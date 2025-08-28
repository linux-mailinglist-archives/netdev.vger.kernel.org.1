Return-Path: <netdev+bounces-217769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2037B39CA1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F07562ED3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7246315774;
	Thu, 28 Aug 2025 12:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D4314A88;
	Thu, 28 Aug 2025 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383052; cv=none; b=n+YTTpGuJN00HFaDc9Dck0BEYlJh8tX76yl7YVFhoLjsJ/zUI27ZFJkvUyJm7SlEfnlKfyeXmtWrfb0cnh6h8kOSMZAXkjJHynatNt07uWaqDRyGyecXeLhiD/942lcbJ0bQ+4rJ6Kfb0xRrgqna56AixioN1VhJRwno/6KKiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383052; c=relaxed/simple;
	bh=iqvyhKuSrHs3LTnNJnSonAKKKY45pUOnlCGS1S7C2uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZorUglGEG2sre1Co8dmKYt3W2wKdecr7HlWoUcPXhZ6eUxxvJCBvzs4k277vLnJrmc+o3PajGZBjnQZW2Rp+6uSTsGhCGTEv2S2O0YaA8JAnmSZ6isSYtFBlJ0r9GGYDSS7BdslRe1HMr+bcLyDlxQ3W9sEswe/rB+nMKhSEbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cCKqk09xLzPqVD;
	Thu, 28 Aug 2025 20:06:10 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E962180B5A;
	Thu, 28 Aug 2025 20:10:46 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:44 +0800
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
Subject: [PATCH net-next v02 08/14] hinic3: Queue pair resource initialization
Date: Thu, 28 Aug 2025 20:10:14 +0800
Message-ID: <e7144feb319e2644ed1191b9a0881411cf4c293a.1756378721.git.zhuyikai1@h-partners.com>
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

