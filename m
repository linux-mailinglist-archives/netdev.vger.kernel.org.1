Return-Path: <netdev+bounces-197804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7EBAD9E9F
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28F27AB7FD
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5BF2E6D09;
	Sat, 14 Jun 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN5ZCjP+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B912E62DD;
	Sat, 14 Jun 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924409; cv=none; b=lUz0/92UcPnarFqIz3JiQV/YFuPbPkZn6Wf52T2JUedo3ruflAeGJ89ClrGl7S6J34RsLD1GfKP9DfFaKTdNkCm9asmj1LGcrsAxgGlIjXsgx/Z29Le0SLpatpoV6fN6gtN697G8cYVvEfhzFbofDKgPy/cw7BOcnjfW2XdFAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924409; c=relaxed/simple;
	bh=q7vrO+Z+re6UJM0frQTU3/pr0lsT93gCohEGzwowpPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMhDgBcuoUr9mScQCHgAPYRVqZrJa8a+te+7cnufX9pMy6tPcGKOkm5QoJNdo1SdIJSpmuij7S4aGUuNg0MAOZA/jTT1PQ8A68gkUEcONDXUYTuhS26xmf6f3vIgBxMoWAn264TZJ//7rdPw6y87fkYJYJwy3+FAVP87MI6KbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN5ZCjP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0A3C4CEF4;
	Sat, 14 Jun 2025 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924409;
	bh=q7vrO+Z+re6UJM0frQTU3/pr0lsT93gCohEGzwowpPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN5ZCjP+c9Xfhz+wFgg+B8H7jVi8MOu2ikUwn0lRwjsHJddVE0mgc0j7AJwCCA0/B
	 rZo5OnPsCFCrNF+vqvLYfqi4lQL1E2RMaFqUyY0v/uS1efM1UVppo+cx0CqdKA8kiG
	 EGV4CrwLffMqhigEt0FY69uqhirGfmujvBQmIuKAkiWNR/ZoT+0Zs63VsUoaBHu1CM
	 bZqPUwvTZXYzmkvHaN3ipAeI0XJQYWDDhX7A6zk4Y0s52EY/v081LaLTswRxu1ZeIu
	 MrYAbBqwLgBizAgH4PW9XvcwHzSrQySxs+AfWCih5JWjZ5xvo9j3+It0JWeWH+HMD+
	 NZ0q1cTSZtBDA==
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
Subject: [PATCH net-next v2 3/5] eth: lan743x: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:06:36 -0700
Message-ID: <20250614180638.4166766-4-kuba@kernel.org>
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
is purely factoring out the handling into a helper.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/microchip/lan743x_ethtool.c  | 31 ++++++++++++-------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 64a3b953cc17..40002d9fe274 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -913,23 +913,29 @@ static int lan743x_ethtool_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
+static int lan743x_ethtool_get_rxfh_fields(struct net_device *netdev,
+					   struct ethtool_rxfh_fields *fields)
+{
+	fields->data = 0;
+
+	switch (fields->flow_type) {
+	case TCP_V4_FLOW:case UDP_V4_FLOW:
+	case TCP_V6_FLOW:case UDP_V6_FLOW:
+		fields->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case IPV4_FLOW: case IPV6_FLOW:
+		fields->data |= RXH_IP_SRC | RXH_IP_DST;
+		return 0;
+	}
+
+	return 0;
+}
+
 static int lan743x_ethtool_get_rxnfc(struct net_device *netdev,
 				     struct ethtool_rxnfc *rxnfc,
 				     u32 *rule_locs)
 {
 	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXFH:
-		rxnfc->data = 0;
-		switch (rxnfc->flow_type) {
-		case TCP_V4_FLOW:case UDP_V4_FLOW:
-		case TCP_V6_FLOW:case UDP_V6_FLOW:
-			rxnfc->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			fallthrough;
-		case IPV4_FLOW: case IPV6_FLOW:
-			rxnfc->data |= RXH_IP_SRC | RXH_IP_DST;
-			return 0;
-		}
-		break;
 	case ETHTOOL_GRXRINGS:
 		rxnfc->data = LAN743X_USED_RX_CHANNELS;
 		return 0;
@@ -1368,6 +1374,7 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.get_rxfh_indir_size = lan743x_ethtool_get_rxfh_indir_size,
 	.get_rxfh = lan743x_ethtool_get_rxfh,
 	.set_rxfh = lan743x_ethtool_set_rxfh,
+	.get_rxfh_fields = lan743x_ethtool_get_rxfh_fields,
 	.get_ts_info = lan743x_ethtool_get_ts_info,
 	.get_eee = lan743x_ethtool_get_eee,
 	.set_eee = lan743x_ethtool_set_eee,
-- 
2.49.0


