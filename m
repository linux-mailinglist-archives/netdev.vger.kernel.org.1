Return-Path: <netdev+bounces-193536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90877AC45DD
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 03:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352231897CA9
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130484D13;
	Tue, 27 May 2025 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDlVTPWS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603432CA9
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 01:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748308992; cv=none; b=ZLmjrQJ+ZVbngtvEEhYXhuQWIOEyNE96JzR6HdBU1AdTt6UNWhnClPo6GJfHtKUbc5IshUnA9lOFMkVJkL/HuuoRqp2qHszQs31ej4WZ1bhT7HEDjKzt3ATMMpQk4Tumv4Abm2J9dp6qgRhKHKON7hEx5SaveQl7qD16aOc90rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748308992; c=relaxed/simple;
	bh=V6+53TGRbaY13qQpLbT62lVQ1KrJgP5UhOGbZ87q4vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkUarocSnGbzzeyySd5m/iuFs9VrokVrzLcnyKzAAa9ZBMijIhbzIhFD5S+rIQMti+oMFOQPD829j3WN4TLQJGlQR8c9RxKcRnMzXAr0jYLCr/qUGo95T8tuxpCbdWGCKneG/SJgFyp83YNm0tvWD7K3NO0q3hweWVNGOagIJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDlVTPWS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748308991; x=1779844991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6+53TGRbaY13qQpLbT62lVQ1KrJgP5UhOGbZ87q4vU=;
  b=dDlVTPWSaYvA/MMJRwqvvUAhTCIRXCSj1DhwhDuG/WO0T0Qiiuqk177D
   8BgYBOq5LufaPQiQ3tl39EBYzNV4q8NnhbB85tT+YsNeNnCKHZXa7IZFN
   0tlMk7quVzIImiFMixdw84hlIefJ3gSFDN/3jQ+OtK2x+XNv0jlb97TgD
   DCKgCN8ai/sRbc5ZaV7GquRrk/P7lDRskLU9KAjUM3UQDMTPcQKzhOoq1
   u+s5asyAZgpZ1knSBMRhYVkx9FgGibRc/SyBTpirVMRytcgnncJPyx8yy
   q4YH5mDFbVJAN9NDKUBoTtKWy2HOST7JkLY2Zlb4nPOulmizUevCFlTjo
   g==;
X-CSE-ConnectionGUID: S5wW99UvSX+1FHD5MSGliw==
X-CSE-MsgGUID: IMcwSgECSHOfBO/C50ibbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50332955"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="50332955"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 18:23:10 -0700
X-CSE-ConnectionGUID: HaVu3naQQpSISTceqEZbKQ==
X-CSE-MsgGUID: dWvFHSgvTnqILb6eJEZmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="143546099"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 26 May 2025 18:23:06 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJj1z-000Sn2-1P;
	Tue, 27 May 2025 01:23:03 +0000
Date: Tue, 27 May 2025 09:22:14 +0800
From: kernel test robot <lkp@intel.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saikrishnag@marvell.com,
	gakula@marvell.com, hkelam@marvell.com, sgoutham@marvell.com,
	lcherian@marvell.com, bbhushan2@marvell.com, jerinj@marvell.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Subbaraya Sundeep <sbhatta@marvell.com>
Subject: Re: [net PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
Message-ID: <202505270941.xkydqqTv-lkp@intel.com>
References: <1748274232-20835-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748274232-20835-1-git-send-email-sbhatta@marvell.com>

Hi Subbaraya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Subbaraya-Sundeep/octeontx2-pf-Avoid-typecasts-by-simplifying-otx2_atomic64_add-macro/20250526-234505
base:   net/main
patch link:    https://lore.kernel.org/r/1748274232-20835-1-git-send-email-sbhatta%40marvell.com
patch subject: [net PATCH] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
config: x86_64-buildonly-randconfig-006-20250527 (https://download.01.org/0day-ci/archive/20250527/202505270941.xkydqqTv-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250527/202505270941.xkydqqTv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505270941.xkydqqTv-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c:10:
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c:451:14: warning: shift count >= width of type [-Wshift-count-overflow]
     451 |                 cc->mask = CYCLECOUNTER_MASK(64);
         |                            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/timecounter.h:14:59: note: expanded from macro 'CYCLECOUNTER_MASK'
      14 | #define CYCLECOUNTER_MASK(bits) (u64)((bits) < 64 ? ((1ULL<<(bits))-1) : -1)
         |                                                           ^ ~~~~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c:13:
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   1 warning and 1 error generated.
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:17:
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:34:17: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
      34 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:34:17: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
      34 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:37:16: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
      37 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:37:16: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
      37 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:47:17: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
      47 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:47:17: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
      47 |         stats->bytes = otx2_atomic64_add(incr, ptr);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:50:16: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
      50 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:50:16: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
      50 |         stats->pkts = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:873:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     873 |                 val = otx2_atomic64_add(incr, ptr);
         |                       ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c:873:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     873 |                 val = otx2_atomic64_add(incr, ptr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   6 warnings and 6 errors generated.
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c:11:
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h:11:
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c:159:8: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     159 |         val = otx2_atomic64_add(incr, ptr);
         |               ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c:159:8: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     159 |         val = otx2_atomic64_add(incr, ptr);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   2 warnings and 2 errors generated.
--
   In file included from drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:22:
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^                       ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:804:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
     804 |         return otx2_atomic64_add(incr, ptr);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1314:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
    1314 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^                               ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1314:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
    1314 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1353:9: warning: ISO C does not allow indirection on operand of type 'void *' [-Wvoid-ptr-dereference]
    1353 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^                               ~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:42: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ^~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:1353:9: error: invalid operands to binary expression ('void' and 'u64' (aka 'unsigned long long'))
    1353 |                 val = otx2_atomic64_add((qidx << 44), ptr);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h:751:47: note: expanded from macro 'otx2_atomic64_add'
     751 | #define otx2_atomic64_add(incr, ptr)            ({ *ptr += incr; })
         |                                                    ~~~~ ^  ~~~~
   3 warnings and 3 errors generated.


vim +804 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h

4c236d5dc8b8622 Geetha sowjanya   2021-02-11  797  
caa2da34fd25a37 Sunil Goutham     2020-01-27  798  /* Alloc pointer from pool/aura */
caa2da34fd25a37 Sunil Goutham     2020-01-27  799  static inline u64 otx2_aura_allocptr(struct otx2_nic *pfvf, int aura)
caa2da34fd25a37 Sunil Goutham     2020-01-27  800  {
22f5790bc6ba331 Subbaraya Sundeep 2025-05-26  801  	void __iomem *ptr = otx2_get_regaddr(pfvf, NPA_LF_AURA_OP_ALLOCX(0));
caa2da34fd25a37 Sunil Goutham     2020-01-27  802  	u64 incr = (u64)aura | BIT_ULL(63);
caa2da34fd25a37 Sunil Goutham     2020-01-27  803  
caa2da34fd25a37 Sunil Goutham     2020-01-27 @804  	return otx2_atomic64_add(incr, ptr);
caa2da34fd25a37 Sunil Goutham     2020-01-27  805  }
caa2da34fd25a37 Sunil Goutham     2020-01-27  806  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

