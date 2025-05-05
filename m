Return-Path: <netdev+bounces-187691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA3AA8E7D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7CB1897544
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F381FF1D9;
	Mon,  5 May 2025 08:43:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038A1F8EFA
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434636; cv=none; b=nWTaWnFQp2u51aQtRR1h63fR/v3ygmk9x90F9nDDpE0hlku8ECYBDFWuybMenay46r9mAGM8VKwUQeB4aMEvHKHuLgWUy1iTCxjQfBMKuk0FMoChhetb6Ba283URmwDoH5j49/AcRHsASV+6pxXTX2mhcAVu/zLqdRw1eCz20AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434636; c=relaxed/simple;
	bh=qIvteqbLhdwo+nIU5NyrF66lRS0uWtrGhO5U+sF2oso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2KO4OmQuGWMJaKGVmt+Nv6Wns4JkyeIsaF5X7U10sM88u+HxxuJEXrJ8fnRoft0W5E+/kLh6iEQjRMR7T9PBW5A6g2t5izKYx1v0s/dZ7d9zP9TqzT1GzGi6pfQWyTs0akDsxXj78XSBQa+wfj8Xw2CmvygT692busHv/v5Dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQN-0005W5-Al; Mon, 05 May 2025 10:43:43 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-001CS9-11;
	Mon, 05 May 2025 10:43:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uBrQM-003SPb-0k;
	Mon, 05 May 2025 10:43:42 +0200
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
Subject: [PATCH net-next v8 0/7]  lan78xx: preparation for PHYLINK conversion
Date: Mon,  5 May 2025 10:43:34 +0200
Message-Id: <20250505084341.824165-1-o.rempel@pengutronix.de>
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

This patch series contains the first part of the LAN78xx driver
refactoring in preparation for converting the driver to use the PHYLINK
framework.

The goal of this initial part is to reduce the size and complexity of
the final PHYLINK conversion by introducing incremental cleanups and
logical separation of concerns, such as:

- Improving error handling in the PHY initialization path
- Refactoring PHY detection and MAC-side configuration
- Moving LED DT configuration to a dedicated helper
- Separating USB link power and flow control setup from the main probe logic
- Extracting PHY interrupt acknowledgment logic

Each patch is self-contained and moves non-PHYLINK-specific logic out of
the way, setting the stage for the actual conversion in a follow-up
patch series.

changes v8 (as split from full v7 00/12 series):
- Split the original series to make review easier
- This part includes only preparation patches; actual PHYLINK
  integration will follow

Oleksij Rempel (7):
  net: usb: lan78xx: Improve error handling in PHY initialization
  net: usb: lan78xx: remove explicit check for missing PHY driver
  net: usb: lan78xx: refactor PHY init to separate detection and MAC
    configuration
  net: usb: lan78xx: move LED DT configuration to helper
  net: usb: lan78xx: Extract PHY interrupt acknowledgment to helper
  net: usb: lan78xx: Refactor USB link power configuration into helper
  net: usb: lan78xx: Extract flow control configuration to helper

 drivers/net/usb/lan78xx.c | 462 ++++++++++++++++++++++++++++----------
 1 file changed, 343 insertions(+), 119 deletions(-)

--
2.39.5


