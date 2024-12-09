Return-Path: <netdev+bounces-150029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E291E9E8A77
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E099280C57
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 04:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A35F194AFB;
	Mon,  9 Dec 2024 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkxUamp7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C755192B95;
	Mon,  9 Dec 2024 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719423; cv=none; b=fhEdCZhWfWrzpiTdUQIOHQVCoJS7zvlxJDvZUt+675/XJG16Lrc0RewOi1OMDWsTshEWGofa+LbZReI+YJvLTqDLjmAUzJqCngckW2LuWtps0qKJbAR/Xf0RyVzyz5dUWtpnT2FXogLmNreDgswgnwbeR+lsQRjZfMJ1t55LpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719423; c=relaxed/simple;
	bh=CnZh5PzuBjSJ5i81gB2eROtQAtISkclOyWpu/tX4BSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF11JFlVE9KYn4SQm2ARh7mHJR1kWhj8ozlpCp+B1Soakp3ay9tg4cN0hIb+008eCU4UJ8HIz7gk3d8VEaw2Ijh4CVOEWftZ5OCCc0C8eTEXpOPNiDHm+99YQfS9pCoOyqCV27JK0F9kk8UaLnWhz+UhZnsu3LJdi4+ly7HHHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkxUamp7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733719421; x=1765255421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CnZh5PzuBjSJ5i81gB2eROtQAtISkclOyWpu/tX4BSo=;
  b=mkxUamp7W5uZwAWSTedbL/CIf+9Vag+34C4DQbFdpmxLWibXW68EezRq
   e87WCC3RjGLZaVPcmSwNVoFh0YY8/+lxNFQGh2RJdG7yrPzXfAOKVBiT0
   cPEdcugeYZU0bffLUVcjFEFESkUqbnsszcnTxGztcR7tXKO/2mm+rGCoj
   KaiDCooagRn48Rk6N6JbxERpMvVdxfxjK4BF+wJumf+05tjc1oJScIyoi
   /R7ReVOE442CxptQoSn6kJFdF/IRrLgXGBbU8oAjn8BeTiknuxCAdECVP
   KWnyC77147Vy5vGkuX1TGKDt+C1WWk2Q7a2wsAW4xIWGPexLBWz/JcPwZ
   g==;
X-CSE-ConnectionGUID: rIyS9NjeSTmY8aemQm1pqg==
X-CSE-MsgGUID: fjwn4/KKSvu3syxxYWcMtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="33348882"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="33348882"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:43:39 -0800
X-CSE-ConnectionGUID: Flp2HtyeTY66gH19/gozDg==
X-CSE-MsgGUID: brSxjW+KShqcUGtJAxw2Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99995074"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Dec 2024 20:43:34 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVcJ-0003u3-18;
	Mon, 09 Dec 2024 04:43:31 +0000
Date: Mon, 9 Dec 2024 12:42:57 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v10 8/9] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
Message-ID: <202412081353.I0203taL-lkp@intel.com>
References: <20241208002105.18074-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208002105.18074-9-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvmem-Document-support-for-Airoha-AN8855-Switch-EFUSE/20241208-082533
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241208002105.18074-9-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v10 8/9] net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20241208/202412081353.I0203taL-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412081353.I0203taL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412081353.I0203taL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/an8855.c: In function 'an8855_switch_probe':
   drivers/net/dsa/an8855.c:2227:34: error: invalid use of undefined type 'struct platform_device'
    2227 |         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
         |                                  ^~
   drivers/net/dsa/an8855.c:2231:26: error: invalid use of undefined type 'struct platform_device'
    2231 |         priv->dev = &pdev->dev;
         |                          ^~
   drivers/net/dsa/an8855.c: In function 'an8855_switch_remove':
   drivers/net/dsa/an8855.c:2282:57: error: invalid use of undefined type 'struct platform_device'
    2282 |         struct an8855_priv *priv = dev_get_drvdata(&pdev->dev);
         |                                                         ^~
   drivers/net/dsa/an8855.c: At top level:
   drivers/net/dsa/an8855.c:2295:15: error: variable 'an8855_switch_driver' has initializer but incomplete type
    2295 | static struct platform_driver an8855_switch_driver = {
         |               ^~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2296:10: error: 'struct platform_driver' has no member named 'probe'
    2296 |         .probe = an8855_switch_probe,
         |          ^~~~~
   drivers/net/dsa/an8855.c:2296:18: warning: excess elements in struct initializer
    2296 |         .probe = an8855_switch_probe,
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2296:18: note: (near initialization for 'an8855_switch_driver')
   drivers/net/dsa/an8855.c:2297:10: error: 'struct platform_driver' has no member named 'remove'
    2297 |         .remove = an8855_switch_remove,
         |          ^~~~~~
   drivers/net/dsa/an8855.c:2297:19: warning: excess elements in struct initializer
    2297 |         .remove = an8855_switch_remove,
         |                   ^~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2297:19: note: (near initialization for 'an8855_switch_driver')
   drivers/net/dsa/an8855.c:2298:10: error: 'struct platform_driver' has no member named 'driver'
    2298 |         .driver = {
         |          ^~~~~~
   drivers/net/dsa/an8855.c:2298:19: error: extra brace group at end of initializer
    2298 |         .driver = {
         |                   ^
   drivers/net/dsa/an8855.c:2298:19: note: (near initialization for 'an8855_switch_driver')
   drivers/net/dsa/an8855.c:2298:19: warning: excess elements in struct initializer
   drivers/net/dsa/an8855.c:2298:19: note: (near initialization for 'an8855_switch_driver')
   drivers/net/dsa/an8855.c:2303:1: warning: data definition has no type or storage class
    2303 | module_platform_driver(an8855_switch_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2303:1: error: type defaults to 'int' in declaration of 'module_platform_driver' [-Werror=implicit-int]
>> drivers/net/dsa/an8855.c:2303:1: warning: parameter names (without types) in function declaration
   drivers/net/dsa/an8855.c:2295:31: error: storage size of 'an8855_switch_driver' isn't known
    2295 | static struct platform_driver an8855_switch_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/an8855.c:2295:31: warning: 'an8855_switch_driver' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +2303 drivers/net/dsa/an8855.c

  2294	
  2295	static struct platform_driver an8855_switch_driver = {
  2296		.probe = an8855_switch_probe,
  2297		.remove = an8855_switch_remove,
  2298		.driver = {
  2299			.name = "an8855-switch",
  2300			.of_match_table = an8855_switch_of_match,
  2301		},
  2302	};
> 2303	module_platform_driver(an8855_switch_driver);
  2304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

