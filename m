Return-Path: <netdev+bounces-144384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A3F9C6F03
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 13:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FEA2B2D094
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6255201002;
	Wed, 13 Nov 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKymMy5E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2792200C94;
	Wed, 13 Nov 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499154; cv=none; b=NgV79PZ4mLg6nBHVtWpfU90SDjdYUvdQSPh0yqWGOJtAnU02zjBbE35SupfPt8B1VVxgA5mUNBZU1G++7UnI1yFOn9kF6TzxTTRD8SuQuV7ywtVDwXfIinSU+jZKEETTPaCNlsIu1KD5LlhYhp3cLDJVbSUKNHhIXuUry/i/SrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499154; c=relaxed/simple;
	bh=S2yXI+RpE/4Z6IIWIoXWreQT7e9SUd1QZeV3E85aBM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdSkrx7w+4YUo9mGtb5hYiJRb0+zVIJcNrmq9ZQxwaPFysR8dPtKhqD4mopZ46jF2uwyoXNbM80rCn/Ll3vLz5WqQi84fwxcq2zgCAwr/ZtymOLAeH9+OsD1q/E4P7CWcSSi+f3m1fBTRJh1tfSR6fGP1CofejV/UHuMTKwYeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKymMy5E; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499153; x=1763035153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S2yXI+RpE/4Z6IIWIoXWreQT7e9SUd1QZeV3E85aBM8=;
  b=MKymMy5EVEqpYpC+dCT4KWJ5GQM2SwaobrVXdbKUFjWBCz5BzSIjJOlu
   szQUsPdf4w4aCPRxTLNudNainTIo+ZYuMdzNOU37mw6ACOccah4cXP2wI
   TqvIeWwECCtBbcgEvLWzBGF7l93f8b4sOAKLZ+2WJrDAnxqT5heaAjhly
   syERIulG6w52UYkCpezgtoqs63OUeYfrvyUEtSBWvkUAtwKPyLotntx3X
   XiiXUbxnbWhTBMD4YnqDg+vel9Ra4RilRAFcBJRGWIFc1R848YbfDOXp6
   hjc019SE1NOlHhLx4ovM5QfZO32E12c0VyM4G0HrXG5RlZ+pthoqT8Nuj
   Q==;
X-CSE-ConnectionGUID: RnN5Be6tSsCk/Vl5mrZdlg==
X-CSE-MsgGUID: PaRj7UwmQ46Hkj+2hi5bxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35314456"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="35314456"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:59:11 -0800
X-CSE-ConnectionGUID: mbuIIPKWTsC2Zo2OOWA+8Q==
X-CSE-MsgGUID: Drm0ljxqRt6tHanbqPmqGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87842391"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Nov 2024 03:59:05 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBC1X-0000Kv-0X;
	Wed, 13 Nov 2024 11:59:03 +0000
Date: Wed, 13 Nov 2024 19:58:08 +0800
From: kernel test robot <lkp@intel.com>
To: Joey Lu <a0987203069@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, ychuang3@nuvoton.com, schung@nuvoton.com,
	yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-nuvoton: Add dwmac support for
 MA35 family
Message-ID: <202411131946.ozq1D0f2-lkp@intel.com>
References: <20241113051857.12732-4-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113051857.12732-4-a0987203069@gmail.com>

Hi Joey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.12-rc7 next-20241113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Lu/dt-bindings-net-nuvoton-Add-schema-for-MA35-family-GMAC/20241113-132300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241113051857.12732-4-a0987203069%40gmail.com
patch subject: [PATCH v2 3/3] net: stmmac: dwmac-nuvoton: Add dwmac support for MA35 family
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241113/202411131946.ozq1D0f2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411131946.ozq1D0f2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411131946.ozq1D0f2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c:20: warning: expecting prototype for dwmac(). Prototype was for PATHDLY_DEC() instead

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +20 drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c

    19	
  > 20	#define PATHDLY_DEC         134
    21	#define TXDLY_OFST          16
    22	#define TXDLY_MSK           GENMASK(19, 16)
    23	#define RXDLY_OFST          20
    24	#define RXDLY_MSK           GENMASK(23, 20)
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

