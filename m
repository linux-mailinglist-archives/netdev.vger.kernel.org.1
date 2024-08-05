Return-Path: <netdev+bounces-115643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B04947570
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9421F217D7
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E949F1448EF;
	Mon,  5 Aug 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1BYl6xT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F713D539
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722840026; cv=none; b=lPgWoOfQs7nKrrR350uehE0gVHeQGzNDej3M4fF0mbpOZlPJPu0OHzPQbs3bP5kcEKXf20hXhwjOwAJnw2olbneaxYTamuSGSuh/svJ0fRfkWbhEhH+GeBouMBtgYmPxVfH0HmzbG7AVbKsZ5t/pioOrAfnFLkbQmNvjmYu3bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722840026; c=relaxed/simple;
	bh=Hc0DKJ+K/2FIRa7TAVEZH9jo99UD0sZM1KT8VTALwmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql4/9fFLzGREWtNvGdRjAKH39ooWVxUyuFki6rhBDAg8/xPilVH8o1ooHlJCmZM+/DHGwtnMGV5YMuge+F1dSaRTyZ1gNaNkOpZ9kqT4e9t9k7f617xDTBxromfGwC4Xga7hrdJv8TCpXvCIcBZcinp++59LGCbcHGRDBGDk0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1BYl6xT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722840025; x=1754376025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hc0DKJ+K/2FIRa7TAVEZH9jo99UD0sZM1KT8VTALwmo=;
  b=P1BYl6xT/WI/Krm7FxL3NySrtPkP9yrT263sZz/j948jQ+nUuZtZVwGB
   rxAs7rLR4nTO3bmi8Y2b2aqnXFBJkGhAIC7/Yabm/eT1R63Bh5IpS6BE3
   zC6iFPF86MSUPm6h8a836H+TAv/UdXt0gJRVikwNmxR91ivhYvjcg10IC
   wwXaAtZ9GZiAjl/t0jGuFgKwjVEQ/9Bs1i+9wAWOoeTB9VC+d6y6bNCW7
   6FsL1i+ciGxLz9ZH+F0nO05PZvI4v1EUjB/JPkxrnqVMfbITBL/ZgwOQ1
   I2Xqam5APTwcR1Ups/Fe/tb/OlhD0/kixzqQiWjwwHlZNeymQUkio4Xfc
   Q==;
X-CSE-ConnectionGUID: FCk+gglVToyQl1V0sQwyPw==
X-CSE-MsgGUID: uww0fIBPTNme89EOXSP3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31412944"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="31412944"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 23:40:24 -0700
X-CSE-ConnectionGUID: OJKOyiOOQuCW1Mrta3Ls3A==
X-CSE-MsgGUID: phGUJvFGRE2GaG6YLmaXfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="60429873"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Aug 2024 23:40:23 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sarOD-0001kq-2E;
	Mon, 05 Aug 2024 06:40:18 +0000
Date: Mon, 5 Aug 2024 14:40:00 +0800
From: kernel test robot <lkp@intel.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 07/10] net: libwx: allocate devlink for
 devlink port
Message-ID: <202408051455.A9boD1Oe-lkp@intel.com>
References: <5CCBD90FF2823C29+20240804124841.71177-8-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CCBD90FF2823C29+20240804124841.71177-8-mengyuanlou@net-swift.com>

Hi Mengyuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mengyuan-Lou/net-libwx-Add-sriov-api-for-wangxun-nics/20240804-214836
base:   net-next/main
patch link:    https://lore.kernel.org/r/5CCBD90FF2823C29%2B20240804124841.71177-8-mengyuanlou%40net-swift.com
patch subject: [PATCH net-next v5 07/10] net: libwx: allocate devlink for devlink port
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240805/202408051455.A9boD1Oe-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408051455.A9boD1Oe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408051455.A9boD1Oe-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_free':
>> wx_devlink.c:(.text+0x58): undefined reference to `devlink_unregister'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0x6c): undefined reference to `devlink_free'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_create_pf_port':
>> wx_devlink.c:(.text+0xa0): undefined reference to `priv_to_devlink'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0xfc): undefined reference to `devlink_port_attrs_set'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0x110): undefined reference to `devlink_port_register_with_ops'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_destroy_pf_port':
>> wx_devlink.c:(.text+0x174): undefined reference to `devl_port_unregister'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_create_devlink':
>> wx_devlink.c:(.text+0x2a0): undefined reference to `devlink_alloc_ns'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0x2d4): undefined reference to `devlink_unregister'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x2dc): undefined reference to `devlink_free'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0x304): undefined reference to `devlink_register'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0x31c): undefined reference to `devlink_priv'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_create_vf_port':
   wx_devlink.c:(.text+0x354): undefined reference to `priv_to_devlink'
   loongarch64-linux-ld: wx_devlink.c:(.text+0x3d0): undefined reference to `devlink_port_attrs_set'
>> loongarch64-linux-ld: wx_devlink.c:(.text+0x3e8): undefined reference to `devl_port_register_with_ops'
   loongarch64-linux-ld: drivers/net/ethernet/wangxun/libwx/wx_devlink.o: in function `wx_devlink_destroy_vf_port':
   wx_devlink.c:(.text+0x47c): undefined reference to `devl_port_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

