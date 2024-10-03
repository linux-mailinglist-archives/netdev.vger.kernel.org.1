Return-Path: <netdev+bounces-131535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECDD98EC98
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F836B21D50
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F214658F;
	Thu,  3 Oct 2024 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UFJXyD7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA084E0D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949696; cv=none; b=CE/+ZzYD+maVnMfINPeP6q1t+d1Wabt8jhGMqMETa191JKdHLDKZH08bF5SVoLJDtY0LHP3nfjGzuR79C4JclDOWCh/0CexjiWEYRHkM/a9z+0bRuHWrDaUQLlox1JwRtpYsmd9JOe76uWwjAh+X7wATAIpii3iQJkDpdzWi7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949696; c=relaxed/simple;
	bh=0X9aHe10UOyPl5tEVJ3uRL+XzFQpjohG35cuPmdfTb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYIoC8b9VRJLXRvFB59N//Hsn75vEipMKPdksmBeEjJhhIF13hu/5U+WJdxVYvXUftWv2frbHOIMbGKMt6x2g8YeSEBAb7hm/kBd0nn2Y58JbYIXH0IBGNgk7EPP9oBtuXOru+COmKxF787kz+PM2CG7Tj7cmzSMXQLGEUdJnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UFJXyD7a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so7115065e9.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 03:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727949692; x=1728554492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR5wsP9W4+FZ026Sdym4VyH26/mgiZXPRD6KhKroS4Q=;
        b=UFJXyD7aVZOP0hQ75zeWPsWcHgi+KapDc8zerDPHyXtKvrTIQRP7DV9iFtg/Gb/9VH
         XBKCY4hH3xs7IoYLG1WMfoEu7XJLsI8ama7cfxD0vpN03X45jQ7pjusF6uX20Qh464GM
         2WPIq0C6iOZPzsH7sK4WRAxM0VqTOQ7UvHi9iMaPEs54TYa10lJwrLAtcc62UEEwHvT8
         iLyBGVHaWM0s8ouU2CjZxZUeLvcKab7l2WpXhLuRxV0IMkrM9dUC4n7A7t+9+nLtDQQ3
         Qo2sSHuMAnUvHRh7y6UlgxLmBCOcIIF8TaeeGLfaXfZPWFruRszd1hqiILDw1mjKQmDx
         n5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727949692; x=1728554492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR5wsP9W4+FZ026Sdym4VyH26/mgiZXPRD6KhKroS4Q=;
        b=m5y1duXW7+JjzHEw9/KfL9a4VxIaiRAJQQyp+7PCSIKGN6jhBygtwteDft+FxJIx1R
         sgbB05fmT45MAHrC0ePpszeaXQqM5ghiKaR5qzohhsNGhgwB5CChJmsQ1r4r0sEyCIPo
         k+vcXPo0wQMZjqMgken1wFlxW5PbFsof5ZGGqN0/EbkJ8y8WA9TSGlNzbgkTcDxuA4Fd
         UqiTiMSjym478ZNpg24FqF41GHpYPkabMQX73Ubyc4Hj+hykq3zkTQvquW7ZHSkYlHNP
         cKTyng+geLeg5BdlyCBcLQUR/cstB+XO8+GQxNhQreGxN+NJRdfsnkoqm5cGf64Cvq02
         EEqg==
X-Gm-Message-State: AOJu0Yy1CmEGk6CqlNY0QkaZAYNXAX9aJ/iBePQts7Eajj+jvynj6K7e
	yUydGFSTULHDltO5CmaT2oV4mmVWYieNYz6GAkLV/0KWkr3Js3MN3IHpIXopUWM=
X-Google-Smtp-Source: AGHT+IGAg1f0RQLf+q3jSLWr3UTpwVkzEf4pYFJeJxs6eS69WewD0FVb/1JI9aV9rObev4tphnuJ1g==
X-Received: by 2002:a5d:6e91:0:b0:37c:ca21:bc50 with SMTP id ffacd0b85a97d-37cfb8c7bfemr3907110f8f.23.1727949691918;
        Thu, 03 Oct 2024 03:01:31 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d08215cd6sm914635f8f.28.2024.10.03.03.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:01:31 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH net-next v2 0/4] net: Switch back to struct platform_driver::remove()
