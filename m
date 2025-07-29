Return-Path: <netdev+bounces-210751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A2B14AC5
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 11:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20BF4E66FC
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B718286D46;
	Tue, 29 Jul 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEu1qoJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94858276052;
	Tue, 29 Jul 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780084; cv=none; b=lIESNbALcINStzr/qCsyGFjGIx9lCF36isot3s3DbqoMag2HszE8OO585FX6P/xceuGLAeiVxtu2SEMpbMVHkMMgXZg59Pg694Xg1/tO5tJaO9C5n/46Pw3OY5RXXnf6iL7AvAtOtR3YcTawNztuXLlIyay8HUWC4wLVyZDHd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780084; c=relaxed/simple;
	bh=u5UpzlLxjeFXPtPFg0oC+Cw7TMJczCQeJysGpqVrRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHtQz2t8f7Rh7D0aWmbNDh7JzwbAt/JaH3NEi/Jl9254z3NueYveeDejeiBwl8m7aZDkHAxX9T0zgcsrA6USa9MvrD9BgShhlV+agw9/oLbiymIcVdk+mRpoV+3wJitKEUlIsIX/w9XxF82/8Ryo2EgTyluDRKPJMwcd3bzTQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEu1qoJZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753780082; x=1785316082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5UpzlLxjeFXPtPFg0oC+Cw7TMJczCQeJysGpqVrRZ0=;
  b=JEu1qoJZojJkYKR8CJtzAYw0qOtPV24t5sFc9Wz3Fc/GOkGJdwSXvYP2
   j07WWp6398J48UAItDCYuWlQ+2dlsfuAmsPqK/jnoVWF4WXlZb6qdOxHK
   6+3EMDQ5oC1QsFbMrX5uuaj/c6S8V4teFUMQJG635Sgr+OrLseGI7g/6n
   LS6h7o26bxViYJ+YTwK1fdsdwcSwJWpOO52X+48JKe2B21AZV1J1ZNDzt
   GMUjgVdhb5Vfnx2gQLEsLTzoh1RF9pNfRNmk5QkeltBDDcSkCp7Edd08y
   UpYj7fqqWFPsB6y+rR9a4KlHDMYnTVQEoHTLk4Ng0CWczqjwhdDDqFeSp
   A==;
X-CSE-ConnectionGUID: KTT8cbuhRXyTwpVvXBmASg==
X-CSE-MsgGUID: t/YSdtnDSlGEHqlUlW/KXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55980645"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="55980645"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 02:08:02 -0700
X-CSE-ConnectionGUID: UaZkfoxbTzCUs4LYJLaVgw==
X-CSE-MsgGUID: fbz7WF3LRPeOZWk5gKRMuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="162360902"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Jul 2025 02:07:59 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uggJP-00018v-1v;
	Tue, 29 Jul 2025 09:07:55 +0000
Date: Tue, 29 Jul 2025 17:07:11 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <monstr@monstr.eu>,
	linux-arm-kernel@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH net-next v3 3/7] net: axienet: Use MDIO bus device in
 prints
Message-ID: <202507291640.Zr1m8oli-lkp@intel.com>
References: <20250728221823.11968-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728221823.11968-4-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/net-axienet-Fix-resource-release-ordering/20250729-062108
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250728221823.11968-4-sean.anderson%40linux.dev
patch subject: [PATCH net-next v3 3/7] net: axienet: Use MDIO bus device in prints
config: arm-randconfig-002-20250729 (https://download.01.org/0day-ci/archive/20250729/202507291640.Zr1m8oli-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507291640.Zr1m8oli-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507291640.Zr1m8oli-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c:172 function parameter 'bus' not described in 'axienet_mdio_enable'
>> Warning: drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c:172 Excess function parameter 'lp' description in 'axienet_mdio_enable'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

