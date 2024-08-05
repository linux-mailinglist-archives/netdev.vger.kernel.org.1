Return-Path: <netdev+bounces-115627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6B947472
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B55E1C208E6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6C13D50E;
	Mon,  5 Aug 2024 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0zaA3E1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E13A94B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722833768; cv=none; b=sgAXyFzE9dTOBJE2YTGKV+p259Y6EqyeDKDzxRV4U3DeMKiKpFnTT9o5f27Zxtn/FtTwgiAHuGbsQzpcj+tyVTKTaEJpOTXcSBBT95HCN3gJKxHqmBC9TRWtR525ETDgjp2FOlUjAIAzf5zRUempV+/tKmIYAIjdvr3qASFS89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722833768; c=relaxed/simple;
	bh=xZighTmIriPAEYCgF4bL8Fze0gvxTtk32s++G3iAKJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI8Je0aLotEWZZPIlWgf3WHc2IJ9DsQh8lU2vihV2Y5cnHzRF4pZdKL9aAj3LbEveK6/W4KA3QSDroPrjcHOtGYSzGAzYYdkoViLjtxe0Y17PGI8BOM4TdSNssgoil+DFcNvUG8ueKAZbOmagW5cYaFSzZ1IcnZ1ckDE6Kavqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0zaA3E1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722833764; x=1754369764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xZighTmIriPAEYCgF4bL8Fze0gvxTtk32s++G3iAKJU=;
  b=W0zaA3E1TE2SFgj/YkQwWpJH+H8CwQj0hIhEooK3Owd49OhJ7kctM9od
   HmGwzwoHLnKfjI46YfZ7oPmOInw6uIGLJk0O+ynDKSpHUycP5hXPi2TlD
   5SQ9PiDULdnzn1kvNZFFPx7kJ+d1QTWWC5t1zeQKGYzEyQMlByryWlNaw
   CKLSgGMa+bVxxOL++lO44II+dGqJxooid7rgk5etyxzY8VG0sDd2x8aBb
   gglTLPCqTjAh+4ZcUG3SMs+RdEcKqG5red7XW2x5BHQOF86fgiQKKCmPi
   KcsBHb6LonuPad8oYisLfQ6U+UlgKAfSj65HlwwPyrcEPqQJ/8+unhcvJ
   Q==;
X-CSE-ConnectionGUID: /uE7ZEDHQsaeotzVK6NZIA==
X-CSE-MsgGUID: 1cF4joIkSx2cAgP1Sbb0wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="32178853"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="32178853"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 21:56:04 -0700
X-CSE-ConnectionGUID: uIp9IkCLTWOWDHAoPgKMGw==
X-CSE-MsgGUID: Pr6HYWGzSy+L6R1T9pTvWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="93570466"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 21:56:01 -0700
Date: Mon, 5 Aug 2024 06:54:23 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, jiri@resnulli.us,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [iwl-next v2 0/7] ice: managing MSI-X in driver
Message-ID: <ZrBa/7ZchA+z6Equ@mev-dev.igk.intel.com>
References: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
 <a146a6cb-9828-4c2e-a5ca-ccd6af8af040@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a146a6cb-9828-4c2e-a5ca-ccd6af8af040@intel.com>

