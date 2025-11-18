Return-Path: <netdev+bounces-239349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55677C67128
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3086328C10
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB332860C;
	Tue, 18 Nov 2025 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDW51Me2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E5328603;
	Tue, 18 Nov 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763434407; cv=none; b=Gl+o3eN1XrtpV4/dfeaf/IvO9kTiqg7y6xA3CD4Y1x/lgMPX+5dm1mp7/Nc8Xn4J4t0CTwYBtFmrU4Z8S4TwJeZjHq8J/qJoB/TQ118pFJ0JsYGwkn2ez0chSfMp2FXtxKZBWenWiVsK77c6GKhufTRaAFJkU4w39Qs3B7kxJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763434407; c=relaxed/simple;
	bh=TGMIpi0NVbJVycoHtc3vfTgyms+LXC6G6OwyhZqhteA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG7+rFNv5t1hRFPddChueADsK3+bVvyEMBJ/F6B4sWV5dV15tiAUMswGTXFCpBwQXINY4ZKyHm4wxtPcWQl8MUHQZA+wk23JYBLC+14NgZ0+gfThYVvI9CB81HpPAFaQLhJO0ZFxhM0lWrjyhyFt/ZUX2TIj7CuDU5bcCUXZd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDW51Me2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763434406; x=1794970406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGMIpi0NVbJVycoHtc3vfTgyms+LXC6G6OwyhZqhteA=;
  b=BDW51Me2/7dyrfMsx+hvZsLmtAftII4E6ww1shAQ/iB91rWTvQuI0FnN
   gIVMJTKqJuU9G4AGOVjObFnuwR+/pEoSstO7Fqj4N+7SObkMs4CvV1v4A
   X2BRoqLCRerjbyWqnti9KiO7y1fAv7fGxDSV5hmIYeckmYlui/ButECSU
   u2GMzXaQ3O5cR9ZWXgwtb9X5SgA7nLoex2ZS2iCiOe4TEYjrPG0GDqyD1
   wFzAzahPmLzga16ftG8cFr/7KBYj0UMuQD0hQyb9GQqLK48JmSC0VolP0
   7nC8D/rNu9y3xHukg20VrPkOkQOSfDOPPgznvXOJT5BUpGh8644+eoka/
   A==;
X-CSE-ConnectionGUID: K9V9smaqRDOxdkMx8My63g==
X-CSE-MsgGUID: G9k7k1chT9WU8xVcyoeEMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="75768687"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="75768687"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 18:53:25 -0800
X-CSE-ConnectionGUID: LOGPaqt5TXCoMMaduCc7dw==
X-CSE-MsgGUID: P7KNbUpzT8aDrUm0gYTNgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="191069423"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2025 18:53:21 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLBqJ-0001Gh-04;
	Tue, 18 Nov 2025 02:53:19 +0000
