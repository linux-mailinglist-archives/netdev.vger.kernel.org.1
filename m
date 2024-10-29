Return-Path: <netdev+bounces-139794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9369B4290
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 07:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE161C21750
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC920127F;
	Tue, 29 Oct 2024 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cf1iMw/2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F12022F1
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184469; cv=none; b=oYOtvT4srKPHTdpFyFy2oIHvSarktqpkzHvvYpl4X90OYrR7bu0ogrUP+6FsqyMCI0viANC5O5Y4ZuzLhEmJLik2liRtR/5EJwzITWKKVKOhGB/CS5CESYw/wWXEAcY9hgW1gvpALAsjMEoSuC5Y4j3PRd9r3PXGepFos3y/pCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184469; c=relaxed/simple;
	bh=N8huXnUZLrC9Lnf0tE8yV/oXO9tA6YtQa8mRhHRnyU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFOHfjWi79k0zAHmip57cRvaTM+b1EEya5P740Q3DhY4kPEReshF0ts9xOaAz7jRlp1tvfI+SUlbzeL0OvOHaZg0roy+gsriS+7dzb1SgfVE2+1OvfyQwg0Tfz3zkmgGNMekpPpJ3QjtacYr5bBHWHb6FgyutAVIYw8UR3X+1GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cf1iMw/2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730184467; x=1761720467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N8huXnUZLrC9Lnf0tE8yV/oXO9tA6YtQa8mRhHRnyU8=;
  b=cf1iMw/25+h+UyX+k1Q3Voum6Pdsp21C1vXF3Ty2nbA7T1Udj3kUr+tt
   ItyQV86G0aCHav8nt57mPsCOUsBfZ8IA6Rgm3YIFzwHvEbANRhgxjgP7v
   4rODn7aReaWmeka+cliLvP8CkP9cVrzIZ/ist8+0xDGVf2/Qlje57UN4y
   +Ux44iUWAS/TXhywRQ5nKlae6wz34qFd0nk1VUeRVVwKSAvD3TWIFM887
   Hu4rb2ki9pTHHDn3llszCtWpzOrBQTQXDuF2OfV4JkOpK1ncFFgeYziRc
   81OPRtNvLzj7euCWsKPNqgkP8duTCNZWmZ1p6kge4RD/xxr0HD5tTSXr4
   g==;
X-CSE-ConnectionGUID: cAvQGOSzQtaKhQNUQQ2RUA==
X-CSE-MsgGUID: 2JHh3yj3RX2gDMa5Pf2Dww==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33505602"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33505602"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 23:47:47 -0700
X-CSE-ConnectionGUID: XfmFOwb2Qji+iHimGIvHZA==
X-CSE-MsgGUID: +BVDzVOqQvm6mAO/g05bWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81763147"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 28 Oct 2024 23:47:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5g11-000dLK-02;
	Tue, 29 Oct 2024 06:47:43 +0000
Date: Tue, 29 Oct 2024 14:47:13 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next 03/12] net: homa: create shared Homa header files
Message-ID: <202410291412.HRZPPCyF-lkp@intel.com>
References: <20241028213541.1529-4-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-4-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241029-095137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241028213541.1529-4-ouster%40cs.stanford.edu
patch subject: [PATCH net-next 03/12] net: homa: create shared Homa header files
reproduce: (https://download.01.org/0day-ci/archive/20241029/202410291412.HRZPPCyF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291412.HRZPPCyF-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-19/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wformat-overflow -Wformat-truncation -Wenum-conversion W=1 --keep-going LLVM=1 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
>> ./net/homa/homa_impl.h: 24 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 423: need linux/version.h
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

