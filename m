Return-Path: <netdev+bounces-177986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869FAA73AB2
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D6C7A5429
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16387214813;
	Thu, 27 Mar 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj9RYzvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610E20F08F;
	Thu, 27 Mar 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097046; cv=none; b=Dz2BS9ZArWcM4P+5szbztKNYCDg4dIFry+/MNWfuSimjLboYPXdpG4oszsKIJp7WvCjU0Un7UY5FDFMQjbVOOYjb9TjIvxhS8e0IxnKyK0bhjHSmsk0jC7VHYanZ4JiwfMEynQGcCbMcqv7h0+y+PvfBYOgX9JaCY/jE8sxUJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097046; c=relaxed/simple;
	bh=HQpAQJh3muklwyCnyzlIWz6Pzj5ISyO1vcpTZ5xzMHQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbGeP+86QJTMNTbKrziP1qG3EzzL5SbJOCv59osaehrMKLyqa6qigFdX7XlGbKYewnLWIsGuju/jqOEGUpZUoz2ZJ+7OQrg/SCC7+japTYz7+LNwY6DXGfLkrToQDV3+uMRUgxS2RSL2nR2WEQ1zoc0AbtrJGjb+Nfuz4jA/Q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj9RYzvm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so13508765e9.0;
        Thu, 27 Mar 2025 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743097043; x=1743701843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Ys2ZlQrZI75OHR8mzHVaydYXLMPUTzTOm26+iFbCo=;
        b=Pj9RYzvmH72ivdRMHLvUKapdco5NGw/d09b5UNPKJD5HypOTUIPTZ87DpHE9JoMXR0
         LIj11E9rYRzo/PhyMR4+rCIny0HXTZDZIP5SF96iKXQ+Vx3XqplkbyNsXpnjZji08z8A
         6XCUrCkOthDVbBBs9C/ArTEvaxD6LAXVP61qRUHcprGcyJMZTiF+EIVvRMgjD4kkMac+
         WsnismwkCuJN1m1IUCATNLbNzR1OUspWV9CvTTBYr3LTiX5urguV3zRTrz5AR9d6hBlp
         jUw4UALw9U760V1CPLTXFTtuxWF69KckeYAq9l6JRuXPh4qdQMwRj/14MCuBJgF26q4q
         VcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743097043; x=1743701843;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6Ys2ZlQrZI75OHR8mzHVaydYXLMPUTzTOm26+iFbCo=;
        b=WL3lgQYPjRV+9N+ERIERIvJjmhrKxAEu0CVV0Y4KVB6exetAp9NNqmNtF7nncjL56J
         dJTwz8Q8iSCHBccFlDYZnxwklSAxD9RERNBvFAWe1plVh4oykudokJeubpRPVy/tNYTG
         gyC0sZexwSc3v+QtWgj5Co5rgopw5LWgq/HtxHNRCNF4Z4leWHZXYWFygLyElh5FudnA
         cHITirbGDLDzDaatpt330Qw2hAt/5GogBYjSRdQojpV1dOjIqvDOwAVqABvAOxMCjxhK
         5cV7CCR4MFMIOzcrZdoLxX8alBMh0DeHz4AGerBuRdRziNw7CMeov06XcyirYO2/973T
         GxIA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0UcNC+uHDAOOtWCFds9ziwuiIPxIejyt0BFVT5GTHIGn5D6aMqeHSb4MRURptwu8ZIWURBaX@vger.kernel.org, AJvYcCWiNjoarnxtBFyNeNeIbqm1rkMDwCC+CLPyl4rCWC+NVQwg4eW2x4z2UzCitBXdOWQbjAfc4/hv2eGPo5i/@vger.kernel.org, AJvYcCXnl9CIDV0s2XGQaUQ7DTTm9qXLzfbhVW30VNC8Wv/ssVfoESnO3gWqDVWrhHsDjONuDrJWNeVcpk2e@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfuOhaW8NtE7CRY1m+FqB7yPWC1duzUhh0cnLG/9AWeJyhTHw
	i561Hsey9Kt7WHPr4a8SU7ezGL/26n1L05Jfz7Fv5QgV7gDOxVHp
