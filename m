Return-Path: <netdev+bounces-87255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5948A2538
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C5E1F22211
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 04:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885A8BF6;
	Fri, 12 Apr 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsmZUCpH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB28495
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896829; cv=none; b=aIWiEtMLwVNUjRYIPDp8GbDLDjWYzVjb1V+c6hNi4K3+5WZznCT3CzXAJhRqQyMmNQQlivyfnDV7xVa5vUpTp1pgmpBtyCzeKoO9unsnCfzVhYfjqFL/UH6QYWwc6swwm+2nr1ZC9UWkHPQMsiu66Cnp81/cww6YeHU1ig/EEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896829; c=relaxed/simple;
	bh=5vcha2skKFg7homxabfBR6MOVSqWIbOUyiwXv0dSf/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV+1DCcG+j82JVHnuhMxDLpLc0AHFA5VmomfeySfEI5B8V358WwM/xVNLq0ZPeVhdIjtJ9fsgoWklrjB1laAevY5U1clsRlnu5GTWnS3BOd5wYaEQQaQXDpAfQeUzRABdhH1vq1/rBDUfCg5/7Cf65vP/aKJdBvEjTdGvFEw3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsmZUCpH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712896827; x=1744432827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vcha2skKFg7homxabfBR6MOVSqWIbOUyiwXv0dSf/s=;
  b=dsmZUCpHQqw2mfsq3aE4VuvMYlWZ3O/RFuQQJXYChnK5HfgKdyutjiaq
   RRRO598IhNmEKE5ezU66yJ6bBOBJ2EvIl/4O5SrdvacVE3qL/Ni9mEXh8
   XWvc8VszrSCEJrQzbLoB+7wB6aWUTyk5T/UjA7klC2tHiTU/yR8ocuI04
   Lh/vzES+sjPu5z8FKKgbjie3QbS1OrB9O/ThJwMiZUN7yMlq7Xhwu8wXz
   Gl+8jMP+phtFJCSY8upTziubD/s0TUgzpLs8oXfuxiJCKun2T6AYQ8i8E
   NX7w7+4OASpB8E9aO3wdq625FJvV7wut34LTin5HzdDSer4xs1FKx1juB
   w==;
X-CSE-ConnectionGUID: x77E8h6lSGyNRNAZWdv0rA==
X-CSE-MsgGUID: gd/fBhVmQtKW0xaC3jFJgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8447801"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8447801"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 21:40:26 -0700
X-CSE-ConnectionGUID: EN3bB6ZVSGSa/76hKno/XA==
X-CSE-MsgGUID: nGb6v1mERgmh7PNYcabdeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52087681"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Apr 2024 21:40:23 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv8i4-0009ND-1m;
	Fri, 12 Apr 2024 04:40:20 +0000
Date: Fri, 12 Apr 2024 12:39:53 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202404121200.pplgT1xP-lkp@intel.com>
References: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240411-221400
base:   net-next/main
patch link:    https://lore.kernel.org/r/1712844751-53514-3-git-send-email-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v6 2/4] ethtool: provide customized dim profile management
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240412/202404121200.pplgT1xP-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404121200.pplgT1xP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404121200.pplgT1xP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/dev.c:80:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/core/dev.c:80:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/core/dev.c:80:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
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
>> net/core/dev.c:10235:58: error: no member named 'rx_eqe_profile' in 'struct net_device'
    10235 |         int length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*dev->rx_eqe_profile);
          |                                                            ~~~  ^
   net/core/dev.c:10242:8: error: no member named 'rx_eqe_profile' in 'struct net_device'
    10242 |                 dev->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
          |                 ~~~  ^
   net/core/dev.c:10243:13: error: no member named 'rx_eqe_profile' in 'struct net_device'
    10243 |                 if (!dev->rx_eqe_profile)
          |                      ~~~  ^
   net/core/dev.c:10245:15: error: no member named 'rx_eqe_profile' in 'struct net_device'
    10245 |                 memcpy(dev->rx_eqe_profile, rx_profile[0], length);
          |                        ~~~  ^
>> net/core/dev.c:10248:8: error: no member named 'rx_cqe_profile' in 'struct net_device'
    10248 |                 dev->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
          |                 ~~~  ^
   net/core/dev.c:10249:13: error: no member named 'rx_cqe_profile' in 'struct net_device'
    10249 |                 if (!dev->rx_cqe_profile)
          |                      ~~~  ^
   net/core/dev.c:10251:15: error: no member named 'rx_cqe_profile' in 'struct net_device'
    10251 |                 memcpy(dev->rx_cqe_profile, rx_profile[1], length);
          |                        ~~~  ^
>> net/core/dev.c:10254:8: error: no member named 'tx_eqe_profile' in 'struct net_device'
    10254 |                 dev->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
          |                 ~~~  ^
   net/core/dev.c:10255:13: error: no member named 'tx_eqe_profile' in 'struct net_device'
    10255 |                 if (!dev->tx_eqe_profile)
          |                      ~~~  ^
   net/core/dev.c:10257:15: error: no member named 'tx_eqe_profile' in 'struct net_device'
    10257 |                 memcpy(dev->tx_eqe_profile, tx_profile[0], length);
          |                        ~~~  ^
