Return-Path: <netdev+bounces-130696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B398B2E8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 06:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF10B22923
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913661B3B30;
	Tue,  1 Oct 2024 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+0SPQjf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7001B3B2C
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756337; cv=none; b=Z/S4I6JNJceF4m+oLf8RUepPzlUJT9VDO7+ODxWWZwa3fwh33oXSACnsd5XoR2mins/yzwScZXL7jNutMPFKljVFXENiPEj8HOkARfQ1p4wcpZBmWW87YBP+njTpW8DYea/mPRQQuxR6ytPPtbPrb6ZUkIq60UKMndQRiPPUY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756337; c=relaxed/simple;
	bh=0b07S+vLXbusNjh+XL++Cg74xkkU7vzbIsgpE5rpVeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiDxXeKUcAOR7iLLrsPTv4IZaxiwHc5V88jZdxRbszWv/UQvZ7T8KH+g9wDaJiL84fgBqoKyS5XTln1UKcfaYIq0BQlCywiRWCR6qIS/I6UN1Z5KxiN8fQqD8XffMSsihEOreYIIhtDtrxmUp1ccWfmoHA/vJ2ZvMfCSRt520/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+0SPQjf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727756336; x=1759292336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0b07S+vLXbusNjh+XL++Cg74xkkU7vzbIsgpE5rpVeE=;
  b=S+0SPQjfvw6f8t1jkpBX9zbK5cFhrvP+HfbpW0bSCEL26y42TKIro+SO
   tAT+1sm6xkA4qHP15XTsTRT4FTyUT4dhi9rDgJDCRBCnJwG8W15385lAM
   Y3ZPYTTLorDgLXFt9ht32/H8pxmf4r2m1VU8w2frcbIC45DiknupuVpw4
   QPqqThe20zw+Gyp2pYZVqBHwdXkE0QBPWT6fJcoyxsrLN3qQDHUySRUhI
   K6hkozQsVQZUTAPxyEg9FHBr3cxUIYd/4MrX+QlFQ+GEG+FUyeRaw1U5/
   qvkZXdeZneSwxVU0GnCNTZeSSaZlCFTNXqQQw8OIUSN7newvV4VhbbAuH
   A==;
X-CSE-ConnectionGUID: X5JN1wu/SnCE4fav4xVMaw==
X-CSE-MsgGUID: 5sc0eJiDR86VGJsT08kSrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26676729"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26676729"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 21:18:56 -0700
X-CSE-ConnectionGUID: 7tSiUmT6Rq2viuSqFBLDmw==
X-CSE-MsgGUID: 8sc6RV3/TO62Vs3ZkofgMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78483449"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Sep 2024 21:18:53 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svULa-000QED-1L;
	Tue, 01 Oct 2024 04:18:50 +0000
Date: Tue, 1 Oct 2024 12:17:55 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Yang <me@shenghaoyang.info>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com, olteanv@gmail.com, pavana.sharma@digi.com,
	ashkan.boldaji@digi.com, kabel@kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net 2/3] net: dsa: mv88e6xxx: read cycle counter period
 from hardware
Message-ID: <202410011105.XXvEbI6k-lkp@intel.com>
References: <20240929101949.723658-3-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929101949.723658-3-me@shenghaoyang.info>

Hi Shenghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Yang/net-dsa-mv88e6xxx-group-cycle-counter-coefficients/20240929-182245
base:   net/main
patch link:    https://lore.kernel.org/r/20240929101949.723658-3-me%40shenghaoyang.info
patch subject: [PATCH net 2/3] net: dsa: mv88e6xxx: read cycle counter period from hardware
config: sparc64-randconfig-r133-20240930 (https://download.01.org/0day-ci/archive/20241001/202410011105.XXvEbI6k-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241001/202410011105.XXvEbI6k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011105.XXvEbI6k-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/dsa/mv88e6xxx/ptp.c:35:34: sparse: sparse: symbol 'mv88e6xxx_cc_10ns_coeffs' was not declared. Should it be static?
>> drivers/net/dsa/mv88e6xxx/ptp.c:49:34: sparse: sparse: symbol 'mv88e6xxx_cc_8ns_coeffs' was not declared. Should it be static?

vim +/mv88e6xxx_cc_10ns_coeffs +35 drivers/net/dsa/mv88e6xxx/ptp.c

    27	
    28	/* Family MV88E6250:
    29	 * Raw timestamps are in units of 10-ns clock periods.
    30	 *
    31	 * clkadj = scaled_ppm * 10*2^28 / (10^6 * 2^16)
    32	 * simplifies to
    33	 * clkadj = scaled_ppm * 2^7 / 5^5
    34	 */
  > 35	const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
    36		.cc_shift = 28,
    37		.cc_mult = 10 << 28,
    38		.cc_mult_num = 1 << 7,
    39		.cc_mult_dem = 3125ULL,
    40	};
    41	
    42	/* Other families:
    43	 * Raw timestamps are in units of 8-ns clock periods.
    44	 *
    45	 * clkadj = scaled_ppm * 8*2^28 / (10^6 * 2^16)
    46	 * simplifies to
    47	 * clkadj = scaled_ppm * 2^9 / 5^6
    48	 */
  > 49	const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
    50		.cc_shift = 28,
    51		.cc_mult = 8 << 28,
    52		.cc_mult_num = 1 << 9,
    53		.cc_mult_dem = 15625ULL
    54	};
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

