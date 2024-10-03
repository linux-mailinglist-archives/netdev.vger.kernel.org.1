Return-Path: <netdev+bounces-131657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3398F28B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B03B1C21591
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16A11A08AB;
	Thu,  3 Oct 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WSzScGzo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744CCDDA8
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969349; cv=none; b=tnHJZWmstP2D6Lqj5rxuUy24fajYflTTagRyZj65n/9TCtUFlUmtpOcAfY7qwk5QaXHnxCqr/+5jv2l+DKfzVfvXxH6+H3yskHvIwC/H1cAzhpqFSZ8rkLmkSab6ULVgRPZ8ZuVDLz1w63bYpmBodGD7TeZ3rVHRzetd4EGPmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969349; c=relaxed/simple;
	bh=B/xKtp1bT853/DmE04DCg7csyunDd6O58nuyLmGD6Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqoUQIBmM7NUgAd5zqudtwv5NJd+SoN57b06bYTXTGv1smhVppxX4Wmw05FTVfi10Hk0vWxsfmBCGX92CGkPcrQlzwgqLc0oHiCpvohLxfrdhd0nqLV2NJTkA8fQqh7C/EOXG4n5ONGGxFsksKm3EEiG4ijLJ+PTp6TOwDtNgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WSzScGzo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=foVV8719zdgze20If2zLW/8BAP6gMZcBocAV/7le+6g=; b=WSzScGzoq61HEUbeA2CP65kfRr
	UYXKyzhrZLdI9Y1tqV+oFKCvt7iViArCi3lEzmVBChPYudJZKO/qdEjq0oQrsZU2JfjqzL9EUNG2k
	cF4jX+HGy2Pxj0IrN9hOb4yltK3PMnEEtqYNCrgbIo0QAI9mssRroBn+Wz6oa+syM68fiCzbVn9F9
	PPMCX08QJYdl1wVAR+dozVFKiAPFM8AgI7wjmAdL0fVJMu8C3GsuZXFvUbMg5BYL6KTVCGfrnvJy4
	R3yDVWfl7m4gmI3gLDOZ60KW4HjOXhYulhzZ/bCddSrAvcrL4jBxHdMVjE8vtwVG29jc5JqsFkLYJ
	BKqhaSZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57472)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swNlE-0000be-1Q;
	Thu, 03 Oct 2024 16:29:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swNlC-0000DC-0O;
	Thu, 03 Oct 2024 16:28:58 +0100
Date: Thu, 3 Oct 2024 16:28:57 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: remove obsolete phylink dsa_switch
 operations
Message-ID: <Zv64OWFyXY5B0B-l@shell.armlinux.org.uk>
References: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
 <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
 <20241003145103.i23tx4mpjtg4e6df@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003145103.i23tx4mpjtg4e6df@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 03, 2024 at 05:51:03PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 03, 2024 at 12:52:17PM +0100, Russell King (Oracle) wrote:
> > No driver now uses the DSA switch phylink members, so we can now remove
> > the method pointers, but we need to leave empty shim functions to allow
> > those drivers that do not provide phylink MAC operations structure to
> > continue functioning.
> > 
> > Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> > index 668c729946ea..09d2f5d4b3dd 100644
> > --- a/net/dsa/dsa.c
> > +++ b/net/dsa/dsa.c
> > diff --git a/net/dsa/port.c b/net/dsa/port.c
> > index 25258b33e59e..f1e96706a701 100644
> > --- a/net/dsa/port.c
> > +++ b/net/dsa/port.c
> > @@ -1579,40 +1579,19 @@ static struct phylink_pcs *
> >  dsa_port_phylink_mac_select_pcs(struct phylink_config *config,
> >  				phy_interface_t interface)
> >  {
> > -	struct dsa_port *dp = dsa_phylink_to_port(config);
> > -	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
> > -	struct dsa_switch *ds = dp->ds;
> > -
> > -	if (ds->ops->phylink_mac_select_pcs)
> > -		pcs = ds->ops->phylink_mac_select_pcs(ds, dp->index, interface);
> > -
> > -	return pcs;
> > +	return ERR_PTR(-EOPNOTSUPP);
> >  }
> 
> dsa_port_phylink_mac_select_pcs() didn't have to stay, as phylink_mac_select_pcs()
> is entirely optional in phylink. Otherwise:

Yes, that's correct, but let's keep it to this for the moment.

There's more to do with mac_select_pcs(). When it was introdued, we
needed a way to distinguish whether the method was actually implemented
or whether the old phylink_set_pcs() function was being used. Those days
are long gone, so returning ERR_PTR(-EOPNOTSUPP) no longer makes much
sense.

DSA's core code returns this, as does mv88e6xxx when the chip doesn't
have any pcs_ops (I'm not sure now why I did the latter now.)

So, I'd like to (a) make mv88e6xxx_mac_select_pcs() return NULL, then
kill dsa_port_phylink_mac_select_pcs() and then eliminate:

        if (mac_ops->mac_select_pcs &&
            mac_ops->mac_select_pcs(config, PHY_INTERFACE_MODE_NA) !=
              ERR_PTR(-EOPNOTSUPP))
                using_mac_select_pcs = true;

replacing all other cases of pl->using_mac_select_pcs with a test
for pl->mac_ops->mac_select_pcs being non-NULL.

However, that's for later - I think for this patch, it makes sense
to keep returning the ERR_PTR() value because that's what it was
doing prior to this patch - we're then only removing the members
on the dsa_switch_ops and their callsite in this patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

