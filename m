Return-Path: <netdev+bounces-96269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8AE8C4C46
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E1E1C20ABA
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206751CAA4;
	Tue, 14 May 2024 06:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmuyXb4K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E71B7FD
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715668115; cv=none; b=CFB7t9xtxYFeZvch/Uer+/GSNCyKJp3pJ7OW0XLVw/MS1hmMx+dFrElkQ0TE6l35XGIK1wz5znITUtKHb+wP+UqkKQDQNgdqBNxbXIAaLushn9U6+bE66dHXH62SxcYLGH0JTUnKsfiWFBE6xvTEnZn6IFvtRAnFBv+9DuLDU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715668115; c=relaxed/simple;
	bh=uvLtRB2vRXuhGSiN6dmEWnhdZEwKhSyXzmwhQ4T0ths=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2kSoDD4wbay4+DopsyMmK/272vWP3tQqld7gFkrcGlm6xSvkiX7n+F8K0R0d3jXr7Xz51rV7QviQHWugtjI8NOUhKeLjKjadVhLGKgwO7BpRi28ou4LY9XUc94r33D6Y4kMr1A/SBcqQTm+PADHP5mpcUCNM2jqpAm0LsYn2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmuyXb4K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715668113; x=1747204113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uvLtRB2vRXuhGSiN6dmEWnhdZEwKhSyXzmwhQ4T0ths=;
  b=SmuyXb4KkOfhBLg5uXmRoyld1CENjrsw64fJ4gNx0mvp9VTjT940FE2u
   y15h9eh2xsWQWQqGKgL6iC/fnNeCgY1XRSD/bo1l03srXikBthI7uB3Gg
   Cf5vAIPSljiwbFf4dSMI6lIrlZca3eLZi6b8S1IbzJdo3myus0ciODTwW
   kZC1RCZbwQXk7vMq6/Fux4w2vOTrjAX/8L/Hf/KnPWLvUqs1rZA/zC6Bh
   23wtUGPZTZlSWqc9FVmxqx4OPpeymGSoePKrpCiza0F2FGgJURi7n1hP7
   pzdkrNQt4IJLbNfvdThBdw/RA/atI/RazxLBYa5ZHkAf0F5WGE+wiEKpy
   Q==;
X-CSE-ConnectionGUID: g//uZVJWRV+DgfLf+6y/MA==
X-CSE-MsgGUID: iNxJkVauQUK7c7OCArzx1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="23032218"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="23032218"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 23:28:33 -0700
X-CSE-ConnectionGUID: //F9auJcTIWsJ3JlW9L7eQ==
X-CSE-MsgGUID: wYzLra60TIy7l8Y0KH2v0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30526862"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 23:28:30 -0700
Date: Tue, 14 May 2024 08:27:57 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 08/15] ice: make reprresentor code generic
Message-ID: <ZkMEbayPH5ms+Qzc@mev-dev>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-9-michal.swiatkowski@linux.intel.com>
 <20240513160947.GQ2787@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513160947.GQ2787@kernel.org>

On Mon, May 13, 2024 at 05:09:47PM +0100, Simon Horman wrote:
> On Mon, May 13, 2024 at 10:37:28AM +0200, Michal Swiatkowski wrote:
> > Keep the same flow of port representor creation, but instead of general
> > attach function create helpers for specific representor type.
> > 
> > Store function pointer for add and remove representor.
> > 
> > Type of port representor can be also known based on VSI type, but it
> > is more clean to have it directly saved in port representor structure.
> > 
> > Add devlink lock for whole port representor creation and destruction.
> > 
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> nit: In subject, reprresentor -> representor
> 
> > ---
> >  .../ethernet/intel/ice/devlink/devlink_port.h |  1 +
> >  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 74 +++++++++++-----
> >  drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 +--
> >  drivers/net/ethernet/intel/ice/ice_repr.c     | 88 +++++++++----------
> >  drivers/net/ethernet/intel/ice/ice_repr.h     | 16 +++-
> >  drivers/net/ethernet/intel/ice/ice_sriov.c    |  4 +-
> >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  4 +-
> >  7 files changed, 121 insertions(+), 77 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > index e4acd855d9f9..6e14b9e4d621 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> > @@ -23,6 +23,7 @@ struct ice_dynamic_port {
> >  	struct devlink_port devlink_port;
> >  	struct ice_pf *pf;
> >  	struct ice_vsi *vsi;
> > +	unsigned long repr_id;
> 
> nit: Please add an entry for repr_id to the Kernel doc for this structure.
> 
>      And also the attached field which is added by the last patch
>      of this series.
> 

Thanks, will recheck every field

> >  	u32 sfnum;
> >  };
> >  
> 
> ...

