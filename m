Return-Path: <netdev+bounces-147224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE39D85F2
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17311169D42
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 13:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2772B1AB52D;
	Mon, 25 Nov 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CO0wVyLw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF51AB507;
	Mon, 25 Nov 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540026; cv=none; b=MZcX6Ba8UZNRBDJg0mPGk3ZTxwFm7/Il6ikwxU9ozA6EBxV7ju5DZDHOK+q2c57ZUJjspiJEKkHB0u7Tc6K6XoEJfi1+ZxgLL0Dq4tWuEGujMFLqzzPIbVdLOdaErFtPiV0XjEyoN66G6V7P4LyJb035BfjSnJCq8takgqFK5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540026; c=relaxed/simple;
	bh=NYAR6zx9csg70XZRm5JpbFd7GI76A8LuONb3G1EzATg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml0DZLfvzPYa2XptZM4v2meFXiI6UJO+2X2/9zdvj7WwbVNwZ7jsbc0a1K15pbIHNm6YK1zQhgNCXsJUXruKZEsMj6SgH2/Pd6w0zPDu37YoBGc8ka6zTzuVTm4dFhCR4fH8mljYduv1+IrGm4D6KrEQZZGikm8humQs3u8d8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CO0wVyLw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540024; x=1764076024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYAR6zx9csg70XZRm5JpbFd7GI76A8LuONb3G1EzATg=;
  b=CO0wVyLwimVZGmXfaCBwDh3QetCeYsNUvBcN2hwIGpTTiHVOdDdkxtNN
   jOgr0tCb4OSK4WPrIkhiuK41mcFHfvY0RHxLPgRcy1dCMPSzlorkiMgNR
   QQMezoyhVW5vat7ByjwXbkWKaSihqBBLlItRSzvqTadrhb/356h8+ImNZ
   8uFLSx5GaX9yVTggTGbRpDS6eMCPBIHSascF9yHNZDw49u5J8+KAIFikw
   uTJVOBvTYWCfMrrlhBY7tNqB/AIfjMJsGxWlTwqtxhhX3oVL0CwIbhg8y
   xM+iGbW2wYTtSsSAyoCmB2Og5t1uduM4fYk72LCVkNoKMRRZnBn3OJVpn
   A==;
X-CSE-ConnectionGUID: boliNkj7SGGq2CIzeeviag==
X-CSE-MsgGUID: fmFoQ79HQ1SdKc7ISmK/Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32016928"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32016928"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:07:03 -0800
X-CSE-ConnectionGUID: WuTFLlVwQfulv7lZjSsbhg==
X-CSE-MsgGUID: UXvWF2SVR4ybBFbmaR/pkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="96324026"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Nov 2024 05:07:00 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFYnp-0006PZ-0X;
	Mon, 25 Nov 2024 13:06:57 +0000
Date: Mon, 25 Nov 2024 21:06:52 +0800
From: kernel test robot <lkp@intel.com>
To: Catdeo Zhang <catdeo.zhang@unisoc.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, catdeo.zhang@unisoc.com,
	cixi.geng@linux.dev, wade.shu@unisoc.com, jiawang.yu@unisoc.com,
	hehe.li@unisoc.com
Subject: Re: [PATCH] net/sipa: Spreadtrum IPA driver code
Message-ID: <202411252057.ShDClRfV-lkp@intel.com>
References: <20241122014541.1234644-1-catdeo.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122014541.1234644-1-catdeo.zhang@unisoc.com>

Hi Catdeo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master horms-ipvs/master v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Catdeo-Zhang/net-sipa-Spreadtrum-IPA-driver-code/20241125-094101
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241122014541.1234644-1-catdeo.zhang%40unisoc.com
patch subject: [PATCH] net/sipa: Spreadtrum IPA driver code
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241125/202411252057.ShDClRfV-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411252057.ShDClRfV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411252057.ShDClRfV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/sipa/sipa_core.c:31: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * SPRD IPA contains a number of common fifo


