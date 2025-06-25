Return-Path: <netdev+bounces-200929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCD5AE7574
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1208216AC06
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443E51FE47B;
	Wed, 25 Jun 2025 03:41:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE101EB5C2;
	Wed, 25 Jun 2025 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822909; cv=none; b=n0c4M2EH1VFmvm8VgyC7jTBijZKnHVl5L2Q2zP6LRtUwSEdUOUjiBCJoflyFJD3OD12EEdouRkOClQp8y4hZ3D6olMcFAmEmZcjNvtBk0zzy8dn5DrtZ3zXIapOd+K6Y+iTCuVKX+PYwBpxMoKKpWfFQ6gOoLRm1xapMxHnfrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822909; c=relaxed/simple;
	bh=C6JZeS0Qw/YhDk9DwKnqZUrONlcD6XaumwjAX3SKUUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo+CaUiJeRHijsimfYQ1MXzLjlJHsDl43QKADnQUqudde/NjCGFHmbR6DeJ5SnqxRuiU0gSq7kqclrIXUav/SVCmwIG17ZtRyweeQgs+1/aM+3zwyghCZdg3jG1H0GdqNsxP/DSZXCdK71G9vu1xsiLa+cRg1YZMRLrOI3ttfsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bRnhH150zz2QVHG;
	Wed, 25 Jun 2025 11:42:39 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C778140142;
	Wed, 25 Jun 2025 11:41:44 +0800 (CST)
Received: from DESKTOP-F6Q6J7K.china.huawei.com (10.174.175.220) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Jun 2025 11:41:42 +0800
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
	<mpe@ellerman.id.au>, Suman Ghosh <sumang@marvell.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v05 8/8] hinic3: Interrupt request configuration
Date: Wed, 25 Jun 2025 11:41:19 +0800
Message-ID: <b83d2559436105d981e3b478708ae5c1fb7c5429.1750821322.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <cover.1750821322.git.zhuyikai1@h-partners.com>
References: <cover.1750821322.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Configure interrupt request initialization.
It allows driver to receive packets and management information
from HW.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  31 ++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 ++
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 137 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   4 -
 4 files changed, 179 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 434696ce7dc2..7adcdd569c7b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -8,6 +8,37 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    const struct hinic3_interrupt_info *info)
+{
+	struct comm_cmd_cfg_msix_ctrl_reg msix_cfg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = MGMT_MSG_CMD_OP_SET;
+
+	msix_cfg.lli_credit_cnt = info->lli_credit_limit;
+	msix_cfg.lli_timer_cnt = info->lli_timer_cfg;
+	msix_cfg.pending_cnt = info->pending_limit;
+	msix_cfg.coalesce_timer_cnt = info->coalesc_timer_cfg;
+	msix_cfg.resend_timer_cnt = info->resend_timer_cfg;
+
+	mgmt_msg_params_init_default(&msg_params, &msix_cfg, sizeof(msix_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_CFG_MSIX_CTRL_REG, &msg_params);
+	if (err || msix_cfg.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set interrupt config, err: %d, status: 0x%x\n",
+			err, msix_cfg.head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
 {
 	struct comm_cmd_func_reset func_reset = {};
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index c33a1c77da9c..2270987b126f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -8,6 +8,19 @@
 
 struct hinic3_hwdev;
 
+struct hinic3_interrupt_info {
+	u32 lli_set;
+	u32 interrupt_coalesc_set;
+	u16 msix_index;
+	u8  lli_credit_limit;
+	u8  lli_timer_cfg;
+	u8  pending_limit;
+	u8  coalesc_timer_cfg;
+	u8  resend_timer_cfg;
+};
+
+int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
+				    const struct hinic3_interrupt_info *info);
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index 8b92eed25edf..cee28e67f252 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -38,7 +38,7 @@ static int hinic3_poll(struct napi_struct *napi, int budget)
 	return work_done;
 }
 
-void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
+static void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(irq_cfg->netdev);
 
@@ -50,7 +50,7 @@ void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)
 	napi_enable(&irq_cfg->napi);
 }
 
-void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
+static void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
 {
 	napi_disable(&irq_cfg->napi);
 	netif_queue_set_napi(irq_cfg->netdev, irq_cfg->irq_id,
@@ -60,3 +60,136 @@ void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)
 	netif_stop_subqueue(irq_cfg->netdev, irq_cfg->irq_id);
 	netif_napi_del(&irq_cfg->napi);
 }
