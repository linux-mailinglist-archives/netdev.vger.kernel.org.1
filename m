Return-Path: <netdev+bounces-39226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8EE7BE588
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BE1281BF5
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE97374F0;
	Mon,  9 Oct 2023 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cbA2yog8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF8339BC
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:52:47 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B2D66;
	Mon,  9 Oct 2023 08:52:38 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1B211C0007;
	Mon,  9 Oct 2023 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696866757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avXVQPWzRJKUhJQzpKYOLVnENRQVKEA8nP3k0T3jh3I=;
	b=cbA2yog8qte67ALWuIDXHSzTxUSM9wkWBe/7C3EHiU+dPm+Bhz4XqsacPYmU7AdP41Weda
	TS8f9rrY7wZHFp/ScZ9EraBdBX0CUbYoZmC2YTNFLVBwAD6QvFuILsX3N17V6LqLYwcbva
	w73cnIqSKkuGFLxmwksQQJm1fPAobCbFhy8fzEHh+dTCPymsOpln6j6BOvs9swWtWbrOdP
	9YzX8pX/j9SO3RfrFVopT9KogbGWvPEzCk5/Uu7v0ZCoCEl4b8wsYHbazrCCo3xWFYeKie
	spQjEY65/IJN1r+JIb98mGJQqBBKR1Zlk6r8mWzHMkVFZY7Wvo8yy3jqIbVQcQ==
From: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <michael@walle.cc>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 14/16] net: ethtool: ts: Update GET_TS to reply the current selected timestamp
Date: Mon,  9 Oct 2023 17:51:36 +0200
Message-Id: <20231009155138.86458-15-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kory Maincent <kory.maincent@bootlin.com>

As the default selected timestamp API change we have to change also the
timestamp return by ethtool. This patch return now the current selected
timestamp.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/ethtool/ts.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ethtool/ts.c b/net/ethtool/ts.c
index d52b9800dc3b..11041a16de5b 100644
--- a/net/ethtool/ts.c
+++ b/net/ethtool/ts.c
@@ -31,19 +31,13 @@ static int ts_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct ts_reply_data *data = TS_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
-	const struct ethtool_ops *ops = dev->ethtool_ops;
 	int ret;
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
 
-	if (phy_has_tsinfo(dev->phydev))
-		data->ts_layer = PHYLIB_TIMESTAMPING;
-	else if (ops->get_ts_info)
-		data->ts_layer = NETDEV_TIMESTAMPING;
-	else
-		data->ts_layer = NO_TIMESTAMPING;
+	data->ts_layer = dev->ts_layer;
 
 	ethnl_ops_complete(dev);
 
-- 
2.25.1


