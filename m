Return-Path: <netdev+bounces-47626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469237EAC83
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 10:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAB9281127
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0FA15AD0;
	Tue, 14 Nov 2023 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YwKsFr5K"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041A156E2;
	Tue, 14 Nov 2023 09:08:10 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24BDD;
	Tue, 14 Nov 2023 01:08:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6E4EFC0007;
	Tue, 14 Nov 2023 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699952887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JYxYfDj45+EiZF7b5YinmOWx9EGt6+1KqgZ0mgDpW4w=;
	b=YwKsFr5KBTrFIrLiYeC7tbO81C8XsSXM4HpJfrcHkJtKR74iqQafCmBzGf57W2k/WV+NXk
	8xP63+JjlQK4JL+kF+do3eGcYNc1EjIcGtZFNwKH79tSpA4AbAxhhK0f9j8sBDHwIRITXB
	ZRWR44Uc6mRNKQFKR3E3N7ixRJkA8qwyolTZQqyHc2tZUZfSvLQkUGHshyUQhkV7eT2mud
	Y67N3R7Vljgv/BXzblZeA0jX/sTG7Z/r85hDX2+FrPzzDlamWHC/3NFRFxUEeJqDRSO4yn
	yb879SQcUO3NYYAuOulq/H2/nIbQQ1betYQkVImp7SqkyndA8A19d7yiUqPTsg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: davem@davemloft.net,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH net-next v2 0/8] net: qualcomm: ipqess: introduce Qualcomm IPQESS driver
Date: Tue, 14 Nov 2023 10:07:26 +0100
Message-ID: <20231114090743.865453-1-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is the 2nd iteration on the Qualcomm IPQ4019 Ethernet Switch Subsystem
driver.

Notable changes in v2:
 - Refactored the PSGMII calibration procedure to exclude
   PHY-model-specific code from the switch driver. Added two new callbacks
   to the phy_driver struct to enable PHY-agnostic calibration control from
   the MAC driver.
 - Modified the EDMA Ethernet driver to use page_pool for skb handling.
 - Refactored several qca8k-common.c functions to enable calling them from
   the IPQESS driver rather than reimplementing them.

The IPQ4019 SoC integrates a modified version of the QCA8K Ethernet switch.
One major difference with the original switch IP is that port tags are
passed to the integrated Ethernet controller out-of-band.

Previous DSA versions of this driver were rejected because they required
adding out-of-band tagging support to the DSA subsystem. Therefore, we
rewrote the driver as a pure switchdev module, which shares a common
backend library with the current QCA8K driver.

The main driver components are:
 - ipqess_switch.c which registers and configures the integrated switch
 - ipqess_port.c which creates net devices for each one of the front-facing
   ports.
 - ipqess_edma.c which handles the integrated EDMA Ethernet controller
   linked to the CPU port.
 - drivers/net/dsa/qca/qca8k-common.c which defines low-level ESS access
   methods common to this driver and the original DSA QCA8K driver.

Thanks to the people from Sartura for providing us hardware and working on
the base QCA8K driver, and to Maxime for his work on the EDMA code.

Best regards,

Romain

Romain Gantois (8):
  dt-bindings: net: Introduce the Qualcomm IPQESS Ethernet switch
  net: dsa: qca8k: Make the QCA8K hardware library available globally
  net: qualcomm: ipqess: introduce the Qualcomm IPQESS driver
  net: qualcomm: ipqess: Add Ethtool ops to IPQESS port netdevices
  net: qualcomm: ipqess: add bridge offloading features to the IPQESS
    driver
  net: phy: add calibration callbacks to phy_driver
  net: qualcomm: ipqess: add a PSGMII calibration procedure to the
    IPQESS driver
  ARM: dts: qcom: ipq4019: Add description for the IPQ4019 ESS EDMA and
    switch

 .../bindings/net/qcom,ipq4019-ess.yaml        |  152 ++
 MAINTAINERS                                   |    7 +
 .../boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi |   13 +
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      |   94 +
 drivers/net/dsa/qca/Kconfig                   |   10 +
 drivers/net/dsa/qca/Makefile                  |    5 +-
 drivers/net/dsa/qca/qca8k-8xxx.c              |   51 +-
 drivers/net/dsa/qca/qca8k-common.c            |  126 +-
 drivers/net/dsa/qca/qca8k-leds.c              |    2 +-
 drivers/net/ethernet/qualcomm/Kconfig         |   15 +
 drivers/net/ethernet/qualcomm/Makefile        |    2 +
 drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
 .../ethernet/qualcomm/ipqess/ipqess_calib.c   |  156 ++
 .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1195 ++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  488 +++++
 .../ethernet/qualcomm/ipqess/ipqess_ethtool.c |  245 +++
 .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++
 .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
 .../ethernet/qualcomm/ipqess/ipqess_port.c    | 1686 +++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |  102 +
 .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  533 ++++++
 .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   36 +
 .../net/dsa/qca => include/linux/dsa}/qca8k.h |   61 +-
 include/linux/phy.h                           |   28 +
 24 files changed, 5296 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_ethtool.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
 rename {drivers/net/dsa/qca => include/linux/dsa}/qca8k.h (90%)

-- 
2.42.0


