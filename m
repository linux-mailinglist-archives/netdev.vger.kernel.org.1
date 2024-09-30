Return-Path: <netdev+bounces-130290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D034989F35
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD39283953
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBF18A6D4;
	Mon, 30 Sep 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rJ+/s2ZZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AD189F55
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691296; cv=none; b=rM3QNCXb1zZg27vbVWfUNu0tFF89LAFs1+IsGohbtoFw7GXnkBWwhj3EAVmG21aHXmTL9H+6+avk9aeuin5nkFsykB3p1HGqaUAYxSXnmFB94662cZ/FNwmeRuVeJ3BiVN2Y2wJHLdFST6THpMBhYsQfvgcos0hiSgXc8BO/aoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691296; c=relaxed/simple;
	bh=uQX3p3gTWX8Hab2b8pic/KY4piqxMKyjairDi0YpJlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCKID5+iEobdFsjNrfQkXjQPU6Q57DQIBNSqh/+JHdNFq2SD2TBnRuxSRlSYDSOETrwMD3Zos+K5B1WKm009Ro7Y5d1pv0HPP2xJeoq9lt0Fz3Ha2M+dlaNGxpGaaPU2t0cI4CcCNHVIIgcka2vQIRes6N1+hQ9l8ahRI52GXZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rJ+/s2ZZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9OlRk2qJffviTG3xiJHPw655zAjPrxKfaoMhCDVoxhU=; b=rJ+/s2ZZ+r1qhJgR5sXdq8swui
	jsh1nMH1fR4V/oWf9FZXMwwI/Hk5nIBQyd3S1HfKYvC29P1K1iye7WHFjWYQVVMAEwD8R4YP2joJC
	AyP0nT9kdNN8pIzpO5LyUgufmVf9HADZ+gBuCTWQu0jMZeQfOqu511rej5iysuuHHt0b5ueYYx6hw
	pKvOhV3HWIGc7INL0rpdBLz61nVMLGXFJiSEVwwGQ+RbufWUgkJ0XAdLfbtlEdPdBwvBBK9LgLDhi
	QtYbKhUxGZYBcDE1uygEP/jJQ1R10aZEl3CMA37vcsPOGp0zPhS1UE5wBwL3uRo0DcvA3NpaEiuUe
	NDKjZSTw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44266)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1svDQ7-00041t-03;
	Mon, 30 Sep 2024 11:14:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1svDPz-0003uN-0e;
	Mon, 30 Sep 2024 11:14:15 +0100
Date: Mon, 30 Sep 2024 11:14:15 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 01/10] net: pcs: xpcs: move PCS reset to
 .pcs_pre_config()
Message-ID: <Zvp59w0kId/t8CZs@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
 <E1ssjcZ-005Nrf-QL@rmk-PC.armlinux.org.uk>
 <mykeabksgikgk6otbub2i3ksfettbozuhqy3gt5vyezmemvttg@cpjn5bcfiwei>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mykeabksgikgk6otbub2i3ksfettbozuhqy3gt5vyezmemvttg@cpjn5bcfiwei>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 30, 2024 at 01:16:57AM +0300, Serge Semin wrote:
> Hi Russell
> 
> On Mon, Sep 23, 2024 at 03:00:59PM GMT, Russell King (Oracle) wrote:
> > +static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
> > +{
> > +	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
> > +	const struct dw_xpcs_compat *compat;
> > +	int ret;
> > +
> > +	if (!xpcs->need_reset)
> > +		return;
> > +
> 
> > +	compat = xpcs_find_compat(xpcs->desc, interface);
> > +	if (!compat) {
> > +		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
> > +			phy_modes(interface));
> > +		return;
> > +	}
> 
> Please note, it's better to preserve the xpcs_find_compat() call even
> if the need_reset flag is false, since it makes sure that the
> PHY-interface is actually supported by the PCS.

Sorry, but I strongly disagree. xpcs_validate() will already have dealt
with that, so we can be sure at this point that the interface is always
valid. The NULL check is really only there because it'll stop the
"you've forgotten to check for NULL on this function that can return
NULL" brigade endlessly submitting patches to add something there -
just like xpcs_get_state() and xpcs_do_config().

> > +	bool need_reset;
> 
> If you still prefer the PCS-reset being done in the pre_config()
> function, then what about just directly checking the PMA id in there?
> 
> 	if (xpcs->info.pma == WX_TXGBE_XPCS_PMA_10G_ID)
> 		return 0;
> 
> 	return xpcs_soft_reset(xpcs);

I think you've missed what "need_reset" is doing as you seem to
think it's just to make it conditional on the PMA ID. That's only
part of the story.

In the existing code, the reset only happens _once_ when the create
happens, not every time the PCS is configured. I am preserving this
behaviour, because I do _NOT_ wish to incorporate multiple functional
changes into one patch - and certainly in a cleanup series keep the
number of functional changes to a minimum.

So, all in all, I don't see the need to change anything in my patch.

Thanks for the feedback anyway.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

