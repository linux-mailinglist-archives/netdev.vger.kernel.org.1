Return-Path: <netdev+bounces-107243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6091A690
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A44D284A83
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6D815A85D;
	Thu, 27 Jun 2024 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3OAdWvp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E013DBA8
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491546; cv=none; b=rUsWHkLgo10bjXQ/S+XszIXkhz9b8aHEhxwtQQfNSctSfOYkWirwDnQzGSTDStw1zKA4UJqpEqHjyei6xZS2YcXMoeg0iGyxOnoGvBHmlaYHFcA8mqnIIs4AuGlIdZQ8yBYOzQ/gOXPQ//d6bwCo03PW2HGS2jiCg0eSUR6tcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491546; c=relaxed/simple;
	bh=Zb5EMl5fYkElVnsUXXDsFGM/Z2dAQphF3aYP4/Cm2Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuS3pFvmlEcL/pCBjBVVpZ+enVyuuXYBEuNvLLrkyOnFJLx9LDFv1AgBoPGUGUS1pEZlEpHpMTHwmamg9uLe8lOjVNxg1oG6mxnki1MrpYs6R/dSJPbxuq0c9hJQas6oGJGxwfgmEZa5+uU/+tuOT888jnO+Tkk1nxAXai1EvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3OAdWvp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719491546; x=1751027546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zb5EMl5fYkElVnsUXXDsFGM/Z2dAQphF3aYP4/Cm2Dw=;
  b=a3OAdWvpBwNI5r7lWBAr37R41yvz2aKwgpYg8QGYLLAawtoWYgd//458
   w+RnaFtoZaRhs+YE2rOyC/hb4nFLYKKEawFZXns4k1Myp8rZKknVH/iwN
   Jt49PGQdqd6/Nor2D6EzXSKXl+bNv8OMGU+DNoeh+JoCo8lXvUJdpD7iR
   wRfZafdjUP/Ze7qmdTft3fFJhp6FGbMLS/V/bH/BXF+6dhk8dNMhatf0d
   EIVw+mHvhA7YkLNiLhmOvMg3UDihZzN7dewsF6IexVMiCihv/5e2oKhBg
   6YIjF40k4aQtg/BtvHO6mltvgi8G3yHNAmGTQrNb9/IsCCs6ooIZKiwZW
   g==;
X-CSE-ConnectionGUID: FRDkL40QTaKzD5fEMvtyXA==
X-CSE-MsgGUID: CmtIIjcFQ3WMiu4MJE64xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="28013239"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="28013239"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:32:24 -0700
X-CSE-ConnectionGUID: gUlL85/mR9qO1J26L1vQfw==
X-CSE-MsgGUID: TeZ8W51wQ96asTqT2fOrlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="48974069"
Received: from mev-dev.igk.intel.com (HELO mev-dev) ([10.237.112.144])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 05:32:20 -0700
Date: Thu, 27 Jun 2024 14:31:14 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	sridhar.samudrala@intel.com, przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com, pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com, horms@kernel.org
Subject: Re: [iwl-next v5 04/15] ice: treat subfunction VSI the same as PF VSI
Message-ID: <Zn1bkhZ1lF1w96AA@mev-dev>
References: <20240606112503.1939759-1-michal.swiatkowski@linux.intel.com>
 <20240606112503.1939759-5-michal.swiatkowski@linux.intel.com>
 <Zn1H6hmr4Y7ZFvT6@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn1H6hmr4Y7ZFvT6@boxer>

On Thu, Jun 27, 2024 at 01:07:22PM +0200, Maciej Fijalkowski wrote:
> On Thu, Jun 06, 2024 at 01:24:52PM +0200, Michal Swiatkowski wrote:
> > When subfunction VSI is open the same code as for PF VSI should be
> > executed. Also when up is complete. Reflect that in code by adding
> > subfunction VSI to consideration.
> > 
> > In case of stopping, PF doesn't have additional tasks, so the same
> > is with subfunction VSI.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index e76e19036593..ddc348371841 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -6726,7 +6726,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
> >  
> >  	if (vsi->port_info &&
> >  	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
> > -	    vsi->netdev && vsi->type == ICE_VSI_PF) {
> > +	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
> > +	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
> 
> patch 1 has:
> 
> 	if (vsi->netdev && (vsi->type == ICE_VSI_PF ||
> 			    vsi->type == ICE_VSI_SF)) {
> 
> so maybe stay consistent and do the same here?
> 
> nit: also seems that a really small helper would make the code easier to
> read and wrap...something like:
> 
> bool ice_is_vsi_pf_sf(struct ice_vsi* vsi)
> {
> 	return (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF);
> }

Make sense, hope you are ok, with changing it on the occasion (for
example adding multibuffer support).

Thanks,
Michal

> 
> >  		ice_print_link_msg(vsi, true);
> >  		netif_tx_start_all_queues(vsi->netdev);
> >  		netif_carrier_on(vsi->netdev);
> > @@ -7427,7 +7428,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
> >  
> >  	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
> >  
> > -	if (vsi->type == ICE_VSI_PF) {
> > +	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
> >  		/* Notify the stack of the actual queue counts. */
> >  		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
> >  		if (err)
> > -- 
> > 2.42.0
> > 

