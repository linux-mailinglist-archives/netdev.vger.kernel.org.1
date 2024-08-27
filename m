Return-Path: <netdev+bounces-122442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384496158F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6855CB22D90
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507DF1D1F72;
	Tue, 27 Aug 2024 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JowLuRmv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EF1D1F71
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780115; cv=none; b=R7+VHoOB2Ea8eJXOgmekd15briSoH4fSaOqQqzzxvX1+whvgF0iSjoLyD54IOfKjDOPYVDVV6+yFgGn+ZreCh2VE2ebWkMWMMsUj+yhv0bHH6MMXR72xQR1rqR9pyeFnGx2LB/R5QySk9FprPK+E+HuoDMzQ0OdcjpT+CpFiP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780115; c=relaxed/simple;
	bh=o2+sF/0A4omvIOgfLTdESzGNUGu8e2JVHlh+A3RmGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDgNKIiKnM9z4+v2visp33VW/Sapy2xzw54vKTGLUT+eTLqR0QhG4HYUcQOSQzbs4c3hK/rf7gzuSgtJdOoBWs2zQGNFHaaT123IWUnfNF/UazTEuoXT/vCUXX1s1nMwT2xmNxdOCJXiNp1Ayv0DTJBBcHrluWK826EZOc3spoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JowLuRmv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724780113; x=1756316113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2+sF/0A4omvIOgfLTdESzGNUGu8e2JVHlh+A3RmGko=;
  b=JowLuRmvQZ3VXYtX4BKtAVX9u0V9jYV4cDOdeXpAovrcztwEDiqRsnfC
   euIcmRbuz6X2/nRolrJQkYQhjo3oHgDQRYNX1NTNiLzFWKE/bJSu5P0dw
   tkgXsiPbloWsTzkH19O75CcZr2kuShlT56l3f/UIyJlGhMF2QctbMssAz
   Cwj8V152wz65xzRr5PeGOePlWzFjYI+Wy7KTJl3sy+sdvEoiBUhoQAQJG
   EWq9Znh/JSnsJY1nhGkbeMszOEZd2j/tNrCOuXYyOzoRuOBJRlEHm4/xU
   JbanVJAMacQFj14cIaVzPn+1/Umnz+MlvF7fhapQbKWaIkyNDAYkF6J6s
   Q==;
X-CSE-ConnectionGUID: iKk6/JJNRHmEWu4PAMwNZQ==
X-CSE-MsgGUID: 82GfECJJQCSAC6BflE2pmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="27043379"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="27043379"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 10:35:11 -0700
X-CSE-ConnectionGUID: r0OPTThvR8O5UEEm/XcKaA==
X-CSE-MsgGUID: ns/Lpc/oTyWiPSMwJm7cXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="62655253"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2024 10:35:08 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj05y-000Jua-0R;
	Tue, 27 Aug 2024 17:35:06 +0000
Date: Wed, 28 Aug 2024 01:34:59 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, sam@mendozajonas.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lihongbo22@huawei.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/ncsi: Use str_up_down to simplify
 the code
Message-ID: <202408280146.axPqeLlk-lkp@intel.com>
References: <20240827025246.963115-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827025246.963115-2-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/net-ncsi-Use-str_up_down-to-simplify-the-code/20240827-104622
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240827025246.963115-2-lihongbo22%40huawei.com
patch subject: [PATCH net-next v2 1/2] net/ncsi: Use str_up_down to simplify the code
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240828/202408280146.axPqeLlk-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280146.axPqeLlk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280146.axPqeLlk-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/ncsi/ncsi-manage.c:6:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from net/ncsi/ncsi-manage.c:9:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
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
   In file included from net/ncsi/ncsi-manage.c:9:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
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
   In file included from net/ncsi/ncsi-manage.c:9:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
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
>> net/ncsi/ncsi-manage.c:1284:9: error: call to undeclared function 'str_up_down'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1284 |                                            str_up_down(ncm->data[2] & 0x1));
         |                                            ^
