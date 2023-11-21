Return-Path: <netdev+bounces-49684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DB7F3106
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B1F283785
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B055C22;
	Tue, 21 Nov 2023 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h54+mbZF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B81A3;
	Tue, 21 Nov 2023 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QKGUm3YOEgFjR/qZttfUWApAFjwkLqqdBvdeGQxH6vg=; b=h54+mbZFXArzqshetgeGPPBTIF
	o5gpQfR4+aIlRkUd1ZHanwKfUHyipyyh7QdK/sSDK2hoUIeSx9i3EN0OxBG5fIhnYwhcLa5lGE5zw
	T2tSAFDwADYzcG6h1b1F718eG0L7CUgX2FTS3dNrhpgx90M0fCqfknvu5JI+EBbaYzSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r5RqR-000lXq-O1; Tue, 21 Nov 2023 15:35:19 +0100
Date: Tue, 21 Nov 2023 15:35:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 03/10] net: phy: add helpers to handle
 sfp phy connect/disconnect
Message-ID: <cd66774b-701a-43c8-9677-d3d7fd13b059@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-4-maxime.chevallier@bootlin.com>
 <ac7d9aa6-e403-482b-a12a-d5821787dd4c@lunn.ch>
 <ZVyBgNcFrSubz2jn@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVyBgNcFrSubz2jn@shell.armlinux.org.uk>

On Tue, Nov 21, 2023 at 10:08:00AM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 21, 2023 at 01:57:24AM +0100, Andrew Lunn wrote:
> > > +/**
> > > + * phy_sfp_connect_phy - Connect the SFP module's PHY to the upstream PHY
> > > + * @upstream: pointer to the upstream phy device
> > > + * @phy: pointer to the SFP module's phy device
> > > + *
> > > + * This helper allows keeping track of PHY devices on the link. It adds the
> > > + * SFP module's phy to the phy namespace of the upstream phy
> > > + */
> > > +int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
> > > +{
> > > +	struct phy_device *phydev = upstream;
> > 
> > Will this function only ever be called from a PHY driver? If so, we
> > know upstream is PHY. So we can avoid using void * and make it a
> > struct phy_device *. 
> 
> No. This function is hooked into the .connect_phy method of
> sfp_upstream_ops, and the SFP bus layer has no idea what the
> "upstream" is. In this case, it's a PHY. In the case of phylink,
> it's the phylink struct. So no, "struct phy_device *" here will
> cause build errors.

O.K, thanks for checking this. It would of been nice to have some
compile time checking what is passed is what we expect in terms of
type, but C does not allow that in this case.

	 Andrew