X-Gm-Gg: ASbGnct+oYlxa7wBgY9Q+HrThtItd8xpk92pN5ilR8irrdzfQbvBYeqTWvAQKRRejBV
	mCkXeIqN+mqvIBg7fKeUdP4ozmPVPtI4Pe39aywxFMQIZpk3XwyRS0w7FjfJRAbgnDINMNlFH0Z
	0S1bMpzkJEgPf7Xm9Am5jz/3cvpTIxfnvIVPYr+7VT7YroQ41AJpRURl7pX2KOppqnCgt6AMHmP
	9qwrH4Px3G9Jo59ax1Ux7sywAPLxCXTELP0t6463SGtc+IDe4aqhqvJ/MShpK36LZ4eA0KIrmJY
	LSh1L8isT0hE+WBhaQkcFT9GtNfbpgMjpPghWcPiwptw1dQwPIaQSz1SPzlMnX9RC+x5hUYV+xo
	ho7Jt13ZRPfg=
X-Google-Smtp-Source: AGHT+IHQVILieqXhfCmLgmCPwty7dU1zs9F7aNXcif4TGuQZJb9ahNm/UpFU22cG7bbu9z+sNoULSQ==
X-Received: by 2002:a05:600c:3b08:b0:43c:eec7:eab7 with SMTP id 5b1f17b1804b1-43d905a8085mr801705e9.11.1743097042824;
        Thu, 27 Mar 2025 10:37:22 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8fccfd9bsm1616715e9.20.2025.03.27.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:37:22 -0700 (PDT)
Message-ID: <67e58cd2.7b0a0220.289480.1e35@mx.google.com>
X-Google-Original-Message-ID: <Z-WMz-YLtJjOYkmH@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 18:37:19 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe
 defer from PCS provider
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-4-ansuelsmth@gmail.com>
 <Z9rplhTelXb-oZdC@shell.armlinux.org.uk>
 <67daee6c.050a0220.31556f.dd73@mx.google.com>
 <Z9r4unqsYJkLl4fn@shell.armlinux.org.uk>
 <67db005c.df0a0220.f7398.ba6b@mx.google.com>
 <Z9sbeNTNy0dYhCgu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9sbeNTNy0dYhCgu@shell.armlinux.org.uk>

On Wed, Mar 19, 2025 at 07:31:04PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 19, 2025 at 06:35:21PM +0100, Christian Marangi wrote:
> > On Wed, Mar 19, 2025 at 05:02:50PM +0000, Russell King (Oracle) wrote:
> > > My thoughts are that if a PCS goes away after a MAC driver has "got"
> > > it, then:
> > > 
> > > 1. we need to recognise that those PHY interfaces and/or link modes
> > >    are no longer available.
> > > 2. if the PCS was in-use, then the link needs to be taken down at
> > >    minimum and the .pcs_disable() method needs to be called to
> > >    release any resources that .pcs_enable() enabled (e.g. irq masks,
> > >    power enables, etc.)
> > > 3. the MAC driver needs to be notified that the PCS pointer it
> > >    stashed is no longer valid, so it doesn't return it for
> > >    mac_select_pcs().
> > 
> > But why we need all these indirect handling and checks if we can
> > make use of .remove and shutdown the interface. A removal of a PCS
> > should cause the entire link to go down, isn't a dev_close enough to
> > propagate this? If and when the interface will came up checks are done
> > again and it will fail to go UP if PCS can't be found.
> > 
> > I know it's a drastic approach to call dev_close but link is down anyway
> > so lets reinit everything from scratch. It should handle point 2 and 3
> > right?
> 
> Let's look at what dev_close() does. This is how it's documented:
> 
>  * dev_close() - shutdown an interface
>  * @dev: device to shutdown
>  *
>  * This function moves an active device into down state. A
>  * %NETDEV_GOING_DOWN is sent to the netdev notifier chain. The device
>  * is then deactivated and finally a %NETDEV_DOWN is sent to the notifier
>  * chain.
> 
> So, this is equivalent to userspace doing:
> 
> # ip li set dev ethX down
> 
> and nothing prevents userspace doing:
> 
> # ip li set dev ethX up
> 
> after that call to dev_close() has returned.
> 
> If this happens, then the netdev driver's .ndo_open will be called,
> which will then call phylink_start(), and that will attempt to bring
> the link back up. That will call .mac_select_pcs(), which _if_ the
> PCS is still "published" means it is _still_ accessible.
> 
> So your call that results in dev_close() with the PCS still being
> published is ineffectual.
> 
> It's *no* different from this crap in the stmmac driver:
> 
>         stmmac_stop_all_dma(priv);
>         stmmac_mac_set(priv, priv->ioaddr, false);
>         unregister_netdev(ndev);
> 
> because *until* that unregister_netdev() call has completed, _userspace_
> still has control over the netdev, and can do whatever it damn well
> pleases.
> 
> Look, this is very very very simple.
> 
> If something is published to another part of the code, it is
> discoverable, and it can be used or manipulated by new users.
> 
> If we wish to take something away, then first, it must be
> unpublished to prevent new users discovering the resource. Then
> existing users need to be dealt with in a safe way. Only at that
> point can we be certain that there are no users, and thus the
> underlying device begin to be torn down.
> 
> It's entirely logical!
>

