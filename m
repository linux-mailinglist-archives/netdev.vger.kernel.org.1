Return-Path: <netdev+bounces-212717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F492B21A65
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5C1A25BD9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2492D6E5D;
	Tue, 12 Aug 2025 01:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FD212B05
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963510; cv=none; b=aWX1da+VVj8d7/FM7Lf6M8eUoW11EHRt0ukL+PwVGU3legOw5oAPY0pOm8KYAnJxTuvidWrLSxR6k7vPLAbts/q1Q12vkMYzDx/jWPej8GcxLj6St+LnT51SX+F9ZIueBpkKzxunDG55hTV2Id6Se0gxMt40PF9IuMLmjhxqkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963510; c=relaxed/simple;
	bh=iZeB9CeGhQ1imIyry5AakNcu4BDJu+p7nt83yb5uoZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRsx3lMWfhxQii2jUKQTQs0/itUmB+deMAn6xmM7ahMfO2qcIbYB34+7K2imaA91+17fE/lfC1gLG90S1xPf2zVDdP4v4pGmwbfI/baMAPLzN+ft2FKSN/SFNDBNQ3sRCUnyqx79Y0nqEdt00MK1NVis9QLbi/VY7GmYGjno5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz18t1754963448t70f15191
X-QQ-Originating-IP: orxMMkrEAEkIS7b9FVHqfSBOBd+HfDZS4fA3Eu6AKpk=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.182.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 09:50:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12057237461175496670
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
Subject: [PATCH net-next v4 4/4] net: wangxun: support to use adaptive RX/TX coalescing
Date: Tue, 12 Aug 2025 09:50:23 +0800
Message-Id: <20250812015023.12876-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250812015023.12876-1-jiawenwu@trustnetic.com>
References: <20250812015023.12876-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OV5xRVowR16SQYQeCgy7Igo0mp/QTSM9ySsaFq8QTA4pN/886eqsnuvA
	RExifmQoZTkp0HTFFgOzx2M/4aqasoeE9uuXOvWVZar10QYPhuLVon+xwbn/fpy+WQ5pAR1
	ePjNQjgI/sLeGYOV3vnTNLWJqyYZ5tSHFtKGPwYEwcjMCm6oqVdUFsdS9nMCUjj1CjvDHcK
	mzS2seaJLdzZFaPglxqJ5IaEf7nn/45uWHsPlfyNBxcpYAWX6kK2Bd3g9HWA2NAiMMPgfNI
	75NptgA54Z+qAhM09O67py8FT9gTJQ9uXOtApejk8ZzyNidRHokJJCK+hRp4HIY/Otrn8+q
	mLBTP0rc+LTv1RZYkRjNWq2ZEubFPOGFBSQ0sG9zOTEW3QFCEzfTR1KDNKEQIEMjCH4A19t
	Vw16onc7TYLPHPPmfN2OW5kMWSjHg/x+J/tuqiHwti5vQBTO6xMvhVoERith1KdVg/uTm5X
	y5f84Ns8pA8QFrenLGrYIncq3FPBftIhBqh5lIAIPqhb4+uV0JrvitINP0P/XSL9IjWEs17
	zx9jZ2qJH5S+b+B/19NIbD9FLGY/aZVCjfkAU+H2F95VU0pZDzhk9bKDJX20k7ks6wwDQwk
	Cbxdf7HLC/CjbZ4uH+yVhb34E3D8UFGa6tfedaEfpOg8TqUpaOQkFunE4j4pckQXjUmet4K
	k4TMCriTQYHQa7b5LS/5dti5n1pJnqfK7RLZN07b46hPw4xTjLylehnROqMEJvbcMRX2620
	2DRmJvdSOlf2p9nsFRNNpixr+bNg4jf2NiwvQ+lfJH5qo84KK1NEGk3ZDE5mB7mXwi1gE8u
	1fw4DsMs8KgJZ9ZVtLYjDx460MO9IpRT88FKR/ZE/Vx/Zu2RQvuCTqOO1R99F81fmUh84dp
	MhnW0bZ/Og2csddjSyurhqjDJNTvTdShQwxL1c6OmkxROy3KfJmLQbugYhn9MtjnxsdN+RB
	S469Qe+vuqcLPz+BsjjJgd25y06z/JoGKsLw5vU7bg1gkIqfg4vwBBorbmwiahAdhbQ+3sZ
	N3JJlXpFvc4o+7N55PqFuA2VZvsOowtEKd7nj6KaDKTmXaSFsW2AyOh9BQcH0sI1ul12iKu
	Uwc04Tw4yJafmTGfW50gBg=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Support to turn on/off adaptive RX/TX coalesce. When adaptive coalesce
