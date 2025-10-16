Return-Path: <netdev+bounces-230228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C8BE593D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DF544E8727
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A952D9EC9;
	Thu, 16 Oct 2025 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5NEo+bx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55421ADB9
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760650568; cv=none; b=IIpw51XhILR1DxEmHI/QEOd1VetIFFOoJlusZxRIb/vbCtfNo6yyWbqGdeoFlBVWLf3kH2vwy8Qop4bKf4RPiDxQ2V3JU7d/9VsZn2rMwWcsDIIghn85yBKRe9IeAEjxbeRjgIUCGbCXJ0WhUmi3XAAkRZ9DNDfCgLsOrYFPX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760650568; c=relaxed/simple;
	bh=uVbxIBDtJ6avmsRcu1VMzgaYxHFdu2dpZ8WUD/BJGGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6tW1L+CHo4ZVLvg2V5A5sHuRTifPcA2dxXq1oDvVPdThNByxov6t2lnE2VkjaLSRd1Zh8j2FcfjTFSApJhfzTHcpbwllbH6mxVMLf3igz4mTUx8DjjbObR2/CyBf+2vi6XtP0LZRYs80BQyqdxYhsRncOctYJyT9zAyT+tCQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5NEo+bx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760650566; x=1792186566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uVbxIBDtJ6avmsRcu1VMzgaYxHFdu2dpZ8WUD/BJGGc=;
  b=G5NEo+bx7UAyiCvQi22VRUtu15oBvsm4Pes8bIix2RsKjJF73+Z4o3kS
   y89vnrQHbjaW3wqUkQMU5ASSFPLjMao8adOC2mzvjYusnUaP+826OdevK
   /46VHwbTKjlq3BZJ/p4piLi2D4n+rjQ0boWFivttWj9wljAXIeUDLsuaV
   6NF4ljn6qHFME64csx+36/3R6dvGU2xYFDKMQNspmIE+Qr0Ze6UKbsF/x
   5P0oB0q/InyzdbjjrVypvkH/skLSc6Z6VyUwwM/UTJohTNr115FrOuC2v
   JJHGrcA3fsvsJ4s+6wmHNYqmu3C5tsFGjsEOXLj2jCkVxx2hayLKteT+x
   w==;
X-CSE-ConnectionGUID: B8Hymo9MQ9uuj1aAirJ/MQ==
X-CSE-MsgGUID: oyrFoiSSRkSAbKniiLUJrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="85476633"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="85476633"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 14:36:05 -0700
X-CSE-ConnectionGUID: kuu7jeVNSc+SpZM+qg7+gg==
X-CSE-MsgGUID: dX5YN5uVRx648xdCouaxkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="213534682"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2025 14:36:02 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Vdg-0005GZ-1G;
	Thu, 16 Oct 2025 21:36:00 +0000
Date: Fri, 17 Oct 2025 05:35:37 +0800
From: kernel test robot <lkp@intel.com>
To: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5: MPFS, add support for dynamic
 enable/disable
Message-ID: <202510170416.DfoJV8mp-lkp@intel.com>
References: <20251016013618.2030940-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016013618.2030940-3-saeed@kernel.org>

Hi Saeed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Saeed-Mahameed/devlink-Introduce-devlink-eswitch-state/20251016-094245
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251016013618.2030940-3-saeed%40kernel.org
patch subject: [PATCH net-next 2/3] net/mlx5: MPFS, add support for dynamic enable/disable
config: x86_64-randconfig-075-20251017 (https://download.01.org/0day-ci/archive/20251017/202510170416.DfoJV8mp-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170416.DfoJV8mp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170416.DfoJV8mp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlx5/core/sriov.c:38:
   In file included from drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:45:
>> drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h:97:5: warning: no previous prototype for function 'mlx5_mpfs_enable' [-Wmissing-prototypes]
      97 | int mlx5_mpfs_enable(struct mlx5_core_dev *dev) { return 0; }
         |     ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h:97:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      97 | int mlx5_mpfs_enable(struct mlx5_core_dev *dev) { return 0; }
         | ^
         | static 
>> drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h:98:6: warning: no previous prototype for function 'mlx5_mpfs_disable' [-Wmissing-prototypes]
      98 | void mlx5_mpfs_disable(struct mlx5_core_dev *dev) {}
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h:98:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      98 | void mlx5_mpfs_disable(struct mlx5_core_dev *dev) {}
         | ^
         | static 
   2 warnings generated.


vim +/mlx5_mpfs_enable +97 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h

    87	
    88	#ifdef CONFIG_MLX5_MPFS
    89	struct mlx5_core_dev;
    90	int  mlx5_mpfs_init(struct mlx5_core_dev *dev);
    91	void mlx5_mpfs_cleanup(struct mlx5_core_dev *dev);
    92	int mlx5_mpfs_enable(struct mlx5_core_dev *dev);
    93	void mlx5_mpfs_disable(struct mlx5_core_dev *dev);
    94	#else /* #ifndef CONFIG_MLX5_MPFS */
    95	static inline int  mlx5_mpfs_init(struct mlx5_core_dev *dev) { return 0; }
    96	static inline void mlx5_mpfs_cleanup(struct mlx5_core_dev *dev) {}
  > 97	int mlx5_mpfs_enable(struct mlx5_core_dev *dev) { return 0; }
  > 98	void mlx5_mpfs_disable(struct mlx5_core_dev *dev) {}
    99	#endif
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

