Return-Path: <netdev+bounces-42679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD77CFCB3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79CE2821C7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BB832197;
	Thu, 19 Oct 2023 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q0XLRxn5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320132188;
	Thu, 19 Oct 2023 14:30:03 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF9319A;
	Thu, 19 Oct 2023 07:30:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22E5D6000D;
	Thu, 19 Oct 2023 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697725799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnH2ZHMI5dsTwImD1KGet0qz4ilreT1GWjYY2D79LCc=;
	b=Q0XLRxn5P1pSD+4wfSUlxew1r+I7e730puAeo26hfCy/eBQK+fZQI4ptJMzDzSa/MDL5cD
	7YpeAjxYif56fPF5oy6T9rPsus852M5f8sV3mrK3Zjwo/AA5p8/7Km3l/U28FhZyIFaszz
	IUt1jrgTZb8y65BoBozwv00QNlDxEm5G2mKGN8/pOXw17LMDG36lZmY/8F8X2S5i7fTnO7
	UFMhkxopFfBWCEuz3EUjrOLsQLmDLKSsuDRlyg7rW8c7tOfOeX2yEbqpFVGAV4hBELhUQp
	E2FXX1T2a9qqu2FNDXr7PPNuXyDiSbL0LZKUk8FcwYjVg5YrPZEM8jMKVAZqCg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 19 Oct 2023 16:29:29 +0200
Subject: [PATCH net-next v6 14/16] net: ethtool: ts: Update GET_TS to reply
 the current selected timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231019-feature_ptp_netnext-v6-14-71affc27b0e5@bootlin.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
In-Reply-To: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com

As the default selected timestamp API change we have to change also the
timestamp return by ethtool. This patch return now the current selected
timestamp.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/ethtool/ts.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/net/ethtool/ts.c b/net/ethtool/ts.c
index f2dd65a2e69c..bd219512b8de 100644
--- a/net/ethtool/ts.c
+++ b/net/ethtool/ts.c
@@ -31,29 +31,13 @@ static int ts_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct ts_reply_data *data = TS_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
 
-	if (phy_has_tsinfo(dev->phydev)) {
-		data->ts_layer = PHY_TIMESTAMPING;
-	} else if (ops->get_ts_info) {
-		struct ethtool_ts_info ts_info = {0};
-
-		ops->get_ts_info(dev, &ts_info);
-		if (ts_info.so_timestamping &
-		    SOF_TIMESTAMPING_HARDWARE_MASK)
-			data->ts_layer = MAC_TIMESTAMPING;
-
-		if (ts_info.so_timestamping &
-		    SOF_TIMESTAMPING_SOFTWARE_MASK)
-			data->ts_layer = SOFTWARE_TIMESTAMPING;
-	} else {
-		data->ts_layer = NO_TIMESTAMPING;
-	}
+	data->ts_layer = dev->ts_layer;
 
 	ethnl_ops_complete(dev);
 

-- 
2.25.1


