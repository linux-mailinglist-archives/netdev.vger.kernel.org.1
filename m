Return-Path: <netdev+bounces-176007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6DA6854F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 07:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0626E7A2C2F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501324EAAA;
	Wed, 19 Mar 2025 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="d7vJPxnQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A120FA90
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367328; cv=none; b=Ua4zQboePLGzl23hu5twStik8Tsz01Hsj/CcHDrRtzN2ordJz7f/b4dMASuvyzTjp0U/3Mg0ech+hTO8QWTTOUuXLGAGnuWZnL973nNVDncrCuqQchnc1Chh9WCTohNmbVSu+Fv18EA241r7bQfKypW1kN6xkGmio7H5jcmPK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367328; c=relaxed/simple;
	bh=K9xSVEIWiV0+Ujss7ZOEGeGTspG7LRS/sXjM7lJxcSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uougCRH8OwDh762oxh4YbGwRqN9/RlG3DrKtoj5RrabHdGXlE94NTlOsnQGMyUbvWj16DYswF1UtfZZCJ0PXQfBt8W0yaI6GX0eHSJF2gdAULAQw2uAXTMC9ANwGn15GwKh9ZPpTh+jAcpuFLw7ir4h6MCPXs8K9wekCKqtw0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=d7vJPxnQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CD65F2074F;
	Wed, 19 Mar 2025 07:55:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXLZT1TGDowx; Wed, 19 Mar 2025 07:55:18 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F159920799;
	Wed, 19 Mar 2025 07:55:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F159920799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742367318;
	bh=XrrHiCyGspXyA8sFeE6fH2IaOPiLw6ufIafJA1eYEOg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=d7vJPxnQ+DecUAmhwz7U2XyLWpkYS/XYHmhomPHtJzouX0uk8mLp9eLppSfm6kdsa
	 G1fVt7ABsre0TsLZxvevzjmaHveiE95+Xz5GjlFiwH64zWkYcC6XxcKGT3JqVXljhH
	 +9wxUyo6G+UI5/zF4KsMhgH5r2VzTByJljcIiImNlyr2tyo2BWq8ReA7ifhX8WH+ij
	 F4b0POVH5jD0PGPVaeU+3rH7e7u5IRcylg50eV2BYobw9Imoz1DR3VoNzKW8DQDLGU
	 jwe3NGeWbOfT5FahbwocIUBHAaMNL5qiRxXqXP3UHZ45dvOvpH5mKX+ZD5KVYRRbf7
	 fzNcpdH0ribaw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Mar 2025 07:55:17 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 07:55:17 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B549F31805E4; Wed, 19 Mar 2025 07:55:16 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 1/2] xfrm: fix tunnel mode TX datapath in packet offload mode
Date: Wed, 19 Mar 2025 07:55:12 +0100
Message-ID: <20250319065513.987135-2-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319065513.987135-1-steffen.klassert@secunet.com>
References: <20250319065513.987135-1-steffen.klassert@secunet.com>
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

From: Alexandre Cassen <acassen@corp.free.fr>

Packets that match the output xfrm policy are delivered to the netstack.
In IPsec packet mode for tunnel mode, the HW is responsible for building
the hard header and outer IP header. In such a situation, the inner
header may refer to a network that is not directly reachable by the host,
resulting in a failed neighbor resolution. The packet is then dropped.
xfrm policy defines the netdevice to use for xmit so we can send packets
directly to it.

Makes direct xmit exclusive to tunnel mode, since some rules may apply
in transport mode.

Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f7abd42c077d..e5b3e343a5ec 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
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
@@ -735,6 +769,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			return -EHOSTUNREACH;
 		}
 
+		/* Exclusive direct xmit for tunnel mode, as
+		 * some filtering or matching rules may apply
+		 * in transport mode.
+		 */
+		if (x->props.mode == XFRM_MODE_TUNNEL)
+			return xfrm_dev_direct_output(sk, x, skb);
+
 		return xfrm_output_resume(sk, skb, 0);
 	}
 
-- 
2.34.1


