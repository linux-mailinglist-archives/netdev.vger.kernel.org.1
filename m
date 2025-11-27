Return-Path: <netdev+bounces-242381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295EC8FF4D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617143AB3F3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9E53019C1;
	Thu, 27 Nov 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NX2/Trzf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2A3FBA7;
	Thu, 27 Nov 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270001; cv=none; b=J2/2aB+8D8xnse+wIbEs8LQBw2nSvtx2sfud8F3uqVwvnFgVLkcjw6rbRHK/aBE+mx30NTa0BEVYt914KjpXHpd2rXPt1urCOlrQjTW8NIuej6lu2vHDonof5tL+eRsZqpH21dVPftzQncUJ9z1ah+aIjSobuVZrdTWtk41G6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270001; c=relaxed/simple;
	bh=I95WHPeK2ifox30pdTI1r4pszrLNx9e9gGpCK2DSQOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEa/7PdjbnHX8sno0KAYRfpAmxZ022b4uwGkBCYHA5fd7LHaWfxcugMk24WwX7UR+D+RLwgFvo1pcSsEivPBaxSp8s2u/l45RRLsuX0xazi6+Xp3A2AAXTIOBVw9YKmrU5u2DR4sCjjzio2rUJU27keNnfLcrC6js3cTEYimguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NX2/Trzf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jVBrTNsb3oGgT2g9a759j8X7ZwuC1ezE4QvNFD3ohCM=; b=NX2/TrzfDOYqFnNE1TcCaRFFZb
	iD670gtuJyyXo9JNjblOIAZpL3HvvPGAtrNdHeC/paNhJ6J+drJCyl4zbailLxCo6zTIxaM8xeTu7
	CwiY0Hlwn5we4sMkaIedDumOE8qJ8ErvQMb75KNoxrTEzXpsh9gLPVulHSmR4L6zUE3M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOhDc-00FI1E-7r; Thu, 27 Nov 2025 19:59:52 +0100
Date: Thu, 27 Nov 2025 19:59:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Ian MacDonald <ian@netstatz.com>, Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, 1121032@bugs.debian.org
Subject: Re: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad
 bonding
Message-ID: <f3c5586c-3d48-4748-babd-5e2a4753a03e@lunn.ch>
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
 <20251121060825.GR2912318@black.igk.intel.com>
 <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
 <CAFJzfF9UxBkvDkuSOG2AVd_mr3mkJ9yMa3D0s6rFvFdiMDKvPA@mail.gmail.com>
 <20251127053336.GI323117@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127053336.GI323117@black.igk.intel.com>

> I see. Yeah for speed we need to do something more than use the hard-coded
> values because it varies depending on whether we have lane bonding (not the
> same bonding you are doing) enabled and also how the link trained.

FYI: In theory, you don't need to keep to the speeds defined in the
ethtool header:

https://elixir.bootlin.com/linux/v6.17.9/source/include/uapi/linux/ethtool.h#L2177

However, ethtool might report a warning it does not know how to
convert to a nice looking number. So if you only have a small number
of possible speeds, please consider extending the list in ethtool, and
phy_speed_to_str().

> > +{
> > + /* ThunderboltIP is a software-only full-duplex network tunnel.
> > + * We report fixed link settings to satisfy bonding (802.3ad)
> > + * requirements for LACP port key calculation. Speed is set to
> > + * 10Gbps as a conservative baseline.
> > + */
> > + ethtool_link_ksettings_zero_link_mode(cmd, supported);
> > + ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
> > +
> > + ethtool_link_ksettings_zero_link_mode(cmd, advertising);
> > + ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);

Are link modes needed by bonding? You technically don't have a baseT
link, its not four twisted pairs, RJ45 connectors etc. Also, since you
set autoneg to disabled, you are not advertising anything.

If the bond drive does not care, i would leave supported and
advertising empty.

	Andrew

