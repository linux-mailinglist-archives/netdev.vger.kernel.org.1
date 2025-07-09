Return-Path: <netdev+bounces-205417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD5AFE9A7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BC31C8131F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45732DECA7;
	Wed,  9 Jul 2025 13:08:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EE2DAFAF
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066489; cv=none; b=fyF7hfcCT0x6Ov3BbRIfKSWAXWM7ZqxahAvRjTpIDiemNI2ZEFmUbuDFuSXMuvrAKTPz0slu5lq0jAQdPhanXbP6+HF+5DQH/C1dfpCkEGiz68IbTZLmLImsv2ijt2kpVFtu0Tl57sewpLrBYj4Iu7em4t9p22fqlPEYEQAfg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066489; c=relaxed/simple;
	bh=KMmyxxp/2NAzSNq9qfdzvsVxjDwXd1ZBe0L2YncoTOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LjzJnkMEacszIBY4hcjJH80XJAX5uL5Vrb6p+Jy/totCdhDrBx7hvZN7BOHG4RKGypzZlL8yv1c3NyRppc4tdbueVwn71JNiFEpTVtcCatfWfDPHO82FexGirspyDYqqpoqGPdxp0G9RPp2OS9W7/gMdQf5r8oh8T0RQNjiK5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZUWj-00036b-Fp; Wed, 09 Jul 2025 15:07:57 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZUWi-007afP-0P;
	Wed, 09 Jul 2025 15:07:56 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZUWi-00Gl9A-08;
	Wed, 09 Jul 2025 15:07:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net v1 0/2] net: phy: microchip: LAN88xx reliability fixes
Date: Wed,  9 Jul 2025 15:07:51 +0200
Message-Id: <20250709130753.3994461-1-o.rempel@pengutronix.de>
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

This patch series improves the reliability of the Microchip LAN88xx
PHYs, particularly in edge cases involving fixed link configurations or
forced speed modes.

Patch 1 assigns genphy_soft_reset() to the .soft_reset hook to ensure
that stale link partner advertisement (LPA) bits are properly cleared
during reconfiguration. Without this, outdated autonegotiation bits may
remain visible in some parallel detection cases.

Patch 2 restricts the 100 Mbps workaround (originally intended to handle
cable length switching) to only run when the link transitions to the
PHY_NOLINK state. This prevents repeated toggling that can confuse
autonegotiating link partners such as the Intel i350, leading to
unstable link cycles.

Both patches were tested on a LAN7850 (with integrated LAN88xx PHY)
against an Intel I350 NIC. The full test suite - autonegotiation, fixed
link, and parallel detection - passed successfully.

Oleksij Rempel (2):
  net: phy: microchip: Use genphy_soft_reset() to purge stale LPA bits
  net: phy: microchip: limit 100M workaround to link-down events on
    LAN88xx

 drivers/net/phy/microchip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
2.39.5


