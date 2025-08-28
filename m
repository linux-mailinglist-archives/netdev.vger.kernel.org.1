Return-Path: <netdev+bounces-217770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D85B39CA6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3557BB49A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355C3176E6;
	Thu, 28 Aug 2025 12:10:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEB314B6D;
	Thu, 28 Aug 2025 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383054; cv=none; b=MIUeue6+72OtT9WZaPsY417XaNH5krMojfCHHy9r1XK+ItHyU8sePWxPn3TQjo3xt0zkZOA7C3MWKZQW4NSqHslFAJu6rueSwpRchSQgYJD50e2Jo2VTg/ctAloegB6tbd8uS0YN3lmojBAJgsftGDI6x540fFz+5cLO4KCurU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383054; c=relaxed/simple;
	bh=viw0OKLHfW/7wBnBr/dQd557Hh7hBoY7UZgEihSzKsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgGnChWz8YH+JuySufm7Vur0UA4NBDXOQQPbX93XHFGVt4iunypxGcta2l247nF8s0LNe9UP/pMAk03luEXX7txVTlwzcWbohqMZ7o99GR0IM0vOcYTrWnzhWMsNXpafzFhOpUZSQBPN7Nl9jeZequ/+NfS8SAo/BYgw4gvuJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cCKqy0h1Bz2CfmX;
	Thu, 28 Aug 2025 20:06:22 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CF961A016C;
	Thu, 28 Aug 2025 20:10:48 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:46 +0800
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
Subject: [PATCH net-next v02 09/14] hinic3: Queue pair context initialization
Date: Thu, 28 Aug 2025 20:10:15 +0800
Message-ID: <479a91678b4edd87a307125c829f0d6e60239ab6.1756378721.git.zhuyikai1@h-partners.com>
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

Initialize queue pair context of hardware interaction.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  88 +++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   3 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  20 +
 .../huawei/hinic3/hinic3_netdev_ops.c         |  42 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  35 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  12 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 579 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   3 +
 8 files changed, 782 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index c28df49e08c0..662187ffa6c6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -337,3 +337,91 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 
 	return ret;
 }
+
+static int get_hw_rx_buf_size_idx(int rx_buf_sz, u16 *buf_sz_idx)
+{
+	/* Supported RX buffer sizes in bytes. Configured by array index. */
+	static const int supported_sizes[16] = {
+		[0] = 32,     [1] = 64,     [2] = 96,     [3] = 128,
+		[4] = 192,    [5] = 256,    [6] = 384,    [7] = 512,
+		[8] = 768,    [9] = 1024,   [10] = 1536,  [11] = 2048,
+		[12] = 3072,  [13] = 4096,  [14] = 8192,  [15] = 16384,
+	};
+	u16 idx;
+
+	/* Scan from biggest to smallest. Choose supported size that is equal or
+	 * smaller. For smaller value HW will under-utilize posted buffers. For
+	 * bigger value HW may overrun posted buffers.
+	 */
+	idx = ARRAY_SIZE(supported_sizes);
+	while (idx > 0) {
+		idx--;
+		if (supported_sizes[idx] <= rx_buf_sz) {
+			*buf_sz_idx = idx;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth,
+			 int rx_buf_sz)
+{
+	struct comm_cmd_set_root_ctxt root_ctxt = {};
+	struct mgmt_msg_params msg_params = {};
+	u16 buf_sz_idx;
+	int err;
+
+	err = get_hw_rx_buf_size_idx(rx_buf_sz, &buf_sz_idx);
+	if (err)
+		return err;
+
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	root_ctxt.set_cmdq_depth = 0;
+	root_ctxt.cmdq_depth = 0;
+
+	root_ctxt.lro_en = 1;
+
+	root_ctxt.rq_depth  = ilog2(rq_depth);
+	root_ctxt.rx_buf_sz = buf_sz_idx;
+	root_ctxt.sq_depth  = ilog2(sq_depth);
+
+	mgmt_msg_params_init_default(&msg_params, &root_ctxt,
+				     sizeof(root_ctxt));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_VAT, &msg_params);
+	if (err || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set root context, err: %d, status: 0x%x\n",
+			err, root_ctxt.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev)
+{
+	struct comm_cmd_set_root_ctxt root_ctxt = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &root_ctxt,
+				     sizeof(root_ctxt));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_VAT, &msg_params);
+	if (err || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set root context, err: %d, status: 0x%x\n",
+			err, root_ctxt.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index 35b93e36e004..304f5691f0c2 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -40,5 +40,8 @@ int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx,
 			    u32 page_size);
 int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth);
 int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev);
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth,
+			 int rx_buf_sz);
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index c4434efdc7f7..b891290a3d6e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -56,6 +56,19 @@ struct l2nic_cmd_update_mac {
 	u8                   new_mac[ETH_ALEN];
 };
 
