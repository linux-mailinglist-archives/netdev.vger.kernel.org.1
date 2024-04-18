Return-Path: <netdev+bounces-89163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8901C8A9921
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133801F21361
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE615EFBB;
	Thu, 18 Apr 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeDsHEox"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E215ECEC
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441329; cv=none; b=ajsBnduhY+UguG3M8KAhu5lPIFwsTHZ0oFFUANUp5lwnaNkxz5Ck/uBfL67cZnb4NcbxPkHbEeaLZ22OPOTjKswEhRjlpDON6L4MUYJMSgziJuxEUre3nUMs9VCTrLGADd5tgyTd/kS+sssiCOm0DJZo1Xbg3stH7mk1g45P3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441329; c=relaxed/simple;
	bh=BjG0eEXPzantOD1jcelhGWFZa+JGWFo4s5JCsisY2Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQWZcD4+rLSq+/uOLW/4y6Bo6L7odnBMfKas2rPtL5X7lA+v7v3MKWaqBQl7kVTN5/s0bk+YHCNlmeyKVHkLCutqW4Bg6IdTvJuqqxtcL5OmvC+nloM60sf1tO6P7xavVnJkYpJPUc43Hgk2vZ99v8rXWm9fXDaQyAks/YpcS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeDsHEox; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713441328; x=1744977328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BjG0eEXPzantOD1jcelhGWFZa+JGWFo4s5JCsisY2Nk=;
  b=CeDsHEoxdPpsTDwGfzde94iXFMN/oC367QV8WRjVV65fZBDuhX9AS3Dv
   wZArTCBm+BHq+dmFBLKHcbNwy+FbG8aKFeOGHc6kt2VDftA+YDT9ar5nM
   /HDLeGB5iuXOiH228JVENXutMeJJrjyJgw0ALRS7hNWPAlGU8SeA6558w
   OohuTBgsBZDNpTBzFWCo/A2BpYFSVfvH/byHrlhAUUVf74UULlMikYU25
   VhoGgl1HpFgDHP7Z6X+qIp6r/FCG2tjNdTrcMqDo2bRC9nu7g8mN/v+nw
   6Ips42p8ADa7I4CVF1F3qk+vB1ZJRv499zaNHY8rA+3RnoV06LCSn3VjW
   w==;
X-CSE-ConnectionGUID: eGyJvwGRSOKSbqOR2wgwYw==
X-CSE-MsgGUID: EboAxIFfT5qIK23zQ88kTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9204855"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9204855"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:55:27 -0700
X-CSE-ConnectionGUID: BRMNBJ1DTxOiScOWaf1H3A==
X-CSE-MsgGUID: Y3uqJNdJToyBcARFJe13cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23040305"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:55:25 -0700
Date: Thu, 18 Apr 2024 13:55:03 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Shay Drori <shayd@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 8/8] ice: allow to activate and deactivate
 subfunction
Message-ID: <ZiEKF8Hm+ccuVedQ@mev-dev>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-9-michal.swiatkowski@linux.intel.com>
 <0045c1a5-1065-40b3-ae61-1f372d4a89e5@nvidia.com>
 <1b678660-7ee7-44d0-91a7-14985d2c469e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b678660-7ee7-44d0-91a7-14985d2c469e@nvidia.com>

On Thu, Apr 18, 2024 at 11:12:47AM +0300, Shay Drori wrote:
> resend as plain test
> 
> On 18/04/2024 10:53, Shay Drori wrote:
> > On 17/04/2024 17:20, Michal Swiatkowski wrote:
> > > +/**
> > > + * ice_devlink_port_fn_state_get - devlink handler for port state get
> > > + * @port: pointer to devlink port
> > > + * @state: admin configured state of the port
> > > + * @opstate: current port operational state
> > > + * @extack: extack for reporting error messages
> > > + *
> > > + * Gets port state.
> > > + *
> > > + * Return: zero on success or an error code on failure.
> > > + */
> > > +static int
> > > +ice_devlink_port_fn_state_get(struct devlink_port *port,
> > > +			      enum devlink_port_fn_state *state,
> > > +			      enum devlink_port_fn_opstate *opstate,
> > > +			      struct netlink_ext_ack *extack)
> > > +{
> > > +	struct ice_dynamic_port *dyn_port;
> > > +
> > > +	dyn_port = ice_devlink_port_to_dyn(port);
> > > +
> > > +	if (dyn_port->active) {
> > > +		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
> > > +		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
> > 
> > 
> > DEVLINK_PORT_FN_OPSTATE_ATTACHED means the SF is up/bind[1].
> > ice is using auxiliary bus for SFs, which means user can unbind it
> > via the auxiliary sysfs (/sys/bus/auxiliary/drivers/ice_sf/unbind).
> > In this case[2], you need to return:
> > *state = DEVLINK_PORT_FN_STATE_ACTIVE;
> > *opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
> > 

Thanks, I didn't think about unbinding/binding the aux driver via sysfs.

To be sure:
- user create the subfunction:
INACTIVE, DETACHED
- user activate it:
ACTIVE, ATTACHED
- user unbind driver:
ACTIVE, DETACHED
- user can bind it again as long as subfunction port is ACTIVE
is it right?

I will fix the comment from previous patch and add state tracking for
ATTACHED/DETACHED.

Thanks,
Michal

> > 
> > [1]
> > Documentation from include/uapi/linux/devlink.h:
> > 
> > * @DEVLINK_PORT_FN_OPSTATE_ATTACHED: Driver is attached to the function.
> > <...>
> > * @DEVLINK_PORT_FN_OPSTATE_DETACHED: Driver is detached from the function.
> > 
> > > +	} else {
> > > +		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
> > > +		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +

