Return-Path: <netdev+bounces-72367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14BB857BE9
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 12:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D01F27356
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592177F12;
	Fri, 16 Feb 2024 11:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173B74E3C
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083725; cv=none; b=noHqCXJZ8A22RkS3YEAEjdmcNNKEq0CvdzpFxf8CxyBd/LBOGpwleJ/EkgUsviiSDp87jYBabtAd6XnnSGW4E42+Y51aMCuF/oEnNLQMPdSZwwKLSdVZSy8luYE2EMNIqhTk4Emy/DLqxV7VaU/MzkVHh06FMRAhNHowVXnFm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083725; c=relaxed/simple;
	bh=+AV13rbsTCpkwgiNtd/KUu3sqBBY9E+B0M1aIJnNknI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcXNsQSd0UBRjHBY0BmWmNkZWyzFMAzDSo22KFbooQCiNLPMmM3m75Lz7x5yMUHJs802vw8+QCVbIFJYVWshFdocBD+GcClMdFiE9cMlHh8Xo6l6S/Vt3CG47TlKYE5Hfn7Ocpe+3Pk+/Qc+aVbOIKYdRzERz1nOMJ4fnXi6c30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1rawbL-00008Z-LZ; Fri, 16 Feb 2024 12:41:55 +0100
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH net] net: skbuff: add overflow debug check to pull/push helpers
Date: Fri, 16 Feb 2024 12:36:57 +0100
Message-ID: <20240216113700.23013-1-fw@strlen.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot managed to trigger following splat:
BUG: KASAN: use-after-free in __skb_flow_dissect+0x4a3b/0x5e50
Read of size 1 at addr ffff888208a4000e by task a.out/2313
[..]
  __skb_flow_dissect+0x4a3b/0x5e50
  __skb_get_hash+0xb4/0x400
  ip_tunnel_xmit+0x77e/0x26f0
  ipip_tunnel_xmit+0x298/0x410
  ..

Analysis shows that the skb has a valid ->head, but bogus ->data
pointer.

skb->data gets its bogus value via the neigh layer, which does:

1556    __skb_pull(skb, skb_network_offset(skb));

... and the skb was already dodgy at this point:

skb_network_offset(skb) returns a negative value due to an
earlier overflow of skb->network_header (u16).  __skb_pull thus
"adjusts" skb->data by a huge offset, pointing outside skb->head
area.

Allow debug builds to splat when we try to pull/push more than
INT_MAX bytes.

After this, the syzkaller reproducer yields a more precise splat
before the flow dissector attempts to read off skb->data memory:

WARNING: CPU: 5 PID: 2313 at include/linux/skbuff.h:2653 neigh_connected_output+0x28e/0x400
  ip_finish_output2+0xb25/0xed0
  iptunnel_xmit+0x4ff/0x870
  ipgre_xmit+0x78e/0xbb0

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 A fix to prevent network_header overflow will follow shortly.

 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2dde34c29203..fd9198fcc3c3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2642,6 +2642,8 @@ static inline void skb_put_u8(struct sk_buff *skb, u8 val)
 void *skb_push(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->data -= len;
 	skb->len  += len;
 	return skb->data;
@@ -2650,6 +2652,8 @@ static inline void *__skb_push(struct sk_buff *skb, unsigned int len)
 void *skb_pull(struct sk_buff *skb, unsigned int len);
 static inline void *__skb_pull(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	skb->len -= len;
 	if (unlikely(skb->len < skb->data_len)) {
 #if defined(CONFIG_DEBUG_NET)
@@ -2674,6 +2678,8 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 static inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
+	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
+
 	if (likely(len <= skb_headlen(skb)))
 		return SKB_NOT_DROPPED_YET;
 
-- 
2.43.0


