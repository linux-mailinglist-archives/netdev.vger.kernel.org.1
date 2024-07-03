Return-Path: <netdev+bounces-109037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B94926974
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68719B23863
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42A185095;
	Wed,  3 Jul 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4/r5DBu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9D136660;
	Wed,  3 Jul 2024 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037939; cv=none; b=d4AUi5xQgJQV7QgY6EbB9/3b8gylGc4UhIe8/TOTrEG6A82Qc0iiU0+AvFCSCDD648XDPezhGyPMkX24DIO5oNKgK/WOSP7eqUrPuxZEmkHLH2e1F0lRO/y6nne3mczXTwA+9GQDt982UiKl32gTBGilkhBp+yKOxfcUP7lne5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037939; c=relaxed/simple;
	bh=NmYwylI9uTS15vLUegAQNWv7+xerEXTc6gEmecROmWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJzu/OvW8FsUR/0ubL5SvTNVhJqxUF8RfndbayUS+T/EHPFeIn5JlXkwPuHZ61tXBpdZsspTsQp8ccVn/uXdF1jkHKr8tF2zDD1SsTdOQdMUn/mZEudZaGXibdt8Qedo/8qd8w//wQ+Funrpx9I36/dhagnc9tsu0tyIchPrVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4/r5DBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D44C2BD10;
	Wed,  3 Jul 2024 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720037938;
	bh=NmYwylI9uTS15vLUegAQNWv7+xerEXTc6gEmecROmWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4/r5DBuudtOWa6WnckEwJ48PEJOPiZgE8udE1gQgCFivvL5Ae6CS/INNuKk3a7kP
	 u/1Y9+DraoB1FS/2XVFe8m6KVg5P3OHl4eqMh67cppHHVhecEGlc2DHZxsD82nxmt3
	 MjXNLuNK8B6p0ujksS0DR7gOrlcIazo+MR5FGILqPP54TuJI4DkhzaPqG47mL11clS
	 1mBvWQOkYbijMfpDKMTxH8h+s2kceCdwPxApx0QNZgCPUfNwhfw0rnaccA/R9588+T
	 xsEOhDfKH709KzaGS8aXKsmoOXf3gOFS5UTHS+MO+4JqPWGHgWnzwD9RzOTH2OI8x9
	 AxkVGtBg+18gQ==
Date: Wed, 3 Jul 2024 21:18:51 +0100
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	mwojtas@chromium.org, Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next v14 12/13] net: ethtool: strset: Allow querying
 phy stats by index
Message-ID: <20240703201851.GT598357@kernel.org>
References: <20240701131801.1227740-1-maxime.chevallier@bootlin.com>
 <20240701131801.1227740-13-maxime.chevallier@bootlin.com>
 <20240702105411.GF598357@kernel.org>
 <20240703085515.25dab47c@fedora-2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703085515.25dab47c@fedora-2.home>

On Wed, Jul 03, 2024 at 08:55:15AM +0200, Maxime Chevallier wrote:
> Hello Simon,
> 
> On Tue, 2 Jul 2024 11:54:11 +0100
> Simon Horman <horms@kernel.org> wrote:
> 
> > On Mon, Jul 01, 2024 at 03:17:58PM +0200, Maxime Chevallier wrote:
> > > The ETH_SS_PHY_STATS command gets PHY statistics. Use the phydev pointer
> > > from the ethnl request to allow query phy stats from each PHY on the
> > > link.
> > > 
> > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > ---
> > >  net/ethtool/strset.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c  
> > 
> > ...
> > 
> > > @@ -279,6 +280,8 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
> > >  	const struct strset_req_info *req_info = STRSET_REQINFO(req_base);
> > >  	struct strset_reply_data *data = STRSET_REPDATA(reply_base);
> > >  	struct net_device *dev = reply_base->dev;
> > > +	struct nlattr **tb = info->attrs;  
> > 
> > Hi Maxime,
> > 
> > Elsewhere in this function it is assumed that info may be NULL.
> > But here it is dereferenced unconditionally.
> 
> Hmm in almst all netlink commands we do dereference the genl_info *info
> pointer without checks.
> 
> I've looked into net/netlink/genetlink.c to backtrack call-sites and it
> looks to be that indeed info can't be NULL (either populated from
> genl_start() or genl_family_rcv_msg_doit(). Maybe Jakub can confirm
> this ?
> 
> If what I say above is correct, I can include a small patch to remove
> the un-necessary check that makes smatch think the genl_info pointer can
> be NULL.

Thanks for following up.
Assuming that is true (I did not check yet) then I agree.
And I don't think such a change needs to block this patchset.

