Return-Path: <netdev+bounces-56212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FFC80E2E7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F666B219A2
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E378F77;
	Tue, 12 Dec 2023 03:46:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C17AC;
	Mon, 11 Dec 2023 19:46:07 -0800 (PST)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rCtiL-0002os-2z;
	Tue, 12 Dec 2023 03:45:47 +0000
Date: Tue, 12 Dec 2023 03:45:42 +0000
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
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH net-next v3 0/8] Add support for 10G Ethernet SerDes on
 MT7988
Message-ID: <cover.1702352117.git.daniel@makrotopia.org>
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

 +--------------+   +----------------+   +------------------+
 |              +---|  USXGMII PCS   |---+                  |
 | Ethernet MAC |   +----------------+   | PEXTP SerDes PHY |
 |              +---|   SGMII PCS    |---+                  |
 +--------------+   +----------------+   +------------------+

Alltogether this allows using GMAC2 and GMAC3 with all possible interface modes,
including in-band-status if needed.

Note that this series depends on series "dt-bindings: clock: mediatek:
add MT7988 clock IDs"[1] as well as "dt-bindings: watchdog:
mediatek,mtk-wdt: add MT7988 watchdog and toprgu"[2] being merged
before.

[1]: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=809031
[2]: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=802588

Changes since RFC v2:
 - use clk_bulk_* when ever feasible
 - rework Ethernet <-> PCS driver link, use device_link
 
Changes since RFC v1:
 - drop patch inhibiting SGMII AN in 2500Base-X mode
 - make pcs-mtk-lynxi a proper platform driver
 - ... hence allowing to remove all the wrappers from the usxgmii driver
 - attach PEXTP to MAC instead of to USXGMII PCS

Daniel Golle (8):
  dt-bindings: phy: mediatek,xfi-pextp: add new bindings
  phy: add driver for MediaTek pextp 10GE SerDes PHY
  net: pcs: pcs-mtk-lynxi: add platform driver for MT7988
  dt-bindings: net: pcs: add bindings for MediaTek USXGMII PCS
  net: pcs: add driver for MediaTek USXGMII PCS
  dt-bindings: net: mediatek: remove wrongly added clocks and SerDes
  dt-bindings: net: mediatek,net: fix and complete mt7988-eth binding
  net: ethernet: mtk_eth_soc: add paths and SerDes modes for MT7988

 .../devicetree/bindings/net/mediatek,net.yaml | 180 +++++--
 .../bindings/net/pcs/mediatek,usxgmii.yaml    |  60 +++
 .../bindings/phy/mediatek,xfi-pextp.yaml      |  80 +++
 MAINTAINERS                                   |   3 +
 drivers/net/ethernet/mediatek/mtk_eth_path.c  | 122 ++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 291 +++++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 107 +++-
 drivers/net/pcs/Kconfig                       |  11 +
 drivers/net/pcs/Makefile                      |   1 +
 drivers/net/pcs/pcs-mtk-lynxi.c               | 226 ++++++++-
 drivers/net/pcs/pcs-mtk-usxgmii.c             | 456 ++++++++++++++++++
 drivers/phy/mediatek/Kconfig                  |  11 +
 drivers/phy/mediatek/Makefile                 |   1 +
 drivers/phy/mediatek/phy-mtk-pextp.c          | 361 ++++++++++++++
 include/linux/pcs/pcs-mtk-lynxi.h             |  11 +
 include/linux/pcs/pcs-mtk-usxgmii.h           |  27 ++
 16 files changed, 1859 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/mediatek,usxgmii.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,xfi-pextp.yaml
 create mode 100644 drivers/net/pcs/pcs-mtk-usxgmii.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-pextp.c
 create mode 100644 include/linux/pcs/pcs-mtk-usxgmii.h

-- 
2.43.0

