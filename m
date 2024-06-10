Return-Path: <netdev+bounces-102174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D7901BCE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B000D1F21A67
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E020B0F;
	Mon, 10 Jun 2024 07:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P85ZPg6o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7B4776E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004079; cv=none; b=rpP/1RHe+LkNqqQMd5Fdxsz4IlO1c8u6um1FAyaVi9DXwDt6AHVUUHsLAErhxPk2fjJNlX0ywM67ON57QdFsX86US+w3J0ZZ60sexmtm0nQwjMT4fFUJxK9N7OHz2sdmZ6cJ28bT8cUt0mWVIyQXDsQtGGKGx9rpJ9hn7xHEMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004079; c=relaxed/simple;
	bh=jXPKiXC/uIzPG3lo6IrKlpRKHxhZ1P35ap2Vzt0Hdpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue9R/OgmDVryOJbWkuVClMh8x7zZtoPDY8dY+mhfgfF4YIQyKGP0BEx+BNvCHtD9YBC6E/uRJnZFRK1nXWEQrVXklPfGsdLv2/qB7fZfWrPGcn5RWMpXeyiJIyDAK2Uu9cSZjPx4Tfp9pZBrwj4LAMx7fPhVH4jjk2jQr0cnhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P85ZPg6o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718004078; x=1749540078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jXPKiXC/uIzPG3lo6IrKlpRKHxhZ1P35ap2Vzt0Hdpw=;
  b=P85ZPg6ox5VGpuSvyMAwN/JW9lio7Dx36dLTctRiDDJwex5yTmmZ8dSo
   0PwRpZd5m2WLCfbuzLzC/0E2+lPBdRh0pmX9G4WIvHV2UG/Gx3xE90Ig5
   TjuqIPqyVz1hhoorZ260BHP0LyyJHqg0W6mi9dTOEIxSdUC8Dtre3LZXb
   7GvPe9UKmmRk2+h1ozTDRZAZ8Gs6rLnv8MkI4FrWHcQtXPbFQe4Q9+7/E
   NSqGfBbmM8iWiQ1iZtPu2c6prSACYq7CCThite4OIO8T0iG0nIb8S6zLr
   8SRT9KxCYeTlOsT5J6rqhjO6w8OfEYQxFHpZetTIRGmXp7q9AORa8NUR7
   A==;
X-CSE-ConnectionGUID: w2Ywk5j3T6u1Ubdq+FN0VQ==
X-CSE-MsgGUID: oY7fC0yOQFmyJFT+zDO+Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="25760689"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25760689"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 00:21:18 -0700
X-CSE-ConnectionGUID: Nyf0iVaGTeysEcjBklIZVA==
X-CSE-MsgGUID: srslRiIURqKdSG0Qj6U3Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39055729"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 00:21:17 -0700
Date: Mon, 10 Jun 2024 09:20:18 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH v2 3/7] ice: move devlink locking outside the port
 creation
Message-ID: <ZmapMiNznNSqGDvT@mev-dev>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
 <20240605-next-2024-06-03-intel-next-batch-v2-3-39c23963fa78@intel.com>
 <20240606175634.2e42fca8@kernel.org>
 <ZmKWNbY1V+ZvP/qX@mev-dev>
 <49f3020a-1b2a-44c5-8ea5-938aa2195144@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f3020a-1b2a-44c5-8ea5-938aa2195144@intel.com>

On Fri, Jun 07, 2024 at 02:20:01PM -0700, Jacob Keller wrote:
> 
> 
> On 6/6/2024 10:10 PM, Michal Swiatkowski wrote:
> > On Thu, Jun 06, 2024 at 05:56:34PM -0700, Jakub Kicinski wrote:
> >> On Wed, 05 Jun 2024 13:40:43 -0700 Jacob Keller wrote:
> >>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> >>>
> >>> In case of subfunction lock will be taken for whole port creation. Do
> >>> the same in VF case.
> >>
> >> No interactions with other locks worth mentioning?
> >>
> > 
> > You right, I could have mentioned also removing path. The patch is only
> > about devlink lock during port representor creation / removing.
> > 
> >>> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >>> index 704e9ad5144e..f774781ab514 100644
> >>> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >>> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> >>> @@ -794,10 +794,8 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
> >>>  
> >>>  	tc_node = pi->root->children[0];
> >>>  	mutex_lock(&pi->sched_lock);
> >>> -	devl_lock(devlink);
> >>>  	for (i = 0; i < tc_node->num_children; i++)
> >>>  		ice_traverse_tx_tree(devlink, tc_node->children[i], tc_node, pf);
> >>> -	devl_unlock(devlink);
> >>>  	mutex_unlock(&pi->sched_lock);
> >>
> >> Like this didn't use to cause a deadlock?
> >>
> >> Seems ice_devlink_rate_node_del() takes this lock and it's already
> >> holding the devlink instance lock.
> > 
> > ice_devlink_rate_init_tx_topology() wasn't (till now) called with
> > devlink lock, because it is called from port representor creation flow,
> > not from the devlink.
> > 
> > Thanks,
> > Michal
> 
> I take it you will make a respin of the 4 subfunction patches in this
> series then?

Ok, I will send.

