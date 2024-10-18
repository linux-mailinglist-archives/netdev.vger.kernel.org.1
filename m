Return-Path: <netdev+bounces-136994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6BC9A3E3B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8E31C2029D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD21CD2B;
	Fri, 18 Oct 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYCgZZn1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D174748A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254160; cv=none; b=poWrQQk+YRNmiIE4f1JC6454Y0T/1+n6RsdWefKCZsfdTC+IUq07VUr0GbleLtBkUwA7CLMhQZXUqbYwNP3mrHbRupiBgqkQyH4tQV0H1VEWnFz/LapWZvq7lFGhNr/sFZpWHkuA19hltMNxPoTHuYfpGb6Iq+yooCCq2CymGpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254160; c=relaxed/simple;
	bh=q4VX7mn4Dlalu2bQAI0bGEcxjzY9NPfADAIeCyUURYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2bGrLrs0FxSllmDXV5e8jD/OYMxjK2K1NuhUpTE7h5v+zR4JRfps7Xbs2vHBCvL14v/KYHSQe9JrGDjMR7aWrPaJTM6JRlhGaRhaAFwtH+cIGnROPykbFwXqqWcdKLHkAG/TdjjIB4HIiiYVo88QrtJx238EjMA7d7zs1aopOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYCgZZn1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729254158; x=1760790158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q4VX7mn4Dlalu2bQAI0bGEcxjzY9NPfADAIeCyUURYI=;
  b=ZYCgZZn1TMAbYSrmmucUWWBg7/Bxwsu5o+q4OZMuNh+q93kXB0Cu/IyU
   1f0kNYyn83CpyeLvDgNm+B159Pl5XmhLvTrZGhrCQAl4ONUmvsush5VFx
   qKkc/qYzH7zAzqYsIlpOWICTgn1CUPjsQ9ftgcR9GQRol0KYauXa+qbqx
   SP+9EGV67EL/x2fcm1Mj5APgxe9jJMIpnuYnIUgE9NewU40i/k/2dinCI
   oqgVGcqhkJUsbmNF1YrPaZ2BxwEZ5Fnpb0GZNoMBXrfP2JMy9pJt1DBc2
   VC5e1RTxb1In2ZdqPwOJoWpkGDRl8H8zz99xYF9osTTup+GXvGiQ2eYs/
   w==;
X-CSE-ConnectionGUID: YbtZCQEYSXiY+V5N4gvHsQ==
X-CSE-MsgGUID: /HqluZ0qQ/CU3Of9dP2psg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="32578226"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="32578226"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 05:22:38 -0700
X-CSE-ConnectionGUID: UViPG7I2TA+Rnain72XKTg==
X-CSE-MsgGUID: b7fe+BULS7WNNmTWXYXGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="102166134"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Oct 2024 05:22:35 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1m01-000NnN-1U;
	Fri, 18 Oct 2024 12:22:33 +0000
Date: Fri, 18 Oct 2024 20:21:56 +0800
From: kernel test robot <lkp@intel.com>
To: Vadim Fedorenko <vadfed@meta.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
Message-ID: <202410182038.mpo0UaRH-lkp@intel.com>
References: <20241014232947.4059941-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014232947.4059941-1-vadfed@meta.com>

Hi Vadim,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vadim-Fedorenko/bnxt_en-replace-PTP-spinlock-with-seqlock/20241015-073207
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241014232947.4059941-1-vadfed%40meta.com
patch subject: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241018/202410182038.mpo0UaRH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410182038.mpo0UaRH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410182038.mpo0UaRH-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_force_fw_reset':
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:13488:30: warning: unused variable 'ptp' [-Wunused-variable]
   13488 |         struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
         |                              ^~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_fw_reset':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:13555:38: warning: unused variable 'ptp' [-Wunused-variable]
   13555 |                 struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
         |                                      ^~~
--
   In file included from drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:21:
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: In function 'bnxt_get_rx_ts_p5':
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h:155:52: error: expected ')' before ';' token
     155 |         while (read_seqretry(&(ptp)->ptp_lock, seq);    \
         |               ~                                    ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:802:9: note: in expansion of macro 'BNXT_READ_TIME64'
     802 |         BNXT_READ_TIME64(ptp, time, ptp->old_time);
         |         ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h:156:1: error: expected expression before '}' token
     156 | } while (0)
         | ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:802:9: note: in expansion of macro 'BNXT_READ_TIME64'
     802 |         BNXT_READ_TIME64(ptp, time, ptp->old_time);
         |         ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:810:1: error: expected 'while' before 'void'
     810 | void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
         | ^~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:857:12: error: invalid storage class for function 'bnxt_ptp_verify'
     857 | static int bnxt_ptp_verify(struct ptp_clock_info *ptp_info, unsigned int pin,
         |            ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:870:12: error: invalid storage class for function 'bnxt_ptp_pps_init'
     870 | static int bnxt_ptp_pps_init(struct bnxt *bp)
         |            ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:931:13: error: invalid storage class for function 'bnxt_pps_config_ok'
     931 | static bool bnxt_pps_config_ok(struct bnxt *bp)
         |             ^~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:938:13: error: invalid storage class for function 'bnxt_ptp_timecounter_init'
     938 | static void bnxt_ptp_timecounter_init(struct bnxt *bp, bool init_tc)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:998:13: error: invalid storage class for function 'bnxt_ptp_free'
     998 | static void bnxt_ptp_free(struct bnxt *bp)
         |             ^~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1100:1: error: expected declaration or statement at end of input
    1100 | }
         | ^
   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c: At top level:
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1077:6: warning: 'bnxt_ptp_clear' defined but not used [-Wunused-function]
    1077 | void bnxt_ptp_clear(struct bnxt *bp)
         |      ^~~~~~~~~~~~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1010:5: warning: 'bnxt_ptp_init' defined but not used [-Wunused-function]
    1010 | int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
         |     ^~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +155 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h

   147	
   148	#if BITS_PER_LONG == 32
   149	#define BNXT_READ_TIME64(ptp, dst, src)			\
   150	do {							\
   151		unsigned int seq;				\
   152		do {						\
   153			seq = read_seqbegin(&(ptp)->ptp_lock);	\
   154			(dst) = (src);				\
 > 155		while (read_seqretry(&(ptp)->ptp_lock, seq);	\
 > 156	} while (0)
   157	#else
   158	#define BNXT_READ_TIME64(ptp, dst, src)		\
   159		((dst) = READ_ONCE(src))
   160	#endif
   161	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

