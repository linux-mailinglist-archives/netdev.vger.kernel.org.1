Return-Path: <netdev+bounces-94494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445F8BFB1C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A01F2321F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23081AA2;
	Wed,  8 May 2024 10:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4881725
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164754; cv=none; b=Bf8FCjMENJfGTIs8+BrJOkZOjwPOsazPskoCEFSzVQwxhLet5Y78W2SZnn0VSNDIOqKktRlkjSabq2PeebSzanSg5hgaYYud0BqniOeCAdnDt1P0xGpAo2LqQQtO45jqORTT4YDDwWbYTvE//iCYvIszzNShRJwsCA8vCVF5vXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164754; c=relaxed/simple;
	bh=73nDyYn53Rnic7QOSyXmbY0u4vSoCSvZ/Gu75sTU39k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqBewFg4iyyT1siGiJSOHoWkPz/7VM6+cLzVT9ytSVB6xG6zCo5MReKBOH991XlZT/xgr8o/WrKn8Nkjh3b3LTNP6eWAXEzuHBVWsRLJQGA03I/wop+JZk72+KE81htYh8SJVH8nv8iICea/0GjOxf1XMFuMyVL6OQjQozhQy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehV-0004BJ-8o; Wed, 08 May 2024 12:39:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-000G0I-I7; Wed, 08 May 2024 12:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-00HLTt-1b;
	Wed, 08 May 2024 12:39:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 3/3] net: dsa: microchip: dcb: set default apptrust to PCP only
Date: Wed,  8 May 2024 12:39:02 +0200
Message-Id: <20240508103902.4134098-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508103902.4134098-1-o.rempel@pengutronix.de>
References: <20240508103902.4134098-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Before DCB support, the KSZ driver had only PCP as source of packet
priority values. To avoid regressions, make PCP only as default value.
User will need enable DSCP support manually.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_dcb.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index 07f6742df41bd..dfe2c48e1066a 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -82,10 +82,6 @@ static const u8 ksz_supported_apptrust[] = {
 	IEEE_8021QAZ_APP_SEL_DSCP,
 };
 
-static const u8 ksz8_port2_supported_apptrust[] = {
-	DCB_APP_SEL_PCP,
-};
-
 static const char * const ksz_supported_apptrust_variants[] = {
 	"empty", "dscp", "pcp", "dscp pcp"
 };
@@ -771,9 +767,8 @@ int ksz_port_get_apptrust(struct dsa_switch *ds, int port, u8 *sel, int *nsel)
  */
 int ksz_dcb_init_port(struct ksz_device *dev, int port)
 {
-	const u8 *sel;
+	const u8 ksz_default_apptrust[] = { DCB_APP_SEL_PCP };
 	int ret, ipm;
-	int sel_len;
 
 	if (is_ksz8(dev)) {
 		ipm = ieee8021q_tt_to_tc(IEEE8021Q_TT_BE,
@@ -789,18 +784,8 @@ int ksz_dcb_init_port(struct ksz_device *dev, int port)
 	if (ret)
 		return ret;
 
-	if (ksz_is_ksz88x3(dev) && port == KSZ_PORT_2) {
-		/* KSZ88x3 devices do not support DSCP classification on
-		 * "Port 2.
-		 */
-		sel = ksz8_port2_supported_apptrust;
-		sel_len = ARRAY_SIZE(ksz8_port2_supported_apptrust);
-	} else {
-		sel = ksz_supported_apptrust;
-		sel_len = ARRAY_SIZE(ksz_supported_apptrust);
-	}
-
-	return ksz_port_set_apptrust(dev->ds, port, sel, sel_len);
+	return ksz_port_set_apptrust(dev->ds, port, ksz_default_apptrust,
+				     ARRAY_SIZE(ksz_default_apptrust));
 }
 
 /**
-- 
2.39.2


