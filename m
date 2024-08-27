Return-Path: <netdev+bounces-122201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E858C9605C0
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C1D284E91
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4575619DF59;
	Tue, 27 Aug 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbLLNd9/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4119DF5C;
	Tue, 27 Aug 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751436; cv=none; b=i3/mx5ikMqoM1K8avGRT6xbtDrZU5iy+BS7v+BkZ0xf/NG8pyDEgk8r8OW1leTMMSnpNTUK5y3JmEvznpLTTnKDVvCI1LGHM9sert5nRVS4tGdX9zJEQu8WThplLjJoRYqU0BEa6UaZ96TBk2/JLSyHQyr7Jbn2RD8T7rug47SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751436; c=relaxed/simple;
	bh=fIUOVedot9IeaESAjfIzsPX/QunqKG3XqRU7QX9msjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FND3mkFWLaSLVx82m3+w6b0ufk3arkoEOSNCECJ24eclKcpJBt0nPagxfL82v7XJadXRaZyuhB/Dt+kUqKQutn0awch5yn9CFz4LtV0NrPKtKBnrBEfJdHD8ZDjmEtJ58f15+IZ3lLVX8vmtCSYsC7wM4lRQthzIdI2TWQmqwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbLLNd9/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724751434; x=1756287434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fIUOVedot9IeaESAjfIzsPX/QunqKG3XqRU7QX9msjU=;
  b=FbLLNd9/Iga7nuJ85sYeL1CWJaELTCfb8shZR60BTJjH0R9tJgL5CLqa
   FgQs5rfn9qdV8kyvemleJq5DjZeFYoXBHlAPChBx7ON3dT5iFz6tpO5MC
   BBccyb8p+tihuhogvuLKPJyvuH9jXKt6LUWpItJMMmAhjsiLK+GN5OLU9
   UiJdpuu5JZQLLxZuE4MjmK4YhjaGVBiZmFL2OA1lD9JY/NykF8JJZ1qzw
   ydBdy3laxRSE0bBE0q5W/do5PFx3ecQiuOh0mAL4mfst3Ze7T/NmWCP5D
   9j9F3zeIFbqVsqKfE15d49PglI7SCFrguKDuzRAATpEZkdczjIHMexJdn
   A==;
X-CSE-ConnectionGUID: zGLCbJ/7Q6CpHnQeT6AEPg==
X-CSE-MsgGUID: LT/4U2/IQ1msPx6jrD4Udw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23377726"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23377726"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:37:14 -0700
X-CSE-ConnectionGUID: Y3S4DTg+R5Wqfj+T4JjJaA==
X-CSE-MsgGUID: LPh9aVcORPSKtq6sP2WCwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62501975"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2024 02:37:11 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sisdR-000IRM-0m;
	Tue, 27 Aug 2024 09:37:09 +0000
Date: Tue, 27 Aug 2024 17:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: Maksym Kutsevol <max@kutsevol.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Message-ID: <202408271711.RhzKTDRD-lkp@intel.com>
References: <20240824215130.2134153-2-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824215130.2134153-2-max@kutsevol.com>

Hi Maksym,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8af174ea863c72f25ce31cee3baad8a301c0cf0f]

url:    https://github.com/intel-lab-lkp/linux/commits/Maksym-Kutsevol/netcons-Add-udp-send-fail-statistics-to-netconsole/20240826-163850
base:   8af174ea863c72f25ce31cee3baad8a301c0cf0f
patch link:    https://lore.kernel.org/r/20240824215130.2134153-2-max%40kutsevol.com
patch subject: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240827/202408271711.RhzKTDRD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271711.RhzKTDRD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271711.RhzKTDRD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/netconsole.c: In function 'stats_show':
>> drivers/net/netconsole.c:340:46: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     340 |         return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
         |                                            ~~^
         |                                              |
         |                                              long unsigned int
         |                                            %u
     341 |                 nt->stats.xmit_drop_count, nt->stats.enomem_count);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~     
         |                          |
         |                          size_t {aka unsigned int}
   drivers/net/netconsole.c:340:58: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     340 |         return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
         |                                                        ~~^
         |                                                          |
         |                                                          long unsigned int
         |                                                        %u
     341 |                 nt->stats.xmit_drop_count, nt->stats.enomem_count);
         |                                            ~~~~~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     size_t {aka unsigned int}


vim +340 drivers/net/netconsole.c

   335	
   336	static ssize_t stats_show(struct config_item *item, char *buf)
   337	{
   338		struct netconsole_target *nt = to_target(item);
   339	
 > 340		return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
   341			nt->stats.xmit_drop_count, nt->stats.enomem_count);
   342	}
   343	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