+struct l2nic_cmd_set_ci_attr {
+	struct mgmt_msg_head msg_head;
+	u16                  func_idx;
+	u8                   dma_attr_off;
+	u8                   pending_limit;
+	u8                   coalescing_time;
+	u8                   intr_en;
+	u16                  intr_idx;
+	u32                  l2nic_sqn;
+	u32                  rsvd;
+	u64                  ci_addr;
+};
+
 struct l2nic_cmd_force_pkt_drop {
 	struct mgmt_msg_head msg_head;
 	u8                   port;
@@ -82,6 +95,13 @@ enum l2nic_cmd {
 	L2NIC_CMD_MAX                 = 256,
 };
 
+/* NIC CMDQ MODE */
+enum l2nic_ucode_cmd {
+	L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX  = 0,
+	L2NIC_UCODE_CMD_CLEAN_QUEUE_CTX   = 1,
+	L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL = 4,
+};
+
 enum hinic3_nic_feature_cap {
 	HINIC3_NIC_F_CSUM           = BIT(0),
 	HINIC3_NIC_F_SCTP_CRC       = BIT(1),
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index f0749a02ff80..054afb2b1460 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -227,6 +227,39 @@ static void hinic3_free_channel_resources(struct net_device *netdev,
 	hinic3_free_qps(nic_dev, qp_params);
 }
 
+static int hinic3_open_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_init_qp_ctxts(nic_dev);
+	if (err) {
+		netdev_err(netdev, "Failed to init qps\n");
+		return err;
+	}
+
+	err = hinic3_qps_irq_init(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to init txrxq irq\n");
+		goto err_free_qp_ctxts;
+	}
+
+	return 0;
+
+err_free_qp_ctxts:
+	hinic3_free_qp_ctxts(nic_dev);
+
+	return err;
+}
+
+static void hinic3_close_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_qps_irq_uninit(netdev);
+	hinic3_free_qp_ctxts(nic_dev);
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -252,8 +285,16 @@ static int hinic3_open(struct net_device *netdev)
 
 	hinic3_init_qps(nic_dev, &qp_params);
 
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_uninit_qps;
+
 	return 0;
 
+err_uninit_qps:
+	hinic3_uninit_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+
 err_destroy_num_qps:
 	hinic3_destroy_num_qps(netdev);
 
@@ -268,6 +309,7 @@ static int hinic3_close(struct net_device *netdev)
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_dyna_qp_params qp_params;
 
+	hinic3_close_channel(netdev);
 	hinic3_uninit_qps(nic_dev, &qp_params);
 	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 049f9536cb86..5b18764781d4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -229,6 +229,41 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,
 			err, mac_info.msg_head.status);
 		return -EIO;
 	}
+
+	return 0;
+}
+
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr)
+{
+	struct l2nic_cmd_set_ci_attr cons_idx_attr = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	cons_idx_attr.func_idx = hinic3_global_func_id(hwdev);
+	cons_idx_attr.dma_attr_off  = attr->dma_attr_off;
+	cons_idx_attr.pending_limit = attr->pending_limit;
+	cons_idx_attr.coalescing_time  = attr->coalescing_time;
+
+	if (attr->intr_en) {
+		cons_idx_attr.intr_en = attr->intr_en;
+		cons_idx_attr.intr_idx = attr->intr_idx;
+	}
+
+	cons_idx_attr.l2nic_sqn = attr->l2nic_sqn;
+	cons_idx_attr.ci_addr = attr->ci_dma_base;
+
+	mgmt_msg_params_init_default(&msg_params, &cons_idx_attr,
+				     sizeof(cons_idx_attr));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_SQ_CI_ATTR, &msg_params);
+	if (err || cons_idx_attr.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set ci attribute table, err: %d, status: 0x%x\n",
+			err, cons_idx_attr.msg_head.status);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 6b6851650a37..dd1615745f02 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -22,6 +22,16 @@ enum hinic3_nic_event_type {
 	HINIC3_NIC_EVENT_LINK_UP   = 1,
 };
 
