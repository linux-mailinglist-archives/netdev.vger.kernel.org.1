Return-Path: <netdev+bounces-107729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316AC91C2DB
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539461C213A9
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B1157480;
	Fri, 28 Jun 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pLz5s731"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97271CD39
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589511; cv=none; b=QM8kJ29FO845bTEEKnj+jwhAQLL7Njz9/MLpAwTAaOgfirJBSnkIM01xm1wLN5UybuYtTWlA+I5NkWin+mYd38/b1xONhEF9I6fqNy91n4cJ5eQH81TIwACqiCjkQIs6v8ZPrUx6OyRQVdkHdT0d+gEcJvHaXEewqxWFi9R5IOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589511; c=relaxed/simple;
	bh=rGGoWqQG8d04jgXFw/aq27ELlUB7e7x6Fg9PeWLsX64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba+Pi4hydWTCvorzflW+jc0xixv04MLzW2wzklyxoiGjZqvs/McTM98+oH8lQlY73bkduy2Gubs9nL0kqptmeoHd7kl0lhhtSat5KTiAsNDVriILx4zzAycqq+NtMeAPv0oxHsPyT1eS9ARebsiK4gi3ILMoLTnD/QYMjk9ksSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pLz5s731; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WwgrO2Tcr0OaEaRPFnkJKgkDzN/LMYUd5HQwF1zhUQQ=; b=pLz5s731j6eMq0tSyCXf6RuwRI
	6BH3MmIKPdbibRszlc0MY/TiMTLHOkXF9evpIXCOxYiDkhV0R6vQ4FAQ7/gKGSdsgRo7dfhDZnERa
	qwdAWYaBuWrKNEL9uJEq6KcyGIqtX47ed9Pn+cgF4JR5/1TUiuuT/G4rxyS3HgsAx5WVhQc8sbDw9
	CQrKZ+l869LenOwDEeF8qUntTRvHF0wjKnyp67wALyfmGovF4LDzQlFrmQpWk6HnFaDwz/0r5eIZv
	GNzm8ipVk6+e2bBNhwWFGJugsHqmZuxy+oxmmPHw9zSfoqflNenBEigWxsU8x1oxP2Qog/fF2gzp4
	+kcJrS1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39192)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sNDmW-0006sF-0M;
	Fri, 28 Jun 2024 16:45:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sNDmX-0006cy-Uf; Fri, 28 Jun 2024 16:45:02 +0100
Date: Fri, 28 Jun 2024 16:45:01 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: tn40xx: add initial ethtool_ops support
Message-ID: <Zn7afU9DiotL92jZ@shell.armlinux.org.uk>
References: <20240628134116.120209-1-fujita.tomonori@gmail.com>
 <fe33e69d-a17b-4afd-a5e5-1e1539e6572c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe33e69d-a17b-4afd-a5e5-1e1539e6572c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 28, 2024 at 04:14:44PM +0200, Andrew Lunn wrote:
> On Fri, Jun 28, 2024 at 10:41:16PM +0900, FUJITA Tomonori wrote:
> > Call phylink_ethtool_ksettings_get() for get_link_ksettings method and
> > ethtool_op_get_link() for get_link method.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > ---
> >  drivers/net/ethernet/tehuti/tn40.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
> > index 11db9fde11fe..565b72537efa 100644
> > --- a/drivers/net/ethernet/tehuti/tn40.c
> > +++ b/drivers/net/ethernet/tehuti/tn40.c
> > @@ -1571,6 +1571,19 @@ static const struct net_device_ops tn40_netdev_ops = {
> >  	.ndo_vlan_rx_kill_vid = tn40_vlan_rx_kill_vid,
> >  };
> >  
> > +static int tn40_ethtool_get_link_ksettings(struct net_device *ndev,
> > +					   struct ethtool_link_ksettings *cmd)
> > +{
> > +	struct tn40_priv *priv = netdev_priv(ndev);
> > +
> > +	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
> > +}
> 
> Have you tried implementing tn40_ethtool_set_link_ksettings() in the
> same way?

I did think about commenting on that, and the [sg]et_pauseparam
methods as well, but when one realises that the driver only supports
one speed and duplex (10G FD) but no pause it didn't seem to make
sense.

Not having pause effectively rules out pause-frame rate adaption
by the PHY, so the PHY probably only supports 10G link speeds,
and if I remember correctly, 10GBASE-T requires autoneg.

Deviating off from this topic a bit... 802.3 28D.5:

28D.5 Extensions required for Clause 40 (1000BASE-T)

  a)   Auto-Negotiation is mandatory for 1000BASE-T (see 40.5.1).

28D.6 Extensions required for Clause 55 (10GBASE-T)

  a)   Auto-Negotiation is mandatory for 10GBASE-T.

Now, delving into the PICS for 1000BASE-T, it states:

 Item            Feature                  Subclause   Status
 Support         Value/Comment
 AN        Support for Auto-Negotiation   40.5.1      M     Yes [ ] Required

which doesn't seem to mean that AN must be enabled, only support for
AN is required and it's possible to disable it. nothing states that
disabling AN for 1000base-T is not allowed.

The same seems to be true of 10GBASE-T.

However, wikipedia says:

The autonegotiation specification was improved in the 1998 release of
IEEE 802.3. This was followed by the release of the IEEE 802.3ab Gigabit
Ethernet standard in 1999 which specified mandatory autonegotiation for
1000BASE-T. Autonegotiation is also mandatory for 1000BASE-TX and
10GBASE-T implementations.

which is loose language - "mandatory autonegotiation" does that refer
to support for auto-negotiation or require auto-negotiation to be
always enabled?

We're already seeing some PHYs from some manufacturers that seem to be
following the "require auto-negotiation to be always enabled".

So why have I gone down what seems to be an unrelated rabbit hole?

If tn40 is connected to a 10GBASE-T PHY, implementing the
set_link_ksettings() method would give the user control over whether AN
is used on the media side.

If 802.3 requires AN to be supported but is not necessarily enabled,
then there is use in exposing the set_link_ksettings() method.

If 802.3 requires AN to be supproted and always enabled, then
implementing set_link_ksettings() in this case would not provide any
value.

Which it is... I have no idea. Nothing seems to be giving a clear
unambiguous definitive statement.

The last thing to point out, however, is phylib's behaviour. If autoneg
is disabled, we only allow 10, 100 and 1000M, half or full duplex.
Slightly worse, we allow those whether or not the PHY is even capable
of supporting them!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