Add Tx & Rx queue resources and functions for packet transmission
and reception.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../huawei/hinic3/hinic3_netdev_ops.c         | 259 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 243 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  21 ++
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 158 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  12 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  69 +++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  10 +
 7 files changed, 765 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 71104a6b8bef..f0749a02ff80 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -11,16 +11,267 @@
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
+/* try to modify the number of irq to the target number,
+ * and return the actual number of irq.
+ */
+static u16 hinic3_qp_irq_change(struct net_device *netdev,
+				u16 dst_num_qp_irq)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct msix_entry *qps_msix_entries;
+	u16 resp_irq_num, irq_num_gap, i;
+	u16 idx;
+	int err;
+
+	qps_msix_entries = nic_dev->qps_msix_entries;
+	if (dst_num_qp_irq > nic_dev->num_qp_irq) {
+		irq_num_gap = dst_num_qp_irq - nic_dev->num_qp_irq;
+		err = hinic3_alloc_irqs(nic_dev->hwdev, irq_num_gap,
+					&qps_msix_entries[nic_dev->num_qp_irq],
+					&resp_irq_num);
+		if (err) {
+			netdev_err(netdev, "Failed to alloc irqs\n");
+			return nic_dev->num_qp_irq;
+		}
+
+		nic_dev->num_qp_irq += resp_irq_num;
+	} else if (dst_num_qp_irq < nic_dev->num_qp_irq) {
+		irq_num_gap = nic_dev->num_qp_irq - dst_num_qp_irq;
+		for (i = 0; i < irq_num_gap; i++) {
+			idx = (nic_dev->num_qp_irq - i) - 1;
+			hinic3_free_irq(nic_dev->hwdev,
+					qps_msix_entries[idx].vector);
+			qps_msix_entries[idx].vector = 0;
+			qps_msix_entries[idx].entry = 0;
+		}
+		nic_dev->num_qp_irq = dst_num_qp_irq;
+	}
+
+	return nic_dev->num_qp_irq;
+}
+
+static void hinic3_config_num_qps(struct net_device *netdev,
+				  struct hinic3_dyna_txrxq_params *q_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 alloc_num_irq, cur_num_irq;
+	u16 dst_num_irq;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		q_params->num_qps = 1;
+
+	if (nic_dev->num_qp_irq >= q_params->num_qps)
+		goto out;
+
+	cur_num_irq = nic_dev->num_qp_irq;
+
+	alloc_num_irq = hinic3_qp_irq_change(netdev, q_params->num_qps);
+	if (alloc_num_irq < q_params->num_qps) {
+		q_params->num_qps = alloc_num_irq;
+		netdev_warn(netdev, "Can not get enough irqs, adjust num_qps to %u\n",
+			    q_params->num_qps);
+
+		/* The current irq may be in use, we must keep it */
+		dst_num_irq = max_t(u16, cur_num_irq, q_params->num_qps);
+		hinic3_qp_irq_change(netdev, dst_num_irq);
+	}
+
+out:
+	netdev_dbg(netdev, "Finally num_qps: %u\n", q_params->num_qps);
+}
+
+static int hinic3_setup_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->num_qp_irq = 0;
+
+	if (!nic_dev->max_qps) {
+		netdev_err(netdev, "Cannot allocate zero size entries\n");
+		return -EINVAL;
+	}
+	nic_dev->qps_msix_entries = kcalloc(nic_dev->max_qps,
+					    sizeof(struct msix_entry),
+					    GFP_KERNEL);
+	if (!nic_dev->qps_msix_entries)
+		return -ENOMEM;
+
+	hinic3_config_num_qps(netdev, &nic_dev->q_params);
+
+	return 0;
+}
+
+static void hinic3_destroy_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	for (i = 0; i < nic_dev->num_qp_irq; i++)
+		hinic3_free_irq(nic_dev->hwdev,
+				nic_dev->qps_msix_entries[i].vector);
+
+	kfree(nic_dev->qps_msix_entries);
+}
+
+static int hinic3_alloc_txrxq_resources(struct net_device *netdev,
+					struct hinic3_dyna_txrxq_params *q_params)
+{
+	int err;
+
+	q_params->txqs_res = kcalloc(q_params->num_qps,
+				     sizeof(*q_params->txqs_res), GFP_KERNEL);
+	if (!q_params->txqs_res)
+		return -ENOMEM;
+
+	q_params->rxqs_res = kcalloc(q_params->num_qps,
+				     sizeof(*q_params->rxqs_res), GFP_KERNEL);
+	if (!q_params->rxqs_res) {
+		err = -ENOMEM;
+		goto err_free_txqs_res_arr;
+	}
+
+	q_params->irq_cfg = kcalloc(q_params->num_qps,
+				    sizeof(*q_params->irq_cfg), GFP_KERNEL);
+	if (!q_params->irq_cfg) {
+		err = -ENOMEM;
+		goto err_free_rxqs_res_arr;
+	}
+
+	err = hinic3_alloc_txqs_res(netdev, q_params->num_qps,
+				    q_params->sq_depth, q_params->txqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc txqs resource\n");
+		goto err_free_irq_cfg;
+	}
+
+	err = hinic3_alloc_rxqs_res(netdev, q_params->num_qps,
+				    q_params->rq_depth, q_params->rxqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc rxqs resource\n");
+		goto err_free_txqs_res;
+	}
+
+	return 0;
+
+err_free_txqs_res:
+	hinic3_free_txqs_res(netdev, q_params->num_qps, q_params->sq_depth,
+			     q_params->txqs_res);
+
+err_free_irq_cfg:
+	kfree(q_params->irq_cfg);
+	q_params->irq_cfg = NULL;
+
+err_free_rxqs_res_arr:
+	kfree(q_params->rxqs_res);
+	q_params->rxqs_res = NULL;
+
+err_free_txqs_res_arr:
+	kfree(q_params->txqs_res);
+	q_params->txqs_res = NULL;
+
+	return err;
+}
+
+static void hinic3_free_txrxq_resources(struct net_device *netdev,
+					struct hinic3_dyna_txrxq_params *q_params)
+{
+	hinic3_free_rxqs_res(netdev, q_params->num_qps, q_params->rq_depth,
+			     q_params->rxqs_res);
+	hinic3_free_txqs_res(netdev, q_params->num_qps, q_params->sq_depth,
+			     q_params->txqs_res);
+
+	kfree(q_params->irq_cfg);
+	q_params->irq_cfg = NULL;
+
+	kfree(q_params->rxqs_res);
+	q_params->rxqs_res = NULL;
+
+	kfree(q_params->txqs_res);
+	q_params->txqs_res = NULL;
+}
+
+static int hinic3_alloc_channel_resources(struct net_device *netdev,
+					  struct hinic3_dyna_qp_params *qp_params,
+					  struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	qp_params->num_qps = trxq_params->num_qps;
+	qp_params->sq_depth = trxq_params->sq_depth;
+	qp_params->rq_depth = trxq_params->rq_depth;
+
+	err = hinic3_alloc_qps(nic_dev, qp_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc qps\n");
+		return err;
+	}
+
+	err = hinic3_alloc_txrxq_resources(netdev, trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc txrxq resources\n");
+		hinic3_free_qps(nic_dev, qp_params);
+		return err;
+	}
+
+	return 0;
+}
+
+static void hinic3_free_channel_resources(struct net_device *netdev,
+					  struct hinic3_dyna_qp_params *qp_params,
+					  struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_free_txrxq_resources(netdev, trxq_params);
+	hinic3_free_qps(nic_dev, qp_params);
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params qp_params;
+	int err;
+
+	err = hinic3_init_nicio_res(nic_dev);
+	if (err) {
+		netdev_err(netdev, "Failed to init nicio resources\n");
+		return err;
+	}
+
+	err = hinic3_setup_num_qps(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to setup num_qps\n");
+		goto err_free_nicio_res;
+	}
+
+	err = hinic3_alloc_channel_resources(netdev, &qp_params,
+					     &nic_dev->q_params);
+	if (err)
+		goto err_destroy_num_qps;
+
+	hinic3_init_qps(nic_dev, &qp_params);
+
+	return 0;
+
+err_destroy_num_qps:
+	hinic3_destroy_num_qps(netdev);
+
+err_free_nicio_res:
+	hinic3_free_nicio_res(nic_dev);
+
+	return err;
 }
 
 static int hinic3_close(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params qp_params;
+
+	hinic3_uninit_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+
+	return 0;
 }
 
 static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index c077bba8f03a..cd44f69ec07e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -9,6 +9,14 @@
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_io.h"
 
