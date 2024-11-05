Return-Path: <netdev+bounces-141852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740059BC8B1
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C3B283850
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D261D0F66;
	Tue,  5 Nov 2024 09:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CC1CF7AA
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797809; cv=none; b=r1NVASuQ9iAwhnobfuA+UbVCd3cN1BdR/gbzkr/yEUBOsZ8M4oZWjl322u33DqiiV9dSxJtx13beiEvHNPudxDHqPy7nFnMO87G7GS6Z57vJmvKiBAFseRIYD+JKbMNYTcrXwHmNO+nKXI5KsyUN1SaubFcnRLQnI21bDkAelr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797809; c=relaxed/simple;
	bh=s78LXm8oVlRxWfFmr0IdFkBYHf7fRypjYC9GfgbS9lI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hY5v6Z21G8v1nfFRi4OwR0U148VH3NZh8IPVkRxdblFnceRmsTAf7JmPUePcNfI+kmXiFVphRSSNQN1H2EECs29QxoJvpoc9fcomsMFgVfbOn2Z2qjMj3wmZkXpK0Ohgm+uPQ/zf0AtkD4YwzPDygsuAv0x8gmrE6oPNp6w/KCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZL-0003oL-Rq; Tue, 05 Nov 2024 10:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-0027YS-18;
	Tue, 05 Nov 2024 10:09:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-002ofR-0s;
	Tue, 05 Nov 2024 10:09:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH net-next v3 0/6] Side MDIO Support for LAN937x Switches
Date: Tue,  5 Nov 2024 10:09:38 +0100
Message-Id: <20241105090944.671379-1-o.rempel@pengutronix.de>
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

This patch set introduces support for an internal MDIO bus in LAN937x
switches, enabling the use of a side MDIO channel for PHY management
while keeping SPI as the main interface for switch configuration.

changes v3:
- add "net: dsa: microchip: parse PHY config from device tree" patch

other changelogs are added to separate patches.

Oleksij Rempel (6):
  dt-bindings: net: dsa: ksz: add internal MDIO bus description
  dt-bindings: net: dsa: ksz: add mdio-parent-bus property for internal
    MDIO
  net: dsa: microchip: Refactor MDIO handling for side MDIO access
  net: dsa: microchip: cleanup error handling in ksz_mdio_register
  net: dsa: microchip: add support for side MDIO interface in LAN937x
  net: dsa: microchip: parse PHY config from device tree

 .../bindings/net/dsa/microchip,ksz.yaml       |  20 ++
 drivers/net/dsa/microchip/ksz_common.c        | 260 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |  59 ++++
 drivers/net/dsa/microchip/lan937x.h           |   2 +
 drivers/net/dsa/microchip/lan937x_main.c      | 226 +++++++++++++--
 drivers/net/dsa/microchip/lan937x_reg.h       |   4 +
 6 files changed, 539 insertions(+), 32 deletions(-)

--
2.39.5


