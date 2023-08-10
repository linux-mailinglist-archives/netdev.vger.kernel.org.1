Return-Path: <netdev+bounces-26227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD261777384
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2511C214AC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80D1E52A;
	Thu, 10 Aug 2023 08:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A61E529
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:57:09 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E383B211F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:57:07 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM13s3gfCz1L9g1;
	Thu, 10 Aug 2023 16:55:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:57:05 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <razor@blackwall.org>,
	<jbenc@redhat.com>, <gavinl@nvidia.com>, <wsa+renesas@sang-engineering.com>,
	<vladimir@nikishkin.pw>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 2/2] vxlan: Use helper functions to update stats
Date: Thu, 10 Aug 2023 16:56:42 +0800
Message-ID: <20230810085642.3781460-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810085642.3781460-1-lizetao1@huawei.com>
References: <20230810085642.3781460-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the helper functions dev_sw_netstats_rx_add() and
dev_sw_netstats_tx_add() to update stats, which helps to
provide code readability.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/vxlan/vxlan_core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2bddcdf482a7..e463f59e95c2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2328,14 +2328,11 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 			       struct vxlan_dev *dst_vxlan, __be32 vni,
 			       bool snoop)
 {
-	struct pcpu_sw_netstats *tx_stats, *rx_stats;
 	union vxlan_addr loopback;
 	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
 	struct net_device *dev;
 	int len = skb->len;
 
-	tx_stats = this_cpu_ptr(src_vxlan->dev->tstats);
-	rx_stats = this_cpu_ptr(dst_vxlan->dev->tstats);
 	skb->pkt_type = PACKET_HOST;
 	skb->encapsulation = 0;
 	skb->dev = dst_vxlan->dev;
@@ -2361,17 +2358,11 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
 		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
-	u64_stats_update_begin(&tx_stats->syncp);
-	u64_stats_inc(&tx_stats->tx_packets);
-	u64_stats_add(&tx_stats->tx_bytes, len);
-	u64_stats_update_end(&tx_stats->syncp);
+	dev_sw_netstats_tx_add(src_vxlan->dev, 1, len);
 	vxlan_vnifilter_count(src_vxlan, vni, NULL, VXLAN_VNI_STATS_TX, len);
 
 	if (__netif_rx(skb) == NET_RX_SUCCESS) {
-		u64_stats_update_begin(&rx_stats->syncp);
-		u64_stats_inc(&rx_stats->rx_packets);
-		u64_stats_add(&rx_stats->rx_bytes, len);
-		u64_stats_update_end(&rx_stats->syncp);
+		dev_sw_netstats_rx_add(dst_vxlan->dev, len);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL, VXLAN_VNI_STATS_RX,
 				      len);
 	} else {
-- 
2.34.1


