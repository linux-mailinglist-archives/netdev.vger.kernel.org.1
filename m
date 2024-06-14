Return-Path: <netdev+bounces-103649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75C908E69
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E132E28AF15
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4037019B5A5;
	Fri, 14 Jun 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rJSYDq3n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623919AA6E;
	Fri, 14 Jun 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377900; cv=none; b=qpTEASackckHNaD9xUMs++/BPslxaQ9IWlPo+ra2H7N4gOd7fPlWY52A44JYc/Oyyfb/GjEVwmr0KwPv84Hb4HynkGL0uJdMEGkbO6tSLm2id2gd4MJ7qBph8KIQ5ty+D9RCIAa9jnOkHpzD6cvNh4x/df+Ps/ODd3SFGUYb8Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377900; c=relaxed/simple;
	bh=/3Mg5rIwDCahxGgJ6iiybRmVjRLsews/D+g4t1liyx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLFw2AhO6fQqgJ/Yw/XovAnulKiYlx3vtjv+WH8RK5abA+pn7IvS1JL50auM+9ZULqtMB/nKxJlO5/wCYRMhURl9Iyy5y2MRBx6HkH3xVFo1qwDkOCG6Moo85NI3F1wy4RukSudQupWQYpHvdN0z9R6EQpjhUKqqBP/kcem50Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rJSYDq3n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bfVN5YN8JhVjpssbPI26uslRFd4p7nnZEhkAMORv9XM=; b=rJSYDq3nwAThqM8pk0ZJ+N9e74
	TPoy0AM3t84gM/r3tHQE1vUj/c1wpZe8mZTmb35nvVPCAumadBWluGk5SelJDcpQOKLKT3TDA/QoI
	05lnooBitw/KIhJNOt3chdZr095Qq707t7gsmpyQ7TJgSap1S1HzoZgcPKU+7OC/lgiY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sI8Cv-0004TC-Hl; Fri, 14 Jun 2024 16:47:13 +0200
Date: Fri, 14 Jun 2024 16:47:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fec_main: Register net device before initializing the
 MDIO bus
Message-ID: <222fed4c-1613-40ec-b0a2-35b181fac795@lunn.ch>
References: <51faeed2-6a6b-439b-80e6-8cf2b5ce401a@lunn.ch>
 <20240614084050.1205641-1-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614084050.1205641-1-paul.geurts@prodrive-technologies.com>

On Fri, Jun 14, 2024 at 10:40:50AM +0200, Paul Geurts wrote:
> > On Thu, Jun 13, 2024 at 04:41:11PM +0200, Paul Geurts wrote:
> > > Registration of the FEC MDIO bus triggers a probe of all devices
> > > connected to that bus. DSA based Ethernet switch devices connect to the
> > > uplink Ethernet port during probe. When a DSA based, MDIO controlled
> > > Ethernet switch is connected to FEC, it cannot connect the uplink port,
> > > as the FEC MDIO port is registered before the net device is being
> > > registered. This causes an unnecessary defer of the Ethernet switch
> > > driver probe.
> > > 
> > > Register the net device before initializing and registering the MDIO
> > > bus.
> > 
> > The problem with this is, as soon as you call register_netdev(), the
> > device is alive and sending packets. It can be sending packets even
> > before register_netdev() returns, e.g. in the case of NFS root. So
> > fec_enet_open() gets called, and tried to find its PHY. But the MDIO
> > bus is not registered yet....
> 
> Valid argument there. I was trying to make the initialization more efficient,
> but you are correct.

Any changes to make this more efficient probably needs to be generic,
and not in a specific Ethernet driver. One idea might be, when parsing
the DT node for the MDIO bus, look to see if the device on the bus has
a compatible which indicates it is not a PHY. If so, try to make the
driver core put the device straight into deferred state, without even
trying the first probe.

Also, look at driver core devlink stuff. It tries to keep track of
resource dependencies, and only probe devices when their resources are
available. It does not seem to understand DSA too well, and it might
be made better. But this is complex, we have dependency loops in
network drivers, which causes devlink issues.

       Andrew

