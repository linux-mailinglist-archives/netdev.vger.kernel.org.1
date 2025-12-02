Return-Path: <netdev+bounces-243319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EBC9CF06
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B623A866E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25302C2340;
	Tue,  2 Dec 2025 20:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X7Bn+rLB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEA2DCBFD
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 20:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708093; cv=none; b=rUG2SowqZ79BH2N06I6q4USlmPm3b7M//KMEE13S7Ko5kHQLgVZJ71Mu5bfVHRhVZWrIR1V78Y2r3yQ/53P7k3bgX6j2Q+S7JslYXF8guwdVNkfZzJKOE+eCq4AJrPtQ9+B+aDtlDY4sU7kaSCnNvzCLzKIyMl396cK0P5nQktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708093; c=relaxed/simple;
	bh=LEVfFlG6q94+HCB5W3L27hJjxPu11GGioFNqS50YjJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAP9CYyHGf5MrfwgOz6Phc52b2lljwpqQtiG26b2ebzHqk6xL3qeCAvBxZktgI7vinZUvlYF1yJBPs5WGtdLmPyStYsEmYmo85L1Q5qKEKsUpkkBqnpZU+IEayeGxsKuKsp/e6/jbZ0JJ2+1CJcQwYskc0KgIu9oHBNViVe9BHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X7Bn+rLB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s3waZXepCFkRRKIayStH6ArmL1LW0hsVTW1MZFUOLTY=; b=X7Bn+rLBvCfSdQwmghef670nf2
	kp/by7GLsazHs80cKwuoAFnzR1LHYdtOq7RNO0DLJsmodcDO60ENFc6PCi3botzqgA0rLajnE7lDz
	spJg0mguP0NIQDgmMClauD2dOcaHKkqrRROnIs9XJlFU/+IDZN9q8ltHwtpxkoEwTavbzF45RnhGW
	n5V6BOwIWMSELXdn9Lb+QAOtTW+7CN4q9gu50JFxbr9RJ6vg9a3v+k64bpR+60+btJ4mlOIHA4JkG
	fwgjut0BFNM7jE6TPknt0/US255FzQfOYl7zoMNW0D4djqSp4AMtLf8TjLMrZYQ2uURkHIn1W7pRX
	VtKDhEZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48208)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vQXBV-000000001yD-2l6c;
	Tue, 02 Dec 2025 20:41:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vQXBO-000000007mS-0bap;
	Tue, 02 Dec 2025 20:41:10 +0000
Date: Tue, 2 Dec 2025 20:41:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 04/15] net: stmmac: rk: convert to
 mask-based interface mode configuration
Message-ID: <aS9O5XqDQ_gyZSuN@shell.armlinux.org.uk>
References: <aS2rFBlz1jdwXaS8@shell.armlinux.org.uk>
 <E1vQ5F1-0000000GNvm-0EON@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vQ5F1-0000000GNvm-0EON@rmk-PC.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Just FYI,

I suggest not reviewing past this patch as I've been doing some reorg
to the patch set since posting... the basic idea remains, but stuff
is getting some renaming, and the "speed" register bitfields are moving
to their own struct.

Thanks.

