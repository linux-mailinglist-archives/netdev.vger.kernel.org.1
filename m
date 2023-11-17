Return-Path: <netdev+bounces-48664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F77EF27A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049ED1C20441
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33230674;
	Fri, 17 Nov 2023 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6GogXYj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0817726
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 12:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688B6C433C9;
	Fri, 17 Nov 2023 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700223486;
	bh=lpWLTDXadMFB1ljUCDUxsx9qfZtjOHFn7HN2op9Hkwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6GogXYjcn1Frj2lwUchKWgxvK5RDTx7Mgg2j0upL+IZ728HKrcCN3IDC/p5JAlTI
	 AF5dqSYAJG9c6KMC+7s0xIzn23/hpA6wajWhuQIJG8CcV0Ly0seWW5GipTJmJ3H3Ff
	 zpvig7jIcuht85I/gVqczDQj4A98MMGS9iaueHo9TLOdBPMIVLQSY80dPAcbT5Yhyn
	 EzNZbfRTEKx2jwOkxwtnUT3qbFkUKKyL/oVVkdKe0uS5nPWL5mt2Bjif1YSzo6VJ7r
	 abA/Jeo4dp7nbT0VA3cDKswDPcqPoA+CV3+zqCL+goz/2O5L59k48quyjM5g/8gDrM
	 zKGWPAIC6hIMg==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	andrew@lunn.ch,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 1/4] net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
Date: Fri, 17 Nov 2023 14:17:52 +0200
Message-Id: <20231117121755.104547-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117121755.104547-1-rogerq@kernel.org>
References: <20231117121755.104547-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gets 'ethtool -S eth0 --groups eth-mac' command to work.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index c51e2af91f69..b9e1d568604b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -662,6 +662,31 @@ static void am65_cpsw_get_ethtool_stats(struct net_device *ndev,
 					hw_stats[i].offset);
 }
 
+static void am65_cpsw_get_eth_mac_stats(struct net_device *ndev,
+					struct ethtool_eth_mac_stats *s)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_stats_regs __iomem *stats;
+
+	stats = port->stat_base;
+
+	s->FramesTransmittedOK = readl_relaxed(&stats->tx_good_frames);
+	s->SingleCollisionFrames = readl_relaxed(&stats->tx_single_coll_frames);
+	s->MultipleCollisionFrames = readl_relaxed(&stats->tx_mult_coll_frames);
+	s->FramesReceivedOK = readl_relaxed(&stats->rx_good_frames);
+	s->FrameCheckSequenceErrors = readl_relaxed(&stats->rx_crc_errors);
+	s->AlignmentErrors = readl_relaxed(&stats->rx_align_code_errors);
+	s->OctetsTransmittedOK = readl_relaxed(&stats->tx_octets);
+	s->FramesWithDeferredXmissions = readl_relaxed(&stats->tx_deferred_frames);
+	s->LateCollisions = readl_relaxed(&stats->tx_late_collisions);
+	s->CarrierSenseErrors = readl_relaxed(&stats->tx_carrier_sense_errors);
+	s->OctetsReceivedOK = readl_relaxed(&stats->rx_octets);
+	s->MulticastFramesXmittedOK = readl_relaxed(&stats->tx_multicast_frames);
+	s->BroadcastFramesXmittedOK = readl_relaxed(&stats->tx_broadcast_frames);
+	s->MulticastFramesReceivedOK = readl_relaxed(&stats->rx_multicast_frames);
+	s->BroadcastFramesReceivedOK = readl_relaxed(&stats->rx_broadcast_frames);
+};
+
 static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 					 struct ethtool_ts_info *info)
 {
@@ -729,6 +754,7 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_sset_count		= am65_cpsw_get_sset_count,
 	.get_strings		= am65_cpsw_get_strings,
 	.get_ethtool_stats	= am65_cpsw_get_ethtool_stats,
+	.get_eth_mac_stats	= am65_cpsw_get_eth_mac_stats,
 	.get_ts_info		= am65_cpsw_get_ethtool_ts_info,
 	.get_priv_flags		= am65_cpsw_get_ethtool_priv_flags,
 	.set_priv_flags		= am65_cpsw_set_ethtool_priv_flags,
-- 
2.34.1