is on, use DIM algorithm for a dynamic interrupt moderation.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/Kconfig          |   1 +
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  26 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 103 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   5 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    |   2 +-
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |   1 +
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |   3 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |   1 +
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |   1 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |   3 +-
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |   1 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |   1 +
 12 files changed, 141 insertions(+), 7 deletions(-)

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
index c7b3f5087b66..9572b9f28e59 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -303,6 +303,11 @@ int wx_get_coalesce(struct net_device *netdev,
 	else
 		ec->rx_coalesce_usecs = wx->rx_itr_setting >> 2;
 
+	if (wx->adaptive_itr) {
+		ec->use_adaptive_rx_coalesce = 1;
+		ec->use_adaptive_tx_coalesce = 1;
+	}
+
 	/* if in mixed tx/rx queues per vector mode, report only rx settings */
 	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)
 		return 0;
@@ -363,19 +368,34 @@ int wx_set_coalesce(struct net_device *netdev,
 	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
 		return -EINVAL;
 
+	if (ec->use_adaptive_rx_coalesce) {
+		wx->adaptive_itr = true;
+		wx->rx_itr_setting = 1;
+		wx->tx_itr_setting = 1;
+		return 0;
+	}
+
 	if (ec->rx_coalesce_usecs > 1)
 		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
 	else
 		wx->rx_itr_setting = ec->rx_coalesce_usecs;
 
-	if (wx->rx_itr_setting != 1)
-		rx_itr_param = wx->rx_itr_setting;
-
 	if (ec->tx_coalesce_usecs > 1)
 		wx->tx_itr_setting = ec->tx_coalesce_usecs << 2;
 	else
 		wx->tx_itr_setting = ec->tx_coalesce_usecs;
 
+	if (wx->adaptive_itr) {
+		wx->adaptive_itr = false;
+		wx->rx_itr_setting = rx_itr_param;
+		wx->tx_itr_setting = tx_itr_param;
+	} else if (wx->rx_itr_setting == 1 || wx->tx_itr_setting == 1) {
+		wx->adaptive_itr = true;
+	}
+
+	if (wx->rx_itr_setting != 1)
+		rx_itr_param = wx->rx_itr_setting;
+
 	if (wx->tx_itr_setting != 1)
 		tx_itr_param = wx->tx_itr_setting;
 
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 723785ef87bb..d88e725014d6 100644
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
+		if (wx->adaptive_itr)
+			wx_update_dim_sample(q_vector);
 		if (netif_running(wx->netdev))
 			wx_intr_enable(wx, WX_INTR_Q(q_vector->v_idx));
 	}
