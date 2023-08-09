Return-Path: <netdev+bounces-25767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE05077567A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 11:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974E01C21143
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2ED134A9;
	Wed,  9 Aug 2023 09:34:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8E613F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:34:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC5910D4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 02:34:34 -0700 (PDT)
Received: from dggpemm100008.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLPvf4hvsz1hwYn;
	Wed,  9 Aug 2023 17:31:42 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 17:34:32 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 17:34:32 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] net: ethernet: 8390: ne2k-pci: use module_pci_driver() macro
Date: Wed, 9 Aug 2023 17:31:28 +0800
Message-ID: <20230809093128.2825803-1-yangyingliang@huawei.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The driver init/exit() function don't do anything special, it
can use the module_pci_driver() macro to eliminate boilerplate
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/ethernet/8390/ne2k-pci.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/8390/ne2k-pci.c b/drivers/net/ethernet/8390/ne2k-pci.c
index 2c6bd36d2f31..65f56a98c0a0 100644
--- a/drivers/net/ethernet/8390/ne2k-pci.c
+++ b/drivers/net/ethernet/8390/ne2k-pci.c
@@ -731,18 +731,4 @@ static struct pci_driver ne2k_driver = {
 	.id_table	= ne2k_pci_tbl,
 	.driver.pm	= &ne2k_pci_pm_ops,
 };
-
-
-static int __init ne2k_pci_init(void)
-{
-	return pci_register_driver(&ne2k_driver);
-}
-
-
-static void __exit ne2k_pci_cleanup(void)
-{
-	pci_unregister_driver(&ne2k_driver);
-}
-
-module_init(ne2k_pci_init);
-module_exit(ne2k_pci_cleanup);
+module_pci_driver(ne2k_driver);
-- 
2.25.1


