Return-Path: <netdev+bounces-93889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373628BD84C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FA328415E
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF915E20C;
	Mon,  6 May 2024 23:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD96915E1E6
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039592; cv=none; b=EFlGHUJ7T3o3BJUTJWlinYR3CAC6safD2lTO6HOkDGIhF88qhdPhg5AQt0HbDG2rfVMJcZumS5L444ezTjswiEjP3nWdzvJCBX29LDsLolWMeL4tEPes1lEuTwZeXi01TqZo6uj6H/2+OiRW3wMsTdLH+kYwsQncLLSKrvw6GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039592; c=relaxed/simple;
	bh=Ap25gxE9RwCV0WKUypuWG75KEW20dtk1igdyBpvCqlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEKiFndNe0UASwS/QjXwz3LMR/Ijbt/O+CNUp0MI7V2zdIsobNA9y/JXTegpjhLhgY7MByJlhtNnXwCbUDzFRXHtjv8Z8Gs0lZD/eN2dtkR/txiRZnSyq20d6pAAgC4m9RiOMX4O490HgUPr6eUmAnxF3wiHX19dmjRisn+aLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	horms@kernel.org
Subject: [PATCH net-next,v3 07/12] gtp: move debugging to skbuff build helper function
Date: Tue,  7 May 2024 01:52:46 +0200
Message-Id: <20240506235251.3968262-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506235251.3968262-1-pablo@netfilter.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
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
index 939699d6cf6f..d5a17195098f 100644
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


