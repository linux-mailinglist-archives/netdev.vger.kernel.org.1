Return-Path: <netdev+bounces-153946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A546C9FA24F
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 21:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81AA18881B9
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B227189F39;
	Sat, 21 Dec 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9doStQU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD912AEE4
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734811244; cv=none; b=dZnkOLTEjWy/1n/Z4YRSIDY/dQJ78cnV/FfZjtaRXVH3Rkr7z48kpnUL8LYGU8QM8N8sE3KF3hguw7szFSeOW/y/MTgDN2qNnV6aasFmXGiGM9EjAslEM3TsbSIFMyNxBUyj81/7UE7PwmMhFLcof20gSgiF+zOtzMAAIF9wVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734811244; c=relaxed/simple;
	bh=JGxOPIfDDiEktIxL4g6C28nbFMK7ZqS7p3OFOtlF6K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw9tOKHD8hruynTMydQPXX0Ba9lHimiPj2fXDqfoKhgpC6XLyWTCQzvDUhORrpojjAoGd5H/5bJtjIBDwnxC/B9ye9+9/7H3n8KqfeMJTMJQEDYzcJvcPkxtfa+S56/ghsR6Vfbb0lqxsrbGQBT6JOUmdqhaLyVQsUqlgT+nHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9doStQU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734811242; x=1766347242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JGxOPIfDDiEktIxL4g6C28nbFMK7ZqS7p3OFOtlF6K0=;
  b=O9doStQUaVBcO0DUKO1BITdC3TiRSBx7TfbKd373I0R+G/vpbn2IBGdp
   0rZHC0MwYCSAk6gv583sRQ8pE0UDQh/nxlYik4BjL7tZ8z3ZI65Xzk635
   Z4wsttXVnVPSlwX1yv+Q9w/7mdlwAZbpmQVwsswliWwPfcAunlcxIllz7
   HiqmFYLxwoZVE92HcONZX7oHpB+yKFKfOD91sNelemIrEa3L5rM6yLpsx
   Qsaj9E53XrbQzAxZ2KpQ3fNZcZG5iBbQC7YJic3W4DZqn6K7cCddT+Mo0
   lhjWtBI+vc0Gz0jTHEafcHuutleVfQ8U2kl2D90WA2YJk0aCdimLY3EAr
   w==;
X-CSE-ConnectionGUID: sPgDACh3TVyUSSx2vMYksg==
X-CSE-MsgGUID: YeO8+M4iQFe7sHbN1i+ZmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="39270347"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="39270347"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 12:00:42 -0800
X-CSE-ConnectionGUID: IpEgOqnsRj23yL3DYx3Owg==
X-CSE-MsgGUID: JbzAI7+KREao3UXJx4/wow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102931941"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Dec 2024 12:00:39 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tP5eP-0002Rj-0U;
	Sat, 21 Dec 2024 20:00:37 +0000
Date: Sun, 22 Dec 2024 03:59:42 +0800
From: kernel test robot <lkp@intel.com>
To: Yong Wang <yongwang@nvidia.com>, razor@blackwall.org, roopa@nvidia.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, aroulin@nvidia.com, idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: Re: [PATCH net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
Message-ID: <202412220334.lMkjQPYn-lkp@intel.com>
References: <20241220220604.1430728-2-yongwang@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220220604.1430728-2-yongwang@nvidia.com>

Hi Yong,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3272040790eb4b6cafe6c30ec05049e9599ec456]

url:    https://github.com/intel-lab-lkp/linux/commits/Yong-Wang/net-bridge-multicast-re-implement-port-multicast-enable-disable-functions/20241221-060848
base:   3272040790eb4b6cafe6c30ec05049e9599ec456
patch link:    https://lore.kernel.org/r/20241220220604.1430728-2-yongwang%40nvidia.com
patch subject: [PATCH net-next 1/2] net: bridge: multicast: re-implement port multicast enable/disable functions
config: nios2-randconfig-r071-20241221 (https://download.01.org/0day-ci/archive/20241222/202412220334.lMkjQPYn-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241222/202412220334.lMkjQPYn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412220334.lMkjQPYn-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/bridge/br_multicast.c: In function 'br_multicast_toggle_port':
>> net/bridge/br_multicast.c:2178:35: error: implicit declaration of function 'br_vlan_state_allowed' [-Wimplicit-function-declaration]
    2178 |                         if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
         |                                   ^~~~~~~~~~~~~~~~~~~~~
>> net/bridge/br_multicast.c:2178:57: error: implicit declaration of function 'br_vlan_get_state'; did you mean 'br_vlan_get_stats'? [-Wimplicit-function-declaration]
    2178 |                         if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
         |                                                         ^~~~~~~~~~~~~~~~~
         |                                                         br_vlan_get_stats


vim +/br_vlan_state_allowed +2178 net/bridge/br_multicast.c

  2159	
  2160	static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
  2161	{
  2162		struct net_bridge *br = port->br;
  2163	
  2164		if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
  2165			struct net_bridge_vlan_group *vg;
  2166			struct net_bridge_vlan *vlan;
  2167	
  2168			rcu_read_lock();
  2169			vg = nbp_vlan_group_rcu(port);
  2170			if (!vg) {
  2171				rcu_read_unlock();
  2172				return;
  2173			}
  2174	
  2175			/* iterate each vlan of the port, toggle port_mcast_ctx per vlan */
  2176			list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
  2177				/* enable port_mcast_ctx when vlan is LEARNING or FORWARDING */
> 2178				if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
  2179					br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
  2180				else
  2181					br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
  2182			}
  2183			rcu_read_unlock();
  2184		} else {
  2185			/* use the port's multicast context when vlan snooping is disabled */
  2186			if (on)
  2187				br_multicast_enable_port_ctx(&port->multicast_ctx);
  2188			else
  2189				br_multicast_disable_port_ctx(&port->multicast_ctx);
  2190		}
  2191	}
  2192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

