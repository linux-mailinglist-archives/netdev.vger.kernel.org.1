Return-Path: <netdev+bounces-221091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF2B4A3A2
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA3A4E7BDA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB42308F03;
	Tue,  9 Sep 2025 07:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1E30749E;
	Tue,  9 Sep 2025 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403234; cv=none; b=T2KchmvQGP0xu2QyVhmMHhpCrKL5myBNf+jaGenGb91B/MNB+2MefolBWcY+fvfvL4afbH7gvkwYWNve19Odt8bpFE1N1NVx1g5evS+SKLXd77PXkAp206YyAjBfwLIjhR0gqOW/7lkNX700C9Zl9jW3yxDSdIaugPqrqu60KEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403234; c=relaxed/simple;
	bh=ayaGakuu4DYw+n1GH+wLESSt2u4fIFjR4mJpSwpbOEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b58zgRcTpd9Wq92Qj0hIDOU94NAooXfTdexxykiR4slR/b1/751wV30KCEkIGqJaGo1mtrREHiTXLkQXo2UD86rJpkjSNwI1xafYBy0zmahYWVGDnR76BtzWGgWpsdXeQMk1vBNh8XXQ4sShWUqwkDx4kw1WqPI3C47rCS76wm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cLb8C2R3mz24j51;
	Tue,  9 Sep 2025 15:30:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 60362140279;
	Tue,  9 Sep 2025 15:33:49 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 15:33:47 +0800
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
Subject: [PATCH net-next v05 01/14] hinic3: HW initialization
Date: Tue, 9 Sep 2025 15:33:26 +0800
Message-ID: <823742a47b0e7fff719d7c1601068585806c0647.1757401320.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757401320.git.zhuyikai1@h-partners.com>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add the hardware resource data structures, functions for HW initialization,
configuration and releasement.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  52 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 243 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  13 +
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   3 +-
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   9 +
 5 files changed, 316 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 6e8788a64925..09e8b0dce7b3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -7,15 +7,61 @@
 #include "hinic3_mbox.h"
 #include "hinic3_mgmt.h"
 
+#define HINIC3_HWDEV_WQ_NAME    "hinic3_hardware"
+#define HINIC3_WQ_MAX_REQ       10
+
+enum hinic3_hwdev_init_state {
+	HINIC3_HWDEV_MBOX_INITED = 2,
+	HINIC3_HWDEV_CMDQ_INITED = 3,
+};
+
 int hinic3_init_hwdev(struct pci_dev *pdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+	struct hinic3_hwdev *hwdev;
+	int err;
+
+	hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
+	if (!hwdev)
+		return -ENOMEM;
+
+	pci_adapter->hwdev = hwdev;
+	hwdev->adapter = pci_adapter;
+	hwdev->pdev = pci_adapter->pdev;
+	hwdev->dev = &pci_adapter->pdev->dev;
+	hwdev->func_state = 0;
+	spin_lock_init(&hwdev->channel_lock);
+
+	err = hinic3_init_hwif(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hwif\n");
+		goto err_free_hwdev;
+	}
+
+	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM,
+				       HINIC3_WQ_MAX_REQ);
+	if (!hwdev->workq) {
+		dev_err(hwdev->dev, "Failed to alloc hardware workq\n");
+		err = -ENOMEM;
+		goto err_free_hwif;
+	}
+
+	return 0;
+
+err_free_hwif:
+	hinic3_free_hwif(hwdev);
+err_free_hwdev:
+	pci_adapter->hwdev = NULL;
+	kfree(hwdev);
+
+	return err;
 }
 
 void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	destroy_workqueue(hwdev->workq);
+	hinic3_free_hwif(hwdev);
+	kfree(hwdev);
 }
 
 void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index d4af376b7f35..90b8e211587f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -10,6 +10,10 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 
+#define HINIC3_HWIF_READY_TIMEOUT          10000
+#define HINIC3_DB_AND_OUTBOUND_EN_TIMEOUT  60000
+#define HINIC3_PCIE_LINK_DOWN              0xFFFFFFFF
+
 /* config BAR4/5 4MB, DB & DWQE both 2MB */
 #define HINIC3_DB_DWQE_SIZE    0x00400000
 
