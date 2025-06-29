Return-Path: <netdev+bounces-202239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F69AECDEC
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4ED172A9E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93D22A1CF;
	Sun, 29 Jun 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V61K5kZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B822540A;
	Sun, 29 Jun 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207019; cv=none; b=CmeEvvOwPSXL82OKf+rUdZPaqEg1ThQ6xtXOlcHHMjo4zOXQuDawLkU29dtTWiC3oTOI82k1j014AklbSj/btVSu87P/ZodHXfuGLfkGx5DXtF2BVt3IGRlQkgSLnmsOocKSyJPGj25H4vM8Xs3w/hhUDBQHomnf9V/N3xkh8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207019; c=relaxed/simple;
	bh=3IXZMlLqYK+fUUIJj6j+HqWjW2huSssVwLxqNpAYLfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiCCKIDLJQMhAQ9xpuQEuhhHxnUWCD6T5N5QdlBsFcggKomOgeMRAoTtnc+LCnQqxXLkQtSYWybwAzK6wnXiiZOVsb9ZhGXvuFAy/AbjPRa1fBpNpnhaaYkAEX4eD9ajgTNnVzQYCs5bYuoHWa2269wpoItjzy8h+n2ZN/HE6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V61K5kZ3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751207016; x=1782743016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3IXZMlLqYK+fUUIJj6j+HqWjW2huSssVwLxqNpAYLfs=;
  b=V61K5kZ3Myi64vdV2M0tstjpdVArQ/0P4syDuSgA2IoC3KWeMDsFGKV+
   u0dx4RskcPMt/rztI3fwJRKAYu/1J03MqfXst1j65+sKtG5TMxbl7b073
   ESWEHYWtkfSPPigFSon/BZGoEdJewg4d0/FqbFo7nmVagt2FXDUrISzRI
   vyM0PGHSj7SxyZdOfaV+OeCRiSmx8Q4q+vHEZlHY9LLuVwfvHQBRJ2uRc
   dzODH2+5Hnf/SIvTa5r20d6i9kKeGYh43XrmaQtECOsQhr4TqYQuVKqBx
   RAOLIokUXfE1nGYRWiazgkgtW6IbH7caDlVe++xcStLH77ZkKfzFyal4r
   g==;
X-CSE-ConnectionGUID: GkEdYgviQPyftOtgUwHm+A==
X-CSE-MsgGUID: 8/iWhMdgSIi6uGYFTK0UeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="57126380"
X-IronPort-AV: E=Sophos;i="6.16,275,1744095600"; 
   d="scan'208";a="57126380"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2025 07:23:36 -0700
X-CSE-ConnectionGUID: x+PxDHTZRiimHaKV1OkFyw==
X-CSE-MsgGUID: B9V29v5aTvy1XkNs/n+NsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,275,1744095600"; 
   d="scan'208";a="152969829"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Jun 2025 07:23:31 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uVswL-000Xzm-1f;
	Sun, 29 Jun 2025 14:23:29 +0000
Date: Sun, 29 Jun 2025 22:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>, linux-clk@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, daniel@makrotopia.org, ericwouds@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joseph.lin@airoha.com,
	wenshin.chung@airoha.com, lucien.jheng@airoha.com,
	albert-al.lee@airoha.com, "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: Re: [PATCH v1 net-next PATCH 1/1] net: phy: air_en8811h: Introduce
 resume/suspend and clk_restore_context to ensure correct CKO settings after
 network interface reinitialization.
Message-ID: <202506292222.nBaJywJw-lkp@intel.com>
References: <20250629115911.51392-1-lucienzx159@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629115911.51392-1-lucienzx159@gmail.com>

Hi Lucien.Jheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Lucien-Jheng/net-phy-air_en8811h-Introduce-resume-suspend-and-clk_restore_context-to-ensure-correct-CKO-settings-after-network-interf/20250629-200137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250629115911.51392-1-lucienzx159%40gmail.com
patch subject: [PATCH v1 net-next PATCH 1/1] net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
config: arm-randconfig-004-20250629 (https://download.01.org/0day-ci/archive/20250629/202506292222.nBaJywJw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250629/202506292222.nBaJywJw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506292222.nBaJywJw-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__clk_get_enable_count" [drivers/net/phy/air_en8811h.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

