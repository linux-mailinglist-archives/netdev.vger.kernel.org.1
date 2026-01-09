Return-Path: <netdev+bounces-248336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB7D0712C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 05:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C1C305A8F6
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 04:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7795C2DFF19;
	Fri,  9 Jan 2026 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JxrUJtLm"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AC2D7DC1;
	Fri,  9 Jan 2026 04:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931823; cv=none; b=R5eC1kN1AU12rjr+Nl2ec0m1hPIZ5Bq4sqyvr7IWTL/GUxpWqp1mZAe4x2QL7+XoU9uFhSjvL0ePvO5QtRLvy4ReHw5qlkChzF0hamIfC1ideETK5s/VGuMNX8Qr7UaWfnwtceCTStxLo2o4nDfXlkP+Ui1q6N7LyT8ITDQHHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931823; c=relaxed/simple;
	bh=T8AN0i8PES9ClxoqYp9n/UZ039PXKFbstSShu4+6K20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkGR4TRZ85O4IYJ+OPwT8IwHM4VK40INehb3NzvAzOjvS6G5DHCfzOgQ7rgspNylEUlzVhvFX3xYd5lWSPs/Dno4uOnzlLqs+VJpJOa5ob+ikX8HPcuDeCR1sLj6P5b9v+y79r9JuRahOIaA84RQoWB6Um0Si6orjGN/0WNS5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JxrUJtLm; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=skVbYWWTi8YJFO9yEX0tp3jqdmxHe/saDuEP0Y+n3TU=;
	b=JxrUJtLmyIX3ij11OmVEt2MQW0NG3QXyMF1Rr12Gk++84gvEaoM3Qu+3bTC53ZygVMvNLv5j2
	4fxpWpoSIFzre09w0mbaEvXuGqAdszVspHyQHPzSRCA2k60gkjKzxIywHoTz+mdt/KVTv7g11Tq
	Lui2PiOMEFADimspd+UgM9k=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dnSs16W3HzmV79;
	Fri,  9 Jan 2026 12:07:01 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0139740539;
	Fri,  9 Jan 2026 12:10:19 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 9 Jan 2026 12:10:17 +0800
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
Subject: [PATCH net-next v10 3/9] hinic3: Add .ndo_tx_timeout and .ndo_get_stats64
Date: Fri, 9 Jan 2026 10:35:53 +0800
Message-ID: <3d50f9fe7d3f787bc6c4363c282022596b65b95a.1767861236.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1767861236.git.zhuyikai1@h-partners.com>
References: <cover.1767861236.git.zhuyikai1@h-partners.com>
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

Implement following callback function:
.ndo_tx_timeout
.ndo_get_stats64

Use a work queue to trace tx_timeout callback and dump necessary
debug information.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  9 +++
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 40 +++++++++-
 .../huawei/hinic3/hinic3_netdev_ops.c         | 77 +++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  8 ++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    | 15 ++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 16 ++++
 6 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 3c15f22973fe..58bc561f95b3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -17,6 +17,15 @@ enum hinic3_event_service_type {
 	HINIC3_EVENT_SRV_NIC  = 1
 };
 
+enum hinic3_fault_err_level {
+	HINIC3_FAULT_LEVEL_SERIOUS_FLR = 3,
+};
+
+enum hinic3_fault_source_type {
+	HINIC3_FAULT_SRC_HW_PHY_FAULT = 9,
+	HINIC3_FAULT_SRC_TX_TIMEOUT   = 22,
+};
+
 #define HINIC3_SRV_EVENT_TYPE(svc, type)    (((svc) << 16) | (type))
 
 /* driver-specific data of pci_dev */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index ce10ae7c0d9e..2bd306f09cd5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -108,6 +108,22 @@ static void hinic3_free_txrxqs(struct net_device *netdev)
 	hinic3_free_txqs(netdev);
 }
 
