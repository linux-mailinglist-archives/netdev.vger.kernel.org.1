Return-Path: <netdev+bounces-144893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1E59C89EE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357741F24A75
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A1B1F9A8D;
	Thu, 14 Nov 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6ANVn1s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9121F8EF6
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731587171; cv=none; b=hMtYRinRpIOr0Ijpr9/2vD7MQUDZzBJuk6etgCOFEYhquOLlTeAu8IClg6vDG2O8V2ALgiHnsJmlg7BczEZ7j/YHXIZp4Z91BK3iOABz26+YAvx/09lgSdedvtmi06H+4N5en9SCD80xZBD6yeyTOLsF0mOwAZw+oebBSUnJ2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731587171; c=relaxed/simple;
	bh=xxSuO9AiJJjx/xH9Tt98F//SeNwQX07KquLKhoofh9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1g0sqzDvhb78yclqRdEHYsudJ27DAJHvuU/ISb/usk3ohSzFfJndxQ+qEQgmGTdNcSsUiyXr3mjFenD677CDzd6lpqOxn3Ywo4q2SKH6GZqJ0d73YH9mzPEhZOvBu1y1biFVelV05/LDz19KqIk3b6hv3u19VqepXx/2cPDxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6ANVn1s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731587170; x=1763123170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xxSuO9AiJJjx/xH9Tt98F//SeNwQX07KquLKhoofh9E=;
  b=F6ANVn1sa4wPBhXyY7xFr4BArYqyJKx8tPqoX4IK8yoUJRuqYXgYPoSA
   W91EBFeaAMtgMBJffH59lL2u/kTpRQesWGtfINZIljrp8NfE/gezcNO7L
   0dJAOwqTRgPy0UfqWPWzOR0v/TS+CeRM1mGKjNVNK29+X1sFujYQV6vss
   IbbEt5LQuyvGlXZhohtSKayoDZMfPf0tKt3s+HmQXSrUsAWGMidi8HIbF
   eCoi7WFgJnFW1T4sclXv9nP2hiLIVZQkTtCyyGQqPnOLZrQBx+mqARjgh
   DRAkbNSwdWPQOc5oM9uvwU8vtnO9lUz9MTDCiOjL87J/UrMllG1QojK8T
   A==;
X-CSE-ConnectionGUID: zSJpmpoTS6uaDSoOEuXkSA==
X-CSE-MsgGUID: fNbllqF4SiK+whyOd1RbPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42632897"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42632897"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:26:09 -0800
X-CSE-ConnectionGUID: k/YvxhfQRESD5Ed33skhRA==
X-CSE-MsgGUID: 1c3aEhXUQsGT1LcTVsXW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88354606"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:26:05 -0800
Date: Thu, 14 Nov 2024 13:23:04 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
	jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com,
	pmenzel@molgen.mpg.de, mschmidt@redhat.com,
	rafal.romanowski@intel.com
Subject: Re: [iwl-next v8 0/9] ice: managing MSI-X in driver
Message-ID: <ZzXrhmigZFGB3//J@mev-dev.igk.intel.com>
References: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>

