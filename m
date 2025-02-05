Return-Path: <netdev+bounces-163203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B5A2994B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875361676B1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED51FECBB;
	Wed,  5 Feb 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTXwOWIL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D413D897
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780870; cv=none; b=lJDRzr3wQV6B3QesDHkf/5o3crw7fXOCpkDvNjZHQ5dI/2PJMUf2CAPHdp0Uj7Iby6vjAM4tfexyiJt6Z1ENJkJzngYzvoe6eeOnNEZRinSD7cKfs7dnehg9TM5H+ObJnF5Ji+6JtFY0uskgYKSwqR9+9j61PfLnzGaRX9nWTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780870; c=relaxed/simple;
	bh=6lMf0zoLlB09uUbUW9vG38BMKlYidJYNY10xkDco/CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bD/zhTYubybjiLyvGorWo2TrFs6HVYwMCFzjG0Qqs7DQ0g5yPNh9rW0T9yVufExmnP0atLtv/SE+vIi1xQnU8lD7uNu/PPebdcPgCc62yDId/CHzY/1zDlNjCSq+NG7z4MLDXtSVwItLUCUrcWfGUthYVm6cnk4qUPxSSzJk/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTXwOWIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F17EC4CED1;
	Wed,  5 Feb 2025 18:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738780869;
	bh=6lMf0zoLlB09uUbUW9vG38BMKlYidJYNY10xkDco/CY=;
	h=From:To:Cc:Subject:Date:From;
	b=oTXwOWILyW4M6RRuZGFLofAB/52ES2QD9I1RiuE7fLzMgWdNJc/p2xo7E6CMZ1t4b
	 nJgV0oPSHpzarU1xry9YRiUhTb+e45/Y1VeytFklp2pwj3LGFQURY7cEfoO2lqxKb+
	 1LTlSjerKXhyNCLWN/RxxzinZ1HXJjuzBxp38qcdawDhNYjLEwm1YIsGH2zVBu3qY1
	 3FPKP052Xmx/D1Yz/4C7WCe0pO/aveBwJGSLOwrLJcccY1P2a+9WoGAyR7W6OFXV1D
	 hVYwXKajXH2zWZgF162vRvgEOJcEgGGiKNOiGuvPNPyyV23KgGk4Tp+nucOd/hZLzK
	 9mOemeX59GBBw==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Alexandre Cassen <acassen@corp.free.fr>,
	netdev@vger.kernel.org
Subject: [RFC ipsec-next] xfrm: fix tunnel mode TX datapath in packet offload mode
Date: Wed,  5 Feb 2025 20:41:02 +0200
Message-ID: <af1b9df0b22d7a9f208e093356412f8976cc1bc2.1738780166.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandre Cassen <acassen@corp.free.fr>

Packets that match the output xfrm policy are delivered to the netstack.
In IPsec packet mode for tunnel mode, the HW is responsible for building the
hard header and outer IP header. In such a situation, the inner header may
refer to a network that is not directly reachable by the host, resulting in
a failed neighbor resolution. The packet is then dropped. xfrm policy defines
the netdevice to use for xmit so we can send packets directly to it.

This fix also provides a performance improvement for transport mode, since
there is no need to perform neighbor resolution if the HW is already configured
to do so.

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Steffen,

I'm sending this patch AS IS to get feedback if it is right approach.

Thanks
---
 net/xfrm/xfrm_output.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 34c8e266641c..4ad83b9ea0e9 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -495,7 +495,7 @@ static int xfrm_output_one(struct sk_buff *skb, int err)
 	struct xfrm_state *x = dst->xfrm;
 	struct net *net = xs_net(x);
 
-	if (err <= 0 || x->xso.type == XFRM_DEV_OFFLOAD_PACKET)
+	if (err <= 0)
 		goto resume;
 
 	do {
@@ -612,6 +612,40 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 }
 EXPORT_SYMBOL_GPL(xfrm_output_resume);
 
+static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
+				  struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct net *net = xs_net(x);
+	int err;
+
+	dst = skb_dst_pop(skb);
+	if (!dst) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+		kfree_skb(skb);
+		return -EHOSTUNREACH;
+	}
+	skb_dst_set(skb, dst);
+	nf_reset_ct(skb);
+
+	err = skb_dst(skb)->ops->local_out(net, sk, skb);
+	if (unlikely(err != 1)) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	/* In transport mode, network destination is
+	 * directly reachable, while in tunnel mode,
+	 * inner packet network may not be. In packet
+	 * offload type, HW is responsible for hard
+	 * header packet mangling so directly xmit skb
+	 * to netdevice.
+	 */
+	skb->dev = x->xso.dev;
+	__skb_push(skb, skb->dev->hard_header_len);
+	return dev_queue_xmit(skb);
+}
+
 static int xfrm_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return xfrm_output_resume(sk, skb, 1);
@@ -735,7 +769,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			return -EHOSTUNREACH;
 		}
 
-		return xfrm_output_resume(sk, skb, 0);
+		return xfrm_dev_direct_output(sk, x, skb);
 	}
 
 	secpath_reset(skb);
-- 
2.48.1


