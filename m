Return-Path: <netdev+bounces-248076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A3D030FB
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83637309886F
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9B3A63F0;
	Thu,  8 Jan 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLgIxyIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD83ACEED;
	Thu,  8 Jan 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877707; cv=none; b=Uyi8PzrPSi0+X0GCRp85/C2gLC8EBbOcxavn63yyXvOzb6fWGDp726+tqyjvtf2D9EVX/uoCD+sHuuYS4r0VCtGRsz0P/hbP7tyQhz3FxtYI/6YiQ4Du7wb0yGn5IJ9Z7h9+1rJypg1nWM3ldaK3MJpSM8vhy8JUhpXghHoC7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877707; c=relaxed/simple;
	bh=WZjdReui+9uqUJBxWx2+yu3EA2Z46nNDOpIBBhIZ02I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9lCYEh/29mchp6mj/5lJH14GUw1C3iZigfNHa7mBSFlY+l9SM/KRvT0OfFcEk3brBYXaLorlBI0pnzvnBzmulH8PT6AoEo7hxlxzN2Ae9Grex5m+kRqDv6EYY0OSspAkFqG8G45A3b7Grg4aWUxBn3W/2FVgRNqgMK+w+K7rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLgIxyIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C7C19421;
	Thu,  8 Jan 2026 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767877706;
	bh=WZjdReui+9uqUJBxWx2+yu3EA2Z46nNDOpIBBhIZ02I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mLgIxyIabylAX90rx8Jn7L7Ic7m5O6LPAg00NPgiwUYN3y+JMJBkdqB/7Vxi3rLZD
	 Jg5EmXYj+477H+SmSv5xI9DFNGRcTmkwoa1O/w5Axf7zPG0kXQ+zKMWgNPgMKYN7FG
	 LYBwveojc4+eDCgY2l44SC+0FgsLOjXcMeoeKVoWltRFpLg6S4wmwdsFbBSiGaY6Fk
	 Q380fpWdb59Orv57GDKpV/skFTr3SN2SpYRCXdxvB//6hE/sM/+aJKp+YqHwodbIqQ
	 MVKrl59yk9yyscEMBA/o3p822Cers2a23PvADzPEOdykLGYREzi1q2pEc3Y6V1Pk4S
	 r3qd+RNZFQfVQ==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Thu, 08 Jan 2026 07:08:09 -0600
Subject: [PATCH v3 1/3] net: stmmac: socfpga: add call to assert/deassert
 ahb reset line
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-remove_ocp-v3-1-ea0190244b4c@kernel.org>
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
In-Reply-To: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2820; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=WZjdReui+9uqUJBxWx2+yu3EA2Z46nNDOpIBBhIZ02I=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpX6xFghfZ1y+O/7GElll7ySvx0smqv/iVf0Hry
 vmvy//a2CKJAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaV+sRQAKCRAZlAQLgaMo
 9NAZD/9xVkxvSB9+n9yzDdezbrLFCJNDOIoDca0A0vbDwXhREq046hORyNqa6F0s1XEMl7z0MQJ
 6XqSywVv/pbGH3ais/VL6jbBKGIw+9tQt/bbVrO9kzMp8CEe3V8WlneIAsVu4iVp1l8KWicTBX0
 jHfATx7DsBk+nk3t11X+lxACHPilw1I+iMis2nQPE1+0V2/o2reGfVNITYIsWXDRjs0buG6GXOo
 bY5ib1cMuoBGIMUpyEnD2zXbYvi9PHxq3D0gmXRCnnVkE8ZfcfbSVtEV1S+9SKrVVQtPuBOb70o
 MYrPpsc+yV8pbuJqylwEcXBVFZbwNqynnPTgLBEvltk7nuV/ivY+F11ePuOA2Tk5N7FgrnjU+Gj
 /DjKsbckxRKJBiAOYMfT5kfg4imlMvYpfQQc28vF2BUYN5c/iav5aHm4S72fceMcmku/MqQdlwc
 36vPHQlDkdNnpwA/EEvmOfbMTIxHd7+drJbo4HfE2XekorW7lu96sd7nurgFRM2hgh8DwPg80pi
 IZnLChkpAFOtgFkCemmsROs59GWgYL1iv46I5M1xmRMT5i9IknJNn6n79ZjcEridvU+btshj2SN
 HSd5z8sm7cToPWXCs/tag7wQ8wkN67twox5b1eRI6pz9G1abjUBUJuleEeJWvITb1sDZDF4m9qV
 AHaJo/qohyIqx1A==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

The "stmmaceth-ocp" reset line of stmmac controller on the SoCFPGA
platform is essentially the "ahb" reset on the standard stmmac
controller. But since stmmaceth-ocp has already been introduced into
the wild, we cannot just remove support for it. But what we can do is
to support both "stmmaceth-ocp" and "ahb" reset names. Going forward we
will be using "ahb", but in order to not break ABI, we will be call reset
assert/de-assert both ahb and stmmaceth-ocp.

The ethernet hardware on SoCFPGA requires either the stmmaceth-ocp or
ahb reset to be asserted every time before changing the phy mode, then
de-asserted when the phy mode has been set.

With this change, we should be able to revert patch:
commit 62a40a0d5634 ("arm: dts: socfpga: use reset-name "stmmaceth-ocp"
instead of "ahb"")

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index a2b52d2c4eb6f..79df55515c718 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -407,6 +407,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 
 	/* Assert reset to the enet controller before changing the phy mode */
 	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
@@ -436,6 +437,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	 * the enet controller, and operation to start in requested mode
 	 */
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII)
 		socfpga_sgmii_config(dwmac, true);
@@ -463,6 +465,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 
 	/* Assert reset to the enet controller before changing the phy mode */
 	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
@@ -489,6 +492,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	 * the enet controller, and operation to start in requested mode
 	 */
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII)
 		socfpga_sgmii_config(dwmac, true);

-- 
2.42.0.411.g813d9a9188


