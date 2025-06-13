Return-Path: <netdev+bounces-197475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08ADAD8BD4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD06518954EB
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EDE2D5C88;
	Fri, 13 Jun 2025 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eke9G0B1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B92275AE2;
	Fri, 13 Jun 2025 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816758; cv=none; b=fntaHKN9sXB0Av/5PPMzw0K0xbmEXbpp0ZKYImS8h7PiyDyzBC4aHYGyLFfvdEVGLDiYTclThneCCF1R0PE9iIU1EEvlfLL2KLOYb61SzwQ82wm0N5/nCTHg8XLqE4t/bMwTNAA6SHM0iLaS0zIiLhQW5S8W/ywZBH7E0m/AH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816758; c=relaxed/simple;
	bh=Q8gbfUYNETamHMlqMO9QOqlu77JO0RYCF9BXmbQkWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1z5vv5GoLJQug09R8+v3utzo1RXS/QbjAL+RBuzenlBu5r32SLOhU14Hq3DXxa4i9W871S+s7xsIOSCtYpelkDkXim5CgRh6253GoORrz0wmMPj5me6YTsGnFTIK7NR8ypG3uoB1NiTxxRhBDw4ZpGfigzo++pUfuthrfKQMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eke9G0B1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749816757; x=1781352757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q8gbfUYNETamHMlqMO9QOqlu77JO0RYCF9BXmbQkWK8=;
  b=eke9G0B1fKklklVkRVh/s2iVN2eQDEZmjoBIV3Z7u3nGmHhkWYPgg1JK
   aZ9lD0GNPFm7ry17M1FKSCVeqQVM7EPDfuaii2p0R5WVz5A/dgjVPuRxn
   gaflIAsCc+wj8b2enmfBjvjlEbQEVUOOIzNTx5R7lxOo7i/G177dGaJ44
   TZFICWQIo7AOnLtjwnsoY94Z3cgHKCqA0SeVsjvUrDtTbXdToV/5sEmiA
   4KlVIy9M00x0LLUR12KAdwN9pyEQtYeAqozR+BYXlP4q3lC6Tk3MKfuxh
   IIIYlmW18oGU4K838nmRf2T7ZOF0dKmZ3p7Tz48OnlzUp9NWKM1nLtXcd
   g==;
X-CSE-ConnectionGUID: 9NLP868MTtGvQBFCKdDtYQ==
X-CSE-MsgGUID: nTAL+qPJTx+NBcJ5D7fnxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52012641"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="52012641"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:12:36 -0700
X-CSE-ConnectionGUID: Kd6ix5V9Q0OrAW95lrLS1w==
X-CSE-MsgGUID: OJffvJHpS2u3WKMrqEw+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="185055534"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Jun 2025 05:12:32 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQ3Gm-000CZu-2y;
	Fri, 13 Jun 2025 12:12:28 +0000
Date: Fri, 13 Jun 2025 20:11:48 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: Re: [PATCH v5] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <202506131908.dH1ks6AW-lkp@intel.com>
References: <20250612221630.45198-1-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612221630.45198-1-matthew.gerlach@altera.com>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.16-rc1 next-20250613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Gerlach/dt-bindings-net-Convert-socfpga-dwmac-bindings-to-yaml/20250613-062051
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250612221630.45198-1-matthew.gerlach%40altera.com
patch subject: [PATCH v5] dt-bindings: net: Convert socfpga-dwmac bindings to yaml
reproduce: (https://download.01.org/0day-ci/archive/20250613/202506131908.dH1ks6AW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506131908.dH1ks6AW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_CN/how-to.rst references a file that doesn't exist: Documentation/xxx/xxx.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/altr,gmii-to-sgmii.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/ti,tps6131x.yaml
   Warning: arch/riscv/kernel/kexec_image.c references a file that doesn't exist: Documentation/riscv/boot-image-header.rst
   Warning: drivers/clocksource/timer-armada-370-xp.c references a file that doesn't exist: Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

