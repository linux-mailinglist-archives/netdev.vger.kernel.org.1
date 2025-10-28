Return-Path: <netdev+bounces-233462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E014CC13BE5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B0464E7DCB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609B2E7F11;
	Tue, 28 Oct 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS81pukt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383E284898
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642634; cv=none; b=Uz5I2pRNtsECjADGUX08u6Povr92Q4yB/Seib5oNmA4uxW5yIRSei3kGcFy86kxPvr+6dfzXnVoNMn+dJ7IWMzRLFZw/NkR4ofqw2ez3qLBoFiKINUdizGK1rA988q/+EntNfqLTQrqkioWLVinQDnmqg73G28ROc5CjPP9gZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642634; c=relaxed/simple;
	bh=lbcYMNWtSmGXCpuFko3OMESYsLMpkByTHzCvLQRpQIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ20DZ0jaKm45uKLfEuHXXQQAtO/RR7ceVAvKWmtkgoiECGt1KyX+6bhK8VpKi74EMuV7JgGPZ/f1YDB7V1sVm1WPf1nTPa40oc/MBhmz7YZPDhfWCc1+i5K6a7Pl30otM7V2VIPoMErtA8gKfeazLiI2ljACI+UU/SM/KbdCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS81pukt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761642633; x=1793178633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lbcYMNWtSmGXCpuFko3OMESYsLMpkByTHzCvLQRpQIM=;
  b=FS81puktEboQKHmfN/7clpVNh1gFIKjmXVN9fIiGpYtBNXOXZI0/WG4r
   pvHkzrMVQdeceH2b8vOGSf3ZbHMtTdYE9oLaAf3mSEfI/X+kofcmeInSh
   9guv2ePasImbYi9fLG6v2AK1eMZQ4cS2Ou//r/S7KJBsQoZ/81G1O8YJm
   V6kIcAvCWS2TpfsEeVPTkDRHtUmwL+WfagZcT/4TLJxecEzrPe5iIsEVN
   dRGI2iwjWuKC75H2MW5NkAQ4l2pvrGISMGraJ5SpuCTUTcc5E7tYjCOkh
   Gi+xZ/ZlABpgkGR2nD/MlQaGnNkQwDljoR+HtPZGB3JnyfeqJWgxVbnwZ
   A==;
X-CSE-ConnectionGUID: eI7sEwYbRiiNuKzZb1CbMg==
X-CSE-MsgGUID: a3/K9ov+SHSVKWs0ZWveaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67574316"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67574316"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:10:32 -0700
X-CSE-ConnectionGUID: VZj/1pnaQaCTQUFRJRnfTg==
X-CSE-MsgGUID: 2VYCyRV4TLCpymx491eKJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184525905"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:10:30 -0700
Date: Tue, 28 Oct 2025 10:08:24 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: use
 netif_get_num_default_rss_queues()
Message-ID: <aQCICC7S4JCaImJa@mev-dev.igk.intel.com>
References: <20251028070634.2124215-1-michal.swiatkowski@linux.intel.com>
 <IA3PR11MB898627B7BCB9ACEEE31A377BE5FDA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB898627B7BCB9ACEEE31A377BE5FDA@IA3PR11MB8986.namprd11.prod.outlook.com>

On Tue, Oct 28, 2025 at 07:48:11AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Michal Swiatkowski
> > Sent: Tuesday, October 28, 2025 8:07 AM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; pmenzel@molgen.mpg.de; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Michal Swiatkowski
> > <michal.swiatkowski@linux.intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: use
> > netif_get_num_default_rss_queues()
> > 
> > On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
> > Forest) loading ice driver with default values can lead to queue/irq
> > exhaustion. It will result in no additional resources for SR-IOV.
> > 
> > In most cases there is no performance reason for more than half
> > num_cpus(). Limit the default value to it using generic
> > netif_get_num_default_rss_queues().
> > 
> > Still, using ethtool the number of queues can be changed up to
> > num_online_cpus(). It can be done by calling:
> > $ethtool -L ethX combined max_cpu
> > 
> It could be nice to use $(nproc)?
>  $ ethtool -L ethX combined $(nproc)

Will change

> 
> > This change affects only the default queue amount.
> > 
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> > v1 --> v2:
> >  * Follow Olek's comment and switch from custom limiting to the
> > generic
> >    netif_...() function.
> >  * Add more info in commit message (Paul)
> >  * Dropping RB tags, as it is different patch now
> > ---
> >  drivers/net/ethernet/intel/ice/ice_irq.c |  5 +++--
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++++----
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c
> > b/drivers/net/ethernet/intel/ice/ice_irq.c
> > index 30801fd375f0..1d9b2d646474 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> > @@ -106,9 +106,10 @@ static struct ice_irq_entry
> > *ice_get_irq_res(struct ice_pf *pf,
> >  #define ICE_RDMA_AEQ_MSIX 1
> >  static int ice_get_default_msix_amount(struct ice_pf *pf)
> >  {
> > -	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
> > +	return ICE_MIN_LAN_OICR_MSIX +
> > netif_get_num_default_rss_queues() +
> >  	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX :
> > 0) +
> > -	       (ice_is_rdma_ena(pf) ? num_online_cpus() +
> > ICE_RDMA_AEQ_MSIX : 0);
> > +	       (ice_is_rdma_ena(pf) ?
> > netif_get_num_default_rss_queues() +
> > +				      ICE_RDMA_AEQ_MSIX : 0);
> >  }
> > 
> >  /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index bac481e8140d..e366d089bef9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -159,12 +159,14 @@ static void ice_vsi_set_num_desc(struct ice_vsi
> > *vsi)
> > 
> >  static u16 ice_get_rxq_count(struct ice_pf *pf)
> >  {
> > -	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
> > +	return min(ice_get_avail_rxq_count(pf),
> > +		   netif_get_num_default_rss_queues());
> >  }
> min(a, b) resolves to the type of the expression, which here will be int due to netif_get_num_default_rss_queues() returning int. 
> That implicitly truncates to u16 on return.
> What do you think about to make this explicit with min_t() to avoid type surprises?

We will just hide the truncing in the min_t() call. Probably if we
assuming that cpu / 2 can be higher than U16_MAX we should check that
here. Is it needed? (Previous situation is the same, num_online_cpus() is
returning int).

> 
> > 
> >  static u16 ice_get_txq_count(struct ice_pf *pf)
> >  {
> > -	return min(ice_get_avail_txq_count(pf), num_online_cpus());
> > +	return min(ice_get_avail_txq_count(pf),
> > +		   netif_get_num_default_rss_queues());
> >  }
> 
> Same min_t() ?
> 
> Otherwise, fine for me.

Thanks

> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

