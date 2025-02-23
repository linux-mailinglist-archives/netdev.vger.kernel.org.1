Return-Path: <netdev+bounces-168806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36592A40CFC
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 07:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 775CF7AB018
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD61F1CBEAA;
	Sun, 23 Feb 2025 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDtaXut0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF4156F41;
	Sun, 23 Feb 2025 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740292758; cv=none; b=SSEIPxBO9wsPCkHq8BgQbC+5/yoPqfo1jHfhT6aGdXmBS67Nk/mXy1C9jfFWxikO4ZzXeB0QInB4AVsqd5JVmLbC4StS7r685d95j8nYPTlAqu2Dm/hIjwsgGQvkBM9k+4aEYDBRWRXprZPZtxemkZ1A59SY4OtK0pyGSE9/vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740292758; c=relaxed/simple;
	bh=I+4KPvRzypPtuDrJMCOOp4HSPrPDgHBgGBkD6P6VHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2iJvnF9zyU3zdz9GfiFACvgl5zs28oGBf//ULYS7Q8kMHLE2Wp+Ha3MIHpTpnkVsQiaJYC/IFsxFVVgJVOLXRsg+gbAJuFelhEqrxL+D75fpvxTBzI/Y0DrsSp4USy/yrE4tpD5aHkLcZcJl5F1gsb/lCkEA3ITDvxNKw/K804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDtaXut0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740292757; x=1771828757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+4KPvRzypPtuDrJMCOOp4HSPrPDgHBgGBkD6P6VHUI=;
  b=LDtaXut0yFZzr0DFoGMduGECsxn21PFszWURTI4IMCiPngIzlHJqL2qm
   2c91xkuH0orN7la+sUWHwYwjdDS+maFbKNy54IeR79X0SUlT9EKyeuddI
   o2sVIPTgodYHv66oKxQssGKDsMHtD1+LiZF6MsFxU+koqxYXSjhnapEuf
   /V2F5r1RhbYaJj3lRnYliuqUrMev5iUviumhPc2pfgwR9T7drtsCUZS4C
   pRuxxbRerpIlBzqqRFKvA3praAYyHVsHVX26lzZXh/GJ4hUBeKeWjevl0
   A0YC+Vg5dIUePbNHqJtMxojh1E6udOML/j7m6lBgLWQH78MTfmADd8u8z
   w==;
X-CSE-ConnectionGUID: dH928nDoSxOqM4521yTauQ==
X-CSE-MsgGUID: deh/3TVlRTCiiYkV3TUraQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="44849615"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44849615"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 22:39:16 -0800
X-CSE-ConnectionGUID: 5uG0uvraSIuqsYe9IW/NcQ==
X-CSE-MsgGUID: ia23rpyKQ7SEVYI3PsLXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115719579"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 22 Feb 2025 22:39:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tm5ds-0007Al-2M;
	Sun, 23 Feb 2025 06:39:08 +0000
Date: Sun, 23 Feb 2025 14:38:46 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 08/13] net: phy: phy_caps: Introduce
 link_caps_valid
Message-ID: <202502231409.QTfXTqrD-lkp@intel.com>
References: <20250222142727.894124-9-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222142727.894124-9-maxime.chevallier@bootlin.com>

Hi Maxime,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-Chevallier/net-phy-Extract-the-speed-duplex-to-linkmode-conversion-from-phylink/20250222-223310
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250222142727.894124-9-maxime.chevallier%40bootlin.com
patch subject: [PATCH net-next 08/13] net: phy: phy_caps: Introduce link_caps_valid
config: x86_64-buildonly-randconfig-004-20250223 (https://download.01.org/0day-ci/archive/20250223/202502231409.QTfXTqrD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250223/202502231409.QTfXTqrD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502231409.QTfXTqrD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy_caps.c:152: warning: Function parameter or struct member 'speed' not described in 'phy_caps_valid'
>> drivers/net/phy/phy_caps.c:152: warning: Function parameter or struct member 'duplex' not described in 'phy_caps_valid'
>> drivers/net/phy/phy_caps.c:152: warning: Function parameter or struct member 'linkmodes' not described in 'phy_caps_valid'


vim +152 drivers/net/phy/phy_caps.c

   147	
   148	/**
   149	 * phy_caps_valid() - Validate a linkmodes set agains given speed and duplex
   150	 */
   151	bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes)
 > 152	{
   153		int capa = speed_duplex_to_capa(speed, duplex);
   154	
   155		if (capa < 0)
   156			return false;
   157	
   158		return linkmode_intersects(link_caps[capa].linkmodes, linkmodes);
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

