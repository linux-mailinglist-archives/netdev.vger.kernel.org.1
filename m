Return-Path: <netdev+bounces-100745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE68FBD7C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB748283FEB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2711214B090;
	Tue,  4 Jun 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwS770UD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81B14658E;
	Tue,  4 Jun 2024 20:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534039; cv=none; b=U/inbtydOwcdhPtZmHHsVGTPIKNl4Ti4m1HzNab9oTXZ3cZgAD8VJLgEqKE9/sjznVVDxOsKCAl7nfLtUXrNJJfQGD+nZutxIRuKLY4qMbfJLA3n9DvYV+Q8h8Ncm9dOEBCym2P4RocrA+wJIxuWf/QkTSj94wZHzHKANs7cqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534039; c=relaxed/simple;
	bh=IJFHMgoH26v1CExj3lKJDiXLct4JZFh9UhxQh1Qp0Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqp7JvNAd0OiSfpqK/iufPWwheJyiX0Ndz3ESbDqGmLTGC4CRWxiG3DYihaJSEDHwBEauaKCM6RvFd7xaUMB9j/GTKIuuLGCnKHpzT1nn3wkPAFaC/l/9T8WN4f83LV7HBYW6cTNQF1+EmU4VE1NNOJa8FRHW/NdjEqf84PHUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwS770UD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717534036; x=1749070036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IJFHMgoH26v1CExj3lKJDiXLct4JZFh9UhxQh1Qp0Us=;
  b=FwS770UDH9e+l+6Bcs8PD8fqvViYz5BKU3Ipk5QTV8bZs/EHvHqRoewO
   XAH4tfs+2njfpQnUeT37yUTiTqSW+xf0Zbif0M4HScGrckQZhjTXzi+sX
   rnXvX/mjmkafXGirflt8GKGARDn9Mj/ht1Zrx8KzPJSt8qN6KccH+Owk4
   DPtNmIECqH6pu9GVn23m+00vEDgpBHaaiB6dvrOW/qO9psFzgL7mnJA7w
   q/xdZQmcDMw3KijfAeiZn0HAvfh4wCMwsNGlkJFnPMs5pjTgmSgQo3rZH
   KDyuH5BIle+gd3+bWYGdT3xlkRtUoSlFqLWSo7PiQtwbtuBboca+jMpuu
   A==;
X-CSE-ConnectionGUID: PYjZusSYRB+qWdm/f60T4g==
X-CSE-MsgGUID: Flh8R03rTr+61y1VjfGoYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25515467"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="25515467"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 13:47:15 -0700
X-CSE-ConnectionGUID: e4kRaR4lTd2p5eemiru3sg==
X-CSE-MsgGUID: +N5m/9ZMRtCMdFewntT/4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="38015444"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2024 13:47:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEb3m-0000Wp-1z;
	Tue, 04 Jun 2024 20:47:10 +0000
Date: Wed, 5 Jun 2024 04:47:01 +0800
From: kernel test robot <lkp@intel.com>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kamilh@axis.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <202406050455.vukoabPJ-lkp@intel.com>
References: <20240604133654.2626813-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604133654.2626813-4-kamilh@axis.com>

Hi Kamil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.10-rc2 next-20240604]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamil-Hor-k-2N/net-phy-bcm54811-New-link-mode-for-BroadR-Reach/20240604-214127
base:   net/main
patch link:    https://lore.kernel.org/r/20240604133654.2626813-4-kamilh%40axis.com
patch subject: [PATCH v4 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240605/202406050455.vukoabPJ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406050455.vukoabPJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406050455.vukoabPJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/broadcom.c:641:6: warning: operator '?:' has lower precedence than '|'; '|' will be evaluated first [-Wbitwise-conditional-parentheses]
                   on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
                   ~~ ^
   drivers/net/phy/broadcom.c:641:6: note: place parentheses around the '|' expression to silence this warning
                   on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
                   ~~ ^
   drivers/net/phy/broadcom.c:641:6: note: place parentheses around the '?:' expression to evaluate it first
                   on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
                   ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +641 drivers/net/phy/broadcom.c

   614	
   615	static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
   616	{
   617		int reg;
   618		int err;
   619	
   620		reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
   621	
   622		if (on)
   623			reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
   624		else
   625			reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
   626	
   627		err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL, reg);
   628		if (err)
   629			return err;
   630	
   631		/* Update the abilities based on the current brr on/off setting */
   632		err = bcm54811_read_abilities(phydev);
   633		if (err)
   634			return err;
   635	
   636		/* Ensure LRE or IEEE register set is accessed according to the brr on/off,
   637		 *  thus set the override
   638		 */
   639		return bcm_phy_write_exp(phydev, BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL,
   640			BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN |
 > 641			on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
   642	}
   643	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

