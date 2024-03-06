Return-Path: <netdev+bounces-78088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B1874068
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC571F2478E
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D443140366;
	Wed,  6 Mar 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jws1f8J4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3ED13E7E9
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753437; cv=none; b=jWQezQaHOObXMKtV9iXleyX2xL+Ng+X/YUqvdXUxxI0cw7Z60Y5/67iAUEiwV8IxR9kCdv+yVuazx7h7CeSe80qMTibnLj5IGaRKrpLpm1DJ3h5lU+acqUgA0X2q0ljvKrl/MpGVSN3ETR7xahCXNrCWf5zW9pDeOjx4lRO4Zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753437; c=relaxed/simple;
	bh=p/U/rU69TCMWDjNEnbplHcix01P+rqg7y1tesLb5KFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+cbMLovTqwqc8A7jq3y6E5MhUoCHMXjpAMGasq1KbEuENMpPZ8BIX/sL8AgQmgWXA2XGyZvIT1E1xS+bf+MQlXA+s1yZ2R8xFZqpwNcdk8bdl6REvImnywGfl1oUV2Vjbyw3ADETfzcvMAbbCkb5IBe6Flm4XLCXYprON1XicE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jws1f8J4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lIbu8pC5xXSUfZBb1Pg09l/IGe11JV4DORXoljg1G9A=; b=Jws1f8J4VWXCh3Bj8bOXvAx7Kp
	w4V8mBSGBrdqVEXDqoLbTm1ihfWceRB1Zs7/onZa8lXe6pKIlO5EPAQBxzpDjaIoLzB+33Ktsj8U1
	RWwATvTNiGQjP6yAEqMsNwlta6bpCxh2s3SGwPJGE9L5hVicHtLB1eXx3R0p7CZfcfX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhwyj-009Wbi-H2; Wed, 06 Mar 2024 20:31:01 +0100
Date: Wed, 6 Mar 2024 20:31:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <b3499947-f4b6-4974-9cc4-b2ff98fa20fc@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
 <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
 <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
 <a9341fa0-bca0-4764-b272-9691ad84b9f2@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9341fa0-bca0-4764-b272-9691ad84b9f2@openvpn.net>

On Wed, Mar 06, 2024 at 03:49:50PM +0100, Antonio Quartulli wrote:
> On 05/03/2024 17:27, Andrew Lunn wrote:
> > > > > +void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
> > > > > +{
> > > > > +	ASSERT_RTNL();
> > > > > +
> > > > > +	netif_carrier_off(ovpn->dev);
> > > > 
> > > > You often see virtual devices turn their carrier off in there
> > > > probe/create function, because it is unclear what state it is in after
> > > > register_netdevice().
> > > 
> > > Are you suggesting to turn it off both here and in the create function?
> > > Or should I remove the invocation above?
> > 
> > I noticed it in the _destruct function and went back to look at
> > create. You probably want it in both, unless as part of destruct, you
> > first disconnect all peers, which should set the carrier to off when
> > the last peer disconnects?
> 
> I think keeping the carrier on while no peer is connected is better for
> OpenVPN.

I then have to wounder what carrier actually means?

Some routing protocols will kick off determining routes when the
carrier goes down. Can you put team/bonding on top of openvpn? If the
peer has gone, you want team to fall over to the active backup?

     Andrew

