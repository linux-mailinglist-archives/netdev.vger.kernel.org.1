Return-Path: <netdev+bounces-123875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEE966B57
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EDE1F23488
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349CF174EFC;
	Fri, 30 Aug 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpPb3Uqq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8608415C153;
	Fri, 30 Aug 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053864; cv=none; b=F2IEtQX2sMJFx56xozELY3kL9DunIY8VD0VoTNCpP7cq63sGPrlhJxm1hvo1GUoDr/5yvOk15t81zZNIY7zUWtXZg1sIF29TMgizxPSir6XhjafHqvoKfmn6463MgY6DIfE1DgfOBB8jU8mCDGfyBQfX1i7n0VbG2yUy2VpFHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053864; c=relaxed/simple;
	bh=NMkRApkrOKWbtVRfnehMf4mTd0oXInv2mc61RoHBklE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFHI7DY4fgMjwH5bTAFxXok00y9B80sl9TffGM19SkONw3WMUbHpiOAPV9ayhlBkUqxS7z7ouIkhftmjbcWppHh5+3I30KdllI5GwixSiclDq+OKgg1eFScJsTaast3dUj1a93PVq7TN48x0xRynea+fB1OjmP8SieNzPCzTyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpPb3Uqq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725053863; x=1756589863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NMkRApkrOKWbtVRfnehMf4mTd0oXInv2mc61RoHBklE=;
  b=TpPb3UqqGdty5scaLTM1j9oDqi7DwOSY2NScp/s2ZkHOZaWwL99o0Ezw
   OtUOXCwiQfj4h0HySGhVeiKiV8btoI14pd4mWQRoiYMIVKkOkn12fFQoL
   ORwHaLeubZkiXfa4nXl1U5PimtWbEYnKYWGFbTZoBlFFO33poIhHD40pv
   Op39Kr4dGfxDEys335yot7e68HfQr19U2oJl35LnAV7GkWbKZBxcoWgx6
   V/PdoQQMujesDkUi4PNpJ/eOQa8ImogmPGoPqIs1nxGUh1zZ1FuQkDbMZ
   7HS6OW+KmUacOv+c4ZhAXsYR+1mO0auNEkZ4G0YFW88+MD73fHGwKkfGl
   Q==;
X-CSE-ConnectionGUID: OcbHASEnTyiE0V/sjzNVqw==
X-CSE-MsgGUID: UNhDjZuwQ9Ot2eYKXxO7pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="27474608"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="27474608"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:37:42 -0700
X-CSE-ConnectionGUID: Z8u/uYXNQKyHU/qNmOPM7Q==
X-CSE-MsgGUID: iZwp9e8PQq++8H0QPaEshA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68818300"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Aug 2024 14:37:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk9JJ-000296-2B;
	Fri, 30 Aug 2024 21:37:37 +0000
Date: Sat, 31 Aug 2024 05:37:31 +0800
From: kernel test robot <lkp@intel.com>
To: Wan Junjie <junjie.wan@inceptio.ai>,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"junjie.wan" <junjie.wan@inceptio.ai>
Subject: Re: [PATCH] dpaa2-switch: fix flooding domain among multiple vlans
Message-ID: <202408310505.RxA0GVcf-lkp@intel.com>
References: <20240827110855.3186502-1-junjie.wan@inceptio.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827110855.3186502-1-junjie.wan@inceptio.ai>

Hi Wan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc5 next-20240830]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wan-Junjie/dpaa2-switch-fix-flooding-domain-among-multiple-vlans/20240827-191121
base:   linus/master
patch link:    https://lore.kernel.org/r/20240827110855.3186502-1-junjie.wan%40inceptio.ai
patch subject: [PATCH] dpaa2-switch: fix flooding domain among multiple vlans
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240831/202408310505.RxA0GVcf-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310505.RxA0GVcf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310505.RxA0GVcf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:179:11: warning: unused variable 'i' [-Wunused-variable]
     179 |         int err, i;
         |                  ^
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:1784:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
    1784 |                 return err;
         |                 ^
   drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c:1782:2: note: previous statement is here
    1782 |         if (err)
         |         ^
   2 warnings generated.


vim +/if +1784 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c

  1766	
  1767	static int dpaa2_switch_port_flood(struct ethsw_port_priv *port_priv,
  1768					   struct switchdev_brport_flags flags)
  1769	{
  1770		struct ethsw_core *ethsw = port_priv->ethsw_data;
  1771		struct net_device *netdev = port_priv->netdev;
  1772		int err;
  1773	
  1774		if (flags.mask & BR_BCAST_FLOOD)
  1775			port_priv->bcast_flood = !!(flags.val & BR_BCAST_FLOOD);
  1776	
  1777		if (flags.mask & BR_FLOOD)
  1778			port_priv->ucast_flood = !!(flags.val & BR_FLOOD);
  1779	
  1780		/* Recreate the egress flood domain of every vlan domain */
  1781		err = vlan_for_each(netdev, dpaa2_switch_port_flood_vlan, netdev);
  1782		if (err)
  1783			netdev_err(netdev, "Unable to restore vlan flood err (%d)\n", err);
> 1784			return err;
  1785	
  1786		return dpaa2_switch_fdb_set_egress_flood(ethsw, port_priv->fdb->fdb_id);
  1787	}
  1788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

