Return-Path: <netdev+bounces-119402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F8955779
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848D71C20DBA
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F311494DB;
	Sat, 17 Aug 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WS5tyAuN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2620328B6
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894600; cv=none; b=iEo6EfMDgdcLZGEfYFlj8aS7aOBilhzFINTo31yJhwecIZBUUEkG32Shg8/Tw4GSnrLWVV3Em3IiY5TWax2qSMYpT0YrguUBM4Qk1bfh1pT2MSAnMRf/rvgZ/iidUOQuAc7giX2NYpVrDNjFoEGVTxF6lX3vhFagcFdUcagCXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894600; c=relaxed/simple;
	bh=rnvomaqO9h0Elw8o0f0lOwSI1b/STBLlNMzFPIg2uHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP2qFn8Vzm3SiZSbYa3OwmmXHagD6ZMvhN0LyP3nOV0W+GC/lMBC1cPldzB7PFXUdfg71E8yBcNLvuB5qFsVPrIuX4kxemgB49IicpcVBGDSB4BGvXeFO20ch2HnquAvPllEjfyg2v1GzbmRIzAj+WVPrI4WOnaxX/HZqgIwoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WS5tyAuN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723894598; x=1755430598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnvomaqO9h0Elw8o0f0lOwSI1b/STBLlNMzFPIg2uHw=;
  b=WS5tyAuNOzLZvY7DmILlNQgMy0yrklBEG1kng5d8nQKsSfXdCch8ZcoI
   /4JOXxfnGH4Xwh/90dRArw5y48gYvfQNXBzjq0Qd9heEujiJLzSBwVRx4
   VsaXIbqqOJ6zgObqq3DGtu3YCynHf48kxH05naYQ1ZeZK5FNMCRx6IHso
   pJAVCZBhc6wAfI5CgPAQuZ2xqG7nYByM59vwftXl6HTDN3MvPRckgyKix
   TLLSGIixLj+/T1wSt90km9X7r3eIGMb60tpIgSWWsWoXeEOntfH5Yqx/9
   dxh5y7a6KcrvSTfWGEUg1vEwrPkH+dLh3oM4mEv5RhLcr+HN1lhBvwo3W
   A==;
X-CSE-ConnectionGUID: /vx3QjvXS7WMjHQAte85CA==
X-CSE-MsgGUID: 4tffijALQBqiKPRHjimlxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22325212"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="22325212"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:36:37 -0700
X-CSE-ConnectionGUID: pURhcwnnQ7qY/LNEVrP5+w==
X-CSE-MsgGUID: TLdb0CrPQ4eIYWGClgWl7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="60471719"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Aug 2024 04:36:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfHjU-0007P1-1F;
	Sat, 17 Aug 2024 11:36:32 +0000
Date: Sat, 17 Aug 2024 19:36:31 +0800
From: kernel test robot <lkp@intel.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCH net-next 1/2] bonding: Add ESN support to IPSec HW offload
Message-ID: <202408171959.Qj3TkV2v-lkp@intel.com>
References: <20240816035518.203704-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816035518.203704-2-liuhangbin@gmail.com>

Hi Hangbin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangbin-Liu/bonding-Add-ESN-support-to-IPSec-HW-offload/20240816-122016
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240816035518.203704-2-liuhangbin%40gmail.com
patch subject: [PATCH net-next 1/2] bonding: Add ESN support to IPSec HW offload
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20240817/202408171959.Qj3TkV2v-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171959.Qj3TkV2v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171959.Qj3TkV2v-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/bonding/bond_main.c: In function 'bond_advance_esn_state':
>> drivers/net/bonding/bond_main.c:639:28: warning: unused variable 'ipsec' [-Wunused-variable]
     639 |         struct bond_ipsec *ipsec;
         |                            ^~~~~


vim +/ipsec +639 drivers/net/bonding/bond_main.c

   631	
   632	/**
   633	 * bond_advance_esn_state - ESN support for IPSec HW offload
   634	 * @xs: pointer to transformer state struct
   635	 **/
   636	static void bond_advance_esn_state(struct xfrm_state *xs)
   637	{
   638		struct net_device *bond_dev = xs->xso.dev;
 > 639		struct bond_ipsec *ipsec;
   640		struct bonding *bond;
   641		struct slave *slave;
   642	
   643		if (!bond_dev)
   644			return;
   645	
   646		rcu_read_lock();
   647		bond = netdev_priv(bond_dev);
   648		slave = rcu_dereference(bond->curr_active_slave);
   649	
   650		if (!slave)
   651			goto out;
   652	
   653		if (!xs->xso.real_dev)
   654			goto out;
   655	
   656		WARN_ON(xs->xso.real_dev != slave->dev);
   657	
   658		if (!slave->dev->xfrmdev_ops ||
   659		    !slave->dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
   660			slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_advance_esn\n", __func__);
   661			goto out;
   662		}
   663	
   664		slave->dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
   665	out:
   666		rcu_read_unlock();
   667	}
   668	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