@@ -18,6 +22,41 @@
 #define HINIC3_DWQE_OFFSET     0x00000800
 #define HINIC3_DB_MAX_AREAS    (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
 
+#define HINIC3_MAX_MSIX_ENTRY  2048
+
+#define HINIC3_AF0_FUNC_GLOBAL_IDX_MASK  GENMASK(11, 0)
+#define HINIC3_AF0_P2P_IDX_MASK          GENMASK(16, 12)
+#define HINIC3_AF0_PCI_INTF_IDX_MASK     GENMASK(19, 17)
+#define HINIC3_AF0_FUNC_TYPE_MASK        BIT(28)
+#define HINIC3_AF0_GET(val, member) \
+	FIELD_GET(HINIC3_AF0_##member##_MASK, val)
+
+#define HINIC3_AF1_AEQS_PER_FUNC_MASK     GENMASK(9, 8)
+#define HINIC3_AF1_MGMT_INIT_STATUS_MASK  BIT(30)
+#define HINIC3_AF1_GET(val, member) \
+	FIELD_GET(HINIC3_AF1_##member##_MASK, val)
+
+#define HINIC3_AF2_CEQS_PER_FUNC_MASK      GENMASK(8, 0)
+#define HINIC3_AF2_IRQS_PER_FUNC_MASK      GENMASK(26, 16)
+#define HINIC3_AF2_GET(val, member) \
+	FIELD_GET(HINIC3_AF2_##member##_MASK, val)
+
+#define HINIC3_AF4_DOORBELL_CTRL_MASK  BIT(0)
+#define HINIC3_AF4_GET(val, member) \
+	FIELD_GET(HINIC3_AF4_##member##_MASK, val)
+#define HINIC3_AF4_SET(val, member) \
+	FIELD_PREP(HINIC3_AF4_##member##_MASK, val)
+
+#define HINIC3_AF5_OUTBOUND_CTRL_MASK  BIT(0)
+#define HINIC3_AF5_GET(val, member) \
+	FIELD_GET(HINIC3_AF5_##member##_MASK, val)
+
+#define HINIC3_AF6_PF_STATUS_MASK     GENMASK(15, 0)
+#define HINIC3_AF6_FUNC_MAX_SQ_MASK   GENMASK(31, 23)
+#define HINIC3_AF6_MSIX_FLEX_EN_MASK  BIT(22)
+#define HINIC3_AF6_GET(val, member) \
+	FIELD_GET(HINIC3_AF6_##member##_MASK, val)
+
 #define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
 
 static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
@@ -39,6 +78,116 @@ void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
 	iowrite32be(val, addr);
 }
 
+static enum hinic3_wait_return check_hwif_ready_handler(void *priv_data)
+{
+	struct hinic3_hwdev *hwdev = priv_data;
+	u32 attr1;
+
+	attr1 = hinic3_hwif_read_reg(hwdev->hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+
+	return HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS) ?
+	       HINIC3_WAIT_PROCESS_CPL : HINIC3_WAIT_PROCESS_WAITING;
+}
+
+static int wait_hwif_ready(struct hinic3_hwdev *hwdev)
+{
+	return hinic3_wait_for_timeout(hwdev, check_hwif_ready_handler,
+				       HINIC3_HWIF_READY_TIMEOUT,
+				       USEC_PER_MSEC);
+}
+
+/* Set attr struct from HW attr values. */
+static void set_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
+			  u32 attr2, u32 attr3, u32 attr6)
+{
+	attr->func_global_idx = HINIC3_AF0_GET(attr0, FUNC_GLOBAL_IDX);
+	attr->port_to_port_idx = HINIC3_AF0_GET(attr0, P2P_IDX);
+	attr->pci_intf_idx = HINIC3_AF0_GET(attr0, PCI_INTF_IDX);
+	attr->func_type = HINIC3_AF0_GET(attr0, FUNC_TYPE);
+
+	attr->num_aeqs = BIT(HINIC3_AF1_GET(attr1, AEQS_PER_FUNC));
+	attr->num_ceqs = HINIC3_AF2_GET(attr2, CEQS_PER_FUNC);
+	attr->num_irqs = HINIC3_AF2_GET(attr2, IRQS_PER_FUNC);
+	if (attr->num_irqs > HINIC3_MAX_MSIX_ENTRY)
+		attr->num_irqs = HINIC3_MAX_MSIX_ENTRY;
+
+	attr->num_sq = HINIC3_AF6_GET(attr6, FUNC_MAX_SQ);
+	attr->msix_flex_en = HINIC3_AF6_GET(attr6, MSIX_FLEX_EN);
+}
+
+/* Read attributes from HW and set attribute struct. */
+static int init_hwif_attr(struct hinic3_hwdev *hwdev)
+{
+	u32 attr0, attr1, attr2, attr3, attr6;
+	struct hinic3_hwif *hwif;
+
+	hwif = hwdev->hwif;
+	attr0 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR0_ADDR);
+	if (attr0 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr1 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	if (attr1 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr2 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR2_ADDR);
+	if (attr2 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr3 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR3_ADDR);
+	if (attr3 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	attr6 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+	if (attr6 == HINIC3_PCIE_LINK_DOWN)
+		return -EFAULT;
+
+	set_hwif_attr(&hwif->attr, attr0, attr1, attr2, attr3, attr6);
+
+	return 0;
+}
+
+static enum hinic3_doorbell_ctrl hinic3_get_doorbell_ctrl_status(struct hinic3_hwif *hwif)
+{
+	u32 attr4 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);
+
+	return HINIC3_AF4_GET(attr4, DOORBELL_CTRL);
+}
+
+static enum hinic3_outbound_ctrl hinic3_get_outbound_ctrl_status(struct hinic3_hwif *hwif)
+{
+	u32 attr5 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);
+
+	return HINIC3_AF5_GET(attr5, OUTBOUND_CTRL);
+}
+
+static int db_area_idx_init(struct hinic3_hwif *hwif, u64 db_base_phy,
+			    u8 __iomem *db_base, u64 db_dwqe_len)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 db_max_areas;
+
+	hwif->db_base_phy = db_base_phy;
+	hwif->db_base = db_base;
+	hwif->db_dwqe_len = db_dwqe_len;
+
+	db_max_areas = db_dwqe_len > HINIC3_DB_DWQE_SIZE ?
+		       HINIC3_DB_MAX_AREAS : db_dwqe_len / HINIC3_DB_PAGE_SIZE;
+	db_area->db_bitmap_array = bitmap_zalloc(db_max_areas, GFP_KERNEL);
+	if (!db_area->db_bitmap_array)
+		return -ENOMEM;
+
+	db_area->db_max_areas = db_max_areas;
+	spin_lock_init(&db_area->idx_lock);
+
+	return 0;
+}
+
+static void db_area_idx_free(struct hinic3_db_area *db_area)
+{
+	bitmap_free(db_area->db_bitmap_array);
+}
+
 static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
 {
 	struct hinic3_db_area *db_area = &hwif->db_area;
@@ -125,6 +274,15 @@ void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
+static void disable_all_msix(struct hinic3_hwdev *hwdev)
+{
+	u16 num_irqs = hwdev->hwif->attr.num_irqs;
+	u16 i;
+
+	for (i = 0; i < num_irqs; i++)
+		hinic3_set_msix_state(hwdev, i, HINIC3_MSIX_DISABLE);
+}
+
 void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				       u8 clear_resend_en)
 {
@@ -161,6 +319,91 @@ void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
+static enum hinic3_wait_return check_db_outbound_enable_handler(void *priv_data)
+{
+	enum hinic3_outbound_ctrl outbound_ctrl;
+	struct hinic3_hwif *hwif = priv_data;
+	enum hinic3_doorbell_ctrl db_ctrl;
+
+	db_ctrl = hinic3_get_doorbell_ctrl_status(hwif);
+	outbound_ctrl = hinic3_get_outbound_ctrl_status(hwif);
+	if (outbound_ctrl == ENABLE_OUTBOUND && db_ctrl == ENABLE_DOORBELL)
+		return HINIC3_WAIT_PROCESS_CPL;
+
+	return HINIC3_WAIT_PROCESS_WAITING;
+}
+
+static int wait_until_doorbell_and_outbound_enabled(struct hinic3_hwif *hwif)
+{
+	return hinic3_wait_for_timeout(hwif, check_db_outbound_enable_handler,
+				       HINIC3_DB_AND_OUTBOUND_EN_TIMEOUT,
+				       USEC_PER_MSEC);
+}
+
+int hinic3_init_hwif(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	struct hinic3_hwif *hwif;
+	u32 attr1, attr4, attr5;
+	int err;
+
+	hwif = kzalloc(sizeof(*hwif), GFP_KERNEL);
+	if (!hwif)
+		return -ENOMEM;
+
+	hwdev->hwif = hwif;
+	hwif->cfg_regs_base = (u8 __iomem *)pci_adapter->cfg_reg_base +
+			      HINIC3_VF_CFG_REG_OFFSET;
+
+	err = db_area_idx_init(hwif, pci_adapter->db_base_phy,
+			       pci_adapter->db_base,
+			       pci_adapter->db_dwqe_len);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init db area.\n");
+		goto err_free_hwif;
+	}
+
+	err = wait_hwif_ready(hwdev);
+	if (err) {
+		attr1 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+		dev_err(hwdev->dev, "Chip status is not ready, attr1:0x%x\n",
+			attr1);
+		goto err_free_db_area_idx;
+	}
+
+	err = init_hwif_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Init hwif attr failed\n");
+		goto err_free_db_area_idx;
+	}
+
+	err = wait_until_doorbell_and_outbound_enabled(hwif);
+	if (err) {
+		attr4 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);
+		attr5 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);
+		dev_err(hwdev->dev, "HW doorbell/outbound is disabled, attr4 0x%x attr5 0x%x\n",
+			attr4, attr5);
+		goto err_free_db_area_idx;
+	}
+
+	disable_all_msix(hwdev);
+
+	return 0;
+
+err_free_db_area_idx:
+	db_area_idx_free(&hwif->db_area);
+err_free_hwif:
+	kfree(hwif);
+
+	return err;
+}
+
+void hinic3_free_hwif(struct hinic3_hwdev *hwdev)
+{
+	db_area_idx_free(&hwdev->hwif->db_area);
+	kfree(hwdev->hwif);
+}
+
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->hwif->attr.func_global_idx;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index 29dd86eb458a..48e43bfdbfbe 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -45,6 +45,16 @@ struct hinic3_hwif {
 	struct hinic3_func_attr attr;
 };
 
