Return-Path: <netdev+bounces-115454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ABC946672
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DBA1F21AF3
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F681E;
	Sat,  3 Aug 2024 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vi6tiLVd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C284A1C
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644884; cv=none; b=Xi5TqpQIU0hEQunRaDdTVJnG64ES6x3zLO2QdxG9h8Bq8H6Jiw/0sLyg3LuPDE1Z695nVPTnT3WdxalZYq4r3qsZwLVh0Fc8mrlf3W5u8D7kE0kOv0l3kG5/tnEJt8KZ9HQmlsg2odcQ2HYx+llg6jIhsm+On3u3ajIqGEd3H8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644884; c=relaxed/simple;
	bh=Uc0cogrRKmgrY6hY1JOF7K/xWaTjPOwJah3nxRySFu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7jdwfRXtRLNERduxt/yUj+4d11/oKas1OjZxq+rDb4dnMFNsxtQ8ptw9hU3PrW6UUX/u9691TZ52oDWPd/YE36ajmRueS6TWTacPObN3qX5f6xyGMOX3bxQLLBxVwI+4Fjy+5jMwqDkmB9z0TQ8hkluaPFJ+uA/AKCB8qB/oR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vi6tiLVd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722644882; x=1754180882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uc0cogrRKmgrY6hY1JOF7K/xWaTjPOwJah3nxRySFu4=;
  b=Vi6tiLVdC7kQUT96u6GG489ne3vdymM0kyU2rhSCPrcERDOcdx1y2JqZ
   9sh4urMn8N/oeG2hUdUYD9jbp/YYoXBLgSe1H3pIeEOU7FWA7hFfQ3W1d
   3FlxJeh8fYBYr6N1/s2TnU2baFZNObmeJ+Xz7ca9ApWZZPQqFVzhPSSPt
   iA/oD057awTUb95H/hLpiRsA6hrUeFQhamjioNA997MjygAuHVuwdu7Dc
   9mKAi5cwr9j4082Yz+tRByS7BAq6ctQQVlGET7oFAncoNbAz+D06UTfla
   wbOPuWUcDyHNZdVNt7y1Y/Mro0xd7Twd0QSpqdNLs2sH5zp7vPy59e9y8
   Q==;
X-CSE-ConnectionGUID: dO4VNQaGQkOSDFV5Sv/3OQ==
X-CSE-MsgGUID: Yp248r6EQdCp4x3kzSIJWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="46084216"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="46084216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 17:28:01 -0700
X-CSE-ConnectionGUID: l7/wzxjnQEmSSmCVvXLZaQ==
X-CSE-MsgGUID: tF/laSRjSuOBBt5CCv2dLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="55225502"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Aug 2024 17:27:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa2cn-000xbc-1K;
	Sat, 03 Aug 2024 00:27:57 +0000
Date: Sat, 3 Aug 2024 08:27:19 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v7 08/16] xfrm: iptfs: add user packet (tunnel
 ingress) handling
Message-ID: <202408030845.8Jzc5s6Q-lkp@intel.com>
References: <20240801080314.169715-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801080314.169715-9-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on netfilter-nf/main linus/master v6.11-rc1 next-20240802]
[cannot apply to klassert-ipsec/master nf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/xfrm-config-add-CONFIG_XFRM_IPTFS/20240802-185628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240801080314.169715-9-chopps%40chopps.org
patch subject: [PATCH ipsec-next v7 08/16] xfrm: iptfs: add user packet (tunnel ingress) handling
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240803/202408030845.8Jzc5s6Q-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030845.8Jzc5s6Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030845.8Jzc5s6Q-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/xfrm/xfrm_iptfs.c:11:
   In file included from include/linux/icmpv6.h:5:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/xfrm/xfrm_iptfs.c:11:
   In file included from include/linux/icmpv6.h:5:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/xfrm/xfrm_iptfs.c:11:
   In file included from include/linux/icmpv6.h:5:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/xfrm/xfrm_iptfs.c:11:
   In file included from include/linux/icmpv6.h:5:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/xfrm/xfrm_iptfs.c:629:8: warning: comparison of distinct pointer types ('typeof ((xtfs->ecn_queue_size)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     629 |         (void)do_div(xtfs->ecn_queue_size, 100);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> net/xfrm/xfrm_iptfs.c:629:8: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     629 |         (void)do_div(xtfs->ecn_queue_size, 100);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
>> net/xfrm/xfrm_iptfs.c:629:8: warning: shift count >= width of type [-Wshift-count-overflow]
     629 |         (void)do_div(xtfs->ecn_queue_size, 100);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   9 warnings and 1 error generated.


vim +629 net/xfrm/xfrm_iptfs.c

   588	
   589	/**
   590	 * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
   591	 * @net: the net data
   592	 * @x: xfrm state
   593	 * @attrs: netlink attributes
   594	 * @extack: extack return data
   595	 *
   596	 * Return: 0 on success or a negative error code on failure
   597	 */
   598	static int iptfs_user_init(struct net *net, struct xfrm_state *x,
   599				   struct nlattr **attrs,
   600				   struct netlink_ext_ack *extack)
   601	{
   602		struct xfrm_iptfs_data *xtfs = x->mode_data;
   603		struct xfrm_iptfs_config *xc;
   604	
   605		xc = &xtfs->cfg;
   606		xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
   607		xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
   608	
   609		if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
   610			xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
   611			if (!xc->pkt_size) {
   612				xtfs->payload_mtu = 0;
   613			} else if (xc->pkt_size > x->props.header_len) {
   614				xtfs->payload_mtu = xc->pkt_size - x->props.header_len;
   615			} else {
   616				NL_SET_ERR_MSG(extack,
   617					       "Packet size must be 0 or greater than IPTFS/ESP header length");
   618				return -EINVAL;
   619			}
   620		}
   621		if (attrs[XFRMA_IPTFS_MAX_QSIZE])
   622			xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
   623		if (attrs[XFRMA_IPTFS_INIT_DELAY])
   624			xtfs->init_delay_ns =
   625				(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) *
   626				NSECS_IN_USEC;
   627	
   628		xtfs->ecn_queue_size = (u64)xc->max_queue_size * 95;
 > 629		(void)do_div(xtfs->ecn_queue_size, 100);
   630	
   631		return 0;
   632	}
   633	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

