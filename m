Return-Path: <netdev+bounces-96296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9D8C4D91
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE03C1F21868
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FC1B7FD;
	Tue, 14 May 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnbzO7I/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1A17C7C;
	Tue, 14 May 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674561; cv=none; b=Vwm17sm2jfbS4N+IaQDhoGecAMRFWNBTC9Gkl+SbnPe7h2Gr2sxlEaXhc+X0hkfNDjt2N8I9ASDmgmHw0E3SiZXGIOpin51ps/+S9pxrkoZeRO0zXUp2FVI6JstKkEywT5O3BQ2/90BkmWJP3DkWItcgrLpFKZe3HOc4/FIl/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674561; c=relaxed/simple;
	bh=FElbwnqrhVDqn0d12ciRbpWVx1AzDYDzRuqgRJ1e7eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK3MdpirlB68+I3+tTvar3mx5CsbPnBVnN2cv4CPFoOGy25vbUUn47b8zv7sJTqMQ4KgWNcjOxfsNLKPgdgOfNiIppd9iTz7xLoIvMTVknMCUccdPM2DmZWa4ZK+gcyBWLrBpVO8Pq9hvNEJAe0MWlxj17T/ruGZisnvR33dutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnbzO7I/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715674559; x=1747210559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FElbwnqrhVDqn0d12ciRbpWVx1AzDYDzRuqgRJ1e7eQ=;
  b=VnbzO7I/odbrZlRqm9VdTe7DNthXfAG3Bc4feNZY4NScMpTjGsV0gy5e
   pOkANWJPbzm+lbyMmZ23gkZKFCNdbuxeCkVAPz6WiDCMri/w3oXCO0KWN
   v7URVaeeSjTsJ9jEZjjlTJY5jEXbbGRpCRGmluQ0j3TmLgoTL576TjwG0
   1uGWKiA8XBfzoTyxmKF5M59m0ooEPWrQeFt6sIY1k5Im1QssXn0sgB/UP
   VTY/y5c8I9VqBW13m3TFPBhoX+/0gir8tfUyFRgYnKYgEOskaXnDmsd3n
   Lg8ck4MWfw65RJkhiAwvAV3x9BKIrMpiRaQgddhtlMUVDpzRbp+Q7saJE
   A==;
X-CSE-ConnectionGUID: AjgB1ISbRzSJiLKLH13wKg==
X-CSE-MsgGUID: jGyPScK1QNSH5J2ccyxG6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="23046565"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="23046565"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 01:15:59 -0700
X-CSE-ConnectionGUID: O0B2e/EYTK2naHqRzX/zPA==
X-CSE-MsgGUID: BdrTSX4DQtCsowv/qhiA5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="31155133"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 May 2024 01:15:53 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6nKA-000BHD-2u;
	Tue, 14 May 2024 08:15:50 +0000
Date: Tue, 14 May 2024 16:15:06 +0800
From: kernel test robot <lkp@intel.com>
To: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
	richardcochran@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete support for
 outb inline ipsec
Message-ID: <202405141559.4cP9LvuS-lkp@intel.com>
References: <20240513105446.297451-6-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513105446.297451-6-bbhushan2@marvell.com>

Hi Bharat,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240513]
[cannot apply to linus/master horms-ipvs/master v6.9 v6.9-rc7 v6.9-rc6 v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/octeontx2-pf-map-skb-data-as-device-writeable/20240513-185803
base:   next-20240513
patch link:    https://lore.kernel.org/r/20240513105446.297451-6-bbhushan2%40marvell.com
patch subject: [net-next,v2 5/8] cn10k-ipsec: Add SA add/delete support for outb inline ipsec
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240514/202405141559.4cP9LvuS-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405141559.4cP9LvuS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405141559.4cP9LvuS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:7:
   In file included from include/net/xfrm.h:9:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:7:
   In file included from include/net/xfrm.h:9:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:7:
   In file included from include/net/xfrm.h:9:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:7:
   In file included from include/net/xfrm.h:9:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
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
>> drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:681:6: warning: variable 'pf' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     681 |         if (x->xso.dir == XFRM_DEV_OFFLOAD_IN) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:721:16: note: uninitialized use occurs here
     721 |         mutex_unlock(&pf->ipsec.lock);
         |                       ^~
   drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:681:2: note: remove the 'if' if its condition is always false
     681 |         if (x->xso.dir == XFRM_DEV_OFFLOAD_IN) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     682 |                 netdev_err(netdev, "xfrm inbound offload not supported\n");
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     683 |                 err = -ENODEV;
         |                 ~~~~~~~~~~~~~~
     684 |         } else {
         |         ~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:674:21: note: initialize the variable 'pf' to silence this warning
     674 |         struct otx2_nic *pf;
         |                            ^
         |                             = NULL
   drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c:768:33: warning: unused variable 'cn10k_ipsec_xfrmdev_ops' [-Wunused-const-variable]
     768 | static const struct xfrmdev_ops cn10k_ipsec_xfrmdev_ops = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   19 warnings generated.


vim +681 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c

   667	
   668	static int cn10k_ipsec_add_state(struct xfrm_state *x,
   669					 struct netlink_ext_ack *extack)
   670	{
   671		struct net_device *netdev = x->xso.dev;
   672		struct cn10k_tx_sa_s *sa_entry;
   673		struct cpt_ctx_info_s *sa_info;
   674		struct otx2_nic *pf;
   675		int err;
   676	
   677		err = cn10k_ipsec_validate_state(x);
   678		if (err)
   679			return err;
   680	
 > 681		if (x->xso.dir == XFRM_DEV_OFFLOAD_IN) {
   682			netdev_err(netdev, "xfrm inbound offload not supported\n");
   683			err = -ENODEV;
   684		} else {
   685			pf = netdev_priv(netdev);
   686			if (!mutex_trylock(&pf->ipsec.lock)) {
   687				netdev_err(netdev, "IPSEC device is busy\n");
   688				return -EBUSY;
   689			}
   690	
   691			if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
   692				netdev_err(netdev, "IPSEC not enabled/supported on device\n");
   693				err = -ENODEV;
   694				goto unlock;
   695			}
   696	
   697			sa_entry = cn10k_outb_alloc_sa(pf);
   698			if (!sa_entry) {
   699				netdev_err(netdev, "SA maximum limit %x reached\n",
   700					   CN10K_IPSEC_OUTB_MAX_SA);
   701				err = -EBUSY;
   702				goto unlock;
   703			}
   704	
   705			cn10k_outb_prepare_sa(x, sa_entry);
   706	
   707			err = cn10k_outb_write_sa(pf, sa_entry);
   708			if (err) {
   709				netdev_err(netdev, "Error writing outbound SA\n");
   710				cn10k_outb_free_sa(pf, sa_entry);
   711				goto unlock;
   712			}
   713	
   714			sa_info = kmalloc(sizeof(*sa_info), GFP_KERNEL);
   715			sa_info->sa_entry = sa_entry;
   716			sa_info->sa_iova = cn10k_outb_get_sa_iova(pf, sa_entry);
   717			x->xso.offload_handle = (unsigned long)sa_info;
   718		}
   719	
   720	unlock:
   721		mutex_unlock(&pf->ipsec.lock);
   722		return err;
   723	}
   724	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

