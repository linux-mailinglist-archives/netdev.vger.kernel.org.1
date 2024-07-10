Return-Path: <netdev+bounces-110618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368392D7A7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876E71C210CA
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67361990D7;
	Wed, 10 Jul 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbzfd+F1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362E1990D6
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633252; cv=none; b=m10igEVbNz6dJR7vMDT6lwR2tMz+H286L1JQG6zXoatHGR7fJthl86G0zSJz08+fm57SdWNOZLsKgu49TMKrXv+M4YLezQVuNT1/oP+P4uUb84vQ35iJTsUOOjzx1qY45gP0DhMlEXNYZvzVi6iFS1Z0rh/mlKl2FC6/NFqTUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633252; c=relaxed/simple;
	bh=YGg5r6GrPZJ2hWVHqt6yi1VbX5leKxEkSwkUA3yvgJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbsFnYJXUN/05u4WrEqxRxJm2XVPhLQgqDGAxUDLb6JCLtd73RRjkbyq1+cUg9NBYNN5PGaUnUrNav06hxRIFPN09QOdJHeUh6aZP3Juvt/rtWIXPBg4FhtQ0esMcbI3ClRjpjHWxy1lbjQVivRrv6833MfTTuLb6DzsbbLbmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbzfd+F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF2C32786;
	Wed, 10 Jul 2024 17:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720633252;
	bh=YGg5r6GrPZJ2hWVHqt6yi1VbX5leKxEkSwkUA3yvgJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbzfd+F1fmQnhqqBH+J7xlrEhj6GUlAO3bPKNt/REepCEQk86u6j0xk1BPm7IjncN
	 xx9vibF/nh6NlzjC41jpZFQGP14y2gxsqZxL0QoYTcR8l1GcCRK+X5Wn/zM1oiu7yL
	 gw4/beCFtpfsNILTokAnpLMy8+jeabm/kxsIRus1+AizEz3T5OLAubdjRucucffpGm
	 FbaRkRVz1tH0A10Gk2Jq46Awod3fffK2+bnbgcgrOffxtrczZuu9pbyJ+FAjW+Hulp
	 ePho9XZ9APuj/9MU5gRH7JV3b/95lKNwLzoeD03SS2fDeyej0u7ewoDy8VsivAamxB
	 YzC5pKb0HCfuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	ecree.xilinx@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] ethtool: fail closed if we can't get max channel used in indirection tables
Date: Wed, 10 Jul 2024 10:40:42 -0700
Message-ID: <20240710174043.754664-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710174043.754664-1-kuba@kernel.org>
References: <20240710174043.754664-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0d1b7d6c9274 ("bnxt: fix crashes when reducing ring count with
active RSS contexts") proves that allowing indirection table to contain
channels with out of bounds IDs may lead to crashes. Currently the
max channel check in the core gets skipped if driver can't fetch
the indirection table or when we can't allocate memory.

Both of those conditions should be extremely rare but if they do
happen we should try to be safe and fail the channel change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/channels.c |  6 ++----
 net/ethtool/common.c   | 26 +++++++++++++++-----------
 net/ethtool/common.h   |  2 +-
 net/ethtool/ioctl.c    |  4 +---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/ethtool/channels.c b/net/ethtool/channels.c
index 7b4bbd674bae..cee188da54f8 100644
--- a/net/ethtool/channels.c
+++ b/net/ethtool/channels.c
@@ -171,11 +171,9 @@ ethnl_set_channels(struct ethnl_req_info *req_info, struct genl_info *info)
 	 */
 	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
 		max_rxnfc_in_use = 0;
-	if (!netif_is_rxfh_configured(dev) ||
-	    ethtool_get_max_rxfh_channel(dev, &max_rxfh_in_use))
-		max_rxfh_in_use = 0;
+	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
 	if (channels.combined_count + channels.rx_count <= max_rxfh_in_use) {
-		GENL_SET_ERR_MSG(info, "requested channel counts are too low for existing indirection table settings");
+		GENL_SET_ERR_MSG_FMT(info, "requested channel counts are too low for existing indirection table (%d)", max_rxfh_in_use);
 		return -EINVAL;
 	}
 	if (channels.combined_count + channels.rx_count <= max_rxnfc_in_use) {
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..8a62375ebd1f 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -587,35 +587,39 @@ int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max)
 	return err;
 }
 
-int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max)
+u32 ethtool_get_max_rxfh_channel(struct net_device *dev)
 {
 	struct ethtool_rxfh_param rxfh = {};
-	u32 dev_size, current_max = 0;
+	u32 dev_size, current_max;
 	int ret;
 
+	if (!netif_is_rxfh_configured(dev))
+		return 0;
+
 	if (!dev->ethtool_ops->get_rxfh_indir_size ||
 	    !dev->ethtool_ops->get_rxfh)
-		return -EOPNOTSUPP;
+		return 0;
 	dev_size = dev->ethtool_ops->get_rxfh_indir_size(dev);
 	if (dev_size == 0)
-		return -EOPNOTSUPP;
+		return 0;
 
 	rxfh.indir = kcalloc(dev_size, sizeof(rxfh.indir[0]), GFP_USER);
 	if (!rxfh.indir)
-		return -ENOMEM;
+		return U32_MAX;
 
 	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh);
-	if (ret)
-		goto out;
+	if (ret) {
+		current_max = U32_MAX;
+		goto out_free;
+	}
 
+	current_max = 0;
 	while (dev_size--)
 		current_max = max(current_max, rxfh.indir[dev_size]);
 
-	*max = current_max;
-
-out:
+out_free:
 	kfree(rxfh.indir);
-	return ret;
+	return current_max;
 }
 
 int ethtool_check_ops(const struct ethtool_ops *ops)
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 28b8aaaf9bcb..b55705a9ad5a 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -42,7 +42,7 @@ int __ethtool_get_link(struct net_device *dev);
 bool convert_legacy_settings_to_link_ksettings(
 	struct ethtool_link_ksettings *link_ksettings,
 	const struct ethtool_cmd *legacy_settings);
-int ethtool_get_max_rxfh_channel(struct net_device *dev, u32 *max);
+u32 ethtool_get_max_rxfh_channel(struct net_device *dev);
 int ethtool_get_max_rxnfc_channel(struct net_device *dev, u64 *max);
 int __ethtool_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index d72b0fec89af..615812ff8974 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2049,9 +2049,7 @@ static noinline_for_stack int ethtool_set_channels(struct net_device *dev,
 	 * indirection table/rxnfc settings */
 	if (ethtool_get_max_rxnfc_channel(dev, &max_rxnfc_in_use))
 		max_rxnfc_in_use = 0;
-	if (!netif_is_rxfh_configured(dev) ||
-	    ethtool_get_max_rxfh_channel(dev, &max_rxfh_in_use))
-		max_rxfh_in_use = 0;
+	max_rxfh_in_use = ethtool_get_max_rxfh_channel(dev);
 	if (channels.combined_count + channels.rx_count <=
 	    max_t(u64, max_rxnfc_in_use, max_rxfh_in_use))
 		return -EINVAL;
-- 
2.45.2


