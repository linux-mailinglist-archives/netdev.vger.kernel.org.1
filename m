Return-Path: <netdev+bounces-142232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D18B9BDF08
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83661F24051
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4F4192B94;
	Wed,  6 Nov 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiKQTj8H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C1A192580;
	Wed,  6 Nov 2024 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876193; cv=none; b=TvkOMpZqbs4bbRp4fNgNP4gBrkpSQ4oLt+C7Bc4zXxeLPRoR6BsMpYGN8PvRQS9VD3PezklIfqrIHp9FSwdMqxkQt9olzTqWNrWlm5L3cdboVhEgeHDOtKDvNBBOv9s31V8KxOvv8E4bnvdMdCBTwI0TgqbYkkPDIxb1LZ0yllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876193; c=relaxed/simple;
	bh=7Blh7p02YI4RwiQup76IUOMLyinN3Qo+MpfCB2iFvv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIFfq7WJMjHgzz4GYYOFFhqK5h/CDOcZWN+EFuRVCLNaLm1NxvBFMOjT2109BCpMTvGbGQvE/4/LLoL9M5sw72qO5vMOY9+jtYxLzlZlmcoex8SvvgIGydqM/fABtPIN9Cld+Gv3Xvz1ENdTiHYnPMYLX1FJsUHMPmO2X95ZfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiKQTj8H; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730876192; x=1762412192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Blh7p02YI4RwiQup76IUOMLyinN3Qo+MpfCB2iFvv8=;
  b=eiKQTj8He7m4DLB3sU9JC7vT5B8ICCmvbpboTZV0P77ju5rmHHoCKe2g
   qCyIA7iUeKtwRHq9TyszLoXMo7/lU/NUGMqwVxdkntnM5L2Mf0WKZsAIQ
   dUq4sD3mlDf/FfIs76lJSM22Ftl4U5/6nsnQmXoCkn3mRhdFb8VPv93b3
   5THn6q1xhmpY9U+UEwroFpm0M4nrQbavh3T7vd4jSxiUilR+dRysdtqXr
   P3t2wKPMefCnyFahFIuEX+642E/TGjLWvyKk2YjgVVX4K4Qhk4XynhDRG
   Ro1EQgl3fjVYwOAwAY881G6OPDJDwZMwxQWFT0TgT6S8A6NiayyS07nyr
   g==;
X-CSE-ConnectionGUID: DGhQVQuhREyfEAFiZTVL5g==
X-CSE-MsgGUID: krHSBKD/RCu0cIJvAilh2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="41285079"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="41285079"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 22:56:31 -0800
X-CSE-ConnectionGUID: suoCvPbpTgCv3vpY5bfu7w==
X-CSE-MsgGUID: 79adoSYUTq+OVmjKJvESiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84308090"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Nov 2024 22:56:12 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8ZxZ-000n1a-2o;
	Wed, 06 Nov 2024 06:56:09 +0000
Date: Wed, 6 Nov 2024 14:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH net-next v2 4/5] net: phy: mediatek: Integrate read/write
 page helper functions
Message-ID: <202411061420.eK9LoyP8-lkp@intel.com>
References: <20241105141911.13326-5-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105141911.13326-5-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20241105-222556
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241105141911.13326-5-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next v2 4/5] net: phy: mediatek: Integrate read/write page helper functions
config: hexagon-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241106/202411061420.eK9LoyP8-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411061420.eK9LoyP8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411061420.eK9LoyP8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: mtk_phy_read_page
   >>> referenced by mtk-ge.c
   >>>               drivers/net/phy/mediatek/mtk-ge.o:(mtk_gephy_driver) in archive vmlinux.a
   >>> referenced by mtk-ge.c
   >>>               drivers/net/phy/mediatek/mtk-ge.o:(mtk_gephy_driver) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: mtk_phy_write_page
   >>> referenced by mtk-ge.c
   >>>               drivers/net/phy/mediatek/mtk-ge.o:(mtk_gephy_driver) in archive vmlinux.a
   >>> referenced by mtk-ge.c
   >>>               drivers/net/phy/mediatek/mtk-ge.o:(mtk_gephy_driver) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

