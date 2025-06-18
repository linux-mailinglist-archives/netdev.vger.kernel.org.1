Return-Path: <netdev+bounces-199223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94FADF7D4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F671663BB
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B411D21C9E7;
	Wed, 18 Jun 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvbd4Mhk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CD188006
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279143; cv=none; b=laLHIjQnC25Q4NGBxh9yXnf1qVHjIBKKDg8QYORnWmHiBj78yEBtS3QulixThVyFikjNr6tFE2sNcUODGP15Cp7qMk1ZA0nL5BrQZgyROLkauFzDsNGeKSiI6M+v4GbtVnswYQ4WIaT6efIrrareYArgkY821ffAqof7w7gn/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279143; c=relaxed/simple;
	bh=7goIh+4lswZjWVoZhcqVqBM6+ec0HeagRxDcn7yoZIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmHwzRZcKOipm6+h+TM6Zpgh9EzqtyXXsqQma0zweJmKh+t98upTEDU74MAWcsUF0LYsprHrqpeGpnUvumuXhKlqsK8mugimreiXSUMhxWQUozPd36TIUonCLzaIfnKgIfRaPysabjiwynQDM8rvY4RNjt1U32kFZe13S/WCyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvbd4Mhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78913C4CEE7;
	Wed, 18 Jun 2025 20:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279143;
	bh=7goIh+4lswZjWVoZhcqVqBM6+ec0HeagRxDcn7yoZIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dvbd4MhkfrZooLfAAqhm2bcSPYV9qNHY+fPYxrt76C1P/SY3Zq+/tO+pYy693REJZ
	 t6u9TXyPxBcDWJXesomvRzKQIhOjVQJ9tcCYoV+0x7BL9/9W4TAz8IjRbu8aYbbjiH
	 vJ8b7jayin8YeMV8kME5Nt3xWrAS/eRonrFvA8BTZ/xSUY4EEWf2I80uDyUGtA6kp1
	 KYyfnnrTLaUcF2oAg3vmGblRiM7ON0qRyjLNXTAFKoNzGYoBp4YXJFefe80cc5Xdd9
	 dTZvLvbkcXkODz9nlUsH/dNJEnJ/cPAQRTkYXqZN374u3tbQm5qFfVFX4fflKVp6WN
	 Akfe9o/l/B51w==
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
Subject: [PATCH net-next 01/10] eth: sfc: falcon: migrate to new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:14 -0700
Message-ID: <20250618203823.1336156-2-kuba@kernel.org>
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
This driver's RXFH config is read only / fixed so the conversion
is purely factoring out the handling into a helper.

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/sfc/falcon/ethtool.c | 51 +++++++++++++----------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 04766448a545..6685e71ab13f 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -943,6 +943,33 @@ static int ef4_ethtool_get_class_rule(struct ef4_nic *efx,
 	return rc;
 }
 
+static int
+ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
+			    struct ethtool_rxfh_fields *info)
+{
+	struct ef4_nic *efx = netdev_priv(net_dev);
+	unsigned int min_revision = 0;
+
+	info->data = 0;
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case IPV4_FLOW:
+		info->data |= RXH_IP_SRC | RXH_IP_DST;
+		min_revision = EF4_REV_FALCON_B0;
+		break;
+	default:
+		break;
+	}
+	if (ef4_nic_rev(efx) < min_revision)
+		info->data = 0;
+	return 0;
+}
+
 static int
 ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		      struct ethtool_rxnfc *info, u32 *rule_locs)
@@ -954,29 +981,6 @@ ef4_ethtool_get_rxnfc(struct net_device *net_dev,
 		info->data = efx->n_rx_channels;
 		return 0;
 
-	case ETHTOOL_GRXFH: {
-		unsigned min_revision = 0;
-
-		info->data = 0;
-		switch (info->flow_type) {
-		case TCP_V4_FLOW:
-			info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			fallthrough;
-		case UDP_V4_FLOW:
-		case SCTP_V4_FLOW:
-		case AH_ESP_V4_FLOW:
-		case IPV4_FLOW:
-			info->data |= RXH_IP_SRC | RXH_IP_DST;
-			min_revision = EF4_REV_FALCON_B0;
-			break;
-		default:
-			break;
-		}
-		if (ef4_nic_rev(efx) < min_revision)
-			info->data = 0;
-		return 0;
-	}
-
 	case ETHTOOL_GRXCLSRLCNT:
 		info->data = ef4_filter_get_rx_id_limit(efx);
 		if (info->data == 0)
@@ -1343,6 +1347,7 @@ const struct ethtool_ops ef4_ethtool_ops = {
 	.get_rxfh_indir_size	= ef4_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= ef4_ethtool_get_rxfh,
 	.set_rxfh		= ef4_ethtool_set_rxfh,
+	.get_rxfh_fields	= ef4_ethtool_get_rxfh_fields,
 	.get_module_info	= ef4_ethtool_get_module_info,
 	.get_module_eeprom	= ef4_ethtool_get_module_eeprom,
 	.get_link_ksettings	= ef4_ethtool_get_link_ksettings,
-- 
2.49.0


