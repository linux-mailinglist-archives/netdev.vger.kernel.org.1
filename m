Return-Path: <netdev+bounces-136149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642899A08DC
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 13:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756271C23A18
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0312076A8;
	Wed, 16 Oct 2024 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2Sqb0b4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2356206971
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079717; cv=none; b=FOTxNjCxLpxXoP4W6WuNgeWF9O0StFo45JhwvoYQybjthJaSNsrFv3zb9/QneaziR9FuJmB8QYFBIYBzylhDIVV7Qe4tFpXf7tIS3v7lse7xdR/RqphrMdR8QEBug9oOUw4KVLIAfBw75tS+jKayzd1fSH3ifoRYExvcy7/4Ugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079717; c=relaxed/simple;
	bh=o7YO58RNpvfnQHJ3ozrIWkOlQxmvd503Se20J7MJq6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok1Ois/pK9d0je3nKS/IR1yYxoCLBvbIf92W3WfmQfNNSHZpmOE+FE5rOFQkJCNEoWwmkZAl5q6mQ/c7SkvsKuk2X/+NJza1HEbkWLIR2oQhYUJ5zbseouDd0j11sTe5YWZx0wqZSv3vXN9sxLcvzqc9Rg7LOaFlwwfjE60zkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2Sqb0b4; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729079714; x=1760615714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o7YO58RNpvfnQHJ3ozrIWkOlQxmvd503Se20J7MJq6s=;
  b=X2Sqb0b47+mN4E1aS2/gArAJbgAI1Y/4iZ3rwIZh2K4flyKkWANhNcZ/
   +vlwzGee0IFPXZ3AhNfn/H8iGA/CqUZGoNqM/OnpnT/xyZgaUrL30JuYK
   pDFtEw3gzVfjIfBBSvjDPnDp2nazqD935Y9crCueaMu1a0O/MDOcFaPGR
   Ep/xEAbcHRolxW/YOISulTgmITLnzeWSk64TcZS+eUzw5clXaSwNRQNW8
   ZEnrKzoh9bP5PWCBcvxI4rc4c6gjGasp8NSNBeE3+8yjo0aJyih6I2dt9
   7qVqxspB/emStkW9CIeJ8/bkVFd8mulKrDGpDMTrZzaaB5r5nFFydCbuv
   w==;
X-CSE-ConnectionGUID: X+CddebkS++UPeShoV3MGQ==
X-CSE-MsgGUID: Cu+3AMP4R9Ghy4SQjP4nxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="53936583"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="53936583"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:55:13 -0700
X-CSE-ConnectionGUID: /wFpulPVTRCYTLPdhADYSw==
X-CSE-MsgGUID: Kl3Kqs7jSK+0ZBbfJKxBCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82167923"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Oct 2024 04:55:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t12cO-000Krv-02;
	Wed, 16 Oct 2024 11:55:08 +0000
