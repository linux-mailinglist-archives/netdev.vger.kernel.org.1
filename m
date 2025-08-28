Return-Path: <netdev+bounces-217766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E74B39C90
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8088C1C819E0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE363148D9;
	Thu, 28 Aug 2025 12:10:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886C313E05;
	Thu, 28 Aug 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383047; cv=none; b=pSkzyohQS9T4ulLDiRXOt6156Pa3jfLEDP8ok8HBOdxHRYtsJN+av9EhXgXXSBq7dgl8/iocrDskeKTVJ9eLNbGb20lehxdRzXq8xNTGuUTvWPfhsojAwFe9SyH0ARpB9OjPpcySRUTteq+1U/wr2ZcRp6wQ0f2H96dD1LrK+oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383047; c=relaxed/simple;
	bh=rPRcZR9tO9HOFchGlsnjqVxtrg55LeN3CNy0BGYQrkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjz5jAvTEYkqYBMtcuB59HCoS/C5CpHGcAazdSti3FRArzEr91DISMyjd6X/Q6MM3TgtM7A4s8VZAdwHUQatYRwb/+BXz3e5aH0Hf/zxjC1RXfTOBKggEyxDPSXCBTooj2X5hN3oRogfSt34i/jY93Rn3t1d+/Vut1h8oRMeZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCKqq2Fn1z2Cg9D;
	Thu, 28 Aug 2025 20:06:15 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id A8712140279;
	Thu, 28 Aug 2025 20:10:41 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:40 +0800
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
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v02 06/14] hinic3: Nic_io initialization
Date: Thu, 28 Aug 2025 20:10:12 +0800
Message-ID: <a27347d567faf603a478eba7dc5dffe87a7cf73e.1756378721.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756378721.git.zhuyikai1@h-partners.com>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add nic_io initialization to enable NIC service, initialize function table
and negotiate activation of NIC features.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 15 ++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 23 ++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  2 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 52 +++++++++++++++++--
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index b3a35863af68..4ab3f5f3fa1d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -438,6 +438,18 @@ static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
 	free_base_mgmt_channel(hwdev);
 }
 
+static DEFINE_IDA(hinic3_adev_ida);
+
+static int hinic3_adev_idx_alloc(void)
+{
+	return ida_alloc(&hinic3_adev_ida, GFP_KERNEL);
+}
+
+static void hinic3_adev_idx_free(int id)
+{
+	ida_free(&hinic3_adev_ida, id);
+}
+
 int hinic3_init_hwdev(struct pci_dev *pdev)
 {
 	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
@@ -453,6 +465,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 	hwdev->pdev = pci_adapter->pdev;
 	hwdev->dev = &pci_adapter->pdev->dev;
 	hwdev->func_state = 0;
+	hwdev->dev_id = hinic3_adev_idx_alloc();
 	spin_lock_init(&hwdev->channel_lock);
 
 	err = hinic3_init_hwif(hwdev);
@@ -510,6 +523,7 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 
 err_free_hwdev:
 	pci_adapter->hwdev = NULL;
+	hinic3_adev_idx_free(hwdev->dev_id);
 	kfree(hwdev);
 
 	return err;
@@ -525,6 +539,7 @@ void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 	hinic3_free_cfg_mgmt(hwdev);
 	destroy_workqueue(hwdev->workq);
 	hinic3_free_hwif(hwdev);
+	hinic3_adev_idx_free(hwdev->dev_id);
 	kfree(hwdev);
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 5b1a91a18c67..049f9536cb86 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -39,6 +39,12 @@ static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,
 	return 0;
 }
 
+int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev)
+{
+	return hinic3_feature_nego(nic_dev->hwdev, MGMT_MSG_CMD_OP_GET,
+				   &nic_dev->nic_io->feature_cap, 1);
+}
+
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev)
 {
 	return hinic3_feature_nego(nic_dev->hwdev, MGMT_MSG_CMD_OP_SET,
@@ -82,6 +88,23 @@ static int hinic3_set_function_table(struct hinic3_hwdev *hwdev, u32 cfg_bitmap,
 	return 0;
 }
 
+int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct l2nic_func_tbl_cfg func_tbl_cfg = {};
+	u32 cfg_bitmap;
+
+	func_tbl_cfg.mtu = 0x3FFF; /* default, max mtu */
+	func_tbl_cfg.rx_wqe_buf_size = nic_io->rx_buf_len;
+
+	cfg_bitmap = BIT(L2NIC_FUNC_TBL_CFG_INIT) |
+		     BIT(L2NIC_FUNC_TBL_CFG_MTU) |
+		     BIT(L2NIC_FUNC_TBL_CFG_RX_BUF_SIZE);
+
+	return hinic3_set_function_table(nic_dev->hwdev, cfg_bitmap,
+					 &func_tbl_cfg);
+}
+
 int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index bf9ce51dc401..6b6851650a37 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -22,11 +22,13 @@ enum hinic3_nic_event_type {
 	HINIC3_NIC_EVENT_LINK_UP   = 1,
 };
 
+int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
 			 enum hinic3_nic_feature_cap feature_bits);
 void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
 
+int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
 
 int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index 34a1f5bd5ac1..c077bba8f03a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -11,11 +11,57 @@
 
 int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_nic_io *nic_io;
+	int err;
+
+	nic_io = kzalloc(sizeof(*nic_io), GFP_KERNEL);
+	if (!nic_io)
+		return -ENOMEM;
+
+	nic_dev->nic_io = nic_io;
+
+	err = hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_NIC, 1);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set function svc used state\n");
+		goto err_free_nicio;
+	}
+
+	err = hinic3_init_function_table(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init function table\n");
+		goto err_clear_func_svc_used_state;
+	}
+
+	nic_io->rx_buf_len = nic_dev->rx_buf_len;
+
+	err = hinic3_get_nic_feature_from_hw(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to get nic features\n");
+		goto err_clear_func_svc_used_state;
+	}
+
+	nic_io->feature_cap &= HINIC3_NIC_F_ALL_MASK;
+	nic_io->feature_cap &= HINIC3_NIC_DRV_DEFAULT_FEATURE;
+	dev_dbg(hwdev->dev, "nic features: 0x%llx\n\n", nic_io->feature_cap);
+
+	return 0;
+
+err_clear_func_svc_used_state:
+	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_NIC, 0);
+
+err_free_nicio:
+	nic_dev->nic_io = NULL;
+	kfree(nic_io);
+
+	return err;
 }
 
 void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+
+	hinic3_set_func_svc_used_state(nic_dev->hwdev, COMM_FUNC_SVC_T_NIC, 0);
+	nic_dev->nic_io = NULL;
+	kfree(nic_io);
 }
-- 
2.43.0


