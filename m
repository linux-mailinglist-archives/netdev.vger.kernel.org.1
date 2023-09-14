Return-Path: <netdev+bounces-33740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A579FD7D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F30A1C20B2F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B70C8E7;
	Thu, 14 Sep 2023 07:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942C62C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:51:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C361BF6
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 00:51:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qgh82-0001Gu-Be; Thu, 14 Sep 2023 09:51:10 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qgh80-006Fd8-Ld; Thu, 14 Sep 2023 09:51:08 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qgh80-009P3t-1n;
	Thu, 14 Sep 2023 09:51:08 +0200
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
Subject: [PATCH net-next v5 0/2] net: dsa: microchip: add drive strength support 
Date: Thu, 14 Sep 2023 09:51:05 +0200
Message-Id: <20230914075107.2239886-1-o.rempel@pengutronix.de>
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

changes v5:
- rename milliamp to microamp
- do not expect negative error code on snprintf
- set coma after last struct element
- rename found to have_any_prop

changes v4:
- integrate microchip feedback to the ksz9477_drive_strengths comment.
- add Reviewed-by: Rob Herring <robh@kernel.org>

changes v3:
- yaml: use enum instead of min/max
- do not use snprintf() on overlapping buffer.
- unify ksz_drive_strength_to_reg() and ksz_drive_strength_error(). Make
  it usable for KSZ9477 and KSZ8830 variants.
- use ksz_rmw8() in ksz9477_drive_strength_write()

changes v2:
- make it work on all know KSZ* variants except of undocumented LAN*
  switches
- add io-drive-strength compatible for ksz88xx chips
- test exact drive strength instead of nearest closest.
- add comment and refactor the code

Oleksij Rempel (2):
  dt-bindings: net: dsa: microchip: Update ksz device tree bindings for
    drive strength
  net: dsa: microchip: Add drive strength configuration

 .../bindings/net/dsa/microchip,ksz.yaml       |  20 ++
 drivers/net/dsa/microchip/ksz8795_reg.h       |  14 -
 drivers/net/dsa/microchip/ksz9477_reg.h       |  13 -
 drivers/net/dsa/microchip/ksz_common.c        | 309 ++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h        |  20 ++
 5 files changed, 349 insertions(+), 27 deletions(-)

-- 
2.39.2


