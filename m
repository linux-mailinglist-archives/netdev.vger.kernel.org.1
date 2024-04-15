Return-Path: <netdev+bounces-87939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80808A5070
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE51B2357A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C007BB1C;
	Mon, 15 Apr 2024 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDxjG2CT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312F7A15B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185529; cv=none; b=HW30GUGPAxIZ1P7IsReoF/KKnbYp7FKhVw05y58xQiGyHrNt7SP+qZB/zpgNcI2tCU15QMozvldIj23SMOr/5WjqCmMJv7os13CYL4Hcb9Tnbmaky+zpRA7ea5BCU1XEDM99hU7UKPWxGpgai5TJHhSSKbX5+UGQ1gI+VrHNtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185529; c=relaxed/simple;
	bh=fBpBNh+RtDbYq2yXMn0of/6egCut/ej4kgtevYT8inU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjOhtik1ZqEVP964MDY+VMpQq/Wy6ATR+JuMEVHfWDLxp1/tQrPd0LiKjB3b6wH74nPsDxJ7/eFfjltsh5K/DvfnhTra9f4s7A3jlC1RRyW4wh0SYOMCQdnnsjJz9FdaukscB26qOPEQtuCOXDW/INq6A8bJupADlN1hFRNVqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDxjG2CT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713185527; x=1744721527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fBpBNh+RtDbYq2yXMn0of/6egCut/ej4kgtevYT8inU=;
  b=ZDxjG2CTNkT3fVIUHcX3N9j6EidCtwzHqFM3CQ1/jXX75nQkM1xmtYUD
   iTDWbAAzlggsd4Hy3++gN49qP8B2dr26HUHThjRQfK6wM08h4fzZiKRRy
   z1Xr3ZNUbjRTyH6SdxYQ4h618bost3W3OL5ahbEOAh10hDiHMHfmdFyiU
   5nxj9u07H4s+rgxfo/15YeBU9SOFrLIJu0IA3pxNoBShgIhUMaBbK4VGf
   s3AKpL9vfr1qQOEL6tXMTwCWX50uDi+bD3shqnfnffKcorm2A+lpl9345
   IcixUaKSDxZ7Gxm9AsRqv1q6dJogN78PyEq7R2kEo13yv7nWS+l8aIggK
   g==;
X-CSE-ConnectionGUID: H2MBClb5RSmPH6uVVTZh+g==
X-CSE-MsgGUID: aV1T1dqVRMusBSZl+BbD+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19965338"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="19965338"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 05:52:06 -0700
X-CSE-ConnectionGUID: uTGl1IfzRK2ZA1Fvp2JHvg==
X-CSE-MsgGUID: 5tUmfGUjQQ6qlGaLky9ZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26697325"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 15 Apr 2024 05:52:03 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwLoV-0004B0-2E;
	Mon, 15 Apr 2024 12:51:59 +0000
Date: Mon, 15 Apr 2024 20:51:46 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v7 2/4] ethtool: provide customized dim profile
 management
Message-ID: <202404152005.vHS17jjP-lkp@intel.com>
References: <20240415093638.123962-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415093638.123962-3-hengqi@linux.alibaba.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240415-173921
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240415093638.123962-3-hengqi%40linux.alibaba.com
patch subject: [PATCH net-next v7 2/4] ethtool: provide customized dim profile management
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240415/202404152005.vHS17jjP-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404152005.vHS17jjP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404152005.vHS17jjP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ethtool/coalesce.c:4:
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
   In file included from net/ethtool/coalesce.c:4:
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
   In file included from net/ethtool/coalesce.c:4:
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
>> net/ethtool/coalesce.c:324:32: warning: unused variable 'coalesce_set_profile_policy' [-Wunused-const-variable]
     324 | static const struct nla_policy coalesce_set_profile_policy[] = {
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   13 warnings generated.


vim +/coalesce_set_profile_policy +324 net/ethtool/coalesce.c

   323	
 > 324	static const struct nla_policy coalesce_set_profile_policy[] = {
   325		[ETHTOOL_A_MODERATION_USEC]	= {.type = NLA_U32},
   326		[ETHTOOL_A_MODERATION_PKTS]	= {.type = NLA_U32},
   327		[ETHTOOL_A_MODERATION_COMPS]	= {.type = NLA_U32},
   328	};
   329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

