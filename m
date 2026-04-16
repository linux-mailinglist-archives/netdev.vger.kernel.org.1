Return-Path: <netdev+bounces-278913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBa9BM5b4GmsfQAAu9opvQ
	(envelope-from <netdev+bounces-278913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:47:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A540A0CF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5239930EDC02
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330830C62D;
	Thu, 16 Apr 2026 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="On3ctYww"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5A30BB8D
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311211; cv=none; b=kZR6rokRDK+XxJNX/O9JLTsJ2fP849Z+qQEAp4QoG7iB+nhlf8s3goRMPFqFBqKiG9Mj0PBmwbCFvlrkQ3WgmIoZNoU91JWccW54wb6nihEfA9DO8KsU6fJnwKc9ymCv5cQHDRp40UbAW9kegdVlA6bU792jjtuqTJPvVDwo7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311211; c=relaxed/simple;
	bh=w1aL7WYU6lAVaJQo8x8bYIFkjKllYYPVcpYi5VXenHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VytdKIX7cugQdFcSFp3c+NR5YYoUdR30UZ3VUAo90/rhmpw16BwI4zjhzszr/YFxdZkTYR8jz93zXQ5puzK0ayVmaqndEd34/JtlqBcDC8pR2V7FtJaOmsIYpAnEQ0dLa8mcmARbYS5av7okZSiH7keEejfYFnI4lLwlmwNx7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=On3ctYww; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776311206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZocjYN9l8oVb8KieLprgFd0j6oVTKXIFe8M1eMGD6+E=;
	b=On3ctYwwtz8QD6QKDpRHGQRM4M3y0jAP2EXJzUTKHkd1S1oHPp9R75+MZCAPIOTmcOLZOp
	NFQrjZgWcIWViajYOHRUftraxbVIU7iE/0Yq/A+gLkYhVW4/zu6X3nY3b/dFW5Eizpo8Dp
	Qq5bpVNIjqvjklCxIEFAK5gffQMlhQE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Pravin B Shelar <pshelar@nicira.com>,
	Tom Herbert <tom@herbertland.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1 2/2] net: add DEBUG_NET_WARN_ON_ONCE for negative transport offset
Date: Thu, 16 Apr 2026 11:46:07 +0800
Message-ID: <20260416034610.8873-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260416034610.8873-1-jiayuan.chen@linux.dev>
References: <20260416034610.8873-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278913-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: D87A540A0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skb_transport_offset() can silently return a negative
value when the transport_header becomes stale after tunnel
decapsulation. A negative offset is never valid — it means
transport_header points before skb->data, which will cause unsigned
wraparound in any caller that assigns the result to an unsigned
variable.

Add a DEBUG_NET_WARN_ON_ONCE(off < 0) check so that such cases are
caught early in CONFIG_DEBUG_NET=y builds (e.g., syzkaller, kernel test
bots) with a full stack trace pointing to the caller, rather than
silently propagating a bogus offset until something crashes downstream.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skbuff.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..0b1aeacc25f7 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3234,7 +3234,10 @@ static inline unsigned char *skb_checksum_start(const struct sk_buff *skb)
 
 static inline int skb_transport_offset(const struct sk_buff *skb)
 {
-	return skb_transport_header(skb) - skb->data;
+	int off = skb_transport_header(skb) - skb->data;
+
+	DEBUG_NET_WARN_ON_ONCE(off < 0);
+	return off;
 }
 
 static inline u32 skb_network_header_len(const struct sk_buff *skb)
-- 
2.43.0


