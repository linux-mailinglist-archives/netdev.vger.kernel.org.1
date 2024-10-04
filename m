Return-Path: <netdev+bounces-131924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B798FF31
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF7B281EAB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC970146D65;
	Fri,  4 Oct 2024 09:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA75144D0A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032487; cv=none; b=ZqFILoS4YG6ctWnkOYv7dzVFPuXNZZq/Olnw35o269ol140BuZ78hAlm1Lb9WmGPByt5HYWDGIBPWpZl4kPSMsFW/HPyHDKo7tzBn6wOVM9m7LzFSavDG6TF5Bx+UXLo8N91i87yggIqhNB2Maod2dHpcS/uP09C1btOVTokxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032487; c=relaxed/simple;
	bh=WJZI5f7afmQeyKcBF75Gok4Nh3/Flinw7pR96fnP/yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LGtYdipor7KmaBig4V7eB59Xbkqoz8wIAJgByepyq56u9XuBiZ6R9HPT0P8Q/bQkU4rsFnSkKlIy3KWCZr1oKqXWoVnqIrDpA7FD5myfHloEgPwJRpZ1HtmVcSGFRTYvYv963b3gbmHlloV7byUDnW2jWIdBO8xZMs9zEFxp5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sweBK-0004Yo-QF; Fri, 04 Oct 2024 11:01:02 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sweBJ-003X8H-4B; Fri, 04 Oct 2024 11:01:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sweBJ-006wNU-0B;
	Fri, 04 Oct 2024 11:01:01 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	Divya.Koppera@microchip.com
Subject: [PATCH net-next v5 0/2] net: phy: Support master-slave config via device tree
Date: Fri,  4 Oct 2024 11:00:58 +0200
Message-Id: <20241004090100.1654353-1-o.rempel@pengutronix.de>
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

This patch series adds support for configuring the master/slave role of
PHYs via the device tree. A new `master-slave` property is introduced in
the device tree bindings, allowing PHYs to be forced into either master
or slave mode. This is particularly necessary for Single Pair Ethernet
(SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
available or correctly configured, but it is applicable to all PHY
types.

changes v5:
- sync DT options with ethtool nameing.

changes v4:
- add Reviewed-by
- rebase against latest net-next

changes v3:
- rename  master-slave to timing-role
- add prefer-master/slave support

Oleksij Rempel (2):
  dt-bindings: net: ethernet-phy: Add timing-role role property for
    ethernet PHYs
  net: phy: Add support for PHY timing-role configuration via device
    tree

 .../devicetree/bindings/net/ethernet-phy.yaml | 21 ++++++++++++
 drivers/net/phy/phy-core.c                    | 33 +++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  3 ++
 include/linux/phy.h                           |  1 +
 4 files changed, 58 insertions(+)

--
2.39.5


