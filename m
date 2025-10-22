Return-Path: <netdev+bounces-231555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFDBFA7A6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 082334E3733
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C682EBBAC;
	Wed, 22 Oct 2025 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZSl421E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602C1C8606
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117113; cv=none; b=ehWVm3sYtz75EFcjS20gLN4fzZ0WeuoVEWrGJhFFd4EjSgubn3+T5ArUDxYpQJVXaAuRG3NDYeELBB4mqpQrIorK75wpgpW49szZOYIWv+5D/kbnNE6VxfvPq4sG5cTHT/ASD2i/BEb7dZ0sUGJ98940z7GXQAtaH0g2dr/FyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117113; c=relaxed/simple;
	bh=KS5mjdbhibr4HOupBrT/VG3rdVqHnXLAHbIdQ5ZRfFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOaAcexMqzh6g+TzLlWvTe84lsQixnqHirkV4xcy+SeDsoBhls0QW/kztODlf1jy1r311gswtfPT5IbLq8ygoq2pbVTTHjK1kdu4cdt+wuLYr2WydDIpY7CBuQb+Nuy1Idl39RxV35wYR+VQU/3RHp+xn0NEabndAcDM0T1C32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZSl421E; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761117111; x=1792653111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KS5mjdbhibr4HOupBrT/VG3rdVqHnXLAHbIdQ5ZRfFQ=;
  b=DZSl421EDToCD5vxs+JcddNAfHD0ZgJqFZnWSyl34/nrNJPCqeZe2Rpr
   5UH5ByT9kT6sGvWa4xcW0BADoET0m2KrIpvifhh1Y2x/B9RkLbZ6x/K2n
   Bn9+uejoNsvAV5c+3pikk0qJPAOe9dpsttP+BmFgbHA2VBt2Vy4pLuaxq
   +vzkb4ogmEp8j20F5ZzgpX4ARks3aOTXLq5CsM+/sHeFHyxDmQt2fgNs1
   6jxYG0hteCzT/rbB3jW+N9jRzoARSNlQPammJlDoArwdcBX5G9ht1R/t9
   c2pEEINcFHMc7EMBIHrhVOH1NtIqoYFfdChqjsZXmd7KU9dNK1TDx7myQ
   A==;
X-CSE-ConnectionGUID: dcA9lJ2iRLWoFDUPAz3IWw==
X-CSE-MsgGUID: 6DCs7vQdTGq84JtxouaZtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50829698"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="50829698"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:11:50 -0700
X-CSE-ConnectionGUID: tHqeaaMNQ5y4jCd4+9wtmQ==
X-CSE-MsgGUID: fMEck10fSfGswxyfgQEXIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183381090"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 00:11:49 -0700
Date: Wed, 22 Oct 2025 09:09:42 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: lower default
 irq/queue counts on high-core systems
Message-ID: <aPiDNooOaHEtmQPI@mev-dev.igk.intel.com>
References: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
 <5d739d1f-faa7-4734-b5e7-8e35b5556ce7@intel.com>
 <34268765-6cc5-4816-9ba7-4f00e8f353a0@intel.com>
 <aPHwpE+YuxfWZjft@mev-dev.igk.intel.com>
 <b1faad7b-531b-429f-97a4-aa93a160569c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1faad7b-531b-429f-97a4-aa93a160569c@intel.com>

On Fri, Oct 17, 2025 at 04:35:18PM +0200, Alexander Lobakin wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Date: Fri, 17 Oct 2025 09:30:44 +0200
> 
> > On Fri, Oct 17, 2025 at 07:03:31AM +0200, Przemek Kitszel wrote:
> >> On 10/16/25 17:36, Alexander Lobakin wrote:
> >>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >>> Date: Thu, 16 Oct 2025 08:22:50 +0200
> >>>
> >>>> On some high-core systems loading ice driver with default values can
> >>>> lead to queue/irq exhaustion. It will result in no additional resources
> >>>> for SR-IOV.
> >>>>
> >>>> In most cases there is no performance reason for more than 64 queues.
> >>>> Limit the default value to 64. Still, using ethtool the number of
> >>>> queues can be changed up to num_online_cpus().
> >>>>
> >>>> This change affects only the default queue amount on systems with more
> >>>> than 64 cores.
> >>>>
> >>>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> >>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >>>> ---
> >>>>   drivers/net/ethernet/intel/ice/ice.h     | 20 ++++++++++++++++++++
> >>>>   drivers/net/ethernet/intel/ice/ice_irq.c |  6 ++++--
> >>>>   drivers/net/ethernet/intel/ice/ice_lib.c |  8 ++++----
> >>>>   3 files changed, 28 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> >>>> index 3d4d8b88631b..354ec2950ff3 100644
> >>>> --- a/drivers/net/ethernet/intel/ice/ice.h
> >>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
> >>>> @@ -1133,4 +1133,24 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
> >>>>   	else
> >>>>   		return &pf->adapter->ctrl_pf->hw;
> >>>>   }
> >>>> +
> >>>> +/**
> >>>> + * ice_capped_num_cpus - normalize the number of CPUs to a reasonable limit
> >>>> + *
> >>>> + * This function returns the number of online CPUs, but caps it at suitable
> >>>> + * default to prevent excessive resource allocation on systems with very high
> >>>> + * CPU counts.
> >>>> + *
> >>>> + * Note: suitable default is currently at 64, which is reflected in default_cpus
> >>>> + * constant. In most cases there is no much benefit for more than 64 and it is a
> >>>> + * power of 2 number.
> >>>> + *
> >>>> + * Return: number of online CPUs, capped at suitable default.
> >>>> + */
> >>>> +static inline u16 ice_capped_num_cpus(void)
> >>>> +{
> >>>> +	const int default_cpus = 64;
> >>>
> >>> Maybe we should just use netif_get_num_default_rss_queues() like I did
> >>> in idpf?
> >>>
> >>> Or it still can be too high e.g. on clusters with > 256 CPUs?
> >>
> >> good point,
> >> perhaps we should both use it and change the (kernel) func to cap at 64
> >>
> > 
> > Sounds good, thanks for pointing the function.
> > 
> > Do you think it is ok to cap the generic function? Maybe other vendors
> > want more default queues.
> 
> Nah I don't think it's a good idea to hardcode any numbers in the
> generic function.
> 
> > 
> > What about capping netif_get_num_default_rss_queues() at 64 just for
> > ice?
> 
> netif_get_num_default_rss_queues() returns *half* of the number of
> *physical* cores. I.e. it will return something bigger than 64 only in
> case of > 256 threads in the system (considering SMT).
> 
> Do we need to still cap this to 64 in ice at all?

That can be good enough. I will send next version with just call to this
function.

> 
> Thanks,
> Olek

