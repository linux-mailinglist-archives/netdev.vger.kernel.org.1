Return-Path: <netdev+bounces-218500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5DB3CC25
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F6D1BA0FBA
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 15:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759A248F62;
	Sat, 30 Aug 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lihi0w1+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF24242D7B;
	Sat, 30 Aug 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756568615; cv=none; b=LXFJMFYaCHwBAtRWSX17xqeI2PPCQp1zXo6p6BgiiR1XEPxI5L5kY79Uiv/dsKwWQVCShNGUKlY2yqnwcbe8zYZo7MF6+TLa9k6s9Y6opj78WdWrI/fzSk0AY7RTcEiOBe+OGaUQWcA5iecUwa9mzbqnWjQnyzHWpypLze7ZJaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756568615; c=relaxed/simple;
	bh=dUdc3YD3kkYcCh+ebcNpEl3q2xqMySVNEI2xbGKknoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRFUe5UoqJzpNx/9kcs88AACt8Rhm6T8oygakCZbC2Fg/8FthvuLdxHn8VJeM7YivoeYvGwDSJwHMoqLRs6XrSP0RoyWk3M/QUG3MJ+ASx7OFPzEoftdcnG7tM4J6+O8Ku0JAfR3E3FkF4Rgucci3Cvpx3fqDkO7sW3wkRFOb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lihi0w1+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756568614; x=1788104614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dUdc3YD3kkYcCh+ebcNpEl3q2xqMySVNEI2xbGKknoc=;
  b=Lihi0w1+cbQompAKO85yjnpgwX1ofT//RhJkaNEJxslZWfZAgZz4BGfg
   M2x54rJV5OsDjf4w0ylpwI0E8fZCklTun1q8ZaV+MNEzEd/XYOuiwCjcp
   ZdehNuveyXf9K8meRxul9ZJp13Z4L/UFvW/lCwur5uxdDHqEt43wMv/PY
   tCuNXjuzbPaiWXZGMG6JBEHBDb3sBjvN1wGL2P6YkJwp6IsOKpsmRGV1v
   MuFbx1FeAfysiHM8SGUCEE8rJ5cdsHMq1rY2+Y2RYEg8sOnh0e0AbqqgZ
   WUwH0+kiZI9jpjsIlSUPQDwvmHWqvw1PIANnuriEeRpBlbRFrDgiV6NIK
   A==;
X-CSE-ConnectionGUID: mBW9lVOFSVytK8PIDtVxtg==
X-CSE-MsgGUID: Ce20RM65QbmAghrSCNjzeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69933109"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69933109"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2025 08:43:33 -0700
X-CSE-ConnectionGUID: IoIRMJ2SS8OOZoP1hwg7zQ==
X-CSE-MsgGUID: EXq+p+TvR+6RSo0YfCui+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171406704"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 30 Aug 2025 08:43:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usNjQ-000VTL-0R;
	Sat, 30 Aug 2025 15:43:16 +0000
Date: Sat, 30 Aug 2025 23:41:07 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] ARM: dts: ls1021a: switch to new fixed-link
 binding
Message-ID: <202508302318.rMGYiqni-lkp@intel.com>
References: <7427825b-7d2f-4edb-a357-fa5eabb6d7d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7427825b-7d2f-4edb-a357-fa5eabb6d7d7@gmail.com>

Hi Heiner,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/arm64-dts-ls1043a-qds-switch-to-new-fixed-link-binding/20250830-183341
base:   net-next/main
patch link:    https://lore.kernel.org/r/7427825b-7d2f-4edb-a357-fa5eabb6d7d7%40gmail.com
patch subject: [PATCH net-next 2/5] ARM: dts: ls1021a: switch to new fixed-link binding
config: arm-randconfig-003-20250830 (https://download.01.org/0day-ci/archive/20250830/202508302318.rMGYiqni-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250830/202508302318.rMGYiqni-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508302318.rMGYiqni-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts:127.2-35 Properties must precede subnodes
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

