Return-Path: <netdev+bounces-97371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF748CB1EC
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B8DB23864
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B07F1BF37;
	Tue, 21 May 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eg3dyUMl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AE2E62F
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307660; cv=none; b=C7s1DHE6dX543+72qv4ykdBTFYeDB6B4tjdmQekIZJmb01Cma2MTKf28wfYCEJ91sp74k4advjCTXz1DpW003WeL2PVzEP3zZYdFOortsXcILgWtB8DXDS9NJxAq626xlqdJ+kN5OiDmC1nG5qFz8sHrYYTYPM3NQhXKNM8slY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307660; c=relaxed/simple;
	bh=X6+TQuHQYvENKSfztJ5OftVkQopYjO+iM3X+c63PpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArJH5AbL5+iChSW0vxJQCKBGJ3QplpigSjXIM1PXC0rkKwfsNLsEqboeUWSfiz/U7BeMDzQ8pLLHW+fHoWmpnjzC9O9DsCnw43QGXYRybdmmCaELF2TFtBI/zX7oOG6qFRU+EmAw/6Ip20mbPegHIO3T/vvKJj0dVIIAh03hXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eg3dyUMl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716307658; x=1747843658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X6+TQuHQYvENKSfztJ5OftVkQopYjO+iM3X+c63PpAo=;
  b=eg3dyUMlQRb81jr33MY+2kZ4xnxc7WaLPfFk2eG8l+AP+T+xVSlTs/rm
   tT6Q9eiY0TR+jsPvwIRrePV9kOKykGbFCd1XuuBtnABoGvxTIsXOWgHCG
   2gEqI0c6PLKJtEwjC3etRrDTQZkAsChTSUsFz3YxukpLthwDxQXvfuU67
   q8sgYWiCQifMmhb3hCuh/msKDSlD+5ebFsjWdaQ+TsKK/8UiK56FwkGzx
   Q0VQFLXsUTp//LJmzBZnmx0drFJmXPfAgnCAAvQ9BeFq3oM7AAWHHyyE3
   Qm2mccHoh9W1w0A3b3RWnuXHQAWuNlSS08kKSEKdDuTjcjauNMZz1sKsW
   Q==;
X-CSE-ConnectionGUID: wUpWwQZqT/aOs+5+ZPsS+A==
X-CSE-MsgGUID: bk0ujKNtSwi2shn1vM8nVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23918927"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23918927"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:07:30 -0700
X-CSE-ConnectionGUID: L8Q/U9mDTeq3jXNUSIKErA==
X-CSE-MsgGUID: A2di3e/mSd20kHJVKIOzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33030958"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 21 May 2024 09:07:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9S1N-0000Vx-00;
	Tue, 21 May 2024 16:07:25 +0000
Date: Wed, 22 May 2024 00:07:01 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v2 16/17] xfrm: iptfs: handle reordering of
 received packets
