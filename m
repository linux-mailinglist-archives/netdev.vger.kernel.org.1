Return-Path: <netdev+bounces-40696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704D7C85A3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85BD1C20B92
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89C014AA7;
	Fri, 13 Oct 2023 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4714A8C
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 12:24:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E79CC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 05:24:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qrHD6-00016C-4U; Fri, 13 Oct 2023 14:24:08 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qrHD4-001OKg-UQ; Fri, 13 Oct 2023 14:24:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qrHD4-00FiNS-2o;
	Fri, 13 Oct 2023 14:24:06 +0200
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 0/7] net: dsa: microchip: provide Wake on LAN support
Date: Fri, 13 Oct 2023 14:23:58 +0200
Message-Id: <20231013122405.3745475-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

changes v3:
- use ethernet address of DSA master instead from devicetree
- use dev_ops->wol* instead of list of supported switch
- don't shotdown the switch if WoL is enabled
- rework on top of latest HSR changes

changes v2:
- rebase against latest next

This series of patches provides Wake on LAN support for the KSZ9477
family of switches. It was tested on KSZ8565 Switch with PME pin
attached to an external PMIC.

The patch making WoL configuration persist on system shutdown will be
send separately, since it will potentially need more discussion.

Oleksij Rempel (7):
  net: dsa: microchip: Add missing MAC address register offset for
    ksz8863
  net: dsa: microchip: Set unique MAC at startup for WoL support
  net: dsa: microchip: ksz9477: add Wake on LAN support
  net: dsa: microchip: ksz9477: add Wake on PHY event support
  dt-bindings: net: dsa: microchip: add wakeup-source property
  net: dsa: microchip: use wakeup-source DT property to enable PME
    output
  net: dsa: microchip: do not shut down the switch if WoL is active

 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +
 drivers/net/dsa/microchip/ksz9477.c           | 116 +++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h           |   4 +
 drivers/net/dsa/microchip/ksz9477_i2c.c       |   3 +
 drivers/net/dsa/microchip/ksz_common.c        | 117 ++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h        |   7 ++
 drivers/net/dsa/microchip/ksz_spi.c           |   3 +
 7 files changed, 245 insertions(+), 7 deletions(-)

-- 
2.39.2


