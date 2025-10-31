Return-Path: <netdev+bounces-234654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B0C253A6
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1EB3BBD99
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAC34B409;
	Fri, 31 Oct 2025 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLj9bMbw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BB34D381
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916762; cv=none; b=tS6T2sumqOVjPKwLSAkDtIM6WGbHP4L/pBMTKjMxdiNRV4Yrx/5lAGThOJw8ZUe/T7lpCKbsIN1OXBpT7Dox9S9RRbSvrgivvH5YW9WlB5x72uR20buR6DVZRxYFfFVAgkK9DIQ5EfeTgJJkKaygSLberVGcbolqXa+HTEL8hk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916762; c=relaxed/simple;
	bh=OkpMyqH9LMB5gbHNeVe9QsvLOlwbhxR1aW4ZuqBdvtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKut4yW86No9Io4FN/tTSW/Z8ivkZBXKgUFWI1MMnMetKg3hARAmIPzs6sbqSpJTBJ2yXV2USBz5XBjBthRLCGD8ULZkZaZkFWmEu5x0KPBX5NqNIZe37N1Z6IMPvykc63YLCE5NpLFr7PugCifhR9OAEZfPdCjNF0CIIILkH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLj9bMbw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761916760; x=1793452760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OkpMyqH9LMB5gbHNeVe9QsvLOlwbhxR1aW4ZuqBdvtM=;
  b=GLj9bMbwO6dhXWGNr5Fvvc/LcI0MYSZUKsLnZVwQ1DTAVhvYjAWciAbV
   iWni6hjtmEtPzc4r4bf6JX2MS2bMgd+Q1yM3tXEVcE2tkm8AwLiFQOZ5L
   MJoICE/aDmZzzD3qc1QfmBiILgkZ9/vdl6TtPQ+MLBqOuQ1bLZ81Pkr61
   8NneaI13jXlnenefkPhAi2UehUUpdP0OwsYc7y5yLQVRqFAWL8q1+grxy
   5HIFuB7Bm+n63a4hhGmr/g875BWjclGRnDZsSU6oWXsuYFJ1p/VHyqj+u
   WrhHzYfWqSPuw4cx1E1otcr0zfC89/OZy8q5Ls8jf+uOde/gocLm4Cmde
   g==;
X-CSE-ConnectionGUID: L3ca7GNkQXSMjPJ+qN6lVg==
X-CSE-MsgGUID: 6cx4qruBQXi2/S4qgV5pXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63282040"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63282040"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:19:19 -0700
X-CSE-ConnectionGUID: Bl+i9EzFTE+wfRK/Lq6/pQ==
X-CSE-MsgGUID: akk5Bya7R9yaDhKS6P+3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="209801248"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:19:18 -0700
Date: Fri, 31 Oct 2025 14:17:11 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, jacob.e.keller@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3] ice: use netif_get_num_default_rss_queues()
Message-ID: <aQS216HKiUmF0tky@mev-dev.igk.intel.com>
References: <20251030083053.2166525-1-michal.swiatkowski@linux.intel.com>
 <370cf4f0-c0a8-480a-939d-33c75961e587@molgen.mpg.de>
 <aQMxvzYqJkwNBYf0@mev-dev.igk.intel.com>
 <621665db-e881-4adc-8caa-9275a4ed7a50@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <621665db-e881-4adc-8caa-9275a4ed7a50@intel.com>

On Thu, Oct 30, 2025 at 11:39:30AM +0100, Przemek Kitszel wrote:
> On 10/30/25 10:37, Michal Swiatkowski wrote:
> > On Thu, Oct 30, 2025 at 10:10:32AM +0100, Paul Menzel wrote:
> > > Dear Michal,
> > > 
> > > 
> > > Thank you for your patch. For the summary, I’d add:
> > > 
> > > ice: Use netif_get_num_default_rss_queues() to decrease queue number
> 
> I would instead just say:
> ice: cap the default number of queues to 64
> 
> as this is exactly what happens. Then next paragraph could be:
> Use netif_get_num_default_rss_queues() as a better base (instead of
> the number of CPU cores), but still cap it to 64 to avoid excess IRQs
> assigned to PF (what would leave, in some cases, nothing for VFs).
> 
> sorry for such late nitpicks
> and, see below too

I moved away from capping to 64, now it is just call to
netif_get_num_default_rss_queues(). Following Olek's comment, dividing
by 2 is just fine now and looks like there is no good reasone to cap it
more in the driver, but let's discuss it here if you have different
opinion.

> 
> > > 
> > > Am 30.10.25 um 09:30 schrieb Michal Swiatkowski:
> > > > On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
> > > > Forest) loading ice driver with default values can lead to queue/irq
> > > > exhaustion. It will result in no additional resources for SR-IOV.
> > > 
> > > Could you please elaborate how to make the queue/irq exhaustion visible?
> > > 
> > 
> > What do you mean? On high core system, lets say num_online_cpus()
> > returns 288, on 8 ports card we have online 256 irqs per eqch PF (2k in
> > total). Driver will load with the 256 queues (and irqs) on each PF.
> > Any VFs creation command will fail due to no free irqs available.
> 
> this clearly means this is a -net material,
> even if this commit will be rather unpleasant for backports to stable
>

In my opinion it isn't. It is just about default values. Still in the
described case user can call ethtool -L and lower the queues to create
VFs without a problem.

> > (echo X > /sys/class/net/ethX/device/sriov_numvfs)
> > 
> > > > In most cases there is no performance reason for more than half
> > > > num_cpus(). Limit the default value to it using generic
> > > > netif_get_num_default_rss_queues().
> > > > 
> > > > Still, using ethtool the number of queues can be changed up to
> > > > num_online_cpus(). It can be done by calling:
> > > > $ethtool -L ethX combined $(nproc)
> > > > 
> > > > This change affects only the default queue amount.
> > > 
> > > How would you judge the regression potential, that means for people where
> > > the defaults work good enough, and the queue number is reduced now?
> > > 
> > 
> > You can take a look into commit that introduce /2 change in
> > netif_get_num_default_rss_queues() [1]. There is a good justification
> > for such situation. In short, heaving physical core number is just a
> > wasting of CPU resources.
> > 
> > [1] https://lore.kernel.org/netdev/20220315091832.13873-1-ihuguet@redhat.com/
> > 
> [...]