Date: Thu,  3 Oct 2024 12:01:02 +0200
Message-ID: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13220; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=0X9aHe10UOyPl5tEVJ3uRL+XzFQpjohG35cuPmdfTb0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm/mtfksK4cmrJw2PFMPsx/fI2mzkWuq92ksZ9H PMXpBjylCqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZv5rXwAKCRCPgPtYfRL+ TkmSB/4q3eeNpdRVu5rwDAZxOXhoY6hBK7bUbkbF9rRYNAQ36aXpyAIk9YbY2CjAzf7qsKcEADC kTJlp8jYA8boQO15l1Of4pRpP8L4fXUkAeve1DvETD8+ICuaucrO7eiI4dBDgCiQ95v8E7zI8rG 1TFwBU9fQ84m7SHE1OMX5hRSVjovU89ieUphteRUJkOu+9W+GGIz/6RZkJ4UXux/ZUHQbgYvLg+ U6Vd6wvxgpsk3sbdC27A+n6Sxl5+eXbsDwNZhP2Ou3IO1MaKvKupv4YP+n3P9ZsPiXvuonXbMQT +YUOU0HnEQukOcc4IKHP/2vEJwXLHmpO5BybNA7i95/NTa/o
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

I already sent a patch last week that is very similar to patch #1 of
this series. However the previous submission was based on plain next. I
was asked to resend based on net-next once the merge window closed, so
here comes this v2.  The additional patches address drivers/net/dsa,
drivers/net/mdio and the rest of drivers/net apart from wireless which
has its own tree and will addressed separately at a later point in time.

Note I didn't Cc: all the individual maintainers to not hit sending
limits and get flagged by spam filters.

Best regards
Uwe

