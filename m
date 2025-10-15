Return-Path: <netdev+bounces-229505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D1BDCE0F
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29AF94E4A28
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CC316908;
	Wed, 15 Oct 2025 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lXA3EUIi"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4B313E34;
	Wed, 15 Oct 2025 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512569; cv=none; b=bxfmJuXJY5N6WeR1CBtjjtg3143S3r8fRunima+vHk97bgP857uDB7mFrEPIyAj0VSUOX8hXJzXB918ynGjtiilmJlUNP9E+dfZ5nuKlSknz9b73JrPtbNZieKqrkCBzRGn0sYLTWi8TWUk9vbNgk1DXxVZKnzPZmg67Q1VxfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512569; c=relaxed/simple;
	bh=7+z82o4ZoGy9/SIxN3CIoTveS9rfYr3ge24mMOaadK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0EtaKCxW07Uq/NbAm3uIjdhVO12UXEcrgFtWFY4bQOrcOQOtFJzQPoN3i/xkh7Rnb4cH+oCoz+H44w/U/Eyb/ImB1Z9JsOxXJWKWELd0VICg7PHDn6iqi1bzsmQ1O887rY2S2lE/sORSESoF/CwbFVpylrRtoFxOBa2yrXzCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lXA3EUIi; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2q0WB1R3h+GlpCy21+2Psj/5kWb3Kf5HOs25lOajkys=;
	b=lXA3EUIinG/4N0PmQ7vx6JM0F2xs6vjXhnuyDQo8FEtyZFxnYq1RosxsPiyXeq+BIUy2BapVg
	rS8+PSFIDiNcWex52nnq8poHhqrxL3TSdS9knMWwS1OvWEp1zy7A39emjdb/GkszPb3D1rDgN34
	5U7hyTXtCB8MRfRQA3pKVrI=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cmj5k2JKjzcb2r;
	Wed, 15 Oct 2025 15:15:06 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E4EC1402C7;
	Wed, 15 Oct 2025 15:16:04 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:16:02 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v01 7/9] hinic3: Fix code Style(remove empty lines between error handling)
Date: Wed, 15 Oct 2025 15:15:33 +0800
Message-ID: <fae5c2fc3790bb2130737715bf457956a6452c29.1760502478.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1760502478.git.zhuyikai1@h-partners.com>
References: <cover.1760502478.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Fix code style of removing empty lines between the actions on the
error handling path.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c | 3 ---
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c  | 1 -
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c  | 5 -----
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c | 4 ----
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c | 2 --
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c   | 1 -
 6 files changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
index ef539d1b69a3..86720bb119e9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c
@@ -878,14 +878,11 @@ int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev)
 	}
 
 	hinic3_free_db_addr(hwdev, cmdqs->cmdqs_db_base);
-
 err_destroy_cmdq_wq:
 	destroy_cmdq_wq(hwdev, cmdqs);
-
 err_free_cmdqs:
 	dma_pool_destroy(cmdqs->cmd_buf_pool);
 	kfree(cmdqs);
-
 err_out:
 	return err;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
index 01686472985b..55bfbe568fdc 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c
@@ -686,7 +686,6 @@ int hinic3_aeqs_init(struct hinic3_hwdev *hwdev, u16 num_aeqs,
 	}
 
 	destroy_workqueue(aeqs->workq);
-
 err_free_aeqs:
 	kfree(aeqs);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 6ae7c9f13932..67b509b98d4c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -247,7 +247,6 @@ static int hinic3_mapping_bar(struct pci_dev *pdev,
 		iounmap(pci_adapter->mgmt_reg_base);
 err_unmap_intr_reg_base:
 	iounmap(pci_adapter->intr_reg_base);
-
 err_unmap_cfg_reg_base:
 	iounmap(pci_adapter->cfg_reg_base);
 
@@ -302,10 +301,8 @@ static int hinic3_pci_init(struct pci_dev *pdev)
 err_release_regions:
 	pci_clear_master(pdev);
 	pci_release_regions(pdev);
-
 err_disable_device:
 	pci_disable_device(pdev);
-
 err_free_pci_adapter:
 	pci_set_drvdata(pdev, NULL);
 	mutex_destroy(&pci_adapter->pdev_mutex);
@@ -394,7 +391,6 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 	hinic3_func_uninit(pdev);
 err_unmap_bar:
 	hinic3_unmapping_bar(pci_adapter);
-
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe function failed\n");
 
@@ -427,7 +423,6 @@ static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_uninit_pci:
 	hinic3_pci_uninit(pdev);
-
 err_out:
 	dev_err(&pdev->dev, "PCIe device probe failed\n");
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index b9b6cb825357..3ed149440b1f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -154,7 +154,6 @@ static int hinic3_alloc_txrxqs(struct net_device *netdev)
 
 err_free_rxqs:
 	hinic3_free_rxqs(netdev);
-
 err_free_txqs:
 	hinic3_free_txqs(netdev);
 
@@ -557,17 +556,14 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	hinic3_unregister_notifier();
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
-
 err_uninit_sw:
 	hinic3_sw_uninit(netdev);
-
 err_free_nic_io:
 	hinic3_free_nic_io(nic_dev);
 err_free_nic_dev:
 	hinic3_free_nic_dev(netdev);
 err_free_netdev:
 	free_netdev(netdev);
-
 err_unregister_adev_event:
 	hinic3_adev_event_unregister(adev);
 	dev_err(&pdev->dev, "NIC service probe failed\n");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index a4be5b2984cf..721c46d94442 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -452,10 +452,8 @@ int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
 		hinic3_uninit_func_mbox_msg_channel(hwdev);
 err_uninit_mgmt_msg_ch:
 	uninit_mgmt_msg_channel(mbox);
-
 err_destroy_workqueue:
 	destroy_workqueue(mbox->workq);
-
 err_free_mbox:
 	kfree(mbox);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 92c43c05e3f2..59045b231ebe 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -582,7 +582,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 
 err_drop_pkt:
 	dev_kfree_skb_any(skb);
-
 err_out:
 	return NETDEV_TX_OK;
 }
-- 
2.43.0