+struct hinic3_sq_attr {
+	u8  dma_attr_off;
+	u8  pending_limit;
+	u8  coalescing_time;
+	u8  intr_en;
+	u16 intr_idx;
+	u32 l2nic_sqn;
+	u64 ci_dma_base;
+};
+
 int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
@@ -38,6 +48,8 @@ int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
 int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,
 		      u8 *new_mac, u16 vlan_id, u16 func_id);
 
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev,
+			struct hinic3_sq_attr *attr);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index cd44f69ec07e..2e353937db2d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
+#include "hinic3_cmdq.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hw_intf.h"
 #include "hinic3_hwdev.h"
@@ -9,6 +10,11 @@
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_io.h"
 
+#define HINIC3_DEFAULT_TX_CI_PENDING_LIMIT    1
+#define HINIC3_DEFAULT_TX_CI_COALESCING_TIME  1
+#define HINIC3_DEFAULT_DROP_THD_ON            (0xFFFF)
+#define HINIC3_DEFAULT_DROP_THD_OFF           0
+
 #define HINIC3_CI_Q_ADDR_SIZE                (64)
 
 #define HINIC3_CI_TABLE_SIZE(num_qps)  \
@@ -17,6 +23,186 @@
 #define HINIC3_CI_VADDR(base_addr, q_id)  \
 	((u8 *)(base_addr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
 
+#define HINIC3_CI_PADDR(base_paddr, q_id)  \
+	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+#define SQ_WQ_PREFETCH_MAX        1
+#define SQ_WQ_PREFETCH_MIN        1
+#define SQ_WQ_PREFETCH_THRESHOLD  16
+
+#define RQ_WQ_PREFETCH_MAX        4
+#define RQ_WQ_PREFETCH_MIN        1
+#define RQ_WQ_PREFETCH_THRESHOLD  256
+
+/* (2048 - 8) / 64 */
+#define HINIC3_Q_CTXT_MAX         31
+
+enum hinic3_qp_ctxt_type {
+	HINIC3_QP_CTXT_TYPE_SQ = 0,
+	HINIC3_QP_CTXT_TYPE_RQ = 1,
+};
+
+struct hinic3_qp_ctxt_hdr {
+	__le16 num_queues;
+	__le16 queue_type;
+	__le16 start_qid;
+	__le16 rsvd;
+};
+
+struct hinic3_sq_ctxt {
+	__le32 ci_pi;
+	__le32 drop_mode_sp;
+	__le32 wq_pfn_hi_owner;
+	__le32 wq_pfn_lo;
+
+	__le32 rsvd0;
+	__le32 pkt_drop_thd;
+	__le32 global_sq_id;
+	__le32 vlan_ceq_attr;
+
+	__le32 pref_cache;
+	__le32 pref_ci_owner;
+	__le32 pref_wq_pfn_hi_ci;
+	__le32 pref_wq_pfn_lo;
+
+	__le32 rsvd8;
+	__le32 rsvd9;
+	__le32 wq_block_pfn_hi;
+	__le32 wq_block_pfn_lo;
+};
+
+struct hinic3_rq_ctxt {
+	__le32 ci_pi;
+	__le32 ceq_attr;
+	__le32 wq_pfn_hi_type_owner;
+	__le32 wq_pfn_lo;
+
+	__le32 rsvd[3];
+	__le32 cqe_sge_len;
+
+	__le32 pref_cache;
+	__le32 pref_ci_owner;
+	__le32 pref_wq_pfn_hi_ci;
+	__le32 pref_wq_pfn_lo;
+
+	__le32 pi_paddr_hi;
+	__le32 pi_paddr_lo;
+	__le32 wq_block_pfn_hi;
+	__le32 wq_block_pfn_lo;
+};
+
+struct hinic3_sq_ctxt_block {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	struct hinic3_sq_ctxt     sq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_rq_ctxt_block {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	struct hinic3_rq_ctxt     rq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_clean_queue_ctxt {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	__le32                    rsvd;
+};
+
+#define SQ_CTXT_SIZE(num_sqs)  \
+	(sizeof(struct hinic3_qp_ctxt_hdr) +  \
+	(num_sqs) * sizeof(struct hinic3_sq_ctxt))
+
+#define RQ_CTXT_SIZE(num_rqs)  \
+	(sizeof(struct hinic3_qp_ctxt_hdr) +  \
+	(num_rqs) * sizeof(struct hinic3_rq_ctxt))
+
+#define SQ_CTXT_PREF_CI_HI_SHIFT           12
+#define SQ_CTXT_PREF_CI_HI(val)            ((val) >> SQ_CTXT_PREF_CI_HI_SHIFT)
+
+#define SQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
+#define SQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
+#define SQ_CTXT_CI_PI_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_##member##_MASK, val)
+
+#define SQ_CTXT_MODE_SP_FLAG_MASK          BIT(0)
+#define SQ_CTXT_MODE_PKT_DROP_MASK         BIT(1)
+#define SQ_CTXT_MODE_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_MODE_##member##_MASK, val)
+
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK        GENMASK(19, 0)
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK         BIT(23)
+#define SQ_CTXT_WQ_PAGE_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_WQ_PAGE_##member##_MASK, val)
+
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK       GENMASK(15, 0)
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK      GENMASK(31, 16)
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_PKT_DROP_##member##_MASK, val)
+
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK          GENMASK(12, 0)
+#define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_##member##_MASK, val)
+
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK      GENMASK(20, 19)
+#define SQ_CTXT_VLAN_CEQ_EN_MASK           BIT(23)
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_VLAN_##member##_MASK, val)
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK  GENMASK(13, 0)
+#define SQ_CTXT_PREF_CACHE_MAX_MASK        GENMASK(24, 14)
+#define SQ_CTXT_PREF_CACHE_MIN_MASK        GENMASK(31, 25)
+
+#define SQ_CTXT_PREF_CI_HI_MASK            GENMASK(3, 0)
+#define SQ_CTXT_PREF_OWNER_MASK            BIT(4)
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK        GENMASK(19, 0)
+#define SQ_CTXT_PREF_CI_LOW_MASK           GENMASK(31, 20)
+#define SQ_CTXT_PREF_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_PREF_##member##_MASK, val)
+
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK       GENMASK(22, 0)
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_WQ_BLOCK_##member##_MASK, val)
+
+#define RQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
+#define RQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
+#define RQ_CTXT_CI_PI_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_##member##_MASK, val)
+
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK         GENMASK(30, 21)
+#define RQ_CTXT_CEQ_ATTR_EN_MASK           BIT(31)
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_CEQ_ATTR_##member##_MASK, val)
+
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK        GENMASK(19, 0)
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK      GENMASK(29, 28)
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK         BIT(31)
+#define RQ_CTXT_WQ_PAGE_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_WQ_PAGE_##member##_MASK, val)
+
+#define RQ_CTXT_CQE_LEN_MASK               GENMASK(29, 28)
+#define RQ_CTXT_CQE_LEN_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_##member##_MASK, val)
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK  GENMASK(13, 0)
+#define RQ_CTXT_PREF_CACHE_MAX_MASK        GENMASK(24, 14)
+#define RQ_CTXT_PREF_CACHE_MIN_MASK        GENMASK(31, 25)
+
+#define RQ_CTXT_PREF_CI_HI_MASK            GENMASK(3, 0)
+#define RQ_CTXT_PREF_OWNER_MASK            BIT(4)
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK        GENMASK(19, 0)
+#define RQ_CTXT_PREF_CI_LOW_MASK           GENMASK(31, 20)
+#define RQ_CTXT_PREF_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_PREF_##member##_MASK, val)
+
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK       GENMASK(22, 0)
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_WQ_BLOCK_##member##_MASK, val)
+
+#define WQ_PAGE_PFN_SHIFT       12
+#define WQ_BLOCK_PFN_SHIFT      9
+#define WQ_PAGE_PFN(page_addr)  ((page_addr) >> WQ_PAGE_PFN_SHIFT)
+#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)
+
 int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
 {
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
@@ -308,3 +494,396 @@ void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
 	qp_params->rqs = nic_io->rq;
 	qp_params->num_qps = nic_io->num_qps;
 }
+
+static void hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_hdr *qp_ctxt_hdr,
+					  enum hinic3_qp_ctxt_type ctxt_type,
+					  u16 num_queues, u16 q_id)
+{
+	qp_ctxt_hdr->queue_type = cpu_to_le16(ctxt_type);
+	qp_ctxt_hdr->num_queues = cpu_to_le16(num_queues);
+	qp_ctxt_hdr->start_qid = cpu_to_le16(q_id);
+	qp_ctxt_hdr->rsvd = 0;
+}
+
+static void hinic3_sq_prepare_ctxt(struct hinic3_io_queue *sq, u16 sq_id,
+				   struct hinic3_sq_ctxt *sq_ctxt)
+{
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;
+	u32 wq_block_pfn_hi, wq_block_pfn_lo;
+	u32 wq_page_pfn_hi, wq_page_pfn_lo;
+	u16 pi_start, ci_start;
+
+	ci_start = hinic3_get_sq_local_ci(sq);
+	pi_start = hinic3_get_sq_local_pi(sq);
+
+	wq_page_addr = hinic3_wq_get_first_wqe_page_addr(&sq->wq);
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	wq_block_pfn = WQ_BLOCK_PFN(sq->wq.wq_block_paddr);
+	wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+
+	sq_ctxt->ci_pi =
+		cpu_to_le32(SQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+			    SQ_CTXT_CI_PI_SET(pi_start, PI_IDX));
+
+	sq_ctxt->drop_mode_sp =
+		cpu_to_le32(SQ_CTXT_MODE_SET(0, SP_FLAG) |
+			    SQ_CTXT_MODE_SET(0, PKT_DROP));
+
+	sq_ctxt->wq_pfn_hi_owner =
+		cpu_to_le32(SQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+			    SQ_CTXT_WQ_PAGE_SET(1, OWNER));
+
+	sq_ctxt->wq_pfn_lo = cpu_to_le32(wq_page_pfn_lo);
+
+	sq_ctxt->pkt_drop_thd =
+		cpu_to_le32(SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEFAULT_DROP_THD_ON, THD_ON) |
+			    SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEFAULT_DROP_THD_OFF, THD_OFF));
+
+	sq_ctxt->global_sq_id =
+		cpu_to_le32(SQ_CTXT_GLOBAL_QUEUE_ID_SET((u32)sq_id,
+							GLOBAL_SQ_ID));
+
+	/* enable insert c-vlan by default */
+	sq_ctxt->vlan_ceq_attr =
+		cpu_to_le32(SQ_CTXT_VLAN_CEQ_SET(0, CEQ_EN) |
+			    SQ_CTXT_VLAN_CEQ_SET(1, INSERT_MODE));
+
+	sq_ctxt->rsvd0 = 0;
+
+	sq_ctxt->pref_cache =
+		cpu_to_le32(SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_MIN, CACHE_MIN) |
+			    SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_MAX, CACHE_MAX) |
+			    SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD));
+
+	sq_ctxt->pref_ci_owner =
+		cpu_to_le32(SQ_CTXT_PREF_SET(SQ_CTXT_PREF_CI_HI(ci_start), CI_HI) |
+			    SQ_CTXT_PREF_SET(1, OWNER));
+
+	sq_ctxt->pref_wq_pfn_hi_ci =
+		cpu_to_le32(SQ_CTXT_PREF_SET(ci_start, CI_LOW) |
+			    SQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI));
+
+	sq_ctxt->pref_wq_pfn_lo = cpu_to_le32(wq_page_pfn_lo);
+
+	sq_ctxt->wq_block_pfn_hi =
+		cpu_to_le32(SQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI));
+
+	sq_ctxt->wq_block_pfn_lo = cpu_to_le32(wq_block_pfn_lo);
+}
+
+static void hinic3_rq_prepare_ctxt_get_wq_info(struct hinic3_io_queue *rq,
+					       u32 *wq_page_pfn_hi,
+					       u32 *wq_page_pfn_lo,
+					       u32 *wq_block_pfn_hi,
+					       u32 *wq_block_pfn_lo)
+{
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;
+
+	wq_page_addr = hinic3_wq_get_first_wqe_page_addr(&rq->wq);
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	*wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	*wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	wq_block_pfn = WQ_BLOCK_PFN(rq->wq.wq_block_paddr);
+	*wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	*wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+}
+
+static void hinic3_rq_prepare_ctxt(struct hinic3_io_queue *rq,
+				   struct hinic3_rq_ctxt *rq_ctxt)
+{
+	u32 wq_block_pfn_hi, wq_block_pfn_lo;
+	u32 wq_page_pfn_hi, wq_page_pfn_lo;
+	u16 pi_start, ci_start;
+
+	ci_start = (rq->wq.cons_idx & rq->wq.idx_mask) << HINIC3_NORMAL_RQ_WQE;
+	pi_start = (rq->wq.prod_idx & rq->wq.idx_mask) << HINIC3_NORMAL_RQ_WQE;
+
+	hinic3_rq_prepare_ctxt_get_wq_info(rq, &wq_page_pfn_hi, &wq_page_pfn_lo,
+					   &wq_block_pfn_hi, &wq_block_pfn_lo);
+
+	rq_ctxt->ci_pi =
+		cpu_to_le32(RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+			    RQ_CTXT_CI_PI_SET(pi_start, PI_IDX));
+
+	rq_ctxt->ceq_attr =
+		cpu_to_le32(RQ_CTXT_CEQ_ATTR_SET(0, EN) |
+			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR));
+
+	rq_ctxt->wq_pfn_hi_type_owner =
+		cpu_to_le32(RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+			    RQ_CTXT_WQ_PAGE_SET(1, OWNER));
+
+	/* use 16Byte WQE */
+	rq_ctxt->wq_pfn_hi_type_owner |=
+		cpu_to_le32(RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE));
+	rq_ctxt->cqe_sge_len = cpu_to_le32(RQ_CTXT_CQE_LEN_SET(1, CQE_LEN));
+
+	rq_ctxt->wq_pfn_lo = cpu_to_le32(wq_page_pfn_lo);
+
+	rq_ctxt->pref_cache =
+		cpu_to_le32(RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_MIN, CACHE_MIN) |
+			    RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_MAX, CACHE_MAX) |
+			    RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD));
+
+	rq_ctxt->pref_ci_owner =
+		cpu_to_le32(RQ_CTXT_PREF_SET(SQ_CTXT_PREF_CI_HI(ci_start), CI_HI) |
+			    RQ_CTXT_PREF_SET(1, OWNER));
+
+	rq_ctxt->pref_wq_pfn_hi_ci =
+		cpu_to_le32(RQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI) |
+			    RQ_CTXT_PREF_SET(ci_start, CI_LOW));
+
+	rq_ctxt->pref_wq_pfn_lo = cpu_to_le32(wq_page_pfn_lo);
+
+	rq_ctxt->wq_block_pfn_hi =
+		cpu_to_le32(RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI));
+
+	rq_ctxt->wq_block_pfn_lo = cpu_to_le32(wq_block_pfn_lo);
+}
+
+static int init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_sq_ctxt_block *sq_ctxt_block;
+	u16 q_id, curr_id, max_ctxts, i;
+	struct hinic3_sq_ctxt *sq_ctxt;
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_io_queue *sq;
+	__le64 out_param;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_io->num_qps) {
+		sq_ctxt_block = cmd_buf->buf;
+		sq_ctxt = sq_ctxt_block->sq_ctxt;
+
+		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
+			     HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_SQ, max_ctxts,
+					      q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			sq = &nic_io->sq[curr_id];
+			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);
+		}
+
+		hinic3_cmdq_buf_swab32(sq_ctxt_block, sizeof(*sq_ctxt_block));
+
+		cmd_buf->size = cpu_to_le16(SQ_CTXT_SIZE(max_ctxts));
+		err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
+					      L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param);
+		if (err || out_param) {
+			dev_err(hwdev->dev, "Failed to set SQ ctxts, err: %d, out_param: 0x%llx\n",
+				err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_rq_ctxt_block *rq_ctxt_block;
+	u16 q_id, curr_id, max_ctxts, i;
+	struct hinic3_rq_ctxt *rq_ctxt;
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_io_queue *rq;
+	__le64 out_param;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_io->num_qps) {
+		rq_ctxt_block = cmd_buf->buf;
+		rq_ctxt = rq_ctxt_block->rq_ctxt;
+
+		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
+				HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_RQ, max_ctxts,
+					      q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			rq = &nic_io->rq[curr_id];
+			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);
+		}
+
+		hinic3_cmdq_buf_swab32(rq_ctxt_block, sizeof(*rq_ctxt_block));
+
+		cmd_buf->size = cpu_to_le16(RQ_CTXT_SIZE(max_ctxts));
+
+		err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
+					      L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param);
+		if (err || out_param) {
+			dev_err(hwdev->dev, "Failed to set RQ ctxts, err: %d, out_param: 0x%llx\n",
+				err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	int err;
+
+	err = init_sq_ctxts(nic_dev);
+	if (err)
+		return err;
+
+	err = init_rq_ctxts(nic_dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
+				    enum hinic3_qp_ctxt_type ctxt_type)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_clean_queue_ctxt *ctxt_block;
+	struct hinic3_cmd_buf *cmd_buf;
+	__le64 out_param;
+	int err;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	ctxt_block = cmd_buf->buf;
+	ctxt_block->cmdq_hdr.num_queues = cpu_to_le16(nic_io->max_qps);
+	ctxt_block->cmdq_hdr.queue_type = cpu_to_le16(ctxt_type);
+	ctxt_block->cmdq_hdr.start_qid = 0;
+	ctxt_block->cmdq_hdr.rsvd = 0;
+	ctxt_block->rsvd = 0;
+
+	hinic3_cmdq_buf_swab32(ctxt_block, sizeof(*ctxt_block));
+
+	cmd_buf->size = cpu_to_le16(sizeof(*ctxt_block));
+
+	err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
+				      L2NIC_UCODE_CMD_CLEAN_QUEUE_CTX,
+				      cmd_buf, &out_param);
+	if (err || out_param) {
+		dev_err(hwdev->dev, "Failed to clean queue offload ctxts, err: %d,out_param: 0x%llx\n",
+			err, out_param);
+
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int clean_qp_offload_ctxt(struct hinic3_nic_dev *nic_dev)
+{
+	/* clean LRO/TSO context space */
+	return (clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_SQ) ||
+		clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_RQ));
+}
+
+/* init qps ctxt and set sq ci attr and arm all sq */
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_sq_attr sq_attr;
+	u32 rq_depth;
+	u16 q_id;
+	int err;
+
+	err = init_qp_ctxts(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init QP ctxts\n");
+		return err;
+	}
+
+	/* clean LRO/TSO context space */
+	err = clean_qp_offload_ctxt(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to clean qp offload ctxts\n");
+		return err;
+	}
+
+	rq_depth = nic_io->rq[0].wq.q_depth << HINIC3_NORMAL_RQ_WQE;
+
+	err = hinic3_set_root_ctxt(hwdev, rq_depth, nic_io->sq[0].wq.q_depth,
+				   nic_io->rx_buf_len);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set root context\n");
+		return err;
+	}
+
+	for (q_id = 0; q_id < nic_io->num_qps; q_id++) {
+		sq_attr.ci_dma_base =
+			HINIC3_CI_PADDR(nic_io->ci_dma_base, q_id) >> 0x2;
+		sq_attr.pending_limit = HINIC3_DEFAULT_TX_CI_PENDING_LIMIT;
+		sq_attr.coalescing_time = HINIC3_DEFAULT_TX_CI_COALESCING_TIME;
+		sq_attr.intr_en = 1;
+		sq_attr.intr_idx = nic_io->sq[q_id].msix_entry_idx;
+		sq_attr.l2nic_sqn = q_id;
+		sq_attr.dma_attr_off = 0;
+		err = hinic3_set_ci_table(hwdev, &sq_attr);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to set ci table\n");
+			goto err_clean_root_ctxt;
+		}
+	}
+
+	return 0;
+
+err_clean_root_ctxt:
+	hinic3_clean_root_ctxt(hwdev);
+
+	return err;
+}
+
+void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	hinic3_clean_root_ctxt(nic_dev->hwdev);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index c103095c37ef..12eefabcf1db 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -139,4 +139,7 @@ void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
 void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
 		       struct hinic3_dyna_qp_params *qp_params);
 
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+
 #endif
-- 
2.43.0


