Return-Path: <netdev+bounces-154256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB69FC544
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FD4163CA2
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D518E373;
	Wed, 25 Dec 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtoU01Yw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2F14AD1A
	for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735131742; cv=none; b=ucNIRKJ813Pyjy400AFA7VIJfTdNNe+v2vLyl2JI3qT9OeB7fbn7I7aGlF1LleW3jZYtuP+aZoLX8opUMQ/cNI7mb3Y/a3JEYwh93GG/tOx3KQO/V+p3/4aV5pmfeuA03jk7BIpBCRm8otLaQceHEQddKxQ30nhtNkSadU25O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735131742; c=relaxed/simple;
	bh=EVo1/chTj+XW7R2AlgQpXBNFX2ODe38tSPHJirwHYq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh57fIcHxjaNzF22aLupAZqTmjxb9b1Czn28CBp24nh/O74FK6nMIDSYJMeBG8oPFNG1xtndQ09G2ChzBv1SLxQxJMVj55IYLFl+r7bRmkkWB87927KmJB2bIzv93Z+yTseCpJSUYONbIuGCNmvd9qg+3czTDyHY3JvbgFzjiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtoU01Yw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735131741; x=1766667741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EVo1/chTj+XW7R2AlgQpXBNFX2ODe38tSPHJirwHYq0=;
  b=mtoU01Ywjg9iKBI004jqGqdfFqg17oIu6l8x51sW21B3qG6B/yVIy/5H
   QHrzUii0ZyFSm5mi1rjW5Q3+CcpgVvRo+DxLP5ttApzjk1gWhwSbKNYIT
   yHDLRskMTkkKrL1mBQQ3jXq0V2z2jsv7Bl+lY9HTUlhaL1miO+agBRqvz
   nYboyoGCkkimIwJvgqBFZFYGGUOIkg2weClBEwf7RBWzNwqZ0dHDD7KG4
   eGWxyYHYEoYFG+pDXBiXTNlnMIAGfIzM6JPo0Qho423883BDzEzBLtXRY
   tyLH1kGOSB34FpeXk3TTU5zSWkQaVXZm8oqe1GpQTILBDk8TJMwnDeCfZ
   g==;
X-CSE-ConnectionGUID: vmJ4zxDcTGe+1MN5ryB4MA==
X-CSE-MsgGUID: qVKen2snTY+bkSv9ICxzPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35289390"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="35289390"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 05:02:20 -0800
X-CSE-ConnectionGUID: GCQ7BFBTRcOSbGDJLVY0sw==
X-CSE-MsgGUID: EQJ0TTcORoiG/DVZsYSyYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="99564861"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Dec 2024 05:02:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQR1g-0001q3-03;
	Wed, 25 Dec 2024 13:02:12 +0000
Date: Wed, 25 Dec 2024 21:02:10 +0800
From: kernel test robot <lkp@intel.com>
To: Yong Wang <yongwang@nvidia.com>, razor@blackwall.org, roopa@nvidia.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, aroulin@nvidia.com,
	idosch@nvidia.com, nmiyar@nvidia.com
Subject: Re: [PATCH net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
Message-ID: <202412251623.8huquaZx-lkp@intel.com>
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
config: i386-randconfig-011-20241225 (https://download.01.org/0day-ci/archive/20241225/202412251623.8huquaZx-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241225/202412251623.8huquaZx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412251623.8huquaZx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/bridge/br_multicast.c:10:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/bridge/br_multicast.c:2178:14: error: call to undeclared function 'br_vlan_state_allowed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2178 |                         if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
         |                                   ^
>> net/bridge/br_multicast.c:2178:36: error: call to undeclared function 'br_vlan_get_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2178 |                         if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
         |                                                         ^
   net/bridge/br_multicast.c:2178:36: note: did you mean 'br_vlan_get_stats'?
   include/trace/events/../../../net/bridge/br_private.h:1792:20: note: 'br_vlan_get_stats' declared here
    1792 | static inline void br_vlan_get_stats(const struct net_bridge_vlan *v,
         |                    ^
   1 warning and 2 errors generated.


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

