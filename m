Return-Path: <netdev+bounces-223372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4833B58E8D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEEE1B278C2
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55E2DCBF1;
	Tue, 16 Sep 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WneHQ4Pz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE081F583D;
	Tue, 16 Sep 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004885; cv=none; b=V0Lw/PozSf8WzRQmSmWTm39dBmlyMCKdvhybXDV9O7/xUG6zBvS7ch42WmNEKu9M6YAU4jPtCMoF41WKl5C+8Q5Y7PEmael+PH5U2F4uFbirE0EuG/dhRcMCOSCL329zhRTLOYO7Clvm+t21gAcDTKOgbbNXvijd7gFVqoc5zNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004885; c=relaxed/simple;
	bh=N5IZxxhluXUUG0JU/1n3V93l19c+z9JD4PPao3oJxtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElBTT0gpAi12xscjFQYUZ1LKWKG1JJggwNQr8Sk9AWHkmJJyA49BpkJyb2+LgKfIeGkL8FKnjy9+bCGYdro7ioPCuPyFwweVDRQw8fwQguZUm3a5JCFei4gItqF8CHxWtNmO7fbjLTuIca/bjbnDR7bPwgXVD0OXlfytzv+J7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WneHQ4Pz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758004884; x=1789540884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5IZxxhluXUUG0JU/1n3V93l19c+z9JD4PPao3oJxtE=;
  b=WneHQ4Pz53t4d1Ib/31YDLf45wbZklEJ3/bNncKVw1OMTdd1e7Bn+w11
   oT7AqWKLu9TMQRT6TK4P85ilZt+AsWk9Do/x0rIDTpWzqZsyoO0IKkI1r
   RmClMSl2nS+BtF4QlhNoGYbRsdL3U7vsgw7Y1G9pfAPMGUd3JQkbdDjt/
   +Mc2x1X1LtZs67PNgk/747jd7UCCRpOsNW2qgQlKZOcx32Lzqbgbjplaa
   KdiivSkDdtPgzVzItA9OTwdJ50RAQpYVv8+RgzIasKIQCzFBMOD6OVaWa
   X+hEVrhpdG6CM5/UcmjbTYp9Qm0MJ9FvR4sH1SxJkilXxzUu6EoorCTTN
   Q==;
X-CSE-ConnectionGUID: 1+JG2z+vSsWThpX99m7Fxw==
X-CSE-MsgGUID: QbJ4BvwkQKK0sf4+svK0kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60386873"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="60386873"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 23:41:23 -0700
X-CSE-ConnectionGUID: rGSvLA/WQJuFWVgarA9APg==
X-CSE-MsgGUID: FVWd+jP/RcGT3luQOYCeQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="205635613"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Sep 2025 23:41:19 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyPNM-00001z-2a;
	Tue, 16 Sep 2025 06:41:16 +0000
Date: Tue, 16 Sep 2025 14:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, "Wang, Crag" <Crag.Wang@dell.com>,
	"Chen, Alan" <Alan.Chen6@dell.com>,
	"Alex Shen@Dell" <Yijun.Shen@dell.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v2] r8169: enable ASPM on Dell platforms
Message-ID: <202509161457.njlVGwnm-lkp@intel.com>
References: <20250915013555.365230-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915013555.365230-1-acelan.kao@canonical.com>

Hi Chia-Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.17-rc6 next-20250915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chia-Lin-Kao-AceLan/r8169-enable-ASPM-on-Dell-platforms/20250915-093648
base:   linus/master
patch link:    https://lore.kernel.org/r/20250915013555.365230-1-acelan.kao%40canonical.com
patch subject: [PATCH v2] r8169: enable ASPM on Dell platforms
config: i386-randconfig-r113-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161457.njlVGwnm-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161457.njlVGwnm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509161457.njlVGwnm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/realtek/r8169_main.c:5370:6: sparse: sparse: symbol 'rtl_aspm_new_dell_platforms' was not declared. Should it be static?

vim +/rtl_aspm_new_dell_platforms +5370 drivers/net/ethernet/realtek/r8169_main.c

  5369	
> 5370	bool rtl_aspm_new_dell_platforms(void)
  5371	{
  5372		const char *family = dmi_get_system_info(DMI_PRODUCT_FAMILY);
  5373		static const char * const dell_product_families[] = {
  5374			"Alienware",
  5375			"Dell Laptops",
  5376			"Dell Pro Laptops",
  5377			"Dell Pro Max Laptops",
  5378			"Dell Desktops",
  5379			"Dell Pro Desktops",
  5380			"Dell Pro Max Desktops",
  5381			"Dell Pro Rugged Laptops"
  5382		};
  5383		int i;
  5384	
  5385		if (!family)
  5386			return false;
  5387	
  5388		for (i = 0; i < ARRAY_SIZE(dell_product_families); i++) {
  5389			if (str_has_prefix(family, dell_product_families[i]))
  5390				return true;
  5391		}
  5392	
  5393		return false;
  5394	}
  5395	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

