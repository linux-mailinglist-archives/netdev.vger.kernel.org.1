Return-Path: <netdev+bounces-229935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BBBE236D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD919C0279
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0BB212FAA;
	Thu, 16 Oct 2025 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zi4/jLJp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBBE218599
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604439; cv=none; b=KLQnOVYPSKPqMlSpKf4CLUBhXT1E2OoTtZge2+qX47/oMKwx2Yzq9sPeWyR8t5EKikUhhxt+faS1Cuhb0x0wu5DQTikkjGvCKSuvbR6doh4VD8ATRDXaXngC0inXBoRtbexxK3PjTNgnpXVSVpGKS7OF9xOdJdsOJF3X5KDOWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604439; c=relaxed/simple;
	bh=lxdA3Rgx7Td+RdMxZKNp62JHMDC6fzh4XBD0nugmcMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or7hzbo+C/Ki50JqTtIRsR55ZXNCuw0IiRLlFm/6o3e+/WtYHu0K3AcJSxcDEtq/Hvn7rFQiNW2G9aimOfGMLN8Wj2oy5kNvKYDt9I5yOCf1i6moqLHgUkgCHEdeQM4GdhSXnZ3vQYjtqlGTi6pEuWNfuCNYIF1mrxn7sXBxN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zi4/jLJp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760604437; x=1792140437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lxdA3Rgx7Td+RdMxZKNp62JHMDC6fzh4XBD0nugmcMM=;
  b=Zi4/jLJpeC5fiCvnJI9WmFwsTtb64fTcZEEMrDr8EWJfTDhfMIQBovDy
   b47OMf/QQd+1kRLKJ3Mf9O5XHT0vTXzQbijDSg96K4PMUaMep+M5J2WSP
   0ijew0TDJc2kgMJawi2fDCk49GoNnabDVDxJH64xaeDv5tGCzxz9sGVl8
   Nun9cr4UlYfOHF3n/swYB/fCItZvHc/dTrGWnob8e8AeiiqH1RaTLnimS
   X3AtjWXDGcM0pVJIzivyA9drDbbhAydyERSHXcKLoszl/yTKqzPQ8J5nq
   XOGPTme9zV2jYFH789mCWEIbYO7WR2kRU7LluOvgqKm5Slz2Byyd1fq0c
   w==;
X-CSE-ConnectionGUID: 9cfN/VWESlS0a3xOh0wiPQ==
X-CSE-MsgGUID: +gJlzxBNSym1/4PoqqqsrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62830856"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="62830856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 01:47:16 -0700
X-CSE-ConnectionGUID: REPZIiNWSpyxMa0BM5z8hw==
X-CSE-MsgGUID: ufQTNyFPQyiqgYO2hlfmTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="186669244"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 01:47:15 -0700
Date: Thu, 16 Oct 2025 10:45:19 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: lower default
 irq/queue counts on high-core systems
Message-ID: <aPCwn1jZDl+7+F1i@mev-dev.igk.intel.com>
References: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
 <d6a90d0d-55f9-467a-b414-5ced78d12c54@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6a90d0d-55f9-467a-b414-5ced78d12c54@molgen.mpg.de>

On Thu, Oct 16, 2025 at 09:44:43AM +0200, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for the patch. I’d mention the 64 in the summary:
> 

Sure, I will add it.

> > ice: lower default irq/queue counts to 64 on > 64 core systems
> 
> 
> Am 16.10.25 um 08:22 schrieb Michal Swiatkowski:
> > On some high-core systems loading ice driver with default values can
> > lead to queue/irq exhaustion. It will result in no additional resources
> > for SR-IOV.
> > 
> > In most cases there is no performance reason for more than 64 queues.
> > Limit the default value to 64. Still, using ethtool the number of
> > queues can be changed up to num_online_cpus().
> > 
> > This change affects only the default queue amount on systems with more
> > than 64 cores.
> 
> Please document a specific system and steps to reproduce the issue.
> 
> Please also document how to override the value.

Ok, will add.

> 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice.h     | 20 ++++++++++++++++++++
> >   drivers/net/ethernet/intel/ice/ice_irq.c |  6 ++++--
> >   drivers/net/ethernet/intel/ice/ice_lib.c |  8 ++++----
> >   3 files changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 3d4d8b88631b..354ec2950ff3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -1133,4 +1133,24 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
> >   	else
> >   		return &pf->adapter->ctrl_pf->hw;
> >   }
> > +
> > +/**
> > + * ice_capped_num_cpus - normalize the number of CPUs to a reasonable limit
> > + *
> > + * This function returns the number of online CPUs, but caps it at suitable
> > + * default to prevent excessive resource allocation on systems with very high
> > + * CPU counts.
> > + *
> > + * Note: suitable default is currently at 64, which is reflected in default_cpus
> > + * constant. In most cases there is no much benefit for more than 64 and it is a
> 
> no*t* much
>

Will fix

> > + * power of 2 number.
> > + *
> > + * Return: number of online CPUs, capped at suitable default.
> > + */
> > +static inline u16 ice_capped_num_cpus(void)
> 
> Why not return `unsigned int` or `size_t`?
>

Just because u16 is used for queue counts, but I can go with unsigned
int, makes more sense as num_online_cpus() is returning unsigned int.

> > +{
> > +	const int default_cpus = 64;
> > +
> > +	return min(num_online_cpus(), default_cpus);
> > +}
> >   #endif /* _ICE_H_ */
> > diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> > index 30801fd375f0..df4d847ca858 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> > @@ -106,9 +106,11 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
> >   #define ICE_RDMA_AEQ_MSIX 1
> >   static int ice_get_default_msix_amount(struct ice_pf *pf)
> >   {
> > -	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
> > +	u16 cpus = ice_capped_num_cpus();
> > +
> > +	return ICE_MIN_LAN_OICR_MSIX + cpus +
> >   	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
> > -	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
> > +	       (ice_is_rdma_ena(pf) ? cpus + ICE_RDMA_AEQ_MSIX : 0);
> >   }
> >   /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index bac481e8140d..3c5f8a4b6c6d 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -159,12 +159,12 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
> >   static u16 ice_get_rxq_count(struct ice_pf *pf)
> >   {
> > -	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
> > +	return min(ice_get_avail_rxq_count(pf), ice_capped_num_cpus());
> >   }
> >   static u16 ice_get_txq_count(struct ice_pf *pf)
> >   {
> > -	return min(ice_get_avail_txq_count(pf), num_online_cpus());
> > +	return min(ice_get_avail_txq_count(pf), ice_capped_num_cpus());
> >   }
> >   /**
> > @@ -907,13 +907,13 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
> >   		if (vsi->type == ICE_VSI_CHNL)
> >   			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
> >   		else
> > -			vsi->rss_size = min_t(u16, num_online_cpus(),
> > +			vsi->rss_size = min_t(u16, ice_capped_num_cpus(),
> >   					      max_rss_size);
> >   		vsi->rss_lut_type = ICE_LUT_PF;
> >   		break;
> >   	case ICE_VSI_SF:
> >   		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
> > -		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
> > +		vsi->rss_size = min_t(u16, ice_capped_num_cpus(), max_rss_size);
> >   		vsi->rss_lut_type = ICE_LUT_VSI;
> >   		break;
> >   	case ICE_VSI_VF:
> 
> With the changes addressed, feel free to add:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 

Thanks

> 
> Kind regards,
> 
> Paul

