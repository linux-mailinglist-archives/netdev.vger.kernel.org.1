Return-Path: <netdev+bounces-87179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC38A1FED
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 22:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDED9283339
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E1E17C61;
	Thu, 11 Apr 2024 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b94xpsuT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2317BCC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866295; cv=none; b=VggkiairF2+B+Gb6SRQrbA4psToG2XKNfpFWp4vcZUjmklELCUoOIPh0yY3gBvSh61epkvCmyMoBOOm/pTgoKMSYFRSzwe6o5m9/T0u9tast/gfiAbVY5wL93sBw1/Z5vjbh894X3z5gnedeuLxcElOmPVcFKoUKycvLsL7vyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866295; c=relaxed/simple;
	bh=cRRJGkuegGo71KskVd84FpOw8rN6fdCQXYoNS3JXEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwM1fJ8nZHXrr/skCveAd14H06pBuJwg+8r2pX6JiGLbDotzGDvGhwREoEmL/UIW1WdFBRD/mYpTUjm5sTXLzeJ4Xyfc70lGdsslNVUQXUVQZ5iQ6BXtrFO/o4YRl/moy8817TOhxBGlyC4YgIl/KKFpzk5BNrh6/K2ZHMansr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b94xpsuT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712866293; x=1744402293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cRRJGkuegGo71KskVd84FpOw8rN6fdCQXYoNS3JXEc4=;
  b=b94xpsuTbxNGBF2XDp7TcN34qpC9ZC3to+7DfbPuiv59HUX7d/Oug6tq
   Gxua+TbG9Z4XwAUtj2A5cHQf5rr7pG0p3G8y3/Q2w7Ldr8zbYs4+Zft3e
   hPjaykSbmrbtJ03Ac6h5BbRGN29y+YNtRIe5x6ovzOpvOau/1IWGtRt6G
   zfoQqHvMhUC+i02J4O6hefhuQTzQ+9E4IHUZSqTvMmTcTR+kwilxerTq7
   qNt+0XX/GAyONa4IJaZ/PycLhd38MLodhp24eE4BX8jp+6JGbWGyIeyjc
   4DGiHNkc+pgnEDvefd/lQoUuldLlqBnavb2xTfaanRXA2uWrSqiblxB8b
   w==;
X-CSE-ConnectionGUID: 6mWzzJ8dT1Wc80Cg6+g2Cg==
X-CSE-MsgGUID: 8mqN0GTtRHuUSgux8FwRkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33700179"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="33700179"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 13:11:32 -0700
X-CSE-ConnectionGUID: s/ic7X35S4q5islsaIGnrw==
X-CSE-MsgGUID: yImR6zX9T5iqDhdgRiUDSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="51970691"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Apr 2024 13:11:29 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv0la-0008x7-2s;
	Thu, 11 Apr 2024 20:11:26 +0000
Date: Fri, 12 Apr 2024 04:11:17 +0800
From: kernel test robot <lkp@intel.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
Message-ID: <202404120417.VUAT9H5b-lkp@intel.com>
References: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.9-rc3 next-20240411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-dma-map-api-for-page/20240411-105318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240411025127.51945-5-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 4/6] virtio_net: big mode support premapped
config: i386-randconfig-062-20240411 (https://download.01.org/0day-ci/archive/20240412/202404120417.VUAT9H5b-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404120417.VUAT9H5b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404120417.VUAT9H5b-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/virtio_net.c:7:
   drivers/net/virtio_net.c: In function 'page_chain_unmap':
>> include/linux/dma-mapping.h:75:41: warning: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      75 | #define DMA_MAPPING_ERROR               (~(dma_addr_t)0)
         |                                         ^
   drivers/net/virtio_net.c:449:28: note: in expansion of macro 'DMA_MAPPING_ERROR'
     449 |         page_dma_addr(p) = DMA_MAPPING_ERROR;
         |                            ^~~~~~~~~~~~~~~~~


vim +75 include/linux/dma-mapping.h

b2fb366425ceb8 Mitchel Humpherys 2017-01-06  64  
eba304c6861613 Christoph Hellwig 2020-09-11  65  /*
eba304c6861613 Christoph Hellwig 2020-09-11  66   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
eba304c6861613 Christoph Hellwig 2020-09-11  67   * be given to a device to use as a DMA source or target.  It is specific to a
eba304c6861613 Christoph Hellwig 2020-09-11  68   * given device and there may be a translation between the CPU physical address
eba304c6861613 Christoph Hellwig 2020-09-11  69   * space and the bus address space.
eba304c6861613 Christoph Hellwig 2020-09-11  70   *
eba304c6861613 Christoph Hellwig 2020-09-11  71   * DMA_MAPPING_ERROR is the magic error code if a mapping failed.  It should not
eba304c6861613 Christoph Hellwig 2020-09-11  72   * be used directly in drivers, but checked for using dma_mapping_error()
eba304c6861613 Christoph Hellwig 2020-09-11  73   * instead.
eba304c6861613 Christoph Hellwig 2020-09-11  74   */
42ee3cae0ed38b Christoph Hellwig 2018-11-21 @75  #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
42ee3cae0ed38b Christoph Hellwig 2018-11-21  76  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

