Return-Path: <netdev+bounces-153673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1129F9282
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AC916D705
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004B215198;
	Fri, 20 Dec 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7c7rwfR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F261C5F21;
	Fri, 20 Dec 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734698905; cv=none; b=DnOqV5IaZOnllEOeVNld/ZpQ8e2R66A8oECLKS3ptZn3E8dec9nCSGr+kMyNJiXxVrAv++I1+Rr8NL8NK7rJPskl0fcWUxmsskUvlQOU51F0X2goJhEcnBL/lBtJ20oK3vtgIb/6aKN56HxFoCgSro7aWdUfB2BIIwHXM7iS3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734698905; c=relaxed/simple;
	bh=FDdJ2lBFifNTt/lTvkM/SY/UtKg5l+gUiTFgEfwyL2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGP5no5phq7lurD7sE1lmIRzNihmVArKg99Vx4+ExB/ZurlvVH/frvogAbS6InQPPf65HB+wr2TY7iqhDuqLiqNXUgnCqxhM646udwn7Lw5pypYUeJDG32O8R0+aU8BpU81SyXwDlS9UfbSlPfDcWg2A3z44aAFj0hkDuIb3Pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7c7rwfR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734698904; x=1766234904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FDdJ2lBFifNTt/lTvkM/SY/UtKg5l+gUiTFgEfwyL2c=;
  b=d7c7rwfRlY244ugosD28BiHk7Nw9W+cFfB8QgyEW4035akmmRedfIuse
   qnAcvd/V27kyBUE6EdV+3QFmI4bJKKsab8foHZQ5G2J2kvIkqaDiSalhm
   TFelzKKWcdHWX97M7hTfvWW6GQ7uYd8i/TRpjcGL8asfWV9PeB5vuFhyF
   FHDUYTy4uJgbSbEp8lUiSwDLcxywGMv3/b/j378koMm8uxncVuVy4EBUd
   uVigDo4sZdTPmOpYnA96h+a7q9IAFtWj8yETdQn7+wH1rDGzxhz1SI/yr
   p8pEeJ0Z73QhX8d0r7S0PSy8QZl6M49cbxPS8oyOKj46YcxlH6d0fG/Wk
   Q==;
X-CSE-ConnectionGUID: vwriY1ztRhKAh1GAqw2b8g==
X-CSE-MsgGUID: bNOhPZigQJWv+63Mz7kBpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35129421"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="35129421"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 04:48:24 -0800
X-CSE-ConnectionGUID: x+DoA/PTQHKmMiqDUDD6Zg==
X-CSE-MsgGUID: WG3pATEDTtCBOQrj2PA1yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="98326547"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Dec 2024 04:48:19 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOcQT-00019D-2y;
	Fri, 20 Dec 2024 12:48:17 +0000
Date: Fri, 20 Dec 2024 20:47:32 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: ethtool: plumb PHY stats to PHY
 drivers
Message-ID: <202412202052.YznBmblv-lkp@intel.com>
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
config: arm-randconfig-004-20241220 (https://download.01.org/0day-ci/archive/20241220/202412202052.YznBmblv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 9daf10ff8f29ba3a88a105aaa9d2379c21b77d35)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412202052.YznBmblv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412202052.YznBmblv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: phy_ethtool_get_phy_stats
   >>> referenced by stats.c
   >>>               net/ethtool/stats.o:(stats_prepare_data) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: phy_ethtool_get_link_ext_stats
   >>> referenced by linkstate.c
   >>>               net/ethtool/linkstate.o:(linkstate_prepare_data) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

