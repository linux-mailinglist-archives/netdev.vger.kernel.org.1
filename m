Return-Path: <netdev+bounces-144690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8561E9C82F2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F421F22533
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 06:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656615A848;
	Thu, 14 Nov 2024 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZ/AOa+M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53561E4B0
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731564508; cv=none; b=TM+SRdc66uGdqGYqWzsblNSf42MnklNL0xP8Ddj7dfQSzfPqq+DB8N1w7gx/iF/Qdlh3YkQ+qmWRCWxh3jYAN6UEPiEoI/enRZZbu5Jz2nnnrcohQxx/0U+8kZnMycC2jqs/WO9AU44/RAzub+OoNhvzanLFpN6aJkC8UYUbUGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731564508; c=relaxed/simple;
	bh=sE51thmAZ7MC5QN6bD4tLwEO0ESCXyPCFsyHxzm0V+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQB2EgJiM1U6Y0kpCvVDqNOY0XF8aQxRx3Zv71pI4YHR3mML1ymHfcccXe2NEqqQLlN/s50XZ4F/fMJXzc4rIMBpP17RNDAFN/y/mZdBMEMHO0NVGtE4ZFkUGJCr1bDXg/2RpHXJ6nLq7L+zcIwT8B+LtC/zxtLvPQWWsyHOa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZ/AOa+M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731564507; x=1763100507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sE51thmAZ7MC5QN6bD4tLwEO0ESCXyPCFsyHxzm0V+I=;
  b=RZ/AOa+MTA7NvAqrQ3p/xhG0yrqBtrq+sF+XK2Zu1fUfeZwnq7rhZzvm
   3PiKG11tBOp4lk7VErS6D2xZ8SEXNo16WFC4g9XWdpB/TfLEhmCnoEjD2
   aziKk5vmGohka7I3i5sEYd0C1JL33wxGcGfeDWYA7AKWF5uEWLzQk4aTP
   ZLIJwNln7ufZvzmQx2H2kvY3AtWvuNnxeHnoz9OLkQti/4JtACo55JMGv
   WMRbMY0uONNIVS5HesEZTAKWA45Ee5qzFCbePMybC6Xn+ChRdLrklIKUd
   Qq7B5PYpXKdfhzcWWUI5P+sxMHrHO43jykSqUL1N+klMp5oYB8sOn9xCJ
   g==;
X-CSE-ConnectionGUID: ZyXKsfnOSPGqYAJZJXUPPQ==
X-CSE-MsgGUID: jc5lzDRHTLajouZE8CEK8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42103554"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42103554"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:08:24 -0800
X-CSE-ConnectionGUID: WPODl92zQeu3pSP3ApAtsg==
X-CSE-MsgGUID: HHWep677Qc+DhUZLVUETEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="111408696"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 22:08:21 -0800
Date: Thu, 14 Nov 2024 07:05:39 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Lukasz Czapnik <lukasz.czapnik@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, pmenzel@molgen.mpg.de,
	wojciech.drewek@intel.com, marcin.szycik@intel.com,
	netdev@vger.kernel.org, konrad.knitter@intel.com,
	pawel.chmielewski@intel.com, horms@kernel.org,
	David.Laight@aculab.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	pio.raczynski@gmail.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, jiri@resnulli.us,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v7 5/9] ice, irdma: move interrupts
 code to irdma
Message-ID: <ZzWTMwo7hx8qRLnt@mev-dev.igk.intel.com>
References: <20241104121337.129287-1-michal.swiatkowski@linux.intel.com>
 <20241104121337.129287-6-michal.swiatkowski@linux.intel.com>
 <5eca295e-1675-4779-b0d6-ec8a7550516f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eca295e-1675-4779-b0d6-ec8a7550516f@intel.com>

On Wed, Nov 13, 2024 at 05:21:20PM +0100, Lukasz Czapnik wrote:
> 
> 
> On 11/4/2024 1:13 PM, Michal Swiatkowski wrote:
> > Move responsibility of MSI-X requesting for RDMA feature from ice driver
> > to irdma driver. It is done to allow simple fallback when there is not
> > enough MSI-X available.
> > 
> > Change amount of MSI-X used for control from 4 to 1, as it isn't needed
> > to have more than one MSI-X for this purpose.
> > 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/infiniband/hw/irdma/hw.c         |  2 -
> >   drivers/infiniband/hw/irdma/main.c       | 46 ++++++++++++++++-
> >   drivers/infiniband/hw/irdma/main.h       |  3 ++
> >   drivers/net/ethernet/intel/ice/ice.h     |  1 -
> >   drivers/net/ethernet/intel/ice/ice_idc.c | 64 ++++++------------------
> >   drivers/net/ethernet/intel/ice/ice_irq.c |  3 +-
> >   include/linux/net/intel/iidc.h           |  2 +
> >   7 files changed, 65 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> > index ad50b77282f8..69ce1862eabe 100644
> > --- a/drivers/infiniband/hw/irdma/hw.c
> > +++ b/drivers/infiniband/hw/irdma/hw.c
> > @@ -498,8 +498,6 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
> >   	iw_qvlist->num_vectors = rf->msix_count;
> >   	if (rf->msix_count <= num_online_cpus())
> >   		rf->msix_shared = true;
> > -	else if (rf->msix_count > num_online_cpus() + 1)
> > -		rf->msix_count = num_online_cpus() + 1;
> >   	pmsix = rf->msix_entries;
> >   	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
> > diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
> > index 3f13200ff71b..1ee8969595d3 100644
> > --- a/drivers/infiniband/hw/irdma/main.c
> > +++ b/drivers/infiniband/hw/irdma/main.c
> > @@ -206,6 +206,43 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
> >   		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
> >   }
> > +static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
> > +{
> > +	int i;
> > +
> > +	rf->msix_count = num_online_cpus() + IRDMA_NUM_AEQ_MSIX;
> 
> I think we can default RDMA MSI-X to 64 instead of num_online_cpus(). It
> would play better on platforms with high core count (200+ cores). There
> are very little benefits for having more than 64 queues.
> 

Sure,I can do that. Do we have some numbers to put it into commit
message?

> In those special cases, when more queues are needed, user should be able
> to manually assign more resources to RDMA.

Do we have a way to do that? I mean, currently AFAIK this is the only place
where RDMA is requesting MSI-X from ice. Driver can be reloaded to do it
again (if didn't receive enough MSI-X and user change other config to
free it for RDMA use case), but the max value is fixed here (to
num_online_cpus() here, and to 64 after your suggestion).

RDMA driver should be able to reinit MSI-X during working exactly the
same way as eth is changing MSI-X amount when queues number is changing.
This should be done in irdma driver. Hope someone will take care of that
(if this is really needed, becase if 64 is always enough we are fine).

In summary I will add:
#define IRDMA_NUM_OPTIMAL_MSIX 64
min(IRDMA_NUM_OPTIMAL_MSIX, num_online_cpus()) + IRDMA_NUM_AEQ_MSIX;

Thanks,
Michal

> 
> Regards,
> Lukasz
> 

