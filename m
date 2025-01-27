Return-Path: <netdev+bounces-161059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5FA1D0CE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D883A7A310C
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17715854F;
	Mon, 27 Jan 2025 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="cgtYwLNN"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA77291E
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958086; cv=none; b=tLT58uwvL8VpCbdjhl7ZtcHHag9vZhYqv/ur4PYG01PpSNYvgbOMGxAOp5RD3Xh2IrrmxQGbcNfhCyiAnMUFTxUgUgy/S6yO/Qt7eWaQJ4h8UAfjCBffTliDcQRwSGymwZ5b+r0IZ+wGE31jGpa+xN+hoJUMJ21NJLK8QnlxfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958086; c=relaxed/simple;
	bh=VsaGG5NR94ct6n+k56hN1fyPxcyLKrK9QNuUJBCy+ZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBx2IYf2tcnbnEDx3g/0aPaN/jiXRZix7fjHJJCIqalpNSFHC8fvZHVJp07Y0hDE2A6EO/Dzou/Lp8T8tNHYNna/1DlqeDGB8zNSJNV6FwNQN+6y1hnTpnagjVjXjVJiqC6IThaKM3ZKjEP1lG9kHT1zicm698j1RuD0AEhsiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=cgtYwLNN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3D1F7207B3;
	Mon, 27 Jan 2025 07:08:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPC5Fu0LZyBZ; Mon, 27 Jan 2025 07:08:00 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 768D52074B;
	Mon, 27 Jan 2025 07:08:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 768D52074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737958080;
	bh=4doNUptqiuVBiYhQzBX6nBtkgeRT8MZ+1fdSCAjjB4w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=cgtYwLNN0Ng/f74kHYi3xr0vkZWgZBf2ihI2/WedmBsUx2QCaRJ9pa5EdKLrp1rG6
	 YIGdJy5Q8KRJEIZFyy4qRpRV2dvcuBwytbOQmYoMwWhvywdXlp71wwOH0I0u19S6Np
	 9T5SkgXFMc9g65QjZKVNHGyAyr5TT4TVRGizo2Hs2VlAFaBoeQrUxtL9NTGMZvRvT7
	 LJQLuO/SuJZMVoelxY1MN5pWu23lnEaZA3j4HaRnIQwbeW7wIA8fu71D3Eqx2/jP9F
	 eM2hT0/P6xMCwoVkjJ5eygDMkILH7mNq1F/wEIgxC5BaepT2mqotLqYM1j9a6Rezvo
	 xbClr5kSshfxw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 Jan 2025 07:08:00 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 07:08:00 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D537D3184172; Mon, 27 Jan 2025 07:07:59 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 4/5] xfrm: Fix the usage of skb->sk
Date: Mon, 27 Jan 2025 07:07:56 +0100
Message-ID: <20250127060757.3946314-5-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127060757.3946314-1-steffen.klassert@secunet.com>
References: <20250127060757.3946314-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

xfrm assumed to always have a full socket at skb->sk.
This is not always true, so fix it by converting to a
full socket before it is used.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/esp4.c                | 2 +-
 net/ipv6/esp6.c                | 2 +-
 net/ipv6/xfrm6_output.c        | 4 ++--
 net/xfrm/xfrm_interface_core.c | 2 +-
 net/xfrm/xfrm_output.c         | 7 ++++---
 net/xfrm/xfrm_policy.c         | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index f3281312eb5e..8cf5f6634775 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -279,7 +279,7 @@ static void esp_output_done(void *data, int err)
 		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 			esp_output_tail_tcp(x, skb);
 		else
-			xfrm_output_resume(skb->sk, skb, err);
+			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 	}
 }
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b2400c226a32..fad4d7c9fa50 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -315,7 +315,7 @@ static void esp_output_done(void *data, int err)
 		    x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
 			esp_output_tail_tcp(x, skb);
 		else
-			xfrm_output_resume(skb->sk, skb, err);
+			xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 	}
 }
 
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 5f7b1fdbffe6..b3d5d1f266ee 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -82,14 +82,14 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	toobig = skb->len > mtu && !skb_is_gso(skb);
 
-	if (toobig && xfrm6_local_dontfrag(skb->sk)) {
+	if (toobig && xfrm6_local_dontfrag(sk)) {
 		xfrm6_local_rxpmtu(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (toobig && xfrm6_noneed_fragment(skb)) {
 		skb->ignore_df = 1;
 		goto skip_frag;
-	} else if (!skb->ignore_df && toobig && skb->sk) {
+	} else if (!skb->ignore_df && toobig && sk) {
 		xfrm_local_error(skb, mtu);
 		kfree_skb(skb);
 		return -EMSGSIZE;
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 98f1e2b67c76..c397eb99d867 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -506,7 +506,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	skb_dst_set(skb, dst);
 	skb->dev = tdev;
 
-	err = dst_output(xi->net, skb->sk, skb);
+	err = dst_output(xi->net, skb_to_full_sk(skb), skb);
 	if (net_xmit_eval(err) == 0) {
 		dev_sw_netstats_tx_add(dev, 1, length);
 	} else {
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..1fb4dc0a76e1 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -796,7 +796,7 @@ static int xfrm4_tunnel_check_size(struct sk_buff *skb)
 	     !skb_gso_validate_network_len(skb, ip_skb_dst_mtu(skb->sk, skb)))) {
 		skb->protocol = htons(ETH_P_IP);
 
-		if (skb->sk)
+		if (skb->sk && sk_fullsock(skb->sk))
 			xfrm_local_error(skb, mtu);
 		else
 			icmp_send(skb, ICMP_DEST_UNREACH,
@@ -832,6 +832,7 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 	struct dst_entry *dst = skb_dst(skb);
+	struct sock *sk = skb_to_full_sk(skb);
 
 	if (skb->ignore_df)
 		goto out;
@@ -846,9 +847,9 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 		skb->dev = dst->dev;
 		skb->protocol = htons(ETH_P_IPV6);
 
-		if (xfrm6_local_dontfrag(skb->sk))
+		if (xfrm6_local_dontfrag(sk))
 			ipv6_stub->xfrm6_local_rxpmtu(skb, mtu);
-		else if (skb->sk)
+		else if (sk)
 			xfrm_local_error(skb, mtu);
 		else
 			icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 4408c11c0835..c27da1fd070e 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2959,7 +2959,7 @@ static void xfrm_policy_queue_process(struct timer_list *t)
 		skb_dst_drop(skb);
 		skb_dst_set(skb, dst);
 
-		dst_output(net, skb->sk, skb);
+		dst_output(net, skb_to_full_sk(skb), skb);
 	}
 
 out:
-- 
2.34.1


