Return-Path: <netdev+bounces-217765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00811B39C87
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7453A9A11
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18A313E25;
	Thu, 28 Aug 2025 12:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B23128D0;
	Thu, 28 Aug 2025 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383043; cv=none; b=mVTMZm89O8jrc/3zTz2h8+c7DlebVL8wSsLT1GiaBZtyDGu8g29jfpDRI0udHDEvObFbrgEWjIIHv1XANsQSsCPbAOEiJHsVVCc2tResAoWvjoVAE8hFRkdyYGPCQ+LRz4MYUF3uPBSNYDnO+DHX7v/wospFqrnrnaA6XhK0uzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383043; c=relaxed/simple;
	bh=epTGv0HZnO/LH/qLu7JBXirm+5oApyJw93xZ5QtnuZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfyse7nrwI9O9SCtSFlbhk5UO/DYLDQseUB+L9bEWAzB0PJVsB4smBw+yKgx14dCr3gQfSyA0wqZkCdgV+V1ucLTRgqylmA3PvZ0BJhtYQVJt80XStdjUVeY5R/UNnHSYymOkFJaCZB5iFq6Hkbnuq+1U+Y/F5xY3Nv7Mgqe96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCKql03M7z2CgHP;
	Thu, 28 Aug 2025 20:06:11 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FC90140109;
	Thu, 28 Aug 2025 20:10:37 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:35 +0800
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
Subject: [PATCH net-next v02 04/14] hinic3: HW capability initialization
Date: Thu, 28 Aug 2025 20:10:10 +0800
Message-ID: <d24011ec50f59ccb62387a5281ce0447e92d5d11.1756378721.git.zhuyikai1@h-partners.com>
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

Use mailbox to get device capability for initializing driver capability.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 66 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  1 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 42 ++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  6 ++
 4 files changed, 115 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index e7ef450c4971..62ab4d879cf7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -8,6 +8,67 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+#define HINIC3_CFG_MAX_QP  256
+
+static void hinic3_parse_pub_res_cap(struct hinic3_hwdev *hwdev,
+				     struct hinic3_dev_cap *cap,
+				     const struct cfg_cmd_dev_cap *dev_cap,
+				     enum hinic3_func_type type)
+{
+	cap->port_id = dev_cap->port_id;
+	cap->supp_svcs_bitmap = dev_cap->svc_cap_en;
+}
+
+static void hinic3_parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
+				       struct hinic3_dev_cap *cap,
+				       const struct cfg_cmd_dev_cap *dev_cap,
+				       enum hinic3_func_type type)
+{
+	struct hinic3_nic_service_cap *nic_svc_cap = &cap->nic_svc_cap;
+
+	nic_svc_cap->max_sqs = min(dev_cap->nic_max_sq_id + 1,
+				   HINIC3_CFG_MAX_QP);
+}
+
+static void hinic3_parse_dev_cap(struct hinic3_hwdev *hwdev,
+				 const struct cfg_cmd_dev_cap *dev_cap,
+				 enum hinic3_func_type type)
+{
+	struct hinic3_dev_cap *cap = &hwdev->cfg_mgmt->cap;
+
+	/* Public resource */
+	hinic3_parse_pub_res_cap(hwdev, cap, dev_cap, type);
+
+	/* L2 NIC resource */
+	if (hinic3_support_nic(hwdev))
+		hinic3_parse_l2nic_res_cap(hwdev, cap, dev_cap, type);
+}
+
+static int get_cap_from_fw(struct hinic3_hwdev *hwdev,
+			   enum hinic3_func_type type)
+{
+	struct mgmt_msg_params msg_params = {};
+	struct cfg_cmd_dev_cap dev_cap = {};
+	int err;
+
+	dev_cap.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &dev_cap, sizeof(dev_cap));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_CFGM,
+				       CFG_CMD_GET_DEV_CAP, &msg_params);
+	if (err || dev_cap.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get capability from FW, err: %d, status: 0x%x\n",
+			err, dev_cap.head.status);
+		return -EIO;
+	}
+
+	hinic3_parse_dev_cap(hwdev, &dev_cap, type);
+
+	return 0;
+}
+
 static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
@@ -180,6 +241,11 @@ void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
 	mutex_unlock(&irq_info->irq_mutex);
 }
 
+int hinic3_init_capability(struct hinic3_hwdev *hwdev)
+{
+	return get_cap_from_fw(hwdev, HINIC3_FUNC_TYPE_VF);
+}
+
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->cfg_mgmt->cap.supp_svcs_bitmap &
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
index 5978cbd56fb2..58806199bf54 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -49,6 +49,7 @@ int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct msix_entry *alloc_arr, u16 *act_num);
 void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
 
+int hinic3_init_capability(struct hinic3_hwdev *hwdev);
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
 u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
 u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index b5695dda8fe5..87b43a123edb 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -51,6 +51,48 @@ static inline void mgmt_msg_params_init_default(struct mgmt_msg_params *msg_para
 	msg_params->timeout_ms = 0;
 }
 
+enum cfg_cmd {
+	CFG_CMD_GET_DEV_CAP = 0,
+};
+
+/* Device capabilities, defined by hw */
+struct cfg_cmd_dev_cap {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  rsvd1;
+
+	/* Public resources */
+	u8                   host_id;
+	u8                   ep_id;
+	u8                   er_id;
+	u8                   port_id;
+
+	u16                  host_total_func;
+	u8                   host_pf_num;
+	u8                   pf_id_start;
+	u16                  host_vf_num;
+	u16                  vf_id_start;
+	u8                   host_oq_id_mask_val;
+	u8                   timer_en;
+	u8                   host_valid_bitmap;
+	u8                   rsvd_host;
+
+	u16                  svc_cap_en;
+	u16                  max_vf;
+	u8                   flexq_en;
+	u8                   valid_cos_bitmap;
+	u8                   port_cos_valid_bitmap;
+	u8                   rsvd2[45];
+
+	/* l2nic */
+	u16                  nic_max_sq_id;
+	u16                  nic_max_rq_id;
+	u16                  nic_default_num_queues;
+
+	u8                   rsvd3[250];
+};
+
 /* COMM Commands between Driver to fw */
 enum comm_cmd {
 	/* Commands for clearing FLR and resources */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index cd4425b265bf..decb55c35228 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -481,6 +481,12 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		goto err_free_cfg_mgmt;
 	}
 
+	err = hinic3_init_capability(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init capability\n");
+		goto err_uninit_comm_ch;
+	}
+
 	err = hinic3_set_comm_features(hwdev, hwdev->features,
 				       COMM_MAX_FEATURE_QWORD);
 	if (err) {
-- 
2.43.0


