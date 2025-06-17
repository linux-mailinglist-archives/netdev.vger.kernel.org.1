Return-Path: <netdev+bounces-198392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F2ADBED3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C2B188E7FE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53DD1DC9B0;
	Tue, 17 Jun 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZHI8Ch2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041C1CAA79
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124938; cv=none; b=clZdTeufmZD2y0nimcMtTdXo3uvF+SrfAUtJIpw4t7nUHowPqR4b6OtQYJTIijrqvlyrLColMAFlLmlK1NJIjiDjLmsXRRhXMhKQS7coOQ4l8sVff7VqrMKxM0hUa8+25lT4G+KXQY70R+DYRVKZlcBwVL7YMdNzdmDMZ7uGjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124938; c=relaxed/simple;
	bh=z3eif209UoZAarn7eWvtU8zlL090oXeLvvgUw3i83yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoIwlolkuCGothWen+yKtVU3D67i9p7YLP57PxWr98PM2A9EfJK2VP84qVh//xRL/wxOh0o3HjAjWEqaIi8RrcU6L/4TREW3yKnnUurfobb/xDvCUV6+MJBY06jgXKt49AYOtqRVklUWAzlhN1oUaohH346WEKNrEyCGYPd41Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZHI8Ch2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD49FC4CEF3;
	Tue, 17 Jun 2025 01:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124938;
	bh=z3eif209UoZAarn7eWvtU8zlL090oXeLvvgUw3i83yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZHI8Ch2r3DXjSMvVuXYW7Kg9WCup2ao1M2kRmtRSmvf5kzPJiiXHKNRD60yDTUCA
	 yY7AC44gzuevJ9gtGXhTbYRnjHJkHfsmE1HEwoXqmFMZ2A+s7imBEkOO6UDFw5vn5B
	 X51s2EyuyELxp9FU2qmy5tcJ7l/9TQk9f+GYy5VN/Mb6ZQT/Prz+dvvS9kra7nVfiZ
	 ey8kotSvdUU2XGoYyPNO14MkKY3zx21rAEKoRikVU5sDgB7L1Q75wnCXkNvBM8OADN
	 5lpH3wikUPDiv4C8wX/9reUcNOXPgteM2HsjJjAWV96Ci2Xwb14Ah421uPycPvBgxN
	 o5T1yzwHaj6VQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/5] eth: dpaa2: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:48:47 -0700
Message-ID: <20250617014848.436741-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014848.436741-1-kuba@kernel.org>
References: <20250617014848.436741-1-kuba@kernel.org>
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
 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  | 36 ++++++++++++-------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index 74ef77cb7078..00474ed11d53 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -719,13 +719,6 @@ static int dpaa2_eth_get_rxnfc(struct net_device *net_dev,
 	int i, j = 0;
 
 	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXFH:
-		/* we purposely ignore cmd->flow_type for now, because the
-		 * classifier only supports a single set of fields for all
-		 * protocols
-		 */
-		rxnfc->data = priv->rx_hash_fields;
-		break;
 	case ETHTOOL_GRXRINGS:
 		rxnfc->data = dpaa2_eth_queue_count(priv);
 		break;
@@ -767,11 +760,6 @@ static int dpaa2_eth_set_rxnfc(struct net_device *net_dev,
 	int err = 0;
 
 	switch (rxnfc->cmd) {
-	case ETHTOOL_SRXFH:
-		if ((rxnfc->data & DPAA2_RXH_SUPPORTED) != rxnfc->data)
-			return -EOPNOTSUPP;
-		err = dpaa2_eth_set_hash(net_dev, rxnfc->data);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		err = dpaa2_eth_update_cls_rule(net_dev, &rxnfc->fs, rxnfc->fs.location);
 		break;
@@ -785,6 +773,28 @@ static int dpaa2_eth_set_rxnfc(struct net_device *net_dev,
 	return err;
 }
 
+static int dpaa2_eth_get_rxfh_fields(struct net_device *net_dev,
+				     struct ethtool_rxfh_fields *rxnfc)
+{
+	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
+
+	/* we purposely ignore cmd->flow_type for now, because the
+	 * classifier only supports a single set of fields for all
+	 * protocols
+	 */
+	rxnfc->data = priv->rx_hash_fields;
+	return 0;
+}
+
+static int dpaa2_eth_set_rxfh_fields(struct net_device *net_dev,
+				     const struct ethtool_rxfh_fields *rxnfc,
+				     struct netlink_ext_ack *extack)
+{
+	if ((rxnfc->data & DPAA2_RXH_SUPPORTED) != rxnfc->data)
+		return -EOPNOTSUPP;
+	return dpaa2_eth_set_hash(net_dev, rxnfc->data);
+}
+
 int dpaa2_phc_index = -1;
 EXPORT_SYMBOL(dpaa2_phc_index);
 
@@ -939,6 +949,8 @@ const struct ethtool_ops dpaa2_ethtool_ops = {
 	.get_strings = dpaa2_eth_get_strings,
 	.get_rxnfc = dpaa2_eth_get_rxnfc,
 	.set_rxnfc = dpaa2_eth_set_rxnfc,
+	.get_rxfh_fields = dpaa2_eth_get_rxfh_fields,
+	.set_rxfh_fields = dpaa2_eth_set_rxfh_fields,
 	.get_ts_info = dpaa2_eth_get_ts_info,
 	.get_tunable = dpaa2_eth_get_tunable,
 	.set_tunable = dpaa2_eth_set_tunable,
-- 
2.49.0


