Return-Path: <netdev+bounces-134182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E049984D2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2502838DC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113711C244F;
	Thu, 10 Oct 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f1HAh1a+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7452A1C2426
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559316; cv=none; b=UUx9OxpWRIf6rc9k2nURw+17GKBQnCvzA7ozZusgtHI8YWFPpON1a0w4lffvq/m9CxvncxYGFheTOuhU8OnueH3o1MzC9EWh9FJvFB1fbugr55U5gou4IRbTmoTmrAYL4FI1KWxr2ctBFCxGvSZBcynwH/zHXueQinwnhZuZeMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559316; c=relaxed/simple;
	bh=IsJhWl5z3Fwrk8/Wuj9EVNVqymfW8XNXnTBnXXkZ2n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb453AcXIiFo+coXTFuEKps9rmy2owW/EEAdA5SGTAnU8cHppCYoJ6Exj0T0WSBB7P++BomJU0DBd6bu8NLjPA5UGFABkf/TeFo2wWiXVzQvar40nsoeT8g/kp8uKaWlP+BwfnKky43x6PYbZSwx7oaP/OkSk1oZhPBNLdUlIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f1HAh1a+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1i7Psxw/WOb7cOeUIIUZsk+qXYRaaQKBmvfbIjVXdcw=; b=f1HAh1a+bfd5VtKBTucadg7hDl
	ePw4MbOt6wV7+UrnPYijU1W4Z+XCnyJYpU5KSbvX7tMob1kfrl5mMG7p75E6tQdzinssofn4k1yUT
	1eMtogDeoST4WCD9AkFVj11iRWDawROVCHFIfQyTprVrsdzGZFbo6Xas+e9GUiGjhAa/NL+YGKy8l
	eWf/wKrXN5RILlotNhdxiXTpF+2J+5YM1m6XfIeAO0AdacwcHn0jUYQ+qHBm9UndFLHa1xph/IPST
	ioiq1B2RSsGKRh6LyGG0PwA2BB4/4lxO8PGqH3io+1rJ8Nuk5UWiaQs5RsgqVKaQRCQNYCsw1XDZa
	fsFNOxvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syrEo-0002CN-0T;
	Thu, 10 Oct 2024 12:21:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syrEl-0007Fx-0e;
	Thu, 10 Oct 2024 12:21:43 +0100
Date: Thu, 10 Oct 2024 12:21:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <Zwe4x0yzPUj6bLV1@shell.armlinux.org.uk>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009122938.qmrq6csapdghwry3@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 09, 2024 at 03:29:38PM +0300, Vladimir Oltean wrote:
> On Tue, Oct 08, 2024 at 03:41:44PM +0100, Russell King (Oracle) wrote:
> > With DSA's implementation of the mac_select_pcs() method removed, we
> > can now remove the detection of mac_select_pcs() implementation.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/phy/phylink.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 4309317de3d1..8f86599d3d78 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -79,7 +79,6 @@ struct phylink {
> >  	unsigned int pcs_state;
> >  
> >  	bool mac_link_dropped;
> > -	bool using_mac_select_pcs;
> >  
> >  	struct sfp_bus *sfp_bus;
> >  	bool sfp_may_have_phy;
> > @@ -661,12 +660,12 @@ static int phylink_validate_mac_and_pcs(struct phylink *pl,
> >  	int ret;
> >  
> >  	/* Get the PCS for this interface mode */
> > -	if (pl->using_mac_select_pcs) {
> > +	if (pl->mac_ops->mac_select_pcs) {
> >  		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
> >  		if (IS_ERR(pcs))
> >  			return PTR_ERR(pcs);
> >  	} else {
> > -		pcs = pl->pcs;
> > +		pcs = NULL;
> 
> The assignment from the "else" branch could have been folded into the
> variable initialization.
> 
> Also, maybe a word in the commit message would be good about why the
> "pcs = pl->pcs" line became "pcs = NULL". I get the impression that
> these are 2 logical changes in one patch. This second aspect I'm
> highlighting seems to be cleaning up the last remnants of phylink_set_pcs().
> Since all phylink users have been converted to mac_select_pcs(), there's
> no other possible value for "pl->pcs" than NULL if "using_mac_select_pcs"
> is true.

Hmm. Looking at this again, we're getting into quite a mess because of
one of your previous review comments from a number of years back.

You stated that you didn't see the need to support a transition from
having-a-PCS to having-no-PCS. I don't have a link to that discussion.
However, it is why we've ended up with phylink_major_config() having
the extra complexity here, effectively preventing mac_select_pcs()
from being able to remove a PCS that was previously added:

		pcs_changed = pcs && pl->pcs != pcs;

because if mac_select_pcs() returns NULL, it was decided that any
in-use PCS would not be removed. It seems (at least to me) to be a
silly decision now.

However, if mac_select_pcs() in phylink_major_config() returns NULL,
we don't do any validation of the PCS.

So this, today, before these patches, is already an inconsistent mess.

To fix this, I think:

	struct phylink_pcs *pcs = NULL;
...
        if (pl->mac_ops->mac_select_pcs) {
                pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
                if (IS_ERR(pcs))
                        return PTR_ERR(pcs);
	}

	if (!pcs)
		pcs = pl->pcs;

is needed to give consistent behaviour.

Alternatively, we could allow mac_select_pcs() to return NULL, which
would then allow the PCS to be removed.

Let me know if you've changed your mind on what behaviour we should
have, because this affects what I do to sort this out.

However, it is true that if mac_select_pcs() is NULL, since commit
a5081bad2eac ("net: phylink: remove phylink_set_pcs()") there is no
way pl->pcs can be non-NULL, since there is no other way for it to
be set.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