+#define HINIC3_CI_Q_ADDR_SIZE                (64)
+
+#define HINIC3_CI_TABLE_SIZE(num_qps)  \
+	(ALIGN((num_qps) * HINIC3_CI_Q_ADDR_SIZE, HINIC3_MIN_PAGE_SIZE))
+
+#define HINIC3_CI_VADDR(base_addr, q_id)  \
+	((u8 *)(base_addr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
 int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
 {
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
@@ -65,3 +73,238 @@ void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev)
 	nic_dev->nic_io = NULL;
 	kfree(nic_io);
 }
+
+int hinic3_init_nicio_res(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	void __iomem *db_base;
+	int err;
+
+	nic_io->max_qps = hinic3_func_max_qnum(hwdev);
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate doorbell for sqs\n");
+		return err;
+	}
+	nic_io->sqs_db_addr = db_base;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr);
+		dev_err(hwdev->dev, "Failed to allocate doorbell for rqs\n");
+		return err;
+	}
+	nic_io->rqs_db_addr = db_base;
+
+	nic_io->ci_vaddr_base =
+		dma_alloc_coherent(hwdev->dev,
+				   HINIC3_CI_TABLE_SIZE(nic_io->max_qps),
+				   &nic_io->ci_dma_base,
+				   GFP_KERNEL);
+	if (!nic_io->ci_vaddr_base) {
+		hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr);
+		hinic3_free_db_addr(hwdev, nic_io->rqs_db_addr);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void hinic3_free_nicio_res(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	dma_free_coherent(hwdev->dev,
+			  HINIC3_CI_TABLE_SIZE(nic_io->max_qps),
+			  nic_io->ci_vaddr_base, nic_io->ci_dma_base);
+
+	hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr);
+	hinic3_free_db_addr(hwdev, nic_io->rqs_db_addr);
+}
+
+static int hinic3_create_sq(struct hinic3_hwdev *hwdev,
+			    struct hinic3_io_queue *sq,
+			    u16 q_id, u32 sq_depth, u16 sq_msix_idx)
+{
+	int err;
+
+	/* sq used & hardware request init 1 */
+	sq->owner = 1;
+
+	sq->q_id = q_id;
+	sq->msix_entry_idx = sq_msix_idx;
+
+	err = hinic3_wq_create(hwdev, &sq->wq, sq_depth,
+			       BIT(HINIC3_SQ_WQEBB_SHIFT));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create tx queue %u wq\n",
+			q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_create_rq(struct hinic3_hwdev *hwdev,
+			    struct hinic3_io_queue *rq,
+			    u16 q_id, u32 rq_depth, u16 rq_msix_idx)
+{
+	int err;
+
+	rq->q_id = q_id;
+	rq->msix_entry_idx = rq_msix_idx;
+
+	err = hinic3_wq_create(hwdev, &rq->wq, rq_depth,
+			       BIT(HINIC3_RQ_WQEBB_SHIFT +
+				   HINIC3_NORMAL_RQ_WQE));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create rx queue %u wq\n",
+			q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_create_qp(struct hinic3_hwdev *hwdev,
+			    struct hinic3_io_queue *sq,
+			    struct hinic3_io_queue *rq, u16 q_id, u32 sq_depth,
+			    u32 rq_depth, u16 qp_msix_idx)
+{
+	int err;
+
+	err = hinic3_create_sq(hwdev, sq, q_id, sq_depth, qp_msix_idx);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create sq, qid: %u\n",
+			q_id);
+		return err;
+	}
+
+	err = hinic3_create_rq(hwdev, rq, q_id, rq_depth, qp_msix_idx);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create rq, qid: %u\n",
+			q_id);
+		goto err_destroy_sq_wq;
+	}
+
+	return 0;
+
+err_destroy_sq_wq:
+	hinic3_wq_destroy(hwdev, &sq->wq);
+
+	return err;
+}
+
+static void hinic3_destroy_qp(struct hinic3_hwdev *hwdev,
+			      struct hinic3_io_queue *sq,
+			      struct hinic3_io_queue *rq)
+{
+	hinic3_wq_destroy(hwdev, &sq->wq);
+	hinic3_wq_destroy(hwdev, &rq->wq);
+}
+
+int hinic3_alloc_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct msix_entry *qps_msix_entries = nic_dev->qps_msix_entries;
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_io_queue *sqs;
+	struct hinic3_io_queue *rqs;
+	u16 q_id;
+	int err;
+
+	if (qp_params->num_qps > nic_io->max_qps || !qp_params->num_qps)
+		return -EINVAL;
+
+	sqs = kcalloc(qp_params->num_qps, sizeof(*sqs), GFP_KERNEL);
+	if (!sqs) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	rqs = kcalloc(qp_params->num_qps, sizeof(*rqs), GFP_KERNEL);
+	if (!rqs) {
+		err = -ENOMEM;
+		goto err_free_sqs;
+	}
+
+	for (q_id = 0; q_id < qp_params->num_qps; q_id++) {
+		err = hinic3_create_qp(hwdev, &sqs[q_id], &rqs[q_id], q_id,
+				       qp_params->sq_depth, qp_params->rq_depth,
+				       qps_msix_entries[q_id].entry);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to allocate qp %u, err: %d\n",
+				q_id, err);
+			goto err_destroy_qp;
+		}
+	}
+
+	qp_params->sqs = sqs;
+	qp_params->rqs = rqs;
+
+	return 0;
+
+err_destroy_qp:
+	while (q_id > 0) {
+		q_id--;
+		hinic3_destroy_qp(hwdev, &sqs[q_id], &rqs[q_id]);
+	}
+
+	kfree(rqs);
+
+err_free_sqs:
+	kfree(sqs);
+
+err_out:
+	return err;
+}
+
+void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u16 q_id;
+
+	for (q_id = 0; q_id < qp_params->num_qps; q_id++)
+		hinic3_destroy_qp(hwdev, &qp_params->sqs[q_id],
+				  &qp_params->rqs[q_id]);
+
+	kfree(qp_params->sqs);
+	kfree(qp_params->rqs);
+}
+
+void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_io_queue *sqs = qp_params->sqs;
+	struct hinic3_io_queue *rqs = qp_params->rqs;
+	u16 q_id;
+
+	nic_io->num_qps = qp_params->num_qps;
+	nic_io->sq = qp_params->sqs;
+	nic_io->rq = qp_params->rqs;
+	for (q_id = 0; q_id < nic_io->num_qps; q_id++) {
+		sqs[q_id].cons_idx_addr =
+			(u16 *)HINIC3_CI_VADDR(nic_io->ci_vaddr_base, q_id);
+		/* clear ci value */
+		WRITE_ONCE(*sqs[q_id].cons_idx_addr, 0);
+
+		sqs[q_id].db_addr = nic_io->sqs_db_addr;
+		rqs[q_id].db_addr = nic_io->rqs_db_addr;
+	}
+}
+
+void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
+		       struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+
+	qp_params->sqs = nic_io->sq;
+	qp_params->rqs = nic_io->rq;
+	qp_params->num_qps = nic_io->num_qps;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index 1808d37e7cf7..c103095c37ef 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -94,6 +94,15 @@ static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
 	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
 }
 