Date: Tue, 18 Nov 2025 10:52:20 +0800
From: kernel test robot <lkp@intel.com>
To: Wei Fang <wei.fang@nxp.com>, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, Frank.Li@nxp.com
Cc: oe-kbuild-all@lists.linux.dev, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Message-ID: <202511181031.CnphZ4bh-lkp@intel.com>
References: <20251117101921.1862427-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117101921.1862427-3-wei.fang@nxp.com>

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.18-rc5]
[also build test ERROR on next-20251117]
[cannot apply to net-next/main net/main linus/master v6.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Fang/net-fec-remove-useless-conditional-preprocessor-directives/20251117-183058
base:   v6.18-rc5
patch link:    https://lore.kernel.org/r/20251117101921.1862427-3-wei.fang%40nxp.com
patch subject: [PATCH v2 net-next 2/5] net: fec: simplify the conditional preprocessor directives
config: m68k-m5272c3_defconfig (https://download.01.org/0day-ci/archive/20251118/202511181031.CnphZ4bh-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511181031.CnphZ4bh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511181031.CnphZ4bh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/fec_main.c:2766:50: error: 'FEC_MIB_CTRLSTAT' undeclared here (not in a function)
    2766 |         FEC_ECNTRL, FEC_MII_DATA, FEC_MII_SPEED, FEC_MIB_CTRLSTAT, FEC_R_CNTRL,
         |                                                  ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2767:51: error: 'FEC_OPD' undeclared here (not in a function); did you mean 'FEC_H'?
    2767 |         FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH, FEC_OPD, FEC_TXIC0, FEC_RXIC0,
         |                                                   ^~~~~~~
         |                                                   FEC_H
>> drivers/net/ethernet/freescale/fec_main.c:2768:9: error: 'FEC_HASH_TABLE_HIGH' undeclared here (not in a function); did you mean 'FEC_GRP_HASH_TABLE_HIGH'?
    2768 |         FEC_HASH_TABLE_HIGH, FEC_HASH_TABLE_LOW, FEC_GRP_HASH_TABLE_HIGH,
         |         ^~~~~~~~~~~~~~~~~~~
         |         FEC_GRP_HASH_TABLE_HIGH
>> drivers/net/ethernet/freescale/fec_main.c:2768:30: error: 'FEC_HASH_TABLE_LOW' undeclared here (not in a function); did you mean 'FEC_GRP_HASH_TABLE_LOW'?
    2768 |         FEC_HASH_TABLE_HIGH, FEC_HASH_TABLE_LOW, FEC_GRP_HASH_TABLE_HIGH,
         |                              ^~~~~~~~~~~~~~~~~~
         |                              FEC_GRP_HASH_TABLE_LOW
>> drivers/net/ethernet/freescale/fec_main.c:2770:47: error: 'FEC_R_FIFO_RSFL' undeclared here (not in a function); did you mean 'FEC_FIFO_RAM'?
    2770 |         FEC_X_DES_START_0, FEC_R_BUFF_SIZE_0, FEC_R_FIFO_RSFL, FEC_R_FIFO_RSEM,
         |                                               ^~~~~~~~~~~~~~~
         |                                               FEC_FIFO_RAM
>> drivers/net/ethernet/freescale/fec_main.c:2770:64: error: 'FEC_R_FIFO_RSEM' undeclared here (not in a function); did you mean 'FEC_FIFO_RAM'?
    2770 |         FEC_X_DES_START_0, FEC_R_BUFF_SIZE_0, FEC_R_FIFO_RSFL, FEC_R_FIFO_RSEM,
         |                                                                ^~~~~~~~~~~~~~~
         |                                                                FEC_FIFO_RAM
>> drivers/net/ethernet/freescale/fec_main.c:2771:9: error: 'FEC_R_FIFO_RAEM' undeclared here (not in a function); did you mean 'FEC_FIFO_RAM'?
    2771 |         FEC_R_FIFO_RAEM, FEC_R_FIFO_RAFL, FEC_RACC,
         |         ^~~~~~~~~~~~~~~
         |         FEC_FIFO_RAM
>> drivers/net/ethernet/freescale/fec_main.c:2771:26: error: 'FEC_R_FIFO_RAFL' undeclared here (not in a function); did you mean 'FEC_FIFO_RAM'?
    2771 |         FEC_R_FIFO_RAEM, FEC_R_FIFO_RAFL, FEC_RACC,
         |                          ^~~~~~~~~~~~~~~
         |                          FEC_FIFO_RAM
>> drivers/net/ethernet/freescale/fec_main.c:2771:43: error: 'FEC_RACC' undeclared here (not in a function); did you mean 'FEC_RXIC1'?
    2771 |         FEC_R_FIFO_RAEM, FEC_R_FIFO_RAFL, FEC_RACC,
         |                                           ^~~~~~~~
         |                                           FEC_RXIC1
>> drivers/net/ethernet/freescale/fec_main.c:2772:9: error: 'RMON_T_DROP' undeclared here (not in a function)
    2772 |         RMON_T_DROP, RMON_T_PACKETS, RMON_T_BC_PKT, RMON_T_MC_PKT,
         |         ^~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2772:22: error: 'RMON_T_PACKETS' undeclared here (not in a function)
    2772 |         RMON_T_DROP, RMON_T_PACKETS, RMON_T_BC_PKT, RMON_T_MC_PKT,
         |                      ^~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2772:38: error: 'RMON_T_BC_PKT' undeclared here (not in a function)
    2772 |         RMON_T_DROP, RMON_T_PACKETS, RMON_T_BC_PKT, RMON_T_MC_PKT,
         |                                      ^~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2772:53: error: 'RMON_T_MC_PKT' undeclared here (not in a function)
    2772 |         RMON_T_DROP, RMON_T_PACKETS, RMON_T_BC_PKT, RMON_T_MC_PKT,
         |                                                     ^~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2773:9: error: 'RMON_T_CRC_ALIGN' undeclared here (not in a function)
    2773 |         RMON_T_CRC_ALIGN, RMON_T_UNDERSIZE, RMON_T_OVERSIZE, RMON_T_FRAG,
         |         ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2773:27: error: 'RMON_T_UNDERSIZE' undeclared here (not in a function)
    2773 |         RMON_T_CRC_ALIGN, RMON_T_UNDERSIZE, RMON_T_OVERSIZE, RMON_T_FRAG,
         |                           ^~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2773:45: error: 'RMON_T_OVERSIZE' undeclared here (not in a function)
    2773 |         RMON_T_CRC_ALIGN, RMON_T_UNDERSIZE, RMON_T_OVERSIZE, RMON_T_FRAG,
         |                                             ^~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2773:62: error: 'RMON_T_FRAG' undeclared here (not in a function)
    2773 |         RMON_T_CRC_ALIGN, RMON_T_UNDERSIZE, RMON_T_OVERSIZE, RMON_T_FRAG,
         |                                                              ^~~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2774:9: error: 'RMON_T_JAB' undeclared here (not in a function)
    2774 |         RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
         |         ^~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2774:21: error: 'RMON_T_COL' undeclared here (not in a function)
    2774 |         RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
         |                     ^~~~~~~~~~
>> drivers/net/ethernet/freescale/fec_main.c:2774:33: error: 'RMON_T_P64' undeclared here (not in a function)
    2774 |         RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
         |                                 ^~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2774:45: error: 'RMON_T_P65TO127' undeclared here (not in a function)
    2774 |         RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
         |                                             ^~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2774:62: error: 'RMON_T_P128TO255' undeclared here (not in a function)
    2774 |         RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
         |                                                              ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2775:9: error: 'RMON_T_P256TO511' undeclared here (not in a function)
    2775 |         RMON_T_P256TO511, RMON_T_P512TO1023, RMON_T_P1024TO2047,
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2775:27: error: 'RMON_T_P512TO1023' undeclared here (not in a function)
    2775 |         RMON_T_P256TO511, RMON_T_P512TO1023, RMON_T_P1024TO2047,
         |                           ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2775:46: error: 'RMON_T_P1024TO2047' undeclared here (not in a function)
    2775 |         RMON_T_P256TO511, RMON_T_P512TO1023, RMON_T_P1024TO2047,
         |                                              ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2776:9: error: 'RMON_T_P_GTE2048' undeclared here (not in a function)
    2776 |         RMON_T_P_GTE2048, RMON_T_OCTETS,
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2776:27: error: 'RMON_T_OCTETS' undeclared here (not in a function)
    2776 |         RMON_T_P_GTE2048, RMON_T_OCTETS,
         |                           ^~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2777:9: error: 'IEEE_T_DROP' undeclared here (not in a function)
    2777 |         IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
         |         ^~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2777:22: error: 'IEEE_T_FRAME_OK' undeclared here (not in a function)
    2777 |         IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
         |                      ^~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2777:39: error: 'IEEE_T_1COL' undeclared here (not in a function)
    2777 |         IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
         |                                       ^~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2777:52: error: 'IEEE_T_MCOL' undeclared here (not in a function)
    2777 |         IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
         |                                                    ^~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2777:65: error: 'IEEE_T_DEF' undeclared here (not in a function)
    2777 |         IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
         |                                                                 ^~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2778:9: error: 'IEEE_T_LCOL' undeclared here (not in a function)
    2778 |         IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
         |         ^~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2778:22: error: 'IEEE_T_EXCOL' undeclared here (not in a function)
    2778 |         IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
         |                      ^~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2778:36: error: 'IEEE_T_MACERR' undeclared here (not in a function)
    2778 |         IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
         |                                    ^~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2778:51: error: 'IEEE_T_CSERR' undeclared here (not in a function)
    2778 |         IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
         |                                                   ^~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2778:65: error: 'IEEE_T_SQE' undeclared here (not in a function)
    2778 |         IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
         |                                                                 ^~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2779:9: error: 'IEEE_T_FDXFC' undeclared here (not in a function)
    2779 |         IEEE_T_FDXFC, IEEE_T_OCTETS_OK,
         |         ^~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2779:23: error: 'IEEE_T_OCTETS_OK' undeclared here (not in a function)
    2779 |         IEEE_T_FDXFC, IEEE_T_OCTETS_OK,
         |                       ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2780:9: error: 'RMON_R_PACKETS' undeclared here (not in a function)
    2780 |         RMON_R_PACKETS, RMON_R_BC_PKT, RMON_R_MC_PKT, RMON_R_CRC_ALIGN,
         |         ^~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2780:25: error: 'RMON_R_BC_PKT' undeclared here (not in a function)
    2780 |         RMON_R_PACKETS, RMON_R_BC_PKT, RMON_R_MC_PKT, RMON_R_CRC_ALIGN,
         |                         ^~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2780:40: error: 'RMON_R_MC_PKT' undeclared here (not in a function)
    2780 |         RMON_R_PACKETS, RMON_R_BC_PKT, RMON_R_MC_PKT, RMON_R_CRC_ALIGN,
         |                                        ^~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2780:55: error: 'RMON_R_CRC_ALIGN' undeclared here (not in a function)
    2780 |         RMON_R_PACKETS, RMON_R_BC_PKT, RMON_R_MC_PKT, RMON_R_CRC_ALIGN,
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2781:9: error: 'RMON_R_UNDERSIZE' undeclared here (not in a function)
    2781 |         RMON_R_UNDERSIZE, RMON_R_OVERSIZE, RMON_R_FRAG, RMON_R_JAB,
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2781:27: error: 'RMON_R_OVERSIZE' undeclared here (not in a function)
    2781 |         RMON_R_UNDERSIZE, RMON_R_OVERSIZE, RMON_R_FRAG, RMON_R_JAB,
         |                           ^~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2781:44: error: 'RMON_R_FRAG' undeclared here (not in a function)
    2781 |         RMON_R_UNDERSIZE, RMON_R_OVERSIZE, RMON_R_FRAG, RMON_R_JAB,
         |                                            ^~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2781:57: error: 'RMON_R_JAB' undeclared here (not in a function)
    2781 |         RMON_R_UNDERSIZE, RMON_R_OVERSIZE, RMON_R_FRAG, RMON_R_JAB,
         |                                                         ^~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2782:9: error: 'RMON_R_RESVD_O' undeclared here (not in a function)
    2782 |         RMON_R_RESVD_O, RMON_R_P64, RMON_R_P65TO127, RMON_R_P128TO255,
         |         ^~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2782:25: error: 'RMON_R_P64' undeclared here (not in a function)
    2782 |         RMON_R_RESVD_O, RMON_R_P64, RMON_R_P65TO127, RMON_R_P128TO255,
         |                         ^~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2782:37: error: 'RMON_R_P65TO127' undeclared here (not in a function)
    2782 |         RMON_R_RESVD_O, RMON_R_P64, RMON_R_P65TO127, RMON_R_P128TO255,
         |                                     ^~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2782:54: error: 'RMON_R_P128TO255' undeclared here (not in a function)
    2782 |         RMON_R_RESVD_O, RMON_R_P64, RMON_R_P65TO127, RMON_R_P128TO255,
         |                                                      ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2783:9: error: 'RMON_R_P256TO511' undeclared here (not in a function)
    2783 |         RMON_R_P256TO511, RMON_R_P512TO1023, RMON_R_P1024TO2047,
         |         ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/fec_main.c:2783:27: error: 'RMON_R_P512TO1023' undeclared here (not in a function)
    2783 |         RMON_R_P256TO511, RMON_R_P512TO1023, RMON_R_P1024TO2047,


vim +/FEC_MIB_CTRLSTAT +2766 drivers/net/ethernet/freescale/fec_main.c

53607ca2565548 Wei Fang        2025-11-17  2762  
0a8b43b12dd78d Juergen Borleis 2022-10-24  2763  /* for i.MX6ul */
0a8b43b12dd78d Juergen Borleis 2022-10-24  2764  static u32 fec_enet_register_offset_6ul[] = {
0a8b43b12dd78d Juergen Borleis 2022-10-24  2765  	FEC_IEVENT, FEC_IMASK, FEC_R_DES_ACTIVE_0, FEC_X_DES_ACTIVE_0,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2766  	FEC_ECNTRL, FEC_MII_DATA, FEC_MII_SPEED, FEC_MIB_CTRLSTAT, FEC_R_CNTRL,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2767  	FEC_X_CNTRL, FEC_ADDR_LOW, FEC_ADDR_HIGH, FEC_OPD, FEC_TXIC0, FEC_RXIC0,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2768  	FEC_HASH_TABLE_HIGH, FEC_HASH_TABLE_LOW, FEC_GRP_HASH_TABLE_HIGH,
0a8b43b12dd78d Juergen Borleis 2022-10-24  2769  	FEC_GRP_HASH_TABLE_LOW, FEC_X_WMRK, FEC_R_DES_START_0,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2770  	FEC_X_DES_START_0, FEC_R_BUFF_SIZE_0, FEC_R_FIFO_RSFL, FEC_R_FIFO_RSEM,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2771  	FEC_R_FIFO_RAEM, FEC_R_FIFO_RAFL, FEC_RACC,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2772  	RMON_T_DROP, RMON_T_PACKETS, RMON_T_BC_PKT, RMON_T_MC_PKT,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2773  	RMON_T_CRC_ALIGN, RMON_T_UNDERSIZE, RMON_T_OVERSIZE, RMON_T_FRAG,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2774  	RMON_T_JAB, RMON_T_COL, RMON_T_P64, RMON_T_P65TO127, RMON_T_P128TO255,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2775  	RMON_T_P256TO511, RMON_T_P512TO1023, RMON_T_P1024TO2047,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2776  	RMON_T_P_GTE2048, RMON_T_OCTETS,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2777  	IEEE_T_DROP, IEEE_T_FRAME_OK, IEEE_T_1COL, IEEE_T_MCOL, IEEE_T_DEF,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2778  	IEEE_T_LCOL, IEEE_T_EXCOL, IEEE_T_MACERR, IEEE_T_CSERR, IEEE_T_SQE,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2779  	IEEE_T_FDXFC, IEEE_T_OCTETS_OK,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2780  	RMON_R_PACKETS, RMON_R_BC_PKT, RMON_R_MC_PKT, RMON_R_CRC_ALIGN,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2781  	RMON_R_UNDERSIZE, RMON_R_OVERSIZE, RMON_R_FRAG, RMON_R_JAB,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2782  	RMON_R_RESVD_O, RMON_R_P64, RMON_R_P65TO127, RMON_R_P128TO255,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2783  	RMON_R_P256TO511, RMON_R_P512TO1023, RMON_R_P1024TO2047,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2784  	RMON_R_P_GTE2048, RMON_R_OCTETS,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2785  	IEEE_R_DROP, IEEE_R_FRAME_OK, IEEE_R_CRC, IEEE_R_ALIGN, IEEE_R_MACERR,
0a8b43b12dd78d Juergen Borleis 2022-10-24 @2786  	IEEE_R_FDXFC, IEEE_R_OCTETS_OK
0a8b43b12dd78d Juergen Borleis 2022-10-24  2787  };
db65f35f50e031 Philippe Reynes 2015-05-11  2788  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

