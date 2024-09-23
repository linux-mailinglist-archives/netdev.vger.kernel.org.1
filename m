Return-Path: <netdev+bounces-129342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3A97EF19
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E671C213D8
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BAF197A97;
	Mon, 23 Sep 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="my4NU3Qx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A67823AC
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108540; cv=none; b=RYtjf6dyrW8gcrRZmhCq8rpQt9GZzfOZ3rwWEW667QUKgsI09KHSGF/TpQ99NxtI4Kr9z7s3HDKD93uV8uXpZyMsE/O4eQsCNI+Y0OZS04ud4OTmigDfyk1JUCRPKNIRdZsWcwNdzzYSLWmtGsftpOJQ8SWl2bLcEGl+mDiUKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108540; c=relaxed/simple;
	bh=LC1FJRQywKUAQMZ+r02KbmzlP+Ers+nJJmGKCOGrHEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dIiS3Nx3kEedc/fqsZPzog+l+TSMKQquAVOJ5UfMxocB3cYvR2U7JDUQLeKaavVMaJxkPttP9nFNSjFPXWD8Fu7/JNwiJh10169FQ1idkmpMqw/5fXGval3RtImjdiKdzWu4SZm44ITBubpw/PQ+3GV87nXcJmSq5cy7yH4IAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=my4NU3Qx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so44568085e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727108533; x=1727713333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LAPMRh8DXFz7h/ETnQ7eVlyfB071q0sNOm99Wq0+bTA=;
        b=my4NU3QxSUmEL0tw2Degg/WmEukC7DIJiLFnslCNs2+nnJ4VjkU0EFM03/OrdegGuz
         YMPJ4+YzIXd2ajKzqUJNpzAC7u9hfT9BrRkVeJUyGVoBxSiKLrgQtGErPDgTX+ahfh+O
         7BkdT536TbTNYJW2exdfsZtHuwxMNqwRUvurnfVvqRgOu/sj8NzmC/3jf43yCuWBpr80
         skuvr15osSyAofRpNSedGTPsPKpVzLUG0A93rFPQSs7HxBhFquQYvHKYlbCwwAOGFPrN
         GJ3pCtjb/1HyTCqtXdnLFpC19bxgmQKJfqYNnENJFzCD2JQyjzsPbjofAdDXYwxuSguj
         eSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108533; x=1727713333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAPMRh8DXFz7h/ETnQ7eVlyfB071q0sNOm99Wq0+bTA=;
        b=mzeKxNf9kDWgNxLEIijJlJgAm0y0/jYGsrr3x5riwEP8JWsrsQGF4ipqXYispu7ANL
         LJMzlydXpXNZltbUjE2MQfiWBuuWSJa3+LJtToOdlR+OE9Y7F57yQDRMTRvYF/baXUVl
         PmwmF8N+TLZWXzx61xXldc85qKBs2P1g4Z6cKMn99SvPXObkzRmat9Fv4W49l/JPpsY6
         X4f+GxRwkJEsRKthUjRmAnhzP1bTl/fcU/PieMKEZw0oKWHJBmq7KNZDfCCpNEFh2452
         T9MVRD/1C1dpzml7nRHhkRuPtNyhuV52tp97lX1YqY9HwZgmvsDSfDNlon02F4MPynoi
         HIrA==
X-Gm-Message-State: AOJu0YybmxKn2uBNtzFg84QgYnEYxgOl6SNQsoE65MDXesBpGt8qoLow
	BjmdaJBVXTZxl2c8Tsxax7Xg7r78+j98tTuwAuwK8+lIjhw6KhzXush8hnmK9IWvLcXNlhoaqpd
	C
X-Google-Smtp-Source: AGHT+IHMhFVbUa2ud4puY4OmFuruWXHdnlqukFfO/eUiM8KBN5G3DqWHCOsehFQ/y6jufhtrwCuT/Q==
X-Received: by 2002:a05:600c:4592:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-42e7c159c0amr91320435e9.3.1727108532245;
        Mon, 23 Sep 2024 09:22:12 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80c5sm24586310f8f.39.2024.09.23.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:22:11 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: Switch back to struct platform_driver::remove()
Date: Mon, 23 Sep 2024 18:22:01 +0200
Message-ID: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=82703; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=LC1FJRQywKUAQMZ+r02KbmzlP+Ers+nJJmGKCOGrHEU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm8ZWq8RqUYJ+R1yHGiQmnXmVQTOMdnBUCPf8hi TUsvQmDLjyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZvGVqgAKCRCPgPtYfRL+ TvduB/4j/OpkqLT0D2oSp+lf98fkYuRyGKofO0Zh4g4733ZM4ANsoJW7dQ3xkodtTKTEVp8iGHc KcSlsKO6kjlz3Lh1l4mwJfsrtXqkJTdfI9neGMvlSXAihWDLr6/aM4JxMMpQjdjeZ6sF2AxCeoQ SxoOyO7IKR0C1AGcesax6M3DFoyGh85LZvs8c5eoXp2J3InxN4YGANWZiL0ez/NK3bOvr5K7iuT +WUlEdMkQwmBCEKHfylUhx+cEmlFxVZlchY5q0NZTIOAFXrAUnINdgkaIs9UcwwPSviZ2X4tqIK cHxUPN6GsQKsgwh9Hvz2xv6WSCHnpiPnR53V86iUBWIWfBOu
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert ethernet clk drivers to use .remove(), with the eventual goal to drop
struct platform_driver::remove_new(). As .remove() and .remove_new() have
the same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I converted all drivers below drivers/net/ethernet in a single patch. If
you want it split, just tell me (per vendor? per driver?). Also note I
didn't add all the maintainers of the individual drivers to Cc: to not
trigger sending restrictions and spam filters.

Best regards
Uwe

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
 136 files changed, 139 insertions(+), 139 deletions(-)

diff --git a/drivers/net/ethernet/8390/ax88796.c b/drivers/net/ethernet/8390/ax88796.c
index 2874680ef24d..e1695d0fbd8b 100644
--- a/drivers/net/ethernet/8390/ax88796.c
+++ b/drivers/net/ethernet/8390/ax88796.c
@@ -1009,7 +1009,7 @@ static struct platform_driver axdrv = {
 		.name		= "ax88796",
 	},
 	.probe		= ax_probe,
-	.remove_new	= ax_remove,
+	.remove		= ax_remove,
 	.suspend	= ax_suspend,
 	.resume		= ax_resume,
 };
diff --git a/drivers/net/ethernet/8390/mcf8390.c b/drivers/net/ethernet/8390/mcf8390.c
index 5a0fa995e643..94ff8364cdf0 100644
--- a/drivers/net/ethernet/8390/mcf8390.c
+++ b/drivers/net/ethernet/8390/mcf8390.c
@@ -457,7 +457,7 @@ static struct platform_driver mcf8390_drv = {
 		.name	= "mcf8390",
 	},
 	.probe		= mcf8390_probe,
-	.remove_new	= mcf8390_remove,
+	.remove		= mcf8390_remove,
 };
 
 module_platform_driver(mcf8390_drv);
diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index 350683a09d2e..961019c32842 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -894,7 +894,7 @@ static int ne_drv_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver ne_driver = {
-	.remove_new	= ne_drv_remove,
+	.remove		= ne_drv_remove,
 	.suspend	= ne_drv_suspend,
 	.resume		= ne_drv_resume,
 	.driver		= {
diff --git a/drivers/net/ethernet/actions/owl-emac.c b/drivers/net/ethernet/actions/owl-emac.c
index e03193da5874..115f48b3342c 100644
--- a/drivers/net/ethernet/actions/owl-emac.c
+++ b/drivers/net/ethernet/actions/owl-emac.c
@@ -1607,7 +1607,7 @@ static struct platform_driver owl_emac_driver = {
 		.pm = &owl_emac_pm_ops,
 	},
 	.probe = owl_emac_probe,
-	.remove_new = owl_emac_remove,
+	.remove = owl_emac_remove,
 };
 module_platform_driver(owl_emac_driver);
 
diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 27af7746d645..ae88961aa896 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -1564,7 +1564,7 @@ static struct platform_driver greth_of_driver = {
 		.of_match_table = greth_of_match,
 	},
 	.probe = greth_of_probe,
-	.remove_new = greth_of_remove,
+	.remove = greth_of_remove,
 };
 
 module_platform_driver(greth_of_driver);
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index d761c08fe5c1..2f516b950f4e 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -1142,7 +1142,7 @@ static struct platform_driver emac_driver = {
 		.of_match_table = emac_of_match,
 	},
 	.probe = emac_probe,
