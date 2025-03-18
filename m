Return-Path: <netdev+bounces-175646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3DDA66FE6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A44226A7
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6005920A5CC;
	Tue, 18 Mar 2025 09:34:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561B207E18
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290465; cv=none; b=HV7sJ+smgIxQgyr9ldVQ9Yb0my8yxOAFwQuy3SGxmcnfOuSecRxXQFSqoFoz+yV0Ez02t89vzPNarToH1tls0m2ldk0aopDZ3ts92QGBW2YSaVGA1cl7zSANFCIz8fGFirsB+MsNGE5iE/hrjlwx9r7O2Z8WDfKe4BFqAVFJb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290465; c=relaxed/simple;
	bh=ehPzU4DJEAPmmLFyJciZ08r1EO3Xrp7ByFPIIC4bucQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m4HKtM8bI8Br3zmTZ4ZzUsd/a5MCeYJQwdA1XT5YKY8FvwrlBEaju4v4Ruo/1iCrC/zOkxymtOox7pLkz5lkhSzbOr41bRE638WxRTELpU83fj2B0MxRbooFgkMY7svVUXnuJ9XlI7iHr65avwtSRpBwfAN+kc07rJWjhFXlva8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKu-0005yB-LY; Tue, 18 Mar 2025 10:34:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKs-000OyM-2m;
	Tue, 18 Mar 2025 10:34:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-00Cmu6-0c;
	Tue, 18 Mar 2025 10:34:11 +0100
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
Subject: [PATCH net-next v4 00/10] Convert LAN78xx to PHYLINK
Date: Tue, 18 Mar 2025 10:34:00 +0100
Message-Id: <20250318093410.3047828-1-o.rempel@pengutronix.de>
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

changes v4:
- split "Improve error handling in PHY initialization" patch and move
  some parts before PHYlink porting to address some of compile warning
  as early as possible.
- add cleanup patch to remove unused struct members

This patch series refactors the LAN78xx USB Ethernet driver to use the
PHYLINK API.

Oleksij Rempel (10):
  net: usb: lan78xx: handle errors in lan7801 PHY initialization
  net: usb: lan78xx: handle errors in LED configuration during PHY init
  net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC
    management
  net: usb: lan78xx: improve error reporting on PHY attach failure
  net: usb: lan78xx: Improve error handling in PHY initialization
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Transition get/set_pause to phylink
  net: usb: lan78xx: Integrate EEE support with phylink LPI API
  net: usb: lan78xx: remove unused struct members

 drivers/net/usb/Kconfig   |   3 +-
 drivers/net/usb/lan78xx.c | 827 ++++++++++++++++++--------------------
 2 files changed, 402 insertions(+), 428 deletions(-)

--
2.39.5