>> net/ncsi/ncsi-manage.c:1284:9: warning: format specifies type 'char *' but the argument has type 'int' [-Wformat]
    1282 |                                            "NCSI: Channel %u added to queue (link %s)\n",
         |                                                                                   ~~
         |                                                                                   %d
    1283 |                                            nc->id,
    1284 |                                            str_up_down(ncm->data[2] & 0x1));
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/net/net_debug.h:57:38: note: expanded from macro 'netdev_dbg'
      57 |         dynamic_netdev_dbg(__dev, format, ##args);              \
         |                                   ~~~~~~    ^~~~
   include/linux/dynamic_debug.h:278:19: note: expanded from macro 'dynamic_netdev_dbg'
     278 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   17 warnings and 1 error generated.


vim +/str_up_down +1284 net/ncsi/ncsi-manage.c

  1224	
  1225	static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
  1226	{
  1227		struct ncsi_channel *nc, *found, *hot_nc;
  1228		struct ncsi_channel_mode *ncm;
  1229		unsigned long flags, cflags;
  1230		struct ncsi_package *np;
  1231		bool with_link;
  1232	
  1233		spin_lock_irqsave(&ndp->lock, flags);
  1234		hot_nc = ndp->hot_channel;
  1235		spin_unlock_irqrestore(&ndp->lock, flags);
  1236	
  1237		/* By default the search is done once an inactive channel with up
  1238		 * link is found, unless a preferred channel is set.
  1239		 * If multi_package or multi_channel are configured all channels in the
  1240		 * whitelist are added to the channel queue.
  1241		 */
  1242		found = NULL;
  1243		with_link = false;
  1244		NCSI_FOR_EACH_PACKAGE(ndp, np) {
  1245			if (!(ndp->package_whitelist & (0x1 << np->id)))
  1246				continue;
  1247			NCSI_FOR_EACH_CHANNEL(np, nc) {
  1248				if (!(np->channel_whitelist & (0x1 << nc->id)))
  1249					continue;
  1250	
  1251				spin_lock_irqsave(&nc->lock, cflags);
  1252	
  1253				if (!list_empty(&nc->link) ||
  1254				    nc->state != NCSI_CHANNEL_INACTIVE) {
  1255					spin_unlock_irqrestore(&nc->lock, cflags);
  1256					continue;
  1257				}
  1258	
  1259				if (!found)
  1260					found = nc;
  1261	
  1262				if (nc == hot_nc)
  1263					found = nc;
  1264	
  1265				ncm = &nc->modes[NCSI_MODE_LINK];
  1266				if (ncm->data[2] & 0x1) {
  1267					found = nc;
  1268					with_link = true;
  1269				}
  1270	
  1271				/* If multi_channel is enabled configure all valid
  1272				 * channels whether or not they currently have link
  1273				 * so they will have AENs enabled.
  1274				 */
  1275				if (with_link || np->multi_channel) {
  1276					spin_lock_irqsave(&ndp->lock, flags);
  1277					list_add_tail_rcu(&nc->link,
  1278							  &ndp->channel_queue);
  1279					spin_unlock_irqrestore(&ndp->lock, flags);
  1280	
  1281					netdev_dbg(ndp->ndev.dev,
  1282						   "NCSI: Channel %u added to queue (link %s)\n",
  1283						   nc->id,
> 1284						   str_up_down(ncm->data[2] & 0x1));
  1285				}
  1286	
  1287				spin_unlock_irqrestore(&nc->lock, cflags);
  1288	
  1289				if (with_link && !np->multi_channel)
  1290					break;
  1291			}
  1292			if (with_link && !ndp->multi_package)
  1293				break;
  1294		}
  1295	
  1296		if (list_empty(&ndp->channel_queue) && found) {
  1297			netdev_info(ndp->ndev.dev,
  1298				    "NCSI: No channel with link found, configuring channel %u\n",
  1299				    found->id);
  1300			spin_lock_irqsave(&ndp->lock, flags);
  1301			list_add_tail_rcu(&found->link, &ndp->channel_queue);
  1302			spin_unlock_irqrestore(&ndp->lock, flags);
  1303		} else if (!found) {
  1304			netdev_warn(ndp->ndev.dev,
  1305				    "NCSI: No channel found to configure!\n");
  1306			ncsi_report_link(ndp, true);
  1307			return -ENODEV;
  1308		}
  1309	
  1310		return ncsi_process_next_channel(ndp);
  1311	}
  1312	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

