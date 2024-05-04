Return-Path: <netdev+bounces-93452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FEF8BBD87
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 20:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D061C20DC0
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B769D2B;
	Sat,  4 May 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOyuJHAU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219FE3B29D;
	Sat,  4 May 2024 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845709; cv=none; b=MGecM8Xn9wnZJ/aOOZWtt6KzRJkJhlX7KdntnE8A/Vbd5ATg+gVDKv9qOuqOAjVhj6jvZARm/KfoVdbOueBnbKQcJVa2vUqqRCBrj66uPo2kr4uAVqapRntLrir5tjEV/CBnV4YM7TBD3ffGmiIMrB/SZGVz2R++iiB6oGdlAxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845709; c=relaxed/simple;
	bh=wvW6UJrlvAGP4USmTQrRSEKApbgHmopSqmwR4tQPvYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQJtL4juA6Sgcv6ctdWjUKr2PCIVpqrXRkefv83b6COz3sQB44lVlRCLPeNpig5HPbYHvmvoPP86LUzyHoD6M349WN0PYtldSbhwImHDH/l18lvPGOthJ7Nk5qbVi/JfQljSZhYD4+w9Gw8/CBlyWsgUrljUxYxvsP0aWg7cbCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOyuJHAU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714845707; x=1746381707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wvW6UJrlvAGP4USmTQrRSEKApbgHmopSqmwR4tQPvYY=;
  b=WOyuJHAUadCQRwmAVxCBEF5r6t+vk62Y8Z8Xm4r8STx68nkNrxnbbEfL
   3h4+l4+SC6yaV+lIuxvgvCtEcSCUxeS/gOZrdVGdy9abAsFIEIzNpiyYD
   opbD8SWgOzes7NOPhcPg/lIB7+g3B87wmcqgvjZDhTq7aySOB4cmg4UuC
   /0tWjUJnBZel3s9yTKVAT2Me8LfZkWv0e4oooRiS849IuGUViiQ+CchIb
   8+Qb0acEAnLN8IqCQvJprBmnreb7zW+MfnBFE0EjKZABBvoHqrMqtabDO
   +g/rXAAr7kvKBEyeOEYOFT8uPZNjR/uuPqKLiesESrVXzc+nRip/TWUfj
   A==;
X-CSE-ConnectionGUID: 7dTGewqnTQ6mOPcZOqsHSA==
X-CSE-MsgGUID: TA68Q1L0RI6QTClfgFYFNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10487394"
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="10487394"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 11:01:47 -0700
X-CSE-ConnectionGUID: z2nWo+zyTvuXA3N9Y7ajYQ==
X-CSE-MsgGUID: vi1PQ4tyRHGNSWY8ST9Ecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,254,1708416000"; 
   d="scan'208";a="32562285"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 May 2024 11:01:42 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3Jhc-000D2q-03;
	Sat, 04 May 2024 18:01:40 +0000
Date: Sun, 5 May 2024 02:01:01 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, jiri@resnulli.us, pkshih@realtek.com,
	larry.chiu@realtek.com, Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v17 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <202405050111.thv4v0Bl-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240505/202405050111.thv4v0Bl-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240505/202405050111.thv4v0Bl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405050111.thv4v0Bl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:47:
   In file included from include/linux/dma-mapping.h:7:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:1970:
   include/linux/vmstat.h:502:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     502 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     503 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:509:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     509 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     510 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:516:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     516 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:521:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     521 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     522 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:530:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     530 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     531 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:47:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:47:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/realtek/rtase/rtase_main.c:47:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:67:10: fatal error: 'net/netdev_queues.h' file not found
      67 | #include <net/netdev_queues.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   17 warnings and 1 error generated.


vim +67 drivers/net/ethernet/realtek/rtase/rtase_main.c

6c114677e472d0 Justin Lai 2024-05-02 @67  #include <net/netdev_queues.h>
6c114677e472d0 Justin Lai 2024-05-02  68  #include <net/page_pool/helpers.h>
6c114677e472d0 Justin Lai 2024-05-02  69  #include <net/pkt_cls.h>
6c114677e472d0 Justin Lai 2024-05-02  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

