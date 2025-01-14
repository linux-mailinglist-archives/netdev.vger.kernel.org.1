Return-Path: <netdev+bounces-158219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D549A1119E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AEF3A05D5
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBF51FC0F9;
	Tue, 14 Jan 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WI1twFnY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9251FBCA6
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884995; cv=none; b=MJowNQ2+js8mmM8/cz7CMeJF6cBALzDH/5SUXGraFU6P7343MhtyUtR8RKI3ofke7e20EbtciMw2N3rB81tHEVHA+YHmZu1kytG5SNJVgjTX8J85oqYX2QbBpTmzqC1gqjB6me4P7pVGS9sxjTFMemHXyMYT+P+8T5kF9XCvYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884995; c=relaxed/simple;
	bh=ju2iLLiVx8qvTOyh22ZwNv+4sazYhqOdMZe7pqLDqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4RV6tlDboeNYqHmQzF+JAmG/hotBR08XvPeJYNnGZavERmZ/f5E0xySwCF4EIcIbg6MqBy/mrKQEmK5WE7pYGS67XuZUF8H54016EaT3DnVWkpqxEIyHeECJURbiLF+Qt+Ow4qYviX0mqlPRq6v0b3qoZXQGMbRjuMjKS6EdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WI1twFnY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8/+p16atLmySpxduQsu62Wnw8bJeS7JrfosUlk3O+CA=; b=WI1twFnY6p36FUl9y0ukPubMsu
	YGK5qDbWdYT/D91y5+at4hWfw/rei5wIlmsYLys9tK3z9ed8a3pJImdulF7eU4HK2d48cHaW20ohg
	pwtdyDmArsz8GT0fjg+3Qt5fLhZk0siAD7D//0JOHV4VjJxThlxsykRaza6rTvKpdGGynUhQlJpNo
	SdVCdZ70RSlPT/DOGe8wYGnxpAEmuUK/+j5gSm6NDpZw5OetXV6l+oAUBzEI2mp+KmfPEIbj/1RxR
	S2ZMgJivpDA95lcve/H5DhKIcL29thhu8Sl2jnWh2qRnjmnU1LRFFI7Cd5LPdCh1VHDpc48N0gWzk
	BmtQbvSg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXn7r-0000Au-2N;
	Tue, 14 Jan 2025 20:02:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXn7n-0005MB-3C;
	Tue, 14 Jan 2025 20:02:56 +0000
Date: Tue, 14 Jan 2025 20:02:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC net-next 10/10] net: dsa: allow use of phylink
 managed EEE support
Message-ID: <Z4bC77mwoeypDAdH@shell.armlinux.org.uk>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
 <E1tXhVK-000n18-3C@rmk-PC.armlinux.org.uk>
 <20250114192656.l5xlipbe4fkirkq4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114192656.l5xlipbe4fkirkq4@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 14, 2025 at 09:26:56PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 14, 2025 at 02:02:50PM +0000, Russell King (Oracle) wrote:
> > In order to allow DSA drivers to use phylink managed EEE, changes are
> > necessary to the DSA .set_eee() and .get_eee() methods. Where drivers
> > make use of phylink managed EEE, these should just pass the method on
> > to their phylink implementation without calling the DSA specific
> > operations.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> 
> What is the reason for including this patch with this set, where
> it is of no use until at least one DSA driver provides the new API
> implementations?

No criticism against you, but I guess you didn't read the cover
message? I tend not to read cover messages. I've been wondering for a
while now whether anyone actually does and thus whether they are worth
the effort of writing anything beyond providing a message ID to tie a
series together and a diffstat for the series.

Here's the relevant bit:

"The remainder of the patches convert mvneta, lan743x and stmmac, add
support for mvneta, and add the basics that will be necessary into the
DSA code for DSA drivers to make use of this.

"I would like to get patches 1 through 9 into net-next before the
merge window, but we're running out of time for that."

So, it's included in this RFC series not because I'm intending it to
be merged, but so that people can see what DSA requires to make it
functional there, and provide review comments if they see fit - which
you have done, thanks.

I'm sure if I'd said "I have patches for DSA" you'd have responded
asking to see them!

Of course, I do have changes that will require this - mt753x - but
that patch is not quite ready because this series I've posted has seen
a few changes recently to remove stuff that was never settled (the
LPI timer questions, whether it should be validated, clamped, should
phylink provide a software timer if the LPI timer is out of range,
etc.) That's more proof that text in cover messages is utterly
useless!

> >  net/dsa/user.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index c74f2b2b92de..6912d2d57486 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -1233,16 +1233,23 @@ static int dsa_user_set_eee(struct net_device *dev, struct ethtool_keee *e)
> >  	if (!ds->ops->support_eee || !ds->ops->support_eee(ds, dp->index))
> >  		return -EOPNOTSUPP;
> >  
> > -	/* Port's PHY and MAC both need to be EEE capable */
> > -	if (!dev->phydev)
> > -		return -ENODEV;
> > -
> > -	if (!ds->ops->set_mac_eee)
> > -		return -EOPNOTSUPP;
> > +	/* If the port is using phylink managed EEE, then get_mac_eee is
> 
> set_mac_eee() is what is unnecessary.

Thanks for spotting that.

> > +	 * unnecessary.
> > +	 */
> > +	if (!ds->phylink_mac_ops ||
> > +	    !ds->phylink_mac_ops->mac_disable_tx_lpi ||
> > +	    !ds->phylink_mac_ops->mac_enable_tx_lpi) {
> 
> Does it make sense to export pl->mac_supports_eee_ops wrapped into a
> helper function and call that here? To avoid making DSA too tightly
> coupled with the phylink MAC operation names.

I could wrap the test up in an inline function which would avoid the
duplication. Thanks for the suggestion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

