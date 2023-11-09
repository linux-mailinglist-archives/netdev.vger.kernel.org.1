Return-Path: <netdev+bounces-46934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E447E73E8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 22:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C531C209F0
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 21:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AC38DF5;
	Thu,  9 Nov 2023 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81237157;
	Thu,  9 Nov 2023 21:51:16 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A14212;
	Thu,  9 Nov 2023 13:51:16 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1r1CvH-0003Tv-1d;
	Thu, 09 Nov 2023 21:50:47 +0000
Date: Thu, 9 Nov 2023 21:50:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH 0/8] Add support for 10G Ethernet SerDes on MT7988
Message-ID: <cover.1699565880.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series aims to add support for GMAC2 and GMAC3 of the MediaTek MT7988 SoC.
While the vendor SDK stuffs all this into their Ethernet driver, I've tried to
seperate things into a PHY driver, a PCS driver as well as changes to the
existing Ethernet and LynxI PCS driver.

                  +----------------+
+--------------+  |  USXGMII PCS   |   +------------------+
| Ethernet MAC +--+-------------+  +---+ PEXTP SerDes PHY |
+--------------+  |  SGMII PCS  |  |   +------------------+
                  +-------------+--+

Alltogether this allows using GMAC2 and GMAC3 with all possible interface modes,
including in-band-status if needed.

Daniel Golle (8):
  dt-bindings: phy: mediatek,xfi-pextp: add new bindings
  phy: add driver for MediaTek pextp 10GE SerDes PHY
  net: pcs: pcs-mtk-lynxi: use 2500Base-X without AN
  net: pcs: pcs-mtk-lynxi: allow calling with NULL advertising
  dt-bindings: net: pcs: add bindings for MediaTek USXGMII PCS
  net: pcs: add driver for MediaTek USXGMII PCS
  dt-bindings: net: mediatek,net: fix and complete mt7988-eth binding
  net: ethernet: mtk_eth_soc: add paths and SerDes modes for MT7988

 .../devicetree/bindings/net/mediatek,net.yaml | 171 ++++-
 .../bindings/net/pcs/mediatek,usxgmii.yaml    | 105 +++
 .../bindings/phy/mediatek,xfi-pextp.yaml      |  71 ++
 MAINTAINERS                                   |   3 +
 drivers/net/ethernet/mediatek/Kconfig         |  17 +
 drivers/net/ethernet/mediatek/mtk_eth_path.c  | 122 +++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 178 ++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 105 ++-
 drivers/net/pcs/Kconfig                       |  10 +
 drivers/net/pcs/Makefile                      |   1 +
 drivers/net/pcs/pcs-mtk-lynxi.c               |  38 +-
 drivers/net/pcs/pcs-mtk-usxgmii.c             | 688 ++++++++++++++++++
 drivers/phy/mediatek/Kconfig                  |  11 +
 drivers/phy/mediatek/Makefile                 |   1 +
 drivers/phy/mediatek/phy-mtk-pextp.c          | 355 +++++++++
 include/linux/pcs/pcs-mtk-usxgmii.h           |  18 +
 16 files changed, 1813 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
 create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-pextp.c
 create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h

-- 
2.42.1

