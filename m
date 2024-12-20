Return-Path: <netdev+bounces-153669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10CA9F9258
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1FA7A2577
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3B21571C;
	Fri, 20 Dec 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIPLepSA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C9215703;
	Fri, 20 Dec 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734698244; cv=none; b=tRFVBk997CPKRTzLHQxNhfWAZTtypbcAV9yW2tNyW2VMkNgonHBVMJM0Ngkz1/WAGtBwgN+OXkA9DFShcspmfsNsRj5S9vIogSTivo0ZuRPUZZreh4yFq9z+jpEg3/PhvraF+bbrY2du22DnVifrmuZ3liQcornBB99T/7MeS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734698244; c=relaxed/simple;
	bh=6VjXhVnkEzgOMFd4xLgiPLNAjwJ2JXk5yqCOlFgunTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBnP7IUO3t3gda+onNn4s1D+Lp+6MgkefehEZVAst0p2hwH0IroveLNEYrK4ub7zfzotuwA6sT2OeYn2Lk07W3tlPh/vt46/c+CsSADQt3wV1tPmD9uP1bNbbdvJ6MNKJBHf7E7r+Z+Q69c6dnsYT+DQDQUu7lw+KrDLOGepE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIPLepSA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734698243; x=1766234243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VjXhVnkEzgOMFd4xLgiPLNAjwJ2JXk5yqCOlFgunTQ=;
  b=IIPLepSAOplx8K1Bp0Hqs7LXnCCNxkxwroFEnGGNjubbT48VMSzGrVMN
   e2/WYsFgkwRbipMdMPwpXwacXKXYISx9Wl2saSlh3GGfwDpWawpZMLRxH
   67w25EQQ5hMVChPJ2hPanSTF3sPds92ok4goRI8x10FK25z1nocAz9049
   H1MGipKbJ/UUtO92+zLGLoo3Nc2GskIIqmBkBYuBGCvCAFwypnEJmcSMy
   z/Td0s4oMX4nYoZtw2IeJvfAQXjOpAGnXpnSw9g2IDhuwBL2LBdMa3zeE
   V77CXMyYdc64GKksX0eJy/Jerx5MKln5ReJKDlCiqLKDMy10mtj54wmGS
   A==;
X-CSE-ConnectionGUID: Fa2Jt8hgRD2KSuSYghLY8w==
X-CSE-MsgGUID: esNbAYfmSoiv2pCUrnP0Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="52650729"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="52650729"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 04:37:22 -0800
X-CSE-ConnectionGUID: likqNpzjSySnfm5pm7n8qg==
X-CSE-MsgGUID: N8eCzxXBQhK49/c1QhxERQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103121745"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 04:37:19 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOcFp-00018p-0G;
	Fri, 20 Dec 2024 12:37:17 +0000
Date: Fri, 20 Dec 2024 20:36:23 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <202412202011.MKXldsMF-lkp@intel.com>
References: <20241219132534.725051-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219132534.725051-3-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/ethtool-linkstate-migrate-linkstate-functions-to-support-multi-PHY-setups/20241219-213024
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241219132534.725051-3-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v2 2/8] net: ethtool: plumb PHY stats to PHY drivers
config: i386-buildonly-randconfig-001-20241220 (https://download.01.org/0day-ci/archive/20241220/202412202011.MKXldsMF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412202011.MKXldsMF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412202011.MKXldsMF-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: net/ethtool/linkstate.o: in function `linkstate_prepare_data':
>> linkstate.c:(.text+0x2d9): undefined reference to `phy_ethtool_get_link_ext_stats'
   ld: net/ethtool/stats.o: in function `stats_prepare_data':
>> stats.c:(.text+0x150): undefined reference to `phy_ethtool_get_phy_stats'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

