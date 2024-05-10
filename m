Return-Path: <netdev+bounces-95314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D822A8C1DC4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731FE1F21812
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6E15EFAB;
	Fri, 10 May 2024 05:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404115D5BD
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319520; cv=none; b=griXwNwGyCngxgL4Bf8lNfPpuZo/CsZNuYaSTT48WJKCnfbJ2QOxpSPU7YOMGkXxbj1uisRXPZRlOwFPXEK7aUcfMsExKqqrM/apNG35sr2hMCVPgukjrbjUBs5TIjmoM5THjhIoPNU4tYOdCtZya82TD4PO73lqYouGUiZ9tXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319520; c=relaxed/simple;
	bh=NHVN4MqHOHW3M13mpXs/mfjl7P3OPbQtFM50LxC9nmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXIU4njwQ9HAyObes77s97Jd8cvRauFHhSehGFW64h+Rjq4AFKFqlDJDpsTh/fNYCfUi3vqWxJnVgPCooMl+OMRSP9vq2pIqymWYWkMRcXBgtwsOe+7NU3/egAwgujWN42+YxnU6GdWBysQqxh8wwOzODCcPaJOKyNRZJuUNFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixk-0006Ra-4d; Fri, 10 May 2024 07:38:32 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixh-000a4G-Fw; Fri, 10 May 2024 07:38:29 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixh-00A7cR-1M;
	Fri, 10 May 2024 07:38:29 +0200
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
Subject: [PATCH net-next v3 3/3] net: dsa: microchip: dcb: set default apptrust to PCP only
Date: Fri, 10 May 2024 07:38:28 +0200
Message-Id: <20240510053828.2412516-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510053828.2412516-1-o.rempel@pengutronix.de>
References: <20240510053828.2412516-1-o.rempel@pengutronix.de>
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

This patch do not affect other KSZ8 related quirks. User will still be
warned by setting not support configurations for the port 2.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
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