On Thu, Nov 14, 2024 at 01:18:32PM +0100, Michal Swiatkowski wrote:
> Hi,
> 
> It is another try to allow user to manage amount of MSI-X used for each
> feature in ice. First was via devlink resources API, it wasn't accepted
> in upstream. Also static MSI-X allocation using devlink resources isn't
> really user friendly.
> 
> This try is using more dynamic way. "Dynamic" across whole kernel when
> platform supports it and "dynamic" across the driver when not.
> 
> To achieve that reuse global devlink parameter pf_msix_max and
> pf_msix_min. It fits how ice hardware counts MSI-X. In case of ice amount
> of MSI-X reported on PCI is a whole MSI-X for the card (with MSI-X for
> VFs also). Having pf_msix_max allow user to statically set how many
> MSI-X he wants on PF and how many should be reserved for VFs.
> 
> pf_msix_min is used to set minimum number of MSI-X with which ice driver
> should probe correctly.
> 
> Meaning of this field in case of dynamic vs static allocation:
> - on system with dynamic MSI-X allocation support
>  * alloc pf_msix_min as static, rest will be allocated dynamically
> - on system without dynamic MSI-X allocation support
>  * try alloc pf_msix_max as static, minimum acceptable result is
>  pf_msix_min
> 
> As Jesse and Piotr suggested pf_msix_max and pf_msix_min can (an
> probably should) be stored in NVM. This patchset isn't implementing
> that.
> 
> Dynamic (kernel or driver) way means that splitting MSI-X across the
> RDMA and eth in case there is a MSI-X shortage isn't correct. Can work
> when dynamic is only on driver site, but can't when dynamic is on kernel
> site.
> 
> Let's remove this code and move to MSI-X allocation feature by feature.
> If there is no more MSI-X for a feature, a feature is working with less
> MSI-X or it is turned off.
> 
> There is a regression here. With MSI-X splitting user can run RDMA and
> eth even on system with not enough MSI-X. Now only eth will work. RDMA
> can be turned on by changing number of PF queues (lowering) and reprobe
> RDMA driver.
> 
> Example:
> 72 CPU number, eth, RDMA and flow director (1 MSI-X), 1 MSI-X for OICR
> on PF, and 1 more for RDMA. Card is using 1 + 72 + 1 + 72 + 1 = 147.
> 
> We set pf_msix_min = 2, pf_msix_max = 128
> 
> OICR: 1
> eth: 72
> flow director: 1
> RDMA: 128 - 74 = 54
> 
> We can change number of queues on pf to 36 and do devlink reinit
> 
> OICR: 1
> eth: 36
> RDMA: 73
> flow director: 1
> 
> We can also (implemented in "ice: enable_rdma devlink param") turned
> RDMA off.
> 
> OICR: 1
> eth: 72
> RDMA: 0 (turned off)
> flow director: 1
> 
> After this changes we have a static base vector for SRIOV (SIOV probably
> in the feature). Last patch from this series is simplifying managing VF
> MSI-X code based on static vector.
> 
> Now changing queues using ethtool is also changing MSI-X. If there is
> enough MSI-X it is always one to one. When there is not enough there
> will be more queues than MSI-X. There is a lack of ability to set how
> many queues should be used per MSI-X. Maybe we should introduce another
> ethtool param for it? Sth like queues_per_vector?
> 
> v7 --> v8: [7]
>  * fix unrolling in devlink parameters register function (patch 2)
> 
> v6 --> v7: [6]
>  * use vu32 for devlink MSI-X parameters instead of u16 (patch 2)
>  * < instead of <= for MSI-X min parameter validation (patch 2)
>  * use u32 for MSI-X values (patch 2, 8)
> 
> v5 --> v6: [5]
>  * set default MSI-X max value based on needs instead of const define
>    (patch 3)
> 
> v4 --> v5: [4]
>  * count combined queues in ethtool for case the vectors aren't mapped
>    1:1 to queues (patch 1)
>  * change min_t to min where the casting isn't needed (and can hide
>    problems) (patch 4)
>  * load msix_max and msix_min value after devlink reload; it accidentally
>    wasn't added after removing loading in probe path to mitigate error
>    from devl_para_driverinit...() (patch 2)
>  * add documentation in develink/ice for new parameters (patch 2)
> 
> v3 --> v4: [3]
>  * drop unnecessary text in devlink validation comments
>  * assume that devl_param_driverinit...() shouldn't return error in
>    normal execution path
> 
> v2 --> v3: [2]
>  * move flow director init before RDMA init
>  * fix unrolling RDMA MSI-X allocation
>  * add comment in commit message about lowering control RDMA MSI-X
>    amount
> 
> v1 --> v2: [1]
>  * change permanent MSI-X cmode parameters to driverinit
>  * remove locking during devlink parameter registration (it is now
>    locked for whole init/deinit part)
> 
> [7] https://lore.kernel.org/netdev/20241104121337.129287-1-michal.swiatkowski@linux.intel.com/
> [6] https://lore.kernel.org/netdev/20241028100341.16631-1-michal.swiatkowski@linux.intel.com/
> [5] https://lore.kernel.org/netdev/20241024121230.5861-1-michal.swiatkowski@linux.intel.com/T/#t
> [4] https://lore.kernel.org/netdev/20240930120402.3468-1-michal.swiatkowski@linux.intel.com/
> [3] https://lore.kernel.org/netdev/20240808072016.10321-1-michal.swiatkowski@linux.intel.com/
> [2] https://lore.kernel.org/netdev/20240801093115.8553-1-michal.swiatkowski@linux.intel.com/
> [1] https://lore.kernel.org/netdev/20240213073509.77622-1-michal.swiatkowski@linux.intel.com/
> 
> Note: previous patchset is on dev-queue. I will be unavailable some
> time, so sending fixed next version basing it on Tony main.

Sorry, first time trying to send with base-commit option. I messed it.
The difference between this and previous version is only in patch 2.

> 
> Michal Swiatkowski (8):
>   ice: devlink PF MSI-X max and min parameter
>   ice: remove splitting MSI-X between features
>   ice: get rid of num_lan_msix field
>   ice, irdma: move interrupts code to irdma
>   ice: treat dyn_allowed only as suggestion
>   ice: enable_rdma devlink param
>   ice: simplify VF MSI-X managing
>   ice: init flow director before RDMA
> 
>  Documentation/networking/devlink/ice.rst      |  11 +
>  drivers/infiniband/hw/irdma/hw.c              |   2 -
>  drivers/infiniband/hw/irdma/main.c            |  46 ++-
>  drivers/infiniband/hw/irdma/main.h            |   3 +
>  .../net/ethernet/intel/ice/devlink/devlink.c  | 109 +++++++
>  drivers/net/ethernet/intel/ice/ice.h          |  21 +-
>  drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   6 +-
>  drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
>  drivers/net/ethernet/intel/ice/ice_irq.c      | 275 ++++++------------
>  drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  35 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 154 +---------
>  include/linux/net/intel/iidc.h                |   2 +
>  15 files changed, 335 insertions(+), 422 deletions(-)
> 
> 
> base-commit: 31a1f8752f7df7e3d8122054fbef02a9a8bff38f
> -- 
> 2.42.0
> 


