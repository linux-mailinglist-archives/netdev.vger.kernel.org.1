Return-Path: <netdev+bounces-100899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB28FC816
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8BDB20A60
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53F190078;
	Wed,  5 Jun 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mN78Cuxt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936B1946CB
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580252; cv=none; b=ZN9DLq8ryKUeBlYUDDey8690siMpmW7J9Nl+H6i33qyVg1xD/TgSyDWHUsxaLC28U4Xp8U392s5GxgjIoeMyYBBhZ3NyLI6Irz4z0PLUjE8VpvKFwniwdhOuSq6UIZr+cfDng054rBJ5ouqT7dLmoJS0racgknMtsjRkJaiFHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580252; c=relaxed/simple;
	bh=BdfgVb9SY/s+T9CbGMmpm2o5PCRFbB0nsRFyhTfUV5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJOpHIpzFGNU+l/E7OtFND/jvU2IjkejR1fHnqvXcnWYFFDTlDmBt0JhqsxYhV39YzPBa2axklP8rj8m+3veIy3JcTmHmcZ7YSL0ZDfM91r5mIv2/dSgsqD3G14i/hovSdEThimMVQuDFHcgQMT7siNUDKjrZhsSlfQ5P4c2P0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mN78Cuxt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717580250; x=1749116250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdfgVb9SY/s+T9CbGMmpm2o5PCRFbB0nsRFyhTfUV5U=;
  b=mN78CuxtVfP3eBi8us6wXMOKrrTc1epMAQO/zY2FD7EvcO4LwLhKTBw1
   JOarKhX6Zfe0Wi30HqySgVA4cPVZVGvYkX1i06ALzi4dI20gW8HpQYhEr
   qyRmlKG9SRXuKmf+7cdBYTQuO45UDedXskpxZixw9Rcfk8YuY6CFhMV1t
   VaLnSRCAOGKiN3xBp2xZ8YdSoCQbJ2jtdzYK1Wnt86WtrvRR3ByxmYFaJ
   JRVBciCuric+xisdu0XuiVEp7MZ/5aFvTYpoqlbEyUgxXZJUDvrZsr/8a
   nyNAMqDNOji52/IGDS87MqHqCJ9fXXdJlZavhy/iR0hsS+x6VmZl0+OPS
   Q==;
X-CSE-ConnectionGUID: VGI7RbAIT9+TTmbv3DfR4Q==
X-CSE-MsgGUID: NBSULk3fRYOseLxZne1SGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36698381"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="36698381"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 02:37:30 -0700
X-CSE-ConnectionGUID: KZYyg8rsTMeQ+7kgp+MXVg==
X-CSE-MsgGUID: Rxw64JkgRrqZ5q039EY7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="38116379"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 05 Jun 2024 02:37:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEn5B-0001Ke-2Z;
	Wed, 05 Jun 2024 09:37:25 +0000
Date: Wed, 5 Jun 2024 17:36:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: core: Implement dstats-type stats collections
Message-ID: <202406051725.14UkSYbV-lkp@intel.com>
References: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-dstats-v1-2-1024396e1670@codeconstruct.com.au>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32f88d65f01bf6f45476d7edbe675e44fb9e1d58]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Kerr/net-core-vrf-Change-pcpu_dstat-fields-to-u64_stats_t/20240605-143942
base:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
patch link:    https://lore.kernel.org/r/20240605-dstats-v1-2-1024396e1670%40codeconstruct.com.au
patch subject: [PATCH 2/3] net: core: Implement dstats-type stats collections
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240605/202406051725.14UkSYbV-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051725.14UkSYbV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051725.14UkSYbV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ./arch/openrisc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:299,
                    from include/linux/instrumented.h:10,
                    from include/linux/uaccess.h:6,
                    from net/core/dev.c:71:
   In function '__seqprop_sequence',
       inlined from '__u64_stats_fetch_begin' at include/linux/u64_stats_sync.h:171:9,
       inlined from 'u64_stats_fetch_begin' at include/linux/u64_stats_sync.h:208:9,
       inlined from 'dev_fetch_dstats' at net/core/dev.c:10873:12:
>> include/asm-generic/rwonce.h:44:26: warning: 'dstats' is used uninitialized [-Wuninitialized]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/linux/seqlock.h:211:16: note: in expansion of macro 'READ_ONCE'
     211 |         return READ_ONCE(s->sequence);
         |                ^~~~~~~~~
   net/core/dev.c: In function 'dev_fetch_dstats':
   net/core/dev.c:10868:43: note: 'dstats' was declared here
   10868 |                 const struct pcpu_dstats *dstats;
         |                                           ^~~~~~


vim +/dstats +44 include/asm-generic/rwonce.h

e506ea451254ab Will Deacon 2019-10-15  28  
e506ea451254ab Will Deacon 2019-10-15  29  /*
e506ea451254ab Will Deacon 2019-10-15  30   * Yes, this permits 64-bit accesses on 32-bit architectures. These will
e506ea451254ab Will Deacon 2019-10-15  31   * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
e506ea451254ab Will Deacon 2019-10-15  32   * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
e506ea451254ab Will Deacon 2019-10-15  33   * (e.g. a virtual address) and a strong prevailing wind.
e506ea451254ab Will Deacon 2019-10-15  34   */
e506ea451254ab Will Deacon 2019-10-15  35  #define compiletime_assert_rwonce_type(t)					\
e506ea451254ab Will Deacon 2019-10-15  36  	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
e506ea451254ab Will Deacon 2019-10-15  37  		"Unsupported access size for {READ,WRITE}_ONCE().")
e506ea451254ab Will Deacon 2019-10-15  38  
e506ea451254ab Will Deacon 2019-10-15  39  /*
e506ea451254ab Will Deacon 2019-10-15  40   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
3c9184109e78ea Will Deacon 2019-10-30  41   * atomicity. Note that this may result in tears!
e506ea451254ab Will Deacon 2019-10-15  42   */
b78b331a3f5c07 Will Deacon 2019-10-15  43  #ifndef __READ_ONCE
e506ea451254ab Will Deacon 2019-10-15 @44  #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
b78b331a3f5c07 Will Deacon 2019-10-15  45  #endif
e506ea451254ab Will Deacon 2019-10-15  46  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

