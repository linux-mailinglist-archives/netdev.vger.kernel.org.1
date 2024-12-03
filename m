Return-Path: <netdev+bounces-148370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD50D9E13FE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213F1B23EEB
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7F1E049E;
	Tue,  3 Dec 2024 07:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CB41DD86E
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210530; cv=none; b=msJF5dXIz5OWx9JRTBZDERUqy55BNspEGEkS+y1tSrHfxOxoOkx/SS9nQ9JPCxrH6D3XG3d34DiJOSh3YNt7tAJ26oKZzO2jPIZxyzWDi6upGSD0Tu9Z03izDqbWydUoHn5RL0bh8hUr6LV1RbMChFH1OOuHl9/wvyJRP5ZJToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210530; c=relaxed/simple;
	bh=mGDid1ehrOdamOqJz3u1exKDT5Bj0RLZfdq1ZKei79g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a1+FKm8xbILrsey7h1DKWb4tlFXUu6/q3s9EB6nhIF7CXmAzlmPJxL3APq23qoAeX4aQOOMpaFHbaxzhMyNueXDlbkok5kCkoly1wLJ/PGcpviplhPuwGGv5bL1zDFFI/8WDXOQaqRPLeK3xcHG8eXgM/CPpbUgR6i6IIG7Pgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004rx-6F; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEI-001Qyj-34;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEmQ-26;
	Tue, 03 Dec 2024 08:21:55 +0100
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
Subject: [PATCH net-next v1 00/21] lan78xx: Preparations for PHYlink
Date: Tue,  3 Dec 2024 08:21:33 +0100
Message-Id: <20241203072154.2440034-1-o.rempel@pengutronix.de>
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

Oleksij Rempel (21):
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
  net: usb: lan78xx: Add error handling to lan78xx_setup_irq_domain
  net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
  net: usb: lan78xx: Add error handling to lan78xx_set_mac_addr
  net: usb: lan78xx: Add error handling to lan78xx_get_regs
  net: usb: lan78xx: Simplify lan78xx_update_reg
  net: usb: lan78xx: Fix return value handling in lan78xx_set_features
  net: usb: lan78xx: Use ETIMEDOUT instead of ETIME in lan78xx_stop_hw
  net: usb: lan78xx: Use function-specific label in lan78xx_mac_reset
  net: usb: lan78xx: Improve error handling in lan78xx_phy_wait_not_busy
  net: usb: lan78xx: Rename lan78xx_phy_wait_not_busy to
    lan78xx_mdiobus_wait_not_busy
  net: usb: lan78xx: Improve error handling in WoL operations

 drivers/net/usb/lan78xx.c | 916 +++++++++++++++++++++-----------------
 1 file changed, 519 insertions(+), 397 deletions(-)

--
2.39.5


