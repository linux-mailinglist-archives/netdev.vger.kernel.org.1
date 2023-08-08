Return-Path: <netdev+bounces-25478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86A774392
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361E01C20E99
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3010171DB;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F79171DD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8B8A43
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:36:25 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKrjF1yB7zNmWv;
	Tue,  8 Aug 2023 19:35:45 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 19:39:13 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <jdmason@kudzu.us>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <lizetao1@huawei.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] ethernet: s2io: Use ether_addr_to_u64() to convert ethernet address
Date: Tue, 8 Aug 2023 19:38:49 +0800
Message-ID: <20230808113849.4033657-1-lizetao1@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/net/ethernet/neterion/s2io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 700c05fb05b9..61d8bfd12d5f 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -5091,13 +5091,10 @@ static void do_s2io_restore_unicast_mc(struct s2io_nic *sp)
 static int do_s2io_add_mc(struct s2io_nic *sp, u8 *addr)
 {
 	int i;
-	u64 mac_addr = 0;
+	u64 mac_addr;
 	struct config_param *config = &sp->config;
 
-	for (i = 0; i < ETH_ALEN; i++) {
-		mac_addr <<= 8;
-		mac_addr |= addr[i];
-	}
+	mac_addr = ether_addr_to_u64(addr);
 	if ((0ULL == mac_addr) || (mac_addr == S2IO_DISABLE_MAC_ENTRY))
 		return SUCCESS;
 
@@ -5220,7 +5217,7 @@ static int s2io_set_mac_addr(struct net_device *dev, void *p)
 static int do_s2io_prog_unicast(struct net_device *dev, const u8 *addr)
 {
 	struct s2io_nic *sp = netdev_priv(dev);
-	register u64 mac_addr = 0, perm_addr = 0;
+	register u64 mac_addr, perm_addr;
 	int i;
 	u64 tmp64;
 	struct config_param *config = &sp->config;
@@ -5230,12 +5227,8 @@ static int do_s2io_prog_unicast(struct net_device *dev, const u8 *addr)
 	 * change on the device address registered with the OS. It will be
 	 * at offset 0.
 	 */
-	for (i = 0; i < ETH_ALEN; i++) {
-		mac_addr <<= 8;
-		mac_addr |= addr[i];
-		perm_addr <<= 8;
-		perm_addr |= sp->def_mac_addr[0].mac_addr[i];
-	}
+	mac_addr = ether_addr_to_u64(addr);
+	perm_addr = ether_addr_to_u64(sp->def_mac_addr[0].mac_addr);
 
 	/* check if the dev_addr is different than perm_addr */
 	if (mac_addr == perm_addr)
-- 
2.34.1


