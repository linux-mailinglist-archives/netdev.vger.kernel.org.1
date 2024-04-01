Return-Path: <netdev+bounces-83748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC83893B0E
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717D4281540
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974523BB35;
	Mon,  1 Apr 2024 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="j2ETJ/fw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311E1EB5B
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711975433; cv=none; b=iHuwHY42BxgPKBat9q9+OBuZRFfo8GYC/IDkRC+KWGBCiF1W234ba+pVYYB3pA+x9d3zrAJdhPhmz2YH7mXLmWVwGOwdXwIIEeiq2nnIMZ+nX5TmTIeQYmiPLNe9/wWlxpXOVqtop708EKC2TwH9hbzcGGoSYwd3v2MSMhMwEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711975433; c=relaxed/simple;
	bh=lF/lWwglK1/KsvSKYmtHHbwODwFVgxNyc1D4jejWxC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t13EKqDCWvsaaINKiH7L3y3qc7zoPIHWRm6YEBnRvkYhimkP8UCiR/Dht5TvhZE7fpbUIf/6+fgTkbe7QQF2MENHafSsivs3gwaJ577q+qFMTlnoL7SPkTKM/ixFNxIE59bjHjCcdmqWzhyCcwMvE1hUi3/fsoO8mpQL8vuQSlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j2ETJ/fw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nj0FkOauhO5ccBUmvkW0LdWM+/zskkW1WdyK2+ag1ZU=; b=j2ETJ/fwKrGo7H37MAHLTmvQfB
	UaBrIFYUlJibhuEvbEYAGiDjvGREBUiHrglfT8JMiM7KXo3Nh80QEGk74NsOA7xPvQYLy7bvrzrSw
	6aeZxjlublj79fr+1qIdqbE7gq3EZPA9jZtDqQRCVXj/erQ2rVVnT/0jV+cbnMDV/DcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrH0d-00Br6W-Oo; Mon, 01 Apr 2024 14:43:31 +0200
Date: Mon, 1 Apr 2024 14:43:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] dsa: mv88e6xxx: Create port/netdev LEDs
Message-ID: <0ccde4c3-c168-4bb3-9948-233a41449c35@lunn.ch>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
 <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-6-fc5beb9febc5@lunn.ch>
 <ZgmHgAhXQpaaKMNb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgmHgAhXQpaaKMNb@shell.armlinux.org.uk>

On Sun, Mar 31, 2024 at 04:55:44PM +0100, Russell King (Oracle) wrote:
> On Sat, Mar 30, 2024 at 01:32:03PM -0500, Andrew Lunn wrote:
> 
> > +static int mv88e6xxx_led_brightness_set(struct net_device *ndev,
> > +					u8 led, enum led_brightness value)
> > +{
> > +	struct dsa_switch *ds = dsa_user_to_ds(ndev);
> > +	struct mv88e6xxx_chip *chip = ds->priv;
> > +	int port = dsa_user_to_index(ndev);
> 
> This breaks the model that the DSA layer contains shims to translate
> stuff to a dsa_switch pointer and port index. That's not a complaint.
> I think it's the right way forward, because the shim later feels like
> it makes maintenance needlessly more complex.

It was something Vladimir requested after reviewing a patchset trying
to reuse parts of a DSA driver in a pure switchdev driver. He wanted
more generic building blocks which could be put together in different
ways. It does result in more boilerplate code in each callback, but
the helpers i added keep it down.

> I have been thinking whether to do the same for the various phylink
> functions - having DSA drivers provide the phylink_mac_ops themselves
> where they implement the phylink ops, and convert from the "config"
> to dsa_switch+port or whatever is suitable for them where necessary.

If it helps, do it. But i would suggest adding helpers to try to keep
the boilerplate down. That is mostly what the wrappers in the DSA core
do, centralise the boilerplate so we only have one copy.

    Andrew

