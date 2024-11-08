Return-Path: <netdev+bounces-143153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602249C1459
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180C01F21F18
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4694962C;
	Fri,  8 Nov 2024 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRwbcJ4S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329DEAD7;
	Fri,  8 Nov 2024 02:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034616; cv=none; b=Pdi3LJdoyLpHHvFv7iKSihStU3K74vRpRF8LIvt/NP9s+cGUBPd6jG9pItbGnFzZz8dYTKXUKEfnZvGj7YXQvC4bApy1MuyDTf4YOmN/P/K0ntaWadKyaMtPpZbZuWRpBjz1w3q/gLuvrQGwhDx8gl6V8B6mFdBi6lH+NdpAJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034616; c=relaxed/simple;
	bh=alNLUomFOrw/dXZvCeCRW/AHRkTVyrDOna3U5uTWQBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlopkrA/1n3r/usgNlONp3SXi2PNXIvPPHn/PFR1sZhHSS37h/I7diYs+8BW36y3MwF9M4Z3nfbpATy52RODEgY+WzcjjDHE9ONledRXIZxWzpyotYV75ofJC/5juSjWFP2vhpj3DfXQ2NsVy02Pe0lMfdrMcinPr29mJ051yLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRwbcJ4S; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731034614; x=1762570614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=alNLUomFOrw/dXZvCeCRW/AHRkTVyrDOna3U5uTWQBQ=;
  b=iRwbcJ4SZt+wI7DcwsK/oAy54IGh+IoepR7sBB6EjdG7/Tj+djQ7rHP8
   54PgrMhKXzwiMBXIVIHS3r/ahgv0DaxmOPGA8e9ZgZ72Sw3YUixgX7IOn
   HvgrQQcUC4/BlXcEKZhNIgxT78XoEArXfUc0Uhx20JZ0tN9t6mUUcfJBL
   DTMOe3bJhP12ogDpWS2mEZf98ljg/1yIDB7iqkz70ydpNPy0R9fLWELNH
   4BHfN3cN9TKV0pp/oPTkPSWV/MiTjejdm1u4P3D+jtDaNseIrZxfMDPBO
   pRZGXFDftYmE9+xqdSc3+QD9FzwGpbfg5LHqiIQtHX+h1SksbSQTBFniq
   Q==;
X-CSE-ConnectionGUID: V8K0JnqUSbiRtwezs5IvSQ==
X-CSE-MsgGUID: tPkPp5KOT2+oYYMSaTD3oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31132180"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31132180"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:56:54 -0800
X-CSE-ConnectionGUID: 2z1C/yRsSBWGCgbO0A4C5g==
X-CSE-MsgGUID: Nwl1tYVrSdam3UOxzimk7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="85503149"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Nov 2024 18:56:45 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9FAx-000qx8-0J;
	Fri, 08 Nov 2024 02:56:43 +0000
Date: Fri, 8 Nov 2024 10:56:25 +0800
From: kernel test robot <lkp@intel.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
Message-ID: <202411081014.jmz4uf6C-lkp@intel.com>
References: <20241107212309.3097362-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-6-almasrymina@google.com>

Hi Mina,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/net-page_pool-rename-page_pool_alloc_netmem-to-_netmems/20241108-052530
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241107212309.3097362-6-almasrymina%40google.com
patch subject: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20241108/202411081014.jmz4uf6C-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081014.jmz4uf6C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081014.jmz4uf6C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:40,
                    from net/ipv4/tcp_vegas.c:37:
   include/net/netmem.h: In function 'netmem_prefetch':
   include/net/netmem.h:179:9: error: implicit declaration of function 'prefetch' [-Wimplicit-function-declaration]
     179 |         prefetch(netmem_to_page(netmem));
         |         ^~~~~~~~
   net/ipv4/tcp_vegas.c: At top level:
>> net/ipv4/tcp_vegas.c:46:12: warning: 'gamma' defined but not used [-Wunused-variable]
      46 | static int gamma = 1;
         |            ^~~~~


vim +/gamma +46 net/ipv4/tcp_vegas.c

7752237e9f07b3 Stephen Hemminger 2007-04-23  43  
8d3a564da34e58 Doug Leith        2008-12-09  44  static int alpha = 2;
8d3a564da34e58 Doug Leith        2008-12-09  45  static int beta  = 4;
8d3a564da34e58 Doug Leith        2008-12-09 @46  static int gamma = 1;
b87d8561d8667d Stephen Hemminger 2005-06-23  47  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

