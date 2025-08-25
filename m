Return-Path: <netdev+bounces-216639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F8B34B65
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808815E17F9
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20D73009D3;
	Mon, 25 Aug 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/UAov6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9BF293B75
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152158; cv=none; b=hz79l4Q9+ayFOc6BoF9Jir9qYx1Oqbfv3LKc8eVwk8p43HBSh5kHc2J7IETOKlRzKBu3NjL+YokWR09fa5uNdLsAE/616wsBMwVgKGjQ+UjrN/9j4ATlwscLmZ2en0P5hNZZB3qBMwFqM/nEKNlU/A6MW5dr2pMDtsbm8HidYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152158; c=relaxed/simple;
	bh=9lmt/qPzUzFQzSf+G2nmgdmqEKGqReRq3FV7Ja3nZOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWccDJLEBwZmNefkOwDBeCUEJ/PZwSHUgDRsfRaJGfh7f3yMnh7IkK7Q7L6RNxmpmvd5F1k6nBOTkWdePH2K+dq/YYMvc/GVBDHif2wlmjZndxGUQ0Vda74Uagh3E+vKoUY+p/0L5+nMiEmLJXHxj7XBwImR4/AwPHg2lyvoCFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/UAov6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F332AC4CEED;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152157;
	bh=9lmt/qPzUzFQzSf+G2nmgdmqEKGqReRq3FV7Ja3nZOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/UAov6wm6uoKHqde8mTsMAbgc5jtG2aiYFk/u1/X5HX5O7Yp6kwVRLuXOf9RjnAQ
	 FLfY7qosnDHmn8XfbM5d1OTNMo175lDJ2CXIzX29G66B2lHmox4bllam95mYSbGzQk
	 HfrmrrHgkB7EfSoFLHD918Be+RVfpTMQtIp8d4hn1lwaonscD8g2Ypz7lsard1afZ/
	 PMqcm3bDa+xmpTnHqlS6KmZFzMHj3LPpQYqvdqMBRzLAIyzV4afaZ1S0C70tMQNM38
	 ZyX0QoSHqOHUgug49Nrc9OMsUT/DYqv5Q2TF5VMbPUbIH3hJdn+eV6BHyoeAq/h8F2
	 SeWnmEg4+XhYA==
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
Subject: [PATCH net-next v2 6/6] eth: fbnic: Add pause stats support
Date: Mon, 25 Aug 2025 13:02:06 -0700
Message-ID: <20250825200206.2357713-7-kuba@kernel.org>
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

Add support to read pause stats for fbnic. Unlike FEC and PCS stats,
pause stats won't wrap, do not fetch them under the service task. Since,
they are exclusively accessed via the ethtool API, don't include them in
fbnic_get_hw_stats().

]# ethtool -I -a eth0
Pause parameters for eth0:
Autonegotiate:	on
RX:		off
TX:		off
Statistics:
  tx_pause_frames: 0
  rx_pause_frames: 0

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |  4 ++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.h    |  7 +++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h     |  2 ++
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 17 +++++++++++++++++
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c    |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c     | 11 +++++++++++
 6 files changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 69cb73ca8bca..e2fffe1597e9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -844,6 +844,10 @@ enum {
 #define FBNIC_CSR_END_SIG		0x1184e /* CSR section delimiter */
 
 #define FBNIC_CSR_START_MAC_STAT	0x11a00
+#define FBNIC_MAC_STAT_RX_XOFF_STB_L	0x11a00		/* 0x46800 */
+#define FBNIC_MAC_STAT_RX_XOFF_STB_H	0x11a01		/* 0x46804 */
+#define FBNIC_MAC_STAT_TX_XOFF_STB_L	0x11a04		/* 0x46810 */
+#define FBNIC_MAC_STAT_TX_XOFF_STB_H	0x11a05		/* 0x46814 */
 #define FBNIC_MAC_STAT_RX_BYTE_COUNT_L	0x11a08		/* 0x46820 */
 #define FBNIC_MAC_STAT_RX_BYTE_COUNT_H	0x11a09		/* 0x46824 */
 #define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L	0x11a0a		/* 0x46828 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index baffae1868a6..aa3f429a9aed 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -50,6 +50,12 @@ struct fbnic_rmon_stats {
 	struct fbnic_stat_counter hist_tx[ETHTOOL_RMON_HIST_MAX];
 };
 
