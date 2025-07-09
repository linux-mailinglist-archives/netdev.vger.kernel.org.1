Return-Path: <netdev+bounces-205375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45440AFE638
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3011890EF9
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431F2BF016;
	Wed,  9 Jul 2025 10:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC928ECDA
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057754; cv=none; b=S7bF1TycEf5kbnb5zMsfik8Xjboqla9wHGYvYDWrzAY0tVTDcL2y+RYBj3lf5+YTOTufo1aD475YSUFidiWxDVg68CeKiTPVAAHHFKcWzMFPOS1riZixg1kmOOv9t7lHIdtLOW09BpaSJSMVebyL8/iwMkTHpe0iSqtaAsWrUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057754; c=relaxed/simple;
	bh=IhrULyZ56NYjD/kQd/0N+EbFDTJWThM/94GBb5oDbgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Uiw4W36L95fCKtCHwFqHMbd/W/YvKbquyBajODzsiFbiG2bjeRHyBWMjIKY1AqrgISWkx1CtUJmB1DndTy2Tvg6u8x+JLmE7m+j54tRUHgQu+9JxAZBRW7NIe4vnprTVfN+DduugK5CeBapFxJmnWkawBwhk/8Xdb6up4SvU4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFh-0004mp-8w; Wed, 09 Jul 2025 12:42:13 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFf-007ZJi-2M;
	Wed, 09 Jul 2025 12:42:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFf-00FyRK-27;
	Wed, 09 Jul 2025 12:42:11 +0200
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
Subject: [PATCH net v2 0/3] net: phy: smsc: use IRQ + relaxed polling to fix missed link-up
Date: Wed,  9 Jul 2025 12:42:07 +0200
Message-Id: <20250709104210.3807203-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This series makes the SMSC LAN8700 (as used in LAN9512 and similar USB
adapters) reliable again in configurations where it is forced to 10 Mb/s
and the link partner still advertises autonegotiation.

In this scenario, the PHY may miss the final link-up interrupt, causing
the network interface to remain down even though a valid link is
present.

To address this:

Patch 1 – phylib: Enable polling if the driver implements
get_next_update_time(). This ensures the state machine is active even
without update_stats().

Patch 2 – phylib: Allow drivers to return PHY_STATE_IRQ to explicitly
disable polling.

Patch 3 – smsc: Implement get_next_update_time() with adaptive 1 Hz
polling for up to 30 seconds after the last interrupt in the affected
10M autoneg-off mode.  All other configurations rely on IRQs only.

Testing:

The LAN9512 (LAN8700 core) was tested against an Intel I350 NIC using
baseline, parallel-detection, and advertisement test suites. All
relevant tests passed.

Changes in v2:
- Introduced explicit disable polling via PHY_STATE_IRQ
- Changed the workaround logic to apply 1 Hz polling only for 30 seconds
  after the last IRQ
- Dropped relaxed 30s polling while link is up
- Reworded commit messages and comments to reflect updated logic
- Split core changes into two separate patches for clarity

Thanks,
Oleksij Rempel

Oleksij Rempel (3):
  net: phy: enable polling when driver implements get_next_update_time
  net: phy: allow drivers to disable polling via get_next_update_time()
  net: phy: smsc: recover missed link-up IRQs on LAN8700 with adaptive
    polling

 drivers/net/phy/phy.c  | 18 +++++++++++-------
 drivers/net/phy/smsc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h    | 12 ++++++++++--
 3 files changed, 61 insertions(+), 9 deletions(-)

--
2.39.5


