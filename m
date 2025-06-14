Return-Path: <netdev+bounces-197805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4991DAD9EA1
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD707AB873
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065A2E6D31;
	Sat, 14 Jun 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZDOGq+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC82E6D2E;
	Sat, 14 Jun 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924410; cv=none; b=LtEeNjkld++gfl5FweuiT0ziEMJRuDY1mNB98vCL5WGQDucufeGvhWjgSid0iVcEaCDbI9lMoN7Kzj2WKTYw4MPM3xEtouzvsADPpomRUBMl3xyvgYZDU+ObLJPchWjIw2pN6edALHvo3gNwrf1zdb8VYPlGeIKGspY1KSyMQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924410; c=relaxed/simple;
	bh=CxOuWAPcF1pLkSLgYrWDvEauSoNhgrOvWfTjtCg/kpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4VaKbcK+yvkmPknDnZK7cEw5aIhMjIHyUW+IyK+DoppeSeQNvCcGNqy5TbUPKqzMQFDOIMDb02GbxNM1sSyXCVMMB4/jJOUwCJfHUFHNrwgHnmGAFgkjL65kDgZe6gmrgP+u81aqpmgQtDYQKVMhBcqO0EGjnqQooBsZ/f0XTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZDOGq+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E444C4CEEB;
	Sat, 14 Jun 2025 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924410;
	bh=CxOuWAPcF1pLkSLgYrWDvEauSoNhgrOvWfTjtCg/kpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZDOGq+yaqfKnYqyQ50UR4G2J4/vWOgzGLLbLsFv2OY4d8klzWEWVEBvhHOKZx1al
	 8PMjjDxwQf6Av7IF0cVwtgD7bD8T2KMpLUMyeraC6HP4PG4BRNGtpnZ4gkwYqgJvXs
	 O+xABHf1SARWsuKYEuGZOjptgPFf57Z//nAsQ0Ko21SgN8RsHw/ILPZeRaocdHFugC
	 zmFGEgMlGAtq1AkL6l2ieqCkEm0fHYrgXjJQXp4rZqBdeixcYjisJSHT4Z1JgF5dj+
	 KSZzdOXU1M2x1s7XGR8gBPePt2Yfd8zokl0LgeptMM04YNM5M6rYMhXqDDylP91x3U
	 H9FwygB2H9wZw==
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
Subject: [PATCH net-next v2 4/5] eth: e1000e: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:06:37 -0700
Message-ID: <20250614180638.4166766-5-kuba@kernel.org>
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
This driver's RXFH config is read only / fixed and it's the only
get_rxnfc sub-command the driver supports. So convert the get_rxnfc
handler into a get_rxfh_fields handler.

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 77 ++++++++++-----------
 1 file changed, 35 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 9364bc2b4eb1..c0bbb12eed2e 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2096,54 +2096,47 @@ static void e1000_get_strings(struct net_device __always_unused *netdev,
 	}
 }
 
-static int e1000_get_rxnfc(struct net_device *netdev,
-			   struct ethtool_rxnfc *info,
-			   u32 __always_unused *rule_locs)
+static int e1000_get_rxfh_fields(struct net_device *netdev,
+				 struct ethtool_rxfh_fields *info)
 {
+	struct e1000_adapter *adapter = netdev_priv(netdev);
+	struct e1000_hw *hw = &adapter->hw;
+	u32 mrqc;
+
 	info->data = 0;
 
-	switch (info->cmd) {
-	case ETHTOOL_GRXFH: {
-		struct e1000_adapter *adapter = netdev_priv(netdev);
-		struct e1000_hw *hw = &adapter->hw;
-		u32 mrqc;
+	mrqc = er32(MRQC);
 
-		mrqc = er32(MRQC);
-
-		if (!(mrqc & E1000_MRQC_RSS_FIELD_MASK))
-			return 0;
-
-		switch (info->flow_type) {
-		case TCP_V4_FLOW:
-			if (mrqc & E1000_MRQC_RSS_FIELD_IPV4_TCP)
-				info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			fallthrough;
-		case UDP_V4_FLOW:
-		case SCTP_V4_FLOW:
-		case AH_ESP_V4_FLOW:
-		case IPV4_FLOW:
-			if (mrqc & E1000_MRQC_RSS_FIELD_IPV4)
-				info->data |= RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case TCP_V6_FLOW:
-			if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_TCP)
-				info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			fallthrough;
-		case UDP_V6_FLOW:
-		case SCTP_V6_FLOW:
-		case AH_ESP_V6_FLOW:
-		case IPV6_FLOW:
-			if (mrqc & E1000_MRQC_RSS_FIELD_IPV6)
-				info->data |= RXH_IP_SRC | RXH_IP_DST;
-			break;
-		default:
-			break;
-		}
+	if (!(mrqc & E1000_MRQC_RSS_FIELD_MASK))
 		return 0;
-	}
+
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		if (mrqc & E1000_MRQC_RSS_FIELD_IPV4_TCP)
+			info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case UDP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case IPV4_FLOW:
+		if (mrqc & E1000_MRQC_RSS_FIELD_IPV4)
+			info->data |= RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case TCP_V6_FLOW:
+		if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_TCP)
+			info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		fallthrough;
+	case UDP_V6_FLOW:
+	case SCTP_V6_FLOW:
+	case AH_ESP_V6_FLOW:
+	case IPV6_FLOW:
+		if (mrqc & E1000_MRQC_RSS_FIELD_IPV6)
+			info->data |= RXH_IP_SRC | RXH_IP_DST;
+		break;
 	default:
-		return -EOPNOTSUPP;
+		break;
 	}
+	return 0;
 }
 
 static int e1000e_get_eee(struct net_device *netdev, struct ethtool_keee *edata)
@@ -2352,7 +2345,7 @@ static const struct ethtool_ops e1000_ethtool_ops = {
 	.get_sset_count		= e1000e_get_sset_count,
 	.get_coalesce		= e1000_get_coalesce,
 	.set_coalesce		= e1000_set_coalesce,
-	.get_rxnfc		= e1000_get_rxnfc,
+	.get_rxfh_fields	= e1000_get_rxfh_fields,
 	.get_ts_info		= e1000e_get_ts_info,
 	.get_eee		= e1000e_get_eee,
 	.set_eee		= e1000e_set_eee,
-- 
2.49.0


