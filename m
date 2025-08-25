Return-Path: <netdev+bounces-216636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A71B34B6B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8EC241F44
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79069298CDC;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5LmbZ1h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA0293B75
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152156; cv=none; b=DPeMEcLaCMTyWOIYX2iDRWlmyohyuOPKxE96voDN6FydnvMytpES4+kcOryJuXrck4KeWIjEzdzTmkOzElMFAZ49/W1J018364YgLrZ3E4SnRCZLXj0hj+0O/HfcfQCG+QRCVyU2di0vEfg4P5DFQIWbLKvWQ0LAd//n6P7eT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152156; c=relaxed/simple;
	bh=n7mku523LKgs9KKGesF9tJnhZLDczMbwuiQf1KNgoPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WczV0ud3tjjIlCZAPKRcDShb7Es7+Zxjm6Apd/+j7FKKyHmBSkmupIeSW7vi/ZnXqwrQ44XGXl5edC5Woxm4QRfUPVfg6gzkgKqNyfEAvWwPJyW+R0oxVNECpLXtnGA1dp3UOrGARv40NmWltkqmO2ZWJfnm/+OLWcXssN1o898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5LmbZ1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F37C113D0;
	Mon, 25 Aug 2025 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152154;
	bh=n7mku523LKgs9KKGesF9tJnhZLDczMbwuiQf1KNgoPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5LmbZ1hfF4yLBaLob4+O88Cjq4FtfKZgrSK9UO3DZ3uyrXQ0C4oHUaisPs99xuh9
	 GEqXDMa3oPeYEkPN+OrKYeMd6kWSQ6RsQLL+kfzMQMeOhGYob+6WEOGU+75en4OW7Q
	 DrrGxEvE9ffzK5M0frdCtPbaoGcqKlni+M2GNCwzzd7wd5KMySG3M/Ya+kJj46rjSk
	 RHz1lCKAOS2SsqRTfP54rH3QrxkSCfDK2YbLwfglkzN9Nqdl4a+16YWF09c6MaL9RH
	 YoQ8pmYRqUapFx7FHCtsvGhnHhWFEcLYha25eopNvqXWsr+RMc0MkPGH7iTFUp12ll
	 AiRkXAbqrd1Ng==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/6] eth: fbnic: Move hw_stats_lock out of fbnic_dev
Date: Mon, 25 Aug 2025 13:02:01 -0700
Message-ID: <20250825200206.2357713-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825200206.2357713-1-kuba@kernel.org>
References: <20250825200206.2357713-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <mohsin.bashr@gmail.com>

Move hw_stats_lock out of fbnic_dev to a more appropriate struct
fbnic_hw_stats since the only use of this lock is to protect access to
the hardware stats. While at it, enclose the lock and stats
initialization in a single init call.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 ---
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  5 ++++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  4 ++--
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 23 ++++++++++++-------
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 12 +++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  3 +--
 6 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index c376e06880c9..311c7dda911a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -84,9 +84,6 @@ struct fbnic_dev {
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
 
-	/* Lock protecting access to hw_stats */
-	spinlock_t hw_stats_lock;
-
 	struct fbnic_fw_log fw_log;
 };
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index 4fe239717497..2fc25074a5e6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -5,6 +5,7 @@
 #define _FBNIC_HW_STATS_H_
 
 #include <linux/ethtool.h>
+#include <linux/spinlock.h>
 
 #include "fbnic_csr.h"
 
