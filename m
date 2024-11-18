Return-Path: <netdev+bounces-145894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C59D1409
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E5A1F23A89
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F51BD4F1;
	Mon, 18 Nov 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NnsKopZJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026EC1BD039;
	Mon, 18 Nov 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942362; cv=none; b=ZsUlGo8v49HrA91ehJ3knkDkigdWCMSZ3npJPUL8/OTlEtZzu3wWjyeCey8OJUE/BFc2VMzN06dbhk2DUfoOBpGwgLLZDhA76LWKnAKo7zozDciOkzJwgIJN7DYmprOdouHBCSRmMty2l0ABZGxs7IGybBpcspkAhxWX+NHrYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942362; c=relaxed/simple;
	bh=uASFMIYlxXCE2tOurC30icr+zwWsqeV6DZ2i/n5I3j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXFB4w5DTd2ohx1Eo2CxKu/NwdOxnN55LxkR4fuQUbzbfT4IDXtkqbH5r6x2pOkKDPavdqXhLDGqANSZODXH6hFlBLXqzNMsxFx3RQ3Kmd0bnCpppzZhw3NeUbhgcwlX5+eW7opxZYUII0+Taw1leoxnjVNBym6IYjSrYaSIrlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NnsKopZJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vJGaOP1Bmd6+XnKQeM0q+6LCTgxio3hFolBnH9ao4lw=; b=NnsKopZJmuFeVoD+J+TGP5enSB
	hziRcc/r4Z9zRzICCE9a1jIpDr3E3tFbubjfl2Tw4tAu3dosnC9SibsB7qqNwo6p567i4rbKjQx/Q
	B1idlPpeFadCADWY4ocTVIA6bECa2b7Roq5YL6Pq6zCpsCPS545c0YsKUEh8IKermaA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tD3K5-00DgVf-Px; Mon, 18 Nov 2024 16:05:53 +0100
Date: Mon, 18 Nov 2024 16:05:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mor Nagli <mor.nagli@solid-run.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Message-ID: <8120c842-2205-415e-ab78-24200efe72a3@lunn.ch>
References: <20240505-mv88e6xxx-truncate-busid-v3-1-e70d6ec2f3db@solid-run.com>
 <A40C71BD-A733-43D2-A563-FEB1322ECB5C@gmail.com>
 <c30a0242-9c68-4930-a752-80fb4ad499d9@solid-run.com>
 <20240513083225.1043f59e@kernel.org>
 <14256ba3-b0d5-44e3-9486-1f35233b594c@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14256ba3-b0d5-44e3-9486-1f35233b594c@solid-run.com>

On Mon, Nov 18, 2024 at 02:57:45PM +0000, Josua Mayer wrote:
> Am 13.05.24 um 17:32 schrieb Jakub Kicinski:
> > On Tue, 7 May 2024 12:03:31 +0000 Josua Mayer wrote:
> >>> The idea and implementation is reasonable but this could affect other drivers than mv88e6xxx, why not move that logic to mdiobus_register() and tracking the truncation index globally within the MDIO bus layer?  
> >> Conceptually I agree, it would be nice to have a centralized
> >> solution to this problem, it probably can occur in multiple places.
> >>
> >> My reasoning is that solving the problem within a single driver
> >> is a much smaller task, especially for sporadic contributors
> >> who lack a deep understanding for how all layers interact.
> >>
> >> Perhaps agreeing on a good solution within this driver
> >> can inform a more general solution to be added later.
> > I agree with Florian, FWIW. The choice of how to truncate is a bit
> > arbitrary, if core does it at least it will be consistent.
> 
> Very true.
> 
> However the names themselves are so far generated by each driver,
> if mdiobus_register should define truncation behaviour,
> then the name format must be passed as an argument, too.
> 
> How about adding new properties to mii_bus?
> But then how to pass the variable arguments ....
> 
> Is it acceptable to have variadic function?:
> 
> int __mdiobus_register(struct mii_bus *bus, struct module *owner, const char *name_format, ...);

Probably not. The format string needs to be fully under control and
constant because otherwise it can be abused. If you look around, you
will see patches converting invocations of variadic functions from
(foo), to ("%s", foo), because if foo can be under user control, it
might contain "%s%s%d%x%lld" causing it to access stuff never passed
to it.

	Andrew

