Return-Path: <netdev+bounces-202283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F6AED125
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 22:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116F816EEAA
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121FE23D2BD;
	Sun, 29 Jun 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKlRP+3f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985053D6F;
	Sun, 29 Jun 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751230657; cv=none; b=V/Wq7Fn4GaxHD95iJXzc/hYIjul5TGNPbUmx1nDuMGwHo0R+Hh/zU+SOCr4BYQ7zLQ2DHoo0Lzts1t4oX9XgwvJAgIPPv4MSGsUrWyEVwllr3lYcY/ufHgPjPGcGGtuty1K4jUN3phBuvlTRbADTL9sdPkw5I61Khfi5I+qfbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751230657; c=relaxed/simple;
	bh=4sGclJ7JPmOXEyw1qCkUxmj9+SxiJpgXHWGQ3kI7L8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpLUhIkM7DgVcFhW8EL/C/OUIy6WUZ+IfRght3y11y2WarwWwPCgjnR8fSqHXW4rA0GjPVlUXlWgww2U0tPU02BDS+YJMXsotctbEgv+DX3I92jTFhrrJuIwoq+IsMpG33cb/ztNBhrZuADGWOT2yqeh7lDqCdDdDOTEOP6BXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKlRP+3f; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751230654; x=1782766654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sGclJ7JPmOXEyw1qCkUxmj9+SxiJpgXHWGQ3kI7L8E=;
  b=TKlRP+3f/6xa/BsqWWJ1rOHbxPuKQxI4UoAPkOLKgX/24YK4S0W6CBr2
   mLPR1nT5/bW4GCFEzV87wIlEZZTVo2cHsL/Io2xUX33AXqMUItAvvUk8W
   9WqWBlXmOIbT0zR7n5FNnqx5iO2Scc+dXCQRUtGTtL6hkAm6bT4XA5ZN5
   dv7KBef4kk2nC0XhV2699kGEOcy0HG1jHzZ4AeMlm9WPBTj9IG+663CZ1
   Pj+fUkEP3t5l940/2+jDusWx7FcnGku0Boqu/5jn9IB7k/6oV7h8hdY17
   eK08987vV6w5dwdnS9y6gzs9fEJWqsrutlm0s/XcNOy2f0Jem8BdKuO3R
   Q==;
X-CSE-ConnectionGUID: MHTvA/O7RTqGdnq6qHH77Q==
X-CSE-MsgGUID: +TVy+MTFTkm36HzPfcv4yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="76006842"
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="76006842"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 13:57:34 -0700
X-CSE-ConnectionGUID: yqedKzWcThKyEa84V8mKAQ==
X-CSE-MsgGUID: 2xMj3oDGTH6CIdlGLr8kEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,276,1744095600"; 
   d="scan'208";a="152780971"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Jun 2025 13:57:29 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVz5b-000YE2-1w;
	Sun, 29 Jun 2025 20:57:27 +0000
Date: Mon, 30 Jun 2025 04:56:37 +0800
From: kernel test robot <lkp@intel.com>
To: Laura Nao <laura.nao@collabora.com>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, guangjie.song@mediatek.com,
	wenst@chromium.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: Re: [PATCH v2 22/29] clk: mediatek: Add MT8196 mfg clock support
Message-ID: <202506300416.dbAiyBcI-lkp@intel.com>
References: <20250624143220.244549-23-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624143220.244549-23-laura.nao@collabora.com>

Hi Laura,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.16-rc3 next-20250627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Laura-Nao/clk-mediatek-clk-pll-Add-set-clr-regs-for-shared-PLL-enable-control/20250624-225217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250624143220.244549-23-laura.nao%40collabora.com
patch subject: [PATCH v2 22/29] clk: mediatek: Add MT8196 mfg clock support
config: arm64-randconfig-r053-20250629 (https://download.01.org/0day-ci/archive/20250630/202506300416.dbAiyBcI-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project e04c938cc08a90ae60440ce22d072ebc69d67ee8)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506300416.dbAiyBcI-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/clk/mediatek/clk-mt8196-mfg.c:143:3-8: No need to set .owner here. The core will do it.

vim +143 drivers/clk/mediatek/clk-mt8196-mfg.c

   137	
   138	static struct platform_driver clk_mt8196_mfg_drv = {
   139		.probe = clk_mt8196_mfg_probe,
   140		.remove = clk_mt8196_mfg_remove,
   141		.driver = {
   142			.name = "clk-mt8196-mfg",
 > 143			.owner = THIS_MODULE,
   144			.of_match_table = of_match_clk_mt8196_mfg,
   145		},
   146	};
   147	module_platform_driver(clk_mt8196_mfg_drv);
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

