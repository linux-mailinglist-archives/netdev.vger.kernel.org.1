Return-Path: <netdev+bounces-189561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63568AB2A17
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 19:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6EB1747D6
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A35525D541;
	Sun, 11 May 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKFSpKVR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE618DB3D
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985509; cv=none; b=mQSkDOENP+qOHY90JL/nV+cZE0WVd8UzUbdh8WiI2GmJc13QhTP1cgCSPxr95ixNSbGCG2LsQYBVWL4UovaFAAMR8f7fkp07gzz7b555gUbbPajF/Koy92YPWt+XUB3D/MRf4JVn+mJt46hmszsoVFtoypx/owye+DA0hk039A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985509; c=relaxed/simple;
	bh=gEwxvQx6pgGEV3Orv8QrtxMZSdJdWmSDFVyY/gUDsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6Nqi8cNCplfPy0G1SsoPDh5Zq8xWRnmoNkHK89PDiTUGuXsv0QY3Z7mrONHSrgfKDQ/CfbOuSXhsoJ3xghIjelXrmNiYK7eico2+YbAzOnvzAOLU0gbIDdFuriHUN7Sw/Z+M7Iw2kRrpLRDlO5mBujTvBNNDjIdcCepky3tAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKFSpKVR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746985508; x=1778521508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gEwxvQx6pgGEV3Orv8QrtxMZSdJdWmSDFVyY/gUDsNk=;
  b=cKFSpKVRa8gVRLld0D1/Fezrdgr4s4vxi/hKygqWh/hTlXnWIXh4yJQn
   C+wHQ/EGb9mKYfKPq1YYTTM/2TfkXMBDWzYiOaCF/cmdtNp17+IfuLX4e
   v59a7UOlo/UQ85zC0NtXDbqwF5Zk+1YisWzEde2ODc29e5fY36QRZofT1
   PEfRSjZ2BIuOLTNcSl0Tx/78iu1nJ/4D9dyiz70nE4rjIsOtpMh1+O2vX
   dMOr7oT0EQMzRw2JUwsQTl6oI74LfRkeg5NwVszBjak94uVfgp6kMyfcq
   SS9JBvh7M6OuG6IVQNDH1qQDAW8kUxJnrYQSzx7YmyUOeQku7Q2XsvMyu
   A==;
X-CSE-ConnectionGUID: KCgPcRFGS1yfxjFBhLlxDA==
X-CSE-MsgGUID: J1Ig8DtjQpKJ+NQCmjNrtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="47893373"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="47893373"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 10:45:07 -0700
X-CSE-ConnectionGUID: NTqxkMPGR4yvffAK4EFg7Q==
X-CSE-MsgGUID: xMp6d7WDQKeDGSWZukMYBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137660912"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 May 2025 10:45:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEAjV-000Du7-1M;
	Sun, 11 May 2025 17:45:01 +0000
Date: Mon, 12 May 2025 01:44:48 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
Message-ID: <202505120152.NK62aoNF-lkp@intel.com>
References: <3c34a2f1-d163-4854-9146-4a9440671177@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c34a2f1-d163-4854-9146-4a9440671177@gmail.com>

Hi Heiner,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/net-phy-remove-Kconfig-symbol-MDIO_DEVRES/20250508-031034
base:   net-next/main
patch link:    https://lore.kernel.org/r/3c34a2f1-d163-4854-9146-4a9440671177%40gmail.com
patch subject: [PATCH v2 net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
config: i386-randconfig-053-20250511 (https://download.01.org/0day-ci/archive/20250512/202505120152.NK62aoNF-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250512/202505120152.NK62aoNF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505120152.NK62aoNF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> depmod: ERROR: Cycle detected: libphy -> of_mdio -> fixed_phy -> libphy
>> depmod: ERROR: Cycle detected: libphy -> of_mdio -> libphy
>> depmod: ERROR: Cycle detected: libphy -> of_mdio -> fwnode_mdio -> libphy
   depmod: ERROR: Found 4 modules in dependency cycles!
   make[3]: *** [scripts/Makefile.modinst:132: depmod] Error 1
   make[3]: Target '__modinst' not remade because of errors.
   make[2]: *** [Makefile:1910: modules_install] Error 2
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'modules_install' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'modules_install' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

