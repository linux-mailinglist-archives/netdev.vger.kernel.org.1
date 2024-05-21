Return-Path: <netdev+bounces-97384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB98CB2E8
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841F41F22D11
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5B763F1;
	Tue, 21 May 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y4t83oNf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA091FBB;
	Tue, 21 May 2024 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312515; cv=none; b=ZafRlC+XyBWi0+mPet7T1nUU0Cg4JUsIdxYAhRfAq5R/6IWkO7E/KwkOGVpb1+8X53CVkcXFCvswPeiAMj3SWMXYI/lshT5x7qo0fqyLems2PQIDIcgGxaWzYkrEbqbiPsFu9YZtfo1H8Ra10RrQ6fdlFGSMD6Kq1z0difVtYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312515; c=relaxed/simple;
	bh=DFM6lDa0lJTFJe7JNKM4Gci25VFXeCSN/ZQ0WqwfoFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEjg2H0FJfWxkcecfYJNSuXDXJ2Iecy2aKeGA+fEvzZ1dtUUYxjj38Ky6N7xX3t2y9zh3fDlq4Er507U2wMWTFoaoCWtfdW560U97ojD3XaWnpacq1l6gD2X8fDdxjbPKxf0GkU7JyUKJ4/P6WKzF6SHaTpLq4Vnw017Voi7eM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y4t83oNf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QhkM+fRteG8PMgK5KQbExBrib5V/iTCrBU/RE50L1EE=; b=y4
	t83oNfL/I9PNlWj48LTO/Cy3aJiuDgNkz5VvIiTfi/ZliR+Cl0IsBp7lCVG8AaZJgPN71kIdYt8wy
	z3mHCy+BvbAsPZYwmlB7QpI4+E1lMIBbha/jZnGMhP9uYpuFGQDNIq8qso8jedq4xenamXMB9GQcn
	z8aGp+3perQmk84=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9THj-00Fm7j-Ne; Tue, 21 May 2024 19:28:23 +0200
Date: Tue, 21 May 2024 19:28:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH net-next v3 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <8af5b5b0-84b0-4603-8190-9661038d3ea5@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
 <20240520113456.21675-6-SkyLake.Huang@mediatek.com>
 <1158a657-1b95-4d7f-9371-41eec5388441@lunn.ch>
 <ab5df65ebd52dfd54231b9b12657d47218df8f25.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab5df65ebd52dfd54231b9b12657d47218df8f25.camel@mediatek.com>

On Tue, May 21, 2024 at 08:17:32AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Mon, 2024-05-20 at 15:35 +0200, Andrew Lunn wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  > +static int mt798x_2p5ge_phy_config_init(struct phy_device
> > *phydev)
> > > +{
> > > +struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> > > +struct device *dev = &phydev->mdio.dev;
> > > +const struct firmware *fw;
> > > +struct pinctrl *pinctrl;
> > > +int ret, i;
> > > +u16 reg;
> > > +
> > > +if (!priv->fw_loaded) {
> > > +if (!priv->md32_en_cfg_base || !priv->pmb_addr) {
> > > +dev_err(dev, "MD32_EN_CFG base & PMB addresses aren't valid\n");
> > > +return -EINVAL;
> > > +}
> > 
> > ...
> > 
> > > +static int mt798x_2p5ge_phy_probe(struct phy_device *phydev)
> > > +{
> > > +struct mtk_i2p5ge_phy_priv *priv;
> > > +
> > > +priv = devm_kzalloc(&phydev->mdio.dev,
> > > +    sizeof(struct mtk_i2p5ge_phy_priv), GFP_KERNEL);
> > > +if (!priv)
> > > +return -ENOMEM;
> > > +
> > > +switch (phydev->drv->phy_id) {
> > > +case MTK_2P5GPHY_ID_MT7988:
> > > +priv->pmb_addr = ioremap(MT7988_2P5GE_PMB_BASE,
> > MT7988_2P5GE_PMB_LEN);
> > > +if (!priv->pmb_addr)
> > > +return -ENOMEM;
> > > +priv->md32_en_cfg_base = ioremap(MT7988_2P5GE_MD32_EN_CFG_BASE,
> > > + MT7988_2P5GE_MD32_EN_CFG_LEN);
> > > +if (!priv->md32_en_cfg_base)
> > > +return -ENOMEM;
> > > +
> > > +/* The original hardware only sets MDIO_DEVS_PMAPMD */
> > > +phydev->c45_ids.mmds_present |= (MDIO_DEVS_PCS | MDIO_DEVS_AN |
> > > + MDIO_DEVS_VEND1 | MDIO_DEVS_VEND2);
> > > +break;
> > > +default:
> > > +return -EINVAL;
> > > +}
> > 
> > How can priv->md32_en_cfg_base or priv->pmb_addr not be set in
> > mt798x_2p5ge_phy_config_init()
> > 
> > Andrew
> Use command "$ifconfig eth1 down" and then "$ifconfig eth1 up",
> mt798x_2p5ge_phy_config_init() will be called again and again. priv-
> >md32_en_cfg_base & priv->pmb_addr are released after first firmware
> loading. So just check these two values again for safety once priv-
> >fw_loaded is overrided unexpectedly.

So the code is unsymmetrical. The memory is mapped in
mt798x_2p5ge_phy_probe() but unmapped in
mt798x_2p5ge_phy_config_init(). It would be better style to unmap it
in mt798x_2p5ge_phy_remove(). Alternatively, just map it when
downloading firmware, and unmap it straight afterwards.

Also, we generally discourage defensive programming. It is much better
to actually understand the code and know something is not possible.

	Andrew

