Return-Path: <netdev+bounces-196009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3DBAD317E
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F7F172C99
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F13928BA93;
	Tue, 10 Jun 2025 09:14:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213FD28B509
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546850; cv=none; b=KQIofKolnIp5GLC6Xxc5SuiS+lbB4iAxX6go1nGQD4fSQPrBWe5q7rmMMhqHjug1Y5CoyPSJdSsbDDOFYfect4s3tdYPdvEVC+/mLXSb2vWph3E7MLnQCQZkPk6TgDw9aqZ2QWKg0pkY3/YR/Jkv3sUuaJbqnsdG5qm+QppQbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546850; c=relaxed/simple;
	bh=eAP/Pgxs/9S4eWPhajMtCxZYCSMA8XaOpnWO4Mni19I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bXUzg7M0LNaLTNl69qzOuJ7mSD6m9zoR21lg1QaYvxCHWBP7xVlY4O4zGd/4vDW4UNGEhPXK81DMGCKLLpodapK/AMLSK3jFf91i+zugFudjSgILRaee1prDxIOSul54ixeOcTKcFyq9gje82IkFEas+wIs+Guc3kHXmxK5D5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3M-000487-VW; Tue, 10 Jun 2025 11:13:57 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3L-002kQH-1d;
	Tue, 10 Jun 2025 11:13:55 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOv3L-00H2Jv-1O;
	Tue, 10 Jun 2025 11:13:55 +0200
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
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 0/3] net: phy: micrel: add extended PHY support for KSZ9477-class devices
Date: Tue, 10 Jun 2025 11:13:51 +0200
Message-Id: <20250610091354.4060454-1-o.rempel@pengutronix.de>
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

Hi all,

This patch series extends the PHY driver support for the Microchip
KSZ9477-class switch-integrated PHYs. These changes enhance ethtool
functionality and diagnostic capabilities by implementing the following
features:
- MDI/MDI-X configuration support
  All crossover modes (auto, MDI, MDI-X) are now configurable.

- RX error counter reporting
  The RXER counter (reg 0x15) is now accumulated and exported via
ethtool stats.

- Cable test support
  Reuses the KSZ9131 implementation to enable open/short fault
detection and approximate fault length reporting.

Oleksij Rempel (3):
  net: phy: micrel: add MDI/MDI-X control support for KSZ9477
    switch-integrated PHYs
  net: phy: micrel: Add RX error counter support for KSZ9477
    switch-integrated PHYs
  net: phy: micrel: add cable test support for KSZ9477-class PHYs

 drivers/net/phy/micrel.c | 111 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

--
2.39.5


