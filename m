Return-Path: <netdev+bounces-193399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670EAC3C93
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEE8174AE2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116741E47C7;
	Mon, 26 May 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCANz7P9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC541EF0A6
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251358; cv=none; b=nn+e5sNYoRjEZqVKdnVT4fsXhw6z01E4NaQxI9u8Rp9XvaNaFJ4ahA8EixTtUjtYB38LQENoBpeDnHtehMv4kuoJlccSyBzGnX9CMMDwyfDG5DXtqGsmcZlwAqzc2vxUiGpx5sEqCEDRLvU7G8BrfKbwS/kAw3S3fiYQy4OhvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251358; c=relaxed/simple;
	bh=Kvfl2K0AGpUibx6yxr8eyF6+wHlRK1PTUrTrsumOftM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwJW6s/TAHYgLT9zKTW+JmMwrxrHV1ABQhM2rIGuDMGN0DDjH87Q4Szuf2nSTFkowFy/rfeWl2+tSR3I5yTd+4Tc8vrV5LfUsRNDuk049yrux55pke4pGG307MnKujBQLune4xn8ZDeWYlI3LNeIf/Oc41wMZyMVibGJgJhRu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCANz7P9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748251357; x=1779787357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kvfl2K0AGpUibx6yxr8eyF6+wHlRK1PTUrTrsumOftM=;
  b=MCANz7P9rpYHDH40YAxn3cnH7p4BvQLpY03t6OM04C3V+5PzVueGrFLb
   Dbq8z6fCYxVMeANHyl1CDS+GoweVQHV8PviUSiPiVk5263KUO8KgkquYt
   kX72d+xhoR8RANduiAPWDl/BUXmRZIpG73ePN5472ME4zRcXdqNehtvV2
   Et1mc3oIptbdJlEjZXTmm+s4jmXW9F/ExOD60ORRTNe9Szqr/+2/+vBXM
   huMxBGTD0V8xt9GwiUzROswZ5ZqXZIOulcOMtMtuOvl7CVAXP861riAXF
   Xsww2PhYRH4OTHb2XfcjpBuRsz4QCAupxfFgVG1oEVH1gpLsPmC1JcFA8
   Q==;
X-CSE-ConnectionGUID: w+GBn/ASSQe31QiRSZCQdQ==
X-CSE-MsgGUID: /mi7ue5BT2m81S/v9fwvwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50101229"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="50101229"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:22:26 -0700
X-CSE-ConnectionGUID: NMfEL1aMRXa0AQunRHb6gQ==
X-CSE-MsgGUID: zZ6XwOijSGSfLhL0sRAwqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="173191296"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 26 May 2025 02:22:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 19E1E165; Mon, 26 May 2025 12:22:20 +0300 (EEST)
Date: Mon, 26 May 2025 12:22:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: netdev@vger.kernel.org, michael.jamet@intel.com, YehezkelShB@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <20250526092220.GO88033@black.fi.intel.com>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>

On Mon, May 26, 2025 at 10:50:43AM +0200, Ricard Bejarano wrote:
> Hey, thanks again for looking into this.

No problem.

> Yes, these are 8th generation Intel NUCs with Thunderbolt 3, not 4. And yes, the
> cable I have used so far is Thunderbolt "compatible" not "certified", and it
> doesn't have the lightning logo[1].
> 
> I am not convinced, though.
> 
> Part I: Thunderbolt 3
> ---------------------
> 
> I first ran into this issue a few months ago with a set of 3 12/13th generation
> Intel NUCs, each of which has 2 Thunderbolt 4 ports, directly connected to each
> other so as to form a ring network. When hopping through one of them, bandwidth
> dropped from ~16Gbps to ~5Mbps. Both in routing and bridging. These 3 NUCs are
> in "production" so I didn't want to use them as my test bench. They are rocking
> "Thunderbolt 4 certified" cables with the lightning logo[2].
> 
> I could justify running any one of the following disruptive tests if you think
> they would be helpful:
> 
> Note: A is connected to B, B to C, and C to A (to form a ring).

I suggest keeping the "test case" as simple as possible.

Simple peer-to-peer, no routing nothing. Anything else is making things
hard to debug. Also note that this whole thing is supposed to be used as
peer-to-peer not some full fledged networking solution.

> 1) Configure A and C to route to each other via B if the A<->C link is down,
>    then disconnect A<->C and run iperfs in all directions, like in [4.6].
>    If they run at ~16Gbps when hopping via B, then TB3 was (at least part of)
>    the problem; otherwise it must be something wrong with the driver.
>    I am very confident speed will drop when hopping via B, because this is how I
>    first came across this issue. I wanted nodes of the ring to use the other way
>    around if the direct path wasn't up, but that wasn't possible due to the huge
>    bandwidth drop.
> 
> 2) Same as #1 but configure B to bridge both of its Thunderbolt interfaces.
> 
> 3) While pulling the A<->C cable for running one of the above, test that cable
>    in the 8th gen test bench. This cable is known to run at ~16Gbps when
>    connecting A and C via their Thunderbolt 4 ports.
>    While very unlikely, if this somehow solves the red->purple bandwidth, then
>    we know the current cable was to blame.
> 
> These 12/13th gen NUCs are running non-upstream kernels, however, and while I
> can justify playing around a bit with their connections, I can't justify pulling
> them out of production to install upstream kernels and make them our test bench.
> 
> Do you think anyone of these tests would be helpful?

Let's forget bridges for now and anything else than this:

  Host A <- Thunderbolt Cable -> Host B

> Part II: the cable
> ------------------
> 
> You also point to the cable as the likely culprit.
> 
> 1) But then, why does iperf between red<->blue[4.6.1] show ~9Gbps both ways, but
>    red->blue->purple[4.6.3a] drops to ~5Mbps? If the cable were to blame,
>    wouldn't red->blue[4.6.1a] also drop to about the same?

I'm saying two things that will for sure limit the maximum throughput you
get for a fact:

 1. You use non-certified cables, so your are limited to 10 Gb/s per lane
    instead of 20 Gb/s per lane.

 2. Your system has firmware connection manager which does not support lane
    bonding so instead of your 2 x 10 Gb/s = 20 Gb/s you only get the 1 x 10
    Gb/s.

It is enough if one of the hosts has these limitations it will affect the
whole link. So instead of 40 Gb/s with lane bonding you get 10 Gb/s
(although there are some limitations in the DMA side so you don't get the
full 40 Gb/s but certainly more than what the 10 Gb/s single lane gives
you).

> 2) Also, if the problem were the cable's bandwidth in the red->blue direction,
>    flipping the cable around should show a similar bandwidth drop in the (now)
>    blue->red direction, right?
>    I have tested this and it doesn't hold true, iperfs in all directions after
>    flipping the cable around gave about the same results as in [4.6], further
>    pointing at something else other than the cable itself.

You can check the link speed using the tool I referred. It may be that
sometimes it manages to negotiate the 20 Gb/s link but sometimes not.

> I've attached the output of 'tblist -Av'. It shows negotiated speed at 10Gb/s in
> both Rx/Tx, which lines up with the red<->blue iperf bandwidth tests of [4.6.1].

You missed the attachment? But anyways as I suspected it shows the same.

> How shall we proceed?

Well, if the link is degraded to 10 Gb/s then I'm not sure there is
nothing more I can do here.

If it is not the case, e.g you see that the link is 40 Gb/s but you still
see crappy throughput the we need to investigate (but keep the topology as
simple as possible). Note in this case please provide full dmesg (with
thunderbolt.dyndbg=+p) on both sides of the link and I can take a look.

