Return-Path: <netdev+bounces-95456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AB28C24CC
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155822815ED
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7D487BC;
	Fri, 10 May 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlLCLxC7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86906182BB
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344041; cv=none; b=bu8OGAXYVPYF/c/qipSPiS70V+KgoXhx1DvFax5sJ1DgYF+Wu/sJiPWCQlwdsUXUskRMPMlmWALlt+CMuKsurEksmJ3osSnQJ/om1RwFAoQisjQ/pSwaL7tmYoy011a3MZm11/rqLHd+ikMR7hMGut/B83HcD+5eEfa+0mlpUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344041; c=relaxed/simple;
	bh=3QOPJukGU6uFHgR5tNYJ36zcuIs6vwSXJ/cY9HhVQL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsCWGqmgMKHNXOCaZoCEzLmo0ooQMRpWcgMB+GH7FmGj/Vk6NCGbneN8x9+/5CjO1bw72zCTpISXORcG6/AReukCMQOL0o4jHnUUzhGzkXIBkmKvtgx11bM21CBIj9J73EhnMRPZOyx+g3oWJW+pJNAPh6iGwpGlTCPWDUQ989w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlLCLxC7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715344040; x=1746880040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3QOPJukGU6uFHgR5tNYJ36zcuIs6vwSXJ/cY9HhVQL4=;
  b=RlLCLxC7+VhlCcpitcuUpXWqEpS/3QXw1ffir7kpW7aOyRLl7OWGueyq
   ZhOLZDFv5CPA8h8ZKi5AZIjDfvuJ2XDoU8kfBUmWUiLSlEqunV3rDtvZY
   43Xlp+ZQMon4lIRTga21+ksup63i0eTTkHpZ6ddbCdJwpqAEL5gpwm3bB
   03mpzJOFBbIr1NAwUoUI10HJc1bYd8R9Xg+Sb+M27D5MUJhtY/7+XOCTW
   d0sbaI8S4sV8jy0pIYaMazBHLBdRrRT/EnjMkcLDdzH2KWGb4H+yj+KFe
   11cZqJrjPAMKCk9177dTYQEKXZUAioI0ITtFpHeiZd/RfcmjEYS7qUSy0
   A==;
X-CSE-ConnectionGUID: hwWcWncoT3O0i0hoyuwYIQ==
X-CSE-MsgGUID: mrN7m4rOSR6lFdnj/LOWOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11448561"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11448561"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:27:19 -0700
X-CSE-ConnectionGUID: j3N3MwOeReK7huCho3WGBg==
X-CSE-MsgGUID: pOF2BCpvRButj3Hp/or91g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29618221"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:27:16 -0700
Date: Fri, 10 May 2024 14:26:44 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: shayd@nvidia.com, maciej.fijalkowski@intel.com,
	mateusz.polchlopek@intel.com, netdev@vger.kernel.org,
	jiri@nvidia.com, michal.kubiak@intel.com,
	intel-wired-lan@lists.osuosl.org, pio.raczynski@gmail.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	wojciech.drewek@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v1 00/14] ice: support devlink
 subfunction
Message-ID: <Zj4ShOiyrGQK8J6p@mev-dev>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <ZjyxBcVZNbWioRP0@nanopsycho.orion>
 <Zj3LwDMbktRXk0QX@mev-dev>
 <Zj4AYN4uDtL51G1P@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj4AYN4uDtL51G1P@nanopsycho.orion>

On Fri, May 10, 2024 at 01:09:20PM +0200, Jiri Pirko wrote:
> Fri, May 10, 2024 at 09:24:48AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Thu, May 09, 2024 at 01:18:29PM +0200, Jiri Pirko wrote:
> >> Tue, May 07, 2024 at 01:45:01PM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >Hi,
> >> >
> >> >Currently ice driver does not allow creating more than one networking
> >> >device per physical function. The only way to have more hardware backed
> >> >netdev is to use SR-IOV.
> >> >
> >> >Following patchset adds support for devlink port API. For each new
> >> >pcisf type port, driver allocates new VSI, configures all resources
> >> >needed, including dynamically MSIX vectors, program rules and registers
> >> >new netdev.
> >> >
> >> >This series supports only one Tx/Rx queue pair per subfunction.
> >> >
> >> >Example commands:
> >> >devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
> >> >devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
> >> >devlink port function set pci/0000:31:00.1/1 state active
> >> >devlink port function del pci/0000:31:00.1/1
> >> >
> >> >Make the port representor and eswitch code generic to support
> >> >subfunction representor type.
> >> >
> >> >VSI configuration is slightly different between VF and SF. It needs to
> >> >be reflected in the code.
> >> >
> >> >Most recent previous patchset (not containing port representor for SF
> >> >support). [1]
> >> >
> >> >[1] https://lore.kernel.org/netdev/20240417142028.2171-1-michal.swiatkowski@linux.intel.com/
> >> >
> >> 
> >> 
> >> I don't understand howcome the patchset is v1, yet there are patches
> >> that came through multiple iterations alread. Changelog is missing
> >> completely :/
> >> 
> >
> >What is wrong here? There is a link to previous patchset with whole
> >changlog and links to previous ones. I didn't add changlog here as it is
> >new patchset (partialy the same as from [1], because of that I added a
> >link). I can add the changlog from [1] if you want, but for me it can be
> >missleading.
> 
> It's always good to see what you changed if you send modified patches.
> That's all.
> 

I will paste previous changelog in next version so.

> 
> >
> >> 
> >> >Michal Swiatkowski (7):
> >> >  ice: treat subfunction VSI the same as PF VSI
> >> >  ice: create port representor for SF
> >> >  ice: don't set target VSI for subfunction
> >> >  ice: check if SF is ready in ethtool ops
> >> >  ice: netdevice ops for SF representor
> >> >  ice: support subfunction devlink Tx topology
> >> >  ice: basic support for VLAN in subfunctions
> >> >
> >> >Piotr Raczynski (7):
> >> >  ice: add new VSI type for subfunctions
> >> >  ice: export ice ndo_ops functions
> >> >  ice: add basic devlink subfunctions support
> >> >  ice: allocate devlink for subfunction
> >> >  ice: base subfunction aux driver
> >> >  ice: implement netdev for subfunction
> >> >  ice: allow to activate and deactivate subfunction
> >> >
> >> > drivers/net/ethernet/intel/ice/Makefile       |   2 +
> >> > .../net/ethernet/intel/ice/devlink/devlink.c  |  48 ++
> >> > .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
> >> > .../ethernet/intel/ice/devlink/devlink_port.c | 516 ++++++++++++++++++
> >> > .../ethernet/intel/ice/devlink/devlink_port.h |  43 ++
> >> > drivers/net/ethernet/intel/ice/ice.h          |  19 +-
> >> > drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
> >> > drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
> >> > drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 ++-
> >> > drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
> >> > drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
> >> > drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
> >> > drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
> >> > drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
> >> > drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++++--
> >> > drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
> >> > drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 329 +++++++++++
> >> > drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
> >> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
> >> > .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
> >> > drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> >> > drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
> >> > drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
> >> > drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> >> > .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
> >> > drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
> >> > 26 files changed, 1362 insertions(+), 138 deletions(-)
> >> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
> >> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
> >> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
> >> > create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h
> >> >
> >> >-- 
> >> >2.42.0
> >> >
> >> >