Message-ID: <202405212335.amQLFAic-lkp@intel.com>
References: <20240520214255.2590923-17-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520214255.2590923-17-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[cannot apply to klassert-ipsec/master netfilter-nf/main linus/master nf-next/master v6.9 next-20240521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/include-uapi-add-ip_tfs_-_hdr-packet-formats/20240521-064324
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240520214255.2590923-17-chopps%40chopps.org
patch subject: [PATCH ipsec-next v2 16/17] xfrm: iptfs: handle reordering of received packets
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240521/202405212335.amQLFAic-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405212335.amQLFAic-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405212335.amQLFAic-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/xfrm/xfrm_iptfs.c:11:
   In file included from include/linux/icmpv6.h:5:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
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
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
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
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
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
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/xfrm/xfrm_iptfs.c:1371:29: warning: variable 's0seq' set but not used [-Wunused-but-set-variable]
    1371 |         u64 distance, extra_drops, s0seq;
         |                                    ^
   net/xfrm/xfrm_iptfs.c:1903:6: warning: variable 'blkoff' set but not used [-Wunused-but-set-variable]
    1903 |         u32 blkoff = 0;
         |             ^
   net/xfrm/xfrm_iptfs.c:2253:11: warning: variable 'settime' set but not used [-Wunused-but-set-variable]
    2253 |         time64_t settime;
         |                  ^
   10 warnings generated.


vim +/s0seq +1371 net/xfrm/xfrm_iptfs.c

  1360	
  1361	static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
  1362					    struct sk_buff *inskb,
  1363					    struct list_head *list,
  1364					    struct list_head *freelist)
  1365	{
  1366		const u32 nslots = xtfs->cfg.reorder_win_size + 1;
  1367		const u64 inseq = __esp_seq(inskb);
  1368		u32 savedlen = xtfs->w_savedlen;
  1369		u64 wantseq = xtfs->w_wantseq;
  1370		struct sk_buff *slot0 = NULL;
> 1371		u64 distance, extra_drops, s0seq;
  1372		struct skb_wseq *wnext;
  1373		u32 beyond, shifting, slot;
  1374	
  1375		BUG_ON(inseq <= wantseq);
  1376		distance = inseq - wantseq;
  1377		BUG_ON(distance <= nslots - 1);
  1378		beyond = distance - (nslots - 1);
  1379	
  1380		/* Handle future sequence number received.
  1381		 *
  1382		 * IMPORTANT: we are at least advancing w_wantseq (i.e., wantseq) by 1
  1383		 * b/c we are beyond the window boundary.
  1384		 *
  1385		 * We know we don't have the wantseq so that counts as a drop.
  1386		 */
  1387	
  1388		/* ex: slot count is 4, array size is 3 savedlen is 2, slot 0 is the
  1389		 * missing sequence number.
  1390		 *
  1391		 * the final slot at savedlen (index savedlen - 1) is always occupied.
  1392		 *
  1393		 * beyond is "beyond array size" not savedlen.
  1394		 *
  1395		 *          +--------- array length (savedlen == 2)
  1396		 *          |   +----- array size (nslots - 1 == 3)
  1397		 *          |   |   +- window boundary (nslots == 4)
  1398		 *          V   V | V
  1399		 *                |
  1400		 *  0   1   2   3 |   slot number
  1401		 * ---  0   1   2 |   array index
  1402		 *     [b] [c] : :|   array
  1403		 *                |
  1404		 * "2" "3" "4" "5"|*6*  seq numbers
  1405		 *
  1406		 * We receive seq number 6
  1407		 * distance == 4 [inseq(6) - w_wantseq(2)]
  1408		 * newslot == distance
  1409		 * index == 3 [distance(4) - 1]
  1410		 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
  1411		 * shifting == 1 [min(savedlen(2), beyond(1)]
  1412		 * slot0_skb == [b], and should match w_wantseq
  1413		 *
  1414		 *                +--- window boundary (nslots == 4)
  1415		 *  0   1   2   3 | 4   slot number
  1416		 * ---  0   1   2 | 3   array index
  1417		 *     [b] : : : :|     array
  1418		 * "2" "3" "4" "5" *6*  seq numbers
  1419		 *
  1420		 * We receive seq number 6
  1421		 * distance == 4 [inseq(6) - w_wantseq(2)]
  1422		 * newslot == distance
  1423		 * index == 3 [distance(4) - 1]
  1424		 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
  1425		 * shifting == 1 [min(savedlen(1), beyond(1)]
  1426		 * slot0_skb == [b] and should match w_wantseq
  1427		 *
  1428		 *                +-- window boundary (nslots == 4)
  1429		 *  0   1   2   3 | 4   5   6   slot number
  1430		 * ---  0   1   2 | 3   4   5   array index
  1431		 *     [-] [c] : :|             array
  1432		 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
  1433		 *
  1434		 * savedlen = 2, beyond = 3
  1435		 * iter 1: slot0 == NULL, missed++, lastdrop = 2 (2+1-1), slot0 = [-]
  1436		 * iter 2: slot0 == NULL, missed++, lastdrop = 3 (2+2-1), slot0 = [c]
  1437		 * 2 < 3, extra = 1 (3-2), missed += extra, lastdrop = 4 (2+2+1-1)
  1438		 *
  1439		 * We receive seq number 8
  1440		 * distance == 6 [inseq(8) - w_wantseq(2)]
  1441		 * newslot == distance
  1442		 * index == 5 [distance(6) - 1]
  1443		 * beyond == 3 [newslot(6) - lastslot((nslots(4) - 1))]
  1444		 * shifting == 2 [min(savedlen(2), beyond(3)]
  1445		 *
  1446		 * slot0_skb == NULL changed from [b] when "savedlen < beyond" is true.
  1447		 */
  1448	
  1449		/* Now send any packets that are being shifted out of saved, and account
  1450		 * for missing packets that are exiting the window as we shift it.
  1451		 */
  1452	
  1453		/* If savedlen > beyond we are shifting some, else all. */
  1454		shifting = min(savedlen, beyond);
  1455	
  1456		/* slot0 is the buf that just shifted out and into slot0 */
  1457		slot0 = NULL;
  1458		s0seq = wantseq;
  1459		wnext = xtfs->w_saved;
  1460		for (slot = 1; slot <= shifting; slot++, wnext++) {
  1461			/* handle what was in slot0 before we occupy it */
  1462			if (slot0)
  1463				list_add_tail(&slot0->list, list);
  1464			s0seq++;
  1465			slot0 = wnext->skb;
  1466			wnext->skb = NULL;
  1467		}
  1468	
  1469		/* slot0 is now either NULL (in which case it's what we now are waiting
  1470		 * for, or a buf in which case we need to handle it like we received it;
  1471		 * however, we may be advancing past that buffer as well..
  1472		 */
  1473	
  1474		/* Handle case where we need to shift more than we had saved, slot0 will
  1475		 * be NULL iff savedlen is 0, otherwise slot0 will always be
  1476		 * non-NULL b/c we shifted the final element, which is always set if
  1477		 * there is any saved, into slot0.
  1478		 */
  1479		if (savedlen < beyond) {
  1480			extra_drops = beyond - savedlen;
  1481			if (savedlen == 0) {
  1482				BUG_ON(slot0);
  1483				s0seq += extra_drops;
  1484			} else {
  1485				extra_drops--; /* we aren't dropping what's in slot0 */
  1486				BUG_ON(!slot0);
  1487				list_add_tail(&slot0->list, list);
  1488				s0seq += extra_drops + 1;
  1489			}
  1490			slot0 = NULL;
  1491			/* slot0 has had an empty slot pushed into it */
  1492		}
  1493	
  1494		/* Remove the entries */
  1495		__vec_shift(xtfs, beyond);
  1496	
  1497		/* Advance want seq */
  1498		xtfs->w_wantseq += beyond;
  1499	
  1500		/* Process drops here when implementing congestion control */
  1501	
  1502		/* We've shifted. plug the packet in at the end. */
  1503		xtfs->w_savedlen = nslots - 1;
  1504		xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
  1505		iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
  1506	
  1507		/* if we don't have a slot0 then we must wait for it */
  1508		if (!slot0)
  1509			return;
  1510	
  1511		/* If slot0, seq must match new want seq */
  1512		BUG_ON(xtfs->w_wantseq != __esp_seq(slot0));
  1513	
  1514		/* slot0 is valid, treat like we received expected. */
  1515		__reorder_this(xtfs, slot0, list);
  1516	}
  1517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

