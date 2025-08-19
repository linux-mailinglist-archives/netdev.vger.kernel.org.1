Return-Path: <netdev+bounces-214917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7BB2BD6A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 11:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ED24E46AB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144931A06A;
	Tue, 19 Aug 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6l1J9pz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3F31CA50
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595696; cv=none; b=JzfwCDMdyWXSpUDW4C/M0q+ovVthRC59kAiZ7vIkz7k+WcqLK50FBsAvm67eLNY7ap9RaBljaIpqsci6FzdJLysp6D9hSb0iYVfMt4M2KHtG+na3Es236JlX1jQDE5D9DzzF054umpxQIhBIkrqodO2WR7TmU4gSAid5diABb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595696; c=relaxed/simple;
	bh=aY4nfATfEDBE9HkWCGMg4md5MJCVY8LRNdkz9R4iLJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVj1Zgvq+doyR2S6W85PARUFLyIARZfqgN1X9/SBSNxWODcLgood7L2ZwQM6g6TDejBLSOV0g354Q46F9cRBFKJTG3qTMZNDDcY+eNQbXKx16bGXtCbNz6SwjSuOxi6QmSd1KVEalIgPJBqTc9DVdCgclJFwMV0/WSBpqZ2i91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6l1J9pz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755595694; x=1787131694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aY4nfATfEDBE9HkWCGMg4md5MJCVY8LRNdkz9R4iLJc=;
  b=X6l1J9pzNIydf0Q8v4oEL8qSEYMQdrOGwM3fMiPvMmm8U48qQ522jJp9
   r891X19k8oy3wkmt3ocW7++qjhqjm51eRkbp/SIcgMI19zaEsdFbpK2jC
   YSOQ/SB09QL2DSR6N4xd6EqOISPlN3mqwTMqwkO7kgKBudm037b/1Eg2Z
   gVM7/A/31kCY35v3gOM5thiSJDTueJMkIMX4cG2yfmFRe+b61yqsJoHxY
   lAWU041PuEhipheuLUsPwk0CAMDDPoaPX7s5dvB+heaSD+Bz1v6EKxKu6
   JPqjesNq9uDwE2YsNH1HCKdvuOdGpTGmekKmkXf7npNUBkaX/NUFCbovR
   Q==;
X-CSE-ConnectionGUID: RkhvsUMGSdCETioDZU247A==
X-CSE-MsgGUID: tNt7tTp8RdmL03si3dAB/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68099574"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="68099574"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 02:28:13 -0700
X-CSE-ConnectionGUID: /q+oVUUHQYOCAIczP/kgWA==
X-CSE-MsgGUID: uUyaX2nBTx+XodmXZp2r0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="172041528"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2025 02:28:10 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoIdH-000Gh9-28;
	Tue, 19 Aug 2025 09:27:58 +0000
Date: Tue, 19 Aug 2025 17:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>, dhowells@redhat.com,
	kees@kernel.org, gustavoars@kernel.org,
	aleksander.lobakin@intel.com, tstruk@gigaio.com
Subject: Re: [PATCH net-next] stddef: don't include compiler_types.h in the
 uAPI header
Message-ID: <202508191741.O5OYysnF-lkp@intel.com>
References: <20250818181848.799566-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818181848.799566-1-kuba@kernel.org>

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/stddef-don-t-include-compiler_types-h-in-the-uAPI-header/20250819-022023
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250818181848.799566-1-kuba%40kernel.org
patch subject: [PATCH net-next] stddef: don't include compiler_types.h in the uAPI header
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250819/202508191741.O5OYysnF-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508191741.O5OYysnF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508191741.O5OYysnF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/auxclock.h:5:
   In file included from include/uapi/linux/time.h:5:
>> include/linux/types.h:265:21: error: field has incomplete type 'struct task_struct'
     265 |         struct task_struct __rcu *task;
         |                            ^
   include/linux/types.h:265:9: note: forward declaration of 'struct task_struct'
     265 |         struct task_struct __rcu *task;
         |                ^
>> include/linux/types.h:265:26: error: expected ';' at end of declaration list
     265 |         struct task_struct __rcu *task;
         |                                 ^
         |                                 ;
   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:6:
   In file included from include/vdso/datapage.h:7:
   In file included from include/linux/compiler.h:5:
   In file included from include/linux/compiler_types.h:89:
>> include/linux/compiler_attributes.h:55:9: warning: '__always_inline' macro redefined [-Wmacro-redefined]
      55 | #define __always_inline                 inline __attribute__((__In file included from arch/arm64/kernel/vdso32/note.c:11:
   In file included from include/linux/elfnote.h:62:
   In file included from include/uapi/linux/elf.h:5:
>> include/linux/types.h:265:21: error: field has incomplete type 'struct task_struct'
   alw  ays_inline__))
         |         ^
   include/uapi/linux/stddef.h:6:9: note: previous definition is here
       6 | #define __always_inline inline
         |         ^
   265 |         struct task_struct __rcu *task;
         |                            ^
   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:6:
   In file included from include/vdso/datapage.h:7:
   In file included from include/linux/compiler.h:5:
