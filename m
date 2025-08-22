Return-Path: <netdev+bounces-216107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D956B320C1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB4E62831F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6223C31281B;
	Fri, 22 Aug 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DE/uIM+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FC312815
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881268; cv=none; b=mgJjyVJEVsgljiBDjv5ZwM6Wk6ow0SSVG5LDP679VrD6PlevOyPoWrYSSGp1ejA1zoSVQ66tLnhmQFYsg6JRCpB64E+SCrd5DQJe4s45CY//DGv8GMIyDMIEpKgklJ0w7sCZEa0IcRCnPGMGpAuBNWM8JALwzpR4TtkkNrC3MM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881268; c=relaxed/simple;
	bh=ogRNXuyA7/UWBwJCnVbErmx1TdIAN/Oj6nrxwUz/z4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+7UoUAAz5Dva+gP38TYq3hl0sgFcGdWivFV0zBf7UhdmnIYpZ9+HxbLTm9qguaWbSFb1dODJHSth00oy49I1FkwOJYEgGROFO4dCX7z3qle3dToY8IW2sXdDFZ0UxFmqCGz5mKoBKezNeC1ByBaYk6hSyAcsD+xgYmVspw9sQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DE/uIM+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A106C4CEED;
	Fri, 22 Aug 2025 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881267;
	bh=ogRNXuyA7/UWBwJCnVbErmx1TdIAN/Oj6nrxwUz/z4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DE/uIM+tirDY+Nbz2L1C6/00AYGfhAZ3oaTmfOUhLhQnz5u2TTN6PH0GGSxjXsov/
	 QEailDgkuEAjCYp7Qo6vF/CpAOjUFp5NvnIn0jobvp6wpnnJYhgIbWrD7YIHiR7bv/
	 BGJKLALWLZRj8QJC43oZPJaCjbYvKqqvIv+SPRMQm2mgsCXJN5Zab0EWtE90loZxw/
	 ZnBZD0MhzilYZDjJl1TIUDAnxMr8juI6a3YL7ej3lX06SO0eQdNU30STD/JtcFyFj4
	 Q+CM1+Vjr4ysM77wUXPSedyMNDKpy9LJWMe16jx7phXCdymW26n9VjUsZ4iamqF/1b
	 RRBv7qsVfADYw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/6] eth: fbnic: Add pause stats support
Date: Fri, 22 Aug 2025 09:47:31 -0700
Message-ID: <20250822164731.1461754-7-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822164731.1461754-1-kuba@kernel.org>
References: <20250822164731.1461754-1-kuba@kernel.org>
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
index 358eb8cc302a..f595863e7ba2 100644
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
2.50.1


