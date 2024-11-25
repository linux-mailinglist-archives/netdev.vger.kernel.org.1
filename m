Return-Path: <netdev+bounces-147268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D79D8D03
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9723328BB24
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 19:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0C1BC07A;
	Mon, 25 Nov 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jyc3siZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A31B219D
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564206; cv=none; b=MUYxQi8XSL+l5t2NRCY3Tp2CjyaJOjBcS50xcTksNRGFb1QLgSjWa7rIIsaR3Bl1FDRK4PviOAQX5rwyVn0eYd4RPGlK44K9mTNvYSNdc5hhKPx7FUVxp84rHrUsjKK2i2nYv9Zmj4rea/AU44jA0zG4CEGxVrphGK2VbcSbaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564206; c=relaxed/simple;
	bh=eIiYQ4jnzBdQyrkKuNAWz+i1Uvp5ruD/Vaojtp/eYus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsAtJ3d7ipt7MczWfOe42NCPirHvhvpX1OLmqXsquEm/PXpAZL2dOFGjpgyNLlS5ClB+Pm0LiQsVpTSDIGAJFXXXT6seowd40DvaPLGRfgjMEVFnfJcFZGzFkKOXLpQ/V8m6UIQJtckgla4rJDWN60tin8FS+92jxjbntR8GoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jyc3siZJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732564205; x=1764100205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eIiYQ4jnzBdQyrkKuNAWz+i1Uvp5ruD/Vaojtp/eYus=;
  b=Jyc3siZJMqLoFCW5hwi7biR5vQk0yzCzjD0eXCdisI6JdmOluy+xew8i
   LJ+dCPQJAgdffA+7F+wQIEXVm4MRhMguifT0vabjVKMpanRAZKhN4Xbc+
   ithsmHx9qygVHryfdqb1aPMQAv1qLY81m1XMt114iLE8XkVw9kpaTAaQs
   LAWuthN5xOhQi/z77nmepYJFJscZ/d7wSJUBsEl3ORiQDBRxifbFcmjSD
   G/+YDLPO0NWQ8NVrN6sxJbpMvhe+GEEgCwqjH721BGuVsUV8GMzjQmlSL
   tdAo60drZUaYnm3d/3NsUqrZy92HnLtn0RgRGjPZotAdTZ0fmU4a6i9VA
   g==;
X-CSE-ConnectionGUID: H2gEs4beRCehH0yMbU3sEQ==
X-CSE-MsgGUID: 54e2Azb1RAWAM5tch2/htw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="35542784"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="35542784"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:50:04 -0800
X-CSE-ConnectionGUID: nNjCuwByS6OG4ynDzKqrOQ==
X-CSE-MsgGUID: vJNEZF/UQ36CXITpa14Bjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="114634706"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2024 11:50:02 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFf5r-0006k1-2U;
	Mon, 25 Nov 2024 19:49:59 +0000
Date: Tue, 26 Nov 2024 03:49:19 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: Re: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
Message-ID: <202411260343.02pIupsk-lkp@intel.com>
References: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/ipmr-add-debug-check-for-mr-table-cleanup/20241125-104108
base:   net/main
patch link:    https://lore.kernel.org/r/23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni%40redhat.com
patch subject: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
config: arc-randconfig-001-20241126 (https://download.01.org/0day-ci/archive/20241126/202411260343.02pIupsk-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411260343.02pIupsk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411260343.02pIupsk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv4/ipmr.c: In function 'ipmr_can_free_table':
   net/ipv4/ipmr.c:363:46: error: 'struct netns_ipv4' has no member named 'mr_rules_ops'; did you mean 'rules_ops'?
     363 |         return !check_net(net) || !net->ipv4.mr_rules_ops;
         |                                              ^~~~~~~~~~~~
         |                                              rules_ops
>> net/ipv4/ipmr.c:364:1: warning: control reaches end of non-void function [-Wreturn-type]
     364 | }
         | ^


vim +364 net/ipv4/ipmr.c

   360	
   361	static bool ipmr_can_free_table(struct net *net)
   362	{
 > 363		return !check_net(net) || !net->ipv4.mr_rules_ops;
 > 364	}
   365	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

