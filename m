Return-Path: <netdev+bounces-210280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8753B12A27
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689AEAA3162
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 10:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0E24167B;
	Sat, 26 Jul 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ai9n+pjj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B81B233727;
	Sat, 26 Jul 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753527515; cv=none; b=utfJq0Kwjygylv0GNM0WWZzCeCAWfe2TzMcwoJygN/LRcvCeMPIpKFmsAyFIL4TMBf4T5wauamqwkOk0Rih6VYBzSZpwX+KI2FnsZ4I66JQQ4Ent+OoWSPmUHVwoLbhJ05OR4FeHlEkA44aYlmeINPuhqHrc0pj+1flexyjtL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753527515; c=relaxed/simple;
	bh=mQnanwLnUU1C5o0pp34uix8UsV6dHEuqF0sPsUHmxQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goL6JpufR37Dfc7hOZwTg1efb4qHpeF4PDSQcmhWohFvQbaBMdxcMeq1aZxfSMqXaaYlhB0HpO5o2AqgRcdNl4A2ShkftQxkdxo2jMd3gD6R+w25W7RN2rtad/lka792HmIoLGC/Q99TWF9OihYCtuuHjoTN4YOBizPEy+llTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ai9n+pjj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753527513; x=1785063513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQnanwLnUU1C5o0pp34uix8UsV6dHEuqF0sPsUHmxQk=;
  b=ai9n+pjj6TwKZOeYpSLWCTRwYRn+r+it9JU5Q+igKxtCXKhFnC0S/N1w
   wyU8M28Gi7Xc8yXEiJzwwHoDt3R9xH6wUGP8hdmVvX/PZPEaod6IYYLvZ
   GQQf/uoSxc+qXmq7WB7vo8MqZOS6FDCOvzYX+s88U65ZGofrX3sfFppOg
   n3z6T/Co/zhv2l/AxWMK1/TuSxXLIjzDpBzcVFcWvbA5cLNVs4rkFiglQ
   xWyuy/FIl5qbxJyJJ7i6hGmHpKxV9AMYFcIS1KRP4N9S4Hf7h848vtqdG
   3yQlGG7BCyyTLbnzoe4VVnmEyh6irj+sloW6hfAvRwLa8CQ/UggiHHCHC
   A==;
X-CSE-ConnectionGUID: nDtuilW7Q4+PuDzQr5hDEg==
X-CSE-MsgGUID: CmBseQmES5uxQkI6o8s4eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="73430354"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73430354"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 03:58:32 -0700
X-CSE-ConnectionGUID: RvfV8D4aSly1vDzwLyaJWA==
X-CSE-MsgGUID: iP1N6lDETkS8ifYjEEkhOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192440431"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Jul 2025 03:58:29 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufcbi-000Lu5-2i;
	Sat, 26 Jul 2025 10:58:26 +0000
Date: Sat, 26 Jul 2025 18:57:33 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next 4/5] dpll: zl3073x: Refactor DPLL initialization
Message-ID: <202507261812.7458edBX-lkp@intel.com>
References: <20250725154136.1008132-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725154136.1008132-5-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-zl3073x-Add-functions-to-access-hardware-registers/20250725-234600
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250725154136.1008132-5-ivecera%40redhat.com
patch subject: [PATCH net-next 4/5] dpll: zl3073x: Refactor DPLL initialization
config: i386-randconfig-001-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261812.7458edBX-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261812.7458edBX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261812.7458edBX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dpll/zl3073x/core.c:994:3: warning: variable 'mask' is uninitialized when used here [-Wuninitialized]
     994 |                 mask |= BIT(zldpll->id);
         |                 ^~~~
   drivers/dpll/zl3073x/core.c:972:25: note: initialize the variable 'mask' to silence this warning
     972 |         u8 dpll_meas_ctrl, mask;
         |                                ^
         |                                 = '\0'
   1 warning generated.


vim +/mask +994 drivers/dpll/zl3073x/core.c

   958	
   959	/**
   960	 * zl3073x_dev_phase_meas_setup - setup phase offset measurement
   961	 * @zldev: pointer to zl3073x_dev structure
   962	 *
   963	 * Enable phase offset measurement block, set measurement averaging factor
   964	 * and enable DPLL-to-its-ref phase measurement for all DPLLs.
   965	 *
   966	 * Returns: 0 on success, <0 on error
   967	 */
   968	static int
   969	zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev)
   970	{
   971		struct zl3073x_dpll *zldpll;
   972		u8 dpll_meas_ctrl, mask;
   973		int rc;
   974	
   975		/* Read DPLL phase measurement control register */
   976		rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
   977		if (rc)
   978			return rc;
   979	
   980		/* Setup phase measurement averaging factor */
   981		dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
   982		dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
   983	
   984		/* Enable DPLL measurement block */
   985		dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
   986	
   987		/* Update phase measurement control register */
   988		rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
   989		if (rc)
   990			return rc;
   991	
   992		/* Enable DPLL-to-connected-ref measurement for each channel */
   993		list_for_each_entry(zldpll, &zldev->dplls, list)
 > 994			mask |= BIT(zldpll->id);
   995	
   996		return zl3073x_write_u8(zldev, ZL_REG_DPLL_PHASE_ERR_READ_MASK, mask);
   997	}
   998	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