+static void hinic3_periodic_work_handler(struct work_struct *work)
+{
+	struct delayed_work *delay = to_delayed_work(work);
+	struct hinic3_nic_dev *nic_dev;
+
+	nic_dev = container_of(delay, struct hinic3_nic_dev, periodic_work);
+	if (test_and_clear_bit(HINIC3_EVENT_WORK_TX_TIMEOUT,
+			       &nic_dev->event_flag))
+		dev_info(nic_dev->hwdev->dev,
+			 "Fault event report, src: %u, level: %u\n",
+			 HINIC3_FAULT_SRC_TX_TIMEOUT,
+			 HINIC3_FAULT_LEVEL_SERIOUS_FLR);
+
+	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
+}
+
 static int hinic3_init_nic_dev(struct net_device *netdev,
 			       struct hinic3_hwdev *hwdev)
 {
@@ -123,6 +139,15 @@ static int hinic3_init_nic_dev(struct net_device *netdev,
 	nic_dev->lro_replenish_thld = HINIC3_LRO_REPLENISH_THLD;
 	nic_dev->nic_svc_cap = hwdev->cfg_mgmt->cap.nic_svc_cap;
 
+	nic_dev->workq = create_singlethread_workqueue(HINIC3_NIC_DEV_WQ_NAME);
+	if (!nic_dev->workq) {
+		dev_err(hwdev->dev, "Failed to initialize nic workqueue\n");
+		return -ENOMEM;
+	}
+
+	INIT_DELAYED_WORK(&nic_dev->periodic_work,
+			  hinic3_periodic_work_handler);
+
 	return 0;
 }
 
@@ -276,6 +301,11 @@ static void hinic3_nic_event(struct auxiliary_device *adev,
 	}
 }
 
+static void hinic3_free_nic_dev(struct hinic3_nic_dev *nic_dev)
+{
+	destroy_workqueue(nic_dev->workq);
+}
+
 static int hinic3_nic_probe(struct auxiliary_device *adev,
 			    const struct auxiliary_device_id *id)
 {
@@ -316,7 +346,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 
 	err = hinic3_init_nic_io(nic_dev);
 	if (err)
-		goto err_free_netdev;
+		goto err_free_nic_dev;
 
 	err = hinic3_sw_init(netdev);
 	if (err)
@@ -329,6 +359,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_uninit_sw;
 
+	queue_delayed_work(nic_dev->workq, &nic_dev->periodic_work, HZ);
 	netif_carrier_off(netdev);
 
 	err = register_netdev(netdev);
@@ -338,6 +369,7 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 	return 0;
 
 err_uninit_nic_feature:
+	disable_delayed_work_sync(&nic_dev->periodic_work);
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
 
@@ -346,7 +378,8 @@ static int hinic3_nic_probe(struct auxiliary_device *adev,
 
 err_free_nic_io:
 	hinic3_free_nic_io(nic_dev);
-
+err_free_nic_dev:
+	hinic3_free_nic_dev(nic_dev);
 err_free_netdev:
 	free_netdev(netdev);
 
@@ -368,6 +401,9 @@ static void hinic3_nic_remove(struct auxiliary_device *adev)
 	netdev = nic_dev->netdev;
 	unregister_netdev(netdev);
 
+	disable_delayed_work_sync(&nic_dev->periodic_work);
+	hinic3_free_nic_dev(nic_dev);
+
 	hinic3_update_nic_feature(nic_dev, 0);
 	hinic3_set_nic_feature_to_hw(nic_dev);
 	hinic3_sw_uninit(netdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 15ff01c1c7b7..39091f472372 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -517,11 +517,88 @@ static int hinic3_set_mac_addr(struct net_device *netdev, void *addr)
 	return 0;
 }
 
+static void hinic3_tx_timeout(struct net_device *netdev, unsigned int txqueue)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_io_queue *sq;
+	u16 sw_pi, hw_ci;
+
+	sq = nic_dev->txqs[txqueue].sq;
+	sw_pi = hinic3_get_sq_local_pi(sq);
+	hw_ci = hinic3_get_sq_hw_ci(sq);
+	netdev_dbg(netdev,
+		   "txq%u: sw_pi: %u, hw_ci: %u, sw_ci: %u, napi->state: 0x%lx.\n",
+		   txqueue, sw_pi, hw_ci, hinic3_get_sq_local_ci(sq),
+		   nic_dev->q_params.irq_cfg[txqueue].napi.state);
+
+	if (sw_pi != hw_ci)
+		set_bit(HINIC3_EVENT_WORK_TX_TIMEOUT, &nic_dev->event_flag);
+}
+
+static void hinic3_get_stats64(struct net_device *netdev,
+			       struct rtnl_link_stats64 *stats)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u64 bytes, packets, dropped, errors;
+	struct hinic3_txq_stats *txq_stats;
+	struct hinic3_rxq_stats *rxq_stats;
+	struct hinic3_txq *txq;
+	struct hinic3_rxq *rxq;
+	unsigned int start;
+	int i;
+
+	bytes = 0;
+	packets = 0;
+	dropped = 0;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		if (!nic_dev->txqs)
+			break;
+
+		txq = &nic_dev->txqs[i];
+		txq_stats = &txq->txq_stats;
+		do {
+			start = u64_stats_fetch_begin(&txq_stats->syncp);
+			bytes += txq_stats->bytes;
+			packets += txq_stats->packets;
+			dropped += txq_stats->dropped;
+		} while (u64_stats_fetch_retry(&txq_stats->syncp, start));
+	}
+	stats->tx_packets = packets;
+	stats->tx_bytes   = bytes;
+	stats->tx_dropped = dropped;
+
+	bytes = 0;
+	packets = 0;
+	errors = 0;
+	dropped = 0;
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		if (!nic_dev->rxqs)
+			break;
+
+		rxq = &nic_dev->rxqs[i];
+		rxq_stats = &rxq->rxq_stats;
+		do {
+			start = u64_stats_fetch_begin(&rxq_stats->syncp);
+			bytes += rxq_stats->bytes;
+			packets += rxq_stats->packets;
+			errors += rxq_stats->csum_errors +
+				rxq_stats->other_errors;
+			dropped += rxq_stats->dropped;
+		} while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
+	}
+	stats->rx_packets = packets;
+	stats->rx_bytes   = bytes;
+	stats->rx_errors  = errors;
+	stats->rx_dropped = dropped;
+}
+
 static const struct net_device_ops hinic3_netdev_ops = {
 	.ndo_open             = hinic3_open,
 	.ndo_stop             = hinic3_close,
 	.ndo_change_mtu       = hinic3_change_mtu,
 	.ndo_set_mac_address  = hinic3_set_mac_addr,
+	.ndo_tx_timeout       = hinic3_tx_timeout,
+	.ndo_get_stats64      = hinic3_get_stats64,
 	.ndo_start_xmit       = hinic3_xmit_frame,
 };
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 52bcf6fb14f2..b8c9c325a45a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -13,6 +13,10 @@ enum hinic3_flags {
 	HINIC3_RSS_ENABLE,
 };
 
