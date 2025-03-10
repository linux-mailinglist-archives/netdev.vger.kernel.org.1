Return-Path: <netdev+bounces-173466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3CA59119
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2541883573
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B8226CE8;
	Mon, 10 Mar 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghrPLKQU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324722689D
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602328; cv=none; b=UcD+hr22OR7IRL82wuDU/81RSw5lmzYNE1zQHrB6F31evIwfWe9mmLwvq9ZnMOfhdFY2I0GGnZ4x821Cg17vg1QZuFsCCiy1WrMRdAYM7DsVu2CDeM2wQQEG4UvYXTInUtu3uyY7ojZAOLoti28mGHQU/+rKV98fvGZzIMZL4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602328; c=relaxed/simple;
	bh=xIE+UTqb+jLSoTXVrKvvWDu1nRgFSGR/ps2L4wLEKN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCfuFV1JG6JiBfVKwdaqsgRv9qAhFnxuWj4fxpi/sHuNI2pqC9bFjU76yhvj2Z0AeXrNYMtCWgipJVlpmWwUd8ihYYzFODLqXrhbVot2Wqs2xjggKxP0QZEeVmmwuyi37ZkZ8ricoPZD3YA4lc9yEJRLaOYe5vDP4CaGC9eA2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghrPLKQU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741602326; x=1773138326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xIE+UTqb+jLSoTXVrKvvWDu1nRgFSGR/ps2L4wLEKN4=;
  b=ghrPLKQUtHBLWczAHjEr8ASliq06B9Ajj5n2LEvBZC39sAkEIyZw/rM5
   W53znxUvgF40bZA2M8zKhtm4NKHhd93997EN2WWnuxQy8v0IHSAFToCZI
   pwt367s6y2exWXCjl8hU1Py8VJTwKAsMkLVe2kVv9H+Kp2pTBp8F5tWew
   BYvfaozwOYCoAoTF2/xdDXLuPkurX+ZpQfGvoOi5jPxYBwdbfjHnxnfAJ
   84a/vShoDa7yON6CqMq2exM7+qJgaOoJEVm4tcSIj3t+eSE+FnsRgQJ2t
   9wRnHUQrCyGbv8COf6cVpakebTA8idCOCydu9Sv/MJoiZZj2Ne5Egys59
   w==;
X-CSE-ConnectionGUID: 9FMN4B8rS5auso2+o+nVwg==
X-CSE-MsgGUID: StpzyboKTl6aNAgMlCcsgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65042735"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65042735"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 03:25:25 -0700
X-CSE-ConnectionGUID: eM0+FtaMRhaL38aq7HZauA==
X-CSE-MsgGUID: KOSUOua0SaOqdGY33wG4+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143161859"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 10 Mar 2025 03:25:23 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1traK0-00045q-1u;
	Mon, 10 Mar 2025 10:25:20 +0000
Date: Mon, 10 Mar 2025 18:24:29 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>,
	syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: lapbether: use netdev_lockdep_set_classes()
 helper
Message-ID: <202503101824.VtjtbcKN-lkp@intel.com>
References: <20250309093930.1359048-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309093930.1359048-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-lapbether-use-netdev_lockdep_set_classes-helper/20250309-174127
base:   net/main
patch link:    https://lore.kernel.org/r/20250309093930.1359048-1-edumazet%40google.com
patch subject: [PATCH net] net: lapbether: use netdev_lockdep_set_classes() helper
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250310/202503101824.VtjtbcKN-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503101824.VtjtbcKN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503101824.VtjtbcKN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/wan/lapbether.c:27:
   In file included from include/linux/net.h:24:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/wan/lapbether.c:42:10: fatal error: 'net/netdev_lock.h' file not found
      42 | #include <net/netdev_lock.h>
         |          ^~~~~~~~~~~~~~~~~~~
   3 warnings and 1 error generated.


vim +42 drivers/net/wan/lapbether.c

    41	
  > 42	#include <net/netdev_lock.h>
    43	#include <net/x25device.h>
    44	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

