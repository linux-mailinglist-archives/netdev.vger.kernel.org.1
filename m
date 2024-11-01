Return-Path: <netdev+bounces-140958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDBE9B8DD5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038C71C212B8
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56915855E;
	Fri,  1 Nov 2024 09:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E231F15C158;
	Fri,  1 Nov 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730453275; cv=none; b=WbhFz+l1B+iM/Mau9R+R4Et5IPu05xpWsyIE4wS7X/oLhHm45EWaZAR+igZ+G+LsvwZizGjCURXrh3IwcdXxDI8AZsubtfXqRd8kwlhSElCb+7JN1b/xWRHKlPyKvF9PUkW9Pro9Dmc/9Taadv8BsKrDMZfe1vK9NQ5kWZdBEzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730453275; c=relaxed/simple;
	bh=tqSksozhg+SR5AgWX0/sEltZoCf9nCYQ8jIaVYZ/UAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TqF96MrxjQQd5hrI5rg4I9rUG57nNwTJmG2tNDJSu2/dUtzHw3nq7MIJs8Y3SlEXyuxr/pqzSo1408Cn8HA+h8G3oUnV0FNzzXEk2QzcF+i8/DE6w+tmOWXh8zEVrpSTS/jx/N9XXpDHTmyNjLgNhCN2kSjuaDsK0116TYuDoBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XfwTX57xPzyTtX;
	Fri,  1 Nov 2024 17:26:08 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E4BF0140878;
	Fri,  1 Nov 2024 17:27:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 17:27:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: hns3: fix kernel crash when uninstalling driver
Date: Fri, 1 Nov 2024 17:15:07 +0800
Message-ID: <20241101091507.3644584-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Peiyang Wang <wangpeiyang1@huawei.com>

When the driver is uninstalled and the VF is disabled concurrently, a
kernel crash occurs. The reason is that the two actions call function
pci_disable_sriov(). The num_VFs is checked to determine whether to
release the corresponding resources. During the second calling, num_VFs
is not 0 and the resource release function is called. However, the
corresponding resource has been released during the first invoking.
Therefore, the problem occurs:

[15277.839633][T50670] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
...
[15278.131557][T50670] Call trace:
[15278.134686][T50670]  klist_put+0x28/0x12c
[15278.138682][T50670]  klist_del+0x14/0x20
[15278.142592][T50670]  device_del+0xbc/0x3c0
[15278.146676][T50670]  pci_remove_bus_device+0x84/0x120
[15278.151714][T50670]  pci_stop_and_remove_bus_device+0x6c/0x80
[15278.157447][T50670]  pci_iov_remove_virtfn+0xb4/0x12c
[15278.162485][T50670]  sriov_disable+0x50/0x11c
[15278.166829][T50670]  pci_disable_sriov+0x24/0x30
[15278.171433][T50670]  hnae3_unregister_ae_algo_prepare+0x60/0x90 [hnae3]
[15278.178039][T50670]  hclge_exit+0x28/0xd0 [hclge]
[15278.182730][T50670]  __se_sys_delete_module.isra.0+0x164/0x230
[15278.188550][T50670]  __arm64_sys_delete_module+0x1c/0x30
[15278.193848][T50670]  invoke_syscall+0x50/0x11c
[15278.198278][T50670]  el0_svc_common.constprop.0+0x158/0x164
[15278.203837][T50670]  do_el0_svc+0x34/0xcc
[15278.207834][T50670]  el0_svc+0x20/0x30

For details, see the following figure.

     rmmod hclge              disable VFs
----------------------------------------------------
hclge_exit()            sriov_numvfs_store()
  ...                     device_lock()
  pci_disable_sriov()     hns3_pci_sriov_configure()
                            pci_disable_sriov()
                              sriov_disable()
    sriov_disable()             if !num_VFs :
      if !num_VFs :               return;
        return;                 sriov_del_vfs()
      sriov_del_vfs()             ...
        ...                       klist_put()
        klist_put()               ...
        ...                     num_VFs = 0;
      num_VFs = 0;        device_unlock();

In this patch, when driver is removing, we get the device_lock()
to protect num_VFs, just like sriov_numvfs_store().

Fixes: 0dd8a25f355b ("net: hns3: disable sriov before unload hclge layer")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index 67b0bf310daa..9a63fbc69408 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -25,8 +25,11 @@ void hnae3_unregister_ae_algo_prepare(struct hnae3_ae_algo *ae_algo)
 		pci_id = pci_match_id(ae_algo->pdev_id_table, ae_dev->pdev);
 		if (!pci_id)
 			continue;
-		if (IS_ENABLED(CONFIG_PCI_IOV))
+		if (IS_ENABLED(CONFIG_PCI_IOV)) {
+			device_lock(&ae_dev->pdev->dev);
 			pci_disable_sriov(ae_dev->pdev);
+			device_unlock(&ae_dev->pdev->dev);
+		}
 	}
 }
 EXPORT_SYMBOL(hnae3_unregister_ae_algo_prepare);
-- 
2.33.0


