Return-Path: <netdev+bounces-25482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D07743B8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453841C20EA5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D31C9F0;
	Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947F18037
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B62335C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:41:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKrv74ypLzrSPj;
	Tue,  8 Aug 2023 19:44:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:45:29 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
	<jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 3/3] octeontx2-af: Remove redundant functions rvu_npc_exact_mac2u64()
Date: Tue, 8 Aug 2023 19:45:04 +0800
Message-ID: <20230808114504.4036008-4-lizetao1@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The rvu_npc_exact_mac2u64() is used to convert an Ethernet MAC address
into a u64 value, as this is exactly what ether_addr_to_u64() does.
Use ether_addr_to_u64() to replace the rvu_npc_exact_mac2u64().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 .../marvell/octeontx2/af/rvu_npc_hash.c       | 20 ++-----------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
index 7e20282c12d0..d2661e7fabdb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c
@@ -390,22 +390,6 @@ int rvu_mbox_handler_npc_get_field_hash_info(struct rvu *rvu,
 	return 0;
 }
 
-/**
- *	rvu_npc_exact_mac2u64 - utility function to convert mac address to u64.
- *	@mac_addr: MAC address.
- *	Return: mdata for exact match table.
- */
-static u64 rvu_npc_exact_mac2u64(u8 *mac_addr)
-{
-	u64 mac = 0;
-	int index;
-
-	for (index = ETH_ALEN - 1; index >= 0; index--)
-		mac |= ((u64)*mac_addr++) << (8 * index);
-
-	return mac;
-}
-
 /**
  *	rvu_exact_prepare_mdata - Make mdata for mcam entry
  *	@mac: MAC address
@@ -416,7 +400,7 @@ static u64 rvu_npc_exact_mac2u64(u8 *mac_addr)
  */
 static u64 rvu_exact_prepare_mdata(u8 *mac, u16 chan, u16 ctype, u64 mask)
 {
-	u64 ldata = rvu_npc_exact_mac2u64(mac);
+	u64 ldata = ether_addr_to_u64(mac);
 
 	/* Please note that mask is 48bit which excludes chan and ctype.
 	 * Increase mask bits if we need to include them as well.
@@ -604,7 +588,7 @@ static u64 rvu_exact_prepare_table_entry(struct rvu *rvu, bool enable,
 					 u8 ctype, u16 chan, u8 *mac_addr)
 
 {
-	u64 ldata = rvu_npc_exact_mac2u64(mac_addr);
+	u64 ldata = ether_addr_to_u64(mac_addr);
 
 	/* Enable or disable */
 	u64 mdata = FIELD_PREP(GENMASK_ULL(63, 63), enable ? 1 : 0);
-- 
2.34.1