@@ -122,11 +123,15 @@ struct fbnic_hw_stats {
 	struct fbnic_rxb_stats rxb;
 	struct fbnic_hw_q_stats hw_q[FBNIC_MAX_QUEUES];
 	struct fbnic_pcie_stats pcie;
+
+	/* Lock protecting the access to hw stats */
+	spinlock_t lock;
 };
 
 u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset);
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd);
+void fbnic_init_hw_stats(struct fbnic_dev *fbd);
 void fbnic_get_hw_q_stats(struct fbnic_dev *fbd,
 			  struct fbnic_hw_q_stats *hw_q);
 void fbnic_get_hw_stats32(struct fbnic_dev *fbd);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index a758f510f886..e6a60d7ea864 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -518,7 +518,7 @@ static void fbnic_get_ethtool_stats(struct net_device *dev,
 
 	fbnic_get_hw_stats(fbn->fbd);
 
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	fbnic_report_hw_stats(fbnic_gstrings_hw_stats, &fbd->hw_stats,
 			      FBNIC_HW_FIXED_STATS_LEN, &data);
 
@@ -555,7 +555,7 @@ static void fbnic_get_ethtool_stats(struct net_device *dev,
 		fbnic_report_hw_stats(fbnic_gstrings_hw_q_stats, hw_q,
 				      FBNIC_HW_Q_STATS_LEN, &data);
 	}
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 
 	for (i = 0; i < FBNIC_MAX_XDPQS; i++)
 		fbnic_get_xdp_queue_stats(fbn->tx[i + FBNIC_MAX_TXQS], &data);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 4223d8100e64..77182922f018 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -421,9 +421,9 @@ static void fbnic_get_hw_rxq_stats32(struct fbnic_dev *fbd,
 void fbnic_get_hw_q_stats(struct fbnic_dev *fbd,
 			  struct fbnic_hw_q_stats *hw_q)
 {
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	fbnic_get_hw_rxq_stats32(fbd, hw_q);
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 static void fbnic_reset_pcie_stats_asic(struct fbnic_dev *fbd,
@@ -512,14 +512,21 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	fbnic_reset_tmi_stats(fbd, &fbd->hw_stats.tmi);
 	fbnic_reset_tti_stats(fbd, &fbd->hw_stats.tti);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
 	fbnic_reset_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
+}
+
+void fbnic_init_hw_stats(struct fbnic_dev *fbd)
+{
+	spin_lock_init(&fbd->hw_stats.lock);
+
+	fbnic_reset_hw_stats(fbd);
 }
 
 static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
@@ -533,19 +540,19 @@ static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 
 void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	__fbnic_get_hw_stats32(fbd);
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 void fbnic_get_hw_stats(struct fbnic_dev *fbd)
 {
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	__fbnic_get_hw_stats32(fbd);
 
 	fbnic_get_tmi_stats(fbd, &fbd->hw_stats.tmi);
 	fbnic_get_tti_stats(fbd, &fbd->hw_stats.tti);
 	fbnic_get_rxb_stats(fbd, &fbd->hw_stats.rxb);
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index b8b684ad376b..98602bc3b39f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -424,12 +424,12 @@ static void fbnic_get_stats64(struct net_device *dev,
 	tx_dropped = stats->dropped;
 
 	/* Record drops from Tx HW Datapath */
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	tx_dropped += fbd->hw_stats.tmi.drop.frames.value +
 		      fbd->hw_stats.tti.cm_drop.frames.value +
 		      fbd->hw_stats.tti.frame_drop.frames.value +
 		      fbd->hw_stats.tti.tbi_drop.frames.value;
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 
 	stats64->tx_bytes = tx_bytes;
 	stats64->tx_packets = tx_packets;
@@ -460,7 +460,7 @@ static void fbnic_get_stats64(struct net_device *dev,
 	rx_packets = stats->packets;
 	rx_dropped = stats->dropped;
 
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	/* Record drops for the host FIFOs.
 	 * 4: network to Host,	6: BMC to Host
 	 * Exclude the BMC and MC FIFOs as those stats may contain drops
@@ -480,7 +480,7 @@ static void fbnic_get_stats64(struct net_device *dev,
 		/* Report packets with errors */
 		rx_errors += fbd->hw_stats.hw_q[i].rde_pkt_err.value;
 	}
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 
 	stats64->rx_bytes = rx_bytes;
 	stats64->rx_packets = rx_packets;
@@ -608,12 +608,12 @@ static void fbnic_get_queue_stats_rx(struct net_device *dev, int idx,
 
 	fbnic_get_hw_q_stats(fbd, fbd->hw_stats.hw_q);
 
-	spin_lock(&fbd->hw_stats_lock);
+	spin_lock(&fbd->hw_stats.lock);
 	rx->hw_drop_overruns = fbd->hw_stats.hw_q[idx].rde_pkt_cq_drop.value +
 			       fbd->hw_stats.hw_q[idx].rde_pkt_bdq_drop.value;
 	rx->hw_drops = fbd->hw_stats.hw_q[idx].rde_pkt_err.value +
 		       rx->hw_drop_overruns;
-	spin_unlock(&fbd->hw_stats_lock);
+	spin_unlock(&fbd->hw_stats.lock);
 }
 
 static void fbnic_get_queue_stats_tx(struct net_device *dev, int idx,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index b70e4cadb37b..8190f49e1426 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -304,10 +304,9 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	fbnic_devlink_register(fbd);
 	fbnic_dbg_fbd_init(fbd);
-	spin_lock_init(&fbd->hw_stats_lock);
 
 	/* Capture snapshot of hardware stats so netdev can calculate delta */
-	fbnic_reset_hw_stats(fbd);
+	fbnic_init_hw_stats(fbd);
 
 	fbnic_hwmon_register(fbd);
 
-- 
2.51.0


