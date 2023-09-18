Return-Path: <netdev+bounces-34830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2435F7A55C0
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437CC1C20ABD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B6328CD;
	Mon, 18 Sep 2023 22:26:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5D2AB4B;
	Mon, 18 Sep 2023 22:26:37 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E38F;
	Mon, 18 Sep 2023 15:26:36 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qiMhA-0002wG-1F;
	Mon, 18 Sep 2023 22:26:20 +0000
Date: Mon, 18 Sep 2023 23:26:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 0/2] net: ethernet: mtk_eth_soc: add paths and
 SerDes modes
Message-ID: <cover.1695058909.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The series brings support for SerDes interface modes up to 10 Gb/s for
the MediaTek MT7988 SoC.

As the Ethernet driver now requires a few more phandles in device tree
referencing various other parts of the SoC also add corresponding
dt-binding changes.

It may be argued that instead of referencing those units as syscon and
access them as regmap one may want to implement propper clk or reset
drivers. However, only a single register write is require to the
otherwise completely undocumented pextp_pll unit which will not make a
nice clk driver...

The toprgu/watchdog reset controller is used to synchronously
assert/deassert multiple resets as the same time which is not
supported by Linux reset controller API which always asserts/deasserts
resets sequentially. It is not known whether asserting/deasserting
pextp, sgmii, xfi and usxgii resets simultanously is stricly required
for the hardware to work reliably, however, it's what the vendor
implementation is doing as well and there are no other drivers needing
to access the toprgu reset controller.

This series has been tested with the MT7988 reference board as well as
pre-mass-production BananaPi BPi-R4 board also featuring MT7988.
Various SFP(+) modules have been successfully tested on both boards and
also the on-board AQR133 10GE PHY found on the MT7988 reference board
works nicely.

To make sure no existing older SoCs have been broken run-time tests
have also been carried out on various MT7981, MT7986, MT7622 and
MT7623 boards. The patch is also present in OpenWrt for some months
now already and hence supposedly hundreds of users also on older
MT7621 systems should have tested it while I didn't hear about any
complaints so far.

For the interfaces modes covered by the existing LynxI PCS driver
(Cisco SGMII, 1000Base-X, 2500Base-X) to work on MT7988 this series
depends on commit 90308679c297f ("net: pcs: lynxi: implement pcs_disable op").

Changes since v1:
 * add missing macro defines (v1 didn't build for that reason)
 * add dt-bindings changes

Daniel Golle (2):
  dt-bindings: net: mediatek,net: add phandles for SerDes on MT7988
  net: ethernet: mtk_eth_soc: add paths and SerDes modes for MT7988

 .../devicetree/bindings/net/mediatek,net.yaml |  28 +
 drivers/net/ethernet/mediatek/Kconfig         |  16 +
 drivers/net/ethernet/mediatek/Makefile        |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_path.c  | 123 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 182 ++++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 237 +++++-
 drivers/net/ethernet/mediatek/mtk_usxgmii.c   | 698 ++++++++++++++++++
 7 files changed, 1254 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/mediatek/mtk_usxgmii.c

-- 
2.42.0