+struct hinic3_dyna_qp_params {
+	u16                    num_qps;
+	u32                    sq_depth;
+	u32                    rq_depth;
+
+	struct hinic3_io_queue *sqs;
+	struct hinic3_io_queue *rqs;
+};
+
 struct hinic3_nic_io {
 	struct hinic3_io_queue *sq;
 	struct hinic3_io_queue *rq;
@@ -118,4 +127,16 @@ struct hinic3_nic_io {
 int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev);
 
+int hinic3_init_nicio_res(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_nicio_res(struct hinic3_nic_dev *nic_dev);
+
+int hinic3_alloc_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
+		       struct hinic3_dyna_qp_params *qp_params);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index ac04e3a192ad..a57ee5c409ba 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -35,13 +35,41 @@
 
 int hinic3_alloc_rxqs(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct pci_dev *pdev = nic_dev->pdev;
+	u16 num_rxqs = nic_dev->max_qps;
+	struct hinic3_rxq *rxq;
+	u16 q_id;
+
+	if (!num_rxqs) {
+		dev_err(hwdev->dev, "Cannot allocate zero size rxqs\n");
+		return -EINVAL;
+	}
+
+	nic_dev->rxqs = kcalloc(num_rxqs, sizeof(*nic_dev->rxqs), GFP_KERNEL);
+	if (!nic_dev->rxqs)
+		return -ENOMEM;
+
+	for (q_id = 0; q_id < num_rxqs; q_id++) {
+		rxq = &nic_dev->rxqs[q_id];
+		rxq->netdev = netdev;
+		rxq->dev = &pdev->dev;
+		rxq->q_id = q_id;
+		rxq->buf_len = nic_dev->rx_buf_len;
+		rxq->buf_len_shift = ilog2(nic_dev->rx_buf_len);
+		rxq->q_depth = nic_dev->q_params.rq_depth;
+		rxq->q_mask = nic_dev->q_params.rq_depth - 1;
+	}
+
+	return 0;
 }
 
 void hinic3_free_rxqs(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->rxqs);
 }
 
 static int rx_alloc_mapped_page(struct page_pool *page_pool,
@@ -50,6 +78,9 @@ static int rx_alloc_mapped_page(struct page_pool *page_pool,
 	struct page *page;
 	u32 page_offset;
 
+	if (likely(rx_info->page))
+		return 0;
+
 	page = page_pool_dev_alloc_frag(page_pool, &page_offset, buf_len);
 	if (unlikely(!page))
 		return -ENOMEM;
@@ -102,6 +133,41 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 	return i;
 }
 
+static u32 hinic3_alloc_rx_buffers(struct hinic3_dyna_rxq_res *rqres,
+				   u32 rq_depth, u16 buf_len)
+{
+	u32 free_wqebbs = rq_depth - 1;
+	u32 idx;
+	int err;
+
+	for (idx = 0; idx < free_wqebbs; idx++) {
+		err = rx_alloc_mapped_page(rqres->page_pool,
+					   &rqres->rx_info[idx], buf_len);
+		if (err)
+			break;
+	}
+
+	return idx;
+}
+
+static void hinic3_free_rx_buffers(struct hinic3_dyna_rxq_res *rqres,
+				   u32 q_depth)
+{
+	struct hinic3_rx_info *rx_info;
+	u32 i;
+
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < q_depth; i++) {
+		rx_info = &rqres->rx_info[i];
+
+		if (rx_info->page) {
+			page_pool_put_full_page(rqres->page_pool,
+						rx_info->page, false);
+			rx_info->page = NULL;
+		}
+	}
+}
+
 static void hinic3_add_rx_frag(struct hinic3_rxq *rxq,
 			       struct hinic3_rx_info *rx_info,
 			       struct sk_buff *skb, u32 size)
