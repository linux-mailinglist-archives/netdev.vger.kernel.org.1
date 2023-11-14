Return-Path: <netdev+bounces-47674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA737EAF1B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63ACA1C20A89
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB083FE33;
	Tue, 14 Nov 2023 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JZZhCAkw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844F2377F;
	Tue, 14 Nov 2023 11:29:17 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292AF1985;
	Tue, 14 Nov 2023 03:29:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B88B46000E;
	Tue, 14 Nov 2023 11:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699961347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnH2ZHMI5dsTwImD1KGet0qz4ilreT1GWjYY2D79LCc=;
	b=JZZhCAkwLMySeO8vgV2JsnvWUEIrHRJyThv0gLJGivHrKuLh62GdVSUDWcw3rdmBRPbCcA
	zYFs+i7xoUgHF5xiUm+vF3j7po1EbgFmRTBt3RyBHGuFwU8Bywa3i1jpGtgDRKr6gM/1Ln
	t9Flxjj2XTpP1YuAnoTfLLnbh7CS4BnJZStVsMRRz+aC3PZTD5am43YaDIw6XOqSzGbMGF
	/ubfTJu6B90f+3wwaeV4DESklHs2bfnumb207Mzu9NgBxnnAMRr85eow9zlwC4+mrxVibw
	oxwT2b9wPFcOE0XoDYpCpM4Z+Hf79cwpWLNBO8cAynnZfuShrAsN/I2+oflqlQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 12:28:42 +0100
Subject: [PATCH net-next v7 14/16] net: ethtool: ts: Update GET_TS to reply
 the current selected timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-14-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
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
X-Mailer: b4 0.12.4
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


