Return-Path: <netdev+bounces-216106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B62B320B6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6D81D273A2
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A3312805;
	Fri, 22 Aug 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdBiV89T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800A312802
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881267; cv=none; b=nQlXa1NZvNE0oL6E2WhvIR7fTyZpqnzIUPYC0qaP8t8b3pa6vPa2Og30tvwLIBhq1pTu60lJJjaB6yUuK/KK0+NiwtH+45yUo+fkJVK+TIGbRJrfXnrwA2994kPggWSu7PKqmGjScx9H+3gsG75IJVhKm5JeGQ6vTH+2iwQbzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881267; c=relaxed/simple;
	bh=mKoh+z/X21VKjA8x0jTOKQ7cC18XKNXhd5BB5wNT7pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv/jgP1IbpkbU67Joh5euUTSYg+UN/wYbi3985jCxDeDJ3+MZqyIbUhFvC6P1WYyPc6Q7d9AcdLx8fNUVRRnOTmvCRmTI2gsAMU5yOJqGqF2ONlassOyFHO58fzpIa+cmc3byM7nYuCYErbuLYEKIqox6cYkr1TbITtahrutMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdBiV89T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22342C116B1;
	Fri, 22 Aug 2025 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881267;
	bh=mKoh+z/X21VKjA8x0jTOKQ7cC18XKNXhd5BB5wNT7pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hdBiV89THwIIPmN6bwHin8yHHoFwl7SuxSyHtW4zk7Mg5SuBNa4Qni2mlJUDgjIY+
	 EDrdT1UA+dDSTNuizPiyGEeiELQVMsYTwD+0yADBILLMn5k85NC8ZHcmP4dJxc0or2
	 xov/Y04gbRNDqZaDqEavA6Bo14zqDpXwwuZPI3AbcP2TgccbFhI4pCI6O6/gxjgoFi
	 szUoLNVHR07Pe6/sn91taniERgkLIRlnn1U43hX/zGhu+OOuS0irTKQaKkDEr4Kbuh
	 6RdyeJhZU0UutLScEa3YIfJfxTHJ7iYnKmrPzzgxPLhbEJMePEL+W7bwFWQQxxp8z7
	 Ru6n8n+tsGMqQ==
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
Subject: [PATCH net-next 5/6] eth: fbnic: Read PHY stats via the ethtool API
Date: Fri, 22 Aug 2025 09:47:30 -0700
Message-ID: <20250822164731.1461754-6-kuba@kernel.org>
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
2.50.1


