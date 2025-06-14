Return-Path: <netdev+bounces-197809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A4AD9EA9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD681897CD0
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33532E62C0;
	Sat, 14 Jun 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkKsKXC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01ED2E62A7
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924552; cv=none; b=S5eqmn5b/odqh21KU7OftIFH7jTKSXShHcDlAT2HCQBjLgPGDt3tWzOFCw5lhdO5SekLdpAKNI0fYdMkmgYR1rLTTcpRj3tSQFR1+W+e3Eq7owUBIy5h9Kran7QQdQuLMmYFLHAxUrrgNhyRsfvzNJr9VL7LABNNZE3jWd/XEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924552; c=relaxed/simple;
	bh=N3g2ptwY5sj9yKa+MsmWTJbDQDQFqtCkmfgsSBqEot0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YknNh5CdnTnmHd8iQ+ssoNTRNVJCbh1NRJlC/c6aPVd5p4cScPG9pMYsXFKLsAnVWemEddgFk8moXlxV53S7TQeZ8RUXTfs6Ecy8DOEKDDHA4Zx3NoJEy+wyBrwAOzAvAv+64TdpRvjiLXVTTlnqNr2hjv8+TugXDQ7UZcX0MxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkKsKXC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5243C4CEF3;
	Sat, 14 Jun 2025 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924552;
	bh=N3g2ptwY5sj9yKa+MsmWTJbDQDQFqtCkmfgsSBqEot0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkKsKXC9IYAVeyRRLWLvMx40cazzAf3qcG8bPI2ZvlHBLF6rNjdIUJ8Z8iyYyEjfd
	 W26pKYmFePlkkX5KKyKX2IvjccJ5hCthlcvHOfD+p+xYzvo3N4aofA/grQ7QeTt1g3
	 balDhu84SC+cyQMUTGaGgKYPD5j8mkBJTYilQBhsH+QsWJ0wn3zVMkOXG/hI2MO5Hs
	 wme565xjMd0sYkMC7/E+CAlGask7YPXdSlUpsJHH+zhGeNNiRDhZMxJZxQB6rYPJ//
	 cFZpVp37WOX6SVQ/VfzYyACe9IGR3LMSa7pYMyBfFt7+RYURfwyw3/1TBFCFHB4+Ta
	 M6UQPc3Xo6dpQ==
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
Subject: [PATCH net-next v2 2/7] eth: igc: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:02 -0700
Message-ID: <20250614180907.4167714-3-kuba@kernel.org>
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


