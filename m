Return-Path: <netdev+bounces-191724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38E3ABCE47
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 06:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958627A42F9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C6825A2D9;
	Tue, 20 May 2025 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlXT5LkE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6B81E5702;
	Tue, 20 May 2025 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747715873; cv=none; b=ZznKS+5TIh3faxqBN1MQT+HP5rUOyHSQ8PXhHrWY1FCukISutUGBYB+0jxVMAC9ZNAcHf24xCfadGNAUFRLHSmrrF8AfvL/6CwjsOW++OzAJC3nNsTiWmqFV2XN/rPKcjrF2Gv3LzqT7C9yuo1BMyB6sjcgK8Dy7eGMw5dpRLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747715873; c=relaxed/simple;
	bh=/HWugewSwF3nvEChZSyWKJu4IdZ646uM+bCDPZacNpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH/5SXg24bjPvdqh9DGswV47PsJ8k/m5HZdtKS2YE2vYWBQomi2mWXBfTrUCM+Lq2pFy/SchafutmoqpxSKbVfPlR7q/zBEMObZkRE7BfSUsvrqj1bp1lTKNMMnaybjcJ1yvZSUZLtHGmwOalbx/RzGXaAuarpvtsrbLsKS47TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlXT5LkE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747715872; x=1779251872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/HWugewSwF3nvEChZSyWKJu4IdZ646uM+bCDPZacNpw=;
  b=FlXT5LkEHUgPqDmyGJLqI2tnL2Cj0A4I7D4N0FDKQSsEc/5/StApyRD2
   qUb189u+uccWcFf/dye4D5FteiNUV9pEtcb1IWDGGDBdch9aEP/UzRqaq
   KWYGdVcsh6hAsVmw5iTBtEhCEZrV3BkBKMgMgjNOtC6xxyrHasGDzKmrT
   4yqoq3Oet9e0MvM9w9dkHjrflXxZbKIC/4onIZCGfoyQHUiZYPTrXEydj
   Qx9y9klCR2evgh503T0Hh7MNSf+o7ocsqIsUV0CgMz07wcQAyxCTJQhus
   1fABQLXg9Be1d3pdz41/QZ6AwXCnBTgF9FkZZfzErsPDpvjUlb8oCtaiQ
   g==;
X-CSE-ConnectionGUID: LG0g4XarSK+gpMlZmSZkEg==
X-CSE-MsgGUID: Y6iMh+M0RA+uR1WPfvedOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49615549"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49615549"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:37:52 -0700
X-CSE-ConnectionGUID: /shfJDbpQOOib6SfJMhTpw==
X-CSE-MsgGUID: CdGruJYmTL2xxLLcWAqHPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144324829"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 May 2025 21:37:49 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHEja-000MA4-1X;
	Tue, 20 May 2025 04:37:46 +0000
Date: Tue, 20 May 2025 12:37:26 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, sgoutham@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] net: cavium: thunder: Add log for verification fail in
 bgx_poll_for_link()
Message-ID: <202505201239.5YN7PGlt-lkp@intel.com>
References: <20250519152348.2839-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519152348.2839-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/net-cavium-thunder-Add-log-for-verification-fail-in-bgx_poll_for_link/20250519-232542
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250519152348.2839-1-vulab%40iscas.ac.cn
patch subject: [PATCH] net: cavium: thunder: Add log for verification fail in bgx_poll_for_link()
config: sparc-randconfig-002-20250520 (https://download.01.org/0day-ci/archive/20250520/202505201239.5YN7PGlt-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505201239.5YN7PGlt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505201239.5YN7PGlt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from drivers/net/ethernet/cavium/thunder/thunder_bgx.c:6:
   drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function 'bgx_poll_for_link':
>> drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1012:40: error: incompatible type for argument 1 of '_dev_err'
    1012 |                 dev_err(lmac->bgx->pdev->dev, "BXG verification fail with time out.\n");
         |                         ~~~~~~~~~~~~~~~^~~~~
         |                                        |
         |                                        struct device
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/ethernet/cavium/thunder/thunder_bgx.c:1012:17: note: in expansion of macro 'dev_err'
    1012 |                 dev_err(lmac->bgx->pdev->dev, "BXG verification fail with time out.\n");
         |                 ^~~~~~~
   include/linux/dev_printk.h:50:36: note: expected 'const struct device *' but argument is of type 'struct device'
      50 | void _dev_err(const struct device *dev, const char *fmt, ...);
         |               ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_err +1012 drivers/net/ethernet/cavium/thunder/thunder_bgx.c

   995	
   996	static void bgx_poll_for_link(struct work_struct *work)
   997	{
   998		struct lmac *lmac;
   999		u64 spu_link, smu_link;
  1000	
  1001		lmac = container_of(work, struct lmac, dwork.work);
  1002		if (lmac->is_sgmii) {
  1003			bgx_poll_for_sgmii_link(lmac);
  1004			return;
  1005		}
  1006	
  1007		/* Receive link is latching low. Force it high and verify it */
  1008		bgx_reg_modify(lmac->bgx, lmac->lmacid,
  1009			       BGX_SPUX_STATUS1, SPU_STATUS1_RCV_LNK);
  1010		if (bgx_poll_reg(lmac->bgx, lmac->lmacid, BGX_SPUX_STATUS1,
  1011				 SPU_STATUS1_RCV_LNK, false))
> 1012			dev_err(lmac->bgx->pdev->dev, "BXG verification fail with time out.\n");
  1013	
  1014		spu_link = bgx_reg_read(lmac->bgx, lmac->lmacid, BGX_SPUX_STATUS1);
  1015		smu_link = bgx_reg_read(lmac->bgx, lmac->lmacid, BGX_SMUX_RX_CTL);
  1016	
  1017		if ((spu_link & SPU_STATUS1_RCV_LNK) &&
  1018		    !(smu_link & SMU_RX_CTL_STATUS)) {
  1019			lmac->link_up = true;
  1020			if (lmac->lmac_type == BGX_MODE_XLAUI)
  1021				lmac->last_speed = SPEED_40000;
  1022			else
  1023				lmac->last_speed = SPEED_10000;
  1024			lmac->last_duplex = DUPLEX_FULL;
  1025		} else {
  1026			lmac->link_up = false;
  1027			lmac->last_speed = SPEED_UNKNOWN;
  1028			lmac->last_duplex = DUPLEX_UNKNOWN;
  1029		}
  1030	
  1031		if (lmac->last_link != lmac->link_up) {
  1032			if (lmac->link_up) {
  1033				if (bgx_xaui_check_link(lmac)) {
  1034					/* Errors, clear link_up state */
  1035					lmac->link_up = false;
  1036					lmac->last_speed = SPEED_UNKNOWN;
  1037					lmac->last_duplex = DUPLEX_UNKNOWN;
  1038				}
  1039			}
  1040			lmac->last_link = lmac->link_up;
  1041		}
  1042	
  1043		queue_delayed_work(lmac->check_link, &lmac->dwork, HZ * 2);
  1044	}
  1045	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

