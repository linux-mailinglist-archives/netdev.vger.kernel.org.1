Return-Path: <netdev+bounces-169602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67688A44B76
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1C3420AD3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8020AF85;
	Tue, 25 Feb 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k1h9NN+v"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A462036EB;
	Tue, 25 Feb 2025 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512373; cv=none; b=nLBiFzItVzkRj6z6ly6+8hqbVCiu9ZPmCiHb+VIj19u5gTIN63xm7dOgCn+XZcue4mCBcq9LuWTJJzuFO+H0YoBad04ocyTMzLqzluF0vaxbJ6J4dWLdEP7Oxgv4+iXCALX1T/RaWBPj0e0nPC8L2L9kOjvARO4Bi5zyaEaPR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512373; c=relaxed/simple;
	bh=12jSNbr/O7Q1kvbb9tzLOBuiGrS73Qz9TCIgyAJGh9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxKy1NAgrbRdPQuHoUgnZxEGVgJHOV2Mcn4dj8IVAOn2ilVywyp7franFQcQ+1g3S+yJLHq3qOAbfBPxRBJ7XUTDZagjLDlQZmOlJsffTBl/060Oq6GJjF95DmZICxrm0TKxO6eknQzmzi+RdI6bF2qjVXhbYkgFTyhCDrglTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k1h9NN+v; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 11B4E11400DD;
	Tue, 25 Feb 2025 14:39:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 14:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740512369; x=1740598769; bh=tNpHy374sw+alC5l8BsffCVK88jBzGOVtLI
	rpfQdpMA=; b=k1h9NN+vlkzReBZoUj7kD0/VPnmlSJ0veTe8nXDG4gsoLEVS9EP
	ZfLrL8wEZmQpCyUXmctwdB3KEFyP+lLPKByi+SXIDOQl9Ikl3go7tRzNRkvoVR9c
	sXwNiTnKuP2D7mjmU0gMVKEj14dPor6uNErVuisSuWp4hin9oP0Sxl3bzmOsU5yn
	CppS5zY7fhRjBVy3psq2TqFO9Abp2uZy5JQxmsdWvLhHoOB2RoHlZtiXajDHpqem
	+T0VgAR7JB7VgVH6io1uO3g1goAWsGRI0hKvm1C1UW9qLQWHxM6R8L9OLU7IhdKs
	+P6fpYALyImD2xMlDdc4EJxZjAIFKSf8fVQ==
X-ME-Sender: <xms:cRy-Z5mzCLParHuQi63QdnKmpk-SOeEG-K2GQyqWkcLFTS4bgUx63w>
    <xme:cRy-Z00KEpOYjG9TvbKgjgOtEedc1t0FB7jJSKMnbQqv8q9Q99sY3nvw5TGlFRTdP
    GEIemLXKdAljuA>
X-ME-Received: <xmr:cRy-Z_roSxA3kyf1FxUmVbl_JuHozi4J0PwGPNoNTEiPA6cRfxr1i9YnO6bdvRrc8pzEgBUk7ncP_vwJ1JY1HjOUhHOgWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefg
    udffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehoshgtmhgrvghsledvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmshes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrd
    horhhgrdhukhdprhgtphhtthhopehjihhrihesrhgvshhnuhhllhhirdhush
X-ME-Proxy: <xmx:cRy-Z5k6_vouBe6jFlqc1nKqnztF7iSLOrZqnJEdE2R-IqhNqsYxkQ>
    <xmx:cRy-Z30tNDb7bMKc_kEErQEUcHDmvPD2Xvb1ZqQu7hGF_ECV0878qw>
    <xmx:cRy-Z4tIOMs-P9HywUUxZ2JpwQgMlhDvxuXfLFXO7zTa60gpT-xhhA>
    <xmx:cRy-Z7VW5fRh4Igf3kyJ36KUFCmL8iwo3dAnh6duGgkXneLXuNYSQg>
    <xmx:cRy-ZwuUbUfsB_0GqtY7xl6oxNyHFGR808nxMBIXd2H02Fe3TKyH3QBT>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 14:39:28 -0500 (EST)
Date: Tue, 25 Feb 2025 21:39:25 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	viro@zeniv.linux.org.uk, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, security@kernel.org,
	syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: 802: enforce underlying device type for GARP
 and MRP
Message-ID: <Z74cbT8aNIPn__FF@shredder>
References: <20250212113218.9859-1-oscmaes92@gmail.com>
 <Z6ywV4OkFu52AB8P@shredder>
 <20250225141157-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225141157-oscmaes92@gmail.com>

