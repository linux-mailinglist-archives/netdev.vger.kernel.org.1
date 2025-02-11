Return-Path: <netdev+bounces-165214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4AA30FD0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB531886E01
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E9253328;
	Tue, 11 Feb 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpgseeJc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFA253326
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287772; cv=none; b=ayzj02fdpz2j0dAwyZ3jMcpwzhve9kJbtcbyGMQtrnlTXEPk8afDk6Sh67MBmO5sUwBeO9mWsHf/EmLuLaEgF3nRpD2dTfKrCiLruE0MJDN0S3Y5Q77NjugPCbzhxz+O6mp1ilW/rXBdSXjmF5cZWmChg93+nuuZIzyBxhBT8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287772; c=relaxed/simple;
	bh=PNWNqJTookf2zJdQY5NjQf0sRFZT3J703U3R1x7akG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDZCLMz1EMS9SnVIKhiNP3HNLir2CZoBqPipujqSOoo5Nyt54O0dVRHptgL94VSKr3Gcamk/vpbcyTEUH1KafLAMVoSvR91P3owoyJIBofHR3MMo8ps7TzVFCG7X3qVnyxfvZZ49yOI7aVIRm750tKmJMIALpM7Y60M6E6/5JCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpgseeJc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739287769; x=1770823769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PNWNqJTookf2zJdQY5NjQf0sRFZT3J703U3R1x7akG8=;
  b=LpgseeJcmF8DV+uUN3+X/QQDKOfic+OOYTfBgUlWHqwTtzCk+JOVDWQA
   +x7gfMpq+aQ7BdPyT35kKVs1IdIXatz+ZrJe6Qt8ofLGDiW3RGbYVR+Iv
   8Qzbni2JxZ1A3JG7z4aKbQxUPN0o2lhU+Pts3LIrG+rKlCTnY+h2++kcR
   IPPud043hGGTjPQd7HSRQGa0p6uAic9fDkZxyz8NqqF3ZduXRj8OAx9/H
   QUMa5D75aZtu+yXpMHAUtqGPTplYAN5nj01mj8yiPQVStHcaVAnGEGGeW
   3LHNDfR6/BCYZRvu5aVErxeNJ+couaERfdbNgNdYHxpiY01JA6hNLz4o9
   g==;
X-CSE-ConnectionGUID: p9O7xte7Sxi+rxRx1mexEA==
X-CSE-MsgGUID: C4DzvRJpSCOgYAnJCd9BZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39774231"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="39774231"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:29:28 -0800
X-CSE-ConnectionGUID: XBQET5EgS8i8G2g4EeJYiw==
X-CSE-MsgGUID: 3UwGCSJoRsGqlX2ylzGogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="143398363"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Feb 2025 07:29:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thsCR-0014MF-2z;
	Tue, 11 Feb 2025 15:29:23 +0000
Date: Tue, 11 Feb 2025 23:29:00 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 09/11] net: dummy: add dummy shaper API
Message-ID: <202502112354.4t60yYpw-lkp@intel.com>
References: <20250210192043.439074-10-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210192043.439074-10-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-hold-netdev-instance-lock-during-ndo_open-ndo_stop/20250211-032336
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250210192043.439074-10-sdf%40fomichev.me
patch subject: [PATCH net-next 09/11] net: dummy: add dummy shaper API
config: i386-randconfig-001-20250211 (https://download.01.org/0day-ci/archive/20250211/202502112354.4t60yYpw-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250211/202502112354.4t60yYpw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502112354.4t60yYpw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/dummy.c:129:3: error: field designator 'net_shaper_ops' does not refer to any field in type 'const struct net_device_ops'
     129 |         .net_shaper_ops         = &dummy_shaper_ops,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +129 drivers/net/dummy.c

   120	
   121	static const struct net_device_ops dummy_netdev_ops = {
   122		.ndo_init		= dummy_dev_init,
   123		.ndo_start_xmit		= dummy_xmit,
   124		.ndo_validate_addr	= eth_validate_addr,
   125		.ndo_set_rx_mode	= set_multicast_list,
   126		.ndo_set_mac_address	= eth_mac_addr,
   127		.ndo_get_stats64	= dummy_get_stats64,
   128		.ndo_change_carrier	= dummy_change_carrier,
 > 129		.net_shaper_ops		= &dummy_shaper_ops,
   130	};
   131	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

