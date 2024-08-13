Return-Path: <netdev+bounces-118162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85647950CE3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41065285D86
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AD21A3BD3;
	Tue, 13 Aug 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iaPV2Cg6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083001A3BC7;
	Tue, 13 Aug 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576158; cv=none; b=hWTxsB81Tzr2xWdBWJXRMw1EgrjIZ6gSRaJy3wZPpLnV0bbfKHQaNmVcdg8aZ6eTAXLFkLVGBe8UkPK7uoU/1Ap7FRgLnMstUy4snxRUnMkMVwpGFv8edDzGKmhMT1XnITQbkbsIV8RhU13OswQT/SWWANKcHYuEhaxQuBf4rX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576158; c=relaxed/simple;
	bh=5yLTqYrEVFQBJuTrsiDLUVqVWQqyOnzlNTbvg0gBosQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB2WrZp+MezVvntEqQTBS73d5P3rzqVFNoduWhSep2vW/s1ltY2hHw67a9zyr1+NJylpjdvh5kQeaag6ASHlJjYCPNRFlPfbH5+P4k8BaCxypLCXi78fpW5YtyAGoE980pdrX7TPEVPPEJ5nF77BVDc2ULHx5K3X/HPweBxQNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iaPV2Cg6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723576157; x=1755112157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5yLTqYrEVFQBJuTrsiDLUVqVWQqyOnzlNTbvg0gBosQ=;
  b=iaPV2Cg6Vk4UysQvw+uXX0bMJLss9PaSJtlbLUAUyiFLQzBNYYl4FnaW
   WlsXZc7Ddu78802F9wYEbY2FSnpo3iEruTadffIBUUks+HLImUbAmLZXm
   Vddfn1jESgXnAHZp9/7ZnzaqZTIymEJJWQnhukZwjOyrmarsw4lkH1RCV
   XLp1yu9CT1ficnd01iKA77S3wUsJr6pmmyCh7BDcjlNloHVZ/+5l5NP1l
   mGDEehRbRQfzmnpsJqErcEqliO68TVz3EZNRUPAlHXdbLpWWo2w4XJPke
   1/RvVbQ0Y97wVwL9nXQS7vqgrYWiByvlvaC+Hcc/a1FjKMapFgJhs/QYy
   g==;
X-CSE-ConnectionGUID: g5b5cTQnT0mXXkQGDvvK3Q==
X-CSE-MsgGUID: M3hGPMg2TDmf/p+yqo5VQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21907742"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21907742"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 12:05:41 -0700
X-CSE-ConnectionGUID: 6mYXJ2zMRLqwskgoE5g5gw==
X-CSE-MsgGUID: h8E2xQ/tSUCvLL31HYqiLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58754347"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 13 Aug 2024 12:05:37 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdwpq-0000fW-1n;
	Tue, 13 Aug 2024 19:05:34 +0000
Date: Wed, 14 Aug 2024 03:05:11 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, eladwf@gmail.com, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Lin <chen45464546@163.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in
 LRO rings release
Message-ID: <202408140256.AkgMaR7u-lkp@intel.com>
References: <20240812152126.14598-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812152126.14598-1-eladwf@gmail.com>

Hi Elad,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Yifee/net-ethernet-mtk_eth_soc-fix-memory-leak-in-LRO-rings-release/20240813-015755
base:   net/main
patch link:    https://lore.kernel.org/r/20240812152126.14598-1-eladwf%40gmail.com
patch subject: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
config: arm-randconfig-003-20240813 (https://download.01.org/0day-ci/archive/20240814/202408140256.AkgMaR7u-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240814/202408140256.AkgMaR7u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408140256.AkgMaR7u-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/mediatek/mtk_eth_soc.c: In function 'mtk_rx_put_buff':
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:28: error: expected expression before 'unsigned'
    1768 |                 free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                            ^~~~~~~~
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:17: error: too few arguments to function 'free_pages'
    1768 |                 free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                 ^~~~~~~~~~
   In file included from include/linux/xarray.h:16,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:18,
                    from drivers/net/ethernet/mediatek/mtk_eth_soc.c:9:
   include/linux/gfp.h:372:13: note: declared here
     372 | extern void free_pages(unsigned long addr, unsigned int order);
         |             ^~~~~~~~~~
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:42: error: expected ';' before 'data'
    1768 |                 free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                                          ^~~~
         |                                          ;
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1767:9: warning: this 'else' clause does not guard... [-Wmisleading-indentation]
    1767 |         else
         |         ^~~~
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:93: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'else'
    1768 |                 free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
         |                                                                                             ^
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1768:93: error: expected statement before ')' token


vim +/unsigned +1768 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1759	
  1760	static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
  1761	{
  1762		if (ring->page_pool)
  1763			page_pool_put_full_page(ring->page_pool,
  1764						virt_to_head_page(data), napi);
  1765		else if (ring->frag_size <= PAGE_SIZE)
  1766			skb_free_frag(data);
> 1767		else
> 1768			free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
  1769	}
  1770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