OK so (I think this was also suggested in the more specific PCS patch)
- 1. unpublish the PCS from the provider
- 2. put down the link...

I feel point 2 is the big effort here to solve. Mainly your problem is
the fact that phylink_major_config should not handle PROBE_DEFER and
should always have all the expected PCS available. (returned from
mac_select_pcs)

So the validation MUST ALWAYS be done before reaching that code path.

That means that when a PCS is removed, the entire phylink should be
refreshed and reevaluated. And at the same time lock userspace from
doing anything fancy (as there might be a possibility for
phylink_major_config)

Daniel at some point in the brainstorm process suggested that we might
need something like phylink_impair() to lock it while it's getting
""refreshed"". Do you think that might be a good path for this?

One of the first implementation of this called phylink_stop (not
dev_stop) so maybe I should reconsider keeping everything phylink
related. But that wouldn't put the interface down from userspace if I'm
not wrong.

It's point 3 (of the old list) "the MAC driver needs to be notified that
the PCS pointer it stashed is no longer valid, so it doesn't return it for
mac_select_pcs()." my problem. I still feel MAC should not track PCS but
only react on the presence (or absence) of them.

And this point is really connected to point 1 so I guess point 1 is the
first to handle, before this. (I also feel it will magically solved once
point 1 is handled)

> > For point 1, additional entry like available_interface? And gets updated
> > once a PCS gets removed??? Or if we don't like the parsing hell we map
> > every interface to a PCS pointer? (not worth the wasted space IMHO)
> 
> At the moment, MAC drivers that I've updated will do things like:
> 
>                 phy_interface_or(priv->phylink_config.supported_interfaces,
>                                  priv->phylink_config.supported_interfaces,
>                                  pcs->supported_interfaces);
> 
> phylink_config.supported_interfaces is the set of interface modes that
> the MAC _and_ PCS subsystem supports. It's not just the MAC, it's both
> together.
> 
> So, if a PCS is going away, then clearing the interface modes that the
> PCS was providing would make sense - but there's a problem here. What
> if the PCS is a bought-in bit of IP where the driver supports many modes
> but the MAC doesn't use it for all those modes. So... which interface
> modes get cleared is up to the MAC driver to decide.
> 

Should we add an OP to handle removal of PCS from a MAC? Like
.mac_release_pcs ? I might be wrong but isn't that giving too much
freedom to the driver?

I need to recheck how the interface validation work and what values are
used but with this removal thing on the table, supported_interfaces OR
with the PCS supported_interface might be problematic and maybe the
original values should be stored somewhere.

> > > There's probably a bunch more that needs to happen, and maybe need
> > > to consider how to deal with "pcs came back".. but I haven't thought
> > > that through yet.
> > 
> > Current approach supports PCS came back as we check the global provider
> > list and the PCS is reachable again there.
> > (we tasted various scenario with unbind/bind while the interface was
> > up/down)
> 
> ... because you look up the PCS in the mac_select_pcs() callback which
> leads to a different race to what we have today, this time inside the
> phylink code which thankfully phylink prints an error which is *NEVER*
> supposed to happen.
>

I want to make sure tho you are ok with the usage of .mac_select_pcs
for re-evaluation task.

Maybe a better approach is to introduce .mac_get_pcs and enforce the
usage only on validation phase? (aka in phylink_validate_mac_and_pcs)

AFAIK in that phase .mac_select_pcs can return errors if the requested
interface is not possible for one reason or another.

What do you think? In short 2 additional OP that with the select one
result in:

- get
- select
- release

-- 
	Ansuel

