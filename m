Return-Path: <netdev+bounces-151267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35D9EDD15
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 02:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0969018881D7
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B0B2AE68;
	Thu, 12 Dec 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPcWNOFD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B953FC7
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733967107; cv=none; b=p5Iuwh00Y2yrYagqxHo0sjDq9FVUJKrfQPIQIzhXAewGeHmgVblcOZCgKhpHaTMk1lstjr/Zpzk1jPMLzCz/bjBH3pvHGXQbguvVUmmkznRAE0vjV9ujXPE3xZaqCVIunG2BsUFLcgr/DlfUbiAHGkiUxv4v6v7k2fIzPol80/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733967107; c=relaxed/simple;
	bh=K0VafvKngiyoy+gIPt2y7Gcv36rDQPvBtIvPL9cZ0PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqXclubnMfuhwedC4EiqZGMCRBPE/CPnpWGryg0lafMVvXqWGy67BCVn2q+1IUhgfwtzgnUddzoEVB50Y446+NBh0PfwFlj+20o/4qeCc6yf78bSV06dXz+8GnjXxAwvMgEP3BYoEW9s1RQIRVJi9DkOceslwxECg4AwzI0BLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPcWNOFD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733967105; x=1765503105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K0VafvKngiyoy+gIPt2y7Gcv36rDQPvBtIvPL9cZ0PM=;
  b=hPcWNOFDwuAhelGwOUkKgpTCc1X0/J1ria5RyQq0KE2+gZZzPZbMqhHe
   pGIMNJXFLTgtjWvZ6yacejkHXY04AgXQqi0LkUB3NLU/pIapXziO30XTI
   /zoR+NgNcWfpoqY53+d8Fmqmtvn4Vu/vmseqdbsaV5b/WRPBcFNREVaE6
   UPcgjndJyBFoE6Q8NvHSyYAUc3aUK7Vu9m0sTSk8G3WrkbmWp0qDgK/E6
   92bMMianSFDaa0xnxfiwEa2hHwb999RycvThDYAWJqLVdqPiSVaEx3jHI
   5OFRzOWkY/202oVe+FbAjwVx4+X61MchpxMVLe6LX7TRSxUgH7MvezoMy
   A==;
X-CSE-ConnectionGUID: m7JQsKrQQnGVPefmImOU/Q==
X-CSE-MsgGUID: fQm1+z0DS/2dWjgAYYrdFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34096049"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34096049"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 17:31:44 -0800
X-CSE-ConnectionGUID: EG1Z7OAyQ2CX6IOyJVs6zA==
X-CSE-MsgGUID: 3hUeEj61R1+Y0MNCL+zJDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119279604"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 17:31:41 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLY3H-0007IG-2N;
	Thu, 12 Dec 2024 01:31:39 +0000
Date: Thu, 12 Dec 2024 09:31:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 10/10] net: lan743x: convert to phylink managed
 EEE
Message-ID: <202412120900.DYyJpYUw-lkp@intel.com>
References: <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKeg8-006SNJ-4Q@rmk-PC.armlinux.org.uk>

Hi Russell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Russell-King-Oracle/net-mdio-add-definition-for-clock-stop-capable-bit/20241210-022608
base:   net-next/main
patch link:    https://lore.kernel.org/r/E1tKeg8-006SNJ-4Q%40rmk-PC.armlinux.org.uk
patch subject: [PATCH net-next 10/10] net: lan743x: convert to phylink managed EEE
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241212/202412120900.DYyJpYUw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120900.DYyJpYUw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120900.DYyJpYUw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/microchip/lan743x_main.c: In function 'mac_disable_tx_lpi':
   drivers/net/ethernet/microchip/lan743x_main.c:3078:32: error: 'adapter' undeclared (first use in this function)
    3078 |         lan743x_mac_eee_enable(adapter, false);
         |                                ^~~~~~~
   drivers/net/ethernet/microchip/lan743x_main.c:3078:32: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/microchip/lan743x_main.c: In function 'mac_enable_tx_lpi':
   drivers/net/ethernet/microchip/lan743x_main.c:3089:27: error: 'adapter' undeclared (first use in this function)
    3089 |         lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, timer);
         |                           ^~~~~~~
   drivers/net/ethernet/microchip/lan743x_main.c: At top level:
   drivers/net/ethernet/microchip/lan743x_main.c:3097:31: error: 'lan743x_mac_disable_tx_lpi' undeclared here (not in a function); did you mean 'mac_disable_tx_lpi'?
    3097 |         .mac_disable_tx_lpi = lan743x_mac_disable_tx_lpi,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                               mac_disable_tx_lpi
   drivers/net/ethernet/microchip/lan743x_main.c:3098:30: error: 'lan743x_mac_enable_tx_lpi' undeclared here (not in a function); did you mean 'mac_enable_tx_lpi'?
    3098 |         .mac_enable_tx_lpi = lan743x_mac_enable_tx_lpi,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                              mac_enable_tx_lpi
   drivers/net/ethernet/microchip/lan743x_main.c: In function 'lan743x_phylink_create':
   drivers/net/ethernet/microchip/lan743x_main.c:3113:33: error: 'struct phylink_config' has no member named 'lpi_timer_max'; did you mean 'lpi_timer_default'?
    3113 |         adapter->phylink_config.lpi_timer_max = U32_MAX;
         |                                 ^~~~~~~~~~~~~
         |                                 lpi_timer_default
   drivers/net/ethernet/microchip/lan743x_main.c: At top level:
>> drivers/net/ethernet/microchip/lan743x_main.c:3081:13: warning: 'mac_enable_tx_lpi' defined but not used [-Wunused-function]
    3081 | static void mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
         |             ^~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/microchip/lan743x_main.c:3076:13: warning: 'mac_disable_tx_lpi' defined but not used [-Wunused-function]
    3076 | static void mac_disable_tx_lpi(struct phylink_config *config)
         |             ^~~~~~~~~~~~~~~~~~


vim +/mac_enable_tx_lpi +3081 drivers/net/ethernet/microchip/lan743x_main.c

  3075	
> 3076	static void mac_disable_tx_lpi(struct phylink_config *config)
  3077	{
  3078		lan743x_mac_eee_enable(adapter, false);
  3079	}
  3080	
> 3081	static void mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
  3082				      bool tx_clk_stop)
  3083	{
  3084		/* Software should only change this field when Energy Efficient
  3085		 * Ethernet Enable (EEEEN) is cleared. We ensure that by clearing
  3086		 * EEEEN during probe, and phylink itself guarantees that
  3087		 * mac_disable_tx_lpi() will have been previously called.
  3088		 */
  3089		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, timer);
  3090		lan743x_mac_eee_enable(adapter, true);
  3091	}
  3092	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

