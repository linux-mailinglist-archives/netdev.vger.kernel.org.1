Return-Path: <netdev+bounces-141743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE56B9BC2B7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0303F1C21410
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CF21D545;
	Tue,  5 Nov 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBAXXKOo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA41CAA4;
	Tue,  5 Nov 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770867; cv=none; b=cUegEqsr6druS6lpYhhn138TaZ8gerInhv86cU02CDFmq3jdGfNkc12WnrgUATfolgGNRi0nhMHOcJaV4bV0t7BgdZZHK+LUaV50Ai0m2iN2xkKpf/oeGPoq7rH7gxrXx++5PI5pnAxoewg/5iFXwvbnUJsFYafjz97KIkQoV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770867; c=relaxed/simple;
	bh=+GPuKpXEsmfqsptPKPYrb39gGs5FlGKD7jeR/0c2SCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4ZtYimslFwVvvDRQGlFu/l+6b2yyvUPj2xX0bMSS4IZbggZFCno+gxMyYeOjdXXy54eQV/J4ubC3iDpyiNz/b+Rtmn4/QB6GgclWGSB+7g9gwM2/5q2hvC0bLYdwUJ1k0TeOTF3IbQEkH6evP5gC5ioy5IfkSapBQzBvUAepK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBAXXKOo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730770863; x=1762306863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GPuKpXEsmfqsptPKPYrb39gGs5FlGKD7jeR/0c2SCY=;
  b=TBAXXKOoT+ZbtwnoM0nzEte6gvkZi5faHBjWlONqR/rX/X2lC+PMRXsT
   KGZ/YIBOy35615uXZmhpnYx3hrIjSALjzfnePZzKfZSOrOtbg66jwA2ic
   WAUGh9Lis9gustlapimb3dHu9wFnLdO5Ycs1I9B5B7z0S6248EXClBg4I
   zxxBul+XnJbtYJA6Wr6xtV8NYdgj1UPsPhFO2Fn61HFotiKCPRrZqYs7k
   gNav+6A4UHwFphVVYbJ+bmvL9ScIPO7k4f1r8c5hbG+qDfs6iawLRaKJ9
   hyxXhg/3ZA3RZp4B25X40qcGLcFUvt/uxeXlxo3BZhcxADtojoKSDkAOQ
   w==;
X-CSE-ConnectionGUID: mBgN0muxQ1q168wjwATtgA==
X-CSE-MsgGUID: 8mpLLgvdTmOEtf2b8i7knA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41044854"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41044854"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:41:02 -0800
X-CSE-ConnectionGUID: veDJ4kIJQySdoCXJGGfrVw==
X-CSE-MsgGUID: iFs51JcyTTOdO0U78CKDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="114620992"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Nov 2024 17:40:58 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t88Yx-000lTr-2d;
	Tue, 05 Nov 2024 01:40:55 +0000
Date: Tue, 5 Nov 2024 09:40:32 +0800
From: kernel test robot <lkp@intel.com>
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
	arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 4/5] net: phy: Makefile: Add makefile support
 for ptp in Microchip phys
Message-ID: <202411050939.88HGuanR-lkp@intel.com>
References: <20241104090750.12942-5-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104090750.12942-5-divya.koppera@microchip.com>

Hi Divya,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Divya-Koppera/net-phy-microchip_ptp-Add-header-file-for-Microchip-ptp-library/20241104-171132
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241104090750.12942-5-divya.koppera%40microchip.com
patch subject: [PATCH net-next 4/5] net: phy: Makefile: Add makefile support for ptp in Microchip phys
config: i386-randconfig-052-20241105 (https://download.01.org/0day-ci/archive/20241105/202411050939.88HGuanR-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241105/202411050939.88HGuanR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411050939.88HGuanR-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/microchip_ptp.c:4:
>> drivers/net/phy/microchip_ptp.h:197:60: warning: declaration of 'struct phy_device' will not be visible outside of this function [-Wvisibility]
     197 | static inline struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev,
         |                                                            ^
>> drivers/net/phy/microchip_ptp.h:198:11: error: unknown type name 'u8'
     198 |                                                     u8 mmd, u16 clk_base,
         |                                                     ^
>> drivers/net/phy/microchip_ptp.h:198:19: error: unknown type name 'u16'
     198 |                                                     u8 mmd, u16 clk_base,
         |                                                             ^
   drivers/net/phy/microchip_ptp.h:199:11: error: unknown type name 'u16'
     199 |                                                     u16 port_base)
         |                                                     ^
   drivers/net/phy/microchip_ptp.h:205:12: error: unknown type name 'u16'
     205 |                                        u16 reg, u16 val, bool enable)
         |                                        ^
   drivers/net/phy/microchip_ptp.h:205:21: error: unknown type name 'u16'
     205 |                                        u16 reg, u16 val, bool enable)
         |                                                 ^
>> drivers/net/phy/microchip_ptp.h:205:30: error: unknown type name 'bool'
     205 |                                        u16 reg, u16 val, bool enable)
         |                                                          ^
>> drivers/net/phy/microchip_ptp.h:210:15: error: unknown type name 'irqreturn_t'
     210 | static inline irqreturn_t mchp_ptp_handle_interrupt(struct mchp_ptp_clock *ptp_clock)
         |               ^