>> net/core/dev.c:10260:8: error: no member named 'tx_cqe_profile' in 'struct net_device'
    10260 |                 dev->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
          |                 ~~~  ^
   net/core/dev.c:10261:13: error: no member named 'tx_cqe_profile' in 'struct net_device'
    10261 |                 if (!dev->tx_cqe_profile)
          |                      ~~~  ^
   net/core/dev.c:10263:15: error: no member named 'tx_cqe_profile' in 'struct net_device'
    10263 |                 memcpy(dev->tx_cqe_profile, tx_profile[1], length);
          |                        ~~~  ^
   net/core/dev.c:11063:14: error: no member named 'rx_eqe_profile' in 'struct net_device'
    11063 |                 kfree(dev->rx_eqe_profile);
          |                       ~~~  ^
   net/core/dev.c:11066:14: error: no member named 'rx_cqe_profile' in 'struct net_device'
    11066 |                 kfree(dev->rx_cqe_profile);
          |                       ~~~  ^
   net/core/dev.c:11069:14: error: no member named 'tx_eqe_profile' in 'struct net_device'
    11069 |                 kfree(dev->tx_eqe_profile);
          |                       ~~~  ^
   net/core/dev.c:11072:14: error: no member named 'tx_cqe_profile' in 'struct net_device'
    11072 |                 kfree(dev->tx_cqe_profile);
          |                       ~~~  ^
   12 warnings and 17 errors generated.
--
   In file included from net/ethtool/coalesce.c:3:
   In file included from net/ethtool/netlink.h:6:
   In file included from include/linux/ethtool_netlink.h:6:
   In file included from include/uapi/linux/ethtool_netlink.h:12:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/ethtool/coalesce.c:3:
   In file included from net/ethtool/netlink.h:6:
   In file included from include/linux/ethtool_netlink.h:6:
   In file included from include/uapi/linux/ethtool_netlink.h:12:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/ethtool/coalesce.c:3:
   In file included from net/ethtool/netlink.h:6:
   In file included from include/linux/ethtool_netlink.h:6:
   In file included from include/uapi/linux/ethtool_netlink.h:12:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
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
>> net/ethtool/coalesce.c:268:11: error: no member named 'rx_eqe_profile' in 'struct net_device'
     268 |                                  dev->rx_eqe_profile, supported) ||
         |                                  ~~~  ^
>> net/ethtool/coalesce.c:270:11: error: no member named 'rx_cqe_profile' in 'struct net_device'
     270 |                                  dev->rx_cqe_profile, supported) ||
         |                                  ~~~  ^
>> net/ethtool/coalesce.c:272:11: error: no member named 'tx_eqe_profile' in 'struct net_device'
     272 |                                  dev->tx_eqe_profile, supported) ||
         |                                  ~~~  ^
>> net/ethtool/coalesce.c:274:11: error: no member named 'tx_cqe_profile' in 'struct net_device'
     274 |                                  dev->tx_cqe_profile, supported))
         |                                  ~~~  ^
   net/ethtool/coalesce.c:479:39: error: no member named 'rx_eqe_profile' in 'struct net_device'
     479 |         ret = ethnl_update_profile(dev, dev->rx_eqe_profile,
         |                                         ~~~  ^
   net/ethtool/coalesce.c:484:39: error: no member named 'rx_cqe_profile' in 'struct net_device'
     484 |         ret = ethnl_update_profile(dev, dev->rx_cqe_profile,
         |                                         ~~~  ^
   net/ethtool/coalesce.c:489:39: error: no member named 'tx_eqe_profile' in 'struct net_device'
     489 |         ret = ethnl_update_profile(dev, dev->tx_eqe_profile,
         |                                         ~~~  ^
   net/ethtool/coalesce.c:494:39: error: no member named 'tx_cqe_profile' in 'struct net_device'
     494 |         ret = ethnl_update_profile(dev, dev->tx_cqe_profile,
         |                                         ~~~  ^
   12 warnings and 8 errors generated.


vim +10235 net/core/dev.c

 10232	
 10233	static int dev_dim_profile_init(struct net_device *dev)
 10234	{
 10235		int length = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*dev->rx_eqe_profile);
 10236		u32 supported = dev->ethtool_ops->supported_coalesce_params;
 10237	
 10238		if (!(dev->priv_flags & (IFF_PROFILE_USEC | IFF_PROFILE_PKTS | IFF_PROFILE_COMPS)))
 10239			return 0;
 10240	
 10241		if (supported & ETHTOOL_COALESCE_RX_EQE_PROFILE) {
 10242			dev->rx_eqe_profile = kzalloc(length, GFP_KERNEL);
 10243			if (!dev->rx_eqe_profile)
 10244				return -ENOMEM;
 10245			memcpy(dev->rx_eqe_profile, rx_profile[0], length);
 10246		}
 10247		if (supported & ETHTOOL_COALESCE_RX_CQE_PROFILE) {
 10248			dev->rx_cqe_profile = kzalloc(length, GFP_KERNEL);
 10249			if (!dev->rx_cqe_profile)
 10250				return -ENOMEM;
 10251			memcpy(dev->rx_cqe_profile, rx_profile[1], length);
 10252		}
 10253		if (supported & ETHTOOL_COALESCE_TX_EQE_PROFILE) {
 10254			dev->tx_eqe_profile = kzalloc(length, GFP_KERNEL);
 10255			if (!dev->tx_eqe_profile)
 10256				return -ENOMEM;
 10257			memcpy(dev->tx_eqe_profile, tx_profile[0], length);
 10258		}
 10259		if (supported & ETHTOOL_COALESCE_TX_CQE_PROFILE) {
 10260			dev->tx_cqe_profile = kzalloc(length, GFP_KERNEL);
 10261			if (!dev->tx_cqe_profile)
 10262				return -ENOMEM;
 10263			memcpy(dev->tx_cqe_profile, tx_profile[1], length);
 10264		}
 10265	
 10266		return 0;
 10267	}
 10268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

