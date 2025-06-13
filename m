Return-Path: <netdev+bounces-197266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5041FAD7FD0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 02:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D744B1E1DFD
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 00:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D064D1D514E;
	Fri, 13 Jun 2025 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+kpDKw9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49291CF7AF;
	Fri, 13 Jun 2025 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776087; cv=none; b=sp4s6povIb5U33HfyRLD7DukAeL77yB7cs9DOp/obbuhflcYsNApUG+U+EbBQmrmm/BZycQJ+e73PlN6YqZbHsJUcRu29m77FWixHF/kCoaMaOEwNHFHalJFn8APM3n/3kmoA3Ck+UOHbIgNxKcRgKtD6WBKYGcqxUhGiOCAEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776087; c=relaxed/simple;
	bh=aUhdWZzoG54MSNGTp4UbgXVSzZTw+FX4lol1ScFUEG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLBUhIpkNYzSELhnv/rLpBQL2YZ0UNO7crZeEo2DZzFqx60IOP65DL9Q7IlDf7w2kuEO44hpOF5C4aLNcmLrKzRIpBG1b7EolxQ86lW4Ac0TxMHLKhS2+Fe825RQPRVMdKIcc32JVGZQEDrwskXWAifE5S8K/hOUzyG1bB31bt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+kpDKw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9D1C4CEF0;
	Fri, 13 Jun 2025 00:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776087;
	bh=aUhdWZzoG54MSNGTp4UbgXVSzZTw+FX4lol1ScFUEG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+kpDKw9EWhzXW8Nm0UUEpVdXH05t2DRGfxhxyTvmehtDFDxEB93Wta3/1Lbu9oyC
	 sefH/yUWP3/ME3IW6+RaO3ChqxY2CBlG/3JHj3KjfpAzmOaijlJt56NDojk6OAmjr6
	 BPSC1oGLxGCPup5aCoto7Ef5UfjFD+iVh7ucS9pIihH/02eNBYdQZwjZvT4cY2ojur
	 xTZtX3Wv+aqWZv/mZhIEe3hzUxTOWePZYeiWRUp5da22Np3FL7EdvwyI4mCtxTeEgE
	 bUbHZgrd/yzW5DkQ1tg+QpLS4S7ZXHzQO5LN9i2vfihYlg+68oVvrK2QuhslqGiWFV
	 qHYhhENn6HzTg==
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
Subject: [PATCH net-next 2/6] eth: cxgb4: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 17:54:05 -0700
Message-ID: <20250613005409.3544529-3-kuba@kernel.org>
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


