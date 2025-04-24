Return-Path: <netdev+bounces-185556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C28EA9AE37
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943114A1B13
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3CE22E403;
	Thu, 24 Apr 2025 13:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE327456
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499762; cv=none; b=rCwEe6SE58cNtrylCtlj+ZsftZXToVR3b2qmwB1QS/SimlFdN9yI5AGriG66kFV9d50v7APF0rsKHVgc2q28pJw7bWqfUei0/RUmhauusCzSp6NmpKrutkJwthkyXfpJRgckdV015tQIyyvApA9xt/Xh49aMk0dbwbQaGNWb+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499762; c=relaxed/simple;
	bh=7R7KVsX3qk+rurBDVziqshzEIUxrEy3FSUgnQ+DvgWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Soa/ZuU0oW/JrVJqPm2/JxiOP/KKoV/bOZ/9YmZDt3HWxaiIHzm4wmJn+Ld7nkA0mXTAG6FZaPIsfH3CU1EKvvIGDFrEJ1vJ6vEtqfXhQ07xVJB1Rn3qVy5IOjX6RMBfdkTelHT1BlEsG6723stq9/AwBM0zt+JtT4jYpgSTjbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDh-0002ZW-3v; Thu, 24 Apr 2025 15:02:25 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDf-001swG-22;
	Thu, 24 Apr 2025 15:02:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u7wDf-00Gc4i-1c;
	Thu, 24 Apr 2025 15:02:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v1 1/4] net: dsa: user: Skip set_mac_eee() if support_eee() is implemented
Date: Thu, 24 Apr 2025 15:02:19 +0200
Message-Id: <20250424130222.3959457-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424130222.3959457-1-o.rempel@pengutronix.de>
References: <20250424130222.3959457-1-o.rempel@pengutronix.de>
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

Some switches with integrated PHYs, like Microchip KSZ, manage EEE
internally based on PHY advertisement and link resolution. If
ds->ops->support_eee() is implemented, assume EEE is supported
and skip requiring set_mac_eee().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/dsa/user.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 804dc7dac4f2..87b78a4c1d6c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1246,14 +1246,12 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	/* If the port is using phylink managed EEE, then an unimplemented
 	 * set_mac_eee() is permissible.
 	 */
-	if (!phylink_mac_implements_lpi(ds->phylink_mac_ops)) {
+	if (ds->ops->set_mac_eee &&
+	    !phylink_mac_implements_lpi(ds->phylink_mac_ops)) {
 		/* Port's PHY and MAC both need to be EEE capable */
 		if (!dev->phydev)
 			return -ENODEV;
 
-		if (!ds->ops->set_mac_eee)
-			return -EOPNOTSUPP;
-
 		ret = ds->ops->set_mac_eee(ds, dp->index, e);
 		if (ret)
 			return ret;
-- 
2.39.5


