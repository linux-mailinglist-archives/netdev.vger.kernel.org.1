Return-Path: <netdev+bounces-197810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA811AD9EB3
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D7C3B3620
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A52E6D0B;
	Sat, 14 Jun 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1pDVdli"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8052E6D09
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924553; cv=none; b=fGS0ZiWcSAe2hw7MMBSdHojX8t2aInzuvC1rUqOS+r5w/gi7mQzW+bF+Jqcjdy0xbeW3t8xWG2CEoSV0pGqIywwMXcF7kRROIPAfBEH6Mx0DC2ipIxDtjEVoUng5e8jRjCdvi6/WMVzXd0BTWfUAxKbE7Uyvmy6bpFdkzEpXCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924553; c=relaxed/simple;
	bh=/3MNfq/1VKgqo7tF4QLu3IzV4Qis8K3i9KxsK9PbOyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k44eIrh2WnNbgCe+cM1g+Bx7Z+NAZs2bQW1TbNGiaSdRK4cJtXh1LUoso5LbbSwfUZ4C5CoF4sFIVfe4Di2ZWCVJRJECqHIABpFfticDL2+o7gMfPGHDuu+/8XPrpzjiScFj3mlW9D8RmgXeQsulkHVYA28GZE5Kl4LG+Zw7kBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1pDVdli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62592C4CEF4;
	Sat, 14 Jun 2025 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924552;
	bh=/3MNfq/1VKgqo7tF4QLu3IzV4Qis8K3i9KxsK9PbOyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1pDVdliEMTxq78SueoRL+WGFDMeCjvUFVt1Iy84Cmc9C4nIlloo5x61XncGDbtas
	 ToMQcDZAL+4i85qdjjvEeJexpBTAwZxzEHNcRrQI9kO4Ypvk64J0TLlZhgcaR56Hr3
	 i+sOZd1MoIgKb7ARTkBXPC7boYQUd+t7DLrGPN2J9V1OAru5tDFmFfvkwepqC58RvA
	 ss0Iet+GQwf2GlLNEBuKxgnPFux7uVYTU62tYnIgw4ce3ID/klBBKWBlsGaG25sVLN
	 p2vkJamkM6ASVjy5qyC4buOO1gIsVd4B6veSK6rjxTbjc7AtE6LN2vyn6FgyyTfPDP
	 V2txxeMzrL2gw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 3/7] eth: ixgbe: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:03 -0700
Message-ID: <20250614180907.4167714-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614180907.4167714-1-kuba@kernel.org>
References: <20250614180907.4167714-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add callbacks to ixgbe_ethtool_ops
v1: https://lore.kernel.org/20250613010111.3548291-4-kuba@kernel.org
---
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 1dc1c6e611a4..25c3a09ad7f1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2753,9 +2753,11 @@ static int ixgbe_get_ethtool_fdir_all(struct ixgbe_adapter *adapter,
 	return 0;
 }
 
-static int ixgbe_get_rss_hash_opts(struct ixgbe_adapter *adapter,
-				   struct ethtool_rxnfc *cmd)
+static int ixgbe_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *cmd)
 {
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+
 	cmd->data = 0;
 
 	/* Report default options for RSS on ixgbe */
@@ -2825,9 +2827,6 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLALL:
 		ret = ixgbe_get_ethtool_fdir_all(adapter, cmd, rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		ret = ixgbe_get_rss_hash_opts(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -3079,9 +3078,11 @@ static int ixgbe_del_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 
 #define UDP_RSS_FLAGS (IXGBE_FLAG2_RSS_FIELD_IPV4_UDP | \
 		       IXGBE_FLAG2_RSS_FIELD_IPV6_UDP)
-static int ixgbe_set_rss_hash_opt(struct ixgbe_adapter *adapter,
-				  struct ethtool_rxnfc *nfc)
+static int ixgbe_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *nfc,
+				 struct netlink_ext_ack *extack)
 {
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
 	u32 flags2 = adapter->flags2;
 
 	/*
@@ -3204,9 +3205,6 @@ static int ixgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	case ETHTOOL_SRXCLSRLDEL:
 		ret = ixgbe_del_ethtool_fdir_entry(adapter, cmd);
 		break;
-	case ETHTOOL_SRXFH:
-		ret = ixgbe_set_rss_hash_opt(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -3751,6 +3749,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.get_rxfh_key_size	= ixgbe_get_rxfh_key_size,
 	.get_rxfh		= ixgbe_get_rxfh,
 	.set_rxfh		= ixgbe_set_rxfh,
+	.get_rxfh_fields	= ixgbe_get_rxfh_fields,
+	.set_rxfh_fields	= ixgbe_set_rxfh_fields,
 	.get_eee		= ixgbe_get_eee,
 	.set_eee		= ixgbe_set_eee,
 	.get_channels		= ixgbe_get_channels,
@@ -3797,6 +3797,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.get_rxfh_key_size	= ixgbe_get_rxfh_key_size,
 	.get_rxfh		= ixgbe_get_rxfh,
 	.set_rxfh		= ixgbe_set_rxfh,
+	.get_rxfh_fields	= ixgbe_get_rxfh_fields,
+	.set_rxfh_fields	= ixgbe_set_rxfh_fields,
 	.get_eee		= ixgbe_get_eee,
 	.set_eee		= ixgbe_set_eee,
 	.get_channels		= ixgbe_get_channels,
-- 
2.49.0


