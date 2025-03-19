Return-Path: <netdev+bounces-176044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56ACA68741
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04A6420BF8
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3C253F1B;
	Wed, 19 Mar 2025 08:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CE253332
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374208; cv=none; b=Ap+zYtzTKDg+kQgnslcMzlNfhZbRYDs7b60JvO6/wZcPz/g/17xtEpkJyqkGO2eBl5bqrIYBPXZsdvGshbcs4x+OZCg848bZwL5ftWBQMpCwrFSaaSvvnjVYnhYNYBgNW9mRE/U0lTm/iWY8mHyGNl2gfBAotHNk3/TcVbxncxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374208; c=relaxed/simple;
	bh=yVb77lXu9UzACfkbSk3IP6Vp7D1nECQHwPZKbbKcdcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hwxSvw87Vw4JxN44WQt8jjhbhoAyvxhwsDwPpbAlsbda4Ie34oDSI6CM6ImlHAjKAPf4MnGLvdnCqkeXEmZdY2v+TZSAt+Orcb4/BkDrV7+RZs/nyJD/R+gBOUacfBR0S9iTAZVDs3LHAL9uNli3UxeDieaBXKR+Cc4HAIe492c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7b-0008Oq-V6; Wed, 19 Mar 2025 09:49:55 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-000Z4M-0Q;
	Wed, 19 Mar 2025 09:49:53 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-001l1O-1W;
	Wed, 19 Mar 2025 09:49:53 +0100
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
Subject: [PATCH net-next v5 0/6] Convert LAN78xx to PHYLINK
Date: Wed, 19 Mar 2025 09:49:46 +0100
Message-Id: <20250319084952.419051-1-o.rempel@pengutronix.de>
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

changes v5:
- merge ethtool pause configuration patch with PHYlink patch
- merge some other small cleanup to a single patch

changes v4:
- split "Improve error handling in PHY initialization" patch and move
  some parts before PHYlink porting to address some of compile warning
  as early as possible.
- add cleanup patch to remove unused struct members

This patch series refactors the LAN78xx USB Ethernet driver to use the
PHYLINK API.


Oleksij Rempel (6):
  net: usb: lan78xx: Improve error handling in PHY initialization
  net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC
    management
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Integrate EEE support with phylink LPI API
  net: usb: lan78xx: remove unused struct members

 drivers/net/usb/Kconfig   |   3 +-
 drivers/net/usb/lan78xx.c | 820 ++++++++++++++++++--------------------
 2 files changed, 394 insertions(+), 429 deletions(-)

--
2.39.5


