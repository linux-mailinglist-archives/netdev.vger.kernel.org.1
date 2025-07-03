Return-Path: <netdev+bounces-203889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF92AF7F10
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B24758023D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7FE28A1E7;
	Thu,  3 Jul 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tr/1IdH2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088122CBD8
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564236; cv=none; b=TIYDIl3NhV95tNG+Onyo377ubUvlDN+bZWaNL/CBLVt7pI6HsAYA2GtrzHBaE2+3YwJiZZ34KgmFwGYNyqEI9sPcxzjEBTBXSWF+9qfVT9PAVLohxEshSUJVHSgBwb5tFJKnLrBbtqGby1+utEQ2ks/x4EpsLGXD15Q+pTQPXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564236; c=relaxed/simple;
	bh=OEy748VIT1MZFGsUfgCuFVL++q+L4zQ1MHBgkE4zBKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+hRu52QBxseBqiDOkOZ32WF+OzIua1qwsUZgvm/5zj21luqlmFZITG6sIKxel5/F2Zfqlj/UfZ3oyvpkmYbqYrTJ6m/1UzsrvwtgRAwOCTHLeW7dlLvfMvD0AXawU6KWTShx5y5qTrjq69BKjSLrFzj/uDsco/qP9pY55A9Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tr/1IdH2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564234; x=1783100234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OEy748VIT1MZFGsUfgCuFVL++q+L4zQ1MHBgkE4zBKg=;
  b=Tr/1IdH2ohM/pwy8+wI40Yejddnm7YP0E7Tj/IeTkzQm7JCeVmXS8W4x
   pVK4QPMNXhdTb/OHT+kj4EJOGF7bPNvrfr3QTdUGWAPGm0xvVc8s5QeY9
   VzmlUksBN4gAwPENfu3XcKNCuRoa9T2UY6dJNPmiTUgCHpmIFecDazLni
   VfCxPhbe5vukeusxOs1if/aHnV0CP3H9KVng0rv0pumJC1snW4lcf7BQn
   2QW9LvudWcNs5RbDMAG/I38qydxgoiq3ORNa0VbMyg91UlLIdzkKfoLp8
   Zvj2fnuzPJKFEwSOSlyOwm+aU6i17HZNOUfS2H1h4+LU/MRfAzP8kuayw
   w==;
X-CSE-ConnectionGUID: F4YtH1GRQdeP44Ae+Nx5XA==
X-CSE-MsgGUID: JxAc2M01T1miXf/whZeLQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79338467"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="79338467"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:36:59 -0700
X-CSE-ConnectionGUID: Nxa26c0zRl2Fr8kG6RS+cA==
X-CSE-MsgGUID: 15IbNe7bQCGpx4PhnqEPVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="155173189"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2025 10:36:55 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXNrg-0002qV-36;
	Thu, 03 Jul 2025 17:36:52 +0000
Date: Fri, 4 Jul 2025 01:35:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org, andrew@lunn.ch, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
	gal@nvidia.com, ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v2 3/5] eth: mlx5: migrate to the *_rxfh_context
 ops
Message-ID: <202507040129.gR5UyINU-lkp@intel.com>
References: <20250702030606.1776293-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702030606.1776293-4-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/eth-otx2-migrate-to-the-_rxfh_context-ops/20250702-110737
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250702030606.1776293-4-kuba%40kernel.org
patch subject: [PATCH net-next v2 3/5] eth: mlx5: migrate to the *_rxfh_context ops
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20250704/202507040129.gR5UyINU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507040129.gR5UyINU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507040129.gR5UyINU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/en/rss.c: In function 'mlx5e_rss_get_rxfh':
>> drivers/net/ethernet/mellanox/mlx5/core/en/rss.c:587:16: warning: 'return' with a value, in function returning void [-Wreturn-type]
     587 |         return 0;
         |                ^
   drivers/net/ethernet/mellanox/mlx5/core/en/rss.c:570:6: note: declared here
     570 | void mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc,
         |      ^~~~~~~~~~~~~~~~~~


vim +/return +587 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c

25307a91cb50a0 Tariq Toukan   2021-08-16  569  
540d484b812cad Jakub Kicinski 2025-07-01  570  void mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc,
540d484b812cad Jakub Kicinski 2025-07-01  571  			bool *symmetric)
25307a91cb50a0 Tariq Toukan   2021-08-16  572  {
25307a91cb50a0 Tariq Toukan   2021-08-16  573  	if (indir)
cae8e6dea27923 Adham Faris    2023-10-12  574  		memcpy(indir, rss->indir.table,
74a8dadac17e2b Adham Faris    2023-10-12  575  		       rss->indir.actual_table_size * sizeof(*rss->indir.table));
25307a91cb50a0 Tariq Toukan   2021-08-16  576  
25307a91cb50a0 Tariq Toukan   2021-08-16  577  	if (key)
25307a91cb50a0 Tariq Toukan   2021-08-16  578  		memcpy(key, rss->hash.toeplitz_hash_key,
25307a91cb50a0 Tariq Toukan   2021-08-16  579  		       sizeof(rss->hash.toeplitz_hash_key));
25307a91cb50a0 Tariq Toukan   2021-08-16  580  
25307a91cb50a0 Tariq Toukan   2021-08-16  581  	if (hfunc)
25307a91cb50a0 Tariq Toukan   2021-08-16  582  		*hfunc = rss->hash.hfunc;
25307a91cb50a0 Tariq Toukan   2021-08-16  583  
4d20c9f2db83a0 Gal Pressman   2025-02-24  584  	if (symmetric)
4d20c9f2db83a0 Gal Pressman   2025-02-24  585  		*symmetric = rss->hash.symmetric;
4d20c9f2db83a0 Gal Pressman   2025-02-24  586  
25307a91cb50a0 Tariq Toukan   2021-08-16 @587  	return 0;
25307a91cb50a0 Tariq Toukan   2021-08-16  588  }
25307a91cb50a0 Tariq Toukan   2021-08-16  589  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

