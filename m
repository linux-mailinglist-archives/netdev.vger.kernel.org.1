Return-Path: <netdev+bounces-156241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A273A05B34
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5DB1882AA9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397BD1FC7F5;
	Wed,  8 Jan 2025 12:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB961FBC82
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338436; cv=none; b=jnHgPE7wWtlZJQeK5S9Om6/q1md9eJEb7+pDVoS9PU0amnbaTKkvakWNXn5Y+GM0BzX7wawR7ilAbMlOxyq38U5K448Rg5CfHdR6M5WLteTr2WC5W25i9GZjl5UJBZJxMuQkijNH1wpI+OoHI+LHw5J3D/pOSi+LAmZHjVvDA/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338436; c=relaxed/simple;
	bh=sC5slS/IxssVCBtQvacT2yNAMKIJpy9/lUO/iWwWgPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Md0ZC9hkFUu51UXSAMtJny+jtuIFhWrTSYkKDJc9r807ViTwF8Z2RoCZYuiRgbwhz0zXIfKKO4lUBj566a38IBNLZshCQ/Lsf33tgYgjk6Vw6jI0drXBRiuIR2tQFi42Qnhna0+DKGZHWx3TFPHvnPln6LrgGrB6q18N+IuFpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwR-0002e3-PW; Wed, 08 Jan 2025 13:13:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwP-007W4Z-13;
	Wed, 08 Jan 2025 13:13:42 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwQ-00BHZb-05;
	Wed, 08 Jan 2025 13:13:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 0/7] Convert LAN78xx to PHYLINK
Date: Wed,  8 Jan 2025 13:13:34 +0100
Message-Id: <20250108121341.2689130-1-o.rempel@pengutronix.de>
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
PHYLINK API.

Oleksij Rempel (7):
  net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC
    management
  net: usb: lan78xx: Move fixed PHY cleanup to lan78xx_unbind()
  net: usb: lan78xx: Improve error handling for PHY init path
  net: usb: lan78xx: Use ethtool_op_get_link to reflect current link
    status
  net: usb: lan78xx: port link settings to phylink API
  net: usb: lan78xx: Transition get/set_pause to phylink
  net: usb: lan78xx: Enable EEE support with phylink integration

 drivers/net/usb/lan78xx.c | 785 +++++++++++++++++++-------------------
 1 file changed, 388 insertions(+), 397 deletions(-)

--
2.39.5


