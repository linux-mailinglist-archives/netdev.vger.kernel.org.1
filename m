Return-Path: <netdev+bounces-253449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ7sEr9Ud2nMeAEAu9opvQ
	(envelope-from <netdev+bounces-253449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:49:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E687D30
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB9D3019079
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF232E6B8;
	Mon, 26 Jan 2026 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1ml0Xyoe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76232E69F
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427995; cv=none; b=BW4drQ5HgTGrqoEyenpn1gFxbpGLickgFg1OKfcJHzo0jaz7XSBJr9ff0gUxrZSc/9Z9gt1bjkngPQoOxXKZeOFofrtg0qnXGtavi7PAfluLkEoLSrwVVbiRb3654GCisuMEJ/wsGDnvH13IbIfRtbwm0Wa60kEtvZfLbLDCBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427995; c=relaxed/simple;
	bh=zVz3XCzTl+Fli1SZ0VOtMUx3ZW+TEeahbAdbJJea8OI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gKTVoCguK9PC/tsiNdjHfRfYAtV02GoZPrFxCy7yvxOn1MM7AUMv2WUQp2j+gRL1giqe0KMFoySfCjAPm+6+PKGHU51GbRjpSUPn/1bDFZ+6x1P++MRKcAhtvvOaUJniacul9K9rjpGP4juTIxBfMEVY9tYgsDkDH5wFCBYAhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1ml0Xyoe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vfPbEt7PFFH7zh3wFpVw4eLAjsZYTTAFHtA7vp3JvdY=; b=1ml0XyoePZ9Ao+ouQHwMaT7cAB
	OE/f80f4qHjIdt7w5cnYZWiBwpRA4f1gDDZ9Oy9dAmUEvgBozH0knEPSA/+5H+XKWQS1LEHG/2ZK5
	tzjhE+1wawxShpuvxHLqVR0WqnY0izdvfuKIwL3aOvkWUcFLxGBr7CWRRYmJbO9I2dOE7jA5Tc4QO
	AKW5+XjetmermSCiIdN6Jnx4ipfcWtTocRKIzRaY+eUlvzV0VNlxdQGf/PW6uIFDZ/TsV9oFh7coA
	vm5UR57FzCzY+J5PoT6zw8FohkXzWKjFN57o1ZaUARMgyeMp6cCVxHbZqRcg8pG08q2wU0jI80w4q
	l9JK0stw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47892 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkL2w-000000004hf-30Dz;
	Mon, 26 Jan 2026 11:46:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkL2s-00000005uta-3W8V;
	Mon, 26 Jan 2026 11:46:14 +0000
In-Reply-To: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 15/22] net: stmmac: rk: remove need for
 ->set_speed() method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkL2s-00000005uta-3W8V@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 11:46:14 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253449-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A77E687D30
X-Rspamd-Action: no action

As we can detect whether the SoC provides the parameters necessary for
rk_set_reg_speed(), we don't need to have explicit calls to this.
Instead, we can move the contents of this function to
rk_set_clk_tx_rate().

This remsoves all the .set_speed() implementations that merely go on to
invoke rk_set_reg_speed().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 153 ++++--------------
 1 file changed, 28 insertions(+), 125 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 663616208a4b..2a7fd82de848 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -167,37 +167,6 @@ static int rk_write_clock_grf_reg(struct rk_priv_data *bsp_priv, u32 val)
 	return regmap_write(regmap, bsp_priv->clock_grf_reg, val);
 }
 