>> include/linux/compiler_types.h:346:10: warning: '__counted_by' macro redefined [-Wmacro-redefined]
     346 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
         |          ^
   include/uapi/linux/stddef.h:60:9: note: previous definition is here
      60 | #define __counted_by(m)
         |         ^
   In file included from include/linux/types.h:265:9: note: forward declaration of 'struct task_struct'
     265 |         struct task_struct __rcu *task;
         |                ^
   <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:6:
   In file included from include/vdso/datapage.h:7:
   In file included from include/linux/compiler.h:5:
>> include/linux/compiler_types.h:367include/linux/types.h:265:26: error: expected ';' at end of declaration list
   :  265 |         struct task_struct __rcu *task;
         |                                 ^
         |                                 ;
   9: warning: '__counted_by_le' macro redefined [-Wmacro-redefined]
     367 | #define __counted_by_le(member) __counted_by(member)
         |         ^
   include/uapi/linux/stddef.h:64:9: note: previous definition is here
      64 | #define __counted_by_le(m)
         |         ^
   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:6:
   In file included from include/vdso/datapage.h:7:
   In file included from include/linux/compiler.h:5:
>> include/linux/compiler_types.h:368:9: warning: '__counted_by_be' macro redefined [-Wmacro-redefined]
     368 | #define __counted_by_be(member)
         |         ^
   include/uapi/linux/stddef.h:68:9: note: previous definition is here
      68 | #define __counted_by_be(m)
         |         ^
>> error: expected ';' after struct
>> arch/arm64/kernel/vdso32/note.c:14:1: error: unknown type name '_note_14'
      14 | ELFNOTE32("Linux", 0, LINUX_VERSION_CODE);
         | ^
   include/linux/elfnote.h:95:37: note: expanded from macro 'ELFNOTE32'
      95 | #define ELFNOTE32(name, type, desc) ELFNOTE(32, name, type, desc)
         |                                     ^
   include/linux/elfnote.h:93:2: note: expanded from macro 'ELFNOTE'
      93 |         _ELFNOTE(size, name, __LINE__, type, desc)
         |         ^
   include/linux/elfnote.h:79:4: note: expanded from macro '_ELFNOTE'
      79 |         } _ELFNOTE_PASTE(_note_, unique)                                \
         |           ^
   include/linux/elfnote.h:71:29: note: expanded from macro '_ELFNOTE_PASTE'
      71 | #define _ELFNOTE_PASTE(a,b)     a##b
         |                                 ^
   <scratch space>:11:1: note: expanded from here
      11 | _note_14
         | ^
>> error: expected ';' after struct
>> arch/arm64/kernel/vdso32/note.c:15:1: error: unknown type name '_note_15'
      15 | BUILD_SALT;
         | ^
   include/linux/build-salt.h:16:8: note: expanded from macro 'BUILD_SALT'
      16 |        ELFNOTE32("Linux", LINUX_ELFNOTE_BUILD_SALT, CONFIG_BUILD_SALT)
         |        ^
   include/linux/elfnote.h:95:37: note: expanded from macro 'ELFNOTE32'
      95 | #define ELFNOTE32(name, type, desc) ELFNOTE(32, name, type, desc)
         |                                     ^
   include/linux/elfnote.h:93:2: note: expanded from macro 'ELFNOTE'
      93 |         _ELFNOTE(size, name, __LINE__, type, desc)
         |         ^
   include/linux/elfnote.h:79:4: note: expanded from macro '_ELFNOTE'
      79 |         } _ELFNOTE_PASTE(_note_, unique)                                \
         |           ^
   include/linux/elfnote.h:71:29: note: expanded from macro '_ELFNOTE_PASTE'
      71 | #define _ELFNOTE_PASTE(a,b)     a##b
         |                                 ^
   <scratch space>:21:1: note: expanded from here
      21 | _note_15
         | ^
   6 errors generated.
   make[3]: *** [arch/arm64/kernel/vdso32/Makefile:144: arch/arm64/kernel/vdso32/note.o] Error 1
   4 warnings and 2 errors generated.
   make[3]: *** [arch/arm64/kernel/vdso32/Makefile:146: arch/arm64/kernel/vdso32/vgettimeofday.o] Error 1
   make[3]: Target 'arch/arm64/kernel/vdso32/vdso.so' not remade because of errors.
   make[2]: *** [arch/arm64/Makefile:208: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__always_inline +55 include/linux/compiler_attributes.h

86cffecdeaa278 Kees Cook    2021-11-05  45  
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  46  /*
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  47   * Note: users of __always_inline currently do not write "inline" themselves,
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  48   * which seems to be required by gcc to apply the attribute according
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  49   * to its docs (and also "warning: always_inline function might not be
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  50   * inlinable [-Wattributes]" is emitted).
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  51   *
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  52   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-always_005finline-function-attribute
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  53   * clang: mentioned
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  54   */
a3f8a30f3f0079 Miguel Ojeda 2018-08-30 @55  #define __always_inline                 inline __attribute__((__always_inline__))
a3f8a30f3f0079 Miguel Ojeda 2018-08-30  56  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

