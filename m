Return-Path: <netdev+bounces-199226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9BADF7D7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CB7169B34
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4D021CFFD;
	Wed, 18 Jun 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8nxjX3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CE21CFF4
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279145; cv=none; b=fPoPNIcIcIviNhGXi6EB+AY1ijmfCqiYBJDTZB7WWnR7rDd/rMp5GSZk9wJGPcwcMAaVdGw3294JKzABvdJCg7jUi1nzDdKjeWRwD8bbFrSUuhLT4JFCl1AKde9h1WoE91+sKz3OYPTLqE5K5GacmcXPk0fGa7AwBtXGLp3oAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279145; c=relaxed/simple;
	bh=jxOZLPFZjI8CErreHzCRFfhrMwovtpeq6jICsaDGTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmsw3B8pnB/4NAvrLkZMRmkTsKs38yIG0t+/BhJjFH0nI5JlL4L2GyP0OIZJvus5s3/jMD2ULCYQG9u0H0qKuBaana5d6g8tuf6IuZYkYaxeFOg784V1JL6a82bp4+sm43nlxdQI87u1ngBJfAiSshswHUXj2V7KaO8qjOA2gKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8nxjX3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40A5C4CEED;
	Wed, 18 Jun 2025 20:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279145;
	bh=jxOZLPFZjI8CErreHzCRFfhrMwovtpeq6jICsaDGTeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8nxjX3l5zbZcUIPArzBrnSpmcHOKVFvobTOWX0SLIFIqck4LRNP8q6Igg+C2Ynw9
	 7P8sRY0W3CMwddaOuJ3Ld1OpbUG8pDw9PngJfyjV3heidBeoVxrvwYgWP9wbqf0+ax
	 o8+qASCfR30xvFXp4V2pgGJFYMC3pyS9JDRr/q2+VeE4H9BBi/8Y9szBcK1TWLtuu5
	 +L6msGyx+ORRzj2m/2RLpeZtZja2kpIdf0isaAk7f288H9nd1Clnv//5/+eikobEBh
	 rOz1Yu8PUZu/vuKWSlAwYQ5cIuzR868/vOqQBVVSUKIl05lwl76uctNWKJazgZqRUc
	 mV7W9wZmqvcmA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/10] eth: benet: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:17 -0700
Message-ID: <20250618203823.1336156-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618203823.1336156-1-kuba@kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

The driver has no other RXNFC functionality so the SET callback can
be now removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/emulex/benet/be_ethtool.c    | 57 +++++++++----------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f001a649f58f..5d616b1689c3 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -1073,10 +1073,19 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
 	adapter->msg_enable = level;
 }
 
-static u64 be_get_rss_hash_opts(struct be_adapter *adapter, u64 flow_type)
+static int be_get_rxfh_fields(struct net_device *netdev,
+			      struct ethtool_rxfh_fields *cmd)
 {
+	struct be_adapter *adapter = netdev_priv(netdev);
+	u64 flow_type = cmd->flow_type;
 	u64 data = 0;
 
+	if (!be_multi_rxq(adapter)) {
+		dev_info(&adapter->pdev->dev,
+			 "ethtool::get_rxfh: RX flow hashing is disabled\n");
+		return -EINVAL;
+	}
+
 	switch (flow_type) {
 	case TCP_V4_FLOW:
 		if (adapter->rss_info.rss_flags & RSS_ENABLE_IPV4)
@@ -1104,7 +1113,8 @@ static u64 be_get_rss_hash_opts(struct be_adapter *adapter, u64 flow_type)
 		break;
 	}
 
-	return data;
+	cmd->data = data;
+	return 0;
 }
 
 static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
@@ -1119,9 +1129,6 @@ static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	}
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXFH:
-		cmd->data = be_get_rss_hash_opts(adapter, cmd->flow_type);
-		break;
 	case ETHTOOL_GRXRINGS:
 		cmd->data = adapter->num_rx_qs;
 		break;
@@ -1132,11 +1139,20 @@ static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	return 0;
 }
 
-static int be_set_rss_hash_opts(struct be_adapter *adapter,
-				struct ethtool_rxnfc *cmd)
+
+static int be_set_rxfh_fields(struct net_device *netdev,
+			      const struct ethtool_rxfh_fields *cmd,
+			      struct netlink_ext_ack *extack)
 {
-	int status;
+	struct be_adapter *adapter = netdev_priv(netdev);
 	u32 rss_flags = adapter->rss_info.rss_flags;
+	int status;
+
+	if (!be_multi_rxq(adapter)) {
+		dev_err(&adapter->pdev->dev,
+			"ethtool::set_rxfh: RX flow hashing is disabled\n");
+		return -EINVAL;
+	}
 
 	if (cmd->data != L3_RSS_FLAGS &&
 	    cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
@@ -1195,28 +1211,6 @@ static int be_set_rss_hash_opts(struct be_adapter *adapter,
 	return be_cmd_status(status);
 }
 
-static int be_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
-{
-	struct be_adapter *adapter = netdev_priv(netdev);
-	int status = 0;
-
-	if (!be_multi_rxq(adapter)) {
-		dev_err(&adapter->pdev->dev,
-			"ethtool::set_rxnfc: RX flow hashing is disabled\n");
-		return -EINVAL;
-	}
-
-	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		status = be_set_rss_hash_opts(adapter, cmd);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return status;
-}
-
 static void be_get_channels(struct net_device *netdev,
 			    struct ethtool_channels *ch)
 {
@@ -1449,7 +1443,8 @@ const struct ethtool_ops be_ethtool_ops = {
 	.flash_device = be_do_flash,
 	.self_test = be_self_test,
 	.get_rxnfc = be_get_rxnfc,
-	.set_rxnfc = be_set_rxnfc,
+	.get_rxfh_fields = be_get_rxfh_fields,
+	.set_rxfh_fields = be_set_rxfh_fields,
 	.get_rxfh_indir_size = be_get_rxfh_indir_size,
 	.get_rxfh_key_size = be_get_rxfh_key_size,
 	.get_rxfh = be_get_rxfh,
-- 
2.49.0


