Return-Path: <netdev+bounces-305645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dSZhN3DmTWpq/wEAu9opvQ
	(envelope-from <netdev+bounces-305645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 07:56:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 541BA722085
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 07:56:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=bp5w6NPH;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305645-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305645-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A3A1300D70E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4ED3AA9DA;
	Wed,  8 Jul 2026 05:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89B27FD43
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 05:55:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490157; cv=none; b=LhIpt+iKNYrixU1racxS/PAewA1QhrSHM4GIXzoQ5vY6HJaPY6PkuH8FzJ35WpC+S+wVQbNQwoOSgB4YcfepkZCk8lGuUADjJ3QywMABzS/Trj4DyEAGYYVef9Q/GHEyn1Vh1uNLANv5c2Xg1+0bg1PnyWYIgLiMmn2oJdGINd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490157; c=relaxed/simple;
	bh=NePtVzLnArKSRcN8Gf6OSj3+5Rep0SzN4OhdZEPaB+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJQsga0/Ap9m/nxwSJRjhSxPU3eDHqqPz49O7elGSY59uWp/EGIrxHhZEqq2tLVZfpQqT/v6qwvwPWpS3n0Mb4FuFDZoCP3LEHFKHZdtFLUi8nr52F8rW3Tdf/8XgbN+14cW8tOsliRUVj+hST9RhG9dOKfBgetxJ5xKFpQua/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bp5w6NPH; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rp
	zoZi//IrMahRPFYPFTT4Lm6Ci1z5s4FtwdfcpBJg4=; b=bp5w6NPHynOhWKsgk8
	lC+FWrjKDhv8uR7ZSOGzHlGSrVXbnMeRl6UDPE1psfuG9fVpgxDKAF8+TJjz2JBJ
	zF5xh0pvhHIgbpe2EYR+ZSR+8xvEvzIB4WvFKuLL9uHsjgPOND5AsYcGwDIyBGqt
	NepqOzIaexlFhJH1BAG3It/QE=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ixsu5k1q96u5GA--.57642S2;
	Wed, 08 Jul 2026 13:54:54 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuniyu@google.com,
	willemdebruijn.kernel@gmail.com
Cc: mhal@rbox.co,
	bjorn@kernel.org,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: skbuff: optimization of net_zcopy_get() call in pskb_carve helpers
Date: Wed,  8 Jul 2026 13:54:54 +0800
Message-ID: <20260708055454.9167-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ixsu5k1q96u5GA--.57642S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur45urW7Cr4UAFWDuFW8Xrb_yoW8Zw1Upr
	4YkryUAFs8Ar43Ar1kZr48Xr15tFsxtasIgF1F9ay3Arn8ZFy0gayrKr4SyFW7KFWxuws7
	XF1Iva4rXr13XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6SoAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BCzgmpN5jBRSgAA3n
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305645-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:willemdebruijn.kernel@gmail.com,m:mhal@rbox.co,m:bjorn@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 541BA722085

From: Yun Lu <luyun@kylinos.cn>

Commit 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
pskb_carve helpers") introduced two calls of net_zcopy_get(skb_zcopy(skb)).
In fact, skb_zcopy() has already been executed once before. When calling
net_zcopy_get(), skb_zcopy() always returns skb_uarg(skb), which results
in adding some unnecessary instructions in skb_zcopy. So, change these
two calls to directly use skb_uarg(skb) instead of skb_zcopy.

In addition, also use net_zcopy_get() instead of refcount_inc() in
pskb_expand_head() for code consistency.

No functional change intended.

Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
Changes in v2:
- Directly use skb_uarg(skb) instead of skb_zcopy.
  Thanks: Willem de Bruijn
- Links to v1: https://lore.kernel.org/all/20260706100229.13812-1-luyun_611@163.com/
---
 net/core/skbuff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..d798fbdc3da7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		if (skb_orphan_frags(skb, gfp_mask))
 			goto nofrags;
 		if (skb_zcopy(skb))
-			refcount_inc(&skb_uarg(skb)->refcnt);
+			net_zcopy_get(skb_uarg(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 
@@ -6842,7 +6842,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			return -ENOMEM;
 		}
 		if (skb_zcopy(skb))
-			net_zcopy_get(skb_zcopy(skb));
+			net_zcopy_get(skb_uarg(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6992,7 +6992,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		return -ENOMEM;
 	}
 	if (skb_zcopy(skb))
-		net_zcopy_get(skb_zcopy(skb));
+		net_zcopy_get(skb_uarg(skb));
 	skb_release_data(skb, SKB_CONSUMED);
 
 	skb->head = data;
-- 
2.43.0


