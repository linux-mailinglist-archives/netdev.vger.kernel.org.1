Return-Path: <netdev+bounces-197273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5109AD7FEF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BF61897FAE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4F1D5CED;
	Fri, 13 Jun 2025 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk5UkXX0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF71D5175
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776496; cv=none; b=Lt4Lf1kQQFt/B+Y7o3Tvp9r7HkNV5Me7BhuQQ/VVW/9QPu7DX7b68KXnbR3TQqzGlv6z8d9tkLWDhUaqvpHlE7O6iTAeVOEaQZuHLZKnmOM0TzOaNOymw2rVMcL62A4W3AZC46Rm4rUk5sFd1AhlOZ/5BAETI44MYMas0RFxQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776496; c=relaxed/simple;
	bh=aXp64FVZ8vBC59bZdDKbUAFWuUawl6rAwfae83yygCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne5gMtXbOLltxRJqV0CYreo/KLylEBQ3pc3WDLiQZ+zNdjF3hKpP/Y65Ls5dW4SUiPCLzk3TMcqic6wiw7hDe6r4NcF8N1I15WW61PVrp2g0ZosQ8hfQ9eQGcOCP+7WbP6/bsDB96/2HjGuaLHEVdgXSNmKnAJFAMgGKNcSb7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk5UkXX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEF9C4CEF4;
	Fri, 13 Jun 2025 01:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776495;
	bh=aXp64FVZ8vBC59bZdDKbUAFWuUawl6rAwfae83yygCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sk5UkXX0JWyh+fdmw6aNtCdpnwUFGXbHKUPRCtfVTkuhvt2cVfUbm13zQuTokL0AY
	 +HewobJ/679t7p4sOb89+yThXjjnoAN6YUK7TzuWWBWabqHqMxKA42wTCGfPkczfev
	 Ij9H9/B1O87m3Kb2bdFl/QKzNcfQzr1wVY6xZW5J0tX2hRbmzrDhbPaOOqG9xthJe9
	 DjyIvP5fr4mEufG5FPPzAEdcC8pwYaFIhRsajCT8HNjsNu4igdvs1I4p3CtnSTRZn5
	 TBIxdZFvK8g/YWDuVRxmmLrScpMaMh6Fq3XpgI0yQ4PWGJ6gUrLIU1H1u+6clvheCM
	 MEMtjE17x2gEQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/7] eth: igc: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 18:01:06 -0700
Message-ID: <20250613010111.3548291-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613010111.3548291-1-kuba@kernel.org>
References: <20250613010111.3548291-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 3fc1eded9605..e6cac8d4b862 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1045,9 +1045,11 @@ static int igc_ethtool_get_nfc_rules(struct igc_adapter *adapter,
 	return 0;
 }
 
-static int igc_ethtool_get_rss_hash_opts(struct igc_adapter *adapter,
-					 struct ethtool_rxnfc *cmd)
+static int igc_ethtool_get_rxfh_fields(struct net_device *dev,
+				       struct ethtool_rxfh_fields *cmd)
 {
+	struct igc_adapter *adapter = netdev_priv(dev);
+
 	cmd->data = 0;
 
 	/* Report default options for RSS on igc */
@@ -1103,8 +1105,6 @@ static int igc_ethtool_get_rxnfc(struct net_device *dev,
 		return igc_ethtool_get_nfc_rule(adapter, cmd);
 	case ETHTOOL_GRXCLSRLALL:
 		return igc_ethtool_get_nfc_rules(adapter, cmd, rule_locs);
-	case ETHTOOL_GRXFH:
-		return igc_ethtool_get_rss_hash_opts(adapter, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1112,9 +1112,11 @@ static int igc_ethtool_get_rxnfc(struct net_device *dev,
 
 #define UDP_RSS_FLAGS (IGC_FLAG_RSS_FIELD_IPV4_UDP | \
 		       IGC_FLAG_RSS_FIELD_IPV6_UDP)
-static int igc_ethtool_set_rss_hash_opt(struct igc_adapter *adapter,
-					struct ethtool_rxnfc *nfc)
+static int igc_ethtool_set_rxfh_fields(struct net_device *dev,
+				       const struct ethtool_rxfh_fields *nfc,
+				       struct netlink_ext_ack *extack)
 {
+	struct igc_adapter *adapter = netdev_priv(dev);
 	u32 flags = adapter->flags;
 
 	/* RSS does not support anything other than hashing
@@ -1425,8 +1427,6 @@ static int igc_ethtool_set_rxnfc(struct net_device *dev,
 	struct igc_adapter *adapter = netdev_priv(dev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		return igc_ethtool_set_rss_hash_opt(adapter, cmd);
 	case ETHTOOL_SRXCLSRLINS:
 		return igc_ethtool_add_nfc_rule(adapter, cmd);
 	case ETHTOOL_SRXCLSRLDEL:
@@ -2144,6 +2144,8 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_rxfh_indir_size	= igc_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= igc_ethtool_get_rxfh,
 	.set_rxfh		= igc_ethtool_set_rxfh,
+	.get_rxfh_fields	= igc_ethtool_get_rxfh_fields,
+	.set_rxfh_fields	= igc_ethtool_set_rxfh_fields,
 	.get_ts_info		= igc_ethtool_get_ts_info,
 	.get_channels		= igc_ethtool_get_channels,
 	.set_channels		= igc_ethtool_set_channels,
-- 
2.49.0


