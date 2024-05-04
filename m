Return-Path: <netdev+bounces-93437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF18BBC47
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FD3B2136A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227D374F1;
	Sat,  4 May 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oq3KtuiI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54E3717F;
	Sat,  4 May 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714830037; cv=none; b=dDU0tW/JzkNUsSCJ14yt0B9c9kiYQEq+VmKvapCTMHc686sMwk4mqksxzaJFHrddA5LyqNqvJyCv0nEQ+xiNYE/Ta09MShU9tcm69IFfcfT2NbG6fCZs/dgulEdOu0Of5Ftcprq4djZldEJdJ2PBGU6uq3mWVzVqWjobBIJ1rSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714830037; c=relaxed/simple;
	bh=t3FONzaDjqiT8WtMX9xx77TxQj428dRPexrHMx5m5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2qlwHVN+GqVUIL1SbnoiG4Mw2bm8D9PKJ4Y1Xv7cRmQYRFb72jy3l92MFNiPuJVGaLYbgmZC9m+hkVPaQYAOLxCBaNXFyPHR3/w7tgfFo8jO0+QT8P6Fqa+vnqyop0Wc+AULDcJHSbFDgAODIHLhqXBKxdBKJUgGuL2ggMhQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oq3KtuiI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714830035; x=1746366035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3FONzaDjqiT8WtMX9xx77TxQj428dRPexrHMx5m5n8=;
  b=Oq3KtuiI7OwHNSIgYOC08lx497qK0FDIAgIfdbTitxQSQblPxsK35p4c
   e5fHlR7WEaDI/7ZVfezPIXgszdseRu9Wjwlnyl1Coiaw0vpaAQlpbKHNA
   eoAn103KQzpWLi3zGNmAOJq/7wgV3xs1y57RnQVOVbilx9yeojy29liC5
   wfwe2p60uqLykDfwW7oa3sDRFE3iH4UQZOZ9dWBhKQ+NCgI3FTaNk9KUL
   pgY2M+wU9H5xoFZVa0v2+FiBs94OKWNAr92JwcxBoHpwNRWxeq+f754CV
   yW4CNkWmJZOiO6yQreEtMIOJFCU79kcaUPUDJxb+4IcpnZKfK507hIihP
   w==;
X-CSE-ConnectionGUID: +9fA2hlMTQiah1AaZAx5TA==
X-CSE-MsgGUID: Mt/C8b6ZSf6OGW7dTlUopA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10846180"
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="10846180"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 06:40:35 -0700
X-CSE-ConnectionGUID: 9kMINrEcSMiLY7iXJfr8Dg==
X-CSE-MsgGUID: qNN/0NVZQC+hOsLs1neCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="27750226"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 May 2024 06:40:31 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3Fcr-000CoO-1l;
	Sat, 04 May 2024 13:40:29 +0000
Date: Sat, 4 May 2024 21:39:54 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	pkshih@realtek.com, larry.chiu@realtek.com,
	Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v17 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <202405042153.ugnyFsrz-lkp@intel.com>
References: <20240502091847.65181-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091847.65181-13-justinlai0215@realtek.com>

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on horms-ipvs/master]
[cannot apply to net-next/main linus/master v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/rtase-Add-pci-table-supported-in-this-module/20240502-172835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/20240502091847.65181-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v17 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240504/202405042153.ugnyFsrz-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405042153.ugnyFsrz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405042153.ugnyFsrz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:67:10: fatal error: net/netdev_queues.h: No such file or directory
      67 | #include <net/netdev_queues.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +67 drivers/net/ethernet/realtek/rtase/rtase_main.c

6c114677e472d0 Justin Lai 2024-05-02 @67  #include <net/netdev_queues.h>
6c114677e472d0 Justin Lai 2024-05-02  68  #include <net/page_pool/helpers.h>
6c114677e472d0 Justin Lai 2024-05-02  69  #include <net/pkt_cls.h>
6c114677e472d0 Justin Lai 2024-05-02  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

