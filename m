Return-Path: <netdev+bounces-78089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882A874098
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A281F22E16
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376F140365;
	Wed,  6 Mar 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JqH63vRq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FA813E7C4
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753997; cv=none; b=lIdEs2Dr8k6QmSLUpOiBRVFumwg8a5z/W17wp/VfaQqqFMQEiHtm4PbtkRqLxAgmPgd1Jc5gp3orsPs5Yp+jiM0/8iSzj4aB17Pa7Gnba+AcdUwrVWkJKMROytoZMUBA8vn9S5I6RGfc0+PJQyFNnuDyfiXqTL5olpi03waobAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753997; c=relaxed/simple;
	bh=OHMDUw8wZFNBqKvBPgCt+j65iaX3/ESPLB8XXqiX2R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwvwsZUiRF2C/fL5ZUjq7ecokI7Oll84YJeDztA5ldIpIOYapeRHD2wZMyIMK/opyCOYQpVPDbkEooab+gxOLpML9kvoHSdzAp10wYM/ZY694MydGZT1oopDuOBB2L51C5L9vtuQqM2PyfVXvdK7GlhPVYa5jBuC9KZM6o9hEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JqH63vRq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ztEqR5HvQk+w5JaIMAVNvY0OgOwcnEbaG9mbQ9VkILQ=; b=JqH63vRqPd7kFITknD+fCw4Fwh
	n98F2XxVs53lCWech/4/NwyLcitudMqKaS9AHKxvsrurO7VKGXLizIcb/hvpiu60fPutq4tcj6jh8
	N7yB5YOiulm9Tq4XCYg0yftxf0b4QvUC0LTWWFZNfpGCBUEHKXncvEjP33ptxR1+N/5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhx7m-009WdM-02; Wed, 06 Mar 2024 20:40:22 +0100
Date: Wed, 6 Mar 2024 20:40:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 22/22] ovpn: add basic ethtool support
Message-ID: <01adab06-78c9-421e-bd3f-453e948f5bbb@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-23-antonio@openvpn.net>
 <57e2274e-fa83-47c9-890b-bb3d2a62acb9@lunn.ch>
 <25cc6fba-d8e5-46c0-8c16-f71373328e7d@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25cc6fba-d8e5-46c0-8c16-f71373328e7d@openvpn.net>

On Wed, Mar 06, 2024 at 04:42:03PM +0100, Antonio Quartulli wrote:
> On 05/03/2024 00:04, Andrew Lunn wrote:
> > On Mon, Mar 04, 2024 at 04:09:13PM +0100, Antonio Quartulli wrote:
> > > Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> > > ---
> > >   drivers/net/ovpn/main.c | 32 ++++++++++++++++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> > > index 95a94ccc99c1..9dfcf2580659 100644
> > > --- a/drivers/net/ovpn/main.c
> > > +++ b/drivers/net/ovpn/main.c
> > > @@ -13,6 +13,7 @@
> > >   #include "ovpnstruct.h"
> > >   #include "packet.h"
> > > +#include <linux/ethtool.h>
> > >   #include <linux/genetlink.h>
> > >   #include <linux/module.h>
> > >   #include <linux/moduleparam.h>
> > > @@ -83,6 +84,36 @@ static const struct net_device_ops ovpn_netdev_ops = {
> > >   	.ndo_get_stats64        = dev_get_tstats64,
> > >   };
> > > +static int ovpn_get_link_ksettings(struct net_device *dev,
> > > +				   struct ethtool_link_ksettings *cmd)
> > > +{
> > > +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, 0);
> > > +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, 0);
> > > +	cmd->base.speed	= SPEED_1000;
> > > +	cmd->base.duplex = DUPLEX_FULL;
> > > +	cmd->base.port = PORT_TP;
> > > +	cmd->base.phy_address = 0;
> > > +	cmd->base.transceiver = XCVR_INTERNAL;
> > > +	cmd->base.autoneg = AUTONEG_DISABLE;
> > 
> > Why? It is a virtual device. Speed and duplex is meaningless. You
> > could run this over FDDI, HIPPI, or RFC 1149? So why PORT_TP?
> 
> To be honest, I couldn't find any description to help me with deciding what
> to set there and I just used a value I saw in other Ethernet drivers.
> 
> Do you have any recommendation?
> For the other fields: do you think they make sense? The speed value is
> always debatable...The actual speed depends on the transport interface and
> there might be multiple involved. Maybe SPEED_UNKNOWN is more appropriate?

Turn it around. What is your use case? What is using this information?
I would just not implement this function. But maybe you know of
something which actually requires it?

> > > +	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
> > 
> > This is also not accurate. There is no bus involved.
> 
> Should I just leave it empty then?
> 
> My concern is that a user expects $something and it will crash on my empty
> string. But if empty is allowed, I will just go with it.

Empty is allowed. The bridge uses "N/A", which i would say is also
correct. tun/tap does however use "tun", so "ovpn" is not that
different i supposes.

	Andrew


