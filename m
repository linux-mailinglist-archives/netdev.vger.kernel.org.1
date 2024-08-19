Return-Path: <netdev+bounces-119726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DE956C12
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B80A2865B3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C816D326;
	Mon, 19 Aug 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bNLyT1w3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6A16C6A4;
	Mon, 19 Aug 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074051; cv=none; b=UnkC6KlyZvcfhh+bsvAdZhUhXBMHykGruBPL6AJ58hgD/GSIWHQ2+6fjAw28/ZfjzTaVCr5ED04XDQaH2oL7mKVF23HH2pPIdDKgAATxNZrDm+NwMHQKuoH85bGhf8g6bpYnt15MDS5p3mT+7tQh6tCzkn8F/Z+qQJiUu+m5ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074051; c=relaxed/simple;
	bh=B0j9K7GExfGAYgBtrNjM7+7B0fWDAGcEaGcch0O+NvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raq+WC7emr8neFDp/sHx/bHytY8HMpP9cRVneUs/q0GnR0+JkjSUJrvLBZusnHC0/GLEzO+GLrDv0QWmAryCV64mg64knrFO8pSrdj+EpJ5+wDGdqjHTodI/3RB3UvOTSEZPtVdVvHlqEG/VnbdyS/+O2hbdfkb0aYxmXPEPt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bNLyT1w3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LWdTs2tc0joo/WW6zTQm3aElIk2DM2kN2a+neksw0uw=; b=bNLyT1w3Az6D+2sNOx6lY8pTfP
	MJjPmPbKd4+Mj6bm/OqYOWNKnt2UqCAYLXxwD+1foeEIARC1FDdVbySs7r97LMWWcc6eZZWBJoWaZ
	yFqu51bdUcSnSb7Gp8BPI3JLvByteoWm8nURRcstAkysKg5PA8cO4MUwjhBcOC/bqlbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sg2Pl-00575a-Eh; Mon, 19 Aug 2024 15:27:17 +0200
Date: Mon, 19 Aug 2024 15:27:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pieter <vtpieter@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>

On Mon, Aug 19, 2024 at 03:21:51PM +0200, Pieter wrote:
> Hi Andrew,
> 
> > > Previously I could not use DSA because of the macb driver limitation, now
> > > fixed (max_mtu increase, submitted here). Once I got that working, I notice
> > > that full DSA was not a compatible use case for my board because of
> > > requiring the conduit interface to behave as a regular ethernet interface.
> > > So it's really the unmanaged switch case, which I though I motivated well in
> > > the patch description here (PHY library, ethtool and switch WoL management).
> >
> > If its an unmanaged switch, you don't need DSA, or anything at all
> > other than MACB. Linux is just a plain host connected to a switch. It
> > is a little unusual that the switch is integrated into the same box,
> > rather than being a patch cable away, bit linux does not really see
> > this difference compared to any other unmanaged switch.
> 
> That's true in theory but not in practice because without DSA I can't use
> the ksz_spi.c driver which gives me access to the full register set. I need
> this for the KSZ8794 I'm using to:
> - apply the EEE link drop erratum from ksz8795.c
> - active port WoL which is connected through its PME_N pin
> - use iproute2 for PHY and connection debugging (link up/down,
>   packets statistics etc.)

Then it is not an unmanaged switch. You are managing it.

> If there's another way to accomplish the above without DSA, I'd be
> happy to learn about it.

Its go back to the beginning. Why cannot use you DSA, and use it as a
manage switch? None of your use-cases above are prevented by DSA.

	Andrew

