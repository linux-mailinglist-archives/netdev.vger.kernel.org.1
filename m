Return-Path: <netdev+bounces-132589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3731992501
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2081C22307
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C8E155C8C;
	Mon,  7 Oct 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEitCoZl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2351531CC;
	Mon,  7 Oct 2024 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283180; cv=none; b=W/m1Acl/nmfKR6NUp3uhqJBhYj9JTcGc6dhyPpvhHh6koSEEXJwfR2I2E9Utoa+VdoKVw1UkT+eAhJXRT9cx02v67/XEN5qPy4AFRxzkXr+6cLik/Vy3GlJizKQovaAH9sKJLaPorKOXQh82880gbrai+OsavPPwk6mp74bn+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283180; c=relaxed/simple;
	bh=J3HVUIzHysZ+CBLRfP6nsdLyZgxcaxzOvunnSv25fYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqnd0AimAorsHaD6+luPKAM0uDWX9sOPsfu2iEqopsfPzY0f3yIjwERJ1eaQm/NgxGliMnHNNo9g6xsyAY4g3HlyIUaTQ10Iwg0lDcrjeaRTXbdUw5e3Jwi4GDonJ1J9yySVKEi+ANEv+NQPVyvMoZ9ZUwT6lDNx6FxaTs22mMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEitCoZl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728283179; x=1759819179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J3HVUIzHysZ+CBLRfP6nsdLyZgxcaxzOvunnSv25fYU=;
  b=nEitCoZlh0gyDKZl+tIWmA2ZBJzLbQwB1bRLDgIi/O7EabIZdxQqB7Fc
   3Zd11OJbeJw0NvL9YNJ4xaw87ekDVOUQRqu0uh+EbPn3yZokrklStjYib
   uQY0zVNtEQDcANabExQCRwotlwgJ6oS6vtCPoJu6TsGnsT1V/YCYQaC0Y
   3wwU3G4dG0M9SewkAQCmlyxHXK152GG2iVDlA2cJxzxleDNKyyt06n0sl
   h3+tpSrTIKYx+WvnMt+0NuPjeWLrUXCwNSkTOPxzPgW27QY/W3gUPzaXh
   nkUqGNhWLCMy54JIhd7A2jgCWqZuCdvRNbiWpjiX28nyCYLdpqkx92oXu
   Q==;
X-CSE-ConnectionGUID: U+OqRzNcR0iEbg21WB9/iw==
X-CSE-MsgGUID: Da3/siC3So+fs0A2SFVNSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="38024627"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="38024627"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 23:39:38 -0700
X-CSE-ConnectionGUID: 7Rdu86XgRF+3MPNbIJd2MA==
X-CSE-MsgGUID: U1TG4f4MSu2dKuZ9VW03mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="80202508"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Oct 2024 23:39:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxhP1-0004gE-0m;
	Mon, 07 Oct 2024 06:39:31 +0000
Date: Mon, 7 Oct 2024 14:38:37 +0800
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH net-next 1/9] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <202410071426.fet54A5E-lkp@intel.com>
References: <20241004102413.5838-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004102413.5838-2-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20241004-183507
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241004102413.5838-2-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next 1/9] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
config: i386-kismet-CONFIG_NVMEM_MTK_EFUSE-CONFIG_MEDIATEK_GE_SOC_PHY-0-0 (https://download.01.org/0day-ci/archive/20241007/202410071426.fet54A5E-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241007/202410071426.fet54A5E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410071426.fet54A5E-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE when selected by MEDIATEK_GE_SOC_PHY
   WARNING: unmet direct dependencies detected for NVMEM_MTK_EFUSE
     Depends on [n]: NVMEM [=n] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
     Selected by [y]:
     - MEDIATEK_GE_SOC_PHY [=y] && NETDEVICES [=y] && PHYLIB [=y] && (ARM64 && ARCH_MEDIATEK || COMPILE_TEST [=y])

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