Date: Wed, 16 Oct 2024 19:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net] bnxt_en: replace ptp_lock with irqsave variant
Message-ID: <202410161945.GNueTqcE-lkp@intel.com>
References: <20241015185310.608328-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015185310.608328-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bnxt_en-replace-ptp_lock-with-irqsave-variant/20241016-025931
base:   net/main
patch link:    https://lore.kernel.org/r/20241015185310.608328-1-vadfed%40meta.com
patch subject: [PATCH net] bnxt_en: replace ptp_lock with irqsave variant
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241016/202410161945.GNueTqcE-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161945.GNueTqcE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161945.GNueTqcE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:2259:5: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
    2259 |                                 spin_lock_irqsave(&ptp->ptp_lock, flags);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:2767:5: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
    2767 |                                 spin_lock_irqsave(&ptp->ptp_lock, flags);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:13501:3: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
    13501 |                 spin_lock_irqsave(&ptp->ptp_lock, flags);
          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:13570:4: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
    13570 |                         spin_lock_irqsave(&ptp->ptp_lock, flags);
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   4 warnings generated.
--
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:70:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
      70 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:108:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     108 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:158:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     158 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:197:3: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     197 |                 spin_lock_irqsave(&ptp->ptp_lock, flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:214:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     214 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:249:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     249 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:264:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     264 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:406:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     406 |         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:714:3: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     714 |                 spin_lock_irqsave(&ptp->ptp_lock, flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:770:3: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     770 |                 spin_lock_irqsave(&ptp->ptp_lock, flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:847:4: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
     847 |                         spin_lock_irqsave(&ptp->ptp_lock, flags);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock_rt.h:99:3: note: expanded from macro 'spin_lock_irqsave'
      99 |                 typecheck(unsigned long, flags);         \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1008:2: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (flags) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
    1008 |         spin_lock_irqsave(&bp->ptp_cfg->ptp_lock, flags);


vim +2259 drivers/net/ethernet/broadcom/bnxt/bnxt.c

  2010	
  2011	/* returns the following:
  2012	 * 1       - 1 packet successfully received
  2013	 * 0       - successful TPA_START, packet not completed yet
  2014	 * -EBUSY  - completion ring does not have all the agg buffers yet
  2015	 * -ENOMEM - packet aborted due to out of memory
  2016	 * -EIO    - packet aborted due to hw error indicated in BD
  2017	 */
  2018	static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
  2019			       u32 *raw_cons, u8 *event)
  2020	{
  2021		struct bnxt_napi *bnapi = cpr->bnapi;
  2022		struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
  2023		struct net_device *dev = bp->dev;
  2024		struct rx_cmp *rxcmp;
  2025		struct rx_cmp_ext *rxcmp1;
  2026		u32 tmp_raw_cons = *raw_cons;
  2027		u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
  2028		struct bnxt_sw_rx_bd *rx_buf;
  2029		unsigned int len;
  2030		u8 *data_ptr, agg_bufs, cmp_type;
  2031		bool xdp_active = false;
  2032		dma_addr_t dma_addr;
  2033		struct sk_buff *skb;
  2034		struct xdp_buff xdp;
  2035		u32 flags, misc;
  2036		u32 cmpl_ts;
  2037		void *data;
  2038		int rc = 0;
  2039	
  2040		rxcmp = (struct rx_cmp *)
  2041				&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
  2042	
  2043		cmp_type = RX_CMP_TYPE(rxcmp);
  2044	
  2045		if (cmp_type == CMP_TYPE_RX_TPA_AGG_CMP) {
  2046			bnxt_tpa_agg(bp, rxr, (struct rx_agg_cmp *)rxcmp);
  2047			goto next_rx_no_prod_no_len;
  2048		}
  2049	
  2050		tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
  2051		cp_cons = RING_CMP(tmp_raw_cons);
  2052		rxcmp1 = (struct rx_cmp_ext *)
  2053				&cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
  2054	
  2055		if (!RX_CMP_VALID(rxcmp1, tmp_raw_cons))
  2056			return -EBUSY;
  2057	
  2058		/* The valid test of the entry must be done first before
  2059		 * reading any further.
  2060		 */
  2061		dma_rmb();
  2062		prod = rxr->rx_prod;
  2063	
  2064		if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP ||
  2065		    cmp_type == CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
  2066			bnxt_tpa_start(bp, rxr, cmp_type,
  2067				       (struct rx_tpa_start_cmp *)rxcmp,
  2068				       (struct rx_tpa_start_cmp_ext *)rxcmp1);
  2069	
  2070			*event |= BNXT_RX_EVENT;
  2071			goto next_rx_no_prod_no_len;
  2072	
  2073		} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
  2074			skb = bnxt_tpa_end(bp, cpr, &tmp_raw_cons,
  2075					   (struct rx_tpa_end_cmp *)rxcmp,
  2076					   (struct rx_tpa_end_cmp_ext *)rxcmp1, event);
  2077	
  2078			if (IS_ERR(skb))
  2079				return -EBUSY;
  2080	
  2081			rc = -ENOMEM;
  2082			if (likely(skb)) {
  2083				bnxt_deliver_skb(bp, bnapi, skb);
  2084				rc = 1;
  2085			}
  2086			*event |= BNXT_RX_EVENT;
  2087			goto next_rx_no_prod_no_len;
  2088		}
  2089	
  2090		cons = rxcmp->rx_cmp_opaque;
  2091		if (unlikely(cons != rxr->rx_next_cons)) {
  2092			int rc1 = bnxt_discard_rx(bp, cpr, &tmp_raw_cons, rxcmp);
  2093	
  2094			/* 0xffff is forced error, don't print it */
  2095			if (rxr->rx_next_cons != 0xffff)
  2096				netdev_warn(bp->dev, "RX cons %x != expected cons %x\n",
  2097					    cons, rxr->rx_next_cons);
  2098			bnxt_sched_reset_rxr(bp, rxr);
  2099			if (rc1)
  2100				return rc1;
  2101			goto next_rx_no_prod_no_len;
  2102		}
  2103		rx_buf = &rxr->rx_buf_ring[cons];
  2104		data = rx_buf->data;
  2105		data_ptr = rx_buf->data_ptr;
  2106		prefetch(data_ptr);
  2107	
  2108		misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
  2109		agg_bufs = (misc & RX_CMP_AGG_BUFS) >> RX_CMP_AGG_BUFS_SHIFT;
  2110	
  2111		if (agg_bufs) {
  2112			if (!bnxt_agg_bufs_valid(bp, cpr, agg_bufs, &tmp_raw_cons))
  2113				return -EBUSY;
  2114	
  2115			cp_cons = NEXT_CMP(cp_cons);
  2116			*event |= BNXT_AGG_EVENT;
  2117		}
  2118		*event |= BNXT_RX_EVENT;
  2119	
  2120		rx_buf->data = NULL;
  2121		if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
  2122			u32 rx_err = le32_to_cpu(rxcmp1->rx_cmp_cfa_code_errors_v2);
  2123	
  2124			bnxt_reuse_rx_data(rxr, cons, data);
  2125			if (agg_bufs)
  2126				bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0, agg_bufs,
  2127						       false);
  2128	
  2129			rc = -EIO;
  2130			if (rx_err & RX_CMPL_ERRORS_BUFFER_ERROR_MASK) {
  2131				bnapi->cp_ring.sw_stats->rx.rx_buf_errors++;
  2132				if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
  2133				    !(bp->fw_cap & BNXT_FW_CAP_RING_MONITOR)) {
  2134					netdev_warn_once(bp->dev, "RX buffer error %x\n",
  2135							 rx_err);
  2136					bnxt_sched_reset_rxr(bp, rxr);
  2137				}
  2138			}
  2139			goto next_rx_no_len;
  2140		}
  2141	
  2142		flags = le32_to_cpu(rxcmp->rx_cmp_len_flags_type);
  2143		len = flags >> RX_CMP_LEN_SHIFT;
  2144		dma_addr = rx_buf->mapping;
  2145	
  2146		if (bnxt_xdp_attached(bp, rxr)) {
  2147			bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
  2148			if (agg_bufs) {
  2149				u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
  2150								     cp_cons, agg_bufs,
  2151								     false);
  2152				if (!frag_len)
  2153					goto oom_next_rx;
  2154			}
  2155			xdp_active = true;
  2156		}
  2157	
  2158		if (xdp_active) {
  2159			if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
  2160				rc = 1;
  2161				goto next_rx;
  2162			}
  2163		}
  2164	
  2165		if (len <= bp->rx_copy_thresh) {
  2166			if (!xdp_active)
  2167				skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
  2168			else
  2169				skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
  2170			bnxt_reuse_rx_data(rxr, cons, data);
  2171			if (!skb) {
  2172				if (agg_bufs) {
  2173					if (!xdp_active)
  2174						bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
  2175								       agg_bufs, false);
  2176					else
  2177						bnxt_xdp_buff_frags_free(rxr, &xdp);
  2178				}
  2179				goto oom_next_rx;
  2180			}
  2181		} else {
  2182			u32 payload;
  2183	
  2184			if (rx_buf->data_ptr == data_ptr)
  2185				payload = misc & RX_CMP_PAYLOAD_OFFSET;
  2186			else
  2187				payload = 0;
  2188			skb = bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
  2189					      payload | len);
  2190			if (!skb)
  2191				goto oom_next_rx;
  2192		}
  2193	
  2194		if (agg_bufs) {
  2195			if (!xdp_active) {
  2196				skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
  2197				if (!skb)
  2198					goto oom_next_rx;
  2199			} else {
  2200				skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
  2201				if (!skb) {
  2202					/* we should be able to free the old skb here */
  2203					bnxt_xdp_buff_frags_free(rxr, &xdp);
  2204					goto oom_next_rx;
  2205				}
  2206			}
  2207		}
  2208	
  2209		if (RX_CMP_HASH_VALID(rxcmp)) {
  2210			enum pkt_hash_types type;
  2211	
  2212			if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
  2213				type = bnxt_rss_ext_op(bp, rxcmp);
  2214			} else {
  2215				u32 hash_type = RX_CMP_HASH_TYPE(rxcmp);
  2216	
  2217				/* RSS profiles 1 and 3 with extract code 0 for inner
  2218				 * 4-tuple
  2219				 */
  2220				if (hash_type != 1 && hash_type != 3)
  2221					type = PKT_HASH_TYPE_L3;
  2222				else
  2223					type = PKT_HASH_TYPE_L4;
  2224			}
  2225			skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
  2226		}
  2227	
  2228		if (cmp_type == CMP_TYPE_RX_L2_CMP)
  2229			dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
  2230		skb->protocol = eth_type_trans(skb, dev);
  2231	
  2232		if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
  2233			skb = bnxt_rx_vlan(skb, cmp_type, rxcmp, rxcmp1);
  2234			if (!skb)
  2235				goto next_rx;
  2236		}
  2237	
  2238		skb_checksum_none_assert(skb);
  2239		if (RX_CMP_L4_CS_OK(rxcmp1)) {
  2240			if (dev->features & NETIF_F_RXCSUM) {
  2241				skb->ip_summed = CHECKSUM_UNNECESSARY;
  2242				skb->csum_level = RX_CMP_ENCAP(rxcmp1);
  2243			}
  2244		} else {
  2245			if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L4_CS_ERR_BITS) {
  2246				if (dev->features & NETIF_F_RXCSUM)
  2247					bnapi->cp_ring.sw_stats->rx.rx_l4_csum_errors++;
  2248			}
  2249		}
  2250	
  2251		if (bnxt_rx_ts_valid(bp, flags, rxcmp1, &cmpl_ts)) {
  2252			if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
  2253				u64 ns, ts;
  2254	
  2255				if (!bnxt_get_rx_ts_p5(bp, &ts, cmpl_ts)) {
  2256					struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
  2257					unsigned int flags;
  2258	
> 2259					spin_lock_irqsave(&ptp->ptp_lock, flags);
  2260					ns = timecounter_cyc2time(&ptp->tc, ts);
  2261					spin_unlock_irqrestore(&ptp->ptp_lock, flags);
  2262					memset(skb_hwtstamps(skb), 0,
  2263					       sizeof(*skb_hwtstamps(skb)));
  2264					skb_hwtstamps(skb)->hwtstamp = ns_to_ktime(ns);
  2265				}
  2266			}
  2267		}
  2268		bnxt_deliver_skb(bp, bnapi, skb);
  2269		rc = 1;
  2270	
  2271	next_rx:
  2272		cpr->rx_packets += 1;
  2273		cpr->rx_bytes += len;
  2274	
  2275	next_rx_no_len:
  2276		rxr->rx_prod = NEXT_RX(prod);
  2277		rxr->rx_next_cons = RING_RX(bp, NEXT_RX(cons));
  2278	
  2279	next_rx_no_prod_no_len:
  2280		*raw_cons = tmp_raw_cons;
  2281	
  2282		return rc;
  2283	
  2284	oom_next_rx:
  2285		cpr->sw_stats->rx.rx_oom_discards += 1;
  2286		rc = -ENOMEM;
  2287		goto next_rx;
  2288	}
  2289	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

