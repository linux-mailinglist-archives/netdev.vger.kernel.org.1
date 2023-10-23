Return-Path: <netdev+bounces-43516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CF7D3B63
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC39B2814F6
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2889F1C2BB;
	Mon, 23 Oct 2023 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SHW0P8+O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EB1BDFD;
	Mon, 23 Oct 2023 15:50:14 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE749D;
	Mon, 23 Oct 2023 08:50:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E1F01BF210;
	Mon, 23 Oct 2023 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698076207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vjTVkjCQdXsf3tUmJ77Jk9QRxhArGxc9gP+wJ5AuGB0=;
	b=SHW0P8+Ov4W6o8525HadMppMPrqfnbfazhjdIOG8bi/hKCuuAnUJGv4Y9s/tWDMj3wWeza
	5MvThii/WbcZI1pf9Dy+jr3Sh261/X8p9PWgK6WSPjv0FuQ3OiSRsbXrylZ0xs9d4Dxmr2
	TrD5k3OPv24PWvcBpUaGrZ+apxA4BeFfN6UnsqczQ/YWwHH1VueFyZpuUu4wvO1UWDcg4r
	a95InWiX+MUeY2XJy+DzWOSJOeCWfpzhXS71W31SIRV1peZITrDjul0WfpwY1abWXeDq3S
	otOSvwKr2nQwbOHrGigseB3KhpxUQ6qYBML20DVZWL64GKPau2u8Q74iVcbsug==
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
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 0/5] net: ipqess: introduce Qualcomm IPQESS driver
Date: Mon, 23 Oct 2023 17:50:07 +0200
Message-ID: <20231023155013.512999-1-romain.gantois@bootlin.com>
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

This is a driver for the Qualcomm IPQ4019 Ethernet Switch Subsystem. The
IPQ4019 SoC integrates a modified version of the QCA8K Ethernet switch. One
major difference with the original switch IP is that port tags are passed
to the integrated Ethernet controller out-of-band.

My colleague Maxime Chevallier submitted several iterations of this driver
about a year ago, here is the latest one:
https://lore.kernel.org/netdev/20221104174151.439008-1-maxime.chevallier@bootlin.com/

These series were rejected because they required adding out-of-band tagging
support to the DSA subsystem. Therefore, we rewrote the driver as a pure
switchdev module, which shares a common backend library with the current
QCA8K driver.

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

Romain Gantois (5):
  net: dt-bindings: Introduce the Qualcomm IPQESS Ethernet switch
  net: dsa: qca: Make the QCA8K hardware library available globally
  net: ipqess: introduce the Qualcomm IPQESS driver
  net: ipqess: add a PSGMII calibration procedure to the IPQESS driver
  dts: qcom: ipq4019: Add description for the IPQ4019 ESS EDMA and
    switch

 .../bindings/net/qcom,ipq4019-ess.yaml        |  152 ++
 MAINTAINERS                                   |    7 +
 .../boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi |   13 +
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      |   94 +
 drivers/net/dsa/qca/Kconfig                   |   10 +
 drivers/net/dsa/qca/Makefile                  |    5 +-
 drivers/net/dsa/qca/qca8k-8xxx.c              |    2 +-
 drivers/net/dsa/qca/qca8k-common.c            |   97 +-
 drivers/net/dsa/qca/qca8k-leds.c              |    2 +-
 drivers/net/ethernet/qualcomm/Kconfig         |   14 +
 drivers/net/ethernet/qualcomm/Makefile        |    2 +
 drivers/net/ethernet/qualcomm/ipqess/Makefile |    8 +
 .../ethernet/qualcomm/ipqess/ipqess_calib.c   |  495 ++++
 .../ethernet/qualcomm/ipqess/ipqess_edma.c    | 1162 ++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_edma.h    |  484 ++++
 .../qualcomm/ipqess/ipqess_notifiers.c        |  306 +++
 .../qualcomm/ipqess/ipqess_notifiers.h        |   29 +
 .../ethernet/qualcomm/ipqess/ipqess_port.c    | 2017 +++++++++++++++++
 .../ethernet/qualcomm/ipqess/ipqess_port.h    |   99 +
 .../ethernet/qualcomm/ipqess/ipqess_switch.c  |  559 +++++
 .../ethernet/qualcomm/ipqess/ipqess_switch.h  |   40 +
 .../net/dsa/qca => include/linux/dsa}/qca8k.h |   74 +-
 22 files changed, 5648 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-ess.yaml
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/Makefile
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_calib.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_edma.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_notifiers.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.c
 create mode 100644 drivers/net/ethernet/qualcomm/ipqess/ipqess_switch.h
 rename {drivers/net/dsa/qca => include/linux/dsa}/qca8k.h (87%)

-- 
2.42.0


