Return-Path: <netdev+bounces-250921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F1D399E8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5D9D30081A6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 21:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD4265623;
	Sun, 18 Jan 2026 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/D3C/eI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F675CDF1;
	Sun, 18 Jan 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768770327; cv=none; b=A8hQqciBCuWWhMnPqQ+YaJnH2mkeCjAl+6AtzyYzp6akJ09vkl56MQVHvWwn5w0HeRnACXJV3FZNqwWz/0yL0E2srMflnJtHSD1mqzHK3sccIq7QY9tL8cv8ZS8hC9kve/aq9gJ+SQSWKfsLVhAAkHdU1AaPjaqBJSJwxzURTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768770327; c=relaxed/simple;
	bh=OE1AoHB1Y79/Fx3YUFsM512vLtvo5xjas7jk/6O9aqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoKeBaE12VDdulBoTdyxdrHQQQcPqiMlt/ZGIcBZAsQto4R1/sP6GA4A3Ga8BnuaMWrQo1eWrMZHw6iGcB32tnizCyDOp/BQXUUFUHW0qxg44EfP3ylwCgAJkdhsu5IXNb1l9NCskF4X9z2F0ZAtMVqIooawJwKIz/NtLF4oTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/D3C/eI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768770325; x=1800306325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OE1AoHB1Y79/Fx3YUFsM512vLtvo5xjas7jk/6O9aqg=;
  b=J/D3C/eIIUoU7YmB+saWgGw2v1JZM0W1X9ig+aUDgdCPRS4Eeme4fFX7
   5/iQfDC+a6r24uWMKKzOFMYWkB47HNiX/VtC3u4SnqcWkgDHvFVY24Nuo
   1dNz/e0M4jsBKyf9UIqCW5tI9wsqATSj7ij7w4VENV9ISjdGZ2efvtDPC
   PAfB4uH3RYQe75yR2LmIOVwH4W3tWnHOhXvwjZzERF3ykK7o9MR5VpwDZ
   NSExGCECwnZPaTBbOaocH/pxeLGKKLoZdPR22RXiLZhbgsH3NVjeAAokz
   tHb2qrA9YQrfe4VioBfYVwdBW5lJ9XMmDcGyrAD0ueDqSHPrz8qIKC08c
   A==;
X-CSE-ConnectionGUID: R/6dx1zTSvu334kjGjpzdQ==
X-CSE-MsgGUID: W6cPZGK7RCunw/LQKrGKZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="73620380"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="73620380"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 13:05:24 -0800
X-CSE-ConnectionGUID: ma6M8gC5TueFYLQs1mg2Rw==
X-CSE-MsgGUID: 2d+5Z5+6QeuDEfRp4e4DxQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jan 2026 13:05:22 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhZxX-00000000NDp-3IGw;
	Sun, 18 Jan 2026 21:05:19 +0000
Date: Mon, 19 Jan 2026 05:04:27 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Pitre <npitre@baylibre.com>
Subject: Re: [PATCH] compiler_types: Introduce inline_for_performance
Message-ID: <202601190420.RlBoZSGm-lkp@intel.com>
References: <20260118152448.2560414-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118152448.2560414-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e84d960149e71e8d5e4db69775ce31305898ed0c]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/compiler_types-Introduce-inline_for_performance/20260118-232653
base:   e84d960149e71e8d5e4db69775ce31305898ed0c
patch link:    https://lore.kernel.org/r/20260118152448.2560414-1-edumazet%40google.com
patch subject: [PATCH] compiler_types: Introduce inline_for_performance
config: arm-randconfig-004-20260119 (https://download.01.org/0day-ci/archive/20260119/202601190420.RlBoZSGm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190420.RlBoZSGm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601190420.RlBoZSGm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/math.h:6,
                    from include/linux/kernel.h:27,
                    from include/linux/random.h:7,
                    from include/linux/nodemask.h:94,
                    from include/linux/numa.h:6,
                    from include/linux/cpumask.h:15,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from lib/dec_and_lock.c:3:
>> arch/arm/include/asm/div64.h:56:10: warning: '__arch_xprod_64' defined but not used [-Wunused-function]
      56 | uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
         |          ^~~~~~~~~~~~~~~


vim +/__arch_xprod_64 +56 arch/arm/include/asm/div64.h

fa4adc614922c2 include/asm-arm/div64.h      Nicolas Pitre 2006-12-06   54  
5f712d70e20a46 arch/arm/include/asm/div64.h Eric Dumazet  2026-01-18   55  static inline_for_performance
d533cb2d2af400 arch/arm/include/asm/div64.h Nicolas Pitre 2024-10-03  @56  uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   57  {
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   58  	unsigned long long res;
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   59  	register unsigned int tmp asm("ip") = 0;
06508533d51a1d arch/arm/include/asm/div64.h Nicolas Pitre 2024-10-03   60  	bool no_ovf = __builtin_constant_p(m) &&
06508533d51a1d arch/arm/include/asm/div64.h Nicolas Pitre 2024-10-03   61  		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   62  
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   63  	if (!bias) {
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   64  		asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   65  			"mov	%Q0, #0"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   66  			: "=&r" (res)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   67  			: "r" (m), "r" (n)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   68  			: "cc");
06508533d51a1d arch/arm/include/asm/div64.h Nicolas Pitre 2024-10-03   69  	} else if (no_ovf) {
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   70  		res = m;
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   71  		asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   72  			"mov	%Q0, #0"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   73  			: "+&r" (res)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   74  			: "r" (m), "r" (n)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   75  			: "cc");
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   76  	} else {
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   77  		asm (	"umull	%Q0, %R0, %Q2, %Q3\n\t"
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   78  			"cmn	%Q0, %Q2\n\t"
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   79  			"adcs	%R0, %R0, %R2\n\t"
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   80  			"adc	%Q0, %1, #0"
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   81  			: "=&r" (res), "+&r" (tmp)
73e592f3bc2cdc arch/arm/include/asm/div64.h Nicolas Pitre 2016-01-27   82  			: "r" (m), "r" (n)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   83  			: "cc");
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   84  	}
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   85  
06508533d51a1d arch/arm/include/asm/div64.h Nicolas Pitre 2024-10-03   86  	if (no_ovf) {
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   87  		asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   88  			"umlal	%R0, %Q0, %Q1, %R2\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   89  			"mov	%R0, #0\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   90  			"umlal	%Q0, %R0, %R1, %R2"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   91  			: "+&r" (res)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   92  			: "r" (m), "r" (n)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   93  			: "cc");
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   94  	} else {
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   95  		asm (	"umlal	%R0, %Q0, %R2, %Q3\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   96  			"umlal	%R0, %1, %Q2, %R3\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   97  			"mov	%R0, #0\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   98  			"adds	%Q0, %1, %Q0\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02   99  			"adc	%R0, %R0, #0\n\t"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  100  			"umlal	%Q0, %R0, %R2, %R3"
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  101  			: "+&r" (res), "+&r" (tmp)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  102  			: "r" (m), "r" (n)
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  103  			: "cc");
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  104  	}
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  105  
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  106  	return res;
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  107  }
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  108  #define __arch_xprod_64 __arch_xprod_64
040b323b5012b5 arch/arm/include/asm/div64.h Nicolas Pitre 2015-11-02  109  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

