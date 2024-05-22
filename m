Return-Path: <netdev+bounces-97591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED1B8CC33C
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB61284528
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512AA1411EB;
	Wed, 22 May 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LKEaHyeK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275E3C0B
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388123; cv=none; b=U0js4ZjmQb+LEcZaYRktMX4GK8V/Pg2X60yRXO68qpFVRQ0+L2jfsrqOojGz4CmWrJzVqhpFxg62CyAeydzJWKFPmvIkKnpzcHb/KPdpPZkh/Rd1Eu2MEaggbz9AZWscUvZkLTw9KJXnKFx5zRDll0lK2iLRT0/Q9YtM2I+TGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388123; c=relaxed/simple;
	bh=VqOqX4sZlN6cJqzBdbV6+32nB6/s4m4Zlviy6a6Oqzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVO1XDzJyAm14Jd90K4GWFvRYZQfhsbfnGE2ARSWo+NxDHzZtdh2p23sR31MVmJeV2lRV0NTFyqEv0QfQbJxG564oQL0vE/yAszTn2kwy842SBYbTrfxACN523wA3CPDQNvrLzyg6gFmGlvh0uX6T2AbA8JbRPkQ8TlKCvc4ZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LKEaHyeK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tw+R9BYf95RyzTDu2T6wVDxUNCWUahQuJrOaTi1MxrY=; b=LKEaHyeK/GGw76sACR/nZ2nL+Z
	umPfUEvaei9fkm7Qe+8erJkdqHL6D1W4ES9RJYqOi4jTS1MJBT4pLsf36KFLeF0I3LwRqhagt2tXr
	x4LeQkOX6h0sNne0e5pixUH8RMijfiV76psWzLboyTd5H6bsmH8hN9r7JRKS3vrfWXvc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9mxI-00FpPv-BU; Wed, 22 May 2024 16:28:36 +0200
Date: Wed, 22 May 2024 16:28:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 11/24] ovpn: implement packet processing
Message-ID: <055d3c86-8d5f-4547-ba89-5277fead3f8d@lunn.ch>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-12-antonio@openvpn.net>
 <ZkCB2sFnpIluo3wm@hog>
 <26aa4e16-a7d5-462a-8361-624536715214@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26aa4e16-a7d5-462a-8361-624536715214@openvpn.net>

On Wed, May 22, 2024 at 04:08:44PM +0200, Antonio Quartulli wrote:
> On 12/05/2024 10:46, Sabrina Dubroca wrote:
> > 2024-05-06, 03:16:24 +0200, Antonio Quartulli wrote:
> > > diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
> > > index c1f842c06e32..7240d1036fb7 100644
> > > --- a/drivers/net/ovpn/bind.c
> > > +++ b/drivers/net/ovpn/bind.c
> > > @@ -13,6 +13,7 @@
> > >   #include "ovpnstruct.h"
> > >   #include "io.h"
> > >   #include "bind.h"
> > > +#include "packet.h"
> > >   #include "peer.h"
> > 
> > You have a few hunks like that in this patch, adding an include to a
> > file that is otherwise not being modified. That's odd.
> 
> I just went through this and there is a reason for these extra includes.
> 
> Basically this patch is modifying peer.h so that it now requires packet.h as
> dependency.
> 
> To reduce the includes complexity I am adding as many includes as possible
> to .c files only, therefore the dependency needs to appear in every .c file
> including peer.h, rather than adding the include to peer.h itself.
> 
> This was my interpretation of Andrew Lunn's suggestion, but I may have got
> it too extreme.

It becomes an issue when adding one include pulls in 10s to 100s of
other includes, 99% of which are not needed and just slows down the
compile. With our own local headers, this is probably not going to
happen.

Try using

make foo/bar/foobar.i

which will run cpp on foobar.c and produce foobar.i. You can then see
the effects of the additional include. If it is minimum, you don't
need to care much, and could always include it.

     Andrew


