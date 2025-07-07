Return-Path: <netdev+bounces-204611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF057AFB772
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E2F4A33AC
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F731F1517;
	Mon,  7 Jul 2025 15:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D71F0E58
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902371; cv=none; b=JWNk03MPk3mmE8E9fELLOserp1accMWb3qZhfnYwDzMHgy/ItKgEeEPd8ELsQ2DrMSeZl+IlE2oEMAzj3wlRkL1tl1F6+9ZTOzmTykzjWenAaDeQ+bosyoIDVrFFjYHk+PJIC9ke1F63pY7spB/jrfkYAOHAu4xhFg4vcbKRMe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902371; c=relaxed/simple;
	bh=5Echb8zj2aHQG67ZuO+XMw2fUTv38gNoRuoKlbYv9do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCtq/qA1TXBhsbNorMfssY+LyekiLo9OOy0M5XDYKxPcaMH79nnaeRCH3XvLakAuKO6qshx9oOuujMaPDOYVrsCt56DcJMNqojT2FEn6wKeNBDus/hj0xYOitDGL4avkkIEhAGyx5h2vUgVpMnY4s1WS43j5oLlux51qITxKqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpb-0007aJ-Qr; Mon, 07 Jul 2025 17:32:35 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpa-007GvT-0R;
	Mon, 07 Jul 2025 17:32:34 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpZ-004YFN-36;
	Mon, 07 Jul 2025 17:32:33 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH net v1 1/2] net: phy: enable polling when driver implements get_next_update_time
Date: Mon,  7 Jul 2025 17:32:31 +0200
Message-Id: <20250707153232.1082819-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707153232.1082819-1-o.rempel@pengutronix.de>
References: <20250707153232.1082819-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Make phylib’s state-machine timer run for drivers that provide
get_next_update_time() but not update_stats().

phy_polling_mode() currently switches to polling only when either
- the PHY runs in interrupt-less mode, or
- the driver exposes update_stats() (needed by several
  statistics-gathering drivers).

Upcoming support for adaptive polling in the SMSC LAN9512/LAN8700 family
relies on get_next_update_time() alone, so the helper must also trigger
polling for that callback. No in-tree drivers have required this until
now, so the change does not alter existing behaviour.

Fixes: 8bf47e4d7b87 ("net: phy: Add support for driver-specific next update time")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64b3c..b37b981fc9be 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1628,7 +1628,7 @@ static inline bool phy_polling_mode(struct phy_device *phydev)
 		if (phydev->drv->flags & PHY_POLL_CABLE_TEST)
 			return true;
 
-	if (phydev->drv->update_stats)
+	if (phydev->drv->update_stats || phydev->drv->get_next_update_time)
 		return true;
 
 	return phydev->irq == PHY_POLL;
-- 
2.39.5


