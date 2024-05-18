Return-Path: <netdev+bounces-97117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EA28C9277
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 23:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EE3281A79
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13D46BFDC;
	Sat, 18 May 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmAK/gDT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE449DF58;
	Sat, 18 May 2024 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716067870; cv=none; b=F/M6Zvk52oS8n/IOS6Yy7ViBxiLXUo8X1L3+s9CYMunBdcD99VUF2Nllcjp6hjvB9Su3cacPZ3Y5IEk7V+G3c1UPFfaE52vG6E3nML6pvJwj4xAYz/oWKkQLWyhh/c2GITKIFIMhV75C5Hp2wzvIyhI9lkmgP8Kb5YHmdgJGH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716067870; c=relaxed/simple;
	bh=YcuHLa93vOsQrMH7qC/ZJuanpLd3bFvl73b4w8gDm7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg1s6qrCNIIicGO2yOsO7+9R+6Z/qWiEXyUs7IKb9ik4WkmOfe0BfaBFRtaLTi0mPQnggrIQRSOBa0tba5VNLw3Vo7tTVTFNouQOBmhTJxxAqU7HhwiARJBbhRcTwpqDQup6GOZHItxTxjwba8xAXhcjpUX+ngHok2GEGs9coEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmAK/gDT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716067869; x=1747603869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YcuHLa93vOsQrMH7qC/ZJuanpLd3bFvl73b4w8gDm7k=;
  b=ZmAK/gDTHpailMxmVoa2PJV91OQV+mkZRQjKDicieJ2uozo1LWyYRprR
   mMujaeO82Ghvs5KHueVG0nX+ViW1nznFyO+SczMaCA/kH9Y0TaeSFpe0F
   +Z8+By0gXHBlEhpXyH5pGB07QyLbJbyK5Zp9m1lyh7St3lzz2dLsMqkVF
   JexErG/BdBgogo0TefzWa2Lx53711GarcJcUHQnG5OUwRfDMPU8200wwt
   mjZKLsvMok/BnzzNA5r1/7ObANMqTUYoDqdYXTSM9flMTRA1zVxyUQ/GW
   zo1+5aEDZ8kH4Hc8HD4khcN7xQZziFoPPPGBgvQRZAB84OQylsxy1V9m4
   A==;
X-CSE-ConnectionGUID: DLRBkHPyRqmNDdBPnXRxjQ==
X-CSE-MsgGUID: 8lIHNxTxRSCMD04wWbj4ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="37608900"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="37608900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 14:31:08 -0700
X-CSE-ConnectionGUID: sc9c9u6PRKSkFMa9ZLiDIw==
X-CSE-MsgGUID: ovrQszmMR3mDpHLmAvxfng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="32710517"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 18 May 2024 14:31:03 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8Rds-0002do-28;
	Sat, 18 May 2024 21:31:00 +0000
Date: Sun, 19 May 2024 05:30:03 +0800
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
Subject: Re: [PATCH net-next v2 2/5] net: phy: mediatek: Move LED and
 read/write page helper functions into mtk phy lib
Message-ID: <202405190537.zWJuRc1r-lkp@intel.com>
References: <20240517102908.12079-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517102908.12079-3-SkyLake.Huang@mediatek.com>

Hi Sky,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240517]
[cannot apply to net-next/main net/main linus/master v6.9 v6.9-rc7 v6.9-rc6 v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sky-Huang/net-phy-mediatek-Re-organize-MediaTek-ethernet-phy-drivers/20240517-184536
base:   next-20240517
patch link:    https://lore.kernel.org/r/20240517102908.12079-3-SkyLake.Huang%40mediatek.com
patch subject: [PATCH net-next v2 2/5] net: phy: mediatek: Move LED and read/write page helper functions into mtk phy lib
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240519/202405190537.zWJuRc1r-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240519/202405190537.zWJuRc1r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405190537.zWJuRc1r-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
   mtk-ge-soc.c:(.text+0x892): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xaaa): undefined reference to `__phy_modify'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_control_get':
>> mtk-ge-soc.c:(.text+0x32): undefined reference to `mtk_phy_led_hw_ctrl_get'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_control_set':
>> mtk-ge-soc.c:(.text+0x64): undefined reference to `mtk_phy_led_hw_ctrl_set'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_hw_is_supported':
>> mtk-ge-soc.c:(.text+0x88): undefined reference to `mtk_phy_led_hw_is_supported'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_blink_set':
>> mtk-ge-soc.c:(.text+0xe0): undefined reference to `mtk_phy_hw_led_blink_set'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0xfa): undefined reference to `mtk_phy_hw_led_on_set'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_led_brightness_set':
   mtk-ge-soc.c:(.text+0x136): undefined reference to `mtk_phy_hw_led_blink_set'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x15a): undefined reference to `mtk_phy_hw_led_on_set'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7981_phy_finetune':
   mtk-ge-soc.c:(.text+0x19e): undefined reference to `phy_write_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x1ea): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x200): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x2f4): undefined reference to `phy_restore_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x30c): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_finetune':
   mtk-ge-soc.c:(.text+0x48a): undefined reference to `phy_write_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x4c2): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x4d8): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x592): undefined reference to `phy_restore_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x5aa): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_common_finetune':
   mtk-ge-soc.c:(.text+0x5e6): undefined reference to `phy_select_page'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x5fc): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x766): undefined reference to `phy_restore_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt798x_phy_eee':
   mtk-ge-soc.c:(.text+0x79c): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x8ac): undefined reference to `__mdiobus_write'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xa8a): undefined reference to `phy_restore_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `cal_cycle.constprop.0':
   mtk-ge-soc.c:(.text+0xb1e): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0xb50): undefined reference to `phy_read_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `tx_vcm_cal_sw':
   mtk-ge-soc.c:(.text+0xc70): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `tx_amp_fill_result.isra.0':
   mtk-ge-soc.c:(.text+0x1016): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `rext_cal_efuse':
   mtk-ge-soc.c:(.text+0x121e): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `cal_efuse':
   mtk-ge-soc.c:(.text+0x12c8): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x13e4): undefined reference to `phy_write_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7988_phy_probe':
   mtk-ge-soc.c:(.text+0x15ec): undefined reference to `devm_phy_package_join'
>> m68k-linux-ld: mtk-ge-soc.c:(.text+0x1688): undefined reference to `mtk_phy_leds_state_init'
   m68k-linux-ld: mtk-ge-soc.c:(.text+0x16ba): undefined reference to `phy_modify_mmd'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `mt7981_phy_probe':
>> mtk-ge-soc.c:(.text+0x17b4): undefined reference to `mtk_phy_leds_state_init'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x7a): undefined reference to `genphy_suspend'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x7e): undefined reference to `genphy_resume'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x92): undefined reference to `genphy_handle_interrupt_no_ack'
>> m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0xb2): undefined reference to `mtk_phy_read_page'
>> m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0xb6): undefined reference to `mtk_phy_write_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x18c): undefined reference to `genphy_suspend'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x190): undefined reference to `genphy_resume'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x1a4): undefined reference to `genphy_handle_interrupt_no_ack'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x1c4): undefined reference to `mtk_phy_read_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o:(.data+0x1c8): undefined reference to `mtk_phy_write_page'
   m68k-linux-ld: drivers/net/phy/mediatek/mtk-ge-soc.o: in function `phy_module_init':
   mtk-ge-soc.c:(.init.text+0x12): undefined reference to `phy_drivers_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

