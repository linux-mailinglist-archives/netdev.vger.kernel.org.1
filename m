Return-Path: <netdev+bounces-43319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D607D25DA
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA441C208C3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D600134C2;
	Sun, 22 Oct 2023 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68F28F2
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 20:25:53 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BFA7E9
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 13:25:51 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: osmocom-net-gprs@lists.osmocom.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	laforge@gnumonks.org
Subject: [PATCH net 2/2] gtp: fix fragmentation needed check with gso
Date: Sun, 22 Oct 2023 22:25:18 +0200
Message-Id: <20231022202519.659526-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231022202519.659526-1-pablo@netfilter.org>
References: <20231022202519.659526-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call skb_gso_validate_network_len() to check if packet is over PMTU.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 144ec626230d..b22596b18ee8 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -872,8 +872,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (!skb_is_gso(skb) && (iph->frag_off & htons(IP_DF)) &&
-	    mtu < ntohs(iph->tot_len)) {
+	if (iph->frag_off & htons(IP_DF) &&
+	    ((!skb_is_gso(skb) && skb->len > mtu) ||
+	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 			      htonl(mtu));
-- 
2.30.2


