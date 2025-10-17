Return-Path: <netdev+bounces-230275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3181BE6284
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F151A64D0D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D525228C;
	Fri, 17 Oct 2025 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtIrTB7M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9A24E4B4
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669347; cv=none; b=HcKCGmxl9LpuToiBEu99R+EcMD2YDJW842VQreo+AYeMYnU26E59Cs7VHlSKRnm6jMi6V6GMCgprdpv9Aoc2/LsFHZmTycvS8Rj7UPVp9WnBHgHeuSGALaxC9dFJJ1Hlo6dMryjX9BlpVNOfj7DM/YI4Ff2RMHEJHW/CbJnk+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669347; c=relaxed/simple;
	bh=WD99PenCbzrrdBMQst12wTBmtrxm7bzCsWLZa4lreN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ne2fLJG3ogYM8hNm4BmR/eZlpt/zcXonm2xYMU7gDE7PDpvdO8ktN6b+uydfB+ieyg4ZXrj2N0FjuGa97LwOgVrnvtNNDqeoXWSQPExdIrwzE63feqBIqe0bvz4Aiy0KCDkmkDyf7Zg6Wjnp4iTkLkYUO2RU6ZfXlC8xyLwJ4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtIrTB7M; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669345; x=1792205345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WD99PenCbzrrdBMQst12wTBmtrxm7bzCsWLZa4lreN8=;
  b=OtIrTB7MxzaA+cSlEkZPxiHUgXxUKdJRELo5IEBlDVwpoDUKeEpkpM0n
   nd94VRMbSECUewxEZygiDUcG/ZXiuVl0C0Kv1LiRSIkLHFqeLZavIS05a
   t3h45wPh+UatGTYOQR11p5nqhaIYG6WWxMuv24m3STQN5w3B8aQHL7Qnb
   7wM/j4xeHm78E4IGNkJsodcrcwHUsnq2/NESolkguO2k3BDNROzUv31wT
   rFAz7aOJd4OpQw8uzDZNcI4E4ObnDrfKBNeNoE5V6gm5z2lj10zghst7I
   D1/edryTY9RYVLpcIkQhRn690kZwoNUFX75FEpscM7CiiwaMVxuApUCyd
   A==;
X-CSE-ConnectionGUID: NaYZkDimS22wuteKm50iUg==
X-CSE-MsgGUID: 0esOcQmFTGGWFFkzCEWG1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73990657"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73990657"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:49:04 -0700
X-CSE-ConnectionGUID: Zks3OUlQRCWlhyDxg9fuAw==
X-CSE-MsgGUID: yEhwY69UT/aiJNc1yol2GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186877105"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 16 Oct 2025 19:49:02 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9aWU-0005T5-0A;
	Fri, 17 Oct 2025 02:48:55 +0000
Date: Fri, 17 Oct 2025 10:48:21 +0800
From: kernel test robot <lkp@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, Shi Hao <i.shihao.999@gmail.com>
Subject: Re: [PATCH] net :ethernet : replace cleanup_module with __exit()
Message-ID: <202510171007.xaD8Yz39-lkp@intel.com>
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
config: i386-randconfig-002-20251017 (https://download.01.org/0day-ci/archive/20251017/202510171007.xaD8Yz39-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510171007.xaD8Yz39-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510171007.xaD8Yz39-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/3com/3c515.c:478:13: warning: variable 'pnp_cards' set but not used [-Wunused-but-set-variable]
     478 |         static int pnp_cards;
         |                    ^
>> drivers/net/ethernet/3com/3c515.c:1552:22: error: use of undeclared identifier 'root_corkscrew_dev'
    1552 |         while (!list_empty(&root_corkscrew_dev)) {
         |                             ^
   drivers/net/ethernet/3com/3c515.c:1556:19: error: use of undeclared identifier 'root_corkscrew_dev'
    1556 |                 vp = list_entry(root_corkscrew_dev.next,
         |                                 ^
   drivers/net/ethernet/3com/3c515.c:1556:19: error: use of undeclared identifier 'root_corkscrew_dev'
   drivers/net/ethernet/3com/3c515.c:1556:19: error: use of undeclared identifier 'root_corkscrew_dev'
   1 warning and 4 errors generated.


vim +/root_corkscrew_dev +1552 drivers/net/ethernet/3com/3c515.c

^1da177e4c3f415 drivers/net/3c515.c               Linus Torvalds 2005-04-16  1549  
c244e2488b92ba8 drivers/net/ethernet/3com/3c515.c Shi Hao        2025-10-16  1550  static void __exit corkscrew_exit_module(void)
^1da177e4c3f415 drivers/net/3c515.c               Linus Torvalds 2005-04-16  1551  {
^1da177e4c3f415 drivers/net/3c515.c               Linus Torvalds 2005-04-16 @1552  	while (!list_empty(&root_corkscrew_dev)) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

