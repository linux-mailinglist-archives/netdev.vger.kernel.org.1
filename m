Return-Path: <netdev+bounces-202876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA02AAEF837
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD717ACCA0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13F26CE10;
	Tue,  1 Jul 2025 12:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD019994F
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372519; cv=none; b=KHRRuMj6+XN7tJTbW9Y0cYBIenDwcHVbkOR3d3Shg63gttkRT5hcLQrOpQ0X/hlFoJDSAx+Xy16jYYy/8RpV7CcHNj5QgYgkjTEWgRVkDor1pP7Rzzc9Gb+xsjGCXQbhMXuBhJiosQ0YMyO7LAAnby5tlodDsLWAYTDxZGrbhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372519; c=relaxed/simple;
	bh=eSDv5lNnaaHDCNYMnyrzvsMt3cx1EZuw6AXE2orFyUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KU743Q1AY+0N+nSxcgN9a2ZwlML+Q6xvCMwsBcA0FVZILAcOFvyrs3CA0nnVPZMq1iF0A66ez3JEvb1AdAfCdmSVCZHeeMIDBQiigwFl9qo/ze+5p9Wt5bdMR4LEpIixYLj72kIoBfO3ogV8eG4kSUZlQ1uD1Gv5NmZ/U53Q660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzh-0007K0-6S; Tue, 01 Jul 2025 14:21:49 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-006GdD-29;
	Tue, 01 Jul 2025 14:21:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uWZzf-0009GI-1s;
	Tue, 01 Jul 2025 14:21:47 +0200
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
Subject: [PATCH net v1 0/4] net: phy: smsc: robustness fixes for LAN87xx/LAN9500
Date: Tue,  1 Jul 2025 14:21:42 +0200
Message-Id: <20250701122146.35579-1-o.rempel@pengutronix.de>
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

Hi all,

The SMSC 10/100 PHYs (LAN87xx family) found in smsc95xx (lan95xx)
USB-Ethernet adapters show several quirks around the Auto-MDIX feature:

- A hardware strap (AUTOMDIX_EN) may boot the PHY in fixed-MDI mode, and
  the current driver cannot always override it.

- When Auto-MDIX is left enabled while autonegotiation is forced off,
  the PHY endlessly swaps the TX/RX pairs and never links up.

- The driver sets the enable bit for Auto-MDIX but forgets the override
  bit, so userspace requests are silently ignored.

- Rapid configuration changes can wedge the link if PHY IRQs are
  enabled.

The four patches below make the MDIX state fully predictable and prevent
link failures in every tested strap / autoneg / MDI-X permutation.

Tested on LAN9512 Eval board.

Best Regards,
Oleksij

Oleksij Rempel (4):
  net: phy: smsc: Fix Auto-MDIX configuration when disabled by strap
  net: phy: smsc: Force predictable MDI-X state on LAN87xx
  net: phy: smsc: Fix link failure in forced mode with Auto-MDIX
  net: phy: smsc: Disable IRQ support to prevent link state corruption

 drivers/net/phy/smsc.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

--
2.39.5


