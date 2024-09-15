Return-Path: <netdev+bounces-128384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F002097945E
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6908B1F230C8
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 02:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC11FDD;
	Sun, 15 Sep 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7qhRKc7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3418D;
	Sun, 15 Sep 2024 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366653; cv=none; b=qLJbsjXIal9wPgDKu0wmRiI/N3zTdcOvCrvBWiIOcV5vmLv3bXOJNNBxQAEJ01VafZm2JvnmMciEBE+BGtZxKrvyenRGpt3Vlsq22W2n0ZmvGWSVqR79SEWJUD0DLVze7O8ToBJSCtlWBDtpusbcLBI7LUBiWxt+6NKcpmSRpVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366653; c=relaxed/simple;
	bh=Cu9oogNUDp0JyK3aZ5kSKAt7MkSWd0QBhKX3Dlldovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR3Y9zAFF1Gvo+/c3mO8ZkMVTaLAop6sTLEILz+k6dIIKCwFdQ3Ucs6s6SniLF9CWCiAWJVF8+uwKYQjmzM7stLUrnQxxADMPORkXgyqElhlnYHw6+ZFvRuAW5M8OTYkNLYU0QArJSxh7Dcvw/Ppar681ZYqp82n/XcG5JEqxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7qhRKc7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726366652; x=1757902652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cu9oogNUDp0JyK3aZ5kSKAt7MkSWd0QBhKX3Dlldovw=;
  b=R7qhRKc7fpzgotfGvmFF4/GpZJHUB9vHbD/dH3TaPSqR/rrDu/AcVKm6
   men4O8z5pUFXGp1WgLqfbwA9sAh5KUZKGh8IE/aO2lPnFRp75DMws5Vsf
   1tbtE5+opeWJJnemEOMSGNqEL7E4PPQJ+Y+p/bDS6zNmyAx2TMX758O/n
   Ss7MQSpeTgVaxtwhHslD6tXngIGmX5jxz94QdxmWSpYGs/57ihb119pSo
   VP28M+4pSDRVwTDR+CbZVjNDHa5mbUUlpE1q9sPJCs0JcC1T7HbYXsgda
   XKYlzeUw7P1EhCqvL1OV9g0Qi6oHFic+72QAMf4hXIeScKHCRtBgTuDXj
   A==;
X-CSE-ConnectionGUID: Wlv2Fn/PQA2EgP99glS2tA==
X-CSE-MsgGUID: cfjUHxunSomgzani2vJIiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25171852"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25171852"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 19:17:31 -0700
X-CSE-ConnectionGUID: yIV5O7oxSyCqb9SiViWT1Q==
X-CSE-MsgGUID: f5nxJ5p8R02TjB12H+h/Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="68608885"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Sep 2024 19:17:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spepI-0008L0-30;
	Sun, 15 Sep 2024 02:17:24 +0000
Date: Sun, 15 Sep 2024 10:16:57 +0800
From: kernel test robot <lkp@intel.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	andrew@lunn.ch, Steen.Hegelund@microchip.com,
	Raju.Lakkaraju@microchip.com, daniel.machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 3/5] net: lan743x: Register the platform
 device for sfp pluggable module
Message-ID: <202409151058.rOgbMAJJ-lkp@intel.com>
References: <20240911161054.4494-4-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911161054.4494-4-Raju.Lakkaraju@microchip.com>

Hi Raju,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Lakkaraju/net-lan743x-Add-SFP-support-check-flag/20240912-002444
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240911161054.4494-4-Raju.Lakkaraju%40microchip.com
patch subject: [PATCH net-next V2 3/5] net: lan743x: Register the platform device for sfp pluggable module
config: x86_64-randconfig-003-20240914 (https://download.01.org/0day-ci/archive/20240915/202409151058.rOgbMAJJ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409151058.rOgbMAJJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409151058.rOgbMAJJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: i2c_get_adapter_by_fwnode
   >>> referenced by sfp.c:2981 (drivers/net/phy/sfp.c:2981)
   >>>               drivers/net/phy/sfp.o:(sfp_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: i2c_put_adapter
   >>> referenced by sfp.c:2989 (drivers/net/phy/sfp.c:2989)
   >>>               drivers/net/phy/sfp.o:(sfp_probe) in archive vmlinux.a
   >>> referenced by sfp.c:2965 (drivers/net/phy/sfp.c:2965)
   >>>               drivers/net/phy/sfp.o:(sfp_cleanup) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: hwmon_device_unregister
   >>> referenced by sfp.c:1640 (drivers/net/phy/sfp.c:1640)
   >>>               drivers/net/phy/sfp.o:(__sfp_sm_event) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: mdio_i2c_alloc
   >>> referenced by sfp.c:707 (drivers/net/phy/sfp.c:707)
   >>>               drivers/net/phy/sfp.o:(__sfp_sm_event) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: hwmon_sanitize_name
   >>> referenced by sfp.c:1611 (drivers/net/phy/sfp.c:1611)
   >>>               drivers/net/phy/sfp.o:(sfp_hwmon_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: hwmon_device_register_with_info
   >>> referenced by sfp.c:1617 (drivers/net/phy/sfp.c:1617)
   >>>               drivers/net/phy/sfp.o:(sfp_hwmon_probe) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: i2c_transfer
   >>> referenced by sfp.c:648 (drivers/net/phy/sfp.c:648)
   >>>               drivers/net/phy/sfp.o:(sfp_i2c_read) in archive vmlinux.a
   >>> referenced by sfp.c:680 (drivers/net/phy/sfp.c:680)
   >>>               drivers/net/phy/sfp.o:(sfp_i2c_write) in archive vmlinux.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GP_PCI1XXXX
   Depends on [n]: PCI [=y] && GPIOLIB [=y] && NVMEM_SYSFS [=n]
   Selected by [y]:
   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
   WARNING: unmet direct dependencies detected for SFP
   Depends on [m]: NETDEVICES [=y] && PHYLIB [=y] && I2C [=m] && PHYLINK [=y] && (HWMON [=m] || HWMON [=m]=n [=n])
   Selected by [y]:
   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
   WARNING: unmet direct dependencies detected for I2C_PCI1XXXX
   Depends on [m]: I2C [=m] && HAS_IOMEM [=y] && PCI [=y]
   Selected by [y]:
   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

