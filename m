Return-Path: <netdev+bounces-247526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6423CFB8CB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B86D30D2C27
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E112192F9;
	Wed,  7 Jan 2026 01:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GvRhsfje"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AD235358;
	Wed,  7 Jan 2026 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747887; cv=none; b=ulHUvRq8DJm8xTqzc3wKbYdyhi934xDxaMSfjjGAI2WdwjKoGSU0+uq3Q/UJ1omXSIb45xhneoA14nshdldVsmxji0fsQ+XMEwioLsta7Z3y8Zm1N9L+p/uDQc1M92sxp9VvFjo6pNHCq+2pxhFeLBph5awl8wLJ4nAq9iJV09c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747887; c=relaxed/simple;
	bh=IKHfxFtZkc88RUA1k3TTPBHAcK/MzP39RCzVRag++D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5jhGoDvIYyLdC5CZFUeRBHnPqSyViddVDgT5shuL3KsWj1ax0NrQiGySI3cApRFHowjQcu9R2TgN/QOQU4TNZuS075oLp2zWB+ItuDM/0y47hHarWeAX3dUC5N3qHijy6J18aJnFIgl4tmaTIppg722umLXQgxF0zOTvadqzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GvRhsfje; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0ItH/uMC8kofzYzGBysHjOnYWNd4L5eIQwveUw6UocY=;
	b=GvRhsfje9WOIFGIFp8sgMPCm5ynJX58Jgm1CLld6Zu96+7bQ0fxhSgxDFV+dbHFvYAVoXO9SP
	rTb9IjA+kuKTpr6UnDSSkBh+HperDvOH+7fHzRll5XERdIsO/N8GUMpMLSbeP0OtSYm+V564FdM
	Gz3p151YVyMAZ52tfbJrM8A=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dm8qX0rtPzcbPg;
	Wed,  7 Jan 2026 09:01:12 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 491EE40538;
	Wed,  7 Jan 2026 09:04:43 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 09:04:42 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v09 7/9] hinic3: Add adaptive IRQ coalescing with DIM
Date: Wed, 7 Jan 2026 09:04:22 +0800
Message-ID: <5a808a2ca8156ccc9db8fc4ef38ed24ce1e8371a.1767707500.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767707500.git.zhuyikai1@h-partners.com>
References: <cover.1767707500.git.zhuyikai1@h-partners.com>
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

DIM offers a way to adjust the coalescing settings based
on load. As hinic3 rx and tx share interrupts, we only need
to base dim on rx stats.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 54 +++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  2 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  2 +-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 96 ++++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 14 ++-
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  5 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  6 ++
 7 files changed, 174 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 3ee1ca3c83ad..ecfe6265954e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -9,6 +9,36 @@
 #include "hinic3_hwif.h"
 #include "hinic3_mbox.h"
 
+static int hinic3_get_interrupt_cfg(struct hinic3_hwdev *hwdev,
+				    struct hinic3_interrupt_info *info)
+{
+	struct comm_cmd_cfg_msix_ctrl_reg msix_cfg = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	msix_cfg.func_id = hinic3_global_func_id(hwdev);
+	msix_cfg.msix_index = info->msix_index;
+	msix_cfg.opcode = MGMT_MSG_CMD_OP_GET;
+
+	mgmt_msg_params_init_default(&msg_params, &msix_cfg, sizeof(msix_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_CFG_MSIX_CTRL_REG, &msg_params);
+	if (err || msix_cfg.head.status) {
+		dev_err(hwdev->dev, "Failed to get interrupt config, err: %d, status: 0x%x\n",
+			err, msix_cfg.head.status);
+		return -EFAULT;
+	}
+
+	info->lli_credit_limit = msix_cfg.lli_credit_cnt;
+	info->lli_timer_cfg = msix_cfg.lli_timer_cnt;
+	info->pending_limit = msix_cfg.pending_cnt;
+	info->coalesc_timer_cfg = msix_cfg.coalesce_timer_cnt;
+	info->resend_timer_cfg = msix_cfg.resend_timer_cnt;
+
+	return 0;
+}
+
 int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
 				    const struct hinic3_interrupt_info *info)
 {
@@ -40,6 +70,30 @@ int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
 	return 0;
 }
 
