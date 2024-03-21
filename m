Return-Path: <netdev+bounces-81092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7264885C32
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138CA1C22C78
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D29128836;
	Thu, 21 Mar 2024 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YVKySJfw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2D86ADB
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035331; cv=none; b=ICP/v8KyFBljkzuL0C1NFfvvMbJSYLcgmsr0kHvLT+x/QiujJ2vuylwRMvYHhzJDKxhjwa/HRPVrxb60cxBtIPFV4WzfwZFQSOr3FswTiwkUwLB6vz6PG3LykIgFjuWhgMbrtWhLRJS3U/VJgT0TuZeyTPZ2zJUByyeSLTOAWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035331; c=relaxed/simple;
	bh=82p/KyuPYX4kgzjg36RQleurmfIva7WuEX0FUqez6k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEjG8Nh3u5C7B+gPyT8+SUApcmtBOqudy2EagkeRf6iZL5bzzyCwZINTybsaFq/jZfNf5n5POMZz1WkxmItt9Us7fWmL0Phtxn2Rz7UNV2kBHKP9ANC4FdLlMD5QgsDOk2d3MsUs1ybMdPymlfdcik/F96m+42+TZwtu/iUexCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YVKySJfw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/kNv2t+2TnUZMom71UUgFkiGAJYEn1nqpGJ6PwDqECQ=; b=YVKySJfwwuPo+OnmgGEEtNEe8u
	okRvehkGtR9wY/ZcfRsGd/v/LhOZjH8ej3JJxOu3LhqNe3Hw76+EHflAW71zZ7exdjnmYMPvMRjSl
	78W9G6JWdoH9lRM11T2mKAMYeXBNPAwwlzNW+yX6ojvmH71LkA6jKgWiumVDw/tZlNXk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnKRs-00At7N-CU; Thu, 21 Mar 2024 16:35:20 +0100
Date: Thu, 21 Mar 2024 16:35:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] net: Add helpers for netdev LEDs
Message-ID: <18007239-f555-4225-b184-46baed8b89ee@lunn.ch>
References: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
 <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
 <20240321080155.1352b481@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321080155.1352b481@kernel.org>

On Thu, Mar 21, 2024 at 08:01:55AM -0700, Jakub Kicinski wrote:
> On Sun, 17 Mar 2024 16:45:15 -0500 Andrew Lunn wrote:
> > +	struct device *dev = &ndev->dev;
> > +	struct netdev_led *netdev_led;
> > +	struct led_classdev *cdev;
> > +	u32 index;
> > +	int err;
> > +
> > +	netdev_led = devm_kzalloc(dev, sizeof(*netdev_led), GFP_KERNEL);
> > +	if (!netdev_led)
> > +		return -ENOMEM;
> 
> Are we guaranteed to have a real bus device under ndev->dev ?
> I'm not aware of any use of devres in netdev core today.

devm_ does not require a real bus device. It just needs a struct
device. It does not care if it is physical or virtual. All it needs is
that something destroys the struct device using the usual device model
methods.

The struct device is actually part of struct net_device. It is not a
pointer to a bus device. We have register_netdevice() ->
netdev_register_kobject() -> device_initialize(). So the struct device
in struct net_device to registered to the driver core.

unregister_netdevice_many_notify() -> netdev_unregister_kobject() ->
device_del() -> devres_release_all().

So it also gets deleted from the driver core, at which point the
driver core will release all the resources.

So i don't see a reason why this should not work.

	Andrew

