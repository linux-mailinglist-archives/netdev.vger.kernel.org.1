Return-Path: <netdev+bounces-209657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E2CB102DF
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1931016A7E1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B42701D0;
	Thu, 24 Jul 2025 08:07:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CD27147D
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344470; cv=none; b=HahSEiBvYnPChXJJapNBNnUakkLN41rYAtjsoXr5ZBxkTOJM/fL6Mp5KYY/mp7PwEw2pXpXR3+llN45gR1wjJF9Ud/VFmW1ze+VI1ptuslu1dHG88ZPyg+joZhOLlWmanJgNKs05/IvVnKJCvpfzNK1aasoav5a/e9hGN+kw5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344470; c=relaxed/simple;
	bh=l4rVJPyXPjhl9kR709Yv98+UtFAP8HDfjurD0NrKeKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cddpUOdVYBprAjeN3uy9MRfi9gZilOZxN0qiuZLWvdBxjG/FYzRXEb5cPNGUdOvisBDw1xVaDVYIrmj4+j9KAByRPc3cPM1o3iVuGT22khhCMCoBHqNX+LwH/jpMKqWm0rt4sOLijxquGQWn1p07ZX/RjLhXKLqgb1zxog4iU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1753344388t07e9d039
X-QQ-Originating-IP: Z93FqpwtELrKytx7e4VX/k4td4axp0c9zsRa6ynSIQ0=
Received: from lap-jiawenwu.trustnetic.com ( [60.186.23.165])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Jul 2025 16:06:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 794691913130010900
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 3/3] net: wangxun: support to use adaptive RX coalescing
Date: Thu, 24 Jul 2025 16:05:48 +0800
Message-Id: <20250724080548.23912-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250724080548.23912-1-jiawenwu@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NamDlXnbz6wM9iJ/GZgk4BYLAw9qX2uuNtKEit4SHfxlDWZ0Bo0Njn6/
	4i9eHkeY7WSKu8iwal3/hb7x6P00TMKWjEFpT2JRXv01d/N3j0k4MDweuMg3OZySm4eWhgg
	OhLXGw8S1WvaNznq97ZBWFEMCBU4pYa9LbvXBz/5MqPhJi8jQv22UYthxpfRba3IthWgatE
	bVYhBeHytdnufzz5+0rrvIvlcW7jR3cKcm2fjYISMXXXRbuUBaqN6BSmeTFfOQqW8Ckq6fz
	MkoxPk3/IZ9XnxjSPiHngW+HRacQyrxkG6fYbNBu+jhk/Xs4jAFqVDr+Xb3fxjtkra78pzV
	ZJ7PK5JlBQ1TE4T5n/yNeiPjwHW8UqOhPWS+lEBVyhXlKHd54/GrLvBTN1gEJurLON1eSlh
	vbZPE7DoyDb9cl0TGEaRPelZdeCAbXOb16wWXHLPlWqJbV070nD/OJaBx3nouCiq7kBYpcZ
	u7zFf3zYO3XD0UGlQ7cMi+756pUVIeLCNhTMPhMH587GZoKtaCp2+Kd5Onv/6B/GbVxISXC
	lzHujz1xOhY0liUkf/0H2az/tsgW1LdqZ2GAsK050AXpKKGlIY8hzdF+KpZM1PYBkXaJuT7
	vzvF4lyUHkJFi3OwppX+8V7y9gUN6rQlvELJ5P0qIwgcATLlbvUPpFD3q03VQPlA6Aif/zk
	dlGgqncDcxNBt7gsKtC8WgzMhIjAjBI33vq2qktwAMZlPQDlPJvCOFWRLzwUqH2Sv7xXT17
	KX1nozsLaX1PIYOIMvSLvDyz/r4SmAAbOow/tSYlTHMZIz0o8KSf2os6lMZ/keCU0N1iAmB
	UJoylTatHQQiolg0lW4F65NdBxtjq+JKx0QFfek0usvVN40/eXhziN0hVqLu2tYyt0pBqfG
	7Or3fcnPSNbtMl4lvJ8T560EUk5IM75jqJWBBP4W3gQ4UDq5ENbozE0rqP6doXoMD+J6xCA
	m7XktDZJIefLTH3kNrAyx6CSWIScTad29IJkcWulrsOEOKYv2QKEAiAo/xhCZ/kyVwLgf6j
	dtoFH2nO6FU/GByexb7PFF82bl9WuIC8xLzKUybALcI8HCGKsHpKVin5w2juz5DNOZ/mQJS
	w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Support to turn on/off adaptive RX coalesce. When adaptive RX coalesce
