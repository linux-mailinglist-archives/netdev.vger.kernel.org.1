Return-Path: <netdev+bounces-197802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D9AD9E9D
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286721897957
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28428ECF2;
	Sat, 14 Jun 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6qvMYKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928771DF96F;
	Sat, 14 Jun 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924407; cv=none; b=lBq6vyjoVqSlAXnzxHcgGzhaMVSn0cxlOdRaH+2y0ALKjVJl1P/m1YvRP5ACTLDVZcBXK8jLrPFklUwMguyWUKyiHGLFSAD7lZsh4/8Iv8VDsHXzh4b8RpfMA670oBPPgQi7exR8sJ3iGj7dmt9BWaOi1YtVLXr395e88+1h83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924407; c=relaxed/simple;
	bh=xkrML5+5NI+T6SNHDhJMfo1ZibBZ4nHjLcqucMoGr1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMjviPxE5lH9LSrfk+584+jv5P/AtTFP6gZViZ+XdHamcD8V1CW4+1ZxGJcnGMPm0voKaDyLyTgZM27/77yWsA00MCdyGS21j+WJgAJKvqcRuS5vrSlzPjmR0fQcEWwUo8wWqnuq34lViWvSy8Y0szaHOW/lcFGQZAj3z3s8iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6qvMYKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9317C4CEF0;
	Sat, 14 Jun 2025 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924407;
	bh=xkrML5+5NI+T6SNHDhJMfo1ZibBZ4nHjLcqucMoGr1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6qvMYKv83USzCXMzOj6f+rVa7WEcpExP3bP6deVKDsIeRT0u74N7LVcOEOn/4etT
	 yH8GRWp9vfKsNKjcYGoRGoNTNC2zCbZW+XkaNK1p34dRmH3MPdGITbvfYCUIkn60jW
	 ZR4Pm8IWnHPOeVgZOQ3IvdkakxlEki5tcnZy00YI8ie34oYaWtwM5hRfDtg3jfEh8r
	 3gHon3aCSwMLUpDlIOTLN+4np9UFYU9d7BWuwVp/L6/nTjHgTPKD7OmUkVU1MW3j2f
	 2AJjkwDWMOJZjbSmc+O1DrjWsiWpFEK0PgIsgY7aQi72DWmvjZPAX2Biigsp6RcU+p
	 SYwYLsjUekRHA==
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
	Jakub Kicinski <kuba@kernel.org>,
	Joe Damato <joe@dama.to>
Subject: [PATCH net-next v2 1/5] eth: cisco: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:06:34 -0700
Message-ID: <20250614180638.4166766-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614180638.4166766-1-kuba@kernel.org>
References: <20250614180638.4166766-1-kuba@kernel.org>
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

Reviewed-by: Joe Damato <joe@dama.to>
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


