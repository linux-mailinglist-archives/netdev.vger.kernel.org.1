Return-Path: <netdev+bounces-191129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D84ABA24D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454EF1BA4E16
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E634C27817C;
	Fri, 16 May 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="IDpC/Q9n"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7D221719;
	Fri, 16 May 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418526; cv=none; b=F6kCzYB6V0pamZoYS1TBwO88XHdhPmEp15A0VgtVJJZU1N93i5e4A5o43ILEjh1AAfqWafqXdfNmlzAJ3qynC4693LpbmKY0/FxIJWTdhpRAfwsP+AQsP//kcoxnOuzzn1ogd69UPp6sy3p0VMyiClF36TBpfMKWDBaDrSH6sPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418526; c=relaxed/simple;
	bh=UuF/JNUJBZ53+cPezbxA19lKN/JAyHQZ9Ehmog69s08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHw8bGvj0xrtEIqvZVReKMvmTB3rqiN1uYVY3P2Et9QBCjoqzo//NaUCLb94RCbGWaWiNaN/8YnnFrjd3sKOPktKBcQkGFEHkdHRdUa5nf9QWJWHWSePph7MYhX0cSm8qJQeNVGUQ5I0/mVsg4I2Cy0R0J7qDY/ZboAkZMcd77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=IDpC/Q9n; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 0EC785FCB0;
	Fri, 16 May 2025 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+JWgG7Xrb6kxHm/xBKBKplVRGDNZd7l9BWTCNftkPlo=;
	b=IDpC/Q9nRdQRXK07+fcgEwZW75VKBwMst5E+e4D80srfYhdwyAFBS0ykeaQEhis9D5K/Mt
	rmlKzEUgu82nwjK21lyQeaGGsGmMjnq0r01km9cVo9aBAY6LLS3YRceQkPZavqqnicPigT
	9vp9f4y3eEFltnfyfLtyOoTmOkYIoQg=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id B069A1226D6;
	Fri, 16 May 2025 18:01:54 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 00/14] further mt7988 devicetree work
Date: Fri, 16 May 2025 20:01:30 +0200
Message-ID: <20250516180147.10416-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series continues mt7988 devicetree work

- Add SPI with BPI-R4 nand to reach eMMC
- Add thermal protection (fan+cooling-points)
- Extend cpu frequency scaling with CCI
- Basic network-support (ethernet controller + builtin switch + SFP Cages)

depencies (i hope this list is complete and latest patches/series linked):

"Add Bananapi R4 variants and add xsphy" (reviewed, partially applied):
https://patchwork.kernel.org/project/linux-mediatek/list/?series=955733

"net: phy: mediatek: do not require syscon compatible for pio property":
https://patchwork.kernel.org/project/netdevbpf/patch/20250510174933.154589-1-linux@fw-web.de/
for phy led function (RFC not yet reviewed, resent without RFC)

for 2.5g phy function (currently disabled):
- net: ethernet: mtk_eth_soc: add support for MT7988 internal 2.5G PHY (already merged to 6.15-net-next)
- net: phy: mediatek: add driver for built-in 2.5G ethernet PHY on MT7988
  https://patchwork.kernel.org/project/netdevbpf/patch/20250516102327.2014531-3-SkyLake.Huang@mediatek.com/ (v4)

for SFP-Function (macs currently disabled):

PCS clearance which is a 1.5 year discussion currently ongoing

e.g. something like this (one of):
* https://patchwork.kernel.org/project/netdevbpf/patch/20250511201250.3789083-4-ansuelsmth@gmail.com/ (v4)
* https://patchwork.kernel.org/project/netdevbpf/patch/20250512161013.731955-4-sean.anderson@linux.dev/ (v4)
* https://patchwork.kernel.org/project/netdevbpf/patch/ba4e359584a6b3bc4b3470822c42186d5b0856f9.1721910728.git.daniel@makrotopia.org/

full usxgmii driver:
https://patchwork.kernel.org/project/netdevbpf/patch/07845ec900ba41ff992875dce12c622277592c32.1702352117.git.daniel@makrotopia.org/

first PCS-discussion is here:
https://patchwork.kernel.org/project/netdevbpf/patch/8aa905080bdb6760875d62cb3b2b41258837f80e.1702352117.git.daniel@makrotopia.org/

and then dts nodes for sgmiisys+usxgmii

when above depencies are solved the mac1/2 can be enabled and 2.5G phy/SFP slots will work.

changes:
v2:
  - change reg to list of items in eth binding
  - changed mt7530 binding:
    - unevaluatedProperties=false
    - mediatek,pio subproperty
    - from patternProperty to property
  - board specific properties like led function and labels moved to bpi-r4 dtsi

Frank Wunderlich (14):
  dt-bindings: net: mediatek,net: update for mt7988
  dt-bindings: net: dsa: mediatek,mt7530: add dsa-port definition for
    mt7988
  dt-bindings: net: dsa: mediatek,mt7530: add internal mdio bus
  arm64: dts: mediatek: mt7988: add spi controllers
  arm64: dts: mediatek: mt7988: move uart0 and spi1 pins to soc dtsi
  arm64: dts: mediatek: mt7988: add cci node
  arm64: dts: mediatek: mt7988: add phy calibration efuse subnodes
  arm64: dts: mediatek: mt7988: add basic ethernet-nodes
  arm64: dts: mediatek: mt7988: add switch node
  arm64: dts: mediatek: mt7988a-bpi-r4: Add fan and coolingmaps
  arm64: dts: mediatek: mt7988a-bpi-r4: configure spi-nodes
  arm64: dts: mediatek: mt7988a-bpi-r4: add proc-supply for cci
  arm64: dts: mediatek: mt7988a-bpi-r4: add sfp cages and link to gmac
  arm64: dts: mediatek: mt7988a-bpi-r4: configure switch phys and leds

 .../bindings/net/dsa/mediatek,mt7530.yaml     |  24 +-
 .../devicetree/bindings/net/mediatek,net.yaml |  10 +-
 .../mediatek/mt7988a-bananapi-bpi-r4-2g5.dts  |  11 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  18 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi | 158 ++++++-
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 389 +++++++++++++++++-
 6 files changed, 590 insertions(+), 20 deletions(-)

-- 
2.43.0


