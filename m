Return-Path: <netdev+bounces-240018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8307C6F499
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3DB103522A5
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0FA2749CE;
	Wed, 19 Nov 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ce3wimTW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB612652AC
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562026; cv=none; b=PhxjAnXbloQZYPZTnusLgwznRlbfHPvbJH6YkO3wj4Yw64nkMTz/dDPpb4nN4oPBEZ14rChsLjT2ip3gK6v7jotYbx5hC3lbJqvWmXWLycx8CAnECmcEnxk8JEg0PL3+JpNdEbjsPXJpZx5cTCfFYmO0xqV/b+od1U5VZzJ0PD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562026; c=relaxed/simple;
	bh=WQZqLBAfdkj5A4myWodlFfO9qORMCoxvewJog5oTCU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgLOqTEzC8rJfejvh2agv4LuT/2onGKu1VFqzkcdeOaTq4z0sIQxCRukk5F58LVLeguRn6mqDZRdWSVrmsEBfiC3/f7fCabR04CCU2QiB/2rnmoTP54LnUfEC/Gqanx6M/65iYIiX5lFTzLotRC26Ogxmx3vv49TF86zbUGE7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ce3wimTW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Ykq4lKormy/QMpaVqfFD3KVbMwllgtXhWjNCLRCzh4E=; b=ce
	3wimTWOBPLF1m4976As/gGLV90sJRebaNgYahccReUJVhsjwL+2ie/WrCvn6bOsTOFYNO+nUggtLw
	H8pnid5ek3Cbl/ISJ9dfAnXssv+KT+E940ZvOEFEgJPO4UpMt0HzoC+893oeI+sK1XscJlqniA2tz
	BQNn0qSZ1ZbR55s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLj2U-00EVIK-GU; Wed, 19 Nov 2025 15:20:06 +0100
Date: Wed, 19 Nov 2025 15:20:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Trager <lee@trager.us>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Susheela Doddagoudar <susheelavin@gmail.com>,
	netdev@vger.kernel.org, mkubecek@suse.cz,
	Hariprasad Kelam <hkelam@marvell.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <0d462aaa-7f41-4649-a665-de8a30a5b514@lunn.ch>
References: <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
 <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
 <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
 <CAKgT0UcVs9SwiGjmXQcLVX7pSRwoQ2ZaWorXOc7Tm_FFi80pJA@mail.gmail.com>
 <174e07b4-68cc-4fbc-8350-a429f3f4e40f@lunn.ch>
 <83128442-9e77-482a-ba8f-08883c3f3269@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83128442-9e77-482a-ba8f-08883c3f3269@trager.us>

> Strictly speaking settings don't have to be mapped to ethernet
> configurations, at least not in our IP. I could use a 3 lane setup
> alternating between NRZ and PAM4 each with different TX coefficients despite
> this not making any sense. This is where the argument comes in that PRBS
> testing and TX coefficients don't belong in ethtool. The argument for
> putting everything in phy is to create a generic interface that works for
> all phys, not just ethernet. That would give us something like

Please could you always make it clear which definition of phy you are
using. generic phy, or phylib phy. Here you appear to be meaning
generic phy. For TX coefficients, that mostly makes sense to me.

There is maybe one exception i can think of, the Aquantia phylib
phy. You have a setup of a SoC with a MAC, PCS, SERDES lane, and then
a discrete aquantia BaseT PHY which has its own PCS and the all the
usual analogue stuff to put the bitstream on twisted pairs. There are
undocumented registers in phylib PHY to configuring the eye etc. There
currently are no phylib phys with embedded generic phys. There is no
reason it cannot be done, just nobody has done it so far. And there is
no reason this is special to the aquantia PHY, other phylib phys using
a SERDES towards the MAC could also have such registers.

> I don't think there is much value in that which is why I like creating an
> ethernet specific version. It makes a cleaner user interface which require
> less technical details from the user. I like piggy backing off of ethtool -s
> since users are custom to NIC speed, not lanes and mode. That would give us
> something like
> 
> ethtool -s eth42 100000baseCR2  - Test fbnic in PAM4 with 2 lanes

Yep, that i like.

> 
> ethtool --set-phy-tunable eth42 tx-coefficent 0 1 8 55 0 - Sets the
> tx-coefficent for PAM4, this way users doesn't have to know the mapping
> between mode and speed

And this i don't. --set-phy-tunable is for a phylib PHY. Its for a
device which converts a bitstream to analogue signals on twisted
pair. fbnic does not have such a device. What you do have is a generic
phy, even if currently you don't model it in Linux with an actual
generic phy. But that is 'just code'. And the generic phy API does
have some networking specific APIs, so i don't see why you cannot add
another API for enumerating and setting TX coefficients.

The other problem with what you have above is you only reference the
netdev, and not which of the multiple generic phys that netdev might
have. Think of the SoC-PCS-generic_phy-lane-generic_phy-PCS-BaseT
system above. Both the SoC and the phylib phy can have coefficient
registers. You need to enumerate which you want to set.

For a long time we had this same problem with phylib, a netdev can
have multiple phylib phys, but the kAPI had no way to indicate which
of those phys you wanted to configure. We mostly have that solved now,
but we should learn from that experience, and not repeat the same
problem.

> ethtool --start-prbs eth42 prbs31 - Start the PRBS31 test

and this has the same problem, which prbs associated to the netdev do
you want to run prb31? There could be one in the SoC PCS, the BaseT
PCS pointing back towards the Soc, and maybe in the BaseT PHY pointing
towards the line?

So you need something like

ethtool --list-prbs eth42

to list all the PRBSes associated to the netdev, maybe also listing
its capabilities. And then something like:

ethtool --start-prbs eth42 --prbs 1 --mode prbs31

to make use of the 1st PRBS, rather than the 0th.

	Andrew

