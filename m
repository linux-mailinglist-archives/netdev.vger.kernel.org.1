Return-Path: <netdev+bounces-197272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0EBAD7FE9
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F35C3B4078
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B858D1C6FF9;
	Fri, 13 Jun 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPPaMzV0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F041A0711
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776495; cv=none; b=NUrk8oYAjzdHoFw8wgkeOhIBGyWkfd3W9KoeUUh+6zpAZoaePXWj5J9SlNUorGGZ+MXopWWG7Yt2I9uMk4LqnsqDu0B+lLs0GzyDi1FwUfiTPsdVFgdN7hoWIiQoZ8pt9RYlAaBVflpyBIKIWsKX/WLqWuvMyX3Br89u3Z/31SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776495; c=relaxed/simple;
	bh=NTwPvUsk4QNe1ETRBmwqN7Lcoqw2Xz3GU5c8UpRSfAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7Ma7DA129TUnytk98hYxnb9SNv4t+L+rvWrHMGUjhYqCxGOfDdqBcfZwl/N/eAvBbWfPkRNIzvWyIb83BIJJe9DkWpHO4TCq6cwDRGhlNiH9sTs9WKuK/FBhzuUo1ncngExTwiJ2ZG+NriWSxaN9A2roBnk14mOdFCh5ChGZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPPaMzV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C12C4CEF0;
	Fri, 13 Jun 2025 01:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776495;
	bh=NTwPvUsk4QNe1ETRBmwqN7Lcoqw2Xz3GU5c8UpRSfAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPPaMzV0OF4RumM2C5y4qSCdI8opH1+MlZzImntQVmAhBpkpVQi1V7P5aWCcU5OND
	 tIyuwjPlO5P/F4x20ZqsgdnkmeIgS+8+iD+/9IMo6dQB8NLBESS2tz8Vv0YdrQLN2/
	 g8j1gc78t8d2TwSswRnP1XRNPfE2gsdGwJ4TkLUxSxUPoMmvmt8mEcJmVzAH/lX/ao
	 sapj2IsGnX5/F83xvwutxX+r92TBdFvzmadvf/CKgnO2wj8gBT5RKr1NdKcZX35wiM
	 sr2+PyRVJnlMTjt1PNlY4tG1iuqau+rGUIHzH7G7PNFmHgFr14/fX1Znnz77OZMWIJ
	 X21ty+UDtfzaQ==
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
Subject: [PATCH net-next 1/7] eth: igb: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 18:01:05 -0700
Message-ID: <20250613010111.3548291-2-kuba@kernel.org>
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


