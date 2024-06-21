Return-Path: <netdev+bounces-105530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6B9911947
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646571F2199B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80084FAC;
	Fri, 21 Jun 2024 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjiqwLqF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE98528F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943458; cv=none; b=sG2kE8yV/4DSstaX22NTZz5QGA7+3da7dMA4FrYhWnw7ZgLC6uX4h6M+uFhUFfk7FqJ65lc7VJYIP9ljvDkm47bpji4BlafbUa+SJjDf9MKypUppDZ+U3j0UjlD7XKmVj9Abpju8KMnNhbS/BA0DakbLAIReYtg/k2vaeBB8XM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943458; c=relaxed/simple;
	bh=enr6nQYDAeDlqhkOC+Fw1OHLsm6fOXBqg7RHAZnRUc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH9uKdaMJxBFvKqNhzwGsjxx4Chu5VDw799svUWwfqlCoDYX2Ke/xyFTM6UEHf5xRSOs22f0Of7+W7gEBOBztW2HfA03eCPh0WLNoZ6ZDi5sysDG0zUMASfPJNMUzkJfiJ5OYr4v1fNkB0Y33UMJM14YmRd71TVCRb4JJSLJfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjiqwLqF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718943457; x=1750479457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=enr6nQYDAeDlqhkOC+Fw1OHLsm6fOXBqg7RHAZnRUc8=;
  b=OjiqwLqFuphBNWE8WOwtHZIX8V4f8kpbfkQjU5k+OYDmPyKs9L8H+GU/
   Ea46nufAH4YegCKl5y9xML4R011D5decMaRqHuYaSwXkxPqvoDaXJ2e7o
   SqYkgQvFTZuiAVFpgusg8kYE3j3eG36UlKt3r3hzkv27Lphf+klOI8Ap6
   8FS7NP4DxJKIMbJzJuQwEbIUMRTTeYtPvRThn6MoS0yM1z+wWur5VTlIH
   w0Uhg0uXtSRJxjKiuBbNcifh5dOV+JEoSfTgTCvpV8xuo3NtbUVkwfwzd
   qr5nGNa3l0r8ZbKQMZXQczJPkoiyEu+Ke8o8i7KDBDlRzZZofWN6+a/XO
   g==;
X-CSE-ConnectionGUID: J32GgdigQz6UdgGimSCiVQ==
X-CSE-MsgGUID: kqsFm8vxSvut2ue5w+nV7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="26555526"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="26555526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:17:36 -0700
X-CSE-ConnectionGUID: C6rNXF/2R42rbkAJV1EmIA==
X-CSE-MsgGUID: cTn23UXoQFGbXj2bw4l08g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="73209979"
Received: from mev-dev.igk.intel.com (HELO mev-dev) ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:17:32 -0700
Date: Fri, 21 Jun 2024 06:16:27 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com, kuba@kernel.org
Subject: Re: [iwl-next v3 3/4] ice: move VSI configuration outside repr setup
Message-ID: <ZnT+m0pMeLqdrEqd@mev-dev>
References: <20240610074434.1962735-1-michal.swiatkowski@linux.intel.com>
 <20240610074434.1962735-4-michal.swiatkowski@linux.intel.com>
 <20240614124331.GL8447@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614124331.GL8447@kernel.org>

On Fri, Jun 14, 2024 at 01:43:31PM +0100, Simon Horman wrote:
> On Mon, Jun 10, 2024 at 09:44:33AM +0200, Michal Swiatkowski wrote:
> > It is needed because subfunction port representor shouldn't configure
> > the source VSI during representor creation.
> > 
> > Move the code to separate function and call it only in case the VF port
> > representor is being created.
> > 
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> Hi Michal,
> 
> The nit below notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> > ---
> >  drivers/net/ethernet/intel/ice/ice_eswitch.c | 55 ++++++++++++++------
> >  drivers/net/ethernet/intel/ice/ice_eswitch.h | 10 ++++
> >  drivers/net/ethernet/intel/ice/ice_repr.c    |  7 +++
> >  3 files changed, 57 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > index 7b57a6561a5a..3f73f46111fc 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > @@ -117,17 +117,10 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
> >  	struct ice_vsi *vsi = repr->src_vsi;
> >  	struct metadata_dst *dst;
> >  
> > -	ice_remove_vsi_fltr(&pf->hw, vsi->idx);
> >  	repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
> >  				       GFP_KERNEL);
> >  	if (!repr->dst)
> > -		goto err_add_mac_fltr;
> > -
> > -	if (ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof))
> > -		goto err_dst_free;
> > -
> > -	if (ice_vsi_add_vlan_zero(vsi))
> > -		goto err_update_security;
> > +		return -ENOMEM;
> >  
> >  	netif_keep_dst(uplink_vsi->netdev);
> >  
> > @@ -136,16 +129,48 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
> >  	dst->u.port_info.lower_dev = uplink_vsi->netdev;
> >  
> >  	return 0;
> > +}
> >  
> > -err_update_security:
> > +/**
> > + * ice_eswitch_cfg_vsi - configure VSI to work in slow-path
> > + * @vsi: VSI structure of representee
> > + * @mac: representee MAC
> > + *
> > + * Return: 0 on success, non-zero on error.
> > + */
> > +int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac)
> > +{
> > +	int err;
> > +
> > +	ice_remove_vsi_fltr(&vsi->back->hw, vsi->idx);
> > +
> > +	err = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
> > +	if (err)
> > +		goto err_update_security;
> > +
> > +	err = ice_vsi_add_vlan_zero(vsi);
> > +	if (err)
> > +		goto err_vlan_zero;
> > +
> > +	return 0;
> > +
> > +err_vlan_zero:
> >  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
> 
> nit: Please consider continuing the practice, that is used for the labels
>      removed by this patch, of naming labels after what they do rather
>      than what jumps to them.
> 

Ok, I was wondering which approach is better. Probably mixing both is
the worst. I will follow your advice next time, thanks.

> > -err_dst_free:
> > -	metadata_dst_free(repr->dst);
> > -	repr->dst = NULL;
> > -err_add_mac_fltr:
> > -	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac, ICE_FWD_TO_VSI);
> > +err_update_security:
> > +	ice_fltr_add_mac_and_broadcast(vsi, mac, ICE_FWD_TO_VSI);
> >  
> > -	return -ENODEV;
> > +	return err;
> > +}
> > +
> 
> ...