+enum hinic3_outbound_ctrl {
+	ENABLE_OUTBOUND  = 0x0,
+	DISABLE_OUTBOUND = 0x1,
+};
+
+enum hinic3_doorbell_ctrl {
+	ENABLE_DOORBELL  = 0,
+	DISABLE_DOORBELL = 1,
+};
+
 enum hinic3_msix_state {
 	HINIC3_MSIX_ENABLE,
 	HINIC3_MSIX_DISABLE,
@@ -62,6 +72,9 @@ int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
 			 void __iomem **dwqe_base);
 void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
 
+int hinic3_init_hwif(struct hinic3_hwdev *hwdev);
+void hinic3_free_hwif(struct hinic3_hwdev *hwdev);
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag);
 void hinic3_msix_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 4827326e6a59..9f3d6af71cc8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -8,6 +8,7 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_lld.h"
 #include "hinic3_mgmt.h"
+#include "hinic3_pci_id_tbl.h"
 
 #define HINIC3_VF_PCI_CFG_REG_BAR  0
 #define HINIC3_PCI_INTR_REG_BAR    2
@@ -377,7 +378,7 @@ static void hinic3_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic3_pci_table[] = {
-	/* Completed by later submission due to LoC limit. */
+	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF), 0},
 	{0, 0}
 
 };
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
new file mode 100644
index 000000000000..86c88d0bb4bd
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_PCI_ID_TBL_H_
+#define _HINIC3_PCI_ID_TBL_H_
+
+#define PCI_DEV_ID_HINIC3_VF    0x375F
+
+#endif
-- 
2.43.0