@@ -299,6 +365,92 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	return 0;
 }
 
+int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	u64 cqe_mem_size = sizeof(struct hinic3_rq_cqe) * rq_depth;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct page_pool_params pp_params = {};
+	struct hinic3_dyna_rxq_res *rqres;
+	u32 pkt_idx;
+	int idx;
+
+	for (idx = 0; idx < num_rq; idx++) {
+		rqres = &rxqs_res[idx];
+		rqres->rx_info = kcalloc(rq_depth, sizeof(*rqres->rx_info),
+					 GFP_KERNEL);
+		if (!rqres->rx_info)
+			goto err_free_rqres;
+
+		rqres->cqe_start_vaddr =
+			dma_alloc_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+					   &rqres->cqe_start_paddr, GFP_KERNEL);
+		if (!rqres->cqe_start_vaddr) {
+			netdev_err(netdev, "Failed to alloc rxq%d rx cqe\n",
+				   idx);
+			goto err_free_rx_info;
+		}
+
+		pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.pool_size = rq_depth * nic_dev->rx_buf_len /
+				      PAGE_SIZE;
+		pp_params.nid = dev_to_node(&nic_dev->pdev->dev);
+		pp_params.dev = &nic_dev->pdev->dev;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+		pp_params.max_len = PAGE_SIZE;
+		rqres->page_pool = page_pool_create(&pp_params);
+		if (!rqres->page_pool) {
+			netdev_err(netdev, "Failed to create rxq%d page pool\n",
+				   idx);
+			goto err_free_cqe;
+		}
+
+		pkt_idx = hinic3_alloc_rx_buffers(rqres, rq_depth,
+						  nic_dev->rx_buf_len);
+		if (!pkt_idx) {
+			netdev_err(netdev, "Failed to alloc rxq%d rx buffers\n",
+				   idx);
+			goto err_destroy_page_pool;
+		}
+		rqres->next_to_alloc = pkt_idx;
+	}
+
+	return 0;
+
+err_destroy_page_pool:
+	page_pool_destroy(rqres->page_pool);
+err_free_cqe:
+	dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+			  rqres->cqe_start_vaddr,
+			  rqres->cqe_start_paddr);
+err_free_rx_info:
+	kfree(rqres->rx_info);
+err_free_rqres:
+	hinic3_free_rxqs_res(netdev, idx, rq_depth, rxqs_res);
+
+	return -ENOMEM;
+}
+
+void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	u64 cqe_mem_size = sizeof(struct hinic3_rq_cqe) * rq_depth;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	int idx;
+
+	for (idx = 0; idx < num_rq; idx++) {
+		rqres = &rxqs_res[idx];
+
+		hinic3_free_rx_buffers(rqres, rq_depth);
+		page_pool_destroy(rqres->page_pool);
+		dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+				  rqres->cqe_start_vaddr,
+				  rqres->cqe_start_paddr);
+		kfree(rqres->rx_info);
+	}
+}
+
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index e7b496d13a69..ec3f45c3688a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -82,9 +82,21 @@ struct hinic3_rxq {
 	dma_addr_t             cqe_start_paddr;
 } ____cacheline_aligned;
 
