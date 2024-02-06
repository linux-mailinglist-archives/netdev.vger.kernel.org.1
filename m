Return-Path: <netdev+bounces-69471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6984B61B
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152B01F269CB
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFE6130AE8;
	Tue,  6 Feb 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1naGhjY7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E4130AE1
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225188; cv=none; b=lQtpJJv95LS2a0tlt4EBEP8StyOF5D7Uqe3p9T5YRPQQYSXUngkcg47aBKo4nCZQdytCSbLz1umirUfOCF+3avEGb/QC3AuDt8yI4h/NImlO+ZTnjh1UnKOVr+UsfiYUIcsw8bSTyQRTV3VRCex5r6m1uC7rh5xmNyZvsxNneFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225188; c=relaxed/simple;
	bh=eXe5JRQueNPT9+iJyw1ObJLo2AFMANd1xXnpd+0FQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faurDUJHAOSKDlqS6EwwWB/gLxjmmdnVlLrFWO8/6PMHLhTFIwwyrxSmU+Ifa+GRh/f0+6jGVA0va8Bj8UAC1F4c1+UznPpVm2OD5THuVH5XC6o4vi2PRv+KgmAQybO0HfLlqOSHvt/EOWz+GjkDc2uCF8quHMGpeFw9sWhUVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1naGhjY7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UjKogbJoVYwz4/4zIRPiHZA8DeUtMRsDWvm2PZop3Tc=; b=1naGhjY7kYT8LNxUUIUOowYWeX
	eKwBs27naUc6/NxZ6U/hWTiIEXpVXwM6TFkHBBzOETzr0T2kl8nAOdru3pAOKyabsFXeL7livY0kf
	OD3F5iyMvCtxKORhmUACtDY0BoSx242QEo+yw8OiIHoVlXgbhR9X5Nn02hPMtAyuE5vaTuJRcWVon
	CAjx21TdK+VHLsaK7sfo1PVuJ+xHQtc6AXlDN23pRm1ObkEfVef33aY3BZcB9ht4M6C9coPYiaCFG
	AF75hBHggI3Ug/weORRMZpw+EMmfo35N0wmIodL9XBj4A661QS1p3FcnpNa/8Agc8SSU/Op6FcAPp
	2qslTbKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39738)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rXLFh-00021Y-0h;
	Tue, 06 Feb 2024 13:12:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rXLFZ-0003f6-I9; Tue, 06 Feb 2024 13:12:33 +0000
Date: Tue, 6 Feb 2024 13:12:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next v2 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Message-ID: <ZcIwQcn3qlk0UjS4@shell.armlinux.org.uk>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
 <20240206112024.3jxtcru3dupeirnj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206112024.3jxtcru3dupeirnj@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 06, 2024 at 01:20:24PM +0200, Vladimir Oltean wrote:
> On Sun, Feb 04, 2024 at 12:13:28PM +0000, Russell King (Oracle) wrote:
> > b53_get_mac_eee() sets both eee_enabled and eee_active, and then
> > returns zero.
> > 
> > dsa_slave_get_eee(), which calls this function, will then continue to
> > call phylink_ethtool_get_eee(), which will return -EOPNOTSUPP if there
> > is no PHY present, otherwise calling phy_ethtool_get_eee() which in
> > turn will call genphy_c45_ethtool_get_eee().
> 
> Nitpick: If you need to resend, the function name changed to
> dsa_user_get_eee().

Thanks.

> > @@ -2227,16 +2227,10 @@ EXPORT_SYMBOL(b53_eee_init);
> >  int b53_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_keee *e)
> >  {
> >  	struct b53_device *dev = ds->priv;
> > -	struct ethtool_keee *p = &dev->ports[port].eee;
> > -	u16 reg;
> >  
> >  	if (is5325(dev) || is5365(dev))
> >  		return -EOPNOTSUPP;
> >  
> > -	b53_read16(dev, B53_EEE_PAGE, B53_EEE_LPI_INDICATE, &reg);
> > -	e->eee_enabled = p->eee_enabled;
> > -	e->eee_active = !!(reg & BIT(port));
> > -
> 
> I know next to nothing about EEE and especially the implementation on
> Broadcom switches. But is the information brought by B53_EEE_LPI_INDICATE
> completely redundant? Is it actually in the system's best interest to
> ignore it?

That's a review comment that should have been made when the original
change to phylib was done, because it's already ignored in kernels
today since the commit changing phylib that I've referenced in this
series - since e->eee_enabled and e->eee_active will be overwritten by
phylib.

If we need B53_EEE_LPI_INDICATE to do something, then we need to have
a discussion about it, and decide how that fits in with the EEE
interface, and how to work around phylib's implementation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

