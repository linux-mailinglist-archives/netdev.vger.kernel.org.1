Return-Path: <netdev+bounces-97041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A178C8DD5
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA2D1F23BD0
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327421411D7;
	Fri, 17 May 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYHavwk5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2239FFD;
	Fri, 17 May 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715982093; cv=none; b=k2J4a8kLY+1ymBEbYoepvBj5s+458Q4GbCH7XfTBe2tTxbqw6RCieNyv8DE+FJI8/ibdGn7Rs4VHgqgvU0gCuwiLbObkE/ke5oJsLVPG15rlozlZ8FzbLFsz1n4l5/xKA1tPMACRCNUh0k69lCc9RGfkVM7+BvMJAn03/65A8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715982093; c=relaxed/simple;
	bh=4DbhTqVeCazl5JYN5QLQkbjuL3BMRR4vuSZ6FBq93Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEu4/3r2JmBz41OetC2PujvqMHpfUJjhYoiVZYJk82zkxKNtaa26ihtQJ3BWi9lRQUvCMn9xCEAGo6Gm7Rlh2N0Mv5R+sTiP7AkbFJVJbk0EEil/2FQ4zmnR17VRbf46+7tAUg8+rnjVdAiRlhovI0egm4u9yQp3G9A6Bnb4jEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYHavwk5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715982092; x=1747518092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4DbhTqVeCazl5JYN5QLQkbjuL3BMRR4vuSZ6FBq93Jc=;
  b=DYHavwk5BDhpoO5lvq4eAS9ZQALRzhUga0ic1Mldk8H67Hi/WVExCvE/
   zCmBok8BvE6/IKi/jOT2XJ+FJHrfiOrFElENc751Tf0dQ8w1v9wvIposO
   0zJlhNeGiJobaJQM7KTeGj59Z2Bny0h/UgQiUPr0lYhcFsxZNtK0w6Wmj
   CJHAcvvJsg4FJdR0+6jqvS8UKlFbhs7Kgy0SeIynRCaSj6LATZYeqg71b
   EWqtwXPGdES/+o6LYikceHfIU35FfJ3NVUZTLZWyuFWT0jryWC4Rbnx7b
   kawFGivVXjsn2vFk0CUnQSzi9cvANXHeaS0y1AJnNu+ArausT5ncyaGEM
   g==;
X-CSE-ConnectionGUID: qyP+kP+/SGO5WA3mSmR9Hg==
X-CSE-MsgGUID: tkzBAKr2QseCS4C3Tua+Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12397799"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12397799"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 14:41:30 -0700
X-CSE-ConnectionGUID: e19tFCluQkOjkel6aQ+J2Q==
X-CSE-MsgGUID: xJBNCq0iQ1WL/xSrWmqUqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="31935398"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 May 2024 14:41:20 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s85KH-00019l-1V;
	Fri, 17 May 2024 21:41:17 +0000
Date: Sat, 18 May 2024 05:34:17 +0800
From: kernel test robot <lkp@intel.com>
To: ye.xingchen@zte.com.cn, davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
	ncardwell@google.com, soheil@google.com, mfreemon@cloudflare.com,
	lixiaoyan@google.com, david.laight@aculab.com,
	haiyangz@microsoft.com, ye.xingchen@zte.com.cn,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	zhang.yunkai@zte.com.cn, fan.yu9@zte.com.cn
Subject: Re: [PATCH net-next] icmp: Add icmp_timestamp_ignore_all to control
 ICMP_TIMESTAMP
Message-ID: <202405180527.iGJVxmda-lkp@intel.com>
References: <20240517172639229ec5bN7VBV7SGEHkSK5K6f@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517172639229ec5bN7VBV7SGEHkSK5K6f@zte.com.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/icmp-Add-icmp_timestamp_ignore_all-to-control-ICMP_TIMESTAMP/20240517-172903
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240517172639229ec5bN7VBV7SGEHkSK5K6f%40zte.com.cn
patch subject: [PATCH net-next] icmp: Add icmp_timestamp_ignore_all to control ICMP_TIMESTAMP
config: arc-vdk_hs38_defconfig (https://download.01.org/0day-ci/archive/20240518/202405180527.iGJVxmda-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405180527.iGJVxmda-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405180527.iGJVxmda-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from ./arch/arc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:299,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/ipv4/icmp.c:62:
   net/ipv4/icmp.c: In function 'icmp_timestamp':
>> include/asm-generic/rwonce.h:44:71: warning: 'net' is used uninitialized [-Wuninitialized]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                       ^~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   net/ipv4/icmp.c:1157:13: note: in expansion of macro 'READ_ONCE'
    1157 |         if (READ_ONCE(net->ipv4.sysctl_icmp_timestamp_ignore_all))
         |             ^~~~~~~~~
   net/ipv4/icmp.c:1155:21: note: 'net' was declared here
    1155 |         struct net *net;
         |                     ^~~


vim +/net +44 include/asm-generic/rwonce.h

e506ea451254ab1 Will Deacon 2019-10-15  28  
e506ea451254ab1 Will Deacon 2019-10-15  29  /*
e506ea451254ab1 Will Deacon 2019-10-15  30   * Yes, this permits 64-bit accesses on 32-bit architectures. These will
e506ea451254ab1 Will Deacon 2019-10-15  31   * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
e506ea451254ab1 Will Deacon 2019-10-15  32   * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
e506ea451254ab1 Will Deacon 2019-10-15  33   * (e.g. a virtual address) and a strong prevailing wind.
e506ea451254ab1 Will Deacon 2019-10-15  34   */
e506ea451254ab1 Will Deacon 2019-10-15  35  #define compiletime_assert_rwonce_type(t)					\
e506ea451254ab1 Will Deacon 2019-10-15  36  	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
e506ea451254ab1 Will Deacon 2019-10-15  37  		"Unsupported access size for {READ,WRITE}_ONCE().")
e506ea451254ab1 Will Deacon 2019-10-15  38  
e506ea451254ab1 Will Deacon 2019-10-15  39  /*
e506ea451254ab1 Will Deacon 2019-10-15  40   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
3c9184109e78ea2 Will Deacon 2019-10-30  41   * atomicity. Note that this may result in tears!
e506ea451254ab1 Will Deacon 2019-10-15  42   */
b78b331a3f5c077 Will Deacon 2019-10-15  43  #ifndef __READ_ONCE
e506ea451254ab1 Will Deacon 2019-10-15 @44  #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
b78b331a3f5c077 Will Deacon 2019-10-15  45  #endif
e506ea451254ab1 Will Deacon 2019-10-15  46  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

