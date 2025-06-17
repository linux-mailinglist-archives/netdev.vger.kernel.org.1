Return-Path: <netdev+bounces-198385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8FADBECB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F9E3B803D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985BA1C861F;
	Tue, 17 Jun 2025 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubB+8EYR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7447B1C84AA
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124763; cv=none; b=CfndnumQwg8Ym9SDQOtiRV3cGCi1RZRUk1tDQQl7/F/lROkFCSyeJQF4n6uS7EUP2ExuuSICumFa+F0QScKR73i+a4+jReOXkHG8Aez0cwk2/sCwthg253FA95xqRUPBUTBMaQ/p0GTGcVy2wqOrFojRBLvTZaluiKOnoZsnUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124763; c=relaxed/simple;
	bh=GkApvReWzZHObxGU9JoWvN+QbMaetoStd5ThVUHwXlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+0cpCOpxpp2xweVOFPluldftf/6kIOAmk9tgTAihIC7C6bjUTnu8qy0gSMAdC1aqz1HlDY7nq6RD0wtiO+sCj8uIszlefr3SRgHkbuMYILnt/sW4hdp+N8MoVDkuDs0LRPeM7VPKL4bkwM4YqT3vNwTbjaXwvZ+AoWI2K7143A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubB+8EYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726D7C4CEF5;
	Tue, 17 Jun 2025 01:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124763;
	bh=GkApvReWzZHObxGU9JoWvN+QbMaetoStd5ThVUHwXlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubB+8EYRwqagQaEBUND7SKp/p+wf/ZbyY9tYl0y7qXv3TYFG9wazi5Dfcp2S1kZJA
	 2WjERtDFbWqflY7kd4bAd5vkAYg5nigacRr2pxkW1XHQGYwkGzY5y83YEmL1B1MhoU
	 iZL7I0rjOuMqedszFYAclvvrWCpNl+69Dq2gErhU6QXDbKsPgWg9YfOERai9jHJf7w
	 kcSpkg+3llnfDmsQ9zaQ/6t5WtYm+0zx2tACJo709S46ME5zyK/dbYUA+mzquX0l1V
	 VvKzTskhMAFZeb9/FCm3efsZvInoeyZ+TNnnB+SsfXGuZ04ATmb62LWIOiaTdz8hnR
	 NSiG+LlvPp7Qg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] eth: ena: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:45:53 -0700
Message-ID: <20250617014555.434790-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014555.434790-1-kuba@kernel.org>
References: <20250617014555.434790-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

The driver as no other RXNFC functionality so the SET callback can
be now removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 39 ++++++-------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index a3c934c3de71..07e8f6b1e8af 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -721,9 +721,11 @@ static u16 ena_flow_data_to_flow_hash(u32 hash_fields)
 	return data;
 }
 
-static int ena_get_rss_hash(struct ena_com_dev *ena_dev,
-			    struct ethtool_rxnfc *cmd)
+static int ena_get_rxfh_fields(struct net_device *netdev,
+			       struct ethtool_rxfh_fields *cmd)
 {
+	struct ena_adapter *adapter = netdev_priv(netdev);
+	struct ena_com_dev *ena_dev = adapter->ena_dev;
 	enum ena_admin_flow_hash_proto proto;
 	u16 hash_fields;
 	int rc;
@@ -772,9 +774,12 @@ static int ena_get_rss_hash(struct ena_com_dev *ena_dev,
 	return 0;
 }
 
-static int ena_set_rss_hash(struct ena_com_dev *ena_dev,
-			    struct ethtool_rxnfc *cmd)
+static int ena_set_rxfh_fields(struct net_device *netdev,
+			       const struct ethtool_rxfh_fields *cmd,
+			       struct netlink_ext_ack *extack)
 {
+	struct ena_adapter *adapter = netdev_priv(netdev);
+	struct ena_com_dev *ena_dev = adapter->ena_dev;
 	enum ena_admin_flow_hash_proto proto;
 	u16 hash_fields;
 
@@ -816,26 +821,6 @@ static int ena_set_rss_hash(struct ena_com_dev *ena_dev,
 	return ena_com_fill_hash_ctrl(ena_dev, proto, hash_fields);
 }
 
-static int ena_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info)
-{
-	struct ena_adapter *adapter = netdev_priv(netdev);
-	int rc = 0;
-
-	switch (info->cmd) {
-	case ETHTOOL_SRXFH:
-		rc = ena_set_rss_hash(adapter->ena_dev, info);
-		break;
-	case ETHTOOL_SRXCLSRLDEL:
-	case ETHTOOL_SRXCLSRLINS:
-	default:
-		netif_err(adapter, drv, netdev,
-			  "Command parameter %d is not supported\n", info->cmd);
-		rc = -EOPNOTSUPP;
-	}
-
-	return rc;
-}
-
 static int ena_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
 			 u32 *rules)
 {
@@ -847,9 +832,6 @@ static int ena_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *info,
 		info->data = adapter->num_io_queues;
 		rc = 0;
 		break;
-	case ETHTOOL_GRXFH:
-		rc = ena_get_rss_hash(adapter->ena_dev, info);
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_GRXCLSRLALL:
@@ -1098,11 +1080,12 @@ static const struct ethtool_ops ena_ethtool_ops = {
 	.get_strings		= ena_get_ethtool_strings,
 	.get_ethtool_stats      = ena_get_ethtool_stats,
 	.get_rxnfc		= ena_get_rxnfc,
-	.set_rxnfc		= ena_set_rxnfc,
 	.get_rxfh_indir_size    = ena_get_rxfh_indir_size,
 	.get_rxfh_key_size	= ena_get_rxfh_key_size,
 	.get_rxfh		= ena_get_rxfh,
 	.set_rxfh		= ena_set_rxfh,
+	.get_rxfh_fields	= ena_get_rxfh_fields,
+	.set_rxfh_fields	= ena_set_rxfh_fields,
 	.get_channels		= ena_get_channels,
 	.set_channels		= ena_set_channels,
 	.get_tunable		= ena_get_tunable,
-- 
2.49.0


