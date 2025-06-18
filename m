Return-Path: <netdev+bounces-199051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F118AADEC39
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA592174798
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7582E6D38;
	Wed, 18 Jun 2025 12:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7F2E265D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249575; cv=none; b=hoPeIWasomEsruj1741gDGn0JEDDbzeRiQYinZz3x2mBUTmdPlpxuwGEOikrGXvZSYXP2fUvbrgqGOj3+4k6SAbJ9wBE7hLnEKInw7MDFx2aq+Ze3rA9tABvuoU4IP+eK5az3fk27cb1hV+N4Qu650baZRa8H59I8mBFjK7iLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249575; c=relaxed/simple;
	bh=YlEmZjVfwC6NQSI23/ta9zK73SdMNgWCqQ6iou40KV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IKvOWIaMpRmuz/vKThuJFe4MF4L7KZ7tw7rfqdgGoO9ZmXzpKz8EjeqXB17hx3tfvP8RXrO2Dj/iHeBUTxJwC0RQPfDT1GsbSl9aVl7cnLm5v2aIyVB5xQFSPokrynb23i2pCTmVof+EoIw5fgm/ADHpBb8ExPIMbfe1I+5iriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrg-00007g-UU; Wed, 18 Jun 2025 14:26:04 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrf-0048Uo-1V;
	Wed, 18 Jun 2025 14:26:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrf-00DFCf-17;
	Wed, 18 Jun 2025 14:26:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v8 0/6] convert lan78xx driver to the PHYLINK
Date: Wed, 18 Jun 2025 14:25:56 +0200
Message-Id: <20250618122602.3156678-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This series converts the lan78xx driver to use the PHYLINK framework,
which enhances PHY and MAC management. The changes also streamline the
driver by removing unused elements and improving link status reporting.

This is the final part of the previously split conversion series:
https://lore.kernel.org/all/20250428130542.3879769-1-o.rempel@pengutronix.de/

Tested on EVB_LAN7850.

Best Regards, Please review.
Oleksij

Oleksij Rempel (6):
  net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC
    management
  net: usb: lan78xx: Rename EVENT_LINK_RESET to EVENT_PHY_INT_ACK
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Integrate EEE support with phylink LPI API
  net: usb: lan78xx: remove unused struct members

 drivers/net/usb/Kconfig   |   3 +-
 drivers/net/usb/lan78xx.c | 730 ++++++++++++++++++--------------------
 2 files changed, 348 insertions(+), 385 deletions(-)

--
2.39.5