+int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev,
+			     struct hinic3_interrupt_info info)
+{
+	struct hinic3_interrupt_info temp_info;
+	int err;
+
+	temp_info.msix_index = info.msix_index;
+
+	err = hinic3_get_interrupt_cfg(hwdev, &temp_info);
+	if (err)
+		return err;
+
+	info.lli_credit_limit = temp_info.lli_credit_limit;
+	info.lli_timer_cfg = temp_info.lli_timer_cfg;
+
+	if (!info.interrupt_coalesc_set) {
+		info.pending_limit = temp_info.pending_limit;
+		info.coalesc_timer_cfg = temp_info.coalesc_timer_cfg;
+		info.resend_timer_cfg = temp_info.resend_timer_cfg;
+	}
+
+	return hinic3_set_interrupt_cfg_direct(hwdev, &info);
+}
+
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
 {
 	struct comm_cmd_func_reset func_reset = {};
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index c9c6b4fbcb12..8e4737c486b7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -23,6 +23,8 @@ struct hinic3_interrupt_info {
 
 int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
 				    const struct hinic3_interrupt_info *info);
+int hinic3_set_interrupt_cfg(struct hinic3_hwdev *hwdev,
+			     struct hinic3_interrupt_info info);
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
 
 int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 25e375b20174..4048b3302db7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -200,7 +200,7 @@ static int init_ceqs_msix_attr(struct hinic3_hwdev *hwdev)
 	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
 		eq = &ceqs->ceq[q_id];
 		info.msix_index = eq->msix_entry_idx;
-		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
+		err = hinic3_set_interrupt_cfg(hwdev, info);
 		if (err) {
 			dev_err(hwdev->dev, "Set msix attr for ceq %u failed\n",
 				q_id);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index a69b361225e9..63932a1fa8ee 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
+#include <linux/dim.h>
 #include <linux/netdevice.h>
 
 #include "hinic3_hw_comm.h"
@@ -10,6 +11,22 @@
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
+#define HINIC3_COAL_PKT_SHIFT   5
+
+static void hinic3_net_dim(struct hinic3_nic_dev *nic_dev,
+			   struct hinic3_irq_cfg *irq_cfg)
+{
+	struct hinic3_rxq *rxq = irq_cfg->rxq;
+	struct dim_sample sample = {};
+
+	if (!nic_dev->adaptive_rx_coal)
+		return;
+
+	dim_update_sample(irq_cfg->total_events, rxq->rxq_stats.packets,
+			  rxq->rxq_stats.bytes, &sample);
+	net_dim(&rxq->dim, &sample);
+}
+
 static int hinic3_poll(struct napi_struct *napi, int budget)
 {
 	struct hinic3_irq_cfg *irq_cfg =
@@ -31,9 +48,11 @@ static int hinic3_poll(struct napi_struct *napi, int budget)
 	if (busy)
 		return budget;
 
-	if (likely(napi_complete_done(napi, work_done)))
+	if (likely(napi_complete_done(napi, work_done))) {
+		hinic3_net_dim(nic_dev, irq_cfg);
 		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
 				      HINIC3_MSIX_ENABLE);
+	}
 
 	return work_done;
 }
@@ -70,6 +89,8 @@ static irqreturn_t qp_irq(int irq, void *data)
 	hinic3_msix_intr_clear_resend_bit(nic_dev->hwdev,
 					  irq_cfg->msix_entry_idx, 1);
 
+	irq_cfg->total_events++;
+
 	napi_schedule(&irq_cfg->napi);
 
 	return IRQ_HANDLED;
@@ -92,7 +113,7 @@ static int hinic3_request_irq(struct hinic3_irq_cfg *irq_cfg, u16 q_id)
 	info.coalesc_timer_cfg =
 		nic_dev->intr_coalesce[q_id].coalesce_timer_cfg;
 	info.resend_timer_cfg = nic_dev->intr_coalesce[q_id].resend_timer_cfg;
-	err = hinic3_set_interrupt_cfg_direct(nic_dev->hwdev, &info);
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
 	if (err) {
 		netdev_err(netdev, "Failed to set RX interrupt coalescing attribute.\n");
 		qp_del_napi(irq_cfg);
@@ -117,6 +138,71 @@ static void hinic3_release_irq(struct hinic3_irq_cfg *irq_cfg)
 	free_irq(irq_cfg->irq_id, irq_cfg);
 }
 
+static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
+				      u8 coalesc_timer_cfg, u8 pending_limit)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_interrupt_info info = {};
+	int err;
+
+	if (q_id >= nic_dev->q_params.num_qps)
+		return 0;
+
+	info.interrupt_coalesc_set = 1;
+	info.coalesc_timer_cfg = coalesc_timer_cfg;
+	info.pending_limit = pending_limit;
+	info.msix_index = nic_dev->q_params.irq_cfg[q_id].msix_entry_idx;
+	info.resend_timer_cfg =
+		nic_dev->intr_coalesce[q_id].resend_timer_cfg;
+
+	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
+	if (err) {
+		netdev_err(netdev,
+			   "Failed to modify moderation for Queue: %u\n", q_id);
+	} else {
+		nic_dev->rxqs[q_id].last_coalesc_timer_cfg = coalesc_timer_cfg;
+		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
+	}
+
+	return err;
+}
+
+static void hinic3_update_queue_coal(struct net_device *netdev, u16 q_id,
+				     u16 coal_timer, u16 coal_pkts)
+{
+	struct hinic3_intr_coal_info *q_coal;
+	u8 coalesc_timer_cfg, pending_limit;
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = netdev_priv(netdev);
+
+	q_coal = &nic_dev->intr_coalesce[q_id];
+	coalesc_timer_cfg = (u8)coal_timer;
+	pending_limit = clamp_t(u8, coal_pkts >> HINIC3_COAL_PKT_SHIFT,
+				q_coal->rx_pending_limit_low,
+				q_coal->rx_pending_limit_high);
+
+	hinic3_set_interrupt_moder(nic_dev->netdev, q_id,
+				   coalesc_timer_cfg, pending_limit);
+}
+
+static void hinic3_rx_dim_work(struct work_struct *work)
+{
+	struct dim_cq_moder cur_moder;
+	struct hinic3_rxq *rxq;
+	struct dim *dim;
+
+	dim = container_of(work, struct dim, work);
+	rxq = container_of(dim, struct hinic3_rxq, dim);
+
+	cur_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+
+	hinic3_update_queue_coal(rxq->netdev, rxq->q_id,
+				 cur_moder.usec, cur_moder.pkts);
+
+	dim->state = DIM_START_MEASURE;
+}
+
 int hinic3_qps_irq_init(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -150,6 +236,9 @@ int hinic3_qps_irq_init(struct net_device *netdev)
 			goto err_release_irqs;
 		}
 