is on, use DIM algorithm for a dynamic interrupt moderation.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  10 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 100 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 8 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index 424ec3212128..d138dea7d208 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -20,6 +20,7 @@ config LIBWX
 	tristate
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select PAGE_POOL
+	select DIMLIB
 	help
 	Common library for Wangxun(R) Ethernet drivers.
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ebef99185bca..f2d888825659 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -303,6 +303,9 @@ int wx_get_coalesce(struct net_device *netdev,
 	else
 		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
 
+	if (wx->rx_itr_setting == 1)
+		ec->use_adaptive_rx_coalesce = 1;
+
 	/* if in mixed tx/rx queues per vector mode, report only rx settings */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
 		return 0;
@@ -363,10 +366,15 @@ int wx_set_coalesce(struct net_device *netdev,
 	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
 		return -EINVAL;
 
+	if (ec->use_adaptive_rx_coalesce) {
+		wx->rx_itr_setting = 1;
+		return 0;
+	}
+
 	if (ec->rx_coalesce_usecs > 1)
 		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
 	else
-		wx->rx_itr_setting = ec->rx_coalesce_usecs;
+		wx->rx_itr_setting = rx_itr_param;
 
 	if (wx->rx_itr_setting != 1)
 		rx_itr_param = wx->rx_itr_setting;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 723785ef87bb..8699103b59e5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -16,6 +16,7 @@
 #include "wx_lib.h"
 #include "wx_ptp.h"
 #include "wx_hw.h"
+#include "wx_vf_lib.h"
 
 /* Lookup table mapping the HW PTYPE to the bit field for decoding */
 static struct wx_dec_ptype wx_ptype_lookup[256] = {
@@ -832,6 +833,36 @@ static bool wx_clean_tx_irq(struct wx_q_vector *q_vector,
 	return !!budget;
 }
 
+static void wx_update_rx_dim_sample(struct wx_q_vector *q_vector)
+{
+	struct dim_sample sample = {};
+
+	dim_update_sample(q_vector->total_events,
+			  q_vector->rx.total_packets,
+			  q_vector->rx.total_bytes,
+			  &sample);
+
+	net_dim(&q_vector->rx.dim, &sample);
+}
+
+static void wx_update_tx_dim_sample(struct wx_q_vector *q_vector)
+{
+	struct dim_sample sample = {};
+
+	dim_update_sample(q_vector->total_events,
+			  q_vector->tx.total_packets,
+			  q_vector->tx.total_bytes,
+			  &sample);
+
+	net_dim(&q_vector->tx.dim, &sample);
+}
+
+static void wx_update_dim_sample(struct wx_q_vector *q_vector)
+{
+	wx_update_rx_dim_sample(q_vector);
+	wx_update_tx_dim_sample(q_vector);
+}
+
 /**
  * wx_poll - NAPI polling RX/TX cleanup routine
  * @napi: napi struct with our devices info in it
@@ -878,6 +909,8 @@ static int wx_poll(struct napi_struct *napi, int budget)
 
 	/* all work done, exit the polling mode */
 	if (likely(napi_complete_done(napi, work_done))) {
+		if (wx->rx_itr_setting == 1)
+			wx_update_dim_sample(q_vector);
 		if (netif_running(wx->netdev))
 			wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
 	}
@@ -1591,6 +1624,62 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(wx_xmit_frame);
 
+static void wx_set_itr(struct wx_q_vector *q_vector)
+{
+	struct wx *wx = q_vector->wx;
+	u32 new_itr;
+
+	/* use the smallest value of new ITR delay calculations */
+	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
+	new_itr <<= 2;
+
+	if (new_itr != q_vector->itr) {
+		/* save the algorithm value here */
+		q_vector->itr = new_itr;
+
+		if (wx->pdev->is_virtfn)
+			wx_write_eitr_vf(q_vector);
+		else
+			wx_write_eitr(q_vector);
+	}
+}
+
+static void wx_rx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct dim_cq_moder rx_moder;
+	struct wx_ring_container *rx;
+	struct wx_q_vector *q_vector;
+
+	rx = container_of(dim, struct wx_ring_container, dim);
+
+	rx_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	rx->itr = rx_moder.usec;
+
+	q_vector = container_of(rx, struct wx_q_vector, rx);
+	wx_set_itr(q_vector);
+
+	dim->state = DIM_START_MEASURE;
+}
+
+static void wx_tx_dim_work(struct work_struct *work)
+{
+	struct dim *dim = container_of(work, struct dim, work);
+	struct dim_cq_moder tx_moder;
+	struct wx_ring_container *tx;
+	struct wx_q_vector *q_vector;
+
+	tx = container_of(dim, struct wx_ring_container, dim);
+
+	tx_moder = net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
+	tx->itr = tx_moder.usec;
+
+	q_vector = container_of(tx, struct wx_q_vector, tx);
+	wx_set_itr(q_vector);
+
+	dim->state = DIM_START_MEASURE;
+}
+
 void wx_napi_enable_all(struct wx *wx)
 {
 	struct wx_q_vector *q_vector;
@@ -1598,6 +1687,11 @@ void wx_napi_enable_all(struct wx *wx)
 
 	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
 		q_vector = wx->q_vector[q_idx];
+
+		INIT_WORK(&q_vector->rx.dim.work, wx_rx_dim_work);
+		INIT_WORK(&q_vector->tx.dim.work, wx_tx_dim_work);
+		q_vector->rx.dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
+		q_vector->tx.dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
 		napi_enable(&q_vector->napi);
 	}
 }
@@ -1611,6 +1705,8 @@ void wx_napi_disable_all(struct wx *wx)
 	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
 		q_vector = wx->q_vector[q_idx];
 		napi_disable(&q_vector->napi);
+		cancel_work_sync(&q_vector->rx.dim.work);
+		cancel_work_sync(&q_vector->tx.dim.work);
 	}
 }
 EXPORT_SYMBOL(wx_napi_disable_all);
