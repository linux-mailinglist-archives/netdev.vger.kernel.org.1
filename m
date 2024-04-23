Return-Path: <netdev+bounces-90693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C78AFBE8
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846C71F22E53
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25E41746;
	Tue, 23 Apr 2024 22:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96FF3613D
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911979; cv=none; b=K1c8qWdDpLUEhpZU2tK9N7/z8BOuwfMraMXdXrQ3wzLBM0IiTq/yt800Ya98OmrqRS4rOH09Msr/ftDXNK+Z6JnbgnPp3f0Mxc04SB07x7M11+/mI/EcKVaz+bOYzuPSY5kumM4QF1jU8FCggRwhWkGfpvtPyyuFmmgdoYRlaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911979; c=relaxed/simple;
	bh=Df/KJbI85PaEAfJs6iupjMvvGYoUFGgdCaO2i0AbU1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bzt+bDuwCBu4WSM6CqDaMTMxAnEoEuFAzjZ0D6TNBDG1MwC0pC16Y5tYp1meIy9s0I6R6DF7J4Zcyhdv8emAuq9e19lnJPMouHpkoLdLgl6NcQv7U0v18+/ZUrS7NnjHKl3ePIXwGzz9LFqy5gANnBvsyg5DxDImkaC3jYfjJWw=
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
	osmith@sysmocom.de
Subject: [PATCH net-next 07/12] gtp: move debugging to skbuff build helper function
Date: Wed, 24 Apr 2024 00:39:14 +0200
Message-Id: <20240423223919.3385493-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423223919.3385493-1-pablo@netfilter.org>
References: <20240423223919.3385493-1-pablo@netfilter.org>
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
index 2afcf1887592..7c9e13a9f9eb 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1059,6 +1059,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph, pctx, rt, &fl4, dev);
 	gtp_push_header(skb, pktinfo);
 
+	netdev_dbg(dev, "gtp -> IP src: %pI4 dst: %pI4\n",
+		   &iph->saddr, &iph->daddr);
+
 	return 0;
 err_rt:
 	ip_rt_put(rt);
@@ -1134,6 +1137,9 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, ip6h, pctx, rt, &fl6, dev);
 	gtp_push_header(skb, pktinfo);
 
+	netdev_dbg(dev, "gtp -> IP src: %pI6 dst: %pI6\n",
+		   &ip6h->saddr, &ip6h->daddr);
+
 	return 0;
 err_rt:
 	dst_release(dst);
@@ -1173,8 +1179,6 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	switch (proto) {
 	case ETH_P_IP:
-		netdev_dbg(pktinfo.dev, "gtp -> IP src: %pI4 dst: %pI4\n",
-			   &pktinfo.iph->saddr, &pktinfo.iph->daddr);
 		udp_tunnel_xmit_skb(pktinfo.rt, pktinfo.sk, skb,
 				    pktinfo.fl4.saddr, pktinfo.fl4.daddr,
 				    pktinfo.iph->tos,
@@ -1187,8 +1191,6 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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