+struct hinic3_dyna_rxq_res {
+	u16                   next_to_alloc;
+	struct hinic3_rx_info *rx_info;
+	dma_addr_t            cqe_start_paddr;
+	void                  *cqe_start_vaddr;
+	struct page_pool      *page_pool;
+};
+
 int hinic3_alloc_rxqs(struct net_device *netdev);
 void hinic3_free_rxqs(struct net_device *netdev);
 
+int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 8671bc2e1316..3c63fe071999 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -138,6 +138,23 @@ static void hinic3_tx_unmap_skb(struct net_device *netdev,
 			 dma_info[0].len, DMA_TO_DEVICE);
 }
 
+static void free_all_tx_skbs(struct net_device *netdev, u32 sq_depth,
+			     struct hinic3_tx_info *tx_info_arr)
+{
+	struct hinic3_tx_info *tx_info;
+	u32 idx;
+
+	for (idx = 0; idx < sq_depth; idx++) {
+		tx_info = &tx_info_arr[idx];
+		if (tx_info->skb) {
+			hinic3_tx_unmap_skb(netdev, tx_info->skb,
+					    tx_info->dma_info);
+			dev_kfree_skb_any(tx_info->skb);
+			tx_info->skb = NULL;
+		}
+	}
+}
+
 union hinic3_ip {
 	struct iphdr   *v4;
 	struct ipv6hdr *v6;
@@ -633,6 +650,58 @@ void hinic3_flush_txqs(struct net_device *netdev)
 #define HINIC3_BDS_PER_SQ_WQEBB \
 	(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))
 
