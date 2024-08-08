Return-Path: <netdev+bounces-117036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9998B94C734
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 01:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D55B1F2216B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C691615F3E2;
	Thu,  8 Aug 2024 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVP8ZVeX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB015F311;
	Thu,  8 Aug 2024 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158528; cv=none; b=iH+L7+4hL9AO/yA4EIil00SFJTTDAIuZOlJ6U38GTMvv73QLXmfAEmLs9/kY8Wz8ELvRL9uKV0TtS9mKqbG3du/jpkVOiNLOMu386VtCpyTL3Fb4jVKBirsEEnFJx9HR5yKrwv4cZUFi3M3hv+bIFcnBG073fUwU1N5jeHe74w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158528; c=relaxed/simple;
	bh=T7KdUeo7zRdu2V4NwX3BnZOQDuovZf6qEZiSGn3VOz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euwdbzqlpvqq4QJTbfkQM7i7PGQi84CCAeUTTp8Fjxjsq4XThVjhwoUzaUEUG2uIC4V1B4tq6aYPXJxc1lfx08qwPGLW4BDWUT516t9GIpfOwaQxKjdzpb3i0Y9OuSf8y1CMPW+RQBguUJKoe4YLpb91SLdKbiJX6PamcwaEWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVP8ZVeX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723158527; x=1754694527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T7KdUeo7zRdu2V4NwX3BnZOQDuovZf6qEZiSGn3VOz8=;
  b=lVP8ZVeXbOKsO2q4p12OhTkTdzJf2JTjBOqswY3ml71m2qzbr2zAs/mG
   2l9crPFVeQmCDIZ4ddQuj3pcTld/340nb+3gEQ73krBksviBS3nWrTf5b
   8pI3i9N5n5grtcjf4gK6n7lTMHC88LlaW5WR4MzfiNoFMv1EgTPW/Ssd+
   KYsuoCgmhw+ywLYaZwnCtFbFqw6y6HZftzp+MaP73YZ1HUhqGkYX+P2Sg
   GAvpBdSitY5fNiHpzzP2L/EO+EbwsLmIrjPFIDPq+OwqNq8u59VNsQ/44
   8AwwvmKsiqpR7qFMV23Gez+y5nWc45tj0OUGWpgvPcVxdCMRyMkRrPHyU
   g==;
X-CSE-ConnectionGUID: nIizC+HuTqC9D0Jx9QJDoA==
X-CSE-MsgGUID: 9qBDSpNITCeaiKbwtUyotA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20977166"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="20977166"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 16:08:46 -0700
X-CSE-ConnectionGUID: yiARJAgUSQ6iMi70uo66VQ==
X-CSE-MsgGUID: X00cbstkRRO3ElG4P2oYeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="62015850"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 08 Aug 2024 16:08:41 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scCFK-0006bW-1v;
	Thu, 08 Aug 2024 23:08:38 +0000
Date: Fri, 9 Aug 2024 07:08:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjian Song <jinjian.song@fibocom.com>,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
	corbet@lwn.net, linux-mediatek@lists.infradead.org,
	danielwinkler@google.com, korneld@google.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: Re: [net-next v1] net: wwan: t7xx: PCIe reset rescan
Message-ID: <202408090610.w01C56AC-lkp@intel.com>
References: <20240808111801.8514-1-jinjian.song@fibocom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808111801.8514-1-jinjian.song@fibocom.com>

Hi Jinjian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jinjian-Song/net-wwan-t7xx-PCIe-reset-rescan/20240808-192313
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240808111801.8514-1-jinjian.song%40fibocom.com
patch subject: [net-next v1] net: wwan: t7xx: PCIe reset rescan
config: i386-buildonly-randconfig-004-20240809 (https://download.01.org/0day-ci/archive/20240809/202408090610.w01C56AC-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408090610.w01C56AC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408090610.w01C56AC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wwan/t7xx/t7xx_modem_ops.c:204:13: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     204 |         } else if (type == PLDR) {
         |                    ^~~~~~~~~~~~
   drivers/net/wwan/t7xx/t7xx_modem_ops.c:215:9: note: uninitialized use occurs here
     215 |         return ret;
         |                ^~~
   drivers/net/wwan/t7xx/t7xx_modem_ops.c:204:9: note: remove the 'if' if its condition is always true
     204 |         } else if (type == PLDR) {
         |                ^~~~~~~~~~~~~~~~~
     205 |                 ret = t7xx_acpi_reset(t7xx_dev, "MRST._RST");
     206 |         } else if (type == FASTBOOT) {
         |           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     207 |                 t7xx_host_event_notify(t7xx_dev, FASTBOOT_DL_NOTIFY);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     208 |                 t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     209 |                 msleep(FASTBOOT_RESET_DELAY_MS);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     210 |         }
         |         ~
   drivers/net/wwan/t7xx/t7xx_modem_ops.c:196:9: note: initialize the variable 'ret' to silence this warning
     196 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +204 drivers/net/wwan/t7xx/t7xx_modem_ops.c

   193	
   194	int t7xx_reset_device(struct t7xx_pci_dev *t7xx_dev, enum reset_type type)
   195	{
   196		int ret;
   197	
   198		pci_save_state(t7xx_dev->pdev);
   199		t7xx_pci_reprobe_early(t7xx_dev);
   200		t7xx_mode_update(t7xx_dev, T7XX_RESET);
   201	
   202		if (type == FLDR) {
   203			ret = t7xx_acpi_reset(t7xx_dev, "_RST");
 > 204		} else if (type == PLDR) {
   205			ret = t7xx_acpi_reset(t7xx_dev, "MRST._RST");
   206		} else if (type == FASTBOOT) {
   207			t7xx_host_event_notify(t7xx_dev, FASTBOOT_DL_NOTIFY);
   208			t7xx_mhccif_h2d_swint_trigger(t7xx_dev, H2D_CH_DEVICE_RESET);
   209			msleep(FASTBOOT_RESET_DELAY_MS);
   210		}
   211	
   212		pci_restore_state(t7xx_dev->pdev);
   213		t7xx_pci_reprobe(t7xx_dev, true);
   214	
   215		return ret;
   216	}
   217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