On Fri, Aug 02, 2024 at 02:41:54PM +0200, Przemek Kitszel wrote:
> On 8/1/24 11:31, Michal Swiatkowski wrote:
> > Hi,
> > 
> > It is another try to allow user to manage amount of MSI-X used for each
> > feature in ice. First was via devlink resources API, it wasn't accepted
> > in upstream. Also static MSI-X allocation using devlink resources isn't
> > really user friendly.
> > 
> > This try is using more dynamic way. "Dynamic" across whole kernel when
> > platform supports it and "dynamic" across the driver when not.
> > 
> > To achieve that reuse global devlink parameter pf_msix_max and
> > pf_msix_min. It fits how ice hardware counts MSI-X. In case of ice amount
> > of MSI-X reported on PCI is a whole MSI-X for the card (with MSI-X for
> > VFs also). Having pf_msix_max allow user to statically set how many
> > MSI-X he wants on PF and how many should be reserved for VFs.
> > 
> > pf_msix_min is used to set minimum number of MSI-X with which ice driver
> > should probe correctly.
> > 
> > Meaning of this field in case of dynamic vs static allocation:
> > - on system with dynamic MSI-X allocation support
> >   * alloc pf_msix_min as static, rest will be allocated dynamically
> > - on system without dynamic MSI-X allocation support
> >   * try alloc pf_msix_max as static, minimum acceptable result is
> >   pf_msix_min
> > 
> > As Jesse and Piotr suggested pf_msix_max and pf_msix_min can (an
> > probably should) be stored in NVM. This patchset isn't implementing
> > that.
> > 
> > Dynamic (kernel or driver) way means that splitting MSI-X across the
> > RDMA and eth in case there is a MSI-X shortage isn't correct. Can work
> > when dynamic is only on driver site, but can't when dynamic is on kernel
> > site.
> > 
> > Let's remove this code and move to MSI-X allocation feature by feature.
> > If there is no more MSI-X for a feature, a feature is working with less
> > MSI-X or it is turned off.
> > 
> > There is a regression here. With MSI-X splitting user can run RDMA and
> > eth even on system with not enough MSI-X. Now only eth will work. RDMA
> > can be turned on by changing number of PF queues (lowering) and reprobe
> > RDMA driver.
> > 
> > Example:
> > 72 CPU number, eth, RDMA and flow director (1 MSI-X), 1 MSI-X for OICR
> > on PF, and 1 more for RDMA. Card is using 1 + 72 + 1 + 72 + 1 = 147.
> > 
> > We set pf_msix_min = 2, pf_msix_max = 128
> > 
> > OICR: 1
> > eth: 72
> > RDMA: 128 - 73 = 55
> > flow director: turned off not enough MSI-X
> > 
> > We can change number of queues on pf to 36 and do devlink reinit
> > 
> > OICR: 1
> > eth: 36
> > RDMA: 73
> > flow director: 1
> > 
> > We can also (implemented in "ice: enable_rdma devlink param") turned
> > RDMA off.
> > 
> > OICR: 1
> > eth: 72
> > RDMA: 0 (turned off)
> > flow director: 1
> > 
> > Maybe flow director should have higher priority than RDMA? It needs only
> > 1 MSI-X, so it seems more logic to lower RDMA by one then maxing MSI-X
> > on RDMA and turning off flow director (as default).
> 
> sounds better, less surprising, with only RDMA being affected by this
> series as "regression"
> 

Sounds reasonable

> > 
> > After this changes we have a static base vector for SRIOV (SIOV probably
> > in the feature). Last patch from this series is simplifying managing VF
> > MSI-X code based on static vector.
> > 
> > Now changing queues using ethtool is also changing MSI-X. If there is
> > enough MSI-X it is always one to one. When there is not enough there
> > will be more queues than MSI-X. There is a lack of ability to set how
> > many queues should be used per MSI-X. Maybe we should introduce another
> > ethtool param for it? Sth like queues_per_vector?
> 
> Our 1:1 mapping was too rigid solution (but performant), I like MSI-Xes
> being kept as a detail and [setting of them] decoupled from being
> mandatory on [at least some] flows. Tuning the mapping could be useful,
> esp in heterotelic scenarios (like keeping XDP stuff separate). Could be
> left for the future.
> 
> What happens when user decreases number of MSI-X, queues will just get
> remapped to other?
>

Yes, queue will be remapped

> > 
> > v1 --> v2: [1]
> >   * change permanent MSI-X cmode parameters to driverinit
> >   * remove locking during devlink parameter registration (it is now
> >     locked for whole init/deinit part)
> > 
> > [1] https://lore.kernel.org/netdev/20240213073509.77622-1-michal.swiatkowski@linux.intel.com/
> > 
> > Michal Swiatkowski (7):
> >    ice: devlink PF MSI-X max and min parameter
> >    ice: remove splitting MSI-X between features
> >    ice: get rid of num_lan_msix field
> >    ice, irdma: move interrupts code to irdma
> >    ice: treat dyn_allowed only as suggestion
> >    ice: enable_rdma devlink param
> >    ice: simplify VF MSI-X managing
> > 
> >   drivers/infiniband/hw/irdma/hw.c              |   2 -
> >   drivers/infiniband/hw/irdma/main.c            |  46 ++-
> >   drivers/infiniband/hw/irdma/main.h            |   3 +
> >   .../net/ethernet/intel/ice/devlink/devlink.c  |  75 ++++-
> >   drivers/net/ethernet/intel/ice/ice.h          |  21 +-
> >   drivers/net/ethernet/intel/ice/ice_base.c     |  10 +-
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
> >   drivers/net/ethernet/intel/ice/ice_idc.c      |  64 +---
> >   drivers/net/ethernet/intel/ice/ice_irq.c      | 277 ++++++------------
> >   drivers/net/ethernet/intel/ice/ice_irq.h      |  13 +-
> >   drivers/net/ethernet/intel/ice/ice_lib.c      |  36 ++-
> >   drivers/net/ethernet/intel/ice/ice_sriov.c    | 153 +---------
> >   include/linux/net/intel/iidc.h                |   2 +
> >   13 files changed, 287 insertions(+), 423 deletions(-)
> > 
> 

