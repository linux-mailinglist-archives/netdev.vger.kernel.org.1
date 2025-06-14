Return-Path: <netdev+bounces-197811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785F5AD9EB5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448B4175F86
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7182E6D1E;
	Sat, 14 Jun 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alwP46Fq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BE2E6D14
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924553; cv=none; b=UMSPtQq1SXRRImdgiWIQPXsPBOtBnRyGreJAZjWR+IOFCAzGXG3+dHI78OdRMNCe68YtXU4X/maWMFDhgRtoWP/46+dhoji0/+KRqW3Rn13oqFKee8/3tdk3mfX5jGO+JDdB6ieAt3Dfwtg07q6XSTWphl9ehF/ymi7AnKkEjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924553; c=relaxed/simple;
	bh=9UOYjumfzFj1YP/sbEZWRQIvmCADIa12+t7J4nrYsoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpgV3WynQvIU7tt9lJtIZOcl1u36FrZ/XZW6vaduUlSqyRWhBgijLP+xaMTUikCBj7oGiCRK83LNMP86ViVi47XEULpcJfNIakFk621rrWJf5met7aQdDqyllAMJo2pauHcVbJaX5puEl2RtXKSvB1KVACoORjYZpjENABarPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alwP46Fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E01C4CEF3;
	Sat, 14 Jun 2025 18:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924553;
	bh=9UOYjumfzFj1YP/sbEZWRQIvmCADIa12+t7J4nrYsoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alwP46Fq1v7PA+w0p6c5Wgx3ULCT05hM9mZT8KMvamE1nH1lqfr4hdgeFAJGqg5fv
	 XgGpDDHgcHmDtirGpHcgLrw6HS+Cm7Qr/cpKIVfdSnS95QenlMUr4yFuPOmDV0ZKMj
	 OEX2hHAUzpA71zYpXDdrojdJZAkBdgXdhMy07MgIzeVSnGA1ADYmc3VWnpuuoUjPlo
	 0BRBiIjyIn1fqGxmtsKbwCNerhzxeRSyYxEJUjJUTjULtDAMPitbSE2vjSBNlXo4L8
	 JjGEZPSGGVjHKFgdCnfRYskb40blPAMSVhp0RPE9pMuxGWkfgYZCaZV/eeoKsrDWxD
	 +nEtffw5Hrrxg==
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
Subject: [PATCH net-next v2 4/7] eth: fm10k: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:09:04 -0700
Message-ID: <20250614180907.4167714-5-kuba@kernel.org>
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
.get callback moves out of the switch and set_rxnfc disappears
as ETHTOOL_SRXFH as the only functionality.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 34 ++++++-------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 1bc5b6c0b897..1954a04460d1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -691,9 +691,11 @@ static int fm10k_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static int fm10k_get_rss_hash_opts(struct fm10k_intfc *interface,
-				   struct ethtool_rxnfc *cmd)
+static int fm10k_get_rssh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *cmd)
 {
+	struct fm10k_intfc *interface = netdev_priv(dev);
+
 	cmd->data = 0;
 
 	/* Report default options for RSS on fm10k */
@@ -743,9 +745,6 @@ static int fm10k_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		cmd->data = interface->num_rx_queues;
 		ret = 0;
 		break;
-	case ETHTOOL_GRXFH:
-		ret = fm10k_get_rss_hash_opts(interface, cmd);
-		break;
 	default:
 		break;
 	}
@@ -753,9 +752,11 @@ static int fm10k_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	return ret;
 }
 
-static int fm10k_set_rss_hash_opt(struct fm10k_intfc *interface,
-				  struct ethtool_rxnfc *nfc)
+static int fm10k_set_rssh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *nfc,
+				 struct netlink_ext_ack *extack)
 {
+	struct fm10k_intfc *interface = netdev_priv(dev);
 	int rss_ipv4_udp = test_bit(FM10K_FLAG_RSS_FIELD_IPV4_UDP,
 				    interface->flags);
 	int rss_ipv6_udp = test_bit(FM10K_FLAG_RSS_FIELD_IPV6_UDP,
@@ -871,22 +872,6 @@ static int fm10k_set_rss_hash_opt(struct fm10k_intfc *interface,
 	return 0;
 }
 
-static int fm10k_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
-{
-	struct fm10k_intfc *interface = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
-
-	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = fm10k_set_rss_hash_opt(interface, cmd);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
 static int fm10k_mbx_test(struct fm10k_intfc *interface, u64 *data)
 {
 	struct fm10k_hw *hw = &interface->hw;
@@ -1176,7 +1161,6 @@ static const struct ethtool_ops fm10k_ethtool_ops = {
 	.get_coalesce		= fm10k_get_coalesce,
 	.set_coalesce		= fm10k_set_coalesce,
 	.get_rxnfc		= fm10k_get_rxnfc,
-	.set_rxnfc		= fm10k_set_rxnfc,
 	.get_regs               = fm10k_get_regs,
 	.get_regs_len           = fm10k_get_regs_len,
 	.self_test		= fm10k_self_test,
@@ -1186,6 +1170,8 @@ static const struct ethtool_ops fm10k_ethtool_ops = {
 	.get_rxfh_key_size	= fm10k_get_rssrk_size,
 	.get_rxfh		= fm10k_get_rssh,
 	.set_rxfh		= fm10k_set_rssh,
+	.get_rxfh_fields	= fm10k_get_rssh_fields,
+	.set_rxfh_fields	= fm10k_set_rssh_fields,
 	.get_channels		= fm10k_get_channels,
 	.set_channels		= fm10k_set_channels,
 	.get_ts_info		= ethtool_op_get_ts_info,
-- 
2.49.0


