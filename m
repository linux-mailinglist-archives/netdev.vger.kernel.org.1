Return-Path: <netdev+bounces-96539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDC8C6649
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084F81F22DB6
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2047441E;
	Wed, 15 May 2024 12:20:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD566EB53;
	Wed, 15 May 2024 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775647; cv=none; b=N6GY1coylB1dcMG1zDhLhX5hklDmzulnDFnL9ZYpn2fzdJAQcdSJ6wXg5wqzQG03ETobdRaR4/3f0qYWJCU8raAO3JBeG66Er7fiKc1to2et0ljExhkzq+NvHjV9Kg+iUNfVOHYICp+LZJEGBj8l6Dgfs4NAWnPnIKp9Kb/04xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775647; c=relaxed/simple;
	bh=/KIIAnKcW2LATTgVf8NIIEsGe9tGj9gkpnTjHQdczf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZB2a8Dm4nhfJ5BAvyacXMk7HmOLFzaXuAxmVYqk4YKybg6JOyh3qBV8ZfIAywcqFtIsX61hBGHE3MHgPRbY3KlTb3u2J6o1mrGh3N/wcassAA66vu+96jA5T6Gy6zsgFfQ+TDRtFdx5jmFhzII2SKi1cfzy6w3UOYwWRsHU+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1s7DEb-00D1eo-Ak; Wed, 15 May 2024 13:55:49 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.97)
	(envelope-from <laforge@gnumonks.org>)
	id 1s7DEV-00000003YLY-056H;
	Wed, 15 May 2024 13:55:43 +0200
Date: Wed, 15 May 2024 13:55:42 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v6 00/21] ice: add PFCP filter support
Message-ID: <ZkSivjg7uZsA20ft@nataraja>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>

Daer Alexander, Wojciech,

forgive me for being late to the party, but I just saw the PFCP support
hitting Linus'' git repo in 1b294a1f35616977caddaddf3e9d28e576a1adbc
and was trying to figure out what it is all about.  Is there some kind
of article, kernel documentation or other explanation about it?

I have a prehistoric background in Linux kernel networking, and have
been spending much of the last two decades in creating open source
implemenmtations of 3GPP specifications.

So I'm very familiar with what PFCP is, and what it does, and how it is
used as a protocol by the 3GPP control plane to control the user/data
plane.

Conceptually it seems very odd to me to have something like *pfcp
net-devices*.  PFCP is just a control plane protocol, not a tunnel
mechanism.

From the Kconfig:

> +config PFCP
> +	tristate "Packet Forwarding Control Protocol (PFCP)"
> +	depends on INET
> +	select NET_UDP_TUNNEL
> +	help
> +	  This allows one to create PFCP virtual interfaces that allows to
> +	  set up software and hardware offload of PFCP packets.

I'm curious to understand why are *pfcp* packets hardware offloaded?
PFCP is just the control plane, similar to you can consider netlink the
control plane by which userspace programs control the data plane.

I can fully understand that GTP-U packets are offloaded to kernel space or
hardware, and that then some control plane mechanism like PFCP is needed
to control that data plane.  But offloading packets of that control
protocol?

I also see the following in the patch:

> +MODULE_DESCRIPTION("Interface driver for PFCP encapsulated traffic");

PFCP is not an encapsulation protocol for user plane traffic.  It is not
a tunneling protocol.  GTP-U is the tunneling protocol, whose
implementations (typically UPFs) are remote-controlled by PFCP.

> +	  Note that this module does not support PFCP protocol in the kernel space.
> +	  There is no support for parsing any PFCP messages.

If I may be frank, why do we introduce something called "pfcp" to the
kernel, if it doesn't actually implement any of the PFCP specification
3GPP TS 29.244 (which is specifying a very concrete protocol)?

Once again, I just try to understand what you're trying to do here. It's
very much within my professional field, but I somehow cannot align what
I see within this patch set with my existing world view of what PFCP is
and how it works.

If anyone else has a better grasp of the architecture of this kernel
PFCP support, or has any pointers, I'd be very happy to follow up
on that.

Thanks for your time,
	Harald

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

