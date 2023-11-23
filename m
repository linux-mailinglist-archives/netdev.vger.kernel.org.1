Return-Path: <netdev+bounces-50450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9700E7F5DA5
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87D11C20E35
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349F22F06;
	Thu, 23 Nov 2023 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72DCD48
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:21:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1r67lO-0002zs-FS; Thu, 23 Nov 2023 12:20:54 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1r67lM-00B1jJ-Ve; Thu, 23 Nov 2023 12:20:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1r67lM-002zWv-2w;
	Thu, 23 Nov 2023 12:20:52 +0100
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
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v6 0/3] Fine-Tune Flow Control and Speed Configurations in Microchip KSZ8xxx DSA Driver
Date: Thu, 23 Nov 2023 12:20:48 +0100
Message-Id: <20231123112051.713142-1-o.rempel@pengutronix.de>
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

changes v7:
- move pause controls out of duplex scope

changes v5:
- add Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
- use regs[S_BROADCAST_CTRL] instead of REG_SW_CTRL_4 as requested.
- s/synchronous/symmetric/
- make phylink_mac_link_up() not optional, as requested 

changes v4:
- instead of downstream/upstream use CPU-port and PHY-port
- adjust comments
- minor fixes

changes v3:
- remove half duplex flow control configuration
- add comments
- s/stram/stream

changes v2:
- split the patch to upstream and downstream part
- add comments
- fix downstream register offset
- fix CPU configuration

This patch set focuses on enhancing the configurability of flow
control, speed, and duplex settings in the Microchip KSZ8xxx DSA driver.

The first patch allows more granular control over the CPU port's flow
control, speed, and duplex settings. The second patch introduces a
method for port configurations for port with integrated PHYs, primarily
concerning flow control based on duplex mode.

Oleksij Rempel (3):
  net: dsa: microchip: ksz8: Make flow control, speed, and duplex on CPU
    port configurable
  net: dsa: microchip: ksz8: Add function to configure ports with
    integrated PHYs
  net: dsa: microchip: make phylink_mac_link_up() not optional

 drivers/net/dsa/microchip/ksz8.h       |   4 +
 drivers/net/dsa/microchip/ksz8795.c    | 127 ++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.c |   7 +-
 3 files changed, 132 insertions(+), 6 deletions(-)

-- 
2.39.2