@@ -1591,6 +1624,65 @@ netdev_tx_t wx_xmit_frame(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(wx_xmit_frame);
 
+static void wx_set_itr(struct wx_q_vector *q_vector)
+{
+	struct wx *wx = q_vector->wx;
+	u32 new_itr;
+
+	if (!wx->adaptive_itr)
+		return;
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
@@ -1598,6 +1690,11 @@ void wx_napi_enable_all(struct wx *wx)
 
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
@@ -1611,6 +1708,8 @@ void wx_napi_disable_all(struct wx *wx)
 	for (q_idx = 0; q_idx < wx->num_q_vectors; q_idx++) {
 		q_vector = wx->q_vector[q_idx];
 		napi_disable(&q_vector->napi);
+		cancel_work_sync(&q_vector->rx.dim.work);
+		cancel_work_sync(&q_vector->tx.dim.work);
 	}
 }
 EXPORT_SYMBOL(wx_napi_disable_all);
@@ -2197,8 +2296,10 @@ irqreturn_t wx_msix_clean_rings(int __always_unused irq, void *data)
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
index 9d5d10f9e410..ec63e7ec8b24 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
+#include <linux/dim.h>
 #include <net/ip.h>
 
 #define WX_NCSI_SUP                             0x8000
@@ -1033,6 +1034,7 @@ struct wx_ring_container {
 	unsigned int total_packets;     /* total packets processed this int */
 	u8 count;                       /* total number of rings in vector */
 	u8 itr;                         /* current ITR setting for ring */
+	struct dim dim;                 /* data for net_dim algorithm */
 };
 struct wx_ring {
 	struct wx_ring *next;           /* pointer to next ring in q_vector */
@@ -1089,6 +1091,8 @@ struct wx_q_vector {
 	struct napi_struct napi;
 	struct rcu_head rcu;    /* to avoid race with update stats on free */
 
+	u16 total_events;       /* number of interrupts processed */
+
 	char name[IFNAMSIZ + 17];
 
 	/* for dynamic allocation of rings associated with this q_vector */
@@ -1268,6 +1272,7 @@ struct wx {
 	int num_rx_queues;
 	u16 rx_itr_setting;
 	u16 rx_work_limit;
+	bool adaptive_itr;
 
 	int num_q_vectors;      /* current number of q_vectors for device */
 	int max_q_vectors;      /* upper limit of q_vectors for device */
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
index 7e2d9ec38a30..4363bab33496 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -115,7 +115,8 @@ static int ngbe_set_channels(struct net_device *dev,
 
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= wx_get_link_ksettings,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 3fff73ae44af..58488e138beb 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -119,6 +119,7 @@ static int ngbe_sw_init(struct wx *wx)
 						   num_online_cpus());
 	wx->rss_enabled = true;
 
+	wx->adaptive_itr = false;
 	wx->rx_itr_setting = WX_7K_ITR;
 	wx->tx_itr_setting = WX_7K_ITR;
 
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index c1246ab5239c..5f9ddb5e5403 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -100,6 +100,7 @@ static int ngbevf_sw_init(struct wx *wx)
 	wx->mac.max_tx_queues = NGBEVF_MAX_TX_QUEUES;
 	wx->mac.max_rx_queues = NGBEVF_MAX_RX_QUEUES;
 	/* Enable dynamic interrupt throttling rates */
+	wx->adaptive_itr = true;
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
 	/* set default ring sizes */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index a4753402660e..b496ec502fed 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -538,7 +538,8 @@ static int txgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
-				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
+				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE,
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
 	.get_link		= ethtool_op_get_link,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a5867f3c93fc..c4c4d70d8466 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -401,6 +401,7 @@ static int txgbe_sw_init(struct wx *wx)
 	set_bit(WX_FLAG_MULTI_64_FUNC, wx->flags);
 
 	/* enable itr by default in dynamic mode */
+	wx->adaptive_itr = true;
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
 
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index ebfce3cf753e..3755bb399f71 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -144,6 +144,7 @@ static int txgbevf_sw_init(struct wx *wx)
 	wx->mac.max_tx_queues = TXGBEVF_MAX_TX_QUEUES;
 	wx->mac.max_rx_queues = TXGBEVF_MAX_RX_QUEUES;
 	/* Enable dynamic interrupt throttling rates */
+	wx->adaptive_itr = true;
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
 	/* set default ring sizes */
-- 
2.48.1


