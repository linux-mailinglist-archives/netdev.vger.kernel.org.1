Return-Path: <netdev+bounces-203060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8694EAF06FC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475F04E01D2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1929F26E701;
	Tue,  1 Jul 2025 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIJwu/i5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC37226D14
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751413167; cv=none; b=Dh2QTXjrCJC3/KUQwei6VR8OOH5EKuQ3JtqLpsVfLZkyu6r79qdAHbkOH51rN6V3s5Srm/IHqQSiqZK5vbcHpUz0LGjRdPjrb2O/R1LVid72YVxTTCgTem1dqmn54xeQ7nYcqV7EKrCEZthk3s4pUNcsqjzI1SscdbHBGMSWraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751413167; c=relaxed/simple;
	bh=yYf9EOICqZsl+xCkOeF5qUltMH5rv9OAeeVhXj8Ajd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFnZG7dsQMbMzf5il9fMMYho8jPyBGlVKLRPOtTiT652D5VGtps3ioDJ2C53QYsCrKC/jquGe06nyxq/BMYsSYeEUsMrCxiUJ/322OUR3RkCnZx2CFiuIaN+hqn57Pbrug0fB4dHiySSXmrCdFDE2AJMB6igudaCxCKYqe7P2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIJwu/i5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751413164; x=1782949164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yYf9EOICqZsl+xCkOeF5qUltMH5rv9OAeeVhXj8Ajd4=;
  b=AIJwu/i5quJUJsF0S6hj0Cm/MyDaI5Ayq4wCSxAqR9NmcfhHi0RbHTYw
   j4CJi056056f4pbPOKhCbvSD4xIdz0trgo9iHcFKakA2GPQZNGy8Rj3F6
   w7prw5Vu+AvSBVd7+za0Xuh+GuAveVFjm19jkQM7BqFPz3JRVCV/RgA+N
   kHMzS4OU0J9Ijp6BPGVtfYPFzGxWYq3B3VX0xBii3bOyDqSWLv3HAHQ1d
   FqDczQPG0pwjRoNLcRbRRTsEHgLnNw2ab/sPU62BlIIBGPeL34Zv4M80Z
   D47LKaGtK2S7Ohbgd6p43c9FMZspWrtIsacxjd82gbfNizqLoWSTvHdjb
   w==;
X-CSE-ConnectionGUID: 27fiC20OS0u4PgTFZKnVsw==
X-CSE-MsgGUID: aMa39cxXRCWWZkmOdTJG7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="64744818"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="64744818"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 16:39:22 -0700
X-CSE-ConnectionGUID: ciClxTy/RtaiPxv8HpaACw==
X-CSE-MsgGUID: lAVSRqjxQZupZ8SU76PVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; 
   d="scan'208";a="153374470"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 01 Jul 2025 16:39:22 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWkZL-000amY-1Q;
	Tue, 01 Jul 2025 23:39:19 +0000
Date: Wed, 2 Jul 2025 07:39:17 +0800
From: kernel test robot <lkp@intel.com>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH v3 iwl-next] ice: add recovery clock and clock 1588
 control for E825c
Message-ID: <202507020615.CBjCysqA-lkp@intel.com>
References: <20250701152244.366226-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701152244.366226-1-grzegorz.nitka@intel.com>

Hi Grzegorz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7d0ed75968573290cf921ae6f6ee0e985d8beab9]

url:    https://github.com/intel-lab-lkp/linux/commits/Grzegorz-Nitka/ice-add-recovery-clock-and-clock-1588-control-for-E825c/20250701-232553
base:   7d0ed75968573290cf921ae6f6ee0e985d8beab9
patch link:    https://lore.kernel.org/r/20250701152244.366226-1-grzegorz.nitka%40intel.com
patch subject: [PATCH v3 iwl-next] ice: add recovery clock and clock 1588 control for E825c
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250702/202507020615.CBjCysqA-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507020615.CBjCysqA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507020615.CBjCysqA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:2115 Excess function parameter 'divider' description in 'ice_dpll_cfg_synce_ethdiv_e825c'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

