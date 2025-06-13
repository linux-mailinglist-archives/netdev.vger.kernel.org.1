Return-Path: <netdev+bounces-197265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9475AD7FCF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771B81897B92
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7DB1C8FB5;
	Fri, 13 Jun 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz4SVrKG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468E191F8C;
	Fri, 13 Jun 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776086; cv=none; b=g8FnJu9Q5GUvFFyF/NruYn7ZmbJKVFfZZwI5ExOSVJI37DCxCoGESX/g1rMr4EsvZCO/oagfgJozC6MDRm+sU24t7OJVs+RnCrsm0ai1EgtNdRHdbQLLymt5uTldtBYEPJekhN5Hw8uH222aUb4ifWYuYf7j+n8IHZk3BZLQp1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776086; c=relaxed/simple;
	bh=/aIYdvvDsa1Asz/YDqRJshb0C0zsGSMtP8jRGmDy9QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0zdKyzfgZvQrkDfQyOi4rIlrhRHWO0lu6sGBitS/a7ngeIj4tUfQKXCVLXEZ1VvoA8Qlrb9DMi5EsdS9nwlHc+LWXXoMeQt5lD8QGTpSwQkhQPZLCaAOM9bwDdgO+VjD+I/3/sXFsqcUwVOzd6Fx2ze8iVIn2YLrqkfwPmJLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz4SVrKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C98C4CEEA;
	Fri, 13 Jun 2025 00:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776086;
	bh=/aIYdvvDsa1Asz/YDqRJshb0C0zsGSMtP8jRGmDy9QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jz4SVrKGwn8Hkm5yYHL/hQD7ljuYR7SkDCrtvCLU/53h4IzL0bN4VAPmshtykX0zq
	 nKbZkXcfKQSFpSNoSeody0DiSdHUpderZBFmppwTkwnsdUVm2JP62jw39wMXzGrTdL
	 Qv9jvlLFXMRc52DMSXwhKnYD2URb1c1CEUb3d9fzIYDubODK5IyN/ySHP3zikAndo+
	 rxMu/es1EoGRHVDMI/AfPr5f6N/gjAAJb6JoMNTx8QaNNxbkUgxjGJqIeC1n4Ti4Vi
	 OTwlae09zE6rW/dyTOIBZqysX98UrBYzQp4zHApGOc2vBmUmO0m9Pm0bbKCttlkWT8
	 i+GmBCuJtyXzw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bharat@chelsio.com,
	benve@cisco.com,
	satishkh@cisco.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com,
	rosenp@gmail.com,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/6] eth: cisco: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 17:54:04 -0700
Message-ID: <20250613005409.3544529-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613005409.3544529-1-kuba@kernel.org>
References: <20250613005409.3544529-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").
This driver's RXFH config is read only / fixed so the conversion
is trivial.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 529160926a96..a50f5dad34d5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -528,8 +528,10 @@ static int enic_grxclsrule(struct enic *enic, struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
-static int enic_get_rx_flow_hash(struct enic *enic, struct ethtool_rxnfc *cmd)
+static int enic_get_rx_flow_hash(struct net_device *dev,
+				 struct ethtool_rxfh_fields *cmd)
 {
+	struct enic *enic = netdev_priv(dev);
 	u8 rss_hash_type = 0;
 	cmd->data = 0;
 
@@ -597,9 +599,6 @@ static int enic_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 		ret = enic_grxclsrule(enic, cmd);
 		spin_unlock_bh(&enic->rfs_h.lock);
 		break;
-	case ETHTOOL_GRXFH:
-		ret = enic_get_rx_flow_hash(enic, cmd);
-		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
@@ -693,6 +692,7 @@ static const struct ethtool_ops enic_ethtool_ops = {
 	.get_rxfh_key_size = enic_get_rxfh_key_size,
 	.get_rxfh = enic_get_rxfh,
 	.set_rxfh = enic_set_rxfh,
+	.get_rxfh_fields = enic_get_rx_flow_hash,
 	.get_link_ksettings = enic_get_ksettings,
 	.get_ts_info = enic_get_ts_info,
 	.get_channels = enic_get_channels,
-- 
2.49.0


