Return-Path: <netdev+bounces-32497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D147F798051
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 03:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16DE01C20C5D
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 01:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A5EA4;
	Fri,  8 Sep 2023 01:40:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4FEA0
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 01:40:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D81BE1
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694137247; x=1725673247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=worUBMND55vJNbyBeHPqUxOWqBelkEKW/vFbtwAy0vY=;
  b=MgAbUbBoEbTZp7m2YfNmObIVUqkh1p4HxFaauQxlfDGeXXo+kHlgXVaE
   9vsgdtS1EielLxptuOsKTch9T2Mf2fC/yVkF/4QC3QZh3WNjndvzpsulc
   d6rtSYQ8ockM3ttrn263ojKwXv0qeSqN2SjVZ0Q9eBrBEJwhOdNNtwFYB
   JAjVVehuCtJqZzOcn7J8vB33EiM9jmGZaLRwoS/xuO7OqCk7axfJAgzOe
   83Z2bD6hPKNCWhORbKisiWdASLLA/5kXmHWposyAPLX1ey+OXfKE4V/tP
   Xk3SVgLV2SUGqs1pfepOdrJyb96Y6qLplnfFvuxe5Fn5dbxPyj9+M+YFF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380261305"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="380261305"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 18:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="807771527"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="807771527"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2023 18:40:43 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qeQUD-0001nh-0N;
	Fri, 08 Sep 2023 01:40:41 +0000
Date: Fri, 8 Sep 2023 09:40:36 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Zeng <zengyhkyle@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	dsahern@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com
Subject: Re: [PATCH] fix null-deref in ipv4_link_failure
Message-ID: <202309080905.JnJFQ6YN-lkp@intel.com>
References: <ZPpUfm/HhFet3ejH@westworld>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPpUfm/HhFet3ejH@westworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Kyle,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5 next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Zeng/fix-null-deref-in-ipv4_link_failure/20230908-065510
base:   linus/master
patch link:    https://lore.kernel.org/r/ZPpUfm%2FHhFet3ejH%40westworld
patch subject: [PATCH] fix null-deref in ipv4_link_failure
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230908/202309080905.JnJFQ6YN-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080905.JnJFQ6YN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080905.JnJFQ6YN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/ipv4/route.c:67:
   In file included from include/linux/memblock.h:13:
   In file included from arch/um/include/asm/dma.h:5:
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
   In file included from net/ipv4/route.c:67:
   In file included from include/linux/memblock.h:13:
   In file included from arch/um/include/asm/dma.h:5:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/ipv4/route.c:67:
   In file included from include/linux/memblock.h:13:
   In file included from arch/um/include/asm/dma.h:5:
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
   net/ipv4/route.c:880:6: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     880 |         int log_martians;
         |             ^
>> net/ipv4/route.c:1235:38: error: use of undeclared identifier 'net'
    1235 |                 res = __ip_options_compile(dev_net(net), &opt, skb, NULL);
         |                                                    ^
   13 warnings and 1 error generated.


vim +/net +1235 net/ipv4/route.c

  1213	
  1214	static void ipv4_send_dest_unreach(struct sk_buff *skb)
  1215	{
  1216		struct ip_options opt;
  1217		int res;
  1218		struct net_device *dev;
  1219	
  1220		/* Recompile ip options since IPCB may not be valid anymore.
  1221		 * Also check we have a reasonable ipv4 header.
  1222		 */
  1223		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)) ||
  1224		    ip_hdr(skb)->version != 4 || ip_hdr(skb)->ihl < 5)
  1225			return;
  1226	
  1227		memset(&opt, 0, sizeof(opt));
  1228		if (ip_hdr(skb)->ihl > 5) {
  1229			if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
  1230				return;
  1231			opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
  1232	
  1233			rcu_read_lock();
  1234			dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
> 1235			res = __ip_options_compile(dev_net(net), &opt, skb, NULL);
  1236			rcu_read_unlock();
  1237	
  1238			if (res)
  1239				return;
  1240		}
  1241		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &opt);
  1242	}
  1243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

