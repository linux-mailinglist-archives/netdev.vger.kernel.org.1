Return-Path: <netdev+bounces-96719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCF8C74D0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 12:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33039B2578C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB6145347;
	Thu, 16 May 2024 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWCFE3h/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9B1459E7;
	Thu, 16 May 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856292; cv=none; b=GTrfC85OyQgWryIwjB0bz6pz7pejACS490aUH8ltdurB0ePMDp47iMVrWh0mbhhgknBQBs763PlR6v5WSZHe//FqC9Z/KdwIJHaivaCMlQZCx/7i0aZnMT6c+V3psw8JGaO6zi8otTHvyHETafN0gh3jfiCVXtj7iIoQ72yH73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856292; c=relaxed/simple;
	bh=qS3BQVM65ikytVxg+vUaAJl6zot53RNMbcABisDLmAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeLlobXaqiaAIeoxb9X/fc8dhh72b9SLSnrivPovUZXXfCgg6KHaCLb0/D7uivmuHoWeAppPXVtAH9q9kMRPfKFs6z3Xevp+kvySPgRazRGT0By/HMSUgLTJMK2dhtTfGCiBEYbY4AK+0ymlOfTbCa24w54Ki7OzLLFfVroMWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWCFE3h/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715856290; x=1747392290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qS3BQVM65ikytVxg+vUaAJl6zot53RNMbcABisDLmAo=;
  b=MWCFE3h/HDtechq24Sd3F51aeTUVLTAScDhey8TcWbuu4a/7UxiISxml
   /VBSpCaJY00wOEyKMmB8dCRnicEZN8c/YTPNmPtP7gkjdeU4OcDmn1Nhr
   y7blHJrm++KhAFN34nvnD+L5N9WhCeFw3bsIQLegu8QSV59/vfZ+tZqbC
   0XGd36gRHBdsK/07Q/wpqxDs/M5VKj3xRvwuE4TKqUR+Vh09/zfACuhBH
   B1nmaiX+Uv61IbayaIw8IkTmRFDvG2ePK8iJYQz+MndjOsx/UZLYnIsvv
   HHlh1mfEd5qPL/6A5ima1Tp6DFIRooFjvhskXfz1KUVMBqGZX+vUc1g32
   w==;
X-CSE-ConnectionGUID: /w7R8K5OTDeDrJqe2XoIdg==
X-CSE-MsgGUID: Oz0HWs4cTNawcPedAV57ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23359552"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23359552"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:44:50 -0700
X-CSE-ConnectionGUID: wjKu3xKkQ3yH316fiCEIWA==
X-CSE-MsgGUID: cNzrnd0JQN2kqljDpR/TxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35822114"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:44:48 -0700
Date: Thu, 16 May 2024 12:44:13 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 00/21] ice: add PFCP filter
 support
Message-ID: <ZkXjfeLhB9T5MLfX@mev-dev>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
 <ZkSivjg7uZsA20ft@nataraja>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkSivjg7uZsA20ft@nataraja>

On Wed, May 15, 2024 at 01:55:42PM +0200, Harald Welte wrote:
> Daer Alexander, Wojciech,

Hi Harald,

> 
> forgive me for being late to the party, but I just saw the PFCP support
> hitting Linus'' git repo in 1b294a1f35616977caddaddf3e9d28e576a1adbc
> and was trying to figure out what it is all about.  Is there some kind
> of article, kernel documentation or other explanation about it?
> 
> I have a prehistoric background in Linux kernel networking, and have
> been spending much of the last two decades in creating open source
> implemenmtations of 3GPP specifications.
> 
> So I'm very familiar with what PFCP is, and what it does, and how it is
> used as a protocol by the 3GPP control plane to control the user/data
> plane.
> 
> Conceptually it seems very odd to me to have something like *pfcp
> net-devices*.  PFCP is just a control plane protocol, not a tunnel
> mechanism.
> 
> From the Kconfig:
> 
> > +config PFCP
> > +	tristate "Packet Forwarding Control Protocol (PFCP)"
> > +	depends on INET
> > +	select NET_UDP_TUNNEL
> > +	help
> > +	  This allows one to create PFCP virtual interfaces that allows to
> > +	  set up software and hardware offload of PFCP packets.
> 
> I'm curious to understand why are *pfcp* packets hardware offloaded?
> PFCP is just the control plane, similar to you can consider netlink the
> control plane by which userspace programs control the data plane.
> 
> I can fully understand that GTP-U packets are offloaded to kernel space or
> hardware, and that then some control plane mechanism like PFCP is needed
> to control that data plane.  But offloading packets of that control
> protocol?

It is hard for me to answer your concerns, because oposite to you, I
don't have any experience with telco implementations. We had client that
want to add offload rule for PFCP in the same way as for GTP. Intel
hardware support matching on specific PFCP packet parts. We spent some
time looking at possible implementations. As you said, it is a little
odd to follow the same scheme for GTP and PFCP, but it look for me like
reasonable solution.

The main idea is to allow user to match in tc flower on PFCP specific
parts. To do that we need PFCP device (which is like dummy device for
now, it isn't doing anything related to PFCP specification, only parsing).

Do you have better idea for that?

> 
> I also see the following in the patch:
> 
> > +MODULE_DESCRIPTION("Interface driver for PFCP encapsulated traffic");
> 
> PFCP is not an encapsulation protocol for user plane traffic.  It is not
> a tunneling protocol.  GTP-U is the tunneling protocol, whose
> implementations (typically UPFs) are remote-controlled by PFCP.
> 

Agree, it is done like that to simplify implementation and reuse kernel
software stack.

> > +	  Note that this module does not support PFCP protocol in the kernel space.
> > +	  There is no support for parsing any PFCP messages.
> 
> If I may be frank, why do we introduce something called "pfcp" to the
> kernel, if it doesn't actually implement any of the PFCP specification
> 3GPP TS 29.244 (which is specifying a very concrete protocol)?
> 
> Once again, I just try to understand what you're trying to do here. It's
> very much within my professional field, but I somehow cannot align what
> I see within this patch set with my existing world view of what PFCP is
> and how it works.
> 
> If anyone else has a better grasp of the architecture of this kernel
> PFCP support, or has any pointers, I'd be very happy to follow up
> on that.

This is the way to allow user to steer PFCP packet based on specific
opts (type and seid) using tc flower. If you have better solution for
that I will probably agree with you and will be willing to help you
with better implementation.

I assume the biggest problem here is with treating PFCP as a tunnel
(done for simplification and reuse) and lack of any functionality of
PFCP device (moving the PFCP specification implementation into kernel
probably isn't good idea and may never be accepted).

Offloading doesn't sound like problematic. If there is a user that want
to use that (to offload for better performance, or even to steer between
VFs based on PFCP specific parts) why not allow to do that?

In your opinion there should not be the pfcp device in kernel, or the
device should have more functionality (or any functionality, because now
it is only parsing)?

> 
> Thanks for your time,
> 	Harald
>

Thanks,
Michal

> -- 
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
> ============================================================================
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. A6)

