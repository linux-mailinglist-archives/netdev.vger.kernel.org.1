Return-Path: <netdev+bounces-105032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121A90F767
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120361C21A16
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91467158A3F;
	Wed, 19 Jun 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a3qQ0mJw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BCA55;
	Wed, 19 Jun 2024 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827807; cv=none; b=mJz5t4YLA5TkR5KcQiQoTM8trCI4dJmL88XLrAG/rmo2FzPeLVhDOAkdQwgvwe/ZWLeKKSBUQdqNS9Xzja7QxOEWYNZCk4fFXtZ0BAMW0WCY5QzYWfHv90vJF/B769ernHNE4mctLQKj3RIVtNpNEj7LLmX0S1c3HYnyZqevr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827807; c=relaxed/simple;
	bh=FFT/3gsOcyW8H+uQZheRM+a/zeFp2syyPVUFiSBtNb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYwVDFTXquaB6IIkAa+oXyfI9olahlWbzTnxGJF+N/8JVSAmlQgYPHxiHbIbn4gSJb/KsQ8KWW8TCNkIVS2zY5IEUepjUEM7o3aR70rYSPo24oW5EbwV7q0d2sgsLgZTydRMMPtir4emO/U8jp3J9A/yQXK2qIhasxPPUyn1AbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a3qQ0mJw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+ZD1LO3y0XJHehNXPuKa1r2z4fZ2XE0qxEWBdt79yn4=; b=a3qQ0mJwO1Wqwk8QDyhbJtiHOe
	owhbk0AznrkgCE4qaOOQ4U8Zv3WRcvC36DRx2rQyNFdSobOI2jcMH3jNjieUVPU4FDl33hhgeH+xd
	Nfihwr5aL7rMQxzyxREdOwRYMmhnV5fShdvxx4oJSazTwHp1iBuQPgFCzSQLxFib+YDUmTNQTu+GO
	xalzu/ACNdxek6LCuHkEvIzx/gNAjw+jwrjfIVYoU0Rn7Su5CskXfADrt8B21cQnmWDCpn2lk2n2Y
	l8wnvBbKfoQmPxX3WZmj94MeLukRdhxaWS90ihIqXo/IYzrPmVtwaMKGC8AYIeYeilstoyMDikK08
	PNCaSDcQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56934)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sK1cs-0000q2-2z;
	Wed, 19 Jun 2024 21:09:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sK1cs-00070q-HU; Wed, 19 Jun 2024 21:09:50 +0100
Date: Wed, 19 Jun 2024 21:09:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
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
Subject: Re: [PATCH net-next v7 5/5] net: phy: add driver for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <ZnM7DkKhMABNgjEi@shell.armlinux.org.uk>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
 <20240613104023.13044-6-SkyLake.Huang@mediatek.com>
 <ZnKgYSi81+JdAdhC@shell.armlinux.org.uk>
 <ac5cfcdeefb350af4467fe163b8a93b7873d3889.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac5cfcdeefb350af4467fe163b8a93b7873d3889.camel@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jun 19, 2024 at 11:44:32AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Wed, 2024-06-19 at 10:09 +0100, Russell King (Oracle) wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Thu, Jun 13, 2024 at 06:40:23PM +0800, Sky Huang wrote:
> > > +static struct phy_driver mtk_gephy_driver[] = {
> > > +{
> > > +PHY_ID_MATCH_MODEL(MTK_2P5GPHY_ID_MT7988),
> > > +.name= "MediaTek MT7988 2.5GbE PHY",
> > > +.probe= mt798x_2p5ge_phy_probe,
> > > +.config_init= mt798x_2p5ge_phy_config_init,
> > > +.config_aneg    = mt798x_2p5ge_phy_config_aneg,
> > > +.get_features= mt798x_2p5ge_phy_get_features,
> > > +.read_status= mt798x_2p5ge_phy_read_status,
> > > +.get_rate_matching= mt798x_2p5ge_phy_get_rate_matching,
> > > +.suspend= genphy_suspend,
> > > +.resume= genphy_resume,
> > > +.read_page= mtk_phy_read_page,
> > > +.write_page= mtk_phy_write_page,
> > > +.led_blink_set= mt798x_2p5ge_phy_led_blink_set,
> > > +.led_brightness_set = mt798x_2p5ge_phy_led_brightness_set,
> > > +.led_hw_is_supported = mt798x_2p5ge_phy_led_hw_is_supported,
> > > +.led_hw_control_get = mt798x_2p5ge_phy_led_hw_control_get,
> > > +.led_hw_control_set = mt798x_2p5ge_phy_led_hw_control_set,
> > 
> > I don't see the point of trying to align some of these method
> > declarators but not others. Consistency is important.
> > 
> Sorry I don't get your point on this. What do you mean by "trying to
> align some of these method declarators but not others"? Do you mean
> "mt798x_2p5ge_phy" prefix?

Some of the method initialisers are:

	.foo<tab>= method_foo,
	.bar<tab>= method_bar,
	...

while other are:

	.longlongname<space>= methodlonglongname,

So what this causes is:

	.foo	= method_foo,
	.bar	= method_bar,
	.longlongbaz = methodlonglongbaz,

which looks messy - why use tabs for the short ones and a space for
the others. Why not be consistent, e.g.:

	.foo = method_foo,
	.bar = method_bar,
	.longlongbaz = methodlonglongbaz,

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

