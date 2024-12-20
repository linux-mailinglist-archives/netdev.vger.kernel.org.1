Return-Path: <netdev+bounces-153552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B39F8A44
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CE21892EBF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7862C190;
	Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McfwGkXi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309829429
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663169; cv=none; b=uKRQJhrF+v9ol+12JFwZPJw3DMHreAL1ZqRDiuBKfTSobrM9mZ+JDkxPQBrsJcByxJbHc8D9wsaDHJuamGgkRdSk+DqOhLGfYrPjdvWLsANjLU/MbjM1r8ic8luuKEW5oFnstRKT/hAtdXC8zukpgumND4CD273vPOvWbsYGaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663169; c=relaxed/simple;
	bh=i2Mp9TR4w7aOIR2wS8MHhqzW2DffxiUqu/bT8o71Oks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya7FHDDPz6ybBC4W2ECd8MA1Z4t//uYQ31+hqgKpauaTk7Uemiik6/ftiV4MYLkzMYiG+zS1P5Q9bbpyVo+6maWGF9/M7nnDF4PwxXfAi91h+WMMu1yRegorXJBBALG7q9e7Ir0mHmH558J8RxiG+2vnNrYNuTGxTEFdSS58kwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McfwGkXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0000FC4CEDD;
	Fri, 20 Dec 2024 02:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663169;
	bh=i2Mp9TR4w7aOIR2wS8MHhqzW2DffxiUqu/bT8o71Oks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McfwGkXizqvXdld4eeyCDl38PHV6BFEvoUd53FfO1LMbrcqPqwSCUEEMR90S34YRh
	 coXjo98kMMjvHJbeQHZZASgUgXS/Mu65chSG8XVexGHvgbTQTdLcoDzVUNuUvN1hXP
	 nE2qkIekfLsp9JHIxa2qHe7I8zi/hHP4cMF4oiNFaiV4qkaAn87ysfkgMKyxuZL9yw
	 dPJnmONTKSRtBfy8vNT+1gil0V7i2lC7Jion7vpbpiPZWsgpF+Xg6W8e6V70ANM0Hp
	 PTtMtGUTetmY2OFjq0b1+GVGlB+yU9k7yC/vBQCO9eEASXZGfqe0MptXGznpPI+U/t
	 /ngy8QfVvDDWQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/10] eth: fbnic: support querying RSS config
Date: Thu, 19 Dec 2024 18:52:33 -0800
Message-ID: <20241220025241.1522781-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@fb.com>

The initial driver submission already added all the RSS state,
as part of multi-queue support. Expose the configuration via
the ethtool APIs.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 777e083acae9..e71ae6abb0f5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -102,6 +102,105 @@ static int fbnic_get_sset_count(struct net_device *dev, int sset)
 	}
 }
 
+static int fbnic_get_rss_hash_idx(u32 flow_type)
+{
+	switch (flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS)) {
+	case TCP_V4_FLOW:
+		return FBNIC_TCP4_HASH_OPT;
+	case TCP_V6_FLOW:
+		return FBNIC_TCP6_HASH_OPT;
+	case UDP_V4_FLOW:
+		return FBNIC_UDP4_HASH_OPT;
+	case UDP_V6_FLOW:
+		return FBNIC_UDP6_HASH_OPT;
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case IPV4_FLOW:
+	case IPV4_USER_FLOW:
+		return FBNIC_IPV4_HASH_OPT;
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+	case AH_ESP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case IPV6_FLOW:
+	case IPV6_USER_FLOW:
+		return FBNIC_IPV6_HASH_OPT;
+	case ETHER_FLOW:
+		return FBNIC_ETHER_HASH_OPT;
+	}
+
+	return -1;
+}
+
+static int
+fbnic_get_rss_hash_opts(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
+{
+	int hash_opt_idx = fbnic_get_rss_hash_idx(cmd->flow_type);
+
+	if (hash_opt_idx < 0)
+		return -EINVAL;
+
+	/* Report options from rss_en table in fbn */
+	cmd->data = fbn->rss_flow_hash[hash_opt_idx];
+
+	return 0;
+}
+
+static int fbnic_get_rxnfc(struct net_device *netdev,
+			   struct ethtool_rxnfc *cmd, u32 *rule_locs)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = fbn->num_rx_queues;
+		ret = 0;
+		break;
+	case ETHTOOL_GRXFH:
+		ret = fbnic_get_rss_hash_opts(fbn, cmd);
+		break;
+	}
+
+	return ret;
+}
+
+static u32 fbnic_get_rxfh_key_size(struct net_device *netdev)
+{
+	return FBNIC_RPC_RSS_KEY_BYTE_LEN;
+}
+
+static u32 fbnic_get_rxfh_indir_size(struct net_device *netdev)
+{
+	return FBNIC_RPC_RSS_TBL_SIZE;
+}
+
+static int
+fbnic_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	unsigned int i;
+
+	rxfh->hfunc = ETH_RSS_HASH_TOP;
+
+	if (rxfh->key) {
+		for (i = 0; i < FBNIC_RPC_RSS_KEY_BYTE_LEN; i++) {
+			u32 rss_key = fbn->rss_key[i / 4] << ((i % 4) * 8);
+
+			rxfh->key[i] = rss_key >> 24;
+		}
+	}
+
+	if (rxfh->indir) {
+		for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
+			rxfh->indir[i] = fbn->indir_tbl[0][i];
+	}
+
+	return 0;
+}
+
 static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
@@ -209,6 +308,10 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_strings		= fbnic_get_strings,
 	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_sset_count		= fbnic_get_sset_count,
+	.get_rxnfc		= fbnic_get_rxnfc,
+	.get_rxfh_key_size	= fbnic_get_rxfh_key_size,
+	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
+	.get_rxfh		= fbnic_get_rxfh,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
-- 
2.47.1


