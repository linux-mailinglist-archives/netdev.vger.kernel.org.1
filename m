Return-Path: <netdev+bounces-200417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9270AE578E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B05A4E1962
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9B218596;
	Mon, 23 Jun 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zS4OurQO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2703594B;
	Mon, 23 Jun 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718732; cv=none; b=Lxcq6Ehb0C62FvmjbLQdovxEKI3FAewPgjuNO70/smVY5K9MwIVkZRkBWDgeYQ+PAFsTiESgfu7m91Msy2vkEZr337zWyrOBaapFbsDNogHltbCKoTuZbUYC4Rlk2pXeBauGuGrjWNhdMr9+FMb5HnYx2ouaD1SUWeOkYYNBxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718732; c=relaxed/simple;
	bh=CeO8AY4lnLWCMgU1gN94LRHZAB8UqehzLbM0fBlC9DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpHQqqMdAy5MD40E6cY8C0z4cjb0SsMplX5KySS5VsnR3SV9OPDcwpCAvIv9MVkNgIw0M0Jb8PQUFCz7tIm7nyMhf6pcKM9uDLficJ7Woq/3vj29N25IoHey5D5jl+JeNmwUIE1UlN7vdVv6SkRqhwLYIlGfU+aG6MRkhuR+LKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zS4OurQO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CHdSNTwyhEj3ZOnn8e0uBB6QJpASsij9hXSlRqn95gA=; b=zS4OurQOgKjixDkTZUxxvRu1MV
	cdvpkvkICmkHHCwoGqsknSGMpLlkE+f2CHsH1GUTo+zHMFyt7HiJiDwUxjvk4ckGiGAhhp5uNT6yG
	F16tQKiX5GaqxW2XIWe8IRjvrgPKywJIstwjT9jHUCiiul80dG5BXcawhVwVujbdZbSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTpuc-00Gjnq-Lj; Tue, 24 Jun 2025 00:45:14 +0200
Date: Tue, 24 Jun 2025 00:45:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
Message-ID: <3e2acebe-a9db-494b-bca8-2e1bbc3c1eaf@lunn.ch>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-5-sean.anderson@linux.dev>
 <16ebbe27-8256-4bbf-ad0a-96d25a3110b2@lunn.ch>
 <0854ddee-1b53-472c-a4fe-0a345f65da65@linux.dev>
 <c543674a-305e-4691-b600-03ede59488ef@lunn.ch>
 <a8a3e849-bef9-4320-8b32-71d79afbab87@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a3e849-bef9-4320-8b32-71d79afbab87@linux.dev>

On Mon, Jun 23, 2025 at 02:48:53PM -0400, Sean Anderson wrote:
> On 6/23/25 14:27, Andrew Lunn wrote:
> > On Mon, Jun 23, 2025 at 11:16:08AM -0400, Sean Anderson wrote:
> >> On 6/21/25 03:33, Andrew Lunn wrote:
> >> > On Thu, Jun 19, 2025 at 04:05:37PM -0400, Sean Anderson wrote:
> >> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
> >> >> probe loop if the EPROBE_DEFER error is never resolved.
> >> > 
> >> > That sounds like a core problem. I also thought there was a time
> >> > limit, how long the system will repeat probes for drivers which defer.
> >> > 
> >> > This seems like the wrong fix to me.
> >> 
> >> I agree. My first attempt to fix this did so by ignoring deferred probes
> >> from child devices, which would prevent "recursive" loops like this one
> >> [1]. But I was informed that failing with EPROBE_DEFER after creating a
> >> bus was not allowed at all, hence this patch.
> > 
> > O.K. So why not change the order so that you know you have all the
> > needed dependencies before registering the MDIO bus?
> > 
> > Quoting your previous email:
> > 
> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
> >> probe loop if the EPROBE_DEFER error is never resolved. For example,
> >> if the PCS is located on another MDIO bus and that MDIO bus is
> >> missing its driver then we will always return EPROBE_DEFER.
> > 
> > Why not get a reference on the PCS device before registering the MDIO
> > bus?
> 
> Because the PCS may be on the MDIO bus. This is probably the most-common
> case.

So you are saying the PCS is physically there, but the driver is
missing because of configuration errors? Then it sounds like a kconfig
issue?

Or are you saying the driver has been built but then removed from
/lib/modules/

	Andrew


