Return-Path: <netdev+bounces-211319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0CB17F88
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24727A1DCB
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8062264BD;
	Fri,  1 Aug 2025 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YwMNHNYy"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83F2E36E5;
	Fri,  1 Aug 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041525; cv=none; b=SAZiLiyTI8LdZKoSB2pqzMFYX5lQ7MqDUlAA/mRQUPrGpLe+373Hb+7lm1NHbSasVWKiZ+uAjmj7jT8PhXltwonF4OKhhNr8G8j5EKc7Y0XDdeaTvAa7Ux/0YmTCqP1YBD2zr8Lj7GKoe6rY83mWa6s/Vbeo7nZqUt6d2wRRG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041525; c=relaxed/simple;
	bh=qJVrbgFEjb8qceqM0uFyEYEUqH64XxmgCXWH2Medvs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOUxLwUijmCKMWSCMjIzqiUtluO2UwqVFW8LPwekxdo8RMCLRLycwtZiMJTHX4ASXZG4d6qwJ3K5req1+shAKWJjz25nYaDdDXLlNf7deT9BjRhuCdMlUkKWGrivEpIStcIG6iP1q/BRYRVb2kFO+sWGv5aZT2dVRpV3i0AAYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YwMNHNYy; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8811225D5A;
	Fri,  1 Aug 2025 11:45:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0C_rDAlOpObn; Fri,  1 Aug 2025 11:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754041521; bh=qJVrbgFEjb8qceqM0uFyEYEUqH64XxmgCXWH2Medvs8=;
	h=From:To:Cc:Subject:Date;
	b=YwMNHNYyJ/8SgYtB0wJP/c2a7b/tWXvCKQ462Wg8t64Li2DC2VnCpjlAvQyhN7qOs
	 xf8qWGSwZbL3qzGOPl5TTI+jvDOCZO8R1IhE98BaXuxSMxZLWyoXhWPmQILY24pQBO
	 PI4hQucFMRQjxzihEaSrY2vX55/rtfxN3mW/HsBb1PCWOUxgJ8B5Jy4jsaaQwrC1mi
	 V3In6j16auSKwgYPpee+fyd/CpbE5pfQSSx2C08zeL1GPdxWSXTBl2b9NTxFFNE+GD
	 Wa0HcaEVx3Krdw5jbau5uSiU9UYr8SNXQRWqNkACozAEoWlaWyC8c0pe8kJTm+XOqg
	 PfHdJ3B05sesA==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH net] net: stmmac: thead: Enable TX clock before MAC initialization
Date: Fri,  1 Aug 2025 09:45:07 +0000
Message-ID: <20250801094507.54011-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_tx_i clock must be supplied to the MAC for successful
initialization. On TH1520 SoC, the clock is provided by an internal
divider configured through GMAC_PLLCLK_DIV register when using RGMII
interface. However, currently we don't setup the divider before
initialization of the MAC, resulting in DMA reset failures if the
bootloader/firmware doesn't enable the divider,

[    7.839601] thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
[    7.938338] thead-dwmac ffe7060000.ethernet eth0: PHY [stmmac-0:02] driver [RTL8211F Gigabit Ethernet] (irq=POLL)
[    8.160746] thead-dwmac ffe7060000.ethernet eth0: Failed to reset the dma
[    8.170118] thead-dwmac ffe7060000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
[    8.179384] thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Hw setup failed

Let's simply write GMAC_PLLCLK_DIV_EN to GMAC_PLLCLK_DIV to enable the
divider before MAC initialization. The rate doesn't matter, which we
could reclock properly according to the link speed later after link is
up.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Fixes: 33a1a01e3afa ("net: stmmac: Add glue layer for T-HEAD TH1520 SoC")
---

Note that the DMA reset failures cannot be reproduced with the vendor
U-Boot, which always enables the divider, regardless whether the port is
used[1].

As this schema (enables the divider first and reclock it later) requires
access to the APB glue registers, the patch depends on v2 of series
"Fix broken link with TH1520 GMAC when linkspeed changes"[2] to ensure
the APB bus clock is ungated.

[1]: https://github.com/revyos/thead-u-boot/blob/93ff49d9f5bbe7942f727ab93311346173506d27/board/thead/light-c910/light.c#L581-L582
[2]: https://lore.kernel.org/netdev/20250801091240.46114-1-ziyao@disroot.org/

 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index 95096244a846..a65c2443bf42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -164,6 +164,7 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		/* use pll */
+		writel(GMAC_PLLCLK_DIV_EN, dwmac->apb_base + GMAC_PLLCLK_DIV);
 		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
 		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
 		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
-- 
2.50.1