+enum hinic3_event_work_flags {
+	HINIC3_EVENT_WORK_TX_TIMEOUT,
+};
+
 enum hinic3_rss_hash_type {
 	HINIC3_RSS_HASH_ENGINE_TYPE_XOR  = 0,
 	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP = 1,
@@ -83,9 +87,13 @@ struct hinic3_nic_dev {
 
 	struct hinic3_intr_coal_info    *intr_coalesce;
 
+	struct workqueue_struct         *workq;
+	struct delayed_work             periodic_work;
 	/* lock for enable/disable port */
 	struct mutex                    port_state_mutex;
 
+	/* flag bits defined by hinic3_event_work_flags */
+	unsigned long                   event_flag;
 	bool                            link_status_up;
 };
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 44ae841a3648..68fc237d642b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -25,6 +25,20 @@
 #define RQ_CQE_STATUS_GET(val, member) \
 	FIELD_GET(RQ_CQE_STATUS_##member##_MASK, val)
 
+struct hinic3_rxq_stats {
+	u64                   packets;
+	u64                   bytes;
+	u64                   errors;
+	u64                   csum_errors;
+	u64                   other_errors;
+	u64                   dropped;
+	u64                   rx_buf_empty;
+	u64                   alloc_skb_err;
+	u64                   alloc_rx_buf_err;
+	u64                   restore_drop_sge;
+	struct u64_stats_sync syncp;
+};
+
 /* RX Completion information that is provided by HW for a specific RX WQE */
 struct hinic3_rq_cqe {
 	__le32 status;
@@ -59,6 +73,7 @@ struct hinic3_rxq {
 	u16                     buf_len;
 	u32                     buf_len_shift;
 
+	struct hinic3_rxq_stats rxq_stats;
 	u32                     cons_idx;
 	u32                     delta;
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 7e1b872ba752..00194f2a1bcc 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -100,6 +100,20 @@ struct hinic3_sq_wqe_combo {
 	u32                       task_type;
 };
 
+struct hinic3_txq_stats {
+	u64                   packets;
+	u64                   bytes;
+	u64                   busy;
+	u64                   dropped;
+	u64                   skb_pad_err;
+	u64                   frag_len_overflow;
+	u64                   offload_cow_skb_err;
+	u64                   map_frag_err;
+	u64                   unknown_tunnel_pkt;
+	u64                   frag_size_err;
+	struct u64_stats_sync syncp;
+};
+
 struct hinic3_dma_info {
 	dma_addr_t dma;
 	u32        len;
@@ -123,6 +137,8 @@ struct hinic3_txq {
 
 	struct hinic3_tx_info   *tx_info;
 	struct hinic3_io_queue  *sq;
+
+	struct hinic3_txq_stats txq_stats;
 } ____cacheline_aligned;
 
 struct hinic3_dyna_txq_res {
-- 
2.43.0