vim +31 drivers/net/sipa/sipa_core.c

    29	
    30	/**
  > 31	 * SPRD IPA contains a number of common fifo
    32	 * in the current Unisoc, mainly includes USB, WIFI, PCIE, AP etc.
    33	 */
    34	static struct sipa_cmn_fifo_info sipa_cmn_fifo_statics[SIPA_CFIFO_MAX] = {
    35		{
    36			.cfifo_name = "sprd,usb-ul",
    37			.tx_fifo = "sprd,usb-ul-tx",
    38			.rx_fifo = "sprd,usb-ul-rx",
    39			.relate_ep = SIPA_EP_USB,
    40			.src_id = SIPA_TERM_USB,
    41			.dst_id = SIPA_TERM_AP,
    42			.is_to_ipa = 1,
    43			.is_pam = 1,
    44		},
    45		{
    46			.cfifo_name = "sprd,wifi-ul",
    47			.tx_fifo = "sprd,wifi-ul-tx",
    48			.rx_fifo = "sprd,wifi-ul-rx",
    49			.relate_ep = SIPA_EP_WIFI,
    50			.src_id = SIPA_TERM_WIFI1,
    51			.dst_id = SIPA_TERM_AP,
    52			.is_to_ipa = 1,
    53			.is_pam = 1,
    54		},
    55		{
    56			.cfifo_name = "sprd,pcie-ul",
    57			.tx_fifo = "sprd,pcie-ul-tx",
    58			.rx_fifo = "sprd,pcie-ul-rx",
    59			.relate_ep = SIPA_EP_PCIE,
    60			.src_id = SIPA_TERM_PCIE0,
    61			.dst_id = SIPA_TERM_AP,
    62			.is_to_ipa = 1,
    63			.is_pam = 1,
    64		},
    65		{
    66			.cfifo_name = "sprd,wiap-dl",
    67			.tx_fifo = "sprd,wiap-dl-tx",
    68			.rx_fifo = "sprd,wiap-dl-rx",
    69			.relate_ep = SIPA_EP_WIAP,
    70			.src_id = SIPA_TERM_VAP0,
    71			.dst_id = SIPA_TERM_AP,
    72			.is_to_ipa = 1,
    73			.is_pam = 1,
    74		},
    75		{
    76			.cfifo_name = "sprd,map-in",
    77			.tx_fifo = "sprd,map-in-tx",
    78			.rx_fifo = "sprd,map-in-rx",
    79			.relate_ep = SIPA_EP_AP,
    80			.src_id = SIPA_TERM_AP,
    81			.dst_id = SIPA_TERM_VCP,
    82			.is_to_ipa = 1,
    83			.is_pam = 0,
    84		},
    85		{
    86			.cfifo_name = "sprd,usb-dl",
    87			.tx_fifo = "sprd,usb-dl-tx",
    88			.rx_fifo = "sprd,usb-dl-rx",
    89			.relate_ep = SIPA_EP_USB,
    90			.src_id = SIPA_TERM_USB,
    91			.dst_id = SIPA_TERM_AP,
    92			.is_to_ipa = 0,
    93			.is_pam = 1,
    94		},
    95		{
    96			.cfifo_name = "sprd,wifi-dl",
    97			.tx_fifo = "sprd,wifi-dl-tx",
    98			.rx_fifo = "sprd,wifi-dl-rx",
    99			.relate_ep = SIPA_EP_WIFI,
   100			.src_id = SIPA_TERM_WIFI1,
   101			.dst_id = SIPA_TERM_AP,
   102			.is_to_ipa = 0,
   103			.is_pam = 1,
   104		},
   105		{
   106			.cfifo_name = "sprd,pcie-dl",
   107			.tx_fifo = "sprd,pcie-dl-tx",
   108			.rx_fifo = "sprd,pcie-dl-rx",
   109			.relate_ep = SIPA_EP_PCIE,
   110			.src_id = SIPA_TERM_PCIE0,
   111			.dst_id = SIPA_TERM_AP,
   112			.is_to_ipa = 0,
   113			.is_pam = 1,
   114		},
   115		{
   116			.cfifo_name = "sprd,wiap-ul",
   117			.tx_fifo = "sprd,wiap-ul-tx",
   118			.rx_fifo = "sprd,wiap-ul-rx",
   119			.relate_ep = SIPA_EP_WIAP,
   120			.src_id = SIPA_TERM_VAP0,
   121			.dst_id = SIPA_TERM_AP,
   122			.is_to_ipa = 0,
   123			.is_pam = 1,
   124		},
   125		{
   126			.cfifo_name = "sprd,map0-out",
   127			.tx_fifo = "sprd,map0-out-tx",
   128			.rx_fifo = "sprd,map0-out-rx",
   129			.relate_ep = SIPA_EP_AP,
   130			.src_id = SIPA_TERM_AP,
   131			.dst_id = SIPA_TERM_USB,
   132			.is_to_ipa = 0,
   133			.is_pam = 0,
   134		},
   135		{
   136			.cfifo_name = "sprd,map1-out",
   137			.tx_fifo = "sprd,map1-out-tx",
   138			.rx_fifo = "sprd,map1-out-rx",
   139			.relate_ep = SIPA_EP_AP,
   140			.src_id = SIPA_TERM_AP,
   141			.dst_id = SIPA_TERM_USB,
   142			.is_to_ipa = 0,
   143			.is_pam = 0,
   144		},
   145		{
   146			.cfifo_name = "sprd,map2-out",
   147			.tx_fifo = "sprd,map2-out-tx",
   148			.rx_fifo = "sprd,map2-out-rx",
   149			.relate_ep = SIPA_EP_AP,
   150			.src_id = SIPA_TERM_AP,
   151			.dst_id = SIPA_TERM_USB,
   152			.is_to_ipa = 0,
   153			.is_pam = 0,
   154		},
   155		{
   156			.cfifo_name = "sprd,map3-out",
   157			.tx_fifo = "sprd,map3-out-tx",
   158			.rx_fifo = "sprd,map3-out-rx",
   159			.relate_ep = SIPA_EP_AP,
   160			.src_id = SIPA_TERM_AP,
   161			.dst_id = SIPA_TERM_USB,
   162			.is_to_ipa = 0,
   163			.is_pam = 0,
   164		},
   165		{
   166			.cfifo_name = "sprd,map4-out",
   167			.tx_fifo = "sprd,map4-out-tx",
   168			.rx_fifo = "sprd,map4-out-rx",
   169			.relate_ep = SIPA_EP_AP,
   170			.src_id = SIPA_TERM_AP,
   171			.dst_id = SIPA_TERM_USB,
   172			.is_to_ipa = 0,
   173			.is_pam = 0,
   174		},
   175		{
   176			.cfifo_name = "sprd,map5-out",
   177			.tx_fifo = "sprd,map5-out-tx",
   178			.rx_fifo = "sprd,map5-out-rx",
   179			.relate_ep = SIPA_EP_AP,
   180			.src_id = SIPA_TERM_AP,
   181			.dst_id = SIPA_TERM_USB,
   182			.is_to_ipa = 0,
   183			.is_pam = 0,
   184		},
   185		{
   186			.cfifo_name = "sprd,map6-out",
   187			.tx_fifo = "sprd,map6-out-tx",
   188			.rx_fifo = "sprd,map6-out-rx",
   189			.relate_ep = SIPA_EP_AP,
   190			.src_id = SIPA_TERM_AP,
   191			.dst_id = SIPA_TERM_USB,
   192			.is_to_ipa = 0,
   193			.is_pam = 0,
   194		},
   195		{
   196			.cfifo_name = "sprd,map7-out",
   197			.tx_fifo = "sprd,map7-out-tx",
   198			.rx_fifo = "sprd,map7-out-rx",
   199			.relate_ep = SIPA_EP_AP,
   200			.src_id = SIPA_TERM_AP,
   201			.dst_id = SIPA_TERM_USB,
   202			.is_to_ipa = 0,
   203			.is_pam = 0,
   204		},
   205	};
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

