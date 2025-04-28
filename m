Return-Path: <netdev+bounces-186432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693BCA9F1AC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D958A3B76CC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FCA26D4F3;
	Mon, 28 Apr 2025 13:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E626A1D9
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845555; cv=none; b=sYH9eDikwTOjqAx94VmAMK1aVGKsOdS1QAgxtnR/MKjMYiJyaI5hKJKcQ0bh9Ai2vGSfani72tHXYY0W7epalC5wqWy2cNYjpczdANRB4TkdfPacps4gaxVbTAPXy6g2oX1NNl0pbQzsTPUNxJ9iU2KVxT0JD+Zi2skuGQ2eOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845555; c=relaxed/simple;
	bh=Oelxlnng9fWRmg0zTjkeoFQ3t5wbNtrQ8n930iYAT7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qjqFYiNe5TERBEMVShS0MYQU3qvvWzgHPiGKLjERv2ZYdEDg62IjITif7xmnYCrYNSlPxrhVyJtCW32lXdkF6yn+SaAXDpzd8KyqM/yFNN1TLRAR2DY7RwTq4o3dR1Kd9SlYfXy53J8ry/c+TDwms5Z7X1/r3NRiZFe6u75AzU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB7-0000MO-L7; Mon, 28 Apr 2025 15:05:45 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-0006FJ-0Q;
	Mon, 28 Apr 2025 15:05:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u9OB6-00GJ5n-09;
	Mon, 28 Apr 2025 15:05:44 +0200
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
Subject: [PATCH net-next v7 00/12] Convert LAN78xx to PHYLINK
Date: Mon, 28 Apr 2025 15:05:30 +0200
Message-Id: <20250428130542.3879769-1-o.rempel@pengutronix.de>
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

This patch series refactors the LAN78xx USB Ethernet driver to use the
PHYLINK framework for MAC and PHY management.

In the process, various improvements were made to structure the code and
separate concerns such as:
- Refactoring PHY detection and MAC-side interface setup
- Consolidating USB and flow control configuration into helpers
- Dropping legacy EEE and pause handling in favor of PHYLINK equivalents
- Simplifying the suspend/resume flow with proper phylink_suspend/resume
- Removing unused fields and outdated workarounds

changes v7:
- update against latest net-next

changes v6:
- Move unrelated logic out of the main PHYLINK conversion patch:
  - EEE handling, USB config, flow control, LED config, etc., now split
    into separate commits
- Remove obsolete members from struct lan78xx_net earlier, in the patch
  where they're no longer needed

changes v5:
- merge ethtool pause configuration patch with PHYlink patch
- merge some other small cleanup to a single patch

changes v4:
- split "Improve error handling in PHY initialization" patch and move
  some parts before PHYlink porting to address some of compile warning
  as early as possible.
- add cleanup patch to remove unused struct members

Oleksij Rempel (12):
  net: usb: lan78xx: Improve error handling in PHY initialization
  net: usb: lan78xx: remove explicit check for missing PHY driver
  net: usb: lan78xx: refactor PHY init to separate detection and MAC
    configuration
  net: usb: lan78xx: move LED DT configuration to helper
  net: usb: lan78xx: Extract PHY interrupt acknowledgment to helper
  net: usb: lan78xx: Refactor USB link power configuration into helper
  net: usb: lan78xx: Extract flow control configuration to helper
  net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC
    management
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Integrate EEE support with phylink LPI API
  net: usb: lan78xx: remove unused struct members

 drivers/net/usb/Kconfig   |    3 +-
 drivers/net/usb/lan78xx.c | 1114 +++++++++++++++++++++----------------
 2 files changed, 646 insertions(+), 471 deletions(-)

--
2.39.5


