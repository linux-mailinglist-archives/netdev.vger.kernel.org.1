Return-Path: <netdev+bounces-199230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D536EADF7DB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A54173397
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9A21E08D;
	Wed, 18 Jun 2025 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flO1vWI1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF021D3E4
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279148; cv=none; b=tVU4o7li7CVTIwsUmRIbZOcUDvzlL+jpSvzfMPlnGgT6ymtMs7xUSDMhL5XbyclDoDTXIiTW0skrORI59ekPBDyU1GAYI/WWQ/31UBz5Vk2zLMwELtBDcpRHoS1jNAYQ3gA+JWNLzQfNnZRCJZ3HEWWatX/UKRB/0ukBQN1VHeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279148; c=relaxed/simple;
	bh=aoeXMDP2v665IhumAl4dZUTqxJFU/gCSY7UOPgIRH4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENZBC95IMadAmE46xsiTdwYzkObmMOlpe0bAln+OTHsevP5OAkuLHEG2k4rM3s3WJGvakteP1zGsHDy0GY5gfgLPfjWMhU/e8WzqiI/bBJOH7MdQW8oT/3Oq8uarysDfMTtcXwLShsO76sQ134J9oE/Ep1fksCeQeyuCz79qxMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flO1vWI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B72C4CEF0;
	Wed, 18 Jun 2025 20:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279148;
	bh=aoeXMDP2v665IhumAl4dZUTqxJFU/gCSY7UOPgIRH4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=flO1vWI12/+Jv3TRPzrY5MhQZXFhytuwoN6XsLhr2J3/ukFLFccYrw5IHOuLIEcMU
	 dBvr0cqAZNApKDL4W9mdDtxfurDkLEJrmnItBnlXDU/oaF0RdQHW7xrxovOoj1F5/z
	 hZ9bKHdjZrew2zgvyxHKrQYV0c1Z980ADGb9+BC5P+2KrGL1h2N3nYhBwPztZijvsF
	 IC0JZlxMUPOftmi4Pm4cnQw2R5vgNWhRUa0aCIMUMWzAotsKP7ExEAY4chd+1lfGTM
	 dM3+TjRSi8ZdO3IH+tF+z5bmEMWesXViRmhK0HTsSCMgITWWGOX1lBaS66hMZlA+nn
	 hewRWsqF6vKBA==
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
Subject: [PATCH net-next 08/10] eth: hinic: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:21 -0700
Message-ID: <20250618203823.1336156-9-kuba@kernel.org>
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

Zeroing data on SET is not necessary, the argument is not copied
back to user space. The driver has no other RXNFC functionality
so the SET callback can be now removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/huawei/hinic/hinic_ethtool.c | 47 +++++++------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
index c559dd4291d3..e9f338e9dbe7 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
@@ -919,9 +919,10 @@ static int hinic_set_channels(struct net_device *netdev,
 	return 0;
 }
 
-static int hinic_get_rss_hash_opts(struct hinic_dev *nic_dev,
-				   struct ethtool_rxnfc *cmd)
+static int hinic_get_rxfh_fields(struct net_device *netdev,
+				 struct ethtool_rxfh_fields *cmd)
 {
+	struct hinic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic_rss_type rss_type = { 0 };
 	int err;
 
@@ -964,7 +965,7 @@ static int hinic_get_rss_hash_opts(struct hinic_dev *nic_dev,
 	return 0;
 }
 
-static int set_l4_rss_hash_ops(struct ethtool_rxnfc *cmd,
+static int set_l4_rss_hash_ops(const struct ethtool_rxfh_fields *cmd,
 			       struct hinic_rss_type *rss_type)
 {
 	u8 rss_l4_en = 0;
@@ -1000,16 +1001,18 @@ static int set_l4_rss_hash_ops(struct ethtool_rxnfc *cmd,
 	return 0;
 }
 
-static int hinic_set_rss_hash_opts(struct hinic_dev *nic_dev,
-				   struct ethtool_rxnfc *cmd)
+static int hinic_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *cmd,
+				 struct netlink_ext_ack *extack)
 {
-	struct hinic_rss_type *rss_type = &nic_dev->rss_type;
+	struct hinic_dev *nic_dev = netdev_priv(dev);
+	struct hinic_rss_type *rss_type;
 	int err;
 
-	if (!(nic_dev->flags & HINIC_RSS_ENABLE)) {
-		cmd->data = 0;
+	rss_type = &nic_dev->rss_type;
+
+	if (!(nic_dev->flags & HINIC_RSS_ENABLE))
 		return -EOPNOTSUPP;
-	}
 
 	/* RSS does not support anything other than hashing
 	 * to queues on src and dst IPs and ports
@@ -1108,26 +1111,6 @@ static int hinic_get_rxnfc(struct net_device *netdev,
 	case ETHTOOL_GRXRINGS:
 		cmd->data = nic_dev->num_qps;
 		break;
-	case ETHTOOL_GRXFH:
-		err = hinic_get_rss_hash_opts(nic_dev, cmd);
-		break;
-	default:
-		err = -EOPNOTSUPP;
-		break;
-	}
-
-	return err;
-}
-
-static int hinic_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
-{
-	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	int err = 0;
-
-	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		err = hinic_set_rss_hash_opts(nic_dev, cmd);
-		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -1797,11 +1780,12 @@ static const struct ethtool_ops hinic_ethtool_ops = {
 	.get_channels = hinic_get_channels,
 	.set_channels = hinic_set_channels,
 	.get_rxnfc = hinic_get_rxnfc,
-	.set_rxnfc = hinic_set_rxnfc,
 	.get_rxfh_key_size = hinic_get_rxfh_key_size,
 	.get_rxfh_indir_size = hinic_get_rxfh_indir_size,
 	.get_rxfh = hinic_get_rxfh,
 	.set_rxfh = hinic_set_rxfh,
+	.get_rxfh_fields = hinic_get_rxfh_fields,
+	.set_rxfh_fields = hinic_set_rxfh_fields,
 	.get_sset_count = hinic_get_sset_count,
 	.get_ethtool_stats = hinic_get_ethtool_stats,
 	.get_strings = hinic_get_strings,
@@ -1829,11 +1813,12 @@ static const struct ethtool_ops hinicvf_ethtool_ops = {
 	.get_channels = hinic_get_channels,
 	.set_channels = hinic_set_channels,
 	.get_rxnfc = hinic_get_rxnfc,
-	.set_rxnfc = hinic_set_rxnfc,
 	.get_rxfh_key_size = hinic_get_rxfh_key_size,
 	.get_rxfh_indir_size = hinic_get_rxfh_indir_size,
 	.get_rxfh = hinic_get_rxfh,
 	.set_rxfh = hinic_set_rxfh,
+	.get_rxfh_fields = hinic_get_rxfh_fields,
+	.set_rxfh_fields = hinic_set_rxfh_fields,
 	.get_sset_count = hinic_get_sset_count,
 	.get_ethtool_stats = hinic_get_ethtool_stats,
 	.get_strings = hinic_get_strings,
-- 
2.49.0


