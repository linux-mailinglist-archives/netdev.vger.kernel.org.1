Return-Path: <netdev+bounces-131275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277598DFD5
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D9A287F95
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3D1D0DD1;
	Wed,  2 Oct 2024 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l6M/p1FD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB61D04A9;
	Wed,  2 Oct 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884396; cv=none; b=aIKzEQ2mFDvkiVJKexleO4bX3EEyS9oK2gh8ZraXRlXPygfoeMOH4bL4gQ/6HMoBWQ/sy0VVQVdJsDjIHA15yWP3LBS+5JrGY3ZOtIse/hDqg6XCrC/SWiJq5qsMp6JsZQlSt7gIG5z7chKr4M4Ip3A2ClapXTBHPu34e/P2tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884396; c=relaxed/simple;
	bh=GneNjFyA+rxAprS9HItyMAhmg49Z/BVqZDm+BgBOtTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJEm4hfgDuGfraaj9gjjaIRgwr6YcKpZ1Z303N3FrNEDG/3NcGSq4K0XKgJn4TxYCkE9uvYCzNB4DPX3n/AVzZKePA7k4ulUHTUj9mNbODxTvnhgeVUZtISggKRAbJlAqqtg7W1kurFornXxePPB89biYJRVsBriXgam0ErMkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l6M/p1FD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=42dCFtvLbpPDj6zUz654KCaWzorsTLfkaBbV+xZ6gLk=; b=l6
	M/p1FDzpq2s28NZSAabEaLRbzfZP4Ta9dIW1Edf4J4xAeS7ANB6d2xNTZqPq/df6ESNHGhnly5Q6T
	j6dQXZ1uuH1syuNFfc9R/fHw0AxJUcfW7SUbvRY8u9DVYI2/ZkJ2pFZSCfBvDLMwkQYHIsid/SVXi
	jnkVb6nAWzW2avU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw1f3-008sIm-Tn; Wed, 02 Oct 2024 17:53:09 +0200
Date: Wed, 2 Oct 2024 17:53:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "inguin@gmx.de" <inguin@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dmurphy@ti.com" <dmurphy@ti.com>
Subject: Re: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
Message-ID: <2ac17718-9bd8-4bc4-8c80-0afff99b1ddc@lunn.ch>
References: <20241001075733.10986-1-inguin@gmx.de>
 <c9baa43edbde4a6aab7ec32a25eec4dae7031443.camel@siemens.com>
 <9e970294-912a-4bc4-8841-3515f789d582@gmx.de>
 <c26909742e1f2bbe8f96699c1bbd54c2eada42ce.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c26909742e1f2bbe8f96699c1bbd54c2eada42ce.camel@siemens.com>

On Tue, Oct 01, 2024 at 01:45:11PM +0000, Sverdlin, Alexander wrote:
> Hi Ingo!
> 
> On Tue, 2024-10-01 at 15:31 +0200, Ingo van Lil wrote:
> > On 10/1/24 12:40, Sverdlin, Alexander wrote:
> > 
> > > > diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> > > > index d7aaefb5226b..9c5ac5d6a9fd 100644
> > > > --- a/drivers/net/phy/dp83869.c
> > > > +++ b/drivers/net/phy/dp83869.c
> > > > @@ -645,7 +645,7 @@ static int dp83869_configure_fiber(struct phy_device *phydev,
> > > >    		     phydev->supported);
> > > > 
> > > >    	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported);
> > > > -	linkmode_set_bit(ADVERTISED_FIBRE, phydev->advertising);
> > > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->advertising);
> > > 
> > > Are you sure this linkmode_set_bit() is required at all?
> > 
> > You're right, it's probably not required. I just tracked a weird bug
> > down to this clear mistake and wanted to change as little as possible.
> 
> As little as possible would be not to add yet another bit set.
> Obviously it has been working (if it was at all) without a proper write,
> but dispite the incorrect write.
> 
> > The logic of the function seems a bit odd to me: At the beginning,
> > advertising is ANDed with supported, and at the end it's ORed again.
> > Inside the function they are mostly manipulated together.
> > 
> > Couldn't that be replaced with a simple "phydev->advertising =
> > phydev->supported;" at the end?
> 
> Yes, the function looks strange.
> But as this is for -stable, maybe complete rework is undesired.
> IMO, just delete the bogus write.

+1 KISS for stable.

For net-next, as far as i can see, dp83869->mode is fixed at probe
time. As a lot of the code here should be moved into .get_features.

	Andrew