-static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	unsigned int val;
-	int ret;
-
-	if (phy_interface_mode_is_rgmii(interface)) {
-		ret = rk_gmac_rgmii_clk_div(speed);
-		if (ret < 0)
-			return ret;
-
-		val = rk_encode_wm16(ret, bsp_priv->clock.gmii_clk_sel_mask);
-	} else if (interface == PHY_INTERFACE_MODE_RMII) {
-		val = rk_encode_wm16(speed == SPEED_100,
-				     bsp_priv->clock.mac_speed_mask) |
-		      rk_encode_wm16(speed == SPEED_100,
-				     bsp_priv->clock.rmii_clk_sel_mask);
-	} else {
-		/* This should never happen, as .get_interfaces() limits
-		 * the interface modes that are supported to RGMII and/or
-		 * RMII.
-		 */
-		return -EINVAL;
-	}
-
-	rk_write_clock_grf_reg(bsp_priv, val);
-
-	return 0;
-
-}
-
 static int rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv,
 				phy_interface_t interface, int speed)
 {
@@ -368,16 +337,9 @@ static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3128_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rk3128_ops = {
 	.set_to_rgmii = rk3128_set_to_rgmii,
 	.set_to_rmii = rk3128_set_to_rmii,
-	.set_speed = rk3128_set_speed,
 
 	.gmac_grf_reg = RK3128_GRF_MAC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
@@ -426,12 +388,6 @@ static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, GRF_BIT(11));
 }
 
