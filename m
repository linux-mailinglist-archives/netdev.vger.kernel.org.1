Return-Path: <netdev+bounces-165123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EBA308ED
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10383A6990
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CFA1F8917;
	Tue, 11 Feb 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F73yxb8X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5471F868C
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270518; cv=none; b=huO/I/oYuWHeAhJWjY2gy9Ap/45txBuSq3Ku5E51Zr/x3J8h3hmEcqMbee5BAnD1knOAvRlVMe+b2rMIAvx78e82tdefbwdv5HrZTvs4NFwKMne5WJyUITxTM7PaqZ9dqCoAZuKcjQiHwrdvwXJwyvVzH64r0hIwKCLffown0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270518; c=relaxed/simple;
	bh=5rTaqC26aI6wSJF/+cWaMWP95+stJL5KOnV1Y+y3Iio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u09vBpDbeuqcbB9PX741JVNnihY18xX6BEL0quEn4P+NaXhlYMQ1F9qvjaSatXBwgIBuh3DJraPp3XvsUIfJJQCT98Mea4ZvlX0d6tJF6lh10rC24+5xMzokIrzJRRSPMkFqzbF9nnNuXI4JFRG84029Vmcih9l9+uPcHlMJV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F73yxb8X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739270515; x=1770806515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5rTaqC26aI6wSJF/+cWaMWP95+stJL5KOnV1Y+y3Iio=;
  b=F73yxb8XGe6H2wFmHkuZ+K9IhtewOauhNZfgaeGpqkouj0RjPquatJBs
   +APW6FNJ9K81rw0e2IKwdIKB7QdI1/sZqUT6Ex2zVIGCv9XuL1ESAKK6i
   LFUuNZGT5t/rdEUlq4/qgrsRlkaEdxIBIaDDRUzXKKBTTrUjGY0wKrt1L
   hQFkboLbTlpjmOsCZ0S/4GOg5Twlq7FSfHjoCicdHulkbqGzGdfTW+qIH
   qUZZ6PSiN3oPC6ILu/nM50Zh+Bb+1hsVUCv+hVHIpaijDSJUwTVx/MV86
   2IhVXKye82TJ2IptrxxTW4rRIkbCvHkXoFMWO/Ydi81F7JXjnjyoDbwx4
   A==;
X-CSE-ConnectionGUID: 5doxKp25SH+wR4MMydFGZQ==
X-CSE-MsgGUID: pfPTdSEyQ0m+LvkC7Gt/FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57292564"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="57292564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 02:41:55 -0800
X-CSE-ConnectionGUID: AfcpU+k8Q9CZE4TNKDJZgg==
X-CSE-MsgGUID: 5we3FFoVSZCnarUHr+V71A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="112989076"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Feb 2025 02:41:53 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thniA-00142V-2m;
	Tue, 11 Feb 2025 10:41:50 +0000
Date: Tue, 11 Feb 2025 18:41:01 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next 09/11] net: dummy: add dummy shaper API
Message-ID: <202502111855.5U4I6OK5-lkp@intel.com>
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
config: i386-randconfig-013-20250211 (https://download.01.org/0day-ci/archive/20250211/202502111855.5U4I6OK5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250211/202502111855.5U4I6OK5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502111855.5U4I6OK5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/dummy.c:129:10: error: 'const struct net_device_ops' has no member named 'net_shaper_ops'
     129 |         .net_shaper_ops         = &dummy_shaper_ops,
         |          ^~~~~~~~~~~~~~
>> drivers/net/dummy.c:129:35: error: initialization of 'int (*)(struct net_device *, struct netdev_phys_item_id *)' from incompatible pointer type 'const struct net_shaper_ops *' [-Werror=incompatible-pointer-types]
     129 |         .net_shaper_ops         = &dummy_shaper_ops,
         |                                   ^
   drivers/net/dummy.c:129:35: note: (near initialization for 'dummy_netdev_ops.ndo_get_phys_port_id')
   cc1: some warnings being treated as errors


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

