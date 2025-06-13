Return-Path: <netdev+bounces-197267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B0AD7FD1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB221897CB8
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876281D618E;
	Fri, 13 Jun 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V08jxwCd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89D1D5ABF;
	Fri, 13 Jun 2025 00:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776088; cv=none; b=WeZaKVw3Qjug8tCE0RysZtk+Hu2szLAODxrFyTU/w0i+AjSYwlTec9kILCKsmABhfKt10/qFTMhNi5Cjl/owyWSGS2PsASP3VLHds3v690ZhPdCLj62I9L9/DjwEA+e8o6S24PQLBTo+M6d6LuNpIC12W5Py5+6rwfUmzL9UCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776088; c=relaxed/simple;
	bh=KhzAP92i8Mt2wZSD6f6IsaM7TYUfQUkjzTpPUD+Fr2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2wBL0Nz6/65GDcvAybLaMSr6wJ4Mim181jFBx5pt4gKC/nQV8xzOTvUP6946tIIhRgXEI/vN3DJFq5M1q8Z+FiSzVJIro+K8sG7X33Yw8YqOoEMrbFqFIZiy0OkpRAVhX1GPk/2UuXd7hF2gpIfIL3hSvfgIetkeTcbgexePq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V08jxwCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65725C4CEF1;
	Fri, 13 Jun 2025 00:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776088;
	bh=KhzAP92i8Mt2wZSD6f6IsaM7TYUfQUkjzTpPUD+Fr2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V08jxwCdfVXKk/qQAUBVVVni0c9DN0PcX/zPYT/6e7kSURvCR9JgQ0GoqOXLm15Ko
	 dwU/LFbJhJ4Rk352joOP4JPEWlE+y4z9XOHf2BbsHlT8Xzes71zJgyUyvAuc4H69FT
	 EJ9xh8fLcpuGoBi5JQgX9KNUNNE/SVwWfhuvOwP7hRmd1z/4KjlUUfiWe/aKgW68X5
	 EZmiW78HsKk23Gv+n40dTHgeev8JSVnbBhsJIhD4apJKHnPc9Am5WevdX4xmrFxJwp
	 /pahZ4aGAhMlfU8FI77XpO/Z2giRn0HLs+JEMjvDWSADL8ilOQvIsK4QSEO/5dZSZg
	 0cPTh1NDuCi6A==
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
Subject: [PATCH net-next 3/6] eth: lan743x: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 17:54:06 -0700
Message-ID: <20250613005409.3544529-4-kuba@kernel.org>
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
is purely factoring out the handling into a helper.

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


