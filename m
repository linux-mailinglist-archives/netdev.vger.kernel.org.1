Return-Path: <netdev+bounces-126666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C618D9722D0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B253B2081B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0910F188CC8;
	Mon,  9 Sep 2024 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vMnIz3gY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56ED200AF;
	Mon,  9 Sep 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910569; cv=none; b=giSVg5jlu2d7ECnH/81FZXvIKfEgpFfV59PZikHTIhgy+tCF+9U8muhCk/qKJGqbWuDl2ra/bQ0rWtbSbgxxU3op509hXjSYrtbOcq6YOAoUgyJ3NSqDxzQPK4mbum4Hs6G7Q+tJtKAfk0nDUQ0TsVRzuurgqQfwqERip4/TAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910569; c=relaxed/simple;
	bh=BX+/MaXTvDjTfi5O/xqF/oW4u0uKBlWCm8bfqwI3qoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogMvEKeCrTIAaS51e9TbJx89vVl98rHo0Y3hxlSGKv3taMMY5ICasEGezIEyNkILr4621QV3vJT2xld2yih6DWIPAquCY8lUP009k7RfntZKiaQvQzqleIYiKB35PsG/iKCLCIl1avD3Hijgz0DR6fpXKEKz1VWSqN5JC2JzlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vMnIz3gY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/l8900RWbPmYjq3b+TLQg0cSZw4LqMuDhLsLEMWJlZQ=; b=vMnIz3gY1KXOGHG+O63lW4eynk
	BwiiICYSi/jPJFBQV7KfsO1nXaOjvrZcem6HS7zQrujD8+iYOo3PmD6jlZqeU+99+xY15ZwRO1qzw
	txMIPgOGUYb30c4+vFe+oYZ7F77Q3km9Zu72uWfljGDDlSfJgWPoZNkA5iJAngcIPYbA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snkAt-0072OP-Gu; Mon, 09 Sep 2024 21:35:47 +0200
Date: Mon, 9 Sep 2024 21:35:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Daly <jeffd@silicom-usa.com>
Cc: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ixgbe: Manual AN-37 for troublesome link partners for
 X550 SFI
Message-ID: <da850961-d6ac-46f5-8afb-66e83e33095e@lunn.ch>
References: <20240906104145.9587-1-jeffd@silicom-usa.com>
 <becaaeaf-e76a-43d2-b6e1-e7cc330d8cae@lunn.ch>
 <VI1PR04MB5501C2A00D658115EF4E7845EA9E2@VI1PR04MB5501.eurprd04.prod.outlook.com>
 <ac2faac2-a946-4052-9f61-b0c1c644ee59@lunn.ch>
 <VI1PR04MB5501658A227BFC1A832B2627EA992@VI1PR04MB5501.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5501658A227BFC1A832B2627EA992@VI1PR04MB5501.eurprd04.prod.outlook.com>

> This was originally worked out by Doug Boom at Intel.  It had to do
> with autonegotiation not being the part of the SFP optics when the
> Denverton X550 Si was released and was thus not POR for DNV.  The
> Juniper switches however won't exit their AN sequence unless an AN37
> transaction is seen.

I wounder what 802.3 says about this. I suspect the Juniper switch is
within the standard here, and the x550 is broken.

> Other switch vendors recover gracefully when the right encoding is
> discovered, not using AN37 transactions, but not Juniper.

We have seen similar things in the Linux core PHY handling, but mostly
around 2500BaseX MAC and PHY drivers. A lot of vendors implement what
they call over clocked SGMII, rather than 2500BaseX. But SGMII
signalling makes no sense when overclocked to 2.5GHz, so they just
disable it, leaving no signalling at all. Some 25000BaseX PHYs handle
this, they gracefully fall back to sensible defaults when they
discover they are connected to a broken MAC. Others need telling they
are connected to a broken MAC which does not perform signalling. But
it is easier for a MAC-PHY relationship, everything is on one board,
we know all the details, and can work around the issues.

> Since DNV doesn't do AN37 in SFP auto mode, there's an endless loop.
> (Technically, the switches *could* be updated to new firmware that
> should have this capability, but apparently a logistical issue for
> at least one of our customers.)

I would say that is the wrong solution, i don't think the switch is
doing anything wrong. But the devil is in the details, check 802.3.

> Going back through my emails, Doug did mention that it would possibly cause issues with other switches, but it wasn't anything we, or (until just recently) anyone else had observed.  A quote from Doug:  
> 
> "that AN37 fix pretty much only works with the Juniper switches, and can cause problems with other switches."

LOS from the from the SFP cage will tell you there is something on the
other end of the link. It is not a particularly reliable signal, since
it just means there is light. Is there any indication the link is not
usable? You could wait 10 seconds after LOS is inactive, and if there
is no usable link kick off the workaround. If after 10 seconds the
link is still not usable, turn the workaround off again. Flip flop
every 10 seconds.

Hopefully the initial 10 seconds delay means you won't upset switches
which currently work, and after 10 seconds, you gain a link to
switches that really do expect AN37.

	Andrew

