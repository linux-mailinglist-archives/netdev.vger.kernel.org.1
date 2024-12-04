Return-Path: <netdev+bounces-148893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD479E35AA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554A7165D83
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C219993D;
	Wed,  4 Dec 2024 08:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FC192B8A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301714; cv=none; b=OI8qURpg3NtCOjqbIjjAooCZLX/3wcjQRwFYexuK3wXUN4HDgw+SypLKV1QwQliUnhcoVBipuUnSNl4WT+ndMpXzBm7KLTxLY3JXPy4WTcocQfpl37jlAIVAU9JcfGYaNe5ZEfS6vfHRHf3B/eqBiPqg16GjMGfa0bK6ycaK310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301714; c=relaxed/simple;
	bh=IKDPfExthKtx+seYruE/9nS6YGL3LxsWsGO3Vnufd+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9ziHNAPKc7BwiWamMGM6acugUoVzzj/6oBoEqZ/3cq1gEeLSwK98sHwenkdIZIKKeweey4rXNogOHezf8/M/1iMrERRifJGbxHMeGXyZ6xgOqDSl7KQK4qschA2m5sFIk0YIwDDdhmdqnEhCId+iOb9aRC4QUD9hkTCN22cnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001Hz-42; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cU6-0H;
	Wed, 04 Dec 2024 09:41:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004psV-2X;
	Wed, 04 Dec 2024 09:41:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 00/21] lan78xx: Preparations for PHYlink
Date: Wed,  4 Dec 2024 09:41:32 +0100
Message-Id: <20241204084142.1152696-1-o.rempel@pengutronix.de>
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

changes v2:
- split the patch set.

This patch set is part of the preparatory work for migrating the lan78xx
USB Ethernet driver to the PHYlink framework. During extensive testing,
I observed that resetting the USB adapter can lead to various read/write
errors. While the errors themselves are acceptable, they generate
excessive log messages, resulting in significant log spam. This set
improves error handling to reduce logging noise by addressing errors
directly and returning early when necessary.

Key highlights of this series include:
- Enhanced error handling to reduce log spam while preserving the
  original error values, avoiding unnecessary overwrites.
- Improved error reporting using the `%pe` specifier for better clarity
  in log messages.
- Removal of redundant and problematic PHY fixups for LAN8835 and
  KSZ9031, with detailed explanations in the respective patches.
- Cleanup of code structure, including unified `goto` labels for better
  readability and maintainability, even in simple editors.

Oleksij Rempel (10):
  net: usb: lan78xx: Remove LAN8835 PHY fixup
  net: usb: lan78xx: Remove KSZ9031 PHY fixup
  net: usb: lan78xx: move functions to avoid forward definitions
  net: usb: lan78xx: Improve error reporting with %pe specifier
  net: usb: lan78xx: Fix error handling in MII read/write functions
  net: usb: lan78xx: Improve error handling in EEPROM and OTP operations
  net: usb: lan78xx: Add error handling to lan78xx_init_ltm
  net: usb: lan78xx: Add error handling to set_rx_max_frame_length and
    set_mtu
  net: usb: lan78xx: Add error handling to lan78xx_irq_bus_sync_unlock
  net: usb: lan78xx: Improve error handling in dataport and multicast
    writes

 drivers/net/usb/lan78xx.c | 785 +++++++++++++++++++++-----------------
 1 file changed, 433 insertions(+), 352 deletions(-)

--
2.39.5


