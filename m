Return-Path: <netdev+bounces-91268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A288B1FA9
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708501F23122
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A0364DF;
	Thu, 25 Apr 2024 10:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF32B9D7
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042313; cv=none; b=AnhpmkYNH4FtEfxjsFsCQB9PLSsF4eNQ94a1Pz37Yq+Hbrnpn728o/DZEV1l1uQspFhfakCDpjDw5hh2g9tQx5djlCFW3WmfSN2/fi4012Md05/CzLiEpWNCZSA5+yN0AkaTqT5toR/CXTgjULfOPYGK6Q3VmrkvI+KPlsAnFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042313; c=relaxed/simple;
	bh=iIolmygZgSL381WGxtCx15YkNPbLa06TMc5j9/6j9jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfUmH2Pb4FS/IXruPFWNpmNpzNCKHiME6R4I7tRhyzgFha4SONbcejWWrN1X1YMHj8+YOCMl/iSB2xcVEZNcDWllevLSX+S8RW++c4MgyuD8ESZHgssJLFcXR4tfW7i4rVbQZ4+ta7EQ4N2A3I9r3nBQuhT6fudQGxMCOHYHrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 07/12] gtp: move debugging to skbuff build helper function
Date: Thu, 25 Apr 2024 12:51:33 +0200
Message-Id: <20240425105138.1361098-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move debugging to the routine to build GTP packets in preparation
for supporting IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 52f4aeecb8f8..3d3818646387 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1060,6 +1060,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph, pctx, rt, &fl4, dev);
 	gtp_push_header(skb, pktinfo);
 
+	netdev_dbg(dev, "gtp -> IP src: %pI4 dst: %pI4\n",
+		   &iph->saddr, &iph->daddr);
+
 	return 0;
 err_rt:
 	ip_rt_put(rt);
@@ -1135,6 +1138,9 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, ip6h, pctx, rt, &fl6, dev);
 	gtp_push_header(skb, pktinfo);
 
+	netdev_dbg(dev, "gtp -> IP src: %pI6 dst: %pI6\n",
+		   &ip6h->saddr, &ip6h->daddr);
+
 	return 0;
 err_rt:
 	dst_release(dst);
@@ -1174,8 +1180,6 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (proto) {
 	case ETH_P_IP:
-		netdev_dbg(pktinfo.dev, "gtp -> IP src: %pI4 dst: %pI4\n",
-			   &pktinfo.iph->saddr, &pktinfo.iph->daddr);
 		udp_tunnel_xmit_skb(pktinfo.rt, pktinfo.sk, skb,
 				    pktinfo.fl4.saddr, pktinfo.fl4.daddr,
 				    pktinfo.iph->tos,
@@ -1188,8 +1192,6 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	case ETH_P_IPV6:
 #if IS_ENABLED(CONFIG_IPV6)
-		netdev_dbg(pktinfo.dev, "gtp -> IP src: %pI6 dst: %pI6\n",
-			   &pktinfo.ip6h->saddr, &pktinfo.ip6h->daddr);
 		udp_tunnel6_xmit_skb(&pktinfo.rt6->dst, pktinfo.sk, skb, dev,
 				     &pktinfo.fl6.saddr, &pktinfo.fl6.daddr,
 				     ipv6_get_dsfield(pktinfo.ip6h),
-- 
2.30.2


