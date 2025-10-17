Return-Path: <netdev+bounces-230354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C88BE6F1C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD35624F1D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F981D5CD7;
	Fri, 17 Oct 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBMfNf22"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C433469A
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686362; cv=none; b=kwILeOS9fiAdwU23ryfkMEN9YZERogJGhJfyFHRKPtMtpG2wAquIfMRsG/bAl1Fg8DIGJgH5sxoymiI8Mfjs95vaVhRdNm1QQNAqza4OstnX7jupdqOZq1nY136XxXlPDz6WhqPNd5Ra+p5uInpNof3i8mJa+Grb5cshzInkY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686362; c=relaxed/simple;
	bh=1kgDxzclXPbdMWDj3OqGrnssQMYk+9cFkc1u0uTTXGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUQL3DpfO12Z/JpiyETBYZQ78tx8WIe+HrbhHRDEZCAI0QrjmcMRC19cJ+Dglf5zb7rkcknlGw1YSnHenRBm7wlg5by7urrjZDCyIW+95T71clxYtpVoDhIxvqyCJ+fEZTBZn2Glq3JVFrPdV3fSGB6TQ4P9oP4a2+aLAeOHzHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBMfNf22; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760686361; x=1792222361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1kgDxzclXPbdMWDj3OqGrnssQMYk+9cFkc1u0uTTXGw=;
  b=QBMfNf224tlLV+vXd4ylYWuxkURQBNGNuvgvfaEVp4VNNy/4ysHP4xbp
   8AKeO/gx3akOrcNdRfz2tJF0GEbsolraqDeI/0ScNcZ+EAEZzFJl+jx37
   CcLWWACW4Q9N8IVxVTozRqFrWzqL8V528AR0RQDbCcGSBtNHqtWyOHA4t
   v05+d7Q2RWHQOhgk6AJXnVsiukRDsvN+9oN4z4sH8mcXkj2ooh9cpdtVN
   0UaRsJuO9lOYCVyUP46DAM6TH4pS/eps+bnlbSDl3Lyto/RKQNpZ+Rc5k
   O5l13p9KELFCtTnnYKbLaKYSbQetz7ZpRboaUxhSha8nJZQ33BvrlH530
   w==;
X-CSE-ConnectionGUID: 9m1C0JfeQjaYDeR4jdlQHA==
X-CSE-MsgGUID: aSLB5e54T6iv64DagrE1/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73498431"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73498431"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:32:40 -0700
X-CSE-ConnectionGUID: 0tLhmyWZTJSKHwYpA3zQIw==
X-CSE-MsgGUID: S7lChEuySFKd/etjNlF/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183074745"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 00:32:39 -0700
Date: Fri, 17 Oct 2025 09:30:44 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: lower default
 irq/queue counts on high-core systems
Message-ID: <aPHwpE+YuxfWZjft@mev-dev.igk.intel.com>
References: <20251016062250.1461903-1-michal.swiatkowski@linux.intel.com>
 <5d739d1f-faa7-4734-b5e7-8e35b5556ce7@intel.com>
 <34268765-6cc5-4816-9ba7-4f00e8f353a0@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34268765-6cc5-4816-9ba7-4f00e8f353a0@intel.com>

On Fri, Oct 17, 2025 at 07:03:31AM +0200, Przemek Kitszel wrote:
> On 10/16/25 17:36, Alexander Lobakin wrote:
> > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Date: Thu, 16 Oct 2025 08:22:50 +0200
> > 
> > > On some high-core systems loading ice driver with default values can
> > > lead to queue/irq exhaustion. It will result in no additional resources
> > > for SR-IOV.
> > > 
> > > In most cases there is no performance reason for more than 64 queues.
> > > Limit the default value to 64. Still, using ethtool the number of
> > > queues can be changed up to num_online_cpus().
> > > 
> > > This change affects only the default queue amount on systems with more
> > > than 64 cores.
> > > 
> > > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice.h     | 20 ++++++++++++++++++++
> > >   drivers/net/ethernet/intel/ice/ice_irq.c |  6 ++++--
> > >   drivers/net/ethernet/intel/ice/ice_lib.c |  8 ++++----
> > >   3 files changed, 28 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > > index 3d4d8b88631b..354ec2950ff3 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice.h
> > > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > > @@ -1133,4 +1133,24 @@ static inline struct ice_hw *ice_get_primary_hw(struct ice_pf *pf)
> > >   	else
> > >   		return &pf->adapter->ctrl_pf->hw;
> > >   }
> > > +
> > > +/**
> > > + * ice_capped_num_cpus - normalize the number of CPUs to a reasonable limit
> > > + *
> > > + * This function returns the number of online CPUs, but caps it at suitable
> > > + * default to prevent excessive resource allocation on systems with very high
> > > + * CPU counts.
> > > + *
> > > + * Note: suitable default is currently at 64, which is reflected in default_cpus
> > > + * constant. In most cases there is no much benefit for more than 64 and it is a
> > > + * power of 2 number.
> > > + *
> > > + * Return: number of online CPUs, capped at suitable default.
> > > + */
> > > +static inline u16 ice_capped_num_cpus(void)
> > > +{
> > > +	const int default_cpus = 64;
> > 
> > Maybe we should just use netif_get_num_default_rss_queues() like I did
> > in idpf?
> > 
> > Or it still can be too high e.g. on clusters with > 256 CPUs?
> 
> good point,
> perhaps we should both use it and change the (kernel) func to cap at 64
> 

Sounds good, thanks for pointing the function.

Do you think it is ok to cap the generic function? Maybe other vendors
want more default queues.

What about capping netif_get_num_default_rss_queues() at 64 just for
ice?

> > 
> > > +
> > > +	return min(num_online_cpus(), default_cpus);
> > > +}
> > >   #endif /* _ICE_H_ */
> > Thanks,
> > Olek
> > 
> 

