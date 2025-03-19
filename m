Return-Path: <netdev+bounces-176209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88DA695BC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BE0167B9F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC7C1EB5EE;
	Wed, 19 Mar 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xn/CF/o8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D71E766E;
	Wed, 19 Mar 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403789; cv=none; b=FTVKQxBYzHwpc5Tg1sCIWj0djXHp0CqsOdzbcON6S5WzKM4wfOcfXEwpXp5t0SUhBQGMD2qz1DkPgwF9OdMuxzC+nV3iTByMX/NdoQEEZT/91KCcnezlZsHp3bcCLhwDrbMyYISRJCs8mpYdPLKy0VBKTojZHOE1J5FegbXqPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403789; c=relaxed/simple;
	bh=RjiLkxQ0OGv2flu0QlyENWi4GfiPSEtYFg57wfQAooU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UExYELWQikCK7BogC04fUSh6BtJ4R82ABcmjIZlJoiFelDz4Qzya64R+Y5UHRErfm+7TkyPx4WNYd9MUzjhHCEs5CUx6gDFXGTtzpLng2SlAxVcewWFf5Irs5pAWX/2sDTsTP2hTum0YlPujiLjgyP4YXq82SRtyY3COf/cd//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xn/CF/o8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8x4sN1+pxH3VPtcO23y1IlCR7ToPAzMh3KZmhBBkH7I=; b=xn/CF/o8cvQ7Mfv+JRBHIvKycY
	P9Y6i8U+UVehi8gSK276TaKEjrczy+l0gcpVZcps8bOxhClwoMbbRQi6T5FotPmuCl87QK8s3AzhW
	aWIkwACgZrsDDV+O806BGOGUgizpHXYFn5udLvlrNIw9FbUs3jlutwko3Uz4dFF12T+x+BthyD3zi
	RIqLY6vWzZ0RLKrSD9szSmjz2t31o4tnyuPDwqjOq+ba/Vr6R5gcYPx/N1WOT+X0GT5WzYfjJLym7
	EEg+DMYQT2R2LATo3p/ivdHMdBmcoLo8Lmq05PvPZWiR7EotAV1eBcpPKduAK/4v0HNU6TWd4tdC1
	fw2PX+qg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuwog-0006hd-2z;
	Wed, 19 Mar 2025 17:02:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuwod-0005m4-0N;
	Wed, 19 Mar 2025 17:02:51 +0000
Date: Wed, 19 Mar 2025 17:02:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
Message-ID: <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
 <67daee6c.050a0220.31556f.dd73@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67daee6c.050a0220.31556f.dd73@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 05:18:50PM +0100, Christian Marangi wrote:
> > >  	linkmode_fill(pl->supported);
> > >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> > > -	phylink_validate(pl, pl->supported, &pl->link_config);
> > > +	ret = phylink_validate(pl, pl->supported, &pl->link_config);
> > > +	/* The PCS might not available at the time phylink_create
> > > +	 * is called. Check this and communicate to the MAC driver
> > > +	 * that probe should be retried later.
> > > +	 *
> > > +	 * Notice that this can only happen in probe stage and PCS
> > > +	 * is expected to be avaialble in phylink_major_config.
> > > +	 */
> > > +	if (ret == -EPROBE_DEFER) {
> > > +		kfree(pl);
> > > +		return ERR_PTR(ret);
> > > +	}
> > 
> > This does not solve the problem - what if the interface mode is
> > currently not one that requires a PCS that may not yet be probed?
> 
> Mhhh but what are the actual real world scenario for this? If a MAC
> needs a dedicated PCS to handle multiple mode then it will probably
> follow this new implementation and register as a provider.
> 
> An option to handle your corner case might be an OP that wait for each
> supported interface by the MAC and make sure there is a possible PCS for
> it. And Ideally place it in the codeflow of validate_pcs ?

I think you've fallen in to the trap of the stupid drivers that
implement mac_select_pcs() as:

static struct phylink_pcs *foo_mac_select_pcs(struct phylink_config *config,
					      phy_interface_t interface)
{
	struct foo_private *priv = phylink_to_foo(config);

	return priv->pcs;
}

but what drivers can (and should) be doing is looking at the interface
argument, and working out which interface to return.

Phylink is not designed to be single interface mode, single PCS driver
despite what many MAC drivers do. Checking the phylink_validate()
return code doesn't mean that all PCS exist for the MAC.

> > I don't like the idea that mac_select_pcs() might be doing a complex
> > lookup - that could make scanning the interface modes (as
> > phylink_validate_mask() does) quite slow and unreliable, and phylink
> > currently assumes that a PCS that is validated as present will remain
> > present.
> 
> The assumption "will remain present" is already very fragile with the
> current PCS so I feel this should be changed or improved. Honestly every
> PCS currently implemented can be removed and phylink will stay in an
> undefined state.

The fragility is because of the way networking works - there's nothing
phylink can do about this.

I take issue with "every PCS currently implemented" because it's
actually not a correct statement.

XPCS as used by stmmac does not fall into this.
The PCS used by mvneta and mvpp2 do not fall into this.
The PCS used by the Marvell DSA driver do not fall into this.

It's only relatively recently with pcs-lynx and others that people have
wanted them to be separate driver-model devices that this problem has
occurred, and I've been pushing back on it saying we need to find a
proper solution to it. I really haven't liked that we've merged drivers
that cause this fragility without addressing that fragility.

I've got to the point where I'm now saying no to new drivers that fail
to address this, so we're at a crunch time when it needs to be
addressed.

We need to think about how to get around this fragility. The need to
pre-validate the link modes comes from the netdev ethtool user
interface itself - the need to tell userspace what link modes can be
supported _before_ they get used. This API hasn't been designed with
the idea that parts of a netdev might vanish at any particular time.

> > If it goes away by the time phylink_major_config() is called, then we
> > leave the phylink state no longer reflecting how the hardware is
> > programmed, but we still continue to call mac_link_up() - which should
> > probably be fixed.
> 
> Again, the idea to prevent these kind of chicken-egg problem is to
> enforce correct removal on the PCS driver side.
> 
> > Given that netdev is severely backlogged, I'm not inclined to add to
> > the netdev maintainers workloads by trying to fix this until after
> > the merge window - it looks like they're at least one week behind.
> > Consequently, I'm expecting that most patches that have been
> > submitted during this week will be dropped from patchwork, which
> > means submitting patches this week is likely not useful.
> 
> Ok I will send next revision as RFC to not increase the "load" but IMHO
> it's worth to discuss this... I really feel we need to fix the PCS
> situation ASAP or more driver will come. (there are already 3 in queue
> as stressed in the cover letter)

Yes, we do need to fix it, but we need to recognise _all_ the issues
it creates by doing this, and how we handle it properly.

Right now, it's up to the MAC driver to get all the PCS it needs
during its probe function, and *not* in the mac_select_pcs() method
which has no way to propagate an error to anywhere sensible that
could handle an EPROBE_DEFER response.

My thoughts are that if a PCS goes away after a MAC driver has "got"
it, then:

1. we need to recognise that those PHY interfaces and/or link modes
   are no longer available.
2. if the PCS was in-use, then the link needs to be taken down at
   minimum and the .pcs_disable() method needs to be called to
   release any resources that .pcs_enable() enabled (e.g. irq masks,
   power enables, etc.)
3. the MAC driver needs to be notified that the PCS pointer it
   stashed is no longer valid, so it doesn't return it for
   mac_select_pcs().

There's probably a bunch more that needs to happen, and maybe need
to consider how to deal with "pcs came back".. but I haven't thought
that through yet.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

