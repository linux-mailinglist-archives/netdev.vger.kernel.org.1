Return-Path: <netdev+bounces-186041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04CA9CDFA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 18:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D491E1BC8093
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 16:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA30198E9B;
	Fri, 25 Apr 2025 16:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca [129.97.134.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F514F9EB;
	Fri, 25 Apr 2025 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.97.134.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598169; cv=none; b=DAd8YK4Zcan6x+psg9ByCOMa451Bvjs9ZiXhbAtv6o6GjbdKL3llSzrnLYH4QW+Mkf/e09e4Z/x2Z/Z2i+dZ78EGUwrbLD2P5B/KdHl6rk+y/PTTpAvCF1iAVuCmdHOf3a6Wzky7mpO5wbgMIUg+eB5Xadp88AXkGvOdur+nK30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598169; c=relaxed/simple;
	bh=IBGf9HERTYTA0SschADqKfc+VU/xdv9jMJ6ICrEjo1o=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=GhGjLu/k8P9tuILTylNGBl/hLOdkTGm4n6oQe7le/kHNoemuYJDxKPN4uGXEqrz14g+H6abLnh1uFOjsNFhlM/uOlPgC7Vgxgy2EolJpPS1O2DI8LD5tswmp6hEImsDyWoiuUFrG8ah+HRpvHq7Z0SNFDAHSoDLkP3AQ5cccE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csclub.uwaterloo.ca; spf=pass smtp.mailfrom=csclub.uwaterloo.ca; arc=none smtp.client-ip=129.97.134.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csclub.uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csclub.uwaterloo.ca
Received: by caffeine.csclub.uwaterloo.ca (Postfix, from userid 20367)
	id 34A7C460021; Fri, 25 Apr 2025 12:22:38 -0400 (EDT)
Date: Fri, 25 Apr 2025 12:22:38 -0400
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>
Subject: Re: Fix promiscous and multicast mode on iavf after reset
Message-ID: <aAu2zoNIuRk-nwWt@csclub.uwaterloo.ca>
References: <aAkflkxbvC8MB8PG@csclub.uwaterloo.ca>
 <8236bef5-d1e3-42ab-ba1f-b1d89f305d0a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8236bef5-d1e3-42ab-ba1f-b1d89f305d0a@intel.com>
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

On Thu, Apr 24, 2025 at 02:59:38PM -0700, Jacob Keller wrote:
> 
> 
> On 4/23/2025 10:12 AM, Lennart Sorensen wrote:
> > I discovered that anything that causes a reset in iavf makes breaks
> > promiscous mode and multicast.  This is because the host side ice
> > driver clears the VF from filters when it is reset.  iavf then correctly
> > calls iavf_configure, but since the current_netdev_promisc_flags already
> > match the netdev promisc settings, nothing is done, so the promisc and
> > multicast settings are not sent to the ice host driver after the reset.
> > As a result the iavf side shows promisc enabled but it isn't working.
> > Disabling and re-enabling promisc on the iavf side fixes it of course.
> > Simple test case to show this is to enable promisc, check that packets
> > are being seen, then change the mtu size (which does a reset) and check
> > packets received again, and promisc is no longer active.  Disabling
> > promisc and enabling it again restores receiving the packets.
> > 
> > The following seems to work for me, but I am not sure it is the correct
> > place to clear the saved flags.
> > 
> > diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > index 6d7ba4d67a19..4018a08d63c1 100644
> > --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> > +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> > @@ -3233,6 +3233,14 @@ static void iavf_reset_task(struct work_struct *work)
> >  		iavf_shutdown_adminq(hw);
> >  		iavf_init_adminq(hw);
> >  		iavf_request_reset(adapter);
> > +
> > +		/* Clear remembered promisc and multicast flags since
> > +		 * reset clears them on the host so they will get force
> > +		 * applied again through iavf_configure() down below.
> > +		 */
> > +		spin_lock_bh(&adapter->current_netdev_promisc_flags_lock);
> > +		adapter->current_netdev_promisc_flags &= ~(IFF_PROMISC | IFF_ALLMULTI);
> > +		spin_unlock_bh(&adapter->current_netdev_promisc_flags_lock);
> >  	}
> >  	adapter->flags |= IAVF_FLAG_RESET_PENDING;
> >  
> > 
> 
> We probably need to do something similar in the flow where we get an
> unexpected reset (such as if PF resets us by changing trusted flag or
> other state).
> 
> I don't think there's a better solution. Arguably the PF shouldn't be
> losing data, but I think its a bit late to go that route at this point..
> Its pretty baked into the virtchnl API :(

Yeah I can see arguments that calling reset should put everything in a
known state so the VF driver can configure things as it wants, but since
reset is also used when tx hang happens or mtu changes and various other
things, it is definitely inconvinient.  Changing behaviour with an API
version change seems ugly too and you would still have to support the
old API anyhow.  I suppose having a reset fully to defaults and a soft
reset to change settings but keep other values could have been nice,
but a bit late now.  Some VF drivers may even be depending on the reset
putting everything to defaults.

If someone that knows the driver better can make a complete fix that
would be great.  So far this small change appears to be working but I
could certainly have missed some cases.  It took quite a bit of debugging
to discover why promiscous mode on the VF side was so unreliable and
unpredicable.  Due to the somewhat asynchrounous message handling,
sometimes the reset would not happen until after the promisc setting
had been applied, and then it was silently lost, while other times it
would do the reset quicker and then the promisc setting would work.
Very confusing to debug.

-- 
Len Sorensen

