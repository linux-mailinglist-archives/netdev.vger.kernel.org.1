Return-Path: <netdev+bounces-175025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D54A627F2
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 08:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55ED73A9C17
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692671B4234;
	Sat, 15 Mar 2025 07:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeD3Jeic"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862FF1898E9;
	Sat, 15 Mar 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742023049; cv=none; b=t2naEM3phTKH4uhKJFTAHT06bcl6M9HGl4BUGm5+gXRufSdMn0kn+hu7MOSheXz9JN4BmcXkpJhLsFRLDNBi86VbKoOThezu50X2In9cKoY/XYjAqFZqU9znPGjXgxGxX8Wvt0xE4w2ZiNajHsn5dqRwHhdo2nqyxFOfbBUqHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742023049; c=relaxed/simple;
	bh=Z31rXIHeFi0vSzpLV+dAnUJCfuKbhgx17niPgsHsIP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4TRZCdYpUbFpqVFXU9Fss1eiIZ5DcVwFoFYHqQA/6vssFdziQXCa+lwpXhf40oxia4+7WAWVkCRjCVMPyhhCxSEHihmPRuA6mgyzydWmMXE6xMaanguYLODXpKrqb8M3A6My6pWlJv5hXRHea49pkimC5xYmTwHfzdXUP0/1Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeD3Jeic; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742023047; x=1773559047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z31rXIHeFi0vSzpLV+dAnUJCfuKbhgx17niPgsHsIP8=;
  b=GeD3Jeicy9qCiOh4H420RuNvHGmb3fHI77POJBGGYOQ0Ex9ajSqHjIeF
   WRJnBBfFDn91Yin84zk9+VKJ2wdx3eQLPItz1rU1apeSU5Ek/4RbY7e4r
   wX9A2CzgOrqJ7RzrIStA0S0IahWghdZZ8xCR1kl9YnxHKGbnnc8bptudY
   ELNVi4+6vAz2P28W6RtpGKYVf7dE5SNGlv8/zbQOHQ5FXdXHUntt7IVIR
   zl0M+YXEHeEMN1XU5BJrgEyo940TP64zxa4GDkbiiUB8VSi38i3PymVxx
   AxGIhZ5Fl5HpHtNjQCKR2/PZYMckMsPLsWktf94FftF7qAilmA09WUko0
   A==;
X-CSE-ConnectionGUID: ER6++RFJRlGN3jXZIx4xjw==
X-CSE-MsgGUID: 4Hns2FpsR6uCIZM/eac0+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="42427577"
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="42427577"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 00:17:26 -0700
X-CSE-ConnectionGUID: ZmLPeHApQmO0muF4tNEDJw==
X-CSE-MsgGUID: B5N6fwFcQ+WPCnmpJ96OIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,249,1736841600"; 
   d="scan'208";a="125685349"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Mar 2025 00:17:22 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ttLln-000B7j-1F;
	Sat, 15 Mar 2025 07:17:19 +0000
Date: Sat, 15 Mar 2025 15:16:19 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v3 5/7] net: usb: lan78xx: port link settings to
 phylink API
Message-ID: <202503151447.4eGbKrTa-lkp@intel.com>
References: <20250310115737.784047-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115737.784047-6-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/net-usb-lan78xx-Convert-to-PHYlink-for-improved-PHY-and-MAC-management/20250310-200116
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250310115737.784047-6-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v3 5/7] net: usb: lan78xx: port link settings to phylink API
config: i386-randconfig-006-20250315 (https://download.01.org/0day-ci/archive/20250315/202503151447.4eGbKrTa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250315/202503151447.4eGbKrTa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503151447.4eGbKrTa-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_set_link_ksettings':
>> drivers/net/usb/lan78xx.c:1874: undefined reference to `phylink_ethtool_ksettings_set'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_get_link_ksettings':
>> drivers/net/usb/lan78xx.c:1866: undefined reference to `phylink_ethtool_ksettings_get'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_open':
   drivers/net/usb/lan78xx.c:3252: undefined reference to `phylink_start'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_stop':
   drivers/net/usb/lan78xx.c:3322: undefined reference to `phylink_stop'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_disconnect':
   drivers/net/usb/lan78xx.c:4347: undefined reference to `phylink_stop'
   ld: drivers/net/usb/lan78xx.c:4348: undefined reference to `phylink_disconnect_phy'
   ld: drivers/net/usb/lan78xx.c:4359: undefined reference to `phylink_destroy'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_reset_resume':
   drivers/net/usb/lan78xx.c:5145: undefined reference to `phylink_start'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_phy_init':
   drivers/net/usb/lan78xx.c:2650: undefined reference to `phylink_connect_phy'
   ld: drivers/net/usb/lan78xx.c:2618: undefined reference to `phylink_set_fixed_link'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_phylink_setup':
   drivers/net/usb/lan78xx.c:2588: undefined reference to `phylink_create'
   ld: drivers/net/usb/lan78xx.o: in function `lan78xx_probe':
   drivers/net/usb/lan78xx.c:4581: undefined reference to `phylink_disconnect_phy'
   ld: drivers/net/usb/lan78xx.c:4583: undefined reference to `phylink_destroy'


vim +1874 drivers/net/usb/lan78xx.c

  1860	
  1861	static int lan78xx_get_link_ksettings(struct net_device *net,
  1862					      struct ethtool_link_ksettings *cmd)
  1863	{
  1864		struct lan78xx_net *dev = netdev_priv(net);
  1865	
> 1866		return phylink_ethtool_ksettings_get(dev->phylink, cmd);
  1867	}
  1868	
  1869	static int lan78xx_set_link_ksettings(struct net_device *net,
  1870					      const struct ethtool_link_ksettings *cmd)
  1871	{
  1872		struct lan78xx_net *dev = netdev_priv(net);
  1873	
> 1874		return phylink_ethtool_ksettings_set(dev->phylink, cmd);
  1875	}
  1876	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

