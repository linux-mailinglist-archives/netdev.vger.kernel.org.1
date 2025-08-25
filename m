Return-Path: <netdev+bounces-216638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB382B34B71
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D087B64CF
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21DF3009DB;
	Mon, 25 Aug 2025 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbr2lJks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94D28F948
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152158; cv=none; b=aKw+pKlW1D+TOomHkplylFU8uYz3ZqSf0YqtaxZ01Vi4Vwl8xMvLFahBvHKAEeQ61tFANy0WsV95PRkA/K2qydsvvs76U2/mtJRSjMV7YycTmPhOhvJRiKQEax85cEwGCvoo5vQWQdSPTzEDmJNkY355mZ90HlzRXQVJlMUWfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152158; c=relaxed/simple;
	bh=CclDnxXj+i6iCU75eOrk48/7wNeD+N6V33l0fu2rPVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtT++pBl1CpgHK/9ZeKrXpwR1y6eFol1ogvZGIgrd7HTpqamBtV39SFZSrXB5+XNBIa2uSw4pM8oZ8tmMAKy4Vyypmw1MhPvEiifieupB8z59ss8N6YOYTS/0zv8gpHdph5ZsNKMqnHqDetRJ0JtYa+pc/1hAH5rEzzdCWr6AU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbr2lJks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C7AC113D0;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152156;
	bh=CclDnxXj+i6iCU75eOrk48/7wNeD+N6V33l0fu2rPVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbr2lJks0iWoHuQe1Qyyd9cQ5qpZ1ydcOBWWYliVz6ohI/X0dg/F9FijE9mtMaucq
	 PPz/W07+cRsejLevrWlsfDv8At7Qnm6r48ps759Km8umMjOuUQb5hEyxxUogEIK3wh
	 AcNKJjeuzYJU6Rvh7wb3CXLBnunmsmHLGH/yK6Q6LuXFhUcKQCCAZMWi2e09BesNpS
	 qe4fB9CFEpjVv1wFU1WprLOyNcMyxoCg+NQvpoJ72ewO8LZIeL+xCqdUWGv7r9dqAh
	 EH4k0Y2fmYoyYRQdBuSD63PWLk/vUXVa3BywQLq0Hh8gA7gl8AsUhcE8L3t22MxmCB
	 9psAVLPGxkd8Q==
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
Subject: [PATCH net-next v2 5/6] eth: fbnic: Read PHY stats via the ethtool API
Date: Mon, 25 Aug 2025 13:02:05 -0700
Message-ID: <20250825200206.2357713-6-kuba@kernel.org>
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

Provide support to read PHY stats (FEC and PCS) via the ethtool API.

]# ethtool -I --show-fec eth0
FEC parameters for eth0:
Supported/Configured FEC encodings: RS
Active FEC encoding: RS
Statistics:
  corrected_blocks: 0
  uncorrectable_blocks: 0

]# ethtool -S eth0 --groups eth-phy
Standard stats for eth0:
eth-phy-SymbolErrorDuringCarrier: 0

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index e6a60d7ea864..4194b30f1074 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1641,6 +1641,46 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
 		*stat = counter->value;
 }
 
+static void
+fbnic_get_fec_stats(struct net_device *netdev,
+		    struct ethtool_fec_stats *fec_stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_phy_stats *phy_stats;
+	struct fbnic_dev *fbd = fbn->fbd;
+
+	fbnic_get_hw_stats32(fbd);
+	phy_stats = &fbd->hw_stats.phy;
+
+	spin_lock(&fbd->hw_stats.lock);
+	fec_stats->corrected_blocks.total =
+		phy_stats->fec.corrected_blocks.value;
+	fec_stats->uncorrectable_blocks.total =
+		phy_stats->fec.uncorrectable_blocks.value;
+	spin_unlock(&fbd->hw_stats.lock);
+}
+
+static void
+fbnic_get_eth_phy_stats(struct net_device *netdev,
+			struct ethtool_eth_phy_stats *eth_phy_stats)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	struct fbnic_phy_stats *phy_stats;
+	struct fbnic_dev *fbd = fbn->fbd;
+	u64 total = 0;
+	int i;
+
+	fbnic_get_hw_stats32(fbd);
+	phy_stats = &fbd->hw_stats.phy;
+
+	spin_lock(&fbd->hw_stats.lock);
+	for (i = 0; i < FBNIC_PCS_MAX_LANES; i++)
+		total += phy_stats->pcs.SymbolErrorDuringCarrier.lanes[i].value;
+
+	eth_phy_stats->SymbolErrorDuringCarrier = total;
+	spin_unlock(&fbd->hw_stats.lock);
+}
+
 static void
 fbnic_get_eth_mac_stats(struct net_device *netdev,
 			struct ethtool_eth_mac_stats *eth_mac_stats)
@@ -1782,7 +1822,9 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_ts_info			= fbnic_get_ts_info,
 	.get_ts_stats			= fbnic_get_ts_stats,
 	.get_link_ksettings		= fbnic_phylink_ethtool_ksettings_get,
+	.get_fec_stats			= fbnic_get_fec_stats,
 	.get_fecparam			= fbnic_phylink_get_fecparam,
+	.get_eth_phy_stats		= fbnic_get_eth_phy_stats,
 	.get_eth_mac_stats		= fbnic_get_eth_mac_stats,
 	.get_eth_ctrl_stats		= fbnic_get_eth_ctrl_stats,
 	.get_rmon_stats			= fbnic_get_rmon_stats,
-- 
2.51.0


