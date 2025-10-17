Return-Path: <netdev+bounces-230486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FCDBE8FDC
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEAB74EAB37
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 13:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFC8320CB9;
	Fri, 17 Oct 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ru65y0e6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F532ABF0
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708905; cv=none; b=LGChKKJqisiW5kngmlALCCmc0fN1/UOLCZXPOJBEYzzDC+Og7kvkUPS5HKJXAcsSGhQZKWB0QvfCC6NctsTQZgtycCVW6gGKJktS+FQRMtNHY3V7D9qUsO7dNE/6YBzI5GAsfOAuZkaS3JcEif4Rfab1/o5rGI9fLDBt3EU1kvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708905; c=relaxed/simple;
	bh=Mt5Ea1PDeIlqjmE1UL0nvD4njZD+3gafTsIJQvrZ1Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCBVWaUl1n8R43sJxQ9hsp454uu3RunnR5yaLgsroZ0xwmZnQf6N/f6fy5VCuvsAORLXa4dKIWtWnJErkCTZ6HXYR9r6tnB2NNc2um4CoIXC5fK2WWlLKqts5E3Le69Q44BW2xobOa75dRO3J8cnO+C4EHOGUr/xHiDijQfixbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ru65y0e6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760708903; x=1792244903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mt5Ea1PDeIlqjmE1UL0nvD4njZD+3gafTsIJQvrZ1Pg=;
  b=Ru65y0e6QBfvi/qZ9xIntelxeen7IJwYvOHf3Xa0UOFdWVtaDvPphqRi
   mqttaejBrFoUAZgb7jiWJvKwdMnzaGIBB1HmN3NQ4IOT4JJjEE3wMo6iR
   01ptgs7T/5bIbblnzy5qbJJ0EVcwCp7t+CV6rvEh07cCMyxfrT++ByQfW
   tIg9xVhc+VERX8GkH8eu+LuMvRo3A4hQrWavGfIWuE0S2vIFLagthsy1g
   Y3GDGPeUOO/gMhgfjM2pYD6drmPSFOIYxmqMwtgtGbCMYSZalSHmsQKFW
   nhGZah5hSAo/YnjvX8DM3EXYC4z+7l9aTnaEwkz7jU9c22HF3z0SalakU
   A==;
X-CSE-ConnectionGUID: GYjK6QJlR6yyd58pVl0z0w==
X-CSE-MsgGUID: 71JNjr8VSYSJvTwHfXq+1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="62821362"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="62821362"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 06:48:23 -0700
X-CSE-ConnectionGUID: C3zfp7g3RS2muHphGC0C+w==
X-CSE-MsgGUID: GVCtUxhHSem3g+Mgtv5IJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182550640"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2025 06:48:21 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9kny-0005zX-2w;
	Fri, 17 Oct 2025 13:47:44 +0000
Date: Fri, 17 Oct 2025 21:46:51 +0800
From: kernel test robot <lkp@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	Shi Hao <i.shihao.999@gmail.com>
Subject: Re: [PATCH] net :ethernet : replace cleanup_module with __exit()
Message-ID: <202510172108.zGZR9d2O-lkp@intel.com>
References: <20251016115113.43986-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016115113.43986-1-i.shihao.999@gmail.com>

Hi Shi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on horms-ipvs/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shi-Hao/net-ethernet-replace-cleanup_module-with-__exit/20251016-195352
base:   linus/master
patch link:    https://lore.kernel.org/r/20251016115113.43986-1-i.shihao.999%40gmail.com
patch subject: [PATCH] net :ethernet : replace cleanup_module with __exit()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251017/202510172108.zGZR9d2O-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510172108.zGZR9d2O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510172108.zGZR9d2O-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/3com/3c515.c: In function 'corkscrew_exit_module':
>> drivers/net/ethernet/3com/3c515.c:1552:29: error: 'root_corkscrew_dev' undeclared (first use in this function)
    1552 |         while (!list_empty(&root_corkscrew_dev)) {
         |                             ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/3com/3c515.c:1552:29: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/net/ethernet/3com/3c515.c:52:
   include/linux/compiler_types.h:532:27: error: expression in static assertion is not an integer
     532 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:21:9: note: in expansion of macro 'static_assert'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/list.h:609:9: note: in expansion of macro 'container_of'
     609 |         container_of(ptr, type, member)
         |         ^~~~~~~~~~~~
   drivers/net/ethernet/3com/3c515.c:1556:22: note: in expansion of macro 'list_entry'
    1556 |                 vp = list_entry(root_corkscrew_dev.next,
         |                      ^~~~~~~~~~


vim +/root_corkscrew_dev +1552 drivers/net/ethernet/3com/3c515.c

^1da177e4c3f415 drivers/net/3c515.c               Linus Torvalds 2005-04-16  1549  
c244e2488b92ba8 drivers/net/ethernet/3com/3c515.c Shi Hao        2025-10-16  1550  static void __exit corkscrew_exit_module(void)
^1da177e4c3f415 drivers/net/3c515.c               Linus Torvalds 2005-04-16  1551  {
^1da177e4c3f415 drivers/net/3c515.c               Linus Torvalds 2005-04-16 @1552  	while (!list_empty(&root_corkscrew_dev)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

