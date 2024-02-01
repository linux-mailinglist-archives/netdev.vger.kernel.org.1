Return-Path: <netdev+bounces-67841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 643228451BA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1876429368A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD3157E90;
	Thu,  1 Feb 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHzFORv6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A9157E80
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771114; cv=none; b=rjjE6r0eI88x4RH0qxBv99JPoPvmvwHAsANM/nLHXnnsgbYiByLSHEwNppkDDUxlLDkJ9ybr8TKXz4kVmfsP6r2BqVnK1RslwR0fWHD2ho2/r7OZ3FXWR5jGLwmjv1nyX3yAfPx0IeBDsbiklTZkOCg57yIi1kwYbqtv1V4ok+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771114; c=relaxed/simple;
	bh=UTM+/2cg11W3aTJGB22NuZYXxv+fuaUMV20mGa+ewX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O739Qvgy/e4ifCnMjCMbijgfGn0q6I/1jBv5077hZlEiAFgTOMuE6Z9/FngDbzfm0MhbBo8LJ1P5q8wYCAfpJH/PRiYlN61wPTlcAaNmZOVihQTp7nzqZIMqhlIY2J2vJrTSBOsafgPZ9GXJQcSvD8Qd+zhDlJ6ROjQi+TfUPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHzFORv6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706771113; x=1738307113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTM+/2cg11W3aTJGB22NuZYXxv+fuaUMV20mGa+ewX8=;
  b=NHzFORv6hw+YBjJ8OHe7CMvttz1VYQLBYGYAVLNaaxTHRRc1VqnqIQQH
   0XjcvOf/w4Sl5O9YOwrSB7csvTxJglKDnsimDGZALdzjx2fZS9rTBFdBF
   gPbyNH8TOOLHn0WHjNmCH6qHMgc/aJ3n2nxv7tsqf2aeEQm1oXHZK79Qp
   YESAgKOzppTwea9FCHM4TeJPCmc4inMy2JVx/v1on3vkzSVIIc6gb6U1K
   2kscqm2IdfkEyAOfLeb56FlqsQbVd3O+y2i0+jfNkOAtYW+4Q78yqauVM
   5/CYclT8r6zmYKzXUS8nO9tLDSdCe93+tNS7KKIBOlMvEyELtEIeAvYR3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10459059"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10459059"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 23:05:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961842778"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961842778"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 23:05:09 -0800
Date: Thu, 1 Feb 2024 08:05:06 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com, przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [iwl-next v1 4/8] ice: control default Tx rule in lag
Message-ID: <ZbtCom/grznFpesc@mev-dev>
References: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
 <20240125125314.852914-5-michal.swiatkowski@linux.intel.com>
 <20240129105541.GH401354@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129105541.GH401354@kernel.org>

On Mon, Jan 29, 2024 at 10:55:41AM +0000, Simon Horman wrote:
> On Thu, Jan 25, 2024 at 01:53:10PM +0100, Michal Swiatkowski wrote:
> > Tx rule in switchdev was changed to use PF instead of additional control
> > plane VSI. Because of that during lag we should control it. Control
> > means to add and remove the default Tx rule during lag active/inactive
> > switching.
> > 
> > It can be done the same way as default Rx rule.
> 
> Hi Michal,
> 
> Can I confirm that LAG TX/RX works both before and after this patch?
> 

Hi Simon,

This part of LAG code is related to the LAG + switchdev feature (it
isn't chaning LAG core code). Hope that normal LAG also works well. This
is the scenario when you have PF in switchdev, bond created of two PFs
connected to the bridge with representors. Switching between interfaces
from bond needs to add default Rx rule, and after my changes also
default Tx rule.

Do you think I should add this description to commit message?

Thanks,
Michal

> > 
> > Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lag.c | 39 ++++++++++++++++++------
> >  drivers/net/ethernet/intel/ice/ice_lag.h |  3 +-
> >  2 files changed, 32 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> 
> ...
> 
> > @@ -266,9 +274,22 @@ ice_lag_cfg_dflt_fltr(struct ice_lag *lag, bool add)
> >  {
> >  	u32 act = ICE_SINGLE_ACT_VSI_FORWARDING |
> >  		ICE_SINGLE_ACT_VALID_BIT | ICE_SINGLE_ACT_LAN_ENABLE;
> > +	int err;
> > +
> > +	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
> > +			       ICE_FLTR_RX, add);
> > +	if (err)
> > +		return err;
> > +
> > +	err = ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_tx_rule_id,
> > +			       ICE_FLTR_TX, add);
> > +	if (err) {
> > +		ice_lag_cfg_fltr(lag, act, lag->pf_recipe, &lag->pf_rx_rule_id,
> > +				 ICE_FLTR_RX, !add);
> > +		return err;
> > +	}
> >  
> > -	return ice_lag_cfg_fltr(lag, act, lag->pf_recipe,
> > -				&lag->pf_rule_id, add);
> > +	return 0;
> >  }
> 
> nit: perhaps this could be more idiomatically written using a
>      goto to unwind on error.
>
Thanks, I will rewrite it.

> ...