Uwe Kleine-König (4):
  net: ethernet: Switch back to struct platform_driver::remove()
  net: dsa: Switch back to struct platform_driver::remove()
  net: mdio: Switch back to struct platform_driver::remove()
  net: Switch back to struct platform_driver::remove()

 drivers/net/dsa/b53/b53_mmap.c                             | 2 +-
 drivers/net/dsa/b53/b53_srab.c                             | 2 +-
 drivers/net/dsa/bcm_sf2.c                                  | 2 +-
 drivers/net/dsa/hirschmann/hellcreek.c                     | 2 +-
 drivers/net/dsa/lantiq_gswip.c                             | 2 +-
 drivers/net/dsa/mt7530-mmio.c                              | 2 +-
 drivers/net/dsa/ocelot/ocelot_ext.c                        | 2 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c                   | 2 +-
 drivers/net/dsa/realtek/realtek-mdio.c                     | 2 +-
 drivers/net/dsa/realtek/realtek-smi.c                      | 2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                        | 2 +-
 drivers/net/dsa/realtek/rtl8366rb.c                        | 2 +-
 drivers/net/dsa/rzn1_a5psw.c                               | 2 +-
 drivers/net/dsa/vitesse-vsc73xx-platform.c                 | 2 +-
 drivers/net/ethernet/8390/ax88796.c                        | 2 +-
 drivers/net/ethernet/8390/mcf8390.c                        | 2 +-
 drivers/net/ethernet/8390/ne.c                             | 2 +-
 drivers/net/ethernet/actions/owl-emac.c                    | 2 +-
 drivers/net/ethernet/aeroflex/greth.c                      | 2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c                | 2 +-
 drivers/net/ethernet/altera/altera_tse_main.c              | 2 +-
 drivers/net/ethernet/amd/au1000_eth.c                      | 2 +-
 drivers/net/ethernet/amd/sunlance.c                        | 2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c              | 2 +-
 drivers/net/ethernet/apm/xgene-v2/main.c                   | 2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c           | 2 +-
 drivers/net/ethernet/apple/macmace.c                       | 2 +-
 drivers/net/ethernet/arc/emac_rockchip.c                   | 2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c                | 2 +-
 drivers/net/ethernet/broadcom/bcm4908_enet.c               | 2 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c               | 4 ++--
 drivers/net/ethernet/broadcom/bcmsysport.c                 | 2 +-
 drivers/net/ethernet/broadcom/bgmac-platform.c             | 2 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c             | 2 +-
 drivers/net/ethernet/broadcom/sb1250-mac.c                 | 2 +-
 drivers/net/ethernet/cadence/macb_main.c                   | 2 +-
 drivers/net/ethernet/calxeda/xgmac.c                       | 2 +-
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c           | 2 +-
 drivers/net/ethernet/cirrus/cs89x0.c                       | 2 +-
 drivers/net/ethernet/cirrus/ep93xx_eth.c                   | 2 +-
 drivers/net/ethernet/cirrus/mac89x0.c                      | 2 +-
 drivers/net/ethernet/cortina/gemini.c                      | 4 ++--
 drivers/net/ethernet/davicom/dm9000.c                      | 2 +-
 drivers/net/ethernet/dnet.c                                | 2 +-
 drivers/net/ethernet/engleder/tsnep_main.c                 | 2 +-
 drivers/net/ethernet/ethoc.c                               | 2 +-
 drivers/net/ethernet/ezchip/nps_enet.c                     | 2 +-
 drivers/net/ethernet/faraday/ftgmac100.c                   | 2 +-
 drivers/net/ethernet/faraday/ftmac100.c                    | 2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c             | 2 +-
 drivers/net/ethernet/freescale/fec_main.c                  | 2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx.c               | 2 +-
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c           | 2 +-
 drivers/net/ethernet/freescale/fman/mac.c                  | 2 +-
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c      | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c       | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mii-fec.c           | 2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c               | 2 +-
 drivers/net/ethernet/freescale/gianfar.c                   | 2 +-
 drivers/net/ethernet/freescale/ucc_geth.c                  | 2 +-
 drivers/net/ethernet/hisilicon/hip04_eth.c                 | 2 +-
 drivers/net/ethernet/hisilicon/hisi_femac.c                | 2 +-
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c              | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c         | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c              | 2 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c                  | 2 +-
 drivers/net/ethernet/i825xx/sni_82596.c                    | 2 +-
 drivers/net/ethernet/ibm/ehea/ehea_main.c                  | 2 +-
 drivers/net/ethernet/ibm/emac/core.c                       | 2 +-
 drivers/net/ethernet/ibm/emac/mal.c                        | 2 +-
 drivers/net/ethernet/ibm/emac/rgmii.c                      | 2 +-
 drivers/net/ethernet/ibm/emac/tah.c                        | 2 +-
 drivers/net/ethernet/ibm/emac/zmii.c                       | 2 +-
 drivers/net/ethernet/korina.c                              | 2 +-
 drivers/net/ethernet/lantiq_etop.c                         | 2 +-
 drivers/net/ethernet/lantiq_xrx200.c                       | 2 +-
 drivers/net/ethernet/litex/litex_liteeth.c                 | 2 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c                 | 4 ++--
 drivers/net/ethernet/marvell/mvmdio.c                      | 2 +-
 drivers/net/ethernet/marvell/mvneta.c                      | 2 +-
 drivers/net/ethernet/marvell/mvneta_bm.c                   | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c            | 2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c                  | 2 +-
 drivers/net/ethernet/mediatek/airoha_eth.c                 | 2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                | 2 +-
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 2 +-
 drivers/net/ethernet/micrel/ks8842.c                       | 2 +-
 drivers/net/ethernet/micrel/ks8851_par.c                   | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c      | 2 +-
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c        | 2 +-
 drivers/net/ethernet/moxa/moxart_ether.c                   | 2 +-
 drivers/net/ethernet/mscc/ocelot_vsc7514.c                 | 2 +-
 drivers/net/ethernet/natsemi/jazzsonic.c                   | 2 +-
 drivers/net/ethernet/natsemi/macsonic.c                    | 2 +-
 drivers/net/ethernet/natsemi/xtsonic.c                     | 2 +-
 drivers/net/ethernet/ni/nixge.c                            | 2 +-
 drivers/net/ethernet/nxp/lpc_eth.c                         | 2 +-
 drivers/net/ethernet/qualcomm/emac/emac.c                  | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c                   | 2 +-
 drivers/net/ethernet/renesas/rswitch.c                     | 2 +-
 drivers/net/ethernet/renesas/sh_eth.c                      | 2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c        | 2 +-
 drivers/net/ethernet/seeq/sgiseeq.c                        | 2 +-
 drivers/net/ethernet/sgi/ioc3-eth.c                        | 2 +-
 drivers/net/ethernet/sgi/meth.c                            | 2 +-
 drivers/net/ethernet/smsc/smc91x.c                         | 2 +-
 drivers/net/ethernet/smsc/smsc911x.c                       | 2 +-
 drivers/net/ethernet/socionext/netsec.c                    | 2 +-
 drivers/net/ethernet/socionext/sni_ave.c                   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c            | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c             | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c           | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c            | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c       | 2 +-
 drivers/net/ethernet/sun/niu.c                             | 2 +-
 drivers/net/ethernet/sun/sunbmac.c                         | 2 +-
 drivers/net/ethernet/sun/sunqe.c                           | 2 +-
 drivers/net/ethernet/sunplus/spl2sw_driver.c               | 2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                   | 2 +-
 drivers/net/ethernet/ti/cpsw.c                             | 2 +-
 drivers/net/ethernet/ti/cpsw_new.c                         | 2 +-
 drivers/net/ethernet/ti/davinci_emac.c                     | 2 +-
 drivers/net/ethernet/ti/davinci_mdio.c                     | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c               | 2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c           | 2 +-
 drivers/net/ethernet/ti/netcp_core.c                       | 2 +-
 drivers/net/ethernet/tundra/tsi108_eth.c                   | 2 +-
 drivers/net/ethernet/via/via-rhine.c                       | 2 +-
 drivers/net/ethernet/via/via-velocity.c                    | 2 +-
 drivers/net/ethernet/wiznet/w5100.c                        | 2 +-
 drivers/net/ethernet/wiznet/w5300.c                        | 2 +-
 drivers/net/ethernet/xilinx/ll_temac_main.c                | 2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c          | 2 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c              | 2 +-
 drivers/net/ethernet/xscale/ixp4xx_eth.c                   | 2 +-
 drivers/net/fjes/fjes_main.c                               | 2 +-
 drivers/net/ieee802154/fakelb.c                            | 2 +-
 drivers/net/ieee802154/mac802154_hwsim.c                   | 2 +-
 drivers/net/ipa/ipa_main.c                                 | 2 +-
 drivers/net/mdio/mdio-aspeed.c                             | 2 +-
 drivers/net/mdio/mdio-bcm-iproc.c                          | 2 +-
 drivers/net/mdio/mdio-bcm-unimac.c                         | 2 +-
 drivers/net/mdio/mdio-gpio.c                               | 2 +-
 drivers/net/mdio/mdio-hisi-femac.c                         | 2 +-
 drivers/net/mdio/mdio-ipq4019.c                            | 2 +-
 drivers/net/mdio/mdio-ipq8064.c                            | 2 +-
 drivers/net/mdio/mdio-moxart.c                             | 2 +-
 drivers/net/mdio/mdio-mscc-miim.c                          | 2 +-
 drivers/net/mdio/mdio-mux-bcm-iproc.c                      | 2 +-
 drivers/net/mdio/mdio-mux-bcm6368.c                        | 2 +-
 drivers/net/mdio/mdio-mux-gpio.c                           | 2 +-
 drivers/net/mdio/mdio-mux-meson-g12a.c                     | 2 +-
 drivers/net/mdio/mdio-mux-meson-gxl.c                      | 2 +-
 drivers/net/mdio/mdio-mux-mmioreg.c                        | 2 +-
 drivers/net/mdio/mdio-mux-multiplexer.c                    | 2 +-
 drivers/net/mdio/mdio-octeon.c                             | 2 +-
 drivers/net/mdio/mdio-sun4i.c                              | 2 +-
 drivers/net/mdio/mdio-xgene.c                              | 2 +-
 drivers/net/pcs/pcs-rzn1-miic.c                            | 2 +-
 drivers/net/phy/sfp.c                                      | 2 +-
 drivers/net/wan/framer/pef2256/pef2256.c                   | 2 +-
 drivers/net/wan/fsl_qmc_hdlc.c                             | 2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                             | 2 +-
 drivers/net/wan/ixp4xx_hss.c                               | 2 +-
 drivers/net/wwan/qcom_bam_dmux.c                           | 2 +-
 180 files changed, 183 insertions(+), 183 deletions(-)

base-commit: e26a0c5d828b225b88f534e2fcf10bf617f85f23
-- 
2.45.2


