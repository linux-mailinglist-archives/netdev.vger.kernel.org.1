Return-Path: <netdev+bounces-87924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E60A8A4F3F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4271C21223
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CF6FE22;
	Mon, 15 Apr 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3uDBzkV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055E6FE0C
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184805; cv=none; b=J5J9UO4A6vANxrkopMbiciGDVNaV+WiTod8R9kaIX8ogtck8miWiAnrahozT2ivaaJYG+A59xl931Zsg3GTDFDUVBxKLnVq2Ew2c5IT5rDk6HWxH1jFN/kHfu1y60MqaUVWqW6ZIq4aqSwJcBTOn90HQ3gsIhvCEzPFU35JdzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184805; c=relaxed/simple;
	bh=i8ZEMLdPu4OleHkKNZoj7pwa+x/6c1ERkI6+xBnFCKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSaJiwdPYsyKvEoZeQE9gVBfVNaCVBAkk/cqsPDm1+EfBm342W1tHduQCtSD/7u9XZbpkXYtSEu/iUX28UEpdYjRemYtu88VNwE4OZOqXuquZsLWg7Gp/QW9JzOaRUiJpcmqyCvfNrVouijhevz065+E+JascCc+KgjfivdKc2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3uDBzkV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713184804; x=1744720804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i8ZEMLdPu4OleHkKNZoj7pwa+x/6c1ERkI6+xBnFCKo=;
  b=T3uDBzkVtN+EFAQrs6INA0B5aF4fZnsPtJNFWDnYDJZXXhAlsKF4RKda
   Mp1c3mcgYYCFrUYV88jYSqDo2TUxGZqDqeYjfeVe84rBE9Ul3cz+O+xRO
   y7ohH9s8wKP75M8lJ3AwCde419QmcqhjnP4QV59puwonE3wF2YsMpnwWH
   cIiVxkJ0EfYOy1LcFmLLOsuGRBPvYI8GLqDCocf5cK8NmiCfWnEbnVrou
   Lh4szC/WCnJ3KcbP7HwtAdAnUuLl+JYmcIV84Gz1UEYOIT2lwgQ/AIC9L
   kG6C27jLXFGPrUzcERVsPYZV2pR91q+x1bTEQjDEjsZFK+l6qzmKhRZU5
   Q==;
X-CSE-ConnectionGUID: 6PPJLQ66SYuExvmtFQ/oFg==
X-CSE-MsgGUID: Lv4tvVtUSaaOSYTEo3JinQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8790940"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8790940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 05:40:03 -0700
X-CSE-ConnectionGUID: UNU3rYamS/2RyFq91wno+g==
X-CSE-MsgGUID: cyRE5pxpSRaNzA/Rf/u63g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="21896339"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 15 Apr 2024 05:40:01 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwLct-0004AO-1B;
	Mon, 15 Apr 2024 12:39:59 +0000
Date: Mon, 15 Apr 2024 20:39:37 +0800
From: kernel test robot <lkp@intel.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 1/5] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <202404152042.fOlsMNTW-lkp@intel.com>
References: <20240415104352.4685-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415104352.4685-2-fujita.tomonori@gmail.com>

Hi FUJITA,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 32affa5578f0e6b9abef3623d3976395afbd265c]

url:    https://github.com/intel-lab-lkp/linux/commits/FUJITA-Tomonori/net-tn40xx-add-pci-driver-for-Tehuti-Networks-TN40xx-chips/20240415-185416
base:   32affa5578f0e6b9abef3623d3976395afbd265c
patch link:    https://lore.kernel.org/r/20240415104352.4685-2-fujita.tomonori%40gmail.com
patch subject: [PATCH net-next v1 1/5] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
reproduce: (https://download.01.org/0day-ci/archive/20240415/202404152042.fOlsMNTW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404152042.fOlsMNTW-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/rustc-1.76.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-17/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wenum-conversion W=1 --keep-going LLVM=1 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>> ./drivers/net/ethernet/tehuti/tn40.h: 10 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 410: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

