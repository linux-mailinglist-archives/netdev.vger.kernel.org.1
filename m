Return-Path: <netdev+bounces-197803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B11AD9E9E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5380E7AB4C4
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31E32E62D3;
	Sat, 14 Jun 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAh6V9Gk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B62E62C0;
	Sat, 14 Jun 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924408; cv=none; b=lqWnen2P76Kjv08qmljXVp+LpVg98yHIuT6wchd+ejQ9gaP0hU1+nZ/Co1Cr7j6YAschpNrLkbrf4w9ID/WdoIvJXFcrhMxpvV0QW+mbP+uRqQAIAcXjDa6XHs/HpZ521dwArRc/FybDCB3Yb2dG6eNsgBKkvtAGia/6KXJgnWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924408; c=relaxed/simple;
	bh=8MMBkeLPXK5fH47jmlzmKbWMt9Wv7fENTj3CmaU2WNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcYN3YG5eiTgLBbZl48K+5P7PMCQcP8w0SmS7aCGOOPjTuz/5MRHL64KJTzQe6x2D6gMfcBcvHQ9Bw+yOuczPy3/K6s3St3dg6fp2KqG14VdGrIVpO50j1vdhdG3C94yxcQ72Sh+KCky40Ho5Y+TJ/ShEUykbC4WC+PvWMUNv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAh6V9Gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986FDC4CEF2;
	Sat, 14 Jun 2025 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749924408;
	bh=8MMBkeLPXK5fH47jmlzmKbWMt9Wv7fENTj3CmaU2WNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAh6V9Gk6DW31S07OKuX2E3tcVb0LhudBDazFPp5YCbT3096hMqycrKXXYdz8QHHZ
	 XkpMgedU9sUFmdtVG7KMk1x0k7pz+X1D3HygiJtbaglMwI5x0IzXJAgnfOHg0jBEsP
	 0SWFX7WepuiTaVr0jnNHWXUi27xxeQre/vKqj8QXo87N5iugbKeXIvbIqh0H1yp69k
	 14Ec6WG0fH0PV0vs1z94TxaosZ0jG/rCUU3iADuATOwl+yuratYgS6AGSW2gyVrAAA
	 IAmxfX4WyHE4+IOjL71Kn/mCIptvzEILjbIt9ehFy17G4mxsgdmtss9gG8NtpzJDV6
	 MQzqalwNzRkDw==
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
Subject: [PATCH net-next v2 2/5] eth: cxgb4: migrate to new RXFH callbacks
Date: Sat, 14 Jun 2025 11:06:35 -0700
Message-ID: <20250614180638.4166766-3-kuba@kernel.org>
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
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    | 105 +++++++++---------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 1546c3db08f0..23326235d4ab 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -1730,6 +1730,60 @@ static int cxgb4_ntuple_get_filter(struct net_device *dev,
 	return 0;
 }
 
+static int cxgb4_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *info)
+{
+	const struct port_info *pi = netdev_priv(dev);
+	unsigned int v = pi->rss_mode;
+
+	info->data = 0;
+	switch (info->flow_type) {
+	case TCP_V4_FLOW:
+		if (v & FW_RSS_VI_CONFIG_CMD_IP4FOURTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+				RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		else if (v & FW_RSS_VI_CONFIG_CMD_IP4TWOTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case UDP_V4_FLOW:
+		if ((v & FW_RSS_VI_CONFIG_CMD_IP4FOURTUPEN_F) &&
+		    (v & FW_RSS_VI_CONFIG_CMD_UDPEN_F))
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+				RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		else if (v & FW_RSS_VI_CONFIG_CMD_IP4TWOTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case SCTP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case IPV4_FLOW:
+		if (v & FW_RSS_VI_CONFIG_CMD_IP4TWOTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case TCP_V6_FLOW:
+		if (v & FW_RSS_VI_CONFIG_CMD_IP6FOURTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+				RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		else if (v & FW_RSS_VI_CONFIG_CMD_IP6TWOTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case UDP_V6_FLOW:
+		if ((v & FW_RSS_VI_CONFIG_CMD_IP6FOURTUPEN_F) &&
+		    (v & FW_RSS_VI_CONFIG_CMD_UDPEN_F))
+			info->data = RXH_IP_SRC | RXH_IP_DST |
+				RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		else if (v & FW_RSS_VI_CONFIG_CMD_IP6TWOTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	case SCTP_V6_FLOW:
+	case AH_ESP_V6_FLOW:
+	case IPV6_FLOW:
+		if (v & FW_RSS_VI_CONFIG_CMD_IP6TWOTUPEN_F)
+			info->data = RXH_IP_SRC | RXH_IP_DST;
+		break;
+	}
+	return 0;
+}
+
 static int get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 		     u32 *rules)
 {
@@ -1739,56 +1793,6 @@ static int get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	int ret = 0;
 
 	switch (info->cmd) {
-	case ETHTOOL_GRXFH: {
-		unsigned int v = pi->rss_mode;
-
-		info->data = 0;
-		switch (info->flow_type) {
-		case TCP_V4_FLOW:
-			if (v & FW_RSS_VI_CONFIG_CMD_IP4FOURTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST |
-					     RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			else if (v & FW_RSS_VI_CONFIG_CMD_IP4TWOTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case UDP_V4_FLOW:
-			if ((v & FW_RSS_VI_CONFIG_CMD_IP4FOURTUPEN_F) &&
-			    (v & FW_RSS_VI_CONFIG_CMD_UDPEN_F))
-				info->data = RXH_IP_SRC | RXH_IP_DST |
-					     RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			else if (v & FW_RSS_VI_CONFIG_CMD_IP4TWOTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case SCTP_V4_FLOW:
-		case AH_ESP_V4_FLOW:
-		case IPV4_FLOW:
-			if (v & FW_RSS_VI_CONFIG_CMD_IP4TWOTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case TCP_V6_FLOW:
-			if (v & FW_RSS_VI_CONFIG_CMD_IP6FOURTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST |
-					     RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			else if (v & FW_RSS_VI_CONFIG_CMD_IP6TWOTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case UDP_V6_FLOW:
-			if ((v & FW_RSS_VI_CONFIG_CMD_IP6FOURTUPEN_F) &&
-			    (v & FW_RSS_VI_CONFIG_CMD_UDPEN_F))
-				info->data = RXH_IP_SRC | RXH_IP_DST |
-					     RXH_L4_B_0_1 | RXH_L4_B_2_3;
-			else if (v & FW_RSS_VI_CONFIG_CMD_IP6TWOTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		case SCTP_V6_FLOW:
-		case AH_ESP_V6_FLOW:
-		case IPV6_FLOW:
-			if (v & FW_RSS_VI_CONFIG_CMD_IP6TWOTUPEN_F)
-				info->data = RXH_IP_SRC | RXH_IP_DST;
-			break;
-		}
-		return 0;
-	}
 	case ETHTOOL_GRXRINGS:
 		info->data = pi->nqsets;
 		return 0;
@@ -2199,6 +2203,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.get_rxfh_indir_size = get_rss_table_size,
 	.get_rxfh	   = get_rss_table,
 	.set_rxfh	   = set_rss_table,
+	.get_rxfh_fields   = cxgb4_get_rxfh_fields,
 	.self_test	   = cxgb4_self_test,
 	.flash_device      = set_flash,
 	.get_ts_info       = get_ts_info,
-- 
2.49.0


