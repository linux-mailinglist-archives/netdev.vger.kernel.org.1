Return-Path: <netdev+bounces-31192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C5778C296
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A65B281074
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC4B14F98;
	Tue, 29 Aug 2023 10:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9403613A
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF61AC433C7;
	Tue, 29 Aug 2023 10:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693306349;
	bh=XgXvx9AusPDy9935nVeLpmXF27doYX4REOLpkMaY//Y=;
	h=From:To:Cc:Subject:Date:From;
	b=SxwJb5LNdnNl1fReRuhH1I77UDnX+PsIlqKEDxhbVW4UJgkHOT8DwdhggArZaq838
	 o4MOdj+KArn3wBefSQIQnyugd0xZJ6ngCOMXbnwRTKmBRks1KoMjUHetzjncvqoM/p
	 Tsfi4sLvSALXVZi/414iGBUJbhxvS0SsG5RLt6R9ueebnspDrKCi8bITTdkO1DW04H
	 x09xbL6T97dzOj7SyEEYc8re2PNXfXohBSItr+kANY7DrU7v8+ipxKWuv0eQhfsyiw
	 Kl3Zi49NBn0rjfJh0WU1YrXbK8ospWOnzt3cQoIqDj8Os1X3lv7EMxBuO/XBvRqqCv
	 L5g0e01PImVDg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 00/22] convert to devm_stmmac_probe_config_dt
Date: Tue, 29 Aug 2023 18:40:11 +0800
Message-Id: <20230829104033.955-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Russell pointed out there's a new devm_stmmac_probe_config_dt()
helper now when reviewing my starfive gmac error handling patch[1].
After greping the code, this nice helper was introduced by Bartosz in
[2], I think it's time to convert all dwmac users to this helper and
finally complete the TODO in [2] "but once all users of the old
stmmac_pltfr_remove() are converted to the devres helper, it will be
renamed back to stmmac_pltfr_remove() and the no_dt function removed."

Link: https://lore.kernel.org/netdev/ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk/ [1]
Link: https://lore.kernel.org/all/20230623100417.93592-1-brgl@bgdev.pl/  [2]

Jisheng Zhang (22):
  net: stmmac: dwmac-anarion: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-dwc-qos-eth: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-generic: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-generic: use devm_stmmac_pltfr_probe()
  net: stmmac: dwmac-imx: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-ingenic: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-intel-plat: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-ipq806x: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-lpc18xx: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-mediatek: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-meson: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-meson8b: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-rk: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-socfpga: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-starfive: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-sti: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-stm32: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-sun8i: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-sunxi: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-tegra: use devm_stmmac_probe_config_dt()
  net: stmmac: dwmac-visconti: use devm_stmmac_probe_config_dt()
  net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove

 .../ethernet/stmicro/stmmac/dwmac-anarion.c   | 10 +---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 15 ++----
 .../ethernet/stmicro/stmmac/dwmac-generic.c   | 15 +-----
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 13 ++---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 33 ++++--------
 .../stmicro/stmmac/dwmac-intel-plat.c         | 25 +++------
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   | 27 +++-------
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   | 19 ++-----
 .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  6 +--
 .../net/ethernet/stmicro/stmmac/dwmac-meson.c | 25 +++------
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 53 ++++++-------------
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 14 ++---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 16 +++---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 10 +---
 .../net/ethernet/stmicro/stmmac/dwmac-sti.c   | 14 ++---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 17 +++---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  6 +--
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 23 +++-----
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c | 10 ++--
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  | 12 ++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 ++------
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 -
 22 files changed, 110 insertions(+), 277 deletions(-)

-- 
2.40.1


