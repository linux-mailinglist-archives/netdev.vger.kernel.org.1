Return-Path: <netdev+bounces-100918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102C8FC880
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE83B20CCC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269018FDD6;
	Wed,  5 Jun 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9iWziCx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A444963B
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581604; cv=none; b=YV4d9tuI8e676vOGQ5FZSQkT9V6Gf2wu9Xou+Syj2uMvW649iko2Rut+OsqS/DwIkNnsWIyuJcecB3T2Pu86P7hN7MRp5vYCa6ncwoUKL9yyde9fThYVpX2obcf6GbdLGoDiP3zn0qLly1/pmf/x0ggG6jUtwywJeyrpPbFXavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581604; c=relaxed/simple;
	bh=eAaxL8dOEnbdf7zGGC+8t1JAz072u3mHY8NMv+nWuss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gncHQ9NKlwYL6mcTW40Td5Nra+kbaCj0Wd+eeEtJ0VyFWHS9rNV9rsQ5HE8QTw9heljtmcvTaQUUsYugOuTHJRtIydbvtaPItxolmUEaanS5dQqYoJo49w/zrB0VAQp+5m6rZL2UXxtBvw3ajBlhi0WalqMjBcXRXU7lfkLwvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9iWziCx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717581603; x=1749117603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eAaxL8dOEnbdf7zGGC+8t1JAz072u3mHY8NMv+nWuss=;
  b=L9iWziCxN9h0fzt7VnjzvCQtnnexW4yakVg9mieaEM5yz6bQGGieqhFf
   xwM8cLC+8Nkrhw4RgxkmCO/PbWDsmRxEx4JkJgU8LbO/UGJej6bLmPbOf
   C9G5oa46cXVMM8dx00tHvDXYOmH84CtKhJwB1CQC3zRtHwt9Fn+FFb6V0
   YrAHi9qFS5vucE1ofDJKW/prARSe+oVnOPlGMBXoTm7bCpeow2LcIhil5
   eUPiW9zy5tNVPlRj0NhEzxx+qF69cJhlj2kmZNXQMkO7VRmkvFJ8IiyBD
   pyd315Mbtt4xKhZI6HZjESuBX05AjNowXmNsWhfaYekomgxnXhAMyqtfn
   Q==;
X-CSE-ConnectionGUID: ytK1TA4+SW6pNHESeX5WMg==
X-CSE-MsgGUID: ngxPYzpwR4uayujGWF0yeQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36701754"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36701754"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:00:01 -0700
X-CSE-ConnectionGUID: treg5r/ASvGGEt8dZN8jYA==
X-CSE-MsgGUID: T715PcomRA+BQv6VWbb0gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="75025241"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Jun 2024 02:59:59 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEnQy-0001MS-0s;
	Wed, 05 Jun 2024 09:59:56 +0000
Date: Wed, 5 Jun 2024 17:59:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: core: Implement dstats-type stats collections
Message-ID: <202406051710.KozBBK8o-lkp@intel.com>
References: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32f88d65f01bf6f45476d7edbe675e44fb9e1d58]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-core-vrf-Change-pcpu_dstat-fields-to-u64_stats_t/20240605-143942
base:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
patch link:    https://lore.kernel.org/r/20240605-dstats-v1-2-1024396e1670%40codeconstruct.com.au
patch subject: [PATCH 2/3] net: core: Implement dstats-type stats collections
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20240605/202406051710.KozBBK8o-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051710.KozBBK8o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051710.KozBBK8o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/core/dev.c:80:
   In file included from include/linux/sched/isolation.h:5:
   In file included from include/linux/cpuset.h:17:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/core/dev.c:80:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
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
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
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
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> net/core/dev.c:10871:24: warning: variable 'dstats' is uninitialized when used here [-Wuninitialized]
    10871 |                 dstats = per_cpu_ptr(dstats, cpu);
          |                                      ^~~~~~
   include/linux/percpu-defs.h:263:65: note: expanded from macro 'per_cpu_ptr'
     263 | #define per_cpu_ptr(ptr, cpu)   ({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
         |                                                                   ^~~
   include/linux/percpu-defs.h:260:38: note: expanded from macro 'VERIFY_PERCPU_PTR'
     260 |         (typeof(*(__p)) __kernel __force *)(__p);                       \
         |                                             ^~~
   net/core/dev.c:10868:35: note: initialize the variable 'dstats' to silence this warning
    10868 |                 const struct pcpu_dstats *dstats;
          |                                                 ^
          |                                                  = NULL
   net/core/dev.c:4128:1: warning: unused function 'sch_handle_ingress' [-Wunused-function]
    4128 | sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
         | ^~~~~~~~~~~~~~~~~~
   net/core/dev.c:4135:1: warning: unused function 'sch_handle_egress' [-Wunused-function]
    4135 | sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
         | ^~~~~~~~~~~~~~~~~
   net/core/dev.c:5392:19: warning: unused function 'nf_ingress' [-Wunused-function]
    5392 | static inline int nf_ingress(struct sk_buff *skb, struct packet_type **pt_prev,
         |                   ^~~~~~~~~~
   17 warnings generated.


vim +/dstats +10871 net/core/dev.c

 10851	
 10852	/**
 10853	 *	dev_fetch_dstats - collate per-cpu network dstats statistics
 10854	 *	@s: place to store stats
 10855	 *	@dstats: per-cpu network stats to read from
 10856	 *
 10857	 *	Read per-cpu network statistics from dev->dstats and populate the
 10858	 *	related fields in @s.
 10859	 */
 10860	void dev_fetch_dstats(struct rtnl_link_stats64 *s,
 10861			      const struct pcpu_dstats __percpu *dstats)
 10862	{
 10863		int cpu;
 10864	
 10865		for_each_possible_cpu(cpu) {
 10866			u64 rx_packets, rx_bytes, rx_drops;
 10867			u64 tx_packets, tx_bytes, tx_drops;
 10868			const struct pcpu_dstats *dstats;
 10869			unsigned int start;
 10870	
 10871			dstats = per_cpu_ptr(dstats, cpu);
 10872			do {
 10873				start = u64_stats_fetch_begin(&dstats->syncp);
 10874				rx_packets = u64_stats_read(&dstats->rx_packets);
 10875				rx_bytes   = u64_stats_read(&dstats->rx_bytes);
 10876				rx_drops   = u64_stats_read(&dstats->rx_drops);
 10877				tx_packets = u64_stats_read(&dstats->tx_packets);
 10878				tx_bytes   = u64_stats_read(&dstats->tx_bytes);
 10879				tx_drops   = u64_stats_read(&dstats->tx_drops);
 10880			} while (u64_stats_fetch_retry(&dstats->syncp, start));
 10881	
 10882			s->rx_packets += rx_packets;
 10883			s->rx_bytes   += rx_bytes;
 10884			s->rx_dropped += rx_drops;
 10885			s->tx_packets += tx_packets;
 10886			s->tx_bytes   += tx_bytes;
 10887			s->tx_dropped += tx_drops;
 10888		}
 10889	}
 10890	EXPORT_SYMBOL_GPL(dev_fetch_dstats);
 10891	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