On Tue, Feb 25, 2025 at 03:11:57PM +0100, Oscar Maes wrote:
> On Wed, Feb 12, 2025 at 04:29:43PM +0200, Ido Schimmel wrote:
> > On Wed, Feb 12, 2025 at 12:32:18PM +0100, Oscar Maes wrote:
> > > When creating a VLAN device, we initialize GARP (garp_init_applicant)
> > > and MRP (mrp_init_applicant) for the underlying device.
> > > 
> > > As part of the initialization process, we add the multicast address of
> > > each applicant to the underlying device, by calling dev_mc_add.
> > > 
> > > __dev_mc_add uses dev->addr_len to determine the length of the new
> > > multicast address.
> > > 
> > > This causes an out-of-bounds read if dev->addr_len is greater than 6,
> > > since the multicast addresses provided by GARP and MRP are only 6 bytes
> > > long.
> > > 
> > > This behaviour can be reproduced using the following commands:
> > > 
> > > ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
> > > ip l set up dev gretest
> > > ip link add link gretest name vlantest type vlan id 100
> > > 
> > > Then, the following command will display the address of garp_pdu_rcv:
> > > 
> > > ip maddr show | grep 01:80:c2:00:00:21
> > > 
> > > Fix this by enforcing the type and address length of
> > > the underlying device during GARP and MRP initialization.
> > > 
> > > Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> > > Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
> > > Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
> > > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > > ---
> > >  net/802/garp.c | 5 +++++
> > >  net/802/mrp.c  | 5 +++++
> > >  2 files changed, 10 insertions(+)
> > > 
> > > diff --git a/net/802/garp.c b/net/802/garp.c
> > > index 27f0ab146..2f383ee73 100644
> > > --- a/net/802/garp.c
> > > +++ b/net/802/garp.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/skbuff.h>
> > >  #include <linux/netdevice.h>
> > >  #include <linux/etherdevice.h>
> > > +#include <linux/if_arp.h>
> > >  #include <linux/rtnetlink.h>
> > >  #include <linux/llc.h>
> > >  #include <linux/slab.h>
> > > @@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
> > >  
> > >  	ASSERT_RTNL();
> > >  
> > > +	err = -EINVAL;
> > > +	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
> > 
> > Checking for 'ARPHRD_ETHER' is not enough? Other virtual devices such as
> > macsec, macvlan and ipvlan only look at 'dev->type' AFAICT.
> 
> Agreed, I will change this.
> 
> > 
> > Also, how about moving this to vlan_check_real_dev()? It's common to
> > both the IOCTL and netlink paths.
> 
> {garp,mrp}_init_applicant assume that the address length is 6-bytes, when they call dev_mc_add
> with a 6-byte buffer.
> I think that the ARPHRD check should be right before calling dev_mc_add.
> 
> Currently, GARP is only used by VLAN, which means your suggestion would technically work,
> but this assumption might be violated by future protocol implementations like GMRP, which
> could potentially resurface this bug.

I disagree. The problem is in the caller (the VLAN driver). It should
explicitly check for the error condition (real device not being
Ethernet) and bail out as soon as possible (in vlan_check_real_dev())
with an appropriate error message. It should not rely on the first
function where this error condition happened to explode to do the
verification, especially when this function can be compiled out (e.g.,
CONFIG_VLAN_8021Q_GVRP=n).

> 
> > 
> > > +		goto err1;
> > > +
> > >  	if (!rtnl_dereference(dev->garp_port)) {
> > >  		err = garp_init_port(dev);
> > >  		if (err < 0)
> > > diff --git a/net/802/mrp.c b/net/802/mrp.c
> > > index e0c96d0da..1efee0b39 100644
> > > --- a/net/802/mrp.c
> > > +++ b/net/802/mrp.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/skbuff.h>
> > >  #include <linux/netdevice.h>
> > >  #include <linux/etherdevice.h>
> > > +#include <linux/if_arp.h>
> > >  #include <linux/rtnetlink.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/module.h>
> > > @@ -859,6 +860,10 @@ int mrp_init_applicant(struct net_device *dev, struct mrp_application *appl)
> > >  
> > >  	ASSERT_RTNL();
> > >  
> > > +	err = -EINVAL;
> > > +	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
> > > +		goto err1;
> > > +
> > >  	if (!rtnl_dereference(dev->mrp_port)) {
> > >  		err = mrp_init_port(dev);
> > >  		if (err < 0)
> > > -- 
> > > 2.39.5
> > > 
> > > 

