Return-Path: <netdev+bounces-24341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B35776FD81
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98B0282590
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23308A95C;
	Fri,  4 Aug 2023 09:38:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B09A94C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:38:25 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E54A30F8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 02:38:23 -0700 (PDT)
Received: from dggpemm500019.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RHLDS606zz1Z1Sb;
	Fri,  4 Aug 2023 17:35:36 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 17:38:21 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 17:38:20 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <alexandru.tachici@analog.com>, <andrew@lunn.ch>,
	<amit.kumar-mahapatra@amd.com>, <yangyingliang@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH net-next] net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address
Date: Fri, 4 Aug 2023 17:35:31 +0800
Message-ID: <20230804093531.1428598-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use eth_broadcast_addr() to assign broadcast address instead
of memset().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/ethernet/adi/adin1110.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index f5c2d7a9abc1..1c009b485188 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -739,7 +739,7 @@ static int adin1110_broadcasts_filter(struct adin1110_port_priv *port_priv,
 	u32 port_rules = 0;
 	u8 mask[ETH_ALEN];
 
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 
 	if (accept_broadcast && port_priv->state == BR_STATE_FORWARDING)
 		port_rules = adin1110_port_rules(port_priv, true, true);
@@ -760,7 +760,7 @@ static int adin1110_set_mac_address(struct net_device *netdev,
 		return -EADDRNOTAVAIL;
 
 	eth_hw_addr_set(netdev, dev_addr);
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 
 	mac_slot = (!port_priv->nr) ?  ADIN_MAC_P1_ADDR_SLOT : ADIN_MAC_P2_ADDR_SLOT;
 	port_rules = adin1110_port_rules(port_priv, true, false);
@@ -1271,7 +1271,7 @@ static int adin1110_port_set_blocking_state(struct adin1110_port_priv *port_priv
 		goto out;
 
 	/* Allow only BPDUs to be passed to the CPU */
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 	port_rules = adin1110_port_rules(port_priv, true, false);
 	ret = adin1110_write_mac_address(port_priv, mac_slot, mac,
 					 mask, port_rules);
@@ -1386,7 +1386,7 @@ static int adin1110_fdb_add(struct adin1110_port_priv *port_priv,
 
 	other_port = priv->ports[!port_priv->nr];
 	port_rules = adin1110_port_rules(port_priv, false, true);
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 
 	return adin1110_write_mac_address(other_port, mac_nr, (u8 *)fdb->addr,
 					  mask, port_rules);
-- 
2.25.1