@@ -2197,8 +2293,10 @@ irqreturn_t wx_msix_clean_rings(int __always_unused irq, void *data)
 	struct wx_q_vector *q_vector = data;
 
 	/* EIAM disabled interrupts (on this vector) for us */
-	if (q_vector->rx.ring || q_vector->tx.ring)
+	if (q_vector->rx.ring || q_vector->tx.ring) {
 		napi_schedule_irqoff(&q_vector->napi);
+		q_vector->total_events++;
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5c52a1db4024..a9572c8028b8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
+#include <linux/dim.h>
 #include <net/ip.h>
 
 #define WX_NCSI_SUP                             0x8000
@@ -1034,6 +1035,7 @@ struct wx_ring_container {
 	unsigned int total_packets;     /* total packets processed this int */
 	u8 count;                       /* total number of rings in vector */
 	u8 itr;                         /* current ITR setting for ring */
+	struct dim dim;                 /* data for net_dim algorithm */
 };
 struct wx_ring {
 	struct wx_ring *next;           /* pointer to next ring in q_vector */
@@ -1090,6 +1092,8 @@ struct wx_q_vector {
 	struct napi_struct napi;
 	struct rcu_head rcu;    /* to avoid race with update stats on free */
 
+	u16 total_events;       /* number of interrupts processed */
+
 	char name[IFNAMSIZ + 17];
 
 	/* for dynamic allocation of rings associated with this q_vector */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
index 5d48df7a849f..7bcf7e90883b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -10,7 +10,7 @@
 #include "wx_vf.h"
 #include "wx_vf_lib.h"
 
-static void wx_write_eitr_vf(struct wx_q_vector *q_vector)
+void wx_write_eitr_vf(struct wx_q_vector *q_vector)
 {
 	struct wx *wx = q_vector->wx;
 	int v_idx = q_vector->v_idx;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
index 43ea126b79eb..a4bd23c92800 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
@@ -4,6 +4,7 @@
 #ifndef _WX_VF_LIB_H_
 #define _WX_VF_LIB_H_
 
+void wx_write_eitr_vf(struct wx_q_vector *q_vector);
 void wx_configure_msix_vf(struct wx *wx);
 int wx_write_uc_addr_list_vf(struct net_device *netdev);
 void wx_setup_psrtype_vf(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 7e2d9ec38a30..2ca127a7aa77 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -115,7 +115,8 @@ static int ngbe_set_channels(struct net_device *dev,
 
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= wx_get_link_ksettings,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index a4753402660e..86f3c106f1ed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -538,7 +538,8 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
-- 
2.48.1


