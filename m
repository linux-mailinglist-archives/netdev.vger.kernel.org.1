Return-Path: <netdev+bounces-118922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696B953861
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2E1B21207
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB91B4C4B;
	Thu, 15 Aug 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1s8vPwKD"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7B10E5;
	Thu, 15 Aug 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739872; cv=none; b=jO7xe08f3GxdE0+wgVjwq92LSazOxH4U75kJq/sVr6xZhFpfP3jDuyPrqaPGBSG5dEQi8oWP4weLWH+f0ZhTowH5UpAFVxjxfojQ5+geFOpL2KqgqUDi+k7geOFQMpl6NjnIEBKpfaxVtH78GRZyYLALTQQVwtr775F488ZEY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739872; c=relaxed/simple;
	bh=wS7NvznDEOIUaRvq/FI7azryJRMWQXghomS49B6kbOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUINwEqH6d6j9EGaMhRbn3eJWBoocr/OS7+kMInPJFFvegBczIFvat7Kb2aALdiFCp4ocHK9l5sehm2eIeDYe1uZbUkCBjy8jVjRm7jgtSle/4F7k1CblizJlRB+tuPZcxkoTi4DP8VLL7HGLrW/NoxFZu9VtQHbXu4DJy5WBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1s8vPwKD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YzUauLZvtjkpYS5lkyPVzFy8sIAW53Spuybo7DpFzHg=; b=1s8vPwKDJKVPOkmLl2ZEgVEhsh
	xWWvtexSHGfq96JwEO8yh1EiwGp/ixle8zY9J539ZsT7PBYlT1Q4dZLgXN2gANxhLB16aP3SwGj1O
	DAXRCXOgDJqEurAN3aYecG4CL+gXE29beIZsx6GVb+xu50jjsJDW+caOxnzCkmR7Q70ofss6roiX7
	YvTr4brg2vR1Vs4kwyJ1SHL7s7Ms83yjrKC9zP1z/+EcySKtVch6UIEW3cCom/OncYuxNl4CHZ4D5
	YKKqRjlWZsnKp/fuqwZGVfqsRdsdtVl3RPEVqp9TxhBDczME/SwrAcy/56QUYh98XzBtsfjTxAiHv
	8NdnR7Ug==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sedTl-0005SG-25; Thu, 15 Aug 2024 18:37:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 David Wu <david.wu@rock-chips.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@collabora.com
Subject:
 Re: [PATCH v2 2/2] ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576
Date: Thu, 15 Aug 2024 18:37:35 +0200
Message-ID: <10024041.2OtUDhi4od@diego>
In-Reply-To: <3304458.aeNJFYEL58@trenzalore>
References:
 <20240808170113.82775-1-detlev.casanova@collabora.com>
 <3724132.9z1YWOviru@diego> <3304458.aeNJFYEL58@trenzalore>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 9. August 2024, 16:38:23 CEST schrieb Detlev Casanova:
> On Friday, 9 August 2024 09:16:44 EDT Heiko St=FCbner wrote:
> > Hi Detlev,
> >=20
> > Am Donnerstag, 8. August 2024, 19:00:18 CEST schrieb Detlev Casanova:
> > > From: David Wu <david.wu@rock-chips.com>
> > >=20
> > > Add constants and callback functions for the dwmac on RK3576 soc.
> > >=20
> > > Signed-off-by: David Wu <david.wu@rock-chips.com>
> > > [rebase, extracted bindings]
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > >=20
> > >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 156 ++++++++++++++++=
++
> > >  1 file changed, 156 insertions(+)
> > >=20
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c index
> > > 7ae04d8d291c8..e1fa8fc9f4012 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > @@ -1116,6 +1116,161 @@ static const struct rk_gmac_ops rk3568_ops =
=3D {
> > >=20
> > >  	},
> > > =20
> > >  };
> > >=20
>=20
> [...]
>=20
> > > +/* SDGMAC_GRF */
> > > +#define RK3576_GRF_GMAC_CON0			0X0020
> > > +#define RK3576_GRF_GMAC_CON1			0X0024
> > > +
> > > +#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
> > > +#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
> > > +
> > > +#define RK3576_GMAC_CLK_SELET_IO		GRF_BIT(7)
> > > +#define RK3576_GMAC_CLK_SELET_CRU		GRF_CLR_BIT(7)
> >=20
> > nit: typos _CLK_SELECT_ ... missing the C in select
>=20
> Ack

So all points below are resolved, and with the C added
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>=20
> > > +
> > > +#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
> > > +#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
> >=20
> > I think those are backwards
> > The TRM says bit[5]=3D0: 25MHz (DIV2) and bit[5]=3D1: 2.5MHz (DIV20)
> >=20
> > I guess nobody also on Rockchip's side tested a RMII phy on those contr=
ollrs
>=20
> Can't be sure about that. An error in the TRM is not impossible either, a=
s for=20
> rk3588, it is also bit[5]=3D0: DIV20 and bit[5]=3D1: DIV2. I can switch t=
hem to=20
> match the TRM though, we may never now.

As David said, the TRM is wrong and the code is correct, so all good