+		INIT_WORK(&irq_cfg->rxq->dim.work, hinic3_rx_dim_work);
+		irq_cfg->rxq->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
+
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
 						irq_cfg->msix_entry_idx,
 						HINIC3_SET_MSIX_AUTO_MASK);
@@ -164,12 +253,14 @@ int hinic3_qps_irq_init(struct net_device *netdev)
 		q_id--;
 		irq_cfg = &nic_dev->q_params.irq_cfg[q_id];
 		qp_del_napi(irq_cfg);
+
 		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,
 				      HINIC3_MSIX_DISABLE);
 		hinic3_set_msix_auto_mask_state(nic_dev->hwdev,
 						irq_cfg->msix_entry_idx,
 						HINIC3_CLR_MSIX_AUTO_MASK);
 		hinic3_release_irq(irq_cfg);
+		disable_work_sync(&irq_cfg->rxq->dim.work);
 	}
 
 	return err;
@@ -190,5 +281,6 @@ void hinic3_qps_irq_uninit(struct net_device *netdev)
 						irq_cfg->msix_entry_idx,
 						HINIC3_CLR_MSIX_AUTO_MASK);
 		hinic3_release_irq(irq_cfg);
+		disable_work_sync(&irq_cfg->rxq->dim.work);
 	}
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 1f6bf7be9c1e..c227c8be29a1 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -29,6 +29,9 @@
 #define HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG  25
 #define HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG   7
 
+#define HINIC3_RX_PENDING_LIMIT_LOW   2
+#define HINIC3_RX_PENDING_LIMIT_HIGH  8
+
 static void init_intr_coal_param(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -38,9 +41,16 @@ static void init_intr_coal_param(struct net_device *netdev)
 	for (i = 0; i < nic_dev->max_qps; i++) {
 		info = &nic_dev->intr_coalesce[i];
 		info->pending_limit = HINIC3_DEFAULT_TXRX_MSIX_PENDING_LIMIT;
-		info->coalesce_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG;
-		info->resend_timer_cfg = HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG;
+		info->coalesce_timer_cfg =
+			HINIC3_DEFAULT_TXRX_MSIX_COALESC_TIMER_CFG;
+		info->resend_timer_cfg =
+			HINIC3_DEFAULT_TXRX_MSIX_RESEND_TIMER_CFG;
+
+		info->rx_pending_limit_high = HINIC3_RX_PENDING_LIMIT_HIGH;
+		info->rx_pending_limit_low = HINIC3_RX_PENDING_LIMIT_LOW;
 	}
+
+	nic_dev->adaptive_rx_coal = 1;
 }
 
 static int hinic3_init_intr_coalesce(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 6e48c29566e1..9ca7794e94a6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -49,6 +49,7 @@ struct hinic3_irq_cfg {
 	cpumask_t          affinity_mask;
 	struct hinic3_txq  *txq;
 	struct hinic3_rxq  *rxq;
+	u16                total_events;
 };
 
 struct hinic3_dyna_txrxq_params {
@@ -65,6 +66,9 @@ struct hinic3_intr_coal_info {
 	u8 pending_limit;
 	u8 coalesce_timer_cfg;
 	u8 resend_timer_cfg;
+
+	u8  rx_pending_limit_low;
+	u8  rx_pending_limit_high;
 };
 
 struct hinic3_nic_dev {
@@ -93,6 +97,7 @@ struct hinic3_nic_dev {
 	struct msix_entry               *qps_msix_entries;
 
 	struct hinic3_intr_coal_info    *intr_coalesce;
+	u32                             adaptive_rx_coal;
 
 	struct workqueue_struct         *workq;
 	struct delayed_work             periodic_work;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 68fc237d642b..31622e0a63d0 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -5,6 +5,7 @@
 #define _HINIC3_RX_H_
 
 #include <linux/bitfield.h>
+#include <linux/dim.h>
 #include <linux/netdevice.h>
 
 #define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK           GENMASK(4, 0)
@@ -95,6 +96,11 @@ struct hinic3_rxq {
 	struct device          *dev; /* device for DMA mapping */
 
 	dma_addr_t             cqe_start_paddr;
+
+	struct dim             dim;
+
+	u8                     last_coalesc_timer_cfg;
+	u8                     last_pending_limit;
 } ____cacheline_aligned;
 
 struct hinic3_dyna_rxq_res {
-- 
2.43.0


