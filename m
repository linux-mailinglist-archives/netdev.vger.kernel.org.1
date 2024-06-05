Return-Path: <netdev+bounces-101059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D88FD143
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E0E1F25CF0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5C27702;
	Wed,  5 Jun 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGUIrNqC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E2519D88D;
	Wed,  5 Jun 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599416; cv=none; b=qNoOtTwH+Dsm5lUTeki9CKxYsxu41PIWg33JWjN/pfXlJxkwzZCUqEOZbLyxiYf6xSzAuv7tD/SCpmty9hO+4EHrG5ndPeq0VbV6PHFGPHgiz3zHLj7kyP9GDWSmQdGgoxrrGhuuvx4q+IUHYAr0QENzMwcOZ92+qnyZbWzmWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599416; c=relaxed/simple;
	bh=srqdIbCzJiCSKItXzlP9aa0Xayzluhdpf+SVbqnv6jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3A+lmTSkNjfK6mEb+XOGihZ3re9ZpUf1oDldaPgmgaDuUCC+H1MvqN7x+OHFMZvag+GikJNVoad1ivxl8DKFFOTEy2XeLbwHelMMMswIx/MY+OjKucf4ItslaAiMIT6zOOdj06VjuqxBugGeBSMqCULT4ddJnky1J0kKmRvutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGUIrNqC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717599415; x=1749135415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=srqdIbCzJiCSKItXzlP9aa0Xayzluhdpf+SVbqnv6jc=;
  b=iGUIrNqCi/s1i7mOH6Y0olgFdlEXaWlD1jFA4ZeIWEOig6QehBJnYJoS
   ygzpwhBVVPqw+2IpuRYdk+I+KXiVCIyX/PX0NrZF4PCVE3RwPH0uSpiCI
   d9w70IInuNc9VbmlRUjEaCGIe/W6fA7INbEn1A9h5IC5BPiQLPVsonnH2
   MHLx55dw0dufz2xvEuUbdOBKV0YBvKtnmWdFMUpLxn8ZbgJbsvPd3K2tj
   3QahjyvhuD5bjQB5hD01ZcSlJ+mRklHSyctXlBPeXpJ48+97NUEPTpx1v
   g6UWK1pCqh+Oq4W3mm4jnL0V36pIr+Ep/bovNPdmVRBNyADZYAmCj0f7d
   w==;
X-CSE-ConnectionGUID: Z8LJnP5jR6GOAmy8t/zMiw==
X-CSE-MsgGUID: /iNMLs37QqGJgqAixT0RmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18062856"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="18062856"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 07:56:54 -0700
X-CSE-ConnectionGUID: 3CDgrgshSYSlKcPgU8/ExQ==
X-CSE-MsgGUID: ZZjCYR3XR7mEuxF96N/4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37551759"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 05 Jun 2024 07:56:51 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEs4F-0001lq-2D;
	Wed, 05 Jun 2024 14:56:47 +0000
Date: Wed, 5 Jun 2024 22:56:19 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	andrew@lunn.ch, linux@armlinux.org.uk, sbauer@blackbox.su,
	hmehrtens@maxlinear.com, lxu@maxlinear.com, hkallweit1@gmail.com,
	edumazet@google.com, pabeni@redhat.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and
 MAC appropriately
Message-ID: <202406052200.w3zuc32H-lkp@intel.com>
References: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Lakkaraju/net-lan743x-disable-WOL-upon-resume-to-restore-full-data-path-operation/20240605-182110
base:   net/main
patch link:    https://lore.kernel.org/r/20240605101611.18791-3-Raju.Lakkaraju%40microchip.com
patch subject: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and MAC appropriately
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240605/202406052200.w3zuc32H-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406052200.w3zuc32H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/microchip/lan743x_main.c: In function 'lan743x_netdev_open':
>> drivers/net/ethernet/microchip/lan743x_main.c:3126:24: error: 'struct lan743x_adapter' has no member named 'phy_wol_supported'
    3126 |                 adapter->phy_wol_supported = wol.supported;
         |                        ^~
>> drivers/net/ethernet/microchip/lan743x_main.c:3127:24: error: 'struct lan743x_adapter' has no member named 'phy_wolopts'
    3127 |                 adapter->phy_wolopts = wol.wolopts;
         |                        ^~


vim +3126 drivers/net/ethernet/microchip/lan743x_main.c

  3085	
  3086	static int lan743x_netdev_open(struct net_device *netdev)
  3087	{
  3088		struct lan743x_adapter *adapter = netdev_priv(netdev);
  3089		int index;
  3090		int ret;
  3091	
  3092		ret = lan743x_intr_open(adapter);
  3093		if (ret)
  3094			goto return_error;
  3095	
  3096		ret = lan743x_mac_open(adapter);
  3097		if (ret)
  3098			goto close_intr;
  3099	
  3100		ret = lan743x_phy_open(adapter);
  3101		if (ret)
  3102			goto close_mac;
  3103	
  3104		ret = lan743x_ptp_open(adapter);
  3105		if (ret)
  3106			goto close_phy;
  3107	
  3108		lan743x_rfe_open(adapter);
  3109	
  3110		for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
  3111			ret = lan743x_rx_open(&adapter->rx[index]);
  3112			if (ret)
  3113				goto close_rx;
  3114		}
  3115	
  3116		for (index = 0; index < adapter->used_tx_channels; index++) {
  3117			ret = lan743x_tx_open(&adapter->tx[index]);
  3118			if (ret)
  3119				goto close_tx;
  3120		}
  3121	
  3122		if (adapter->netdev->phydev) {
  3123			struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
  3124	
  3125			phy_ethtool_get_wol(netdev->phydev, &wol);
> 3126			adapter->phy_wol_supported = wol.supported;
> 3127			adapter->phy_wolopts = wol.wolopts;
  3128		}
  3129	
  3130		return 0;
  3131	
  3132	close_tx:
  3133		for (index = 0; index < adapter->used_tx_channels; index++) {
  3134			if (adapter->tx[index].ring_cpu_ptr)
  3135				lan743x_tx_close(&adapter->tx[index]);
  3136		}
  3137	
  3138	close_rx:
  3139		for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
  3140			if (adapter->rx[index].ring_cpu_ptr)
  3141				lan743x_rx_close(&adapter->rx[index]);
  3142		}
  3143		lan743x_ptp_close(adapter);
  3144	
  3145	close_phy:
  3146		lan743x_phy_close(adapter);
  3147	
  3148	close_mac:
  3149		lan743x_mac_close(adapter);
  3150	
  3151	close_intr:
  3152		lan743x_intr_close(adapter);
  3153	
  3154	return_error:
  3155		netif_warn(adapter, ifup, adapter->netdev,
  3156			   "Error opening LAN743x\n");
  3157		return ret;
  3158	}
  3159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

