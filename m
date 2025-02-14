Return-Path: <netdev+bounces-166301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E6AA35680
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202913AC591
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0311891AA;
	Fri, 14 Feb 2025 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeVaPbT9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D4155743
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739511919; cv=none; b=ciEuzf4EW1r5WY9ipK6p5rmE4VPmW122oP/KJJxD483SbvqIKGgpN+yxbXnwrireqz/iW1KjShpCf56w3LY5pksMX0KPSzI0DQWUoC36FZQhfAE38LQuo9LWkk3tFqGYJM/nRYiSZMLoQK1oK2tRtnv8gDnhiDUVRaGRtM2C/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739511919; c=relaxed/simple;
	bh=WkDTYJr0mQ8LaGzM86s/k8BZhKOQcrJIJdVs6kspsYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcDjvvqDqC3vzIxmAMH5gq/UxG65d5YS/BTU9v6gyX2TtsZ04knM2Qmd9RevfzELJ8diLwG8hxr3JmR5UVqo2SN01t0Nw4bcHbo2QEXcehpJ1bsBJct0+UzSnQvKibqQwNI+yah4QiDS3iPxcl/kFu7bM7Vy7K3x9+BP4fVsdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeVaPbT9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739511918; x=1771047918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkDTYJr0mQ8LaGzM86s/k8BZhKOQcrJIJdVs6kspsYA=;
  b=OeVaPbT9uak7J2+duIDsuY1easuelkOuwdcIu/VsyjkQejcjWovMrQbt
   9n0bIaYV9o/1yfbTjEiBE3l4HUFGXXIemfAHW1vUpqzFBNPAYUwdv7OwX
   KJmGVVIb+Ia0qCXkOjfw5SDBqh5VVx0s7lo++QgcGYMOgO/p9HDqOxB2l
   wfojezoALAfhGwxapUY38UE9JUtOg13U76WHw+qgeXAgAPq88PZNjmJsE
   RGgFJ7TVBDZQbgT/6gUHG/thtuNJiWemMlB0t/+h1okpg7OVInUtBdD0l
   C03js4rUwUCxuVgZ4dVYNuXBT1FcaaNihdmiZp4FKD5z7F+Y5AYnrspob
   w==;
X-CSE-ConnectionGUID: e4GLbs9NTFugyoUxwa8lRw==
X-CSE-MsgGUID: g2sZaYTkSDydMQBWqdScXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39955443"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="39955443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 21:45:16 -0800
X-CSE-ConnectionGUID: X3ElYp6mRuamoI8ErGA/tQ==
X-CSE-MsgGUID: WPA/9lNuTzGl0YLZ3L8yDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113226630"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 21:45:12 -0800
Date: Fri, 14 Feb 2025 06:41:35 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, himasekharx.reddy.pucha@intel.com,
	pmenzel@molgen.mpg.de, marcin.szycik@intel.com,
	netdev@vger.kernel.org, rafal.romanowski@intel.com,
	konrad.knitter@intel.com, pawel.chmielewski@intel.com,
	horms@kernel.org, David.Laight@aculab.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, pio.raczynski@gmail.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	jiri@resnulli.us, przemyslaw.kitszel@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-next v9 5/9] ice, irdma: move interrupts
 code to irdma
Message-ID: <Z67XjwByeVSuLooq@mev-dev.igk.intel.com>
References: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
 <20241203065817.13475-6-michal.swiatkowski@linux.intel.com>
 <8e533834-4564-472f-b29b-4f1cb7730053@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e533834-4564-472f-b29b-4f1cb7730053@linux.intel.com>

On Thu, Feb 13, 2025 at 08:20:31PM +0100, Marcin Szycik wrote:
> 
> 
> On 03.12.2024 07:58, Michal Swiatkowski wrote:
> > Move responsibility of MSI-X requesting for RDMA feature from ice driver
> > to irdma driver. It is done to allow simple fallback when there is not
> > enough MSI-X available.
> > 
> > Change amount of MSI-X used for control from 4 to 1, as it isn't needed
> > to have more than one MSI-X for this purpose.
> 
> Hi, I'm observing KASAN reports or kernel panic when attempting to remove irdma
> with this patchset, most probably this patch being the culprit, since it touches
> functions from splat.
> 
> Reproducer:
>   sudo rmmod irdma
> 
> Minified splat(s):
>   BUG: KASAN: use-after-free in irdma_remove+0x257/0x2d0 [irdma]
>   Call Trace:
>    <TASK>
>    ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>    ? kfree+0x253/0x450
>    ? irdma_remove+0x257/0x2d0 [irdma]
>    kasan_report+0xed/0x120
>    ? irdma_remove+0x257/0x2d0 [irdma]
>    irdma_remove+0x257/0x2d0 [irdma]
>    auxiliary_bus_remove+0x56/0x80
>    device_release_driver_internal+0x371/0x530
>    ? kernfs_put.part.0+0x147/0x310
>    driver_detach+0xbf/0x180
>    bus_remove_driver+0x11b/0x2a0
>    auxiliary_driver_unregister+0x1a/0x50
>    irdma_exit_module+0x40/0x4c [irdma]
>   
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:ice_free_rdma_qvector+0x2a/0xa0 [ice]
>   Call Trace:
>    ? ice_free_rdma_qvector+0x2a/0xa0 [ice]
>    irdma_remove+0x179/0x2d0 [irdma]
>    auxiliary_bus_remove+0x56/0x80
>    device_release_driver_internal+0x371/0x530
>    ? kobject_put+0x61/0x4b0
>    driver_detach+0xbf/0x180
>    bus_remove_driver+0x11b/0x2a0
>    auxiliary_driver_unregister+0x1a/0x50
>    irdma_exit_module+0x40/0x4c [irdma]

Thanks, I will work on it.

> 

