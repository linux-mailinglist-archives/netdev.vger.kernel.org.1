Return-Path: <netdev+bounces-230197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E18BE53D9
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214DE420E0E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01072D9EE1;
	Thu, 16 Oct 2025 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwflpyXN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A062D8799
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642998; cv=none; b=gZSEc7NuGuj4ZNSuw44bJpEcEBAAgBSIIRUd2I6eKAIdFZWI9p6gUSRx4vN6CjjHf7+axiaMHfD5HkcvlT/q4/PtfYoethEB8n2sjK2+ba3HBCVSvncz/r5qIIRzV2uWcihtx7ZVFUB92dFS8FnZ/QdYgUtArywRVD+HMfewFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642998; c=relaxed/simple;
	bh=cV3fW+kerhCjyP1ytsTudflquM/A43l4cnZYguEe+fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt7pfViXyhZDd8Fxso8h66u3ghsm3J3hDgJsdi5x7h5f8sNYFbm4PKANe9gQxf57TXF8Ck1Z/GR3VSYIT73QVgOeuaNFHfhRBFYfZtMjTDU5V3bspFCi78GeSG1g7cJr6Sm/Y+xEtAlsLtnUNhwDlJszmw1A8rUeN/yklAbuhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwflpyXN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760642997; x=1792178997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cV3fW+kerhCjyP1ytsTudflquM/A43l4cnZYguEe+fQ=;
  b=KwflpyXN/22AQ1Q6khR54ywygkjVAe6xTr/OM/KdhCMaSk3rlUgOq3fI
   0XrF8qx86+rfTcHczjXA/j/eOFI9/GsQjEIWHJ+6ezCysw5HJnKJH8oj6
   ZRM5h++0LoQe+xBGEP6mxaKp5iTEAzrlGHiCUVpwY8UQkDc7js8D+lOCx
   7VUmp1LqD+voK57taF3anH4QTkI6uo5yAh1m91+DpkVWtraxkvBUggR8N
   GNwgtn/SY/uq1I/Hjv660ABNCbLEzpGhtm5jwTSXoyYAmhEcy5tG6HkAV
   ipBN3YxXaA7jtrhYocSBArVefKXy7f7RZkNLHZ04SPg3PWKF2sWoDI4ma
   A==;
X-CSE-ConnectionGUID: msR00BLKSZO1F40nBESa2Q==
X-CSE-MsgGUID: mQcCw0M3Qf+vnfmWvqvu9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73966070"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73966070"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:29:57 -0700
X-CSE-ConnectionGUID: DXMtKYg7RwOmuIVDr2VNKA==
X-CSE-MsgGUID: VgdDoqRHQZ6acm/3wNY5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182522398"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 16 Oct 2025 12:29:53 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9TfP-0005Bf-0S;
	Thu, 16 Oct 2025 19:29:47 +0000
Date: Fri, 17 Oct 2025 03:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 2/3] net/mlx5: MPFS, add support for dynamic
 enable/disable
Message-ID: <202510170321.YvES75vr-lkp@intel.com>
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
config: powerpc-randconfig-001-20251017 (https://download.01.org/0day-ci/archive/20251017/202510170321.YvES75vr-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170321.YvES75vr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170321.YvES75vr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:45,
                    from drivers/net/ethernet/mellanox/mlx5/core/vport.c:39:
>> drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h:97:5: warning: no previous prototype for 'mlx5_mpfs_enable' [-Wmissing-prototypes]
      97 | int mlx5_mpfs_enable(struct mlx5_core_dev *dev) { return 0; }
         |     ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h:98:6: warning: no previous prototype for 'mlx5_mpfs_disable' [-Wmissing-prototypes]
      98 | void mlx5_mpfs_disable(struct mlx5_core_dev *dev) {}
         |      ^~~~~~~~~~~~~~~~~


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