+/* Note: not updated by fbnic_get_hw_stats() */
+struct fbnic_pause_stats {
+	struct fbnic_stat_counter tx_pause_frames;
+	struct fbnic_stat_counter rx_pause_frames;
+};
+
 struct fbnic_eth_mac_stats {
 	struct fbnic_stat_counter FramesTransmittedOK;
 	struct fbnic_stat_counter FramesReceivedOK;
@@ -73,6 +79,7 @@ struct fbnic_phy_stats {
 
 struct fbnic_mac_stats {
 	struct fbnic_eth_mac_stats eth_mac;
+	struct fbnic_pause_stats pause;
 	struct fbnic_eth_ctrl_stats eth_ctrl;
 	struct fbnic_rmon_stats rmon;
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 92dd6efb920a..ede5ff0dae22 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -85,6 +85,8 @@ struct fbnic_mac {
 			      struct fbnic_pcs_stats *pcs_stats);
 	void (*get_eth_mac_stats)(struct fbnic_dev *fbd, bool reset,
 				  struct fbnic_eth_mac_stats *mac_stats);
+	void (*get_pause_stats)(struct fbnic_dev *fbd, bool reset,
+				struct fbnic_pause_stats *pause_stats);
 	void (*get_eth_ctrl_stats)(struct fbnic_dev *fbd, bool reset,
 				   struct fbnic_eth_ctrl_stats *ctrl_stats);
 	void (*get_rmon_stats)(struct fbnic_dev *fbd, bool reset,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 4194b30f1074..b4ff98ee2051 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1641,6 +1641,22 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
 		*stat = counter->value;
 }
 
+static void
+fbnic_get_pause_stats(struct net_device *netdev,
+		      struct ethtool_pause_stats *pause_stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_mac_stats *mac_stats;
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	mac_stats = &fbd->hw_stats.mac;
+
+	fbd->mac->get_pause_stats(fbd, false, &mac_stats->pause);
+
+	pause_stats->tx_pause_frames = mac_stats->pause.tx_pause_frames.value;
+	pause_stats->rx_pause_frames = mac_stats->pause.rx_pause_frames.value;
+}
+
 static void
 fbnic_get_fec_stats(struct net_device *netdev,
 		    struct ethtool_fec_stats *fec_stats)
@@ -1801,6 +1817,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.set_coalesce			= fbnic_set_coalesce,
 	.get_ringparam			= fbnic_get_ringparam,
 	.set_ringparam			= fbnic_set_ringparam,
+	.get_pause_stats		= fbnic_get_pause_stats,
 	.get_pauseparam			= fbnic_phylink_get_pauseparam,
 	.set_pauseparam			= fbnic_phylink_set_pauseparam,
 	.get_strings			= fbnic_get_strings,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 9e7becba7386..8b9b2076beec 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -536,6 +536,7 @@ static void fbnic_reset_hw_mac_stats(struct fbnic_dev *fbd,
 	const struct fbnic_mac *mac = fbd->mac;
 
 	mac->get_eth_mac_stats(fbd, true, &mac_stats->eth_mac);
+	mac->get_pause_stats(fbd, true, &mac_stats->pause);
 	mac->get_eth_ctrl_stats(fbd, true, &mac_stats->eth_ctrl);
 	mac->get_rmon_stats(fbd, true, &mac_stats->rmon);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index ffdaebd4002a..8f998d26b9a3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -709,6 +709,16 @@ fbnic_mac_get_eth_mac_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_BROADCAST);
 }
 
+static void
+fbnic_mac_get_pause_stats(struct fbnic_dev *fbd, bool reset,
+			  struct fbnic_pause_stats *pause_stats)
+{
+	fbnic_mac_stat_rd64(fbd, reset, pause_stats->tx_pause_frames,
+			    MAC_STAT_TX_XOFF_STB);
+	fbnic_mac_stat_rd64(fbd, reset, pause_stats->rx_pause_frames,
+			    MAC_STAT_RX_XOFF_STB);
+}
+
 static void
 fbnic_mac_get_eth_ctrl_stats(struct fbnic_dev *fbd, bool reset,
 			     struct fbnic_eth_ctrl_stats *ctrl_stats)
@@ -856,6 +866,7 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.get_fec_stats = fbnic_mac_get_fec_stats,
 	.get_pcs_stats = fbnic_mac_get_pcs_stats,
 	.get_eth_mac_stats = fbnic_mac_get_eth_mac_stats,
+	.get_pause_stats = fbnic_mac_get_pause_stats,
 	.get_eth_ctrl_stats = fbnic_mac_get_eth_ctrl_stats,
 	.get_rmon_stats = fbnic_mac_get_rmon_stats,
 	.link_down = fbnic_mac_link_down_asic,
-- 
2.51.0


