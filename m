Return-Path: <netdev+bounces-222913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B358B56EFC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406E73A93B6
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750D2550AF;
	Mon, 15 Sep 2025 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvD5PqXN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C31E51EC;
	Mon, 15 Sep 2025 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908060; cv=none; b=ZgKQOrTi8ZyLDtQCJit/8gOOtoa+S3gxmJ7xhESkJqXPygm5pZ4FH84aTzhzppNlxmqHJStqjSaFChIFewHVYyk2zENs/FWCadloC5kGjh1k5dAoBy9FV5mLtitI88LzIDsPS+hV3OJZ6evzn5xujl7WiwLxqURZgH+mQULTMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908060; c=relaxed/simple;
	bh=ATcqmhO4zO6S8Z6mwXqmWFUNnlT+T385TfHZ3kQoDwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxh2O0QDNWiO3BRhoW7YAWCnqsE+l0+K9vsJFqBAn2DU02Vl38T9JONa6GyU1KBfR97Otg1M0sEKd0pCPC40g2iRcFcG9qeb+KWrVX1+zvHOea5LWm+oyNp+wEJ0r400Rz4UsJ/Pagay9J+ilt1g7H4Kl/14/JlitkD6P83fLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvD5PqXN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757908059; x=1789444059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ATcqmhO4zO6S8Z6mwXqmWFUNnlT+T385TfHZ3kQoDwE=;
  b=QvD5PqXNNwZnM7mtK1fHP1GU0kpjmFuCUdGxa1L10ZBQtljuSWigB2XL
   fuGIYk6DKNjGf5nwtPn0KJmoe9/NTZ7HGpN7BFpyR/TeKacIklNl+lieG
   pcY5GqN46P3NQPMo4LpJ00gIn9vMCoabv2RanV7p9tF6SRyVivf7d/aAL
   t/A9GGDFfY1JxzYYMQU6FKMTalNqpYyTJrb4QKbawwwVrdsd9yU8DuaUm
   tYKQTOUaCnQDO9yu7koqz1z3hNAH+WfpTSDAbyoK2s5j1l+DKV6NIF6YJ
   96onNHk7lkom5zMevXV4JJ9NuzLESHwgIzsf1KZhAIl+6QJP7Y6fIFF74
   w==;
X-CSE-ConnectionGUID: hCsZxoWbQi2jm3U+vuquxg==
X-CSE-MsgGUID: D+K0iFDaTA+U8DljdO9rqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="77765785"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="77765785"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 20:47:38 -0700
X-CSE-ConnectionGUID: XFJSSZxuRjigpUnM95a8CA==
X-CSE-MsgGUID: /is72rpSTrWwCGsayGXgtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="174946287"
Received: from lkp-server02.sh.intel.com (HELO eb5fdfb2a9b7) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 14 Sep 2025 20:47:35 -0700
Received: from kbuild by eb5fdfb2a9b7 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uy0Bg-0002vw-33;
	Mon, 15 Sep 2025 03:47:32 +0000
Date: Mon, 15 Sep 2025 11:46:50 +0800
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
Message-ID: <202509151143.M8cTV3NE-lkp@intel.com>
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
[also build test WARNING on v6.17-rc6 next-20250912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chia-Lin-Kao-AceLan/r8169-enable-ASPM-on-Dell-platforms/20250915-093648
base:   linus/master
patch link:    https://lore.kernel.org/r/20250915013555.365230-1-acelan.kao%40canonical.com
patch subject: [PATCH v2] r8169: enable ASPM on Dell platforms
config: csky-randconfig-002-20250915 (https://download.01.org/0day-ci/archive/20250915/202509151143.M8cTV3NE-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250915/202509151143.M8cTV3NE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509151143.M8cTV3NE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/r8169_main.c:5370:6: warning: no previous prototype for 'rtl_aspm_new_dell_platforms' [-Wmissing-prototypes]
    5370 | bool rtl_aspm_new_dell_platforms(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


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