+int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_dyna_txq_res *tqres;
+	int idx;
+
+	for (idx = 0; idx < num_sq; idx++) {
+		tqres = &txqs_res[idx];
+
+		tqres->tx_info = kcalloc(sq_depth, sizeof(*tqres->tx_info),
+					 GFP_KERNEL);
+		if (!tqres->tx_info)
+			goto err_free_tqres;
+
+		tqres->bds = kcalloc(sq_depth * HINIC3_BDS_PER_SQ_WQEBB +
+				     HINIC3_MAX_SQ_SGE, sizeof(*tqres->bds),
+				     GFP_KERNEL);
+		if (!tqres->bds) {
+			kfree(tqres->tx_info);
+			goto err_free_tqres;
+		}
+	}
+
+	return 0;
+
+err_free_tqres:
+	while (idx > 0) {
+		idx--;
+		tqres = &txqs_res[idx];
+
+		kfree(tqres->bds);
+		kfree(tqres->tx_info);
+	}
+
+	return -ENOMEM;
+}
+
+void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_dyna_txq_res *tqres;
+	int idx;
+
+	for (idx = 0; idx < num_sq; idx++) {
+		tqres = &txqs_res[idx];
+
+		free_all_tx_skbs(netdev, sq_depth, tqres->tx_info);
+		kfree(tqres->bds);
+		kfree(tqres->tx_info);
+	}
+}
+
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 {
 	struct net_device *netdev = txq->netdev;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 21dfe879a29a..9ec6968b6688 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -125,9 +125,19 @@ struct hinic3_txq {
 	struct hinic3_io_queue  *sq;
 } ____cacheline_aligned;
 
+struct hinic3_dyna_txq_res {
+	struct hinic3_tx_info  *tx_info;
+	struct hinic3_dma_info *bds;
+};
+
 int hinic3_alloc_txqs(struct net_device *netdev);
 void hinic3_free_txqs(struct net_device *netdev);
 
+int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+
 netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 bool hinic3_tx_poll(struct hinic3_txq *txq, int budget);
 void hinic3_flush_txqs(struct net_device *netdev);
-- 
2.43.0


