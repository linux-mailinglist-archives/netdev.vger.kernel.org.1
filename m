Return-Path: <netdev+bounces-84651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFE897B9F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF985282566
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860B156981;
	Wed,  3 Apr 2024 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lWlbpPBA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA007156978
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183169; cv=none; b=m+3aIPFcGkC1jUEeiZkokNq9aSWpnHIAbgM17Wcdl5/JiD2boL/3CtWiLYZJHnviuPkJyzuAsTbR9XAlwwxI0RJucd/ZPNKoQIw0TPvTfYyoUkn7kCe8eRqY/xkPvcLsfi47v1SCnbiiOs31pwXZThTLNP+akuvhh8/JAObSHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183169; c=relaxed/simple;
	bh=UqH916rh7Et3Yo4zjePqyoDjI+p7BFvtJ1TohLuY7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvKLx44irRMRzrYXUbFpE3i328JXH+lGOdh/iJ+0u/7D9NZWiDVjOIzdMWcLZ841CglpSBcbbLGeNDdHdDlXD4k5mniYG4z2U3GrEUicZNC0i+QdYiSYHHMT73/dEYrBerjoP9DWBj5ogUFm1ODvmntd5mqKx0skJwtTpdYcPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lWlbpPBA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=pTrZNlYmlug31htyq78PPCJAEkgyZdlx96u7l2nVWZs=; b=lW
	lbpPBACoMLRwZOAAUhQzPwNdcdu1trdyG7wV1O35b7tGlD0W08dWVUUGhPgdSC87sXPNKWSxrvZA6
	yckMMVbzhRZ5KkfSGPKWnclQx3g7TM5ZXapXCu83lhzWCZGy/b/hUmC4HEI4hSa3WV4F9D7TVLxwT
	1iXSs8oxUVPD2M4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs93U-00C7ci-Ab; Thu, 04 Apr 2024 00:26:04 +0200
Date: Thu, 4 Apr 2024 00:26:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 07/15] eth: fbnic: allocate a netdevice and napi
 vectors with queues
Message-ID: <391f2b71-a811-4536-ac6b-9581fc9457ff@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217493453.1598374.2269514228508217276.stgit@ahduyck-xeon-server.home.arpa>
 <8b16d2b4-ef5c-4906-b094-840150980dc1@lunn.ch>
 <CAKgT0UeO-Bv5twdgts0gSaO1qjd_Ze5ax5k0XYUPTeDcsDuyQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UeO-Bv5twdgts0gSaO1qjd_Ze5ax5k0XYUPTeDcsDuyQA@mail.gmail.com>

On Wed, Apr 03, 2024 at 03:15:25PM -0700, Alexander Duyck wrote:
> On Wed, Apr 3, 2024 at 1:58 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +static int fbnic_dsn_to_mac_addr(u64 dsn, char *addr)
> > > +{
> > > +     addr[0] = (dsn >> 56) & 0xFF;
> > > +     addr[1] = (dsn >> 48) & 0xFF;
> > > +     addr[2] = (dsn >> 40) & 0xFF;
> > > +     addr[3] = (dsn >> 16) & 0xFF;
> > > +     addr[4] = (dsn >> 8) & 0xFF;
> > > +     addr[5] = dsn & 0xFF;
> >
> > u64_to_ether_addr() might work here.
> 
> Actually I think it is the opposite byte order. In addition we have to
> skip over bytes 3 and 4 in the center of this as those are just {
> 0xff, 0xff } assuming the DSN is properly formed.

O.K. That is why i used 'might'

> > > +/**
> > > + * fbnic_netdev_register - Initialize general software structures
> > > + * @netdev: Netdev containing structure to initialize and register
> > > + *
> > > + * Initialize the MAC address for the netdev and register it.
> > > + **/
> > > +int fbnic_netdev_register(struct net_device *netdev)
> > > +{
> > > +     struct fbnic_net *fbn = netdev_priv(netdev);
> > > +     struct fbnic_dev *fbd = fbn->fbd;
> > > +     u64 dsn = fbd->dsn;
> > > +     u8 addr[ETH_ALEN];
> > > +     int err;
> > > +
> > > +     err = fbnic_dsn_to_mac_addr(dsn, addr);
> > > +     if (!err) {
> > > +             ether_addr_copy(netdev->perm_addr, addr);
> > > +             eth_hw_addr_set(netdev, addr);
> > > +     } else {
> > > +             dev_err(fbd->dev, "MAC addr %pM invalid\n", addr);
> >
> > Rather than fail, it is more normal to allocate a random MAC address.
> 
> If the MAC address is invalid we are probably looking at an EEPROM
> corruption. If requested we could port over a module parameter we have
> that enables fallback as you are mentioning. However for us it is
> better to default to failing since the MAC address is used to identify
> the system within the datacenter and if it is randomly assigned it
> will make it hard to correctly provision the system anyway.

So maybe add a comment about that.

But i would also expect your DHCP server to be helping out here. If it
gets a request with a MAC it does not know, it could allocate an IP
address from a pool for devices which are FUBAR. You can then at least
ssh into it and try to figure out what has gone wrong?

    Andrew

