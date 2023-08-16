Return-Path: <netdev+bounces-27863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D277D7CE
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 03:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB411C20D05
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6F7F0;
	Wed, 16 Aug 2023 01:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26DA392
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:41:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E321FDE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 18:41:40 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQW6V3FwGzrSLl;
	Wed, 16 Aug 2023 09:40:18 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 09:41:38 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH net-next] pds_core: remove redundant pci_clear_master()
Date: Wed, 16 Aug 2023 09:38:02 +0800
Message-ID: <20230816013802.2985145-1-liaoyu15@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

pci_disable_device() involves disabling PCI bus-mastering. So remove
redundant pci_clear_master().

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 672757932246..ffe619cff413 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -374,7 +374,6 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 err_out_clear_master:
-	pci_clear_master(pdev);
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


