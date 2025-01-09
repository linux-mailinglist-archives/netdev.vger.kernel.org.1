Return-Path: <netdev+bounces-156832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761CAA07F24
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30053A6D6C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD291B0421;
	Thu,  9 Jan 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJX8iyrc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA01B0412
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736444567; cv=none; b=BHTZJQwjNvmiZy5R5V7eHtsUekar2JW6c+OblWWavqoQPYJF8pi47B2Qw64PlPx1HiuFLDxTCmCb20AUcCG7TIF6dopxWhyKVkyUTGg+Uqv6oIk1bK8M2EQJ/KYgGoJbcmJtLKPwEoHr6au9I6ifiDY2RX0OYiXjYdJMG6lOj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736444567; c=relaxed/simple;
	bh=TPi1jWgepqP30sAUxR/sHKQYrWqP6iP8Nn9Nr2Bpx28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozXqZs9O2thKSspUAKGdY8GQI12K0Bf0Fc6fekWFh52CUPQQMAeRG5hWdiGzRsduHsbo3YJCaoATgt8LaQCXzdEjHbhwWeHxRHQE+gMYur9U+e+sgX9S5jem6P47Ihfjnfb9fgCp68wgatawUnGZ4Q84m6TQGJjyzaQ+iXlvC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJX8iyrc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736444566; x=1767980566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TPi1jWgepqP30sAUxR/sHKQYrWqP6iP8Nn9Nr2Bpx28=;
  b=gJX8iyrc9Bm4vCi7HPQTviMMNLEnHi4NZeQP3nzkYOqLZwXp8+S7QL74
   PltALxFpgJ6ArIBVzo7xRZqAPkTgw4ScNV0BiR3BTnSy3oBmoagNLC+0d
   1s25QkhScC2jWWJRO5mvAAhA6hn/FbHRZ7qJnVSAFCtdVAhAol75c2m9s
   WdIUwk5Bw/Cxhh7MTkbD0rngskwNOttH0qzhGVSNqTn1YhkdmPgV4SQFq
   8CXXREoO9BZ4movPtjHkWIqKrw49VSjQvj9xaB69BFV6JFNCgntrS7lgv
   +MBGb2RIMidhbncTAhr04uWXxWOwh03KgayMzKOgiCsnjiL6jAKvrZ1Zb
   g==;
X-CSE-ConnectionGUID: L5St/X5xSoaQqWLdJ0keVg==
X-CSE-MsgGUID: 4wNWUMPlTzamXucxb0LBmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36602364"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36602364"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 09:42:45 -0800
X-CSE-ConnectionGUID: weaQC6DFSMajJlFHvc8ucg==
X-CSE-MsgGUID: 9lzX1tdbTlKV9fM1+9bZIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126759246"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2025 09:42:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVwYL-000HwV-10;
	Thu, 09 Jan 2025 17:42:41 +0000
Date: Fri, 10 Jan 2025 01:42:01 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] net: expedite synchronize_net() for
 cleanup_net()
Message-ID: <202501100127.LhRwhYMs-lkp@intel.com>
References: <20250107173838.1130187-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107173838.1130187-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-no-longer-assume-RTNL-is-held-in-flush_all_backlogs/20250108-014049
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250107173838.1130187-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] net: expedite synchronize_net() for cleanup_net()
config: mips-bmips_be_defconfig (https://download.01.org/0day-ci/archive/20250110/202501100127.LhRwhYMs-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250110/202501100127.LhRwhYMs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501100127.LhRwhYMs-lkp@intel.com/

All errors (new ones prefixed by >>):

   mips-linux-ld: net/core/dev.o: in function `synchronize_net':
   dev.c:(.text+0x2250): undefined reference to `cleanup_net_task'
>> mips-linux-ld: dev.c:(.text+0x225c): undefined reference to `cleanup_net_task'
   mips-linux-ld: net/core/dev.o: in function `free_netdev':
   dev.c:(.text+0x5824): undefined reference to `cleanup_net_task'
   mips-linux-ld: net/core/dev.o: in function `netdev_rx_handler_unregister':
   dev.c:(.text+0x6204): undefined reference to `cleanup_net_task'
   mips-linux-ld: dev.c:(.text+0x620c): undefined reference to `cleanup_net_task'
   mips-linux-ld: net/core/dev.o:dev.c:(.text+0x6764): more undefined references to `cleanup_net_task' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

