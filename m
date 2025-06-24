Return-Path: <netdev+bounces-200518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55079AE5CFE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A5E3A914E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7024169A;
	Tue, 24 Jun 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii7Qynol"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD523C51F;
	Tue, 24 Jun 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747307; cv=none; b=bpIjh8F2c3on7jqudEkaARD0/6ZhGspOI4uuMSgNa6xZHSpYoEXYNl+il47PTKnaWP+bQa5YFAEM1jWi+/kXCQ3d+jQF6Tl7SnCcvgjmT9MvZ9HbvzMiIbF/kkAzy1hGNWHVeFCgeUUNIyGEoLQszV0MkgifAfpMJQco4xE1b2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747307; c=relaxed/simple;
	bh=XbgEhC+fI0zEai/znLDBDx3WSxt18trUioMURpeGfM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDbNaC1vxti1oQqOJBfTopXew4jS+9BvTC8AORfBC/P5ZXzKTfFqVttspRPtMrbggJ7vzlG5LpjZLHGRUhVDXcB5n1whtyI9PAtOEVhhrW5CxgiOOvMCcngcGEDGpstxNrWkOFriZIDRrdkX63QfJDmqdMqxyDzvVd4RSvaEEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii7Qynol; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750747306; x=1782283306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XbgEhC+fI0zEai/znLDBDx3WSxt18trUioMURpeGfM4=;
  b=ii7QynolNuKhDaq751MX3IMMf1BE59dX/FXGyqa0QugxD51V5BqygUKR
   LW7Hv0KRhP8FqFvcryzEuxUOYEWvWjshfFA5lN0zqGFBVmivxz1n2Ayez
   3eNqfXXjIQL/LtF13Kdv1bASfLUQcdcpxsgKiLO2sLX4Y7jlJ/qUgjigN
   79xY1MT7ueBud+ORNOqmoVww8kqzg9kkNCppAYt30qZDSjWFUb42u5YD6
   A/PGOXCayDv+0PX+4ISTnVqHwNLLBLuQU6gkSuNQwZNAvFbgIgAfN0Gvq
   2P0SUS0nRPKnaL/N8hZ4FzrGK3gwstnUHp/AtVqxrTJmePqfbyRliOJ/V
   A==;
X-CSE-ConnectionGUID: dx3LAe5cQJy5YVS0OLoVWg==
X-CSE-MsgGUID: DeNn7xnARcKXCAYPhbGC6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53107557"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="53107557"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 23:41:46 -0700
X-CSE-ConnectionGUID: FaRihE0RS/ChSZqkWDGsLA==
X-CSE-MsgGUID: AMgtjDzgTkKJg1vnnqz3dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157599303"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Jun 2025 23:41:41 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTxLe-000Roo-1k;
	Tue, 24 Jun 2025 06:41:38 +0000
Date: Tue, 24 Jun 2025 14:40:55 +0800
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
Subject: Re: [PATCH 24/30] clk: mediatek: Add MT8196 disp-ao clock support
Message-ID: <202506241439.PGytyi4q-lkp@intel.com>
References: <20250623102940.214269-25-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623102940.214269-25-laura.nao@collabora.com>

Hi Laura,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.16-rc3 next-20250623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Laura-Nao/clk-mediatek-clk-pll-Add-set-clr-regs-for-shared-PLL-enable-control/20250623-184204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250623102940.214269-25-laura.nao%40collabora.com
patch subject: [PATCH 24/30] clk: mediatek: Add MT8196 disp-ao clock support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250624/202506241439.PGytyi4q-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506241439.PGytyi4q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506241439.PGytyi4q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt8196-vdisp_ao.c:62:34: warning: 'of_match_clk_mt8196_vdisp_ao' defined but not used [-Wunused-const-variable=]
      62 | static const struct of_device_id of_match_clk_mt8196_vdisp_ao[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/of_match_clk_mt8196_vdisp_ao +62 drivers/clk/mediatek/clk-mt8196-vdisp_ao.c

    61	
  > 62	static const struct of_device_id of_match_clk_mt8196_vdisp_ao[] = {
    63		{ .compatible = "mediatek,mt8196-vdisp-ao", .data = &mm_v_mcd },
    64		{ /* sentinel */ }
    65	};
    66	MODULE_DEVICE_TABLE(of, of_match_clk_mt8196_vdisp_ao);
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

