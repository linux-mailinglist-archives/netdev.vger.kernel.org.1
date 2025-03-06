Return-Path: <netdev+bounces-172597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA264A5578D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435EF7AA4CB
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221EA274264;
	Thu,  6 Mar 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="mrzCPSYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8118BC26
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293554; cv=none; b=cw8HPGlQ4m1quunSVo2kph54NfKvz8o5juntb6hyL4Ox2Jb45UPrLMvBK7adr0UFcioSN0h2LI61v90X0oVUEfE3eyPzlVcExehuoqnL0iPLqgdMy6yZLY4RYm8C4aiH7BsCGcuv5uqM/IJ63kUevhRE6xh0vaKWDt8QRbCIeWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293554; c=relaxed/simple;
	bh=wduhX53R8HjEeAjnRW1KoaV39KQVKrQ6gif7EZPc4Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyoBK03HvgSg2auKBkTk2ZzEhB6k3CITvRa/4WPLxFpjKN6+irzUlBMGs4HUsg/9pqprGBZoNOqh5ygjWdRB7dE49saNo6uf+BHO0iblLmKgCpbl/gg6xHfojR3erzNiRB1EwN8bOHqkqmq1IHlbnAoYevvvDKJnNCNqW3dIx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=mrzCPSYp; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741293549; bh=7JyxP8FBRDIO7vgzFTNLCIrseIO0xPkXO1N8Yvb5Wzo=;
 b=mrzCPSYp2vBoEgERGbhVXHiYhoFEygSIzdYjgLOIMzPYQRXFKwoRprf8SHOMlcEZjL0s8y5tb
 eflUW8t1NA/E7BZsAfHmYJk3nR+eEHZ+tetP3cVSemZQSZtyd77j/JwdkKolWS2vH9sfNuHffzi
 WMI241LU8bj5eFccdMtu0uBIP8RYGJXvsqGqdxG/rfGsTANWRaXLYRFYApZpLDLqlcWRT3IuwkC
 FLiq43rIrXCLzrfJyPjmGfp+Pw7g7oK7nsShu8dAbNtXZUwIFZzZ+wbBNduemgqM8QkXsZ7ZOZF
 8EsDCbOe8+3vYu1+ziJ15mH8dapo7i0PKhAuVaJRjfVg==
X-Forward-Email-ID: 67ca07ecdeafcb1458af9261
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Wadim Egorov <w.egorov@phytec.de>
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3328
Date: Thu,  6 Mar 2025 20:38:52 +0000
Message-ID: <20250306203858.1677595-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306203858.1677595-1-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Rockchip RK3328 GMAC and addition of the DELAY_ENABLE macro
was merged in the same merge window. This resulted in RK3328 not being
converted to use the new DELAY_ENABLE macro.

Change to use the DELAY_ENABLE macro to help disable MAC delay when
RGMII_ID/RXID/TXID is used.

Fixes: eaf70ad14cbb ("net: stmmac: dwmac-rk: Add handling for RGMII_ID/RXID/TXID")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 003fa5cf42c3..297fa93e4a39 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -593,8 +593,7 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
 		     RK3328_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3328_GMAC_RMII_MODE_CLR |
-		     RK3328_GMAC_RXCLK_DLY_ENABLE |
-		     RK3328_GMAC_TXCLK_DLY_ENABLE);
+		     DELAY_ENABLE(RK3328, tx_delay, rx_delay));
 
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON0,
 		     RK3328_GMAC_CLK_RX_DL_CFG(rx_delay) |
-- 
2.48.1


