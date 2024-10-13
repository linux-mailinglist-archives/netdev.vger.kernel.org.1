Return-Path: <netdev+bounces-134891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB9799B82C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DE0B21D62
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 04:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5B93EA71;
	Sun, 13 Oct 2024 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4QrNF7i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D1231C8D;
	Sun, 13 Oct 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728792102; cv=none; b=GG8uNW/GJzLi66hb8iDipnnk+qGHkVJ4Eyje7gj268tikmP99MRQh8bh1Uxf497pIEak74/q/LZXuNWOvVFGHec9OU5zCHCEpSABuWs2LTaHZjCxPUlae9hO1XObG6T556G73ABvUN3KdDFWEYUxWUUiR3idxughln+9bwb0tBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728792102; c=relaxed/simple;
	bh=oocklscEBCSjq1rJjo1SBNYankaIRti27cp1754HjiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhDF3ELtAG7XjWAOnR4q04CsKwPKIli8JgUM1jLSR8y386snfOFlJvbkiRHitmkUH5/CqO2SEzsDQ1U9yLFwCXinnG3RVp1VsKctFdzGX0gDYUCk/wDl6AqKPZZtUsM3eqv5Fht3VrdqDz+uvWY467UDgoTiHBGer6rpBoDtg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4QrNF7i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728792099; x=1760328099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oocklscEBCSjq1rJjo1SBNYankaIRti27cp1754HjiU=;
  b=V4QrNF7itD6sfuMrCKBPzO0W9oxT9VqikJmtL0mqxNWiG7uPwjV1zExd
   nssgQ7wR3DvJhbfkiihQBd9UQPjpCLUSy3WSj/6JdlGwjvJ39tQg2aoZV
   KZb3L9De+PGjuq2FExmgBCtLP9+m/HD9lZrokZNpAySqg2VEb/xPodLII
   EcO+ejb76OssjIiEBAo5a4gU/fWWk8WKtaibLgLMCjKt7koyFWSJC35m4
   lvkmAo5BB/20y7i6Ho3xNd6NU4j93kSTaMn+cpjeisjlHlkCIkdyx+Ag3
   pS4S8J42VDZtdCwkXYe31+s0HgGGHXXg4Pls5W7Q6nCWt/qdDdNz20Cwh
   w==;
X-CSE-ConnectionGUID: uD5YfxF0QwuXuVcZXm6QJg==
X-CSE-MsgGUID: pAzReksQR/6Fj3V2Fu3rGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28108157"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28108157"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 21:01:38 -0700
X-CSE-ConnectionGUID: fS4uKx4lSLqGC5MxWgjg4Q==
X-CSE-MsgGUID: cNa69fAOT4qgjSuSnsTeow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="78080134"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Oct 2024 21:01:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szpnP-000E3X-0v;
	Sun, 13 Oct 2024 04:01:31 +0000
Date: Sun, 13 Oct 2024 12:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Kees Cook <keescook@chromium.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Dan Carpenter <error27@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid
 potential warning
Message-ID: <202410131151.SBnGQot0-lkp@intel.com>
References: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011121535.28049-1-przemyslaw.kitszel@intel.com>

Hi Przemek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 44badc908f2c85711cb18e45e13119c10ad3a05f]