-static int rk3228_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK3228_GRF_CON_MUX,
@@ -443,7 +399,6 @@ static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
 static const struct rk_gmac_ops rk3228_ops = {
 	.set_to_rgmii = rk3228_set_to_rgmii,
 	.set_to_rmii = rk3228_set_to_rmii,
-	.set_speed = rk3228_set_speed,
 	.integrated_phy_powerup = rk3228_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 
@@ -485,16 +440,9 @@ static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3288_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rk3288_ops = {
 	.set_to_rgmii = rk3288_set_to_rgmii,
 	.set_to_rmii = rk3288_set_to_rmii,
-	.set_speed = rk3288_set_speed,
 
 	.gmac_grf_reg = RK3288_GRF_SOC_CON1,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(8, 6),
@@ -516,15 +464,8 @@ static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rk3308_ops = {
 	.set_to_rmii = rk3308_set_to_rmii,
-	.set_speed = rk3308_set_speed,
 
 	.gmac_grf_reg = RK3308_GRF_MAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(4, 2),
@@ -586,12 +527,6 @@ static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3328_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK3328_GRF_MACPHY_CON1,
@@ -604,7 +539,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.init = rk3328_init,
 	.set_to_rgmii = rk3328_set_to_rgmii,
 	.set_to_rmii = rk3328_set_to_rmii,
-	.set_speed = rk3328_set_speed,
 	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 
@@ -650,16 +584,9 @@ static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3366_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rk3366_ops = {
 	.set_to_rgmii = rk3366_set_to_rgmii,
 	.set_to_rmii = rk3366_set_to_rmii,
-	.set_speed = rk3366_set_speed,
 
 	.gmac_grf_reg = RK3366_GRF_SOC_CON6,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
@@ -699,16 +626,9 @@ static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3368_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rk3368_ops = {
 	.set_to_rgmii = rk3368_set_to_rgmii,
 	.set_to_rmii = rk3368_set_to_rmii,
-	.set_speed = rk3368_set_speed,
 
 	.gmac_grf_reg = RK3368_GRF_SOC_CON15,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
@@ -748,16 +668,9 @@ static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3399_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rk3399_ops = {
 	.set_to_rgmii = rk3399_set_to_rgmii,
 	.set_to_rmii = rk3399_set_to_rmii,
-	.set_speed = rk3399_set_speed,
 
 	.gmac_grf_reg = RK3399_GRF_SOC_CON5,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(11, 9),
@@ -804,12 +717,6 @@ static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
 }
 
-static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
 				       bool input, bool enable)
 {
@@ -827,7 +734,6 @@ static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
 static const struct rk_gmac_ops rk3506_ops = {
 	.init = rk3506_init,
 	.set_to_rmii = rk3506_set_to_rmii,
-	.set_speed = rk3506_set_speed,
 	.set_clock_selection = rk3506_set_clock_selection,
 
 	.clock.rmii_clk_sel_mask = BIT_U16(3),
@@ -909,12 +815,6 @@ static void rk3528_set_to_rmii(struct rk_priv_data *bsp_priv)
 			     RK3528_GMAC0_PHY_INTF_SEL_RMII);
 }
 
-static int rk3528_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static void rk3528_set_clock_selection(struct rk_priv_data *bsp_priv,
 				       bool input, bool enable)
 {
@@ -947,7 +847,6 @@ static const struct rk_gmac_ops rk3528_ops = {
 	.init = rk3528_init,
 	.set_to_rgmii = rk3528_set_to_rgmii,
 	.set_to_rmii = rk3528_set_to_rmii,
-	.set_speed = rk3528_set_speed,
 	.set_clock_selection = rk3528_set_clock_selection,
 	.integrated_phy_powerup = rk3528_integrated_phy_powerup,
 	.integrated_phy_powerdown = rk3528_integrated_phy_powerdown,
@@ -1100,12 +999,6 @@ static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv,
-				 phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
 				       bool enable)
 {
@@ -1126,7 +1019,6 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.init = rk3576_init,
 	.set_to_rgmii = rk3576_set_to_rgmii,
 	.set_to_rmii = rk3576_set_to_rmii,
-	.set_speed = rk3576_set_gmac_speed,
 	.set_clock_selection = rk3576_set_clock_selection,
 
 	.gmac_rmii_mode_mask = BIT_U16(3),
@@ -1215,12 +1107,6 @@ static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
 }
 
-static int rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv,
-				 phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
 				       bool enable)
 {
@@ -1237,7 +1123,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 	.init = rk3588_init,
 	.set_to_rgmii = rk3588_set_to_rgmii,
 	.set_to_rmii = rk3588_set_to_rmii,
-	.set_speed = rk3588_set_gmac_speed,
 	.set_clock_selection = rk3588_set_clock_selection,
 
 	.gmac_grf_reg_in_php = true,
@@ -1265,15 +1150,8 @@ static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
 }
 
-static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
-			    phy_interface_t interface, int speed)
-{
-	return rk_set_reg_speed(bsp_priv, interface, speed);
-}
-
 static const struct rk_gmac_ops rv1108_ops = {
 	.set_to_rmii = rv1108_set_to_rmii,
-	.set_speed = rv1108_set_speed,
 
 	.gmac_grf_reg = RV1108_GRF_GMAC_CON0,
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
@@ -1702,11 +1580,36 @@ static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
 			      phy_interface_t interface, int speed)
 {
 	struct rk_priv_data *bsp_priv = bsp_priv_;
+	int ret = -EINVAL;
+	bool is_100m;
+	u32 val;
 
-	if (bsp_priv->ops->set_speed)
-		return bsp_priv->ops->set_speed(bsp_priv, interface, speed);
+	if (bsp_priv->ops->set_speed) {
+		ret = bsp_priv->ops->set_speed(bsp_priv, interface, speed);
+		if (ret < 0)
+			return ret;
+	}
 
-	return -EINVAL;
+	if (phy_interface_mode_is_rgmii(interface) &&
+	    bsp_priv->clock.gmii_clk_sel_mask) {
+		ret = rk_gmac_rgmii_clk_div(speed);
+		if (ret < 0)
+			return ret;
+
+		val = rk_encode_wm16(ret, bsp_priv->clock.gmii_clk_sel_mask);
+
+		ret = rk_write_clock_grf_reg(bsp_priv, val);
+	} else if (interface == PHY_INTERFACE_MODE_RMII &&
+		   (bsp_priv->clock.rmii_clk_sel_mask ||
+		    bsp_priv->clock.mac_speed_mask)) {
+		is_100m = speed == SPEED_100;
+		val = rk_encode_wm16(is_100m, bsp_priv->clock.mac_speed_mask) |
+		      rk_encode_wm16(is_100m, bsp_priv->clock.rmii_clk_sel_mask);
+
+		ret = rk_write_clock_grf_reg(bsp_priv, val);
+	}
+
+	return ret;
 }
 
 static int rk_gmac_suspend(struct device *dev, void *bsp_priv_)
-- 
2.47.3


