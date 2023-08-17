Return-Path: <netdev+bounces-28301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E277EF44
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A053281C8E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13B396;
	Thu, 17 Aug 2023 03:00:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0636A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:00:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261E71FE9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:00:28 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RR8mQ25W2zNn1p;
	Thu, 17 Aug 2023 10:56:54 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 11:00:20 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <leon@kernel.org>,
	<shannon.nelson@amd.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH v2 net-next] pds_core: remove redundant pci_clear_master()
Date: Thu, 17 Aug 2023 10:57:09 +0800
Message-ID: <20230817025709.2023553-1-liaoyu15@huawei.com>
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

do_pci_disable_device() disable PCI bus-mastering as following:
static void do_pci_disable_device(struct pci_dev *dev)
{
		u16 pci_command;

		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
		if (pci_command & PCI_COMMAND_MASTER) {
				pci_command &= ~PCI_COMMAND_MASTER;
				pci_write_config_word(dev, PCI_COMMAND, pci_command);
		}

		pcibios_disable_device(dev);
}
And pci_disable_device() sets dev->is_busmaster to 0.

pci_enable_device() is called only once before calling to
pci_disable_device() and such pci_clear_master() is not needed. So remove
redundant pci_clear_master().

Also rename goto label 'err_out_clear_master' to 'err_out_disable_device'.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
v1 -> v2:
- add explanation why pci_disable_device() disables PCI bus-mastering
- rename goto label 'err_out_clear_master' to 'err_out_disable_device' 
---
 drivers/net/ethernet/amd/pds_core/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 672757932246..3a45bf474a19 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -367,14 +367,13 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = pdsc_init_vf(pdsc);
 	if (err) {
 		dev_err(dev, "Cannot init device: %pe\n", ERR_PTR(err));
-		goto err_out_clear_master;
+		goto err_out_disable_device;
 	}
 
 	clear_bit(PDSC_S_INITING_DRIVER, &pdsc->state);
 	return 0;
 
-err_out_clear_master:
-	pci_clear_master(pdev);
+err_out_disable_device:
 	pci_disable_device(pdev);
 err_out_free_ida:
 	ida_free(&pdsc_ida, pdsc->uid);
@@ -439,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
 		pci_release_regions(pdev);
 	}
 
-	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 
 	ida_free(&pdsc_ida, pdsc->uid);
-- 
2.25.1