+
+static irqreturn_t qp_irq(int irq, void *data)
+{
+	struct hinic3_irq_cfg *irq_cfg = data;
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = netdev_priv(irq_cfg->netdev);
+	hinic3_msix_intr_clear_resend_bit(nic_dev->hwdev,
+					  irq_cfg->msix_entry_idx, 1);
+
+	napi_schedule(&irq_cfg->napi);
+
+	return IRQ_HANDLED;
+}
+
+static int hinic3_request_irq(struct hinic3_irq_cfg *irq_cfg, u16 q_id)
+{
+	struct hinic3_interrupt_info info = {};
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+	int err;
+
+	netdev = irq_cfg->netdev;
+	nic_dev = netdev_priv(netdev);
+	qp_add_napi(irq_cfg);
+
+	info.msix_index = irq_cfg->msix_entry_idx;
+	info.interrupt_coalesc_set = 1;
+	info.pending_limit = nic_dev->intr_coalesce[q_id].pending_limit;
+	info.coalesc_timer_cfg =
+		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
+	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+	err = hinic3_set_interrupt_cfg_direct(nic_dev->hwdev, &info);
+	if (err) {
+		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	err = request_irq(irq_cfg->irq_id, qp_irq, 0, irq_cfg->irq_name,
+			  irq_cfg);
+	if (err) {
+		qp_del_napi(irq_cfg);
+		return err;
+	}
+
+	irq_set_affinity_hint(irq_cfg->irq_id, &irq_cfg->affinity_mask);
+
+	return 0;
+}
+
+static void hinic3_release_irq(struct hinic3_irq_cfg *irq_cfg)
+{
+	irq_set_affinity_hint(irq_cfg->irq_id, NULL);
+	synchronize_irq(irq_cfg->irq_id);
+	free_irq(irq_cfg->irq_id, irq_cfg);
+}
+
+int hinic3_qps_irq_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct hinic3_irq_cfg *irq_cfg;
+	struct msix_entry *msix_entry;
+	u32 local_cpu;
+	u16 q_id;
+	int err;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		msix_entry = &nic_dev->qps_msix_entries[q_id];
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+
+		irq_cfg->irq_id = msix_entry->vector;
+		irq_cfg->msix_entry_idx = msix_entry->entry;
+		irq_cfg->netdev = netdev;
+		irq_cfg->txq = &nic_dev->txqs[q_id];
+		irq_cfg->rxq = &nic_dev->rxqs[q_id];
+		nic_dev->rxqs[q_id].irq_cfg = irq_cfg;
+
+		local_cpu = cpumask_local_spread(q_id, dev_to_node(&pdev->dev));
+		cpumask_set_cpu(local_cpu, &irq_cfg->affinity_mask);
+
+		snprintf(irq_cfg->irq_name, sizeof(irq_cfg->irq_name),
+			 "%s_qp%u", netdev->name, q_id);
+
+		err = hinic3_request_irq(irq_cfg, q_id);
+		if (err) {
+			netdev_err(netdev, "Failed to request Rx irq\n");
+			goto err_release_irqs;
+		}
+
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_SET_MSIX_AUTO_MASK);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_ENABLE);
+	}
+
+	return 0;
+
+err_release_irqs:
+	while (q_id > 0) {
+		q_id--;
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+		qp_del_napi(irq_cfg);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+
+	return err;
+}
+
+void hinic3_qps_irq_uninit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_irq_cfg *irq_cfg;
+	u16 q_id;
+
+	for (q_id = 0; q_id < nic_dev->q_params.num_qps; q_id++) {
+		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
+		qp_del_napi(irq_cfg);
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
+				      HINIC3_MSIX_DISABLE);
+		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
+						irq_cfg->msix_entry_idx,
+						HINIC3_CLR_MSIX_AUTO_MASK);
+		hinic3_release_irq(irq_cfg);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9577cc673257..9fad834f9e92 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -85,8 +85,4 @@ void hinic3_set_netdev_ops(struct net_device *netdev);
 int hinic3_qps_irq_init(struct net_device *netdev);
 void hinic3_qps_irq_uninit(struct net_device *netdev);
 
-/* Temporary prototypes. Functions become static in later submission. */
-void qp_add_napi(struct hinic3_irq_cfg *irq_cfg);
-void qp_del_napi(struct hinic3_irq_cfg *irq_cfg);
-
 #endif
-- 
2.43.0


