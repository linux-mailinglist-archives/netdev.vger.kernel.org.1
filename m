Return-Path: <netdev+bounces-197655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5F9AD985A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF7D3BB5E3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAC28D8C4;
	Fri, 13 Jun 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tvmUy9Z6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD528D8D5
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854655; cv=none; b=QLUWQ4nhVFuDLXsf9hDcZIo+tu32QsdWY3QRQ8S1Qdbx02NkQlTbjQYovor1xl0okoq0Xxs1ijtxkYGysXDOTJ25z7SWY4NhfkoEHWzTnTesKubwAQRiw5WTgVFmo4O8wBPjXWr0mNqX1qNWnwTzev9Fn2kvGg15Hxeffg/XB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854655; c=relaxed/simple;
	bh=uvNACmiNW7f7+Bl1769+VYsKemVjFIk5SOSplngXoUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSYhwRcGvsDKC2IXkItzdD2BZ6zxPFVxdZKYx6UmZOQZpT4Uw0jBnO8a1H1OoMIqdLTckEIi3UaOlRUyuaG97kyfha4lRaVufzRhjg6nHrfs9XXhhO5VXMYdefFNNIpot5J8rnjvXSRoSRdlJ+PED4WWCNylwqPcGpDSER5+kXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tvmUy9Z6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0gCXuYT8pHNTAL0RzTO23h/sxUeauxHEj6VCUoV4Ndo=; b=tvmUy9Z6YuB6p3pZZKA0diP2Uq
	KlyG7zPw+OmxsT2I1m9+YA46GZuCH5uOY84afPaveu2RMOSFJUy5CWKBZKw+wli9byzFe9+Lax3KT
	j3SMemt/Akvqu76Mm2Nfy6C/fmyq8Qytzcl46sQlDhdNnFsGL8iOE90k3MiOOm3uBNTT4aa9nmiA/
	nO8EY9R1de+KGHbjPXh2IKklbEmohJ+cmiaJS0klELrVEFTiBNBBN6gEYhAzvOHDEDWovL8uKP+I9
	/lZsBcnWtgobo/1MPVHJj9GrtvZn8F4jqt/sJx84TJvRCczkJxKXvLnKL00LeHdKYieSpLjoIKtmg
	zZCkS6Yg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uQD7x-0001Uq-1v;
	Fri, 13 Jun 2025 23:44:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uQD7u-0002B6-1t;
	Fri, 13 Jun 2025 23:43:58 +0100
Date: Fri, 13 Jun 2025 23:43:58 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Leon Romanovsky <leon@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
 <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613160024.GC436744@unreal>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> Excellent, like you said, no one needs this code except fbnic, which is
> exactly as was agreed - no core in/out API changes special for fbnic.

Rather than getting all religious about this, I'd prefer to ask a
different question.

Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
and would anyone else use them? That's the real question here, and
*not* whomever is submitting the patches or who is the first user.

So, let's look into this. According to the proposed code and comments,
PHY_INTERFACE_MODE_50GBASER is a single lane for 50G with clause 134
FEC.

LAUI seems to also be a single lane 50G, no mention about FEC (so one
assumes it has none) and the comment states it's an attachment unit
interface. It doesn't mention anything else about it.

Lastly, we have PHY_INTERFACE_MDOE_100GBASEP, which is again a single
lane running at 100G with clause 134 FEC.

I assume these are *all* IEEE 802.3 defined protocols, sadly my 2018
version of 802.3 doesn't cover them. If they are, then someday, it is
probable that someone will want these definitions.

Now, looking at the SFP code:
- We already have SFF8024_ECC_100GBASE_CR4 which is value 0x0b.
  SFF-8024 says that this is "100GBASE-CR4, 25GBASE-CR, CA-25G-L,
  50GBASE-CR2 with RS (Clause 91) FEC".

  We have a linkmode for 100GBASE-CR4 which we already use, and the
  code adds the LAUI interface. 

  Well, "50GBASE-CR2" is 50GBASE-R over two lanes over a copper cable.
  So, this doesn't fit as LAUI is as per the definition above
  extracted from the code.

- Adding SFF8024_ECC_200GBASE_CR4 which has value 0x40. SFF-8024
  says this is "50GBASE-CR, 100GBASE-CR2, 200GBASE-CR4". No other
  information, e.g. whether FEC is supported or not.

  We do have ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, which is added.
  This is added with PHY_INTERFACE_MODE_50GBASER

  Similar for ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, but with
  PHY_INTERFACE_MDOE_100GBASEP. BASE-P doesn't sound like it's
  compatible with BASE-R, but I have no information on this.

  Finally, we have ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT which
  has not been added.

So, it looks to me like some of these additions could be useful one
day, but I'm not convinced that their use with SFPs is correct.

Now, the next question is whether we have anyone else who could
possibly use this.

Well, we have the LX2160A SoC in mainline, used on SolidRun boards
that are available. These support 25GBASE-R, what could be called
50GBASE-R2 (CAUI-2), and what could be called 100GBASE-R4 (CAUI-4).

This is currently as far as my analysis has gone, and I'm starting
to fall asleep, so it's time to stop trying to comment further on
this right now. Some of what I've written may not be entirely
accurate either. I'm unlikely to have time to provide any further
comment until after the weekend.

However, I think a summary would be... the additions could be useful
but currently seem to me wrongly used.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