-	.remove_new = emac_remove,
+	.remove = emac_remove,
 	.suspend = emac_suspend,
 	.resume = emac_resume,
 };
diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 3c112c18ae6a..3f6204de9e6b 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1519,7 +1519,7 @@ MODULE_DEVICE_TABLE(of, altera_tse_ids);
 
 static struct platform_driver altera_tse_driver = {
 	.probe		= altera_tse_probe,
-	.remove_new	= altera_tse_remove,
+	.remove		= altera_tse_remove,
 	.suspend	= NULL,
 	.resume		= NULL,
 	.driver		= {
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 85c978149bf6..0671a066913b 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1363,7 +1363,7 @@ static void au1000_remove(struct platform_device *pdev)
 
 static struct platform_driver au1000_eth_driver = {
 	.probe  = au1000_probe,
-	.remove_new = au1000_remove,
+	.remove = au1000_remove,
 	.driver = {
 		.name   = "au1000-eth",
 	},
diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index c78706d21a6a..0f98b92408ed 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1514,7 +1514,7 @@ static struct platform_driver sunlance_sbus_driver = {
 		.of_match_table = sunlance_sbus_match,
 	},
 	.probe		= sunlance_sbus_probe,
-	.remove_new	= sunlance_sbus_remove,
+	.remove		= sunlance_sbus_remove,
 };
 
 module_platform_driver(sunlance_sbus_driver);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 7912b3b45148..4365bd62942c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -565,7 +565,7 @@ static struct platform_driver xgbe_driver = {
 		.pm = &xgbe_platform_pm_ops,
 	},
 	.probe = xgbe_platform_probe,
-	.remove_new = xgbe_platform_remove,
+	.remove = xgbe_platform_remove,
 };
 
 int xgbe_platform_init(void)
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 9e90c2381491..2a91c84aebdb 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -734,7 +734,7 @@ static struct platform_driver xge_driver = {
 		   .acpi_match_table = ACPI_PTR(xge_acpi_match),
 	},
 	.probe = xge_probe,
-	.remove_new = xge_remove,
+	.remove = xge_remove,
 	.shutdown = xge_shutdown,
 };
 module_platform_driver(xge_driver);
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 4af9d89d5f88..3b2951030a38 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -2159,7 +2159,7 @@ static struct platform_driver xgene_enet_driver = {
 		   .acpi_match_table = ACPI_PTR(xgene_enet_acpi_match),
 	},
 	.probe = xgene_enet_probe,
-	.remove_new = xgene_enet_remove,
+	.remove = xgene_enet_remove,
 	.shutdown = xgene_enet_shutdown,
 };
 
diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
index 766ab78256fe..8989506e6248 100644
--- a/drivers/net/ethernet/apple/macmace.c
+++ b/drivers/net/ethernet/apple/macmace.c
@@ -759,7 +759,7 @@ static void mac_mace_device_remove(struct platform_device *pdev)
 
 static struct platform_driver mac_mace_driver = {
 	.probe  = mace_probe,
-	.remove_new = mac_mace_device_remove,
+	.remove = mac_mace_device_remove,
 	.driver	= {
 		.name	= mac_mace_string,
 	},
diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 493d6356c8ca..780e70ea1c22 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -264,7 +264,7 @@ static void emac_rockchip_remove(struct platform_device *pdev)
 
 static struct platform_driver emac_rockchip_driver = {
 	.probe = emac_rockchip_probe,
-	.remove_new = emac_rockchip_remove,
+	.remove = emac_rockchip_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table  = emac_rockchip_dt_ids,
diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 297c2682a9cf..a68fab1b05f0 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1500,7 +1500,7 @@ static SIMPLE_DEV_PM_OPS(bcmasp_pm_ops,
 
 static struct platform_driver bcmasp_driver = {
 	.probe = bcmasp_probe,
-	.remove_new = bcmasp_remove,
+	.remove = bcmasp_remove,
 	.shutdown = bcmasp_shutdown,
 	.driver = {
 		.name = "brcm,asp-v2",
diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 72df1bb10172..203e8d0dd04b 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -789,7 +789,7 @@ static struct platform_driver bcm4908_enet_driver = {
 		.of_match_table = bcm4908_enet_of_match,
 	},
 	.probe	= bcm4908_enet_probe,
-	.remove_new = bcm4908_enet_remove,
+	.remove = bcm4908_enet_remove,
 };
 module_platform_driver(bcm4908_enet_driver);
 
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 3c0e3b9828be..e5e03aaa49f9 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1936,7 +1936,7 @@ static void bcm_enet_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm63xx_enet_driver = {
 	.probe	= bcm_enet_probe,
-	.remove_new = bcm_enet_remove,
+	.remove = bcm_enet_remove,
 	.driver	= {
 		.name	= "bcm63xx_enet",
 	},
@@ -2755,7 +2755,7 @@ static void bcm_enetsw_remove(struct platform_device *pdev)
 
 static struct platform_driver bcm63xx_enetsw_driver = {
 	.probe	= bcm_enetsw_probe,
-	.remove_new = bcm_enetsw_remove,
+	.remove = bcm_enetsw_remove,
 	.driver	= {
 		.name	= "bcm63xx_enetsw",
 	},
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..9332a9390f0d 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2899,7 +2899,7 @@ static SIMPLE_DEV_PM_OPS(bcm_sysport_pm_ops,
 
 static struct platform_driver bcm_sysport_driver = {
 	.probe	= bcm_sysport_probe,
-	.remove_new = bcm_sysport_remove,
+	.remove = bcm_sysport_remove,
 	.driver =  {
 		.name = "brcm-systemport",
 		.of_match_table = bcm_sysport_of_match,
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 77425c7a32db..ecce23cecbea 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -294,7 +294,7 @@ static struct platform_driver bgmac_enet_driver = {
 		.pm = BGMAC_PM_OPS
 	},
 	.probe = bgmac_probe,
-	.remove_new = bgmac_remove,
+	.remove = bgmac_remove,
 };
 
 module_platform_driver(bgmac_enet_driver);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index c7e7dac057a3..be884f0e23b0 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4350,7 +4350,7 @@ MODULE_DEVICE_TABLE(acpi, genet_acpi_match);
 
 static struct platform_driver bcmgenet_driver = {
 	.probe	= bcmgenet_probe,
-	.remove_new = bcmgenet_remove,
+	.remove = bcmgenet_remove,
 	.shutdown = bcmgenet_shutdown,
 	.driver	= {
 		.name	= "bcmgenet",
diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index fcf8485f3446..30865fe03eeb 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2608,7 +2608,7 @@ static void sbmac_remove(struct platform_device *pldev)
 
 static struct platform_driver sbmac_driver = {
 	.probe = sbmac_probe,
-	.remove_new = sbmac_remove,
+	.remove = sbmac_remove,
 	.driver = {
 		.name = sbmac_string,
 	},
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f06babec04a0..132ca4fc2930 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5482,7 +5482,7 @@ static const struct dev_pm_ops macb_pm_ops = {
 
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
-	.remove_new	= macb_remove,
+	.remove		= macb_remove,
 	.driver		= {
 		.name		= "macb",
 		.of_match_table	= of_match_ptr(macb_dt_ids),
diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index a71b320fd030..331ac6a3dc38 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1919,7 +1919,7 @@ static struct platform_driver xgmac_driver = {
 		.pm = &xgmac_pm_ops,
 	},
 	.probe = xgmac_probe,
-	.remove_new = xgmac_remove,
+	.remove = xgmac_remove,
 };
 
 module_platform_driver(xgmac_driver);
diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index 744f2434f7fa..393b9951490a 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1545,7 +1545,7 @@ static struct platform_driver octeon_mgmt_driver = {
 		.of_match_table = octeon_mgmt_match,
 	},
 	.probe		= octeon_mgmt_probe,
-	.remove_new	= octeon_mgmt_remove,
+	.remove		= octeon_mgmt_remove,
 };
 
 module_platform_driver(octeon_mgmt_driver);
diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index 0a21a10a791c..fa5857923db4 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -1903,7 +1903,7 @@ static struct platform_driver cs89x0_driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= of_match_ptr(cs89x0_match),
 	},
-	.remove_new = cs89x0_platform_remove,
+	.remove = cs89x0_platform_remove,
 };
 
 module_platform_driver_probe(cs89x0_driver, cs89x0_platform_probe);
diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 2523d9c9d1b8..b1767e0448e5 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -860,7 +860,7 @@ MODULE_DEVICE_TABLE(of, ep93xx_eth_of_ids);
 
 static struct platform_driver ep93xx_eth_driver = {
 	.probe		= ep93xx_eth_probe,
-	.remove_new	= ep93xx_eth_remove,
+	.remove		= ep93xx_eth_remove,
 	.driver		= {
 		.name	= "ep93xx-eth",
 		.of_match_table = ep93xx_eth_of_ids,
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 84b300fee2bb..6723df9b65d9 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -568,7 +568,7 @@ static void mac89x0_device_remove(struct platform_device *pdev)
 
 static struct platform_driver mac89x0_platform_driver = {
 	.probe = mac89x0_device_probe,
-	.remove_new = mac89x0_device_remove,
+	.remove = mac89x0_device_remove,
 	.driver = {
 		.name = "mac89x0",
 	},
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 73e1c71c5092..991e3839858b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2573,7 +2573,7 @@ static struct platform_driver gemini_ethernet_port_driver = {
 		.of_match_table = gemini_ethernet_port_of_match,
 	},
 	.probe = gemini_ethernet_port_probe,
-	.remove_new = gemini_ethernet_port_remove,
+	.remove = gemini_ethernet_port_remove,
 };
 
 static int gemini_ethernet_probe(struct platform_device *pdev)
@@ -2637,7 +2637,7 @@ static struct platform_driver gemini_ethernet_driver = {
 		.of_match_table = gemini_ethernet_of_match,
 	},
 	.probe = gemini_ethernet_probe,
-	.remove_new = gemini_ethernet_remove,
+	.remove = gemini_ethernet_remove,
 };
 
 static int __init gemini_ethernet_module_init(void)
diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 150cc94ae9f8..8735e333034c 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1799,7 +1799,7 @@ static struct platform_driver dm9000_driver = {
 		.of_match_table = of_match_ptr(dm9000_of_matches),
 	},
 	.probe   = dm9000_probe,
-	.remove_new = dm9000_drv_remove,
+	.remove = dm9000_drv_remove,
 };
 
 module_platform_driver(dm9000_driver);
diff --git a/drivers/net/ethernet/dnet.c b/drivers/net/ethernet/dnet.c
index 2a18df3605f1..0de3cd660ec8 100644
--- a/drivers/net/ethernet/dnet.c
+++ b/drivers/net/ethernet/dnet.c
@@ -863,7 +863,7 @@ static void dnet_remove(struct platform_device *pdev)
 
 static struct platform_driver dnet_driver = {
 	.probe		= dnet_probe,
-	.remove_new	= dnet_remove,
+	.remove		= dnet_remove,
 	.driver		= {
 		.name		= "dnet",
 	},
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 44da335d66bd..95a5295d0361 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2689,7 +2689,7 @@ static struct platform_driver tsnep_driver = {
 		.of_match_table = tsnep_of_match,
 	},
 	.probe = tsnep_probe,
-	.remove_new = tsnep_remove,
+	.remove = tsnep_remove,
 };
 module_platform_driver(tsnep_driver);
 
diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index ad41c9019018..0c418557264c 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1296,7 +1296,7 @@ MODULE_DEVICE_TABLE(of, ethoc_match);
 
 static struct platform_driver ethoc_driver = {
 	.probe   = ethoc_probe,
-	.remove_new = ethoc_remove,
+	.remove = ethoc_remove,
 	.suspend = ethoc_suspend,
 	.resume  = ethoc_resume,
 	.driver  = {
diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 9ebe751c1df0..5cb478e98697 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -651,7 +651,7 @@ MODULE_DEVICE_TABLE(of, nps_enet_dt_ids);
 
 static struct platform_driver nps_enet_driver = {
 	.probe = nps_enet_probe,
-	.remove_new = nps_enet_remove,
+	.remove = nps_enet_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table  = nps_enet_dt_ids,
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index f3cc14cc757d..059266b71d34 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2084,7 +2084,7 @@ MODULE_DEVICE_TABLE(of, ftgmac100_of_match);
 
 static struct platform_driver ftgmac100_driver = {
 	.probe	= ftgmac100_probe,
-	.remove_new = ftgmac100_remove,
+	.remove = ftgmac100_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= ftgmac100_of_match,
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 1047c805054e..5803a382f0ba 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -1243,7 +1243,7 @@ static const struct of_device_id ftmac100_of_ids[] = {
 
 static struct platform_driver ftmac100_driver = {
 	.probe		= ftmac100_probe,
-	.remove_new	= ftmac100_remove,
+	.remove		= ftmac100_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.of_match_table = ftmac100_of_ids
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index e15dd3d858df..6b9b6d72db98 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -3571,7 +3571,7 @@ static struct platform_driver dpaa_driver = {
 	},
 	.id_table = dpaa_devtype,
 	.probe = dpaa_eth_probe,
-	.remove_new = dpaa_remove
+	.remove = dpaa_remove
 };
 
 static int __init dpaa_load(void)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index acbb627d51bf..5ec5c8987c4a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4755,7 +4755,7 @@ static struct platform_driver fec_driver = {
 	},
 	.id_table = fec_devtype,
 	.probe	= fec_probe,
-	.remove_new = fec_drv_remove,
+	.remove = fec_drv_remove,
 };
 
 module_platform_driver(fec_driver);
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index ebae71ec26c6..2bfaf14f65c8 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -1040,7 +1040,7 @@ static struct platform_driver mpc52xx_fec_driver = {
 		.of_match_table = mpc52xx_fec_match,
 	},
 	.probe		= mpc52xx_fec_probe,
-	.remove_new	= mpc52xx_fec_remove,
+	.remove		= mpc52xx_fec_remove,
 #ifdef CONFIG_PM
 	.suspend	= mpc52xx_fec_of_suspend,
 	.resume		= mpc52xx_fec_of_resume,
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index 39689826cc8f..2c37004bb0fe 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -144,7 +144,7 @@ struct platform_driver mpc52xx_fec_mdio_driver = {
 		.of_match_table = mpc52xx_fec_mdio_match,
 	},
 	.probe = mpc52xx_fec_mdio_probe,
-	.remove_new = mpc52xx_fec_mdio_remove,
+	.remove = mpc52xx_fec_mdio_remove,
 };
 
 /* let fec driver call it, since this has to be registered before it */
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 9767586b4eb3..43f4ad29eadd 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -345,7 +345,7 @@ static struct platform_driver mac_driver = {
 		.of_match_table	= mac_match,
 	},
 	.probe		= mac_probe,
-	.remove_new	= mac_remove,
+	.remove		= mac_remove,
 };
 
 builtin_platform_driver(mac_driver);
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 3425c4a6abcb..f563692a4a00 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1052,7 +1052,7 @@ static struct platform_driver fs_enet_driver = {
 		.of_match_table = fs_enet_match,
 	},
 	.probe = fs_enet_probe,
-	.remove_new = fs_enet_remove,
+	.remove = fs_enet_remove,
 };
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
index 2e210a003558..e6b2d7452fe7 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -214,7 +214,7 @@ static struct platform_driver fs_enet_bb_mdio_driver = {
 		.of_match_table = fs_enet_mdio_bb_match,
 	},
 	.probe = fs_enet_mdio_probe,
-	.remove_new = fs_enet_mdio_remove,
+	.remove = fs_enet_mdio_remove,
 };
 
 module_platform_driver(fs_enet_bb_mdio_driver);
diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
index 93d91e8ad0de..dec31b638941 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-fec.c
@@ -212,7 +212,7 @@ static struct platform_driver fs_enet_fec_mdio_driver = {
 		.of_match_table = fs_enet_mdio_fec_match,
 	},
 	.probe = fs_enet_mdio_probe,
-	.remove_new = fs_enet_mdio_remove,
+	.remove = fs_enet_mdio_remove,
 };
 
 module_platform_driver(fs_enet_fec_mdio_driver);
diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 026f7270a54d..56d2f79fb7e3 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -526,7 +526,7 @@ static struct platform_driver fsl_pq_mdio_driver = {
 		.of_match_table = fsl_pq_mdio_match,
 	},
 	.probe = fsl_pq_mdio_probe,
-	.remove_new = fsl_pq_mdio_remove,
+	.remove = fsl_pq_mdio_remove,
 };
 
 module_platform_driver(fsl_pq_mdio_driver);
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index ecb1703ea150..092db6995824 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3642,7 +3642,7 @@ static struct platform_driver gfar_driver = {
 		.of_match_table = gfar_match,
 	},
 	.probe = gfar_probe,
-	.remove_new = gfar_remove,
+	.remove = gfar_remove,
 };
 
 module_platform_driver(gfar_driver);
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index ab421243a419..d3ddca22d6b0 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3786,7 +3786,7 @@ static struct platform_driver ucc_geth_driver = {
 		.of_match_table = ucc_geth_match,
 	},
 	.probe		= ucc_geth_probe,
-	.remove_new	= ucc_geth_remove,
+	.remove		= ucc_geth_remove,
 	.suspend	= ucc_geth_suspend,
 	.resume		= ucc_geth_resume,
 };
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index beb815e5289b..a376d4bdf281 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -1047,7 +1047,7 @@ MODULE_DEVICE_TABLE(of, hip04_mac_match);
 
 static struct platform_driver hip04_mac_driver = {
 	.probe	= hip04_mac_probe,
-	.remove_new = hip04_remove,
+	.remove = hip04_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= hip04_mac_match,
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 2406263c9dd3..d244a40df430 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -959,7 +959,7 @@ static struct platform_driver hisi_femac_driver = {
 		.of_match_table = hisi_femac_match,
 	},
 	.probe = hisi_femac_drv_probe,
-	.remove_new = hisi_femac_drv_remove,
+	.remove = hisi_femac_drv_remove,
 #ifdef CONFIG_PM
 	.suspend = hisi_femac_drv_suspend,
 	.resume = hisi_femac_drv_resume,
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 1a972b093a42..e3e7f2270560 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1312,7 +1312,7 @@ static struct platform_driver hix5hd2_dev_driver = {
 		.of_match_table = hix5hd2_of_match,
 	},
 	.probe = hix5hd2_dev_probe,
-	.remove_new = hix5hd2_dev_remove,
+	.remove = hix5hd2_dev_remove,
 };
 
 module_platform_driver(hix5hd2_dev_driver);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 1b67da1f6fa8..eb60f45a3460 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -3031,7 +3031,7 @@ MODULE_DEVICE_TABLE(of, g_dsaf_match);
 
 static struct platform_driver g_dsaf_driver = {
 	.probe = hns_dsaf_probe,
-	.remove_new = hns_dsaf_remove,
+	.remove = hns_dsaf_remove,
 	.driver = {
 		.name = DSAF_DRV_NAME,
 		.of_match_table = g_dsaf_match,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index fd32e15cadcb..42bb341fd80b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2439,7 +2439,7 @@ static struct platform_driver hns_nic_dev_driver = {
 		.acpi_match_table = ACPI_PTR(hns_enet_acpi_match),
 	},
 	.probe = hns_nic_dev_probe,
-	.remove_new = hns_nic_dev_remove,
+	.remove = hns_nic_dev_remove,
 };
 
 module_platform_driver(hns_nic_dev_driver);
diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 8a047145f0c5..a1aa6c1f966e 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -636,7 +636,7 @@ MODULE_DEVICE_TABLE(acpi, hns_mdio_acpi_match);
 
 static struct platform_driver hns_mdio_driver = {
 	.probe = hns_mdio_probe,
-	.remove_new = hns_mdio_remove,
+	.remove = hns_mdio_remove,
 	.driver = {
 		   .name = MDIO_DRV_NAME,
 		   .of_match_table = hns_mdio_match,
diff --git a/drivers/net/ethernet/i825xx/sni_82596.c b/drivers/net/ethernet/i825xx/sni_82596.c
index 813403c2628f..baa598988f47 100644
--- a/drivers/net/ethernet/i825xx/sni_82596.c
+++ b/drivers/net/ethernet/i825xx/sni_82596.c
@@ -168,7 +168,7 @@ static void sni_82596_driver_remove(struct platform_device *pdev)
 
 static struct platform_driver sni_82596_driver = {
 	.probe	= sni_82596_probe,
-	.remove_new = sni_82596_driver_remove,
+	.remove = sni_82596_driver_remove,
 	.driver	= {
 		.name	= sni_82596_string,
 	},
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index c41c3f1cc506..9b006bc353a1 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -121,7 +121,7 @@ static struct platform_driver ehea_driver = {
 		.of_match_table = ehea_device_table,
 	},
 	.probe = ehea_probe_adapter,
-	.remove_new = ehea_remove,
+	.remove = ehea_remove,
 };
 
 void ehea_dump(void *adr, int len, char *msg)
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index dac570f3c110..dadd987efb6b 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3241,7 +3241,7 @@ static struct platform_driver emac_driver = {
 		.of_match_table = emac_match,
 	},
 	.probe = emac_probe,
-	.remove_new = emac_remove,
+	.remove = emac_remove,
 };
 
 static void __init emac_make_bootlist(void)
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index d92dd9c83031..bb9415327555 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -776,7 +776,7 @@ static struct platform_driver mal_of_driver = {
 		.of_match_table = mal_platform_match,
 	},
 	.probe = mal_probe,
-	.remove_new = mal_remove,
+	.remove = mal_remove,
 };
 
 int __init mal_init(void)
diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index e1712fdc3c31..317c22d09172 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -300,7 +300,7 @@ static struct platform_driver rgmii_driver = {
 		.of_match_table = rgmii_match,
 	},
 	.probe = rgmii_probe,
-	.remove_new = rgmii_remove,
+	.remove = rgmii_remove,
 };
 
 int __init rgmii_init(void)
diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index fa3488258ca2..c605c8ff933e 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -158,7 +158,7 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove_new = tah_remove,
+	.remove = tah_remove,
 };
 
 int __init tah_init(void)
diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 26e86cdee2f6..03bab3f95fe4 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -306,7 +306,7 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove_new = zmii_remove,
+	.remove = zmii_remove,
 };
 
 int __init zmii_init(void)
diff --git a/drivers/net/ethernet/korina.c b/drivers/net/ethernet/korina.c
index 81cf3361a1e5..87c7e6251a4f 100644
--- a/drivers/net/ethernet/korina.c
+++ b/drivers/net/ethernet/korina.c
@@ -1403,7 +1403,7 @@ static struct platform_driver korina_driver = {
 		.of_match_table = of_match_ptr(korina_match),
 	},
 	.probe = korina_probe,
-	.remove_new = korina_remove,
+	.remove = korina_remove,
 };
 
 module_platform_driver(korina_driver);
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 3c289bfe0a09..ea92a7bbe972 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -732,7 +732,7 @@ static void ltq_etop_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ltq_mii_driver = {
-	.remove_new = ltq_etop_remove,
+	.remove = ltq_etop_remove,
 	.driver = {
 		.name = "ltq_etop",
 	},
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index 07904a528f21..b8766fb7a844 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -669,7 +669,7 @@ MODULE_DEVICE_TABLE(of, xrx200_match);
 
 static struct platform_driver xrx200_driver = {
 	.probe = xrx200_probe,
-	.remove_new = xrx200_remove,
+	.remove = xrx200_remove,
 	.driver = {
 		.name = "lantiq,xrx200-net",
 		.of_match_table = xrx200_match,
diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index ff54fbe41bcc..829a4b828f8e 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -309,7 +309,7 @@ MODULE_DEVICE_TABLE(of, liteeth_of_match);
 
 static struct platform_driver liteeth_driver = {
 	.probe = liteeth_probe,
-	.remove_new = liteeth_remove,
+	.remove = liteeth_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = liteeth_of_match,
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 9e80899546d9..3071638b546e 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2902,7 +2902,7 @@ static void mv643xx_eth_shared_remove(struct platform_device *pdev)
 
 static struct platform_driver mv643xx_eth_shared_driver = {
 	.probe		= mv643xx_eth_shared_probe,
-	.remove_new	= mv643xx_eth_shared_remove,
+	.remove		= mv643xx_eth_shared_remove,
 	.driver = {
 		.name	= MV643XX_ETH_SHARED_NAME,
 		.of_match_table = of_match_ptr(mv643xx_eth_shared_ids),
@@ -3307,7 +3307,7 @@ static void mv643xx_eth_shutdown(struct platform_device *pdev)
 
 static struct platform_driver mv643xx_eth_driver = {
 	.probe		= mv643xx_eth_probe,
-	.remove_new	= mv643xx_eth_remove,
+	.remove		= mv643xx_eth_remove,
 	.shutdown	= mv643xx_eth_shutdown,
 	.driver = {
 		.name	= MV643XX_ETH_NAME,
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index e1d003fdbc2e..9f8a3ffec5f8 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -447,7 +447,7 @@ MODULE_DEVICE_TABLE(acpi, orion_mdio_acpi_match);
 
 static struct platform_driver orion_mdio_driver = {
 	.probe = orion_mdio_probe,
-	.remove_new = orion_mdio_remove,
+	.remove = orion_mdio_remove,
 	.driver = {
 		.name = "orion-mdio",
 		.of_match_table = orion_mdio_match,
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d72b2d5f96db..f5d6acee0d37 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5883,7 +5883,7 @@ MODULE_DEVICE_TABLE(of, mvneta_match);
 
 static struct platform_driver mvneta_driver = {
 	.probe = mvneta_probe,
-	.remove_new = mvneta_remove,
+	.remove = mvneta_remove,
 	.driver = {
 		.name = MVNETA_DRIVER_NAME,
 		.of_match_table = mvneta_match,
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 3f46a0fed048..6bb380494919 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -485,7 +485,7 @@ MODULE_DEVICE_TABLE(of, mvneta_bm_match);
 
 static struct platform_driver mvneta_bm_driver = {
 	.probe = mvneta_bm_probe,
-	.remove_new = mvneta_bm_remove,
+	.remove = mvneta_bm_remove,
 	.driver = {
 		.name = MVNETA_BM_DRIVER_NAME,
 		.of_match_table = mvneta_bm_match,
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 3880dcc0418b..103632ba78a2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7774,7 +7774,7 @@ MODULE_DEVICE_TABLE(acpi, mvpp2_acpi_match);
 
 static struct platform_driver mvpp2_driver = {
 	.probe = mvpp2_probe,
-	.remove_new = mvpp2_remove,
+	.remove = mvpp2_remove,
 	.driver = {
 		.name = MVPP2_DRIVER_NAME,
 		.of_match_table = mvpp2_match,
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 1a59c952aa01..fe38426ec42d 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1579,7 +1579,7 @@ MODULE_DEVICE_TABLE(of, pxa168_eth_of_match);
 
 static struct platform_driver pxa168_eth_driver = {
 	.probe = pxa168_eth_probe,
-	.remove_new = pxa168_eth_remove,
+	.remove = pxa168_eth_remove,
 	.shutdown = pxa168_eth_shutdown,
 	.resume = pxa168_eth_resume,
 	.suspend = pxa168_eth_suspend,
diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 930f180688e5..2fd53ea12691 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -2779,7 +2779,7 @@ MODULE_DEVICE_TABLE(of, of_airoha_match);
 
 static struct platform_driver airoha_driver = {
 	.probe = airoha_probe,
-	.remove_new = airoha_remove,
+	.remove = airoha_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_airoha_match,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..a476a94a607d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5358,7 +5358,7 @@ MODULE_DEVICE_TABLE(of, of_mtk_match);
 
 static struct platform_driver mtk_driver = {
 	.probe = mtk_probe,
-	.remove_new = mtk_remove,
+	.remove = mtk_remove,
 	.driver = {
 		.name = "mtk_soc_eth",
 		.of_match_table = of_mtk_match,
diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 385a56ac7348..fb2e5b844c15 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -520,7 +520,7 @@ MODULE_DEVICE_TABLE(acpi, mlxbf_gige_acpi_match);
 
 static struct platform_driver mlxbf_gige_driver = {
 	.probe = mlxbf_gige_probe,
-	.remove_new = mlxbf_gige_remove,
+	.remove = mlxbf_gige_remove,
 	.shutdown = mlxbf_gige_shutdown,
 	.driver = {
 		.name = KBUILD_MODNAME,
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index ddd87ef71caf..c7b0b09c2b09 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -1247,7 +1247,7 @@ static struct platform_driver ks8842_platform_driver = {
 		.name	= DRV_NAME,
 	},
 	.probe		= ks8842_probe,
-	.remove_new	= ks8842_remove,
+	.remove		= ks8842_remove,
 };
 
 module_platform_driver(ks8842_platform_driver);
diff --git a/drivers/net/ethernet/micrel/ks8851_par.c b/drivers/net/ethernet/micrel/ks8851_par.c
index 381b9cd285eb..78695be2570b 100644
--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -334,7 +334,7 @@ static struct platform_driver ks8851_driver = {
 		.pm = &ks8851_pm_ops,
 	},
 	.probe = ks8851_probe_par,
-	.remove_new = ks8851_remove_par,
+	.remove = ks8851_remove_par,
 };
 module_platform_driver(ks8851_driver);
 
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 534d4716d5f7..3234a960fcc3 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1285,7 +1285,7 @@ static void lan966x_remove(struct platform_device *pdev)
 
 static struct platform_driver lan966x_driver = {
 	.probe = lan966x_probe,
-	.remove_new = lan966x_remove,
+	.remove = lan966x_remove,
 	.driver = {
 		.name = "lan966x-switch",
 		.of_match_table = lan966x_match,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index b64c814eac11..1d893b2f4cda 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -945,7 +945,7 @@ MODULE_DEVICE_TABLE(of, mchp_sparx5_match);
 
 static struct platform_driver mchp_sparx5_driver = {
 	.probe = mchp_sparx5_probe,
-	.remove_new = mchp_sparx5_remove,
+	.remove = mchp_sparx5_remove,
 	.driver = {
 		.name = "sparx5-switch",
 		.of_match_table = mchp_sparx5_match,
diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 96dc69e7141f..8bd60168624a 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -576,7 +576,7 @@ MODULE_DEVICE_TABLE(of, moxart_mac_match);
 
 static struct platform_driver moxart_mac_driver = {
 	.probe	= moxart_mac_probe,
-	.remove_new = moxart_remove,
+	.remove = moxart_remove,
 	.driver	= {
 		.name		= "moxart-ethernet",
 		.of_match_table	= moxart_mac_match,
diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index c09dd2e3343c..055b55651a49 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -416,7 +416,7 @@ static void mscc_ocelot_remove(struct platform_device *pdev)
 
 static struct platform_driver mscc_ocelot_driver = {
 	.probe = mscc_ocelot_probe,
-	.remove_new = mscc_ocelot_remove,
+	.remove = mscc_ocelot_remove,
 	.driver = {
 		.name = "ocelot-switch",
 		.of_match_table = mscc_ocelot_match,
diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index 2b6e097df28f..6d29d2e1fa7c 100644
--- a/drivers/net/ethernet/natsemi/jazzsonic.c
+++ b/drivers/net/ethernet/natsemi/jazzsonic.c
@@ -241,7 +241,7 @@ static void jazz_sonic_device_remove(struct platform_device *pdev)
 
 static struct platform_driver jazz_sonic_driver = {
 	.probe	= jazz_sonic_probe,
-	.remove_new = jazz_sonic_device_remove,
+	.remove = jazz_sonic_device_remove,
 	.driver	= {
 		.name	= jazz_sonic_string,
 	},
diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index 2fc63860dbdb..a740e24a9759 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -545,7 +545,7 @@ static void mac_sonic_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver mac_sonic_platform_driver = {
 	.probe  = mac_sonic_platform_probe,
-	.remove_new = mac_sonic_platform_remove,
+	.remove = mac_sonic_platform_remove,
 	.driver = {
 		.name = "macsonic",
 	},
diff --git a/drivers/net/ethernet/natsemi/xtsonic.c b/drivers/net/ethernet/natsemi/xtsonic.c
index 8943e7244310..c01a4cb5dc0f 100644
--- a/drivers/net/ethernet/natsemi/xtsonic.c
+++ b/drivers/net/ethernet/natsemi/xtsonic.c
@@ -264,7 +264,7 @@ static void xtsonic_device_remove(struct platform_device *pdev)
 
 static struct platform_driver xtsonic_driver = {
 	.probe = xtsonic_probe,
-	.remove_new = xtsonic_device_remove,
+	.remove = xtsonic_device_remove,
 	.driver = {
 		.name = xtsonic_string,
 	},
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 2aa4ad9cf96e..230d5ff99dd7 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1415,7 +1415,7 @@ static void nixge_remove(struct platform_device *pdev)
 
 static struct platform_driver nixge_driver = {
 	.probe		= nixge_probe,
-	.remove_new	= nixge_remove,
+	.remove		= nixge_remove,
 	.driver		= {
 		.name		= "nixge",
 		.of_match_table	= nixge_dt_ids,
diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index dd3e58a1319c..8b9a3e3bba30 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1503,7 +1503,7 @@ MODULE_DEVICE_TABLE(of, lpc_eth_match);
 
 static struct platform_driver lpc_eth_driver = {
 	.probe		= lpc_eth_drv_probe,
-	.remove_new	= lpc_eth_drv_remove,
+	.remove		= lpc_eth_drv_remove,
 #ifdef CONFIG_PM
 	.suspend	= lpc_eth_drv_suspend,
 	.resume		= lpc_eth_drv_resume,
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 99d4647bf245..699a8afc214a 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -760,7 +760,7 @@ static void emac_shutdown(struct platform_device *pdev)
 
 static struct platform_driver emac_platform_driver = {
 	.probe	= emac_probe,
-	.remove_new = emac_remove,
+	.remove = emac_remove,
 	.driver = {
 		.name		= "qcom-emac",
 		.of_match_table = emac_dt_match,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c7ec23688d56..acb7356519b0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3279,7 +3279,7 @@ static const struct dev_pm_ops ravb_dev_pm_ops = {
 
 static struct platform_driver ravb_driver = {
 	.probe		= ravb_probe,
-	.remove_new	= ravb_remove,
+	.remove		= ravb_remove,
 	.driver = {
 		.name	= "ravb",
 		.pm	= pm_ptr(&ravb_dev_pm_ops),
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index b80aa27a7214..8d18dae4d8fb 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -2188,7 +2188,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(renesas_eth_sw_pm_ops, renesas_eth_sw_suspend,
 
 static struct platform_driver renesas_eth_sw_driver_platform = {
 	.probe = renesas_eth_sw_probe,
-	.remove_new = renesas_eth_sw_remove,
+	.remove = renesas_eth_sw_remove,
 	.driver = {
 		.name = "renesas_eth_sw",
 		.pm = pm_sleep_ptr(&renesas_eth_sw_pm_ops),
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 7a25903e35c3..8887b8921009 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3560,7 +3560,7 @@ MODULE_DEVICE_TABLE(platform, sh_eth_id_table);
 
 static struct platform_driver sh_eth_driver = {
 	.probe = sh_eth_drv_probe,
-	.remove_new = sh_eth_drv_remove,
+	.remove = sh_eth_drv_remove,
 	.id_table = sh_eth_id_table,
 	.driver = {
 		   .name = CARDNAME,
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
index e6e130dbe1de..2eccc7617507 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -224,7 +224,7 @@ MODULE_DEVICE_TABLE(of, sxgbe_dt_ids);
 
 static struct platform_driver sxgbe_platform_driver = {
 	.probe	= sxgbe_platform_probe,
-	.remove_new = sxgbe_platform_remove,
+	.remove = sxgbe_platform_remove,
 	.driver	= {
 		.name		= SXGBE_RESOURCE_NAME,
 		.pm		= &sxgbe_platform_pm_ops,
diff --git a/drivers/net/ethernet/seeq/sgiseeq.c b/drivers/net/ethernet/seeq/sgiseeq.c
index 76356dadf233..7967a0ee320b 100644
--- a/drivers/net/ethernet/seeq/sgiseeq.c
+++ b/drivers/net/ethernet/seeq/sgiseeq.c
@@ -832,7 +832,7 @@ static void sgiseeq_remove(struct platform_device *pdev)
 
 static struct platform_driver sgiseeq_driver = {
 	.probe	= sgiseeq_probe,
-	.remove_new = sgiseeq_remove,
+	.remove = sgiseeq_remove,
 	.driver = {
 		.name	= "sgiseeq",
 	}
diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index 98d0b561a057..4535579018c9 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -1273,7 +1273,7 @@ static void ioc3_set_multicast_list(struct net_device *dev)
 
 static struct platform_driver ioc3eth_driver = {
 	.probe  = ioc3eth_probe,
-	.remove_new = ioc3eth_remove,
+	.remove = ioc3eth_remove,
 	.driver = {
 		.name = "ioc3-eth",
 	}
diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index 18b6f93d875e..f7c3a5a766b7 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -864,7 +864,7 @@ static void meth_remove(struct platform_device *pdev)
 
 static struct platform_driver meth_driver = {
 	.probe	= meth_probe,
-	.remove_new = meth_remove,
+	.remove = meth_remove,
 	.driver = {
 		.name	= "meth",
 	}
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index a5e23e2da90f..9d1a83a5fa7e 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2475,7 +2475,7 @@ static const struct dev_pm_ops smc_drv_pm_ops = {
 
 static struct platform_driver smc_driver = {
 	.probe		= smc_drv_probe,
-	.remove_new	= smc_drv_remove,
+	.remove		= smc_drv_remove,
 	.driver		= {
 		.name	= CARDNAME,
 		.pm	= &smc_drv_pm_ops,
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 74f1ccc96459..f539813878f5 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2667,7 +2667,7 @@ MODULE_DEVICE_TABLE(acpi, smsc911x_acpi_match);
 
 static struct platform_driver smsc911x_driver = {
 	.probe = smsc911x_drv_probe,
-	.remove_new = smsc911x_drv_remove,
+	.remove = smsc911x_drv_remove,
 	.driver = {
 		.name	= SMSC_CHIPNAME,
 		.pm	= SMSC911X_PM_OPS,
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index 5ab8b81b84e6..dc99821c6226 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2211,7 +2211,7 @@ MODULE_DEVICE_TABLE(acpi, netsec_acpi_ids);
 
 static struct platform_driver netsec_driver = {
 	.probe	= netsec_probe,
-	.remove_new = netsec_remove,
+	.remove = netsec_remove,
 	.driver = {
 		.name = "netsec",
 		.pm = &netsec_pm_ops,
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index eed24e67c5a6..66b3549636f8 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1974,7 +1974,7 @@ MODULE_DEVICE_TABLE(of, of_ave_match);
 
 static struct platform_driver ave_driver = {
 	.probe  = ave_probe,
-	.remove_new = ave_remove,
+	.remove = ave_remove,
 	.driver	= {
 		.name = "ave",
 		.pm   = AVE_PM_OPS,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 643ee6d8d4dd..ef99ef3f1ab4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -135,7 +135,7 @@ MODULE_DEVICE_TABLE(of, anarion_dwmac_match);
 
 static struct platform_driver anarion_dwmac_driver = {
 	.probe  = anarion_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "anarion-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index ec924c6c76c6..83290e707df5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -479,7 +479,7 @@ MODULE_DEVICE_TABLE(of, dwc_eth_dwmac_match);
 
 static struct platform_driver dwc_eth_dwmac_driver = {
 	.probe  = dwc_eth_dwmac_probe,
-	.remove_new = dwc_eth_dwmac_remove,
+	.remove = dwc_eth_dwmac_remove,
 	.driver = {
 		.name           = "dwc-eth-dwmac",
 		.pm             = &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 6b65420e11b5..641f3cd019a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -422,7 +422,7 @@ MODULE_DEVICE_TABLE(of, imx_dwmac_match);
 
 static struct platform_driver imx_dwmac_driver = {
 	.probe  = imx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "imx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 19c93b998fb3..066783d66422 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -370,7 +370,7 @@ MODULE_DEVICE_TABLE(of, ingenic_mac_of_matches);
 
 static struct platform_driver ingenic_mac_driver = {
 	.probe		= ingenic_mac_probe,
-	.remove_new	= stmmac_pltfr_remove,
+	.remove		= stmmac_pltfr_remove,
 	.driver		= {
 		.name	= "ingenic-mac",
 		.pm		= pm_ptr(&ingenic_mac_pm_ops),
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d68f0c4e7835..230e79658c54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -167,7 +167,7 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
 
 static struct platform_driver intel_eth_plat_driver = {
 	.probe  = intel_eth_plat_probe,
-	.remove_new = intel_eth_plat_remove,
+	.remove = intel_eth_plat_remove,
 	.driver = {
 		.name		= "intel-eth-plat",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 4ba15873d5b1..61227dcf56dc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -499,7 +499,7 @@ MODULE_DEVICE_TABLE(of, ipq806x_gmac_dwmac_match);
 
 static struct platform_driver ipq806x_gmac_dwmac_driver = {
 	.probe = ipq806x_gmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name		= "ipq806x-gmac-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 4c810d8f5bea..22653ffd2a04 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_dwmac_match);
 
 static struct platform_driver lpc18xx_dwmac_driver = {
 	.probe  = lpc18xx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "lpc18xx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 2a9132d6d743..f8ca81675407 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -699,7 +699,7 @@ MODULE_DEVICE_TABLE(of, mediatek_dwmac_match);
 
 static struct platform_driver mediatek_dwmac_driver = {
 	.probe  = mediatek_dwmac_probe,
-	.remove_new = mediatek_dwmac_remove,
+	.remove = mediatek_dwmac_remove,
 	.driver = {
 		.name           = "dwmac-mediatek",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index a16bfa9089ea..5469fa1b429e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -78,7 +78,7 @@ MODULE_DEVICE_TABLE(of, meson6_dwmac_match);
 
 static struct platform_driver meson6_dwmac_driver = {
 	.probe  = meson6_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "meson6-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index b23944aa344e..9c2d62d133ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -520,7 +520,7 @@ MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
 
 static struct platform_driver meson8b_dwmac_driver = {
 	.probe  = meson8b_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "meson8b-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 50073bdade46..8cb374668b74 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -2073,7 +2073,7 @@ MODULE_DEVICE_TABLE(of, rk_gmac_dwmac_match);
 
 static struct platform_driver rk_gmac_dwmac_driver = {
 	.probe  = rk_gmac_probe,
-	.remove_new = rk_gmac_remove,
+	.remove = rk_gmac_remove,
 	.driver = {
 		.name           = "rk_gmac-dwmac",
 		.pm		= &rk_gmac_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
index 59a7bd560f96..13634965bc19 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rzn1.c
@@ -80,7 +80,7 @@ MODULE_DEVICE_TABLE(of, rzn1_dwmac_match);
 
 static struct platform_driver rzn1_dwmac_driver = {
 	.probe  = rzn1_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "rzn1-dwmac",
 		.of_match_table = rzn1_dwmac_match,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index fdb4c773ec98..0745117d5872 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -582,7 +582,7 @@ MODULE_DEVICE_TABLE(of, socfpga_dwmac_match);
 
 static struct platform_driver socfpga_dwmac_driver = {
 	.probe  = socfpga_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
 		.pm		= &socfpga_dwmac_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 4e1076faee0c..421666279dd3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -176,7 +176,7 @@ MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
 
 static struct platform_driver starfive_dwmac_driver = {
 	.probe  = starfive_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name = "starfive-dwmac",
 		.pm = &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index 4445cddc4cbe..a6ff02d905a9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -358,7 +358,7 @@ MODULE_DEVICE_TABLE(of, sti_dwmac_match);
 
 static struct platform_driver sti_dwmac_driver = {
 	.probe  = sti_dwmac_probe,
-	.remove_new = sti_dwmac_remove,
+	.remove = sti_dwmac_remove,
 	.driver = {
 		.name           = "sti-dwmac",
 		.pm		= &sti_dwmac_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index c1732955a697..1e8bac665cc9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -675,7 +675,7 @@ MODULE_DEVICE_TABLE(of, stm32_dwmac_match);
 
 static struct platform_driver stm32_dwmac_driver = {
 	.probe  = stm32_dwmac_probe,
-	.remove_new = stm32_dwmac_remove,
+	.remove = stm32_dwmac_remove,
 	.driver = {
 		.name           = "stm32-dwmac",
 		.pm		= &stm32_dwmac_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 4a0ae92b3055..4b7b2582a120 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1343,7 +1343,7 @@ MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);
 
 static struct platform_driver sun8i_dwmac_driver = {
 	.probe  = sun8i_dwmac_probe,
-	.remove_new = sun8i_dwmac_remove,
+	.remove = sun8i_dwmac_remove,
 	.shutdown = sun8i_dwmac_shutdown,
 	.driver = {
 		.name           = "dwmac-sun8i",
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 2653a9f0958c..9ae318436c4a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -172,7 +172,7 @@ MODULE_DEVICE_TABLE(of, sun7i_dwmac_match);
 
 static struct platform_driver sun7i_dwmac_driver = {
 	.probe  = sun7i_gmac_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "sun7i-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 362f85136c3e..f5891bc75c21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -371,7 +371,7 @@ static SIMPLE_DEV_PM_OPS(tegra_mgbe_pm_ops, tegra_mgbe_suspend, tegra_mgbe_resum
 
 static struct platform_driver tegra_mgbe_driver = {
 	.probe = tegra_mgbe_probe,
-	.remove_new = tegra_mgbe_remove,
+	.remove = tegra_mgbe_remove,
 	.driver = {
 		.name = "tegra-mgbe",
 		.pm		= &tegra_mgbe_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index a5a5cfa989c6..eccf7f537467 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -268,7 +268,7 @@ MODULE_DEVICE_TABLE(of, visconti_eth_dwmac_match);
 
 static struct platform_driver visconti_eth_dwmac_driver = {
 	.probe  = visconti_eth_dwmac_probe,
-	.remove_new = visconti_eth_dwmac_remove,
+	.remove = visconti_eth_dwmac_remove,
 	.driver = {
 		.name           = "visconti-eth-dwmac",
 		.of_match_table = visconti_eth_dwmac_match,
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 41a27ae58ced..df6d35d41b97 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -10182,7 +10182,7 @@ static struct platform_driver niu_of_driver = {
 		.of_match_table = niu_match,
 	},
 	.probe		= niu_of_probe,
-	.remove_new	= niu_of_remove,
+	.remove		= niu_of_remove,
 };
 
 #endif /* CONFIG_SPARC64 */
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index 16c86b13c185..bbb3a6ca19ed 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -1272,7 +1272,7 @@ static struct platform_driver bigmac_sbus_driver = {
 		.of_match_table = bigmac_sbus_match,
 	},
 	.probe		= bigmac_sbus_probe,
-	.remove_new	= bigmac_sbus_remove,
+	.remove		= bigmac_sbus_remove,
 };
 
 module_platform_driver(bigmac_sbus_driver);
diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
index aedd13c94225..2920341b14a0 100644
--- a/drivers/net/ethernet/sun/sunqe.c
+++ b/drivers/net/ethernet/sun/sunqe.c
@@ -965,7 +965,7 @@ static struct platform_driver qec_sbus_driver = {
 		.of_match_table = qec_sbus_match,
 	},
 	.probe		= qec_sbus_probe,
-	.remove_new	= qec_sbus_remove,
+	.remove		= qec_sbus_remove,
 };
 
 static int __init qec_init(void)
diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
index 391a1bc7f446..721d8ed3f302 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
@@ -549,7 +549,7 @@ MODULE_DEVICE_TABLE(of, spl2sw_of_match);
 
 static struct platform_driver spl2sw_driver = {
 	.probe = spl2sw_probe,
-	.remove_new = spl2sw_remove,
+	.remove = spl2sw_remove,
 	.driver = {
 		.name = "sp7021_emac",
 		.of_match_table = spl2sw_of_match,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index cbe99017cbfa..64c4fb03cfa4 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3769,7 +3769,7 @@ static struct platform_driver am65_cpsw_nuss_driver = {
 		.pm = &am65_cpsw_nuss_dev_pm_ops,
 	},
 	.probe = am65_cpsw_nuss_probe,
-	.remove_new = am65_cpsw_nuss_remove,
+	.remove = am65_cpsw_nuss_remove,
 };
 
 module_platform_driver(am65_cpsw_nuss_driver);
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index c0a5abd8d9a8..4ef8cf6ea135 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1802,7 +1802,7 @@ static struct platform_driver cpsw_driver = {
 		.of_match_table = cpsw_of_mtable,
 	},
 	.probe = cpsw_probe,
-	.remove_new = cpsw_remove,
+	.remove = cpsw_remove,
 };
 
 module_platform_driver(cpsw_driver);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 557cc71b9dd2..a98bcc5eb566 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2127,7 +2127,7 @@ static struct platform_driver cpsw_driver = {
 		.of_match_table = cpsw_of_mtable,
 	},
 	.probe = cpsw_probe,
-	.remove_new = cpsw_remove,
+	.remove = cpsw_remove,
 };
 
 module_platform_driver(cpsw_driver);
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index b0950a318c42..ed8116fb05e9 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -2070,7 +2070,7 @@ static struct platform_driver davinci_emac_driver = {
 		.of_match_table = davinci_emac_of_match,
 	},
 	.probe = davinci_emac_probe,
-	.remove_new = davinci_emac_remove,
+	.remove = davinci_emac_remove,
 };
 
 /**
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 8e07d4a1b6ba..68507126be8e 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -760,7 +760,7 @@ static struct platform_driver davinci_mdio_driver = {
 		.of_match_table = of_match_ptr(davinci_mdio_of_mtable),
 	},
 	.probe = davinci_mdio_probe,
-	.remove_new = davinci_mdio_remove,
+	.remove = davinci_mdio_remove,
 };
 
 static int __init davinci_mdio_init(void)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 5fd9902ab181..6ae6e33db5fc 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1645,7 +1645,7 @@ MODULE_DEVICE_TABLE(of, prueth_dt_match);
 
 static struct platform_driver prueth_driver = {
 	.probe = prueth_probe,
-	.remove_new = prueth_remove,
+	.remove = prueth_remove,
 	.driver = {
 		.name = "icssg-prueth",
 		.of_match_table = prueth_dt_match,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 292f04d29f4f..5024f0647a0d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -1215,7 +1215,7 @@ MODULE_DEVICE_TABLE(of, prueth_dt_match);
 
 static struct platform_driver prueth_driver = {
 	.probe = prueth_probe,
-	.remove_new = prueth_remove,
+	.remove = prueth_remove,
 	.driver = {
 		.name = "icssg-prueth-sr1",
 		.of_match_table = prueth_dt_match,
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 11b90e1da0c6..857820657bac 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2270,7 +2270,7 @@ static struct platform_driver netcp_driver = {
 		.of_match_table	= of_match,
 	},
 	.probe = netcp_probe,
-	.remove_new = netcp_remove,
+	.remove = netcp_remove,
 };
 module_platform_driver(netcp_driver);
 
diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index 554aff7c8f3b..c6957e3b7f0f 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -1676,7 +1676,7 @@ static void tsi108_ether_remove(struct platform_device *pdev)
 
 static struct platform_driver tsi_eth_driver = {
 	.probe = tsi108_init_one,
-	.remove_new = tsi108_ether_remove,
+	.remove = tsi108_ether_remove,
 	.driver	= {
 		.name = "tsi-ethernet",
 	},
diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index e80c02948801..894911f3d560 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -2570,7 +2570,7 @@ static struct pci_driver rhine_driver_pci = {
 
 static struct platform_driver rhine_driver_platform = {
 	.probe		= rhine_init_one_platform,
-	.remove_new	= rhine_remove_one_platform,
+	.remove		= rhine_remove_one_platform,
 	.driver = {
 		.name	= DRV_NAME,
 		.of_match_table	= rhine_of_tbl,
diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index 55fff4d0d380..dd4a07c97eee 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -3247,7 +3247,7 @@ static struct pci_driver velocity_pci_driver = {
 
 static struct platform_driver velocity_platform_driver = {
 	.probe		= velocity_platform_probe,
-	.remove_new	= velocity_platform_remove,
+	.remove		= velocity_platform_remove,
 	.driver = {
 		.name = "via-velocity",
 		.of_match_table = velocity_of_ids,
diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index b26fd15c25ae..b77f096eaf99 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -1271,6 +1271,6 @@ static struct platform_driver w5100_mmio_driver = {
 		.pm	= &w5100_pm_ops,
 	},
 	.probe		= w5100_mmio_probe,
-	.remove_new	= w5100_mmio_remove,
+	.remove		= w5100_mmio_remove,
 };
 module_platform_driver(w5100_mmio_driver);
diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index f165616f36fe..3e711dea3b2c 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -681,7 +681,7 @@ static struct platform_driver w5300_driver = {
 		.pm	= &w5300_pm_ops,
 	},
 	.probe		= w5300_probe,
-	.remove_new	= w5300_remove,
+	.remove		= w5300_remove,
 };
 
 module_platform_driver(w5300_driver);
diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 1072e2210aed..edb36ff07a0c 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1649,7 +1649,7 @@ MODULE_DEVICE_TABLE(of, temac_of_match);
 
 static struct platform_driver temac_driver = {
 	.probe = temac_probe,
-	.remove_new = temac_remove,
+	.remove = temac_remove,
 	.driver = {
 		.name = "xilinx_temac",
 		.of_match_table = temac_of_match,
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index fc35fcb22d94..2a000ac0e4d8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2997,7 +2997,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
 
 static struct platform_driver axienet_driver = {
 	.probe = axienet_probe,
-	.remove_new = axienet_remove,
+	.remove = axienet_remove,
 	.shutdown = axienet_shutdown,
 	.driver = {
 		 .name = "xilinx_axienet",
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 940452d0a4d2..2eb7f23538a6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1257,7 +1257,7 @@ static struct platform_driver xemaclite_of_driver = {
 		.of_match_table = xemaclite_of_match,
 	},
 	.probe		= xemaclite_of_probe,
-	.remove_new	= xemaclite_of_remove,
+	.remove		= xemaclite_of_remove,
 };
 
 module_platform_driver(xemaclite_of_driver);
diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index aef316278eb4..a2ab1c150822 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1619,7 +1619,7 @@ static struct platform_driver ixp4xx_eth_driver = {
 		.of_match_table = of_match_ptr(ixp4xx_eth_of_match),
 	},
 	.probe		= ixp4xx_eth_probe,
-	.remove_new	= ixp4xx_eth_remove,
+	.remove		= ixp4xx_eth_remove,
 };
 module_platform_driver(ixp4xx_eth_driver);
 

base-commit: ef545bc03a65438cabe87beb1b9a15b0ffcb6ace
-- 
2.45.2