url:    https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/cleanup-adjust-scoped_guard-macros-to-avoid-potential-warning/20241011-201702
base:   44badc908f2c85711cb18e45e13119c10ad3a05f
patch link:    https://lore.kernel.org/r/20241011121535.28049-1-przemyslaw.kitszel%40intel.com
patch subject: [PATCH v3] cleanup: adjust scoped_guard() macros to avoid potential warning
config: i386-buildonly-randconfig-005-20241013 (https://download.01.org/0day-ci/archive/20241013/202410131151.SBnGQot0-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410131151.SBnGQot0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131151.SBnGQot0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firewire/core-device.c:1041:2: warning: variable 'found' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1041 |         scoped_guard(rwsem_read, &fw_device_rwsem) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/core-device.c:1045:6: note: uninitialized use occurs here
    1045 |         if (found) {
         |             ^~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/firewire/core-device.c:1041:2: note: remove the 'if' if its condition is always false
    1041 |         scoped_guard(rwsem_read, &fw_device_rwsem) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/firewire/core-device.c:1008:22: note: initialize the variable 'found' to silence this warning
    1008 |         struct device *found;
         |                             ^
         |                              = NULL
   1 warning generated.
--
>> drivers/firewire/core-transaction.c:912:2: warning: variable 'handler' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     912 |         scoped_guard(rcu) {
         |         ^~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/core-transaction.c:921:7: note: uninitialized use occurs here
     921 |         if (!handler)
         |              ^~~~~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/firewire/core-transaction.c:912:2: note: remove the 'if' if its condition is always false
     912 |         scoped_guard(rcu) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/firewire/core-transaction.c:903:36: note: initialize the variable 'handler' to silence this warning
     903 |         struct fw_address_handler *handler;
         |                                           ^
         |                                            = NULL
   1 warning generated.
--
>> drivers/firewire/core-cdev.c:508:2: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     508 |         scoped_guard(spinlock_irqsave, &client->lock) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/core-cdev.c:530:9: note: uninitialized use occurs here
     530 |         return ret < 0 ? ret : 0;
         |                ^~~
   drivers/firewire/core-cdev.c:508:2: note: remove the 'if' if its condition is always false
     508 |         scoped_guard(spinlock_irqsave, &client->lock) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/firewire/core-cdev.c:506:9: note: initialize the variable 'ret' to silence this warning
     506 |         int ret;
         |                ^
         |                 = 0
>> drivers/firewire/core-cdev.c:1327:2: warning: variable 'skip' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1327 |         scoped_guard(spinlock_irq, &client->lock) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/firewire/core-cdev.c:1346:6: note: uninitialized use occurs here
    1346 |         if (skip)
         |             ^~~~
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                               ^~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/firewire/core-cdev.c:1327:2: note: remove the 'if' if its condition is always false
    1327 |         scoped_guard(spinlock_irq, &client->lock) {
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/firewire/core-cdev.c:1325:11: note: initialize the variable 'skip' to silence this warning
    1325 |         bool skip, free, success;
         |                  ^
         |                   = 0
   2 warnings generated.
--
>> drivers/gpio/gpio-sim.c:179:2: warning: variable 'direction' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     179 |         scoped_guard(mutex, &chip->lock)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-sim.c:182:9: note: uninitialized use occurs here
     182 |         return direction ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
         |                ^~~~~~~~~
   drivers/gpio/gpio-sim.c:179:2: note: remove the 'if' if its condition is always false
     179 |         scoped_guard(mutex, &chip->lock)
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/gpio/gpio-sim.c:177:15: note: initialize the variable 'direction' to silence this warning
     177 |         int direction;
         |                      ^
         |                       = 0
>> drivers/gpio/gpio-sim.c:277:2: warning: variable 'val' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     277 |         scoped_guard(mutex, &chip->lock)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-sim.c:280:33: note: uninitialized use occurs here
     280 |         return sysfs_emit(buf, "%d\n", val);
         |                                        ^~~
   drivers/gpio/gpio-sim.c:277:2: note: remove the 'if' if its condition is always false
     277 |         scoped_guard(mutex, &chip->lock)
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/gpio/gpio-sim.c:275:9: note: initialize the variable 'val' to silence this warning
     275 |         int val;
         |                ^
         |                 = 0
>> drivers/gpio/gpio-sim.c:307:2: warning: variable 'pull' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     307 |         scoped_guard(mutex, &chip->lock)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-sim.c:310:61: note: uninitialized use occurs here
     310 |         return sysfs_emit(buf, "%s\n", gpio_sim_sysfs_pull_strings[pull]);
         |                                                                    ^~~~
   drivers/gpio/gpio-sim.c:307:2: note: remove the 'if' if its condition is always false
     307 |         scoped_guard(mutex, &chip->lock)
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/gpio/gpio-sim.c:305:10: note: initialize the variable 'pull' to silence this warning
     305 |         int pull;
         |                 ^
         |                  = 0
>> drivers/gpio/gpio-sim.c:756:2: warning: variable 'live' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     756 |         scoped_guard(mutex, &dev->lock)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-sim.c:759:31: note: uninitialized use occurs here
     759 |         return sprintf(page, "%c\n", live ? '1' : '0');
         |                                      ^~~~
   drivers/gpio/gpio-sim.c:756:2: note: remove the 'if' if its condition is always false
     756 |         scoped_guard(mutex, &dev->lock)
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/gpio/gpio-sim.c:754:11: note: initialize the variable 'live' to silence this warning
     754 |         bool live;
         |                  ^
         |                   = 0
>> drivers/gpio/gpio-sim.c:1266:2: warning: variable 'dir' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1266 |         scoped_guard(mutex, &dev->lock)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:28: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:30: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-sim.c:1269:10: note: uninitialized use occurs here
    1269 |         switch (dir) {
         |                 ^~~
   drivers/gpio/gpio-sim.c:1266:2: note: remove the 'if' if its condition is always false
    1266 |         scoped_guard(mutex, &dev->lock)
         |         ^
   include/linux/cleanup.h:197:2: note: expanded from macro 'scoped_guard'
     197 |         __scoped_guard(_name, /* empty */, __UNIQUE_ID(label), args)
         |         ^
   include/linux/cleanup.h:190:3: note: expanded from macro '__scoped_guard'
     190 |                 if (!__guard_ptr(_name)(&scope) && __is_cond_ptr(_name)) {      \
         |                 ^
   include/linux/compiler.h:55:23: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^
   drivers/gpio/gpio-sim.c:1264:9: note: initialize the variable 'dir' to silence this warning
    1264 |         int dir;
         |                ^
         |                 = 0
   5 warnings generated.
..


vim +1041 drivers/firewire/core-device.c

e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1002  
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1003  static void fw_device_init(struct work_struct *work)
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1004  {
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1005  	struct fw_device *device =
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1006  		container_of(work, struct fw_device, work.work);
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1007  	struct fw_card *card = device->card;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1008  	struct device *found;
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1009  	u32 minor;
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1010  	int ret;
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1011  
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1012  	/*
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1013  	 * All failure paths here set node->data to NULL, so that we
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1014  	 * don't try to do device_for_each_child() on a kfree()'d
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1015  	 * device.
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1016  	 */
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1017  
94fba9fbeac444 drivers/firewire/core-device.c Clemens Ladisch   2012-04-11  1018  	ret = read_config_rom(device, device->generation);
94fba9fbeac444 drivers/firewire/core-device.c Clemens Ladisch   2012-04-11  1019  	if (ret != RCODE_COMPLETE) {
855c603d61ede7 drivers/firewire/fw-device.c   Stefan Richter    2008-02-27  1020  		if (device->config_rom_retries < MAX_RETRIES &&
855c603d61ede7 drivers/firewire/fw-device.c   Stefan Richter    2008-02-27  1021  		    atomic_read(&device->state) == FW_DEVICE_INITIALIZING) {
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1022  			device->config_rom_retries++;
6ea9e7bbfc389a drivers/firewire/core-device.c Stefan Richter    2010-10-13  1023  			fw_schedule_device_work(device, RETRY_DELAY);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1024  		} else {
115881d395959b drivers/firewire/core-device.c Stefan Richter    2011-03-15  1025  			if (device->node->link_on)
94fba9fbeac444 drivers/firewire/core-device.c Clemens Ladisch   2012-04-11  1026  				fw_notice(card, "giving up on node %x: reading config rom failed: %s\n",
94fba9fbeac444 drivers/firewire/core-device.c Clemens Ladisch   2012-04-11  1027  					  device->node_id,
94fba9fbeac444 drivers/firewire/core-device.c Clemens Ladisch   2012-04-11  1028  					  fw_rcode_string(ret));
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1029  			if (device->node == card->root_node)
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1030  				fw_schedule_bm_work(card, 0);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1031  			fw_device_release(&device->device);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1032  		}
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1033  		return;
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1034  	}
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1035  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1036  	// If a device was pending for deletion because its node went away but its bus info block
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1037  	// and root directory header matches that of a newly discovered device, revive the
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1038  	// existing fw_device. The newly allocated fw_device becomes obsolete instead.
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1039  	//
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1040  	// serialize config_rom access.
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20 @1041  	scoped_guard(rwsem_read, &fw_device_rwsem) {
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1042  		found = device_find_child(card->device, (void *)device->config_rom,
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1043  					  compare_configuration_rom);
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1044  	}
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1045  	if (found) {
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1046  		struct fw_device *reused = fw_device(found);
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1047  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1048  		if (atomic_cmpxchg(&reused->state,
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1049  				   FW_DEVICE_GONE,
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1050  				   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1051  			// serialize node access
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1052  			scoped_guard(spinlock_irq, &card->lock) {
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1053  				struct fw_node *current_node = device->node;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1054  				struct fw_node *obsolete_node = reused->node;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1055  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1056  				device->node = obsolete_node;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1057  				device->node->data = device;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1058  				reused->node = current_node;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1059  				reused->node->data = reused;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1060  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1061  				reused->max_speed = device->max_speed;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1062  				reused->node_id = current_node->node_id;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1063  				smp_wmb();  /* update node_id before generation */
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1064  				reused->generation = card->generation;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1065  				reused->config_rom_retries = 0;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1066  				fw_notice(card, "rediscovered device %s\n",
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1067  					  dev_name(found));
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1068  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1069  				reused->workfn = fw_device_update;
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1070  				fw_schedule_device_work(reused, 0);
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1071  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1072  				if (current_node == card->root_node)
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1073  					fw_schedule_bm_work(card, 0);
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1074  			}
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1075  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1076  			put_device(found);
3d36a0df3b473f drivers/firewire/fw-device.c   Stefan Richter    2009-01-17  1077  			fw_device_release(&device->device);
3d36a0df3b473f drivers/firewire/fw-device.c   Stefan Richter    2009-01-17  1078  
3d36a0df3b473f drivers/firewire/fw-device.c   Stefan Richter    2009-01-17  1079  			return;
3d36a0df3b473f drivers/firewire/fw-device.c   Stefan Richter    2009-01-17  1080  		}
3d36a0df3b473f drivers/firewire/fw-device.c   Stefan Richter    2009-01-17  1081  
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1082  		put_device(found);
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1083  	}
e2c87f484190b1 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-20  1084  
6230582320b721 drivers/firewire/fw-device.c   Stefan Richter    2009-01-09  1085  	device_initialize(&device->device);
96b19062e741b7 drivers/firewire/fw-device.c   Stefan Richter    2008-02-02  1086  
96b19062e741b7 drivers/firewire/fw-device.c   Stefan Richter    2008-02-02  1087  	fw_device_get(device);
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1088  
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1089  	// The index of allocated entry is used for minor identifier of device node.
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1090  	ret = xa_alloc(&fw_device_xa, &minor, device, XA_LIMIT(0, MINORMASK), GFP_KERNEL);
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1091  	if (ret < 0)
a3aca3dabbcf00 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-07  1092  		goto error;
a3aca3dabbcf00 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-07  1093  
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1094  	device->device.bus = &fw_bus_type;
21351dbe4e6127 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-20  1095  	device->device.type = &fw_device_type;
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1096  	device->device.parent = card->device;
a3aca3dabbcf00 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-07  1097  	device->device.devt = MKDEV(fw_cdev_major, minor);
a1f64819fe9f13 drivers/firewire/fw-device.c   Kay Sievers       2008-10-30  1098  	dev_set_name(&device->device, "fw%d", minor);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1099  
e5333db9285e08 drivers/firewire/fw-device.c   Stefan Richter    2009-05-22  1100  	BUILD_BUG_ON(ARRAY_SIZE(device->attribute_group.attrs) <
e5333db9285e08 drivers/firewire/fw-device.c   Stefan Richter    2009-05-22  1101  			ARRAY_SIZE(fw_device_attributes) +
e5333db9285e08 drivers/firewire/fw-device.c   Stefan Richter    2009-05-22  1102  			ARRAY_SIZE(config_rom_attributes));
6f2e53d5135a86 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-27  1103  	init_fw_attribute_group(&device->device,
6f2e53d5135a86 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-27  1104  				fw_device_attributes,
6f2e53d5135a86 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-27  1105  				&device->attribute_group);
e5333db9285e08 drivers/firewire/fw-device.c   Stefan Richter    2009-05-22  1106  
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1107  	if (device_add(&device->device)) {
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1108  		fw_err(card, "failed to add device\n");
a3aca3dabbcf00 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-07  1109  		goto error_with_cdev;
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1110  	}
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1111  
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1112  	create_units(device);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1113  
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1114  	/*
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1115  	 * Transition the device to running state.  If it got pulled
183b8021fc0a5f drivers/firewire/core-device.c Masahiro Yamada   2017-02-27  1116  	 * out from under us while we did the initialization work, we
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1117  	 * have to shut down the device again here.  Normally, though,
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1118  	 * fw_node_event will be responsible for shutting it down when
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1119  	 * necessary.  We have to use the atomic cmpxchg here to avoid
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1120  	 * racing with the FW_NODE_DESTROYED case in
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1121  	 * fw_node_event().
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1122  	 */
641f8791f031d6 drivers/firewire/fw-device.c   Stefan Richter    2007-01-27  1123  	if (atomic_cmpxchg(&device->state,
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1124  			   FW_DEVICE_INITIALIZING,
3d36a0df3b473f drivers/firewire/fw-device.c   Stefan Richter    2009-01-17  1125  			   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
70044d71d31d69 drivers/firewire/core-device.c Tejun Heo         2014-03-07  1126  		device->workfn = fw_device_shutdown;
6ea9e7bbfc389a drivers/firewire/core-device.c Stefan Richter    2010-10-13  1127  		fw_schedule_device_work(device, SHUTDOWN_DELAY);
fa6e697b85d705 drivers/firewire/fw-device.c   Stefan Richter    2008-02-03  1128  	} else {
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1129  		fw_notice(card, "created device %s: GUID %08x%08x, S%d00\n",
a1f64819fe9f13 drivers/firewire/fw-device.c   Kay Sievers       2008-10-30  1130  			  dev_name(&device->device),
fa6e697b85d705 drivers/firewire/fw-device.c   Stefan Richter    2008-02-03  1131  			  device->config_rom[3], device->config_rom[4],
f1397490017e33 drivers/firewire/fw-device.c   Stefan Richter    2007-06-10  1132  			  1 << device->max_speed);
c9755e14a01987 drivers/firewire/fw-device.c   Stefan Richter    2008-03-24  1133  		device->config_rom_retries = 0;
7889b60ee71eaf drivers/firewire/fw-device.c   Stefan Richter    2009-03-10  1134  
099d54143e49d4 drivers/firewire/core-device.c Stefan Richter    2009-06-06  1135  		set_broadcast_channel(device, device->generation);
badfcb24891ccd drivers/firewire/core-device.c Clemens Ladisch   2012-08-13  1136  
badfcb24891ccd drivers/firewire/core-device.c Clemens Ladisch   2012-08-13  1137  		add_device_randomness(&device->config_rom[3], 8);
fa6e697b85d705 drivers/firewire/fw-device.c   Stefan Richter    2008-02-03  1138  	}
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1139  
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1140  	/*
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1141  	 * Reschedule the IRM work if we just finished reading the
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1142  	 * root node config rom.  If this races with a bus reset we
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1143  	 * just end up running the IRM work a couple of extra times -
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1144  	 * pretty harmless.
c781c06d119d04 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-05-07  1145  	 */
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1146  	if (device->node == card->root_node)
26b4950de174bc drivers/firewire/core-device.c Stefan Richter    2012-02-18  1147  		fw_schedule_bm_work(card, 0);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1148  
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1149  	return;
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1150  
a3aca3dabbcf00 drivers/firewire/fw-device.c   Kristian Høgsberg 2007-03-07  1151   error_with_cdev:
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1152  	xa_erase(&fw_device_xa, minor);
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1153   error:
7e5a7725a0e403 drivers/firewire/core-device.c Takashi Sakamoto  2024-08-12  1154  	fw_device_put(device);		// fw_device_xa's reference.
96b19062e741b7 drivers/firewire/fw-device.c   Stefan Richter    2008-02-02  1155  
96b19062e741b7 drivers/firewire/fw-device.c   Stefan Richter    2008-02-02  1156  	put_device(&device->device);	/* our reference */
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1157  }
19a15b937b2663 drivers/firewire/fw-device.c   Kristian Høgsberg 2006-12-19  1158  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

