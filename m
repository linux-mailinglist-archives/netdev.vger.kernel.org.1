Return-Path: <netdev+bounces-25488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBB67743C5
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC7F1C20E71
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B011CA11;
	Tue,  8 Aug 2023 18:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C84171D8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285B893E
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:01:21 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKrlZ5MsvzNmyj;
	Tue,  8 Aug 2023 19:37:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:41:14 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <geoff@infradead.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <christophe.leroy@csgroup.eu>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH -next] net/ps3_gelic_net: Use ether_addr_to_u64() to convert ethernet address
Date: Tue, 8 Aug 2023 19:40:50 +0800
Message-ID: <20230808114050.4034547-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use ether_addr_to_u64() to convert an Ethernet address into a u64 value,
instead of directly calculating, as this is exactly what
this function does.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 9d535ae59626..77a02819e412 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -596,7 +596,6 @@ void gelic_net_set_multi(struct net_device *netdev)
 	struct gelic_card *card = netdev_card(netdev);
 	struct netdev_hw_addr *ha;
 	unsigned int i;
-	uint8_t *p;
 	u64 addr;
 	int status;
 
@@ -629,12 +628,7 @@ void gelic_net_set_multi(struct net_device *netdev)
 
 	/* set multicast addresses */
 	netdev_for_each_mc_addr(ha, netdev) {
-		addr = 0;
-		p = ha->addr;
-		for (i = 0; i < ETH_ALEN; i++) {
-			addr <<= 8;
-			addr |= *p++;
-		}
+		addr = ether_addr_to_u64(ha->addr);
 		status = lv1_net_add_multicast_address(bus_id(card),
 						       dev_id(card),
 						       addr, 0);
-- 
2.34.1


