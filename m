Return-Path: <netdev+bounces-97109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98948C91D5
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 20:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020751C2096B
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 18:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277947A5C;
	Sat, 18 May 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DH7KmcMa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DA45026;
	Sat, 18 May 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716056435; cv=none; b=N5ZN5bF9VE0wvlE7etDVMIohTjTOIDDJLeokJCxcf5l8lftSpAQvKhx7pTm4MNn5oVeIjnQh/S9PbVdf9mHJKBljM41sch/p+Jlfvj1tQDb28GkfibOFkHgTiS/1mQi/9he7sR8TrW3ziw2drbrPZBtYkasLnCbLsIEUz59dIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716056435; c=relaxed/simple;
	bh=71RabXOq6vDxowg3qtAHm2HVaMGle+7+ZRIk+BCvGj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDuI6bcJsjZgUB/R38K/AcNo+nLqNmWX9VxIFTa8rPi6wnAmw2vXDBD6VRZhVX/WpQMfZu7TXvYGWMF+jme0sLQ1jYh3v46EXcSq1Zw4WEV8UibDBKbqvf3rF4qqBInC/xihjrmTS7cgOdXFujG6hjo5l8AmIvDFfSGTJK/S6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DH7KmcMa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716056433; x=1747592433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71RabXOq6vDxowg3qtAHm2HVaMGle+7+ZRIk+BCvGj8=;
  b=DH7KmcMa3sqo9yWdwbnNtzK46bO02oKoMkqV7NYvqtOR00QabuJug4sd
   mM4refaTixVj6d9FQkphA10PemARXPxYUcD51VGTbzhTXDGHMIT0VvkXc
   KDX+ylDVZGcLUr4fuZaL0se9azKEvRDw+FCQk46TiWe+6Ybiwj/hjh1gv
   dbwaHv/TQbiC7Lw20gOrv/2cMnTlhsRyy2aDnn4rIWzggMpLokj+Rot5c
   v1qkIlvrxy+WeXYMVYFDG+gn7RixGRXDLPeI5ZU0Le3m7BQKCp1oK0sQ/
   UPha8l7toviYbu4AqztayTwrhAloF4W/F9fahUTY0Gu4cRF7KNDbJsRF6
   w==;
X-CSE-ConnectionGUID: iTjLkUsySkuFZVyQVXT1RQ==
X-CSE-MsgGUID: oYnyE9srQ4WHH0maJrRo9Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12337510"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="12337510"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 11:20:32 -0700
X-CSE-ConnectionGUID: XIbSxsbPQo2VzxIuGvKSig==
X-CSE-MsgGUID: k4SG/OyfT8WUIPObcss+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="32687008"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 May 2024 11:20:27 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8OfR-0002UH-1I;
	Sat, 18 May 2024 18:20:25 +0000
Date: Sun, 19 May 2024 02:19:34 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Steven Liu <Steven.Liu@mediatek.com>,
	"SkyLake.Huang" <skylake.huang@mediatek.com>
Subject: Re: [PATCH net-next v2 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <202405190238.VoQDfwSS-lkp@intel.com>
References: <20240517102908.12079-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517102908.12079-2-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240517]
[cannot apply to net-next/main net/main linus/master v6.9 v6.9-rc7 v6.9-rc6 v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20240517-184536
base:   next-20240517
patch link:    https://lore.kernel.org/r/20240517102908.12079-2-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next v2 1/5] net: phy: mediatek: Re-organize MediaTek ethernet phy drivers
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240519/202405190238.VoQDfwSS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240519/202405190238.VoQDfwSS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405190238.VoQDfwSS-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
>> mtk-ge-soc.c:(.text+0xc5e): undefined reference to `phy_select_page'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0xe76): undefined reference to `__phy_modify'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_hw_led_on_set':
>> mtk-ge-soc.c:(.text+0xac): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_control_set':
>> mtk-ge-soc.c:(.text+0x1d4): undefined reference to `phy_write_mmd'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0x1fe): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x228): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_hw_led_blink_set':
   mtk-ge-soc.c:(.text+0x29c): undefined reference to `phy_write_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_control_get':
   mtk-ge-soc.c:(.text+0x3d2): undefined reference to `phy_read_mmd'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0x4c6): undefined reference to `phy_read_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mtk_socphy_write_page':
   mtk-ge-soc.c:(.text+0x50e): undefined reference to `__mdiobus_write'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mtk_socphy_read_page':
   mtk-ge-soc.c:(.text+0x52e): undefined reference to `__mdiobus_read'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7981_phy_finetune':
   mtk-ge-soc.c:(.text+0x56a): undefined reference to `phy_write_mmd'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0x5b6): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x5cc): undefined reference to `__mdiobus_write'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0x6c0): undefined reference to `phy_restore_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x6d8): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_finetune':
   mtk-ge-soc.c:(.text+0x856): undefined reference to `phy_write_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x88e): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x8a4): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x95e): undefined reference to `phy_restore_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x976): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_common_finetune':
   mtk-ge-soc.c:(.text+0x9b2): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x9c8): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xb32): undefined reference to `phy_restore_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
   mtk-ge-soc.c:(.text+0xb68): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xc78): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xe56): undefined reference to `phy_restore_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `cal_cycle.constprop.0':
   mtk-ge-soc.c:(.text+0xeea): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xf1c): undefined reference to `phy_read_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `tx_vcm_cal_sw':
   mtk-ge-soc.c:(.text+0x103c): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `tx_amp_fill_result.isra.0':
   mtk-ge-soc.c:(.text+0x13e2): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `rext_cal_efuse':
   mtk-ge-soc.c:(.text+0x15ea): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `cal_efuse':
   mtk-ge-soc.c:(.text+0x1694): undefined reference to `phy_modify_mmd'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0x17b0): undefined reference to `phy_write_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_probe':
>> mtk-ge-soc.c:(.text+0x19b8): undefined reference to `devm_phy_package_join'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x1a94): undefined reference to `phy_modify_mmd'
>> m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x7a): undefined reference to `genphy_suspend'
>> m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x7e): undefined reference to `genphy_resume'
>> m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x92): undefined reference to `genphy_handle_interrupt_no_ack'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x18c): undefined reference to `genphy_suspend'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x190): undefined reference to `genphy_resume'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x1a4): undefined reference to `genphy_handle_interrupt_no_ack'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `phy_module_init':
>> mtk-ge-soc.c:(.init.text+0x12): undefined reference to `phy_drivers_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

