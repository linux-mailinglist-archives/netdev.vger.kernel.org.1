Return-Path: <netdev+bounces-25485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EB7743BF
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C342817AD
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEEE1CA06;
	Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7835818035
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155E23372
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:41:22 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKrrT0xyPzNn00;
	Tue,  8 Aug 2023 19:42:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:45:28 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 1/3] octeontx2-af: Remove redundant functions mac2u64() and cfg2mac()
Date: Tue, 8 Aug 2023 19:45:02 +0800
Message-ID: <20230808114504.4036008-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808114504.4036008-1-lizetao1@huawei.com>
References: <20230808114504.4036008-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mac2u64() is used to convert an Ethernet MAC address into a u64 value,
as this is exactly what ether_addr_to_u64() does. Similarly, the cfg2mac()
is also the case. Use ether_addr_to_u64() and u64_to_ether_addr() instead
of these two.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 .../net/ethernet/marvell/octeontx2/af/cgx.c   | 26 +++----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 592037f4e55b..988383e20bb8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -223,24 +223,6 @@ int cgx_get_link_info(void *cgxd, int lmac_id,
 	return 0;
 }
 
-static u64 mac2u64 (u8 *mac_addr)
-{
-	u64 mac = 0;
-	int index;
-
-	for (index = ETH_ALEN - 1; index >= 0; index--)
-		mac |= ((u64)*mac_addr++) << (8 * index);
-	return mac;
-}
-
-static void cfg2mac(u64 cfg, u8 *mac_addr)
-{
-	int i, index = 0;
-
-	for (i = ETH_ALEN - 1; i >= 0; i--, index++)
-		mac_addr[i] = (cfg >> (8 * index)) & 0xFF;
-}
-
 int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr)
 {
 	struct cgx *cgx_dev = cgx_get_pdata(cgx_id);
@@ -255,7 +237,7 @@ int cgx_lmac_addr_set(u8 cgx_id, u8 lmac_id, u8 *mac_addr)
 	/* copy 6bytes from macaddr */
 	/* memcpy(&cfg, mac_addr, 6); */
 
-	cfg = mac2u64 (mac_addr);
+	cfg = ether_addr_to_u64(mac_addr);
 
 	id = get_sequence_id_of_lmac(cgx_dev, lmac_id);
 
@@ -322,7 +304,7 @@ int cgx_lmac_addr_add(u8 cgx_id, u8 lmac_id, u8 *mac_addr)
 
 	index = id * lmac->mac_to_index_bmap.max + idx;
 
-	cfg = mac2u64 (mac_addr);
+	cfg = ether_addr_to_u64(mac_addr);
 	cfg |= CGX_DMAC_CAM_ADDR_ENABLE;
 	cfg |= ((u64)lmac_id << 49);
 	cgx_write(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index * 0x8)), cfg);
@@ -405,7 +387,7 @@ int cgx_lmac_addr_update(u8 cgx_id, u8 lmac_id, u8 *mac_addr, u8 index)
 
 	cfg = cgx_read(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index * 0x8)));
 	cfg &= ~CGX_RX_DMAC_ADR_MASK;
-	cfg |= mac2u64 (mac_addr);
+	cfg |= ether_addr_to_u64(mac_addr);
 
 	cgx_write(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index * 0x8)), cfg);
 	return 0;
@@ -441,7 +423,7 @@ int cgx_lmac_addr_del(u8 cgx_id, u8 lmac_id, u8 index)
 	/* Read MAC address to check whether it is ucast or mcast */
 	cfg = cgx_read(cgx_dev, 0, (CGXX_CMRX_RX_DMAC_CAM0 + (index * 0x8)));
 
-	cfg2mac(cfg, mac);
+	u64_to_ether_addr(cfg, mac);
 	if (is_multicast_ether_addr(mac))
 		lmac->mcast_filters_count--;
 
-- 
2.34.1