On Mon, Dec 01, 2025 at 02:51:03PM +0000, Russell King (Oracle) wrote:
> Most of the Rockchip implementations use the phy_intf_sel values for
> interface mode configuration, but the register and field within that
> register vary between each SoC. They also have a RMII mode bit, which
> is in the same register but a different bit position.
> 
> Rather than having each and every Rockchip implementation cope with
> this using code, add struct members to specify the regmap register
> offset, and the bitfield masks for these two parameters.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 281 +++++++++++-------
>  1 file changed, 171 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index e9f531d6c22a..369792b62c5e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -45,6 +45,11 @@ struct rk_gmac_ops {
>  				    bool enable);
>  	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
>  	void (*integrated_phy_powerdown)(struct rk_priv_data *bsp_priv);
> +
> +	u16 phy_intf_sel_grf_reg;
> +	u16 phy_intf_sel_mask;
> +	u16 rmii_mode_mask;
> +
>  	bool php_grf_required;
>  	bool regs_valid;
>  	u32 regs[];
> @@ -90,12 +95,37 @@ struct rk_priv_data {
>  
>  	struct regmap *grf;
>  	struct regmap *php_grf;
> +
> +	u16 phy_intf_sel_grf_reg;
> +	u16 phy_intf_sel_mask;
> +	u16 rmii_mode_mask;
>  };
>  
>  #define GMAC_CLK_DIV1_125M		0
>  #define GMAC_CLK_DIV50_2_5M		2
>  #define GMAC_CLK_DIV5_25M		3
>  
> +static int rk_get_phy_intf_sel(phy_interface_t interface)
> +{
> +	int ret = stmmac_get_phy_intf_sel(interface);
> +
> +	/* Only RGMII and RMII are supported */
> +	if (ret != PHY_INTF_SEL_RGMII && ret != PHY_INTF_SEL_RMII)
> +		ret = -EINVAL;
> +
> +	return ret;
> +}
> +
> +static u32 rk_encode_wm16(u16 val, u16 mask)
> +{
> +	u32 reg_val = mask << 16;
> +
> +	if (mask)
> +		reg_val |= mask & (val << (ffs(mask) - 1));
> +
> +	return reg_val;
> +}
> +
>  static int rk_set_reg_speed(struct rk_priv_data *bsp_priv,
>  			    const struct rk_reg_speed_data *rsd,
>  			    unsigned int reg, phy_interface_t interface,
> @@ -239,14 +269,11 @@ static void rk_gmac_integrated_fephy_powerdown(struct rk_priv_data *priv,
>  #define PX30_GRF_GMAC_CON1		0x0904
>  
>  /* PX30_GRF_GMAC_CON1 */
> -#define PX30_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
>  #define PX30_GMAC_SPEED_10M		GRF_CLR_BIT(2)
>  #define PX30_GMAC_SPEED_100M		GRF_BIT(2)
>  
>  static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
> -		     PX30_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
>  }
>  
>  static int px30_set_speed(struct rk_priv_data *bsp_priv,
> @@ -281,6 +308,9 @@ static int px30_set_speed(struct rk_priv_data *bsp_priv,
>  static const struct rk_gmac_ops px30_ops = {
>  	.set_to_rmii = px30_set_to_rmii,
>  	.set_speed = px30_set_speed,
> +
> +	.phy_intf_sel_grf_reg = PX30_GRF_GMAC_CON1,
> +	.phy_intf_sel_mask = GENMASK_U16(6, 4),
>  };
>  
>  #define RK3128_GRF_MAC_CON0	0x0168
> @@ -295,7 +325,6 @@ static const struct rk_gmac_ops px30_ops = {
>  #define RK3128_GMAC_CLK_TX_DL_CFG(val) GRF_FIELD(6, 0, val)
>  
>  /* RK3128_GRF_MAC_CON1 */
> -#define RK3128_GMAC_PHY_INTF_SEL(val)  GRF_FIELD(8, 6, val)
>  #define RK3128_GMAC_FLOW_CTRL          GRF_BIT(9)
>  #define RK3128_GMAC_FLOW_CTRL_CLR      GRF_CLR_BIT(9)
>  #define RK3128_GMAC_SPEED_10M          GRF_CLR_BIT(10)
> @@ -303,15 +332,10 @@ static const struct rk_gmac_ops px30_ops = {
>  #define RK3128_GMAC_RMII_CLK_25M       GRF_BIT(11)
>  #define RK3128_GMAC_RMII_CLK_2_5M      GRF_CLR_BIT(11)
>  #define RK3128_GMAC_CLK(val)           GRF_FIELD_CONST(13, 12, val)
> -#define RK3128_GMAC_RMII_MODE          GRF_BIT(14)
> -#define RK3128_GMAC_RMII_MODE_CLR      GRF_CLR_BIT(14)
>  
>  static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> -	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
> -		     RK3128_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3128_GMAC_RMII_MODE_CLR);
>  	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON0,
>  		     DELAY_ENABLE(RK3128, tx_delay, rx_delay) |
>  		     RK3128_GMAC_CLK_RX_DL_CFG(rx_delay) |
> @@ -320,9 +344,6 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
> -		     RK3128_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3128_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3128_reg_speed_data = {
> @@ -344,6 +365,10 @@ static const struct rk_gmac_ops rk3128_ops = {
>  	.set_to_rgmii = rk3128_set_to_rgmii,
>  	.set_to_rmii = rk3128_set_to_rmii,
>  	.set_speed = rk3128_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RK3128_GRF_MAC_CON1,
> +	.phy_intf_sel_mask = GENMASK_U16(8, 6),
> +	.rmii_mode_mask = BIT_U16(14),
>  };
>  
>  #define RK3228_GRF_MAC_CON0	0x0900
> @@ -356,7 +381,6 @@ static const struct rk_gmac_ops rk3128_ops = {
>  #define RK3228_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
>  
>  /* RK3228_GRF_MAC_CON1 */
> -#define RK3228_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
>  #define RK3228_GMAC_FLOW_CTRL		GRF_BIT(3)
>  #define RK3228_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
>  #define RK3228_GMAC_SPEED_10M		GRF_CLR_BIT(2)
> @@ -364,8 +388,6 @@ static const struct rk_gmac_ops rk3128_ops = {
>  #define RK3228_GMAC_RMII_CLK_25M	GRF_BIT(7)
>  #define RK3228_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
>  #define RK3228_GMAC_CLK(val)		GRF_FIELD_CONST(9, 8, val)
> -#define RK3228_GMAC_RMII_MODE		GRF_BIT(10)
> -#define RK3228_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(10)
>  #define RK3228_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
>  #define RK3228_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(0)
>  #define RK3228_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
> @@ -378,8 +400,6 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
>  	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
> -		     RK3228_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3228_GMAC_RMII_MODE_CLR |
>  		     DELAY_ENABLE(RK3228, tx_delay, rx_delay));
>  
>  	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON0,
> @@ -389,10 +409,6 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
> -		     RK3228_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3228_GMAC_RMII_MODE);
> -
>  	/* set MAC to RMII mode */
>  	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1, GRF_BIT(11));
>  }
> @@ -426,13 +442,17 @@ static const struct rk_gmac_ops rk3228_ops = {
>  	.set_speed = rk3228_set_speed,
>  	.integrated_phy_powerup = rk3228_integrated_phy_powerup,
>  	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
> +
> +	.phy_intf_sel_grf_reg = RK3228_GRF_MAC_CON1,
> +	.phy_intf_sel_mask = GENMASK_U16(6, 4),
> +	.rmii_mode_mask = BIT_U16(10),
> +
>  };
>  
>  #define RK3288_GRF_SOC_CON1	0x0248
>  #define RK3288_GRF_SOC_CON3	0x0250
>  
>  /*RK3288_GRF_SOC_CON1*/
> -#define RK3288_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(8, 6, val)
>  #define RK3288_GMAC_FLOW_CTRL		GRF_BIT(9)
>  #define RK3288_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(9)
>  #define RK3288_GMAC_SPEED_10M		GRF_CLR_BIT(10)
> @@ -440,8 +460,6 @@ static const struct rk_gmac_ops rk3228_ops = {
>  #define RK3288_GMAC_RMII_CLK_25M	GRF_BIT(11)
>  #define RK3288_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(11)
>  #define RK3288_GMAC_CLK(val)		GRF_FIELD_CONST(13, 12, val)
> -#define RK3288_GMAC_RMII_MODE		GRF_BIT(14)
> -#define RK3288_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(14)
>  
>  /*RK3288_GRF_SOC_CON3*/
>  #define RK3288_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
> @@ -454,9 +472,6 @@ static const struct rk_gmac_ops rk3228_ops = {
>  static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> -	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
> -		     RK3288_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3288_GMAC_RMII_MODE_CLR);
>  	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON3,
>  		     DELAY_ENABLE(RK3288, tx_delay, rx_delay) |
>  		     RK3288_GMAC_CLK_RX_DL_CFG(rx_delay) |
> @@ -465,9 +480,6 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
> -		     RK3288_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3288_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3288_reg_speed_data = {
> @@ -489,12 +501,15 @@ static const struct rk_gmac_ops rk3288_ops = {
>  	.set_to_rgmii = rk3288_set_to_rgmii,
>  	.set_to_rmii = rk3288_set_to_rmii,
>  	.set_speed = rk3288_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RK3288_GRF_SOC_CON1,
> +	.phy_intf_sel_mask = GENMASK_U16(8, 6),
> +	.rmii_mode_mask = BIT_U16(14),
>  };
>  
>  #define RK3308_GRF_MAC_CON0		0x04a0
>  
>  /* RK3308_GRF_MAC_CON0 */
> -#define RK3308_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(4, 2, val)
>  #define RK3308_GMAC_FLOW_CTRL		GRF_BIT(3)
>  #define RK3308_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
>  #define RK3308_GMAC_SPEED_10M		GRF_CLR_BIT(0)
> @@ -502,8 +517,6 @@ static const struct rk_gmac_ops rk3288_ops = {
>  
>  static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
> -		     RK3308_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
>  }
>  
>  static const struct rk_reg_speed_data rk3308_reg_speed_data = {
> @@ -521,6 +534,9 @@ static int rk3308_set_speed(struct rk_priv_data *bsp_priv,
>  static const struct rk_gmac_ops rk3308_ops = {
>  	.set_to_rmii = rk3308_set_to_rmii,
>  	.set_speed = rk3308_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RK3308_GRF_MAC_CON0,
> +	.phy_intf_sel_mask = GENMASK_U16(4, 2),
>  };
>  
>  #define RK3328_GRF_MAC_CON0	0x0900
> @@ -533,7 +549,6 @@ static const struct rk_gmac_ops rk3308_ops = {
>  #define RK3328_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
>  
>  /* RK3328_GRF_MAC_CON1 */
> -#define RK3328_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
>  #define RK3328_GMAC_FLOW_CTRL		GRF_BIT(3)
>  #define RK3328_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
>  #define RK3328_GMAC_SPEED_10M		GRF_CLR_BIT(2)
> @@ -541,20 +556,32 @@ static const struct rk_gmac_ops rk3308_ops = {
>  #define RK3328_GMAC_RMII_CLK_25M	GRF_BIT(7)
>  #define RK3328_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(7)
>  #define RK3328_GMAC_CLK(val)		GRF_FIELD_CONST(12, 11, val)
> -#define RK3328_GMAC_RMII_MODE		GRF_BIT(9)
> -#define RK3328_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(9)
>  #define RK3328_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(0)
>  #define RK3328_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(1)
>  
>  /* RK3328_GRF_MACPHY_CON1 */
>  #define RK3328_MACPHY_RMII_MODE		GRF_BIT(9)
>  
> +static int rk3328_init(struct rk_priv_data *bsp_priv)
> +{
> +	switch (bsp_priv->id) {
> +	case 0: /* gmac2io */
> +		bsp_priv->phy_intf_sel_grf_reg = RK3328_GRF_MAC_CON1;
> +		return 0;
> +
> +	case 1: /* gmac2phy */
> +		bsp_priv->phy_intf_sel_grf_reg = RK3328_GRF_MAC_CON2;
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
>  	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
> -		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3328_GMAC_RMII_MODE_CLR |
>  		     RK3328_GMAC_RXCLK_DLY_ENABLE |
>  		     RK3328_GMAC_TXCLK_DLY_ENABLE);
>  
> @@ -565,13 +592,6 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	unsigned int reg;
> -
> -	reg = bsp_priv->id ? RK3328_GRF_MAC_CON2 : RK3328_GRF_MAC_CON1;
> -
> -	regmap_write(bsp_priv->grf, reg,
> -		     RK3328_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3328_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3328_reg_speed_data = {
> @@ -602,12 +622,16 @@ static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
>  }
>  
>  static const struct rk_gmac_ops rk3328_ops = {
> +	.init = rk3328_init,
>  	.set_to_rgmii = rk3328_set_to_rgmii,
>  	.set_to_rmii = rk3328_set_to_rmii,
>  	.set_speed = rk3328_set_speed,
>  	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
>  	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
>  
> +	.phy_intf_sel_mask = GENMASK_U16(6, 4),
> +	.rmii_mode_mask = BIT_U16(9),
> +
>  	.regs_valid = true,
>  	.regs = {
>  		0xff540000, /* gmac2io */
> @@ -620,7 +644,6 @@ static const struct rk_gmac_ops rk3328_ops = {
>  #define RK3366_GRF_SOC_CON7	0x041c
>  
>  /* RK3366_GRF_SOC_CON6 */
> -#define RK3366_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
>  #define RK3366_GMAC_FLOW_CTRL		GRF_BIT(8)
>  #define RK3366_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
>  #define RK3366_GMAC_SPEED_10M		GRF_CLR_BIT(7)
> @@ -628,8 +651,6 @@ static const struct rk_gmac_ops rk3328_ops = {
>  #define RK3366_GMAC_RMII_CLK_25M	GRF_BIT(3)
>  #define RK3366_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
>  #define RK3366_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
> -#define RK3366_GMAC_RMII_MODE		GRF_BIT(6)
> -#define RK3366_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
>  
>  /* RK3366_GRF_SOC_CON7 */
>  #define RK3366_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
> @@ -642,9 +663,6 @@ static const struct rk_gmac_ops rk3328_ops = {
>  static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> -	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
> -		     RK3366_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3366_GMAC_RMII_MODE_CLR);
>  	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON7,
>  		     DELAY_ENABLE(RK3366, tx_delay, rx_delay) |
>  		     RK3366_GMAC_CLK_RX_DL_CFG(rx_delay) |
> @@ -653,9 +671,6 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
> -		     RK3366_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3366_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3366_reg_speed_data = {
> @@ -677,13 +692,16 @@ static const struct rk_gmac_ops rk3366_ops = {
>  	.set_to_rgmii = rk3366_set_to_rgmii,
>  	.set_to_rmii = rk3366_set_to_rmii,
>  	.set_speed = rk3366_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RK3366_GRF_SOC_CON6,
> +	.phy_intf_sel_mask = GENMASK_U16(11, 9),
> +	.rmii_mode_mask = BIT_U16(6),
>  };
>  
>  #define RK3368_GRF_SOC_CON15	0x043c
>  #define RK3368_GRF_SOC_CON16	0x0440
>  
>  /* RK3368_GRF_SOC_CON15 */
> -#define RK3368_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
>  #define RK3368_GMAC_FLOW_CTRL		GRF_BIT(8)
>  #define RK3368_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
>  #define RK3368_GMAC_SPEED_10M		GRF_CLR_BIT(7)
> @@ -691,8 +709,6 @@ static const struct rk_gmac_ops rk3366_ops = {
>  #define RK3368_GMAC_RMII_CLK_25M	GRF_BIT(3)
>  #define RK3368_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
>  #define RK3368_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
> -#define RK3368_GMAC_RMII_MODE		GRF_BIT(6)
> -#define RK3368_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
>  
>  /* RK3368_GRF_SOC_CON16 */
>  #define RK3368_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
> @@ -705,9 +721,6 @@ static const struct rk_gmac_ops rk3366_ops = {
>  static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> -	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
> -		     RK3368_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3368_GMAC_RMII_MODE_CLR);
>  	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON16,
>  		     DELAY_ENABLE(RK3368, tx_delay, rx_delay) |
>  		     RK3368_GMAC_CLK_RX_DL_CFG(rx_delay) |
> @@ -716,9 +729,6 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
> -		     RK3368_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3368_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3368_reg_speed_data = {
> @@ -740,13 +750,16 @@ static const struct rk_gmac_ops rk3368_ops = {
>  	.set_to_rgmii = rk3368_set_to_rgmii,
>  	.set_to_rmii = rk3368_set_to_rmii,
>  	.set_speed = rk3368_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RK3368_GRF_SOC_CON15,
> +	.phy_intf_sel_mask = GENMASK_U16(11, 9),
> +	.rmii_mode_mask = BIT_U16(6),
>  };
>  
>  #define RK3399_GRF_SOC_CON5	0xc214
>  #define RK3399_GRF_SOC_CON6	0xc218
>  
>  /* RK3399_GRF_SOC_CON5 */
> -#define RK3399_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(11, 9, val)
>  #define RK3399_GMAC_FLOW_CTRL		GRF_BIT(8)
>  #define RK3399_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(8)
>  #define RK3399_GMAC_SPEED_10M		GRF_CLR_BIT(7)
> @@ -754,8 +767,6 @@ static const struct rk_gmac_ops rk3368_ops = {
>  #define RK3399_GMAC_RMII_CLK_25M	GRF_BIT(3)
>  #define RK3399_GMAC_RMII_CLK_2_5M	GRF_CLR_BIT(3)
>  #define RK3399_GMAC_CLK(val)		GRF_FIELD_CONST(5, 4, val)
> -#define RK3399_GMAC_RMII_MODE		GRF_BIT(6)
> -#define RK3399_GMAC_RMII_MODE_CLR	GRF_CLR_BIT(6)
>  
>  /* RK3399_GRF_SOC_CON6 */
>  #define RK3399_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(7)
> @@ -768,9 +779,6 @@ static const struct rk_gmac_ops rk3368_ops = {
>  static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> -	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
> -		     RK3399_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
> -		     RK3399_GMAC_RMII_MODE_CLR);
>  	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON6,
>  		     DELAY_ENABLE(RK3399, tx_delay, rx_delay) |
>  		     RK3399_GMAC_CLK_RX_DL_CFG(rx_delay) |
> @@ -779,9 +787,6 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
> -		     RK3399_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII) |
> -		     RK3399_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3399_reg_speed_data = {
> @@ -803,6 +808,10 @@ static const struct rk_gmac_ops rk3399_ops = {
>  	.set_to_rgmii = rk3399_set_to_rgmii,
>  	.set_to_rmii = rk3399_set_to_rmii,
>  	.set_speed = rk3399_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RK3399_GRF_SOC_CON5,
> +	.phy_intf_sel_mask = GENMASK_U16(11, 9),
> +	.rmii_mode_mask = BIT_U16(6),
>  };
>  
>  #define RK3506_GRF_SOC_CON8		0x0020
> @@ -1005,7 +1014,6 @@ static const struct rk_gmac_ops rk3528_ops = {
>  #define RK3568_GRF_GMAC1_CON1		0x038c
>  
>  /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
> -#define RK3568_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
>  #define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
>  #define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
>  #define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
> @@ -1017,6 +1025,22 @@ static const struct rk_gmac_ops rk3528_ops = {
>  #define RK3568_GMAC_CLK_RX_DL_CFG(val)	GRF_FIELD(14, 8, val)
>  #define RK3568_GMAC_CLK_TX_DL_CFG(val)	GRF_FIELD(6, 0, val)
>  
> +static int rk3568_init(struct rk_priv_data *bsp_priv)
> +{
> +	switch (bsp_priv->id) {
> +	case 0:
> +		bsp_priv->phy_intf_sel_grf_reg = RK3568_GRF_GMAC0_CON1;
> +		return 0;
> +
> +	case 1:
> +		bsp_priv->phy_intf_sel_grf_reg = RK3568_GRF_GMAC1_CON1;
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> @@ -1032,25 +1056,22 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
>  
>  	regmap_write(bsp_priv->grf, con1,
> -		     RK3568_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
>  		     RK3568_GMAC_RXCLK_DLY_ENABLE |
>  		     RK3568_GMAC_TXCLK_DLY_ENABLE);
>  }
>  
>  static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	u32 con1;
> -
> -	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
> -				     RK3568_GRF_GMAC0_CON1;
> -	regmap_write(bsp_priv->grf, con1,
> -		     RK3568_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
>  }
>  
>  static const struct rk_gmac_ops rk3568_ops = {
> +	.init = rk3568_init,
>  	.set_to_rgmii = rk3568_set_to_rgmii,
>  	.set_to_rmii = rk3568_set_to_rmii,
>  	.set_speed = rk_set_clk_mac_speed,
> +
> +	.phy_intf_sel_mask = GENMASK_U16(6, 4),
> +
>  	.regs_valid = true,
>  	.regs = {
>  		0xfe2a0000, /* gmac0 */
> @@ -1077,9 +1098,6 @@ static const struct rk_gmac_ops rk3568_ops = {
>  #define RK3576_GRF_GMAC_CON0			0X0020
>  #define RK3576_GRF_GMAC_CON1			0X0024
>  
> -#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
> -#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
> -
>  #define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
>  #define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
>  
> @@ -1091,16 +1109,27 @@ static const struct rk_gmac_ops rk3568_ops = {
>  #define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
>  #define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
>  
> +static int rk3576_init(struct rk_priv_data *bsp_priv)
> +{
> +	switch (bsp_priv->id) {
> +	case 0:
> +		bsp_priv->phy_intf_sel_grf_reg = RK3576_GRF_GMAC_CON0;
> +		return 0;
> +
> +	case 1:
> +		bsp_priv->phy_intf_sel_grf_reg = RK3576_GRF_GMAC_CON1;
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
>  	unsigned int offset_con;
>  
> -	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
> -					 RK3576_GRF_GMAC_CON0;
> -
> -	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RGMII_MODE);
> -
>  	offset_con = bsp_priv->id == 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
>  					 RK3576_VCCIO0_1_3_IOC_CON2;
>  
> @@ -1121,12 +1150,6 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	unsigned int offset_con;
> -
> -	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
> -					 RK3576_GRF_GMAC_CON0;
> -
> -	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
>  }
>  
>  static const struct rk_reg_speed_data rk3578_reg_speed_data = {
> @@ -1166,10 +1189,14 @@ static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
>  }
>  
>  static const struct rk_gmac_ops rk3576_ops = {
> +	.init = rk3576_init,
>  	.set_to_rgmii = rk3576_set_to_rgmii,
>  	.set_to_rmii = rk3576_set_to_rmii,
>  	.set_speed = rk3576_set_gmac_speed,
>  	.set_clock_selection = rk3576_set_clock_selection,
> +
> +	.rmii_mode_mask = BIT_U16(3),
> +
>  	.php_grf_required = true,
>  	.regs_valid = true,
>  	.regs = {
> @@ -1196,9 +1223,6 @@ static const struct rk_gmac_ops rk3576_ops = {
>  #define RK3588_GRF_GMAC_CON0			0X0008
>  #define RK3588_GRF_CLK_CON1			0X0070
>  
> -#define RK3588_GMAC_PHY_INTF_SEL(id, val)	\
> -	(GRF_FIELD(5, 3, val) << ((id) * 6))
> -
>  #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
>  #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
>  
> @@ -1214,6 +1238,22 @@ static const struct rk_gmac_ops rk3576_ops = {
>  #define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
>  #define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
>  
> +static int rk3588_init(struct rk_priv_data *bsp_priv)
> +{
> +	switch (bsp_priv->id) {
> +	case 0:
> +		bsp_priv->phy_intf_sel_mask = GENMASK_U16(5, 3);
> +		return 0;
> +
> +	case 1:
> +		bsp_priv->phy_intf_sel_mask = GENMASK_U16(11, 9);
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
> @@ -1222,9 +1262,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
>  					 RK3588_GRF_GMAC_CON8;
>  
> -	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
> -		     RK3588_GMAC_PHY_INTF_SEL(id, PHY_INTF_SEL_RGMII));
> -
>  	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
>  		     RK3588_GMAC_CLK_RGMII_MODE(id));
>  
> @@ -1239,9 +1276,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
> -		     RK3588_GMAC_PHY_INTF_SEL(bsp_priv->id, PHY_INTF_SEL_RMII));
> -
>  	regmap_write(bsp_priv->php_grf, RK3588_GRF_CLK_CON1,
>  		     RK3588_GMAC_CLK_RMII_MODE(bsp_priv->id));
>  }
> @@ -1294,10 +1328,14 @@ static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
>  }
>  
>  static const struct rk_gmac_ops rk3588_ops = {
> +	.init = rk3588_init,
>  	.set_to_rgmii = rk3588_set_to_rgmii,
>  	.set_to_rmii = rk3588_set_to_rmii,
>  	.set_speed = rk3588_set_gmac_speed,
>  	.set_clock_selection = rk3588_set_clock_selection,
> +
> +	.phy_intf_sel_grf_reg = RK3588_GRF_GMAC_CON0,
> +
>  	.php_grf_required = true,
>  	.regs_valid = true,
>  	.regs = {
> @@ -1310,7 +1348,6 @@ static const struct rk_gmac_ops rk3588_ops = {
>  #define RV1108_GRF_GMAC_CON0		0X0900
>  
>  /* RV1108_GRF_GMAC_CON0 */
> -#define RV1108_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
>  #define RV1108_GMAC_FLOW_CTRL		GRF_BIT(3)
>  #define RV1108_GMAC_FLOW_CTRL_CLR	GRF_CLR_BIT(3)
>  #define RV1108_GMAC_SPEED_10M		GRF_CLR_BIT(2)
> @@ -1320,8 +1357,6 @@ static const struct rk_gmac_ops rk3588_ops = {
>  
>  static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
> -		     RV1108_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
>  }
>  
>  static const struct rk_reg_speed_data rv1108_reg_speed_data = {
> @@ -1339,6 +1374,9 @@ static int rv1108_set_speed(struct rk_priv_data *bsp_priv,
>  static const struct rk_gmac_ops rv1108_ops = {
>  	.set_to_rmii = rv1108_set_to_rmii,
>  	.set_speed = rv1108_set_speed,
> +
> +	.phy_intf_sel_grf_reg = RV1108_GRF_GMAC_CON0,
> +	.phy_intf_sel_mask = GENMASK_U16(6, 4),
>  };
>  
>  #define RV1126_GRF_GMAC_CON0		0X0070
> @@ -1346,7 +1384,6 @@ static const struct rk_gmac_ops rv1108_ops = {
>  #define RV1126_GRF_GMAC_CON2		0X0078
>  
>  /* RV1126_GRF_GMAC_CON0 */
> -#define RV1126_GMAC_PHY_INTF_SEL(val)	GRF_FIELD(6, 4, val)
>  #define RV1126_GMAC_FLOW_CTRL			GRF_BIT(7)
>  #define RV1126_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(7)
>  #define RV1126_GMAC_M0_RXCLK_DLY_ENABLE		GRF_BIT(1)
> @@ -1369,7 +1406,6 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
>  	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
> -		     RV1126_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RGMII) |
>  		     RV1126_GMAC_M0_RXCLK_DLY_ENABLE |
>  		     RV1126_GMAC_M0_TXCLK_DLY_ENABLE |
>  		     RV1126_GMAC_M1_RXCLK_DLY_ENABLE |
> @@ -1386,14 +1422,15 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  
>  static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
> -		     RV1126_GMAC_PHY_INTF_SEL(PHY_INTF_SEL_RMII));
>  }
>  
>  static const struct rk_gmac_ops rv1126_ops = {
>  	.set_to_rgmii = rv1126_set_to_rgmii,
>  	.set_to_rmii = rv1126_set_to_rmii,
>  	.set_speed = rk_set_clk_mac_speed,
> +
> +	.phy_intf_sel_grf_reg = RV1126_GRF_GMAC_CON0,
> +	.phy_intf_sel_mask = GENMASK_U16(6, 4),
>  };
>  
>  static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
> @@ -1614,6 +1651,11 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
>  
>  	bsp_priv->dev = dev;
>  
> +	/* Set the default phy_intf_sel and RMII mode register parameters. */
> +	bsp_priv->phy_intf_sel_grf_reg = ops->phy_intf_sel_grf_reg;
> +	bsp_priv->phy_intf_sel_mask = ops->phy_intf_sel_mask;
> +	bsp_priv->rmii_mode_mask = ops->rmii_mode_mask;
> +
>  	if (ops->init) {
>  		ret = ops->init(bsp_priv);
>  		if (ret) {
> @@ -1649,6 +1691,7 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
>  static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  {
>  	struct device *dev = bsp_priv->dev;
> +	u32 val;
>  	int ret;
>  
>  	ret = rk_gmac_check_ops(bsp_priv);
> @@ -1659,6 +1702,24 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (bsp_priv->phy_intf_sel_mask) {
> +		/* Encode the phy_intf_sel value */
> +		val = rk_encode_wm16(ret, bsp_priv->phy_intf_sel_mask);
> +
> +		/* If defined, encode the RMII mode mask setting. */
> +		val |= rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				      bsp_priv->rmii_mode_mask);
> +
> +		ret = regmap_write(bsp_priv->grf,
> +				   bsp_priv->phy_intf_sel_grf_reg, val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	/*rmii or rgmii*/
>  	switch (bsp_priv->phy_iface) {
>  	case PHY_INTERFACE_MODE_RGMII:
> -- 
> 2.47.3
> 
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

