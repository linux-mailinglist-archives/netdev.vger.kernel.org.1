Return-Path: <netdev+bounces-197808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99910AD9EA4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09383AE390
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BC23C4F8;
	Sat, 14 Jun 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV4FdacJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66661DF96F
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924552; cv=none; b=QL2q8+oyiyTnkeCYzBX02zRhKlr//lkyrIq7pz/A9zZ/S1xqAMlbPcc6ide9nJgZHdKYGbYLBQ+2wogSpIxH3a/6Ocv+jokhp9zqat73CPBU5iX8Y3WEsbnyxNRrqNq5kIW3jqtKlkMX+bTBdVVPDO35CrnJ6xdSHAaEz4UWnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924552; c=relaxed/simple;
	bh=k57sVhhiCCeU3pmSXiuH2DBELSdMUg2pLnUSwiDmhNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQGq0MOv13guT7dMycg8fQUELd4+GxQl1FLJMCu2ys5g4ED3FAmV7MV0rwXGv638Op2K0WC+gJqxTXoPXrhjT2n1h01ttpZGRVYfl/yS4gAA/MX3F4gKEwQZ9EW2ud9V1bZcz730JqX0FD2y+dObapDmKYxUkVVwkiuGBhPdYpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV4FdacJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F2EC4CEF2;
	Sat, 14 Jun 2025 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924551;
	bh=k57sVhhiCCeU3pmSXiuH2DBELSdMUg2pLnUSwiDmhNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV4FdacJ66+OX67ZD36CSf+6GeeJqIUbeANdcmv54yGfM5JNQPb9uzvOVkQ4eQSea
	 gl+PhAuRzNoFTUoxTA73xID2hk7ryPGQ2StLtT+EDrV+pPOlt6Fu7IsCHB0w6pohR7
	 tKX96EsynqH1dgm4qoq6cvJ0Nq2frU322kSjN6XTjMoxM61ccfHV4q6xGmr8Ym7Otv
	 gLkTwSqktFK2uhWvuHluzrsS2MYpBmApQJTLXiN3Clo9VMSh7Y460y583X6Xikm1KG
	 stRjYi/bWipTgPrK3b3MIDHmlSDxmj5V1Lzr0cbJ3nxZRrjCezbfGFrn8QqeuvHt1q
	 sTx0jFxix0HsA==
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
Subject: [PATCH net-next v2 1/7] eth: igb: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:01 -0700
Message-ID: <20250614180907.4167714-2-kuba@kernel.org>
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
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ca6ccbc13954..92ef33459aec 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2500,9 +2500,11 @@ static int igb_get_ethtool_nfc_all(struct igb_adapter *adapter,
 	return 0;
 }
 
-static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
-				 struct ethtool_rxnfc *cmd)
+static int igb_get_rxfh_fields(struct net_device *dev,
+			       struct ethtool_rxfh_fields *cmd)
 {
+	struct igb_adapter *adapter = netdev_priv(dev);
+
 	cmd->data = 0;
 
 	/* Report default options for RSS on igb */
@@ -2563,9 +2565,6 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	case ETHTOOL_GRXCLSRLALL:
 		ret = igb_get_ethtool_nfc_all(adapter, cmd, rule_locs);
 		break;
-	case ETHTOOL_GRXFH:
-		ret = igb_get_rss_hash_opts(adapter, cmd);
-		break;
 	default:
 		break;
 	}
@@ -2575,9 +2574,11 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 
 #define UDP_RSS_FLAGS (IGB_FLAG_RSS_FIELD_IPV4_UDP | \
 		       IGB_FLAG_RSS_FIELD_IPV6_UDP)
-static int igb_set_rss_hash_opt(struct igb_adapter *adapter,
-				struct ethtool_rxnfc *nfc)
+static int igb_set_rxfh_fields(struct net_device *dev,
+			       const struct ethtool_rxfh_fields *nfc,
+			       struct netlink_ext_ack *extack)
 {
+	struct igb_adapter *adapter = netdev_priv(dev);
 	u32 flags = adapter->flags;
 
 	/* RSS does not support anything other than hashing
@@ -3005,9 +3006,6 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = igb_set_rss_hash_opt(adapter, cmd);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		ret = igb_add_ethtool_nfc_entry(adapter, cmd);
 		break;
@@ -3485,6 +3483,8 @@ static const struct ethtool_ops igb_ethtool_ops = {
 	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 	.get_rxfh		= igb_get_rxfh,
 	.set_rxfh		= igb_set_rxfh,
+	.get_rxfh_fields	= igb_get_rxfh_fields,
+	.set_rxfh_fields	= igb_set_rxfh_fields,
 	.get_channels		= igb_get_channels,
 	.set_channels		= igb_set_channels,
 	.get_priv_flags		= igb_get_priv_flags,
-- 
2.49.0


