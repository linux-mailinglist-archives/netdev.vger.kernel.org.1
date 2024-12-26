Return-Path: <netdev+bounces-154303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8C9FCBBE
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719521883003
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C85D8F0;
	Thu, 26 Dec 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lj+2m7z7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E5647;
	Thu, 26 Dec 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735229570; cv=none; b=GXhrWFwIuW9pKLtbFNJvSR1kFeVcJMbgxiWjTrW25uoKikFHsQuI3He29x1N3ACGalzwFD0tm9inO33CslyMDopFudwrSVC3ix4DhC0rxQJfgqNIYjIgjd2Fx8sxWd8HAvV4uZvF7vaipogQiG3WCV9SRiCFjrmIaCp5wrkx1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735229570; c=relaxed/simple;
	bh=VTlaFfUyGxXavHeYnrdDn3aVaMe/WmZQsQaO+nlu2y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2FIjwoHWRMqx8T+4eS9Hf28ExlrEYaCTYh0Uu5RhfcsxFn5qe24CQp+X9pgL7lk2wVTQ14fvpZ+vPlc7hG/pDorQCTfSYSnjiUUQBngWIT649lr/zYSezpf4byczPhy/P9eGjoouAgNbiK7JweYWq+Su4kPD4g9F00A4t+I7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lj+2m7z7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735229570; x=1766765570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VTlaFfUyGxXavHeYnrdDn3aVaMe/WmZQsQaO+nlu2y0=;
  b=lj+2m7z7yFZV8GhptY5zEHZGZ9ljSLxSRmBMGxkbgZSCJ0GZneuWBxOH
   Osvy3hWToMEL2j+ciI0/Bgaesr3bEHKOh3KSCcH4xdxfskUAmLfatmrEG
   mwbFtZrBGMEn1Y5ujKhOAnMS3leldNz346sg+tK2fCrZQpaOlGJeF5zic
   D174OgmZZZRKEV/wdtYkXE1oBWQMw8kfD5QDJL2IFQtCYfiqRnQs5ykWL
   oRO14wte49Nb42ppWbvRoEvz7rb96iiCkn/CwUmN8I4fMMEuOqaLDNm95
   tkGmwJVASoeAqHy/xmX8GGw4FTjvrbQ6bSRQpOlv4KNkIQbrEN36ByO1/
   A==;
X-CSE-ConnectionGUID: hbIQIC4uRtuzp0iLUEz+pw==
X-CSE-MsgGUID: T6/dT2j1SHqNm/+vskBnIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35358539"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35358539"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 08:12:49 -0800
X-CSE-ConnectionGUID: CllPXsfwR1CBqfRCEfds9g==
X-CSE-MsgGUID: Lq2Ho4+KTYu+BnCu6FgcZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137295161"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Dec 2024 08:12:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQqTZ-0002gT-0S;
	Thu, 26 Dec 2024 16:12:41 +0000
Date: Fri, 27 Dec 2024 00:12:02 +0800
From: kernel test robot <lkp@intel.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [PATCH net-next v02 1/1] hinic3: module initialization and tx/rx
 logic
Message-ID: <202412262331.IwY6o4xF-lkp@intel.com>
References: <bbf2442dc9feca8bfa13ccfa2497a0e857eb5809.1735206602.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf2442dc9feca8bfa13ccfa2497a0e857eb5809.1735206602.git.gur.stavi@huawei.com>

Hi Gur,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9268abe611b09edc975aa27e6ce829f629352ff4]

url:    https://github.com/intel-lab-lkp/linux/commits/Gur-Stavi/hinic3-module-initialization-and-tx-rx-logic/20241226-192558
base:   9268abe611b09edc975aa27e6ce829f629352ff4
patch link:    https://lore.kernel.org/r/bbf2442dc9feca8bfa13ccfa2497a0e857eb5809.1735206602.git.gur.stavi%40huawei.com
patch subject: [PATCH net-next v02 1/1] hinic3: module initialization and tx/rx logic
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241226/202412262331.IwY6o4xF-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 319b89197348b7cad1215e235bdc7b5ec8f9b72c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241226/202412262331.IwY6o4xF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412262331.IwY6o4xF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/huawei/hinic3/hinic3_tx.c:4:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/um/include/asm/cacheflush.h:4:
   In file included from arch/um/include/asm/tlbflush.h:9:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/ethernet/huawei/hinic3/hinic3_tx.c:4:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/huawei/hinic3/hinic3_tx.c:4:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/huawei/hinic3/hinic3_tx.c:4:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/net/ethernet/huawei/hinic3/hinic3_tx.c:292:3: error: call to undeclared function 'csum_ipv6_magic'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     292 |                 csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);
         |                 ^
   13 warnings and 1 error generated.


vim +/csum_ipv6_magic +292 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c

   287	
   288	static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
   289	{
   290		return (ip->v4->version == 4) ?
   291			csum_tcpudp_magic(ip->v4->saddr, ip->v4->daddr, 0, proto, 0) :
 > 292			csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);
   293	}
   294	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