>=20
> > > +
> > > +#define RK3576_GMAC_CLK_RGMII_DIV1		\
> > > +			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
> > > +#define RK3576_GMAC_CLK_RGMII_DIV5		\
> > > +			(GRF_BIT(6) | GRF_BIT(5))
> > > +#define RK3576_GMAC_CLK_RGMII_DIV50		\
> > > +			(GRF_BIT(6) | GRF_CLR_BIT(5))
> > > +
> >=20
> > in contrast, these are correct and match the TRM
> >=20
> > > +#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
> > > +#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
> > > +
> > > +static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
> > > +				int tx_delay, int rx_delay)
> > > +{
> > > +	struct device *dev =3D &bsp_priv->pdev->dev;
> > > +	unsigned int offset_con;
> > > +
> > > +	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
> > > +		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf=20
> property\n");
> > > +		return;
> > > +	}
> > > +
> > > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > > +					 RK3576_GRF_GMAC_CON0;
> > > +
> > > +	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RGMII_MODE);
> > > +
> > > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
> > > +					=20
> RK3576_VCCIO0_1_3_IOC_CON2;
> > > +
> > > +	/* m0 && m1 delay enabled */
> > > +	regmap_write(bsp_priv->php_grf, offset_con,
> > > +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> > > +	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
> > > +		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
> > > +
> > > +	/* m0 && m1 delay value */
> > > +	regmap_write(bsp_priv->php_grf, offset_con,
> > > +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> > > +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> > > +	regmap_write(bsp_priv->php_grf, offset_con + 0x4,
> > > +		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
> > > +		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
> > > +}
> > > +
> > > +static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
> > > +{
> > > +	struct device *dev =3D &bsp_priv->pdev->dev;
> > > +	unsigned int offset_con;
> > > +
> > > +	if (IS_ERR(bsp_priv->php_grf)) {
> > > +		dev_err(dev, "%s: Missing rockchip,php_grf property\n",=20
> __func__);
> > > +		return;
> > > +	}
> > > +
> > > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > > +					 RK3576_GRF_GMAC_CON0;
> > > +
> > > +	regmap_write(bsp_priv->grf, offset_con, RK3576_GMAC_RMII_MODE);
> > > +}
> > > +
> > > +static void rk3576_set_gmac_speed(struct rk_priv_data *bsp_priv, int
> > > speed) +{
> > > +	struct device *dev =3D &bsp_priv->pdev->dev;
> > > +	unsigned int val =3D 0, offset_con;
> > > +
> > > +	switch (speed) {
> > > +	case 10:
> > > +		if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> > > +			val =3D RK3576_GMAC_CLK_RMII_DIV20;
> > > +		else
> > > +			val =3D RK3576_GMAC_CLK_RGMII_DIV50;
> >=20
> > 		val =3D bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII ?
> > 				RK3576_GMAC_CLK_RMII_DIV20 :
> > 				RK3576_GMAC_CLK_RGMII_DIV50;
> > perhaps?
>=20
> This way matches how it is written in rk3588_set_gmac_speed(). I find tha=
t=20
> having similar code for similar functions helps reading and understanding=
 it=20
> better (although I agree that your suggestion looks better).
>=20
> I'd rather keep it like it is for now if that's ok.

ok, there is not much difference between the two variants anyway.


> > > +		break;
> > > +	case 100:
> > > +		if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> > > +			val =3D RK3576_GMAC_CLK_RMII_DIV2;
> > > +		else
> > > +			val =3D RK3576_GMAC_CLK_RGMII_DIV5;
> >=20
> > same as above?
> >=20
> > > +		break;
> > > +	case 1000:
> > > +		if (bsp_priv->phy_iface !=3D PHY_INTERFACE_MODE_RMII)
> > > +			val =3D RK3576_GMAC_CLK_RGMII_DIV1;
> > > +		else
> > > +			goto err;
> >=20
> > 		if (bsp_priv->phy_iface =3D=3D PHY_INTERFACE_MODE_RMII)
> > 			goto err;
> >=20
> > 		val =3D RK3576_GMAC_CLK_RGMII_DIV1;
> >=20
> > > +		break;
> > > +	default:
> > > +		goto err;
> > > +	}
> > > +
> > > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > > +					 RK3576_GRF_GMAC_CON0;
> > > +
> > > +	regmap_write(bsp_priv->grf, offset_con, val);
> > > +
> > > +	return;
> > > +err:
> > > +	dev_err(dev, "unknown speed value for GMAC speed=3D%d", speed);
> > > +}
> > > +
> > > +static void rk3576_set_clock_selection(struct rk_priv_data *bsp_priv,
> > > bool input, +				       bool enable)
> > > +{
> > > +	unsigned int val =3D input ? RK3576_GMAC_CLK_SELET_IO :
> > > +				   RK3576_GMAC_CLK_SELET_CRU;
> > > +	unsigned int offset_con;
> > > +
> > > +	val |=3D enable ? RK3576_GMAC_CLK_RMII_NOGATE :
> > > +			RK3576_GMAC_CLK_RMII_GATE;
> > > +
> > > +	offset_con =3D bsp_priv->id =3D=3D 1 ? RK3576_GRF_GMAC_CON1 :
> > > +					 RK3576_GRF_GMAC_CON0;
> >=20
> > nit: alignment of both looks like it could be nicer
>=20
> That's strange, the alignments looks good in vim and git diff. It also lo=
oks=20
> nice on the archive: https://lore.kernel.org/linux-rockchip/
> 20240808170113.82775-3-detlev.casanova@collabora.com/

ok, probably just some display artifact here :-)