>> drivers/net/phy/microchip_ptp.h:212:9: error: use of undeclared identifier 'IRQ_NONE'
     212 |         return IRQ_NONE;
         |                ^
>> drivers/net/phy/microchip_ptp.c:7:16: warning: declaration of 'enum ptp_fifo_dir' will not be visible outside of this function [-Wvisibility]
       7 |                                enum ptp_fifo_dir dir)
         |                                     ^
>> drivers/net/phy/microchip_ptp.c:7:29: error: variable has incomplete type 'enum ptp_fifo_dir'
       7 |                                enum ptp_fifo_dir dir)
         |                                                  ^
   drivers/net/phy/microchip_ptp.c:7:16: note: forward declaration of 'enum ptp_fifo_dir'
       7 |                                enum ptp_fifo_dir dir)
         |                                     ^
>> drivers/net/phy/microchip_ptp.c:9:39: error: incomplete definition of type 'struct mchp_ptp_clock'
       9 |         struct phy_device *phydev = ptp_clock->phydev;
         |                                     ~~~~~~~~~^
   drivers/net/phy/microchip_ptp.h:197:22: note: forward declaration of 'struct mchp_ptp_clock'
     197 | static inline struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev,
         |                      ^
>> drivers/net/phy/microchip_ptp.c:12:22: error: use of undeclared identifier 'MCHP_PTP_FIFO_SIZE'
      12 |         for (int i = 0; i < MCHP_PTP_FIFO_SIZE; ++i) {
         |                             ^
>> drivers/net/phy/microchip_ptp.c:13:8: error: call to undeclared function 'phy_read_mmd'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      13 |                 rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
         |                      ^
>> drivers/net/phy/microchip_ptp.c:13:29: error: call to undeclared function 'PTP_MMD'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      13 |                 rc = phy_read_mmd(phydev, PTP_MMD(ptp_clock),
         |                                           ^
>> drivers/net/phy/microchip_ptp.c:15:7: error: call to undeclared function 'MCHP_PTP_TX_MSG_HEADER2'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      15 |                                   MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
         |                                   ^
>> drivers/net/phy/microchip_ptp.c:15:31: error: call to undeclared function 'BASE_PORT'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      15 |                                   MCHP_PTP_TX_MSG_HEADER2(BASE_PORT(ptp_clock)) :
         |                                                           ^
>> drivers/net/phy/microchip_ptp.c:16:7: error: call to undeclared function 'MCHP_PTP_RX_MSG_HEADER2'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      16 |                                   MCHP_PTP_RX_MSG_HEADER2(BASE_PORT(ptp_clock)));
         |                                   ^
>> drivers/net/phy/microchip_ptp.c:14:14: error: use of undeclared identifier 'PTP_EGRESS_FIFO'
      14 |                                   dir == PTP_EGRESS_FIFO ?
         |                                          ^
   drivers/net/phy/microchip_ptp.c:20:9: error: call to undeclared function 'phy_read_mmd'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      20 |         return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
         |                ^
   drivers/net/phy/microchip_ptp.c:20:30: error: call to undeclared function 'PTP_MMD'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      20 |         return phy_read_mmd(phydev, PTP_MMD(ptp_clock),
         |                                     ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   2 warnings and 20 errors generated.


vim +/u8 +198 drivers/net/phy/microchip_ptp.h

ca38715fe9dd463 Divya Koppera 2024-11-04  196  
ca38715fe9dd463 Divya Koppera 2024-11-04 @197  static inline struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev,
ca38715fe9dd463 Divya Koppera 2024-11-04 @198  						    u8 mmd, u16 clk_base,
ca38715fe9dd463 Divya Koppera 2024-11-04  199  						    u16 port_base)
ca38715fe9dd463 Divya Koppera 2024-11-04  200  {
ca38715fe9dd463 Divya Koppera 2024-11-04  201  	return 0;
ca38715fe9dd463 Divya Koppera 2024-11-04  202  }
ca38715fe9dd463 Divya Koppera 2024-11-04  203  
ca38715fe9dd463 Divya Koppera 2024-11-04  204  static inline int mchp_config_ptp_intr(struct mchp_ptp_clock *ptp_clock,
ca38715fe9dd463 Divya Koppera 2024-11-04 @205  				       u16 reg, u16 val, bool enable)
ca38715fe9dd463 Divya Koppera 2024-11-04  206  {
ca38715fe9dd463 Divya Koppera 2024-11-04  207  	return 0;
ca38715fe9dd463 Divya Koppera 2024-11-04  208  }
ca38715fe9dd463 Divya Koppera 2024-11-04  209  
ca38715fe9dd463 Divya Koppera 2024-11-04 @210  static inline irqreturn_t mchp_ptp_handle_interrupt(struct mchp_ptp_clock *ptp_clock)
ca38715fe9dd463 Divya Koppera 2024-11-04  211  {
ca38715fe9dd463 Divya Koppera 2024-11-04 @212  	return IRQ_NONE;
ca38715fe9dd463 Divya Koppera 2024-11-04  213  }
ca38715fe9dd463 Divya Koppera 2024-11-04  214  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

