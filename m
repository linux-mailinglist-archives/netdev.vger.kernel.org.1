Return-Path: <netdev+bounces-64454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CCE8332E3
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 07:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7BF1F228CB
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB717D4;
	Sat, 20 Jan 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YG3+J9a4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D791858
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705730854; cv=none; b=Qef8F34ggmXwDYZomZIXyZB6EBc/ww9qqynLsYVFTU0ubdFng4J5zV4ztjdnJ62Pz+cmt9NIF8NwWWgJSUCxaCX4j2VZ5qoK3Rj8ssUiqnAMFcHjvYcxUTQ50iShSoQCeV1IwrPxfpiiScMZjs9tTFuddQwNSFYQpHJP5Y4qu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705730854; c=relaxed/simple;
	bh=jQVnWfL86YNXRWj9shatjvqBq84vyVtxuPx6nMvurKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLSRxKWxOQsf1EnDVuD9d/Kp7iB6QeB0DFD3ncD63x2NTPRIDjYYgN9qIl7Tvu9N1SkET0PSDZZa8GSu2XzQ7P3LcJzk8bIDR7MNHdQh/WI7GTLGNTGSdafj6PxtLXBMstLTz4ft/IIqIDbwUnrqHEWGyqMDBeEvfGmXWDHnUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YG3+J9a4; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705730851; x=1737266851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQVnWfL86YNXRWj9shatjvqBq84vyVtxuPx6nMvurKI=;
  b=YG3+J9a4rNqky0xilCxBs9DDHx53ImjmllesZuWT/35oGw+Ff20VwH4C
   dvmkrAy3LBofhl/4q3Q79SstdCoFKy2Qlhmzw2miZna7FcKzXZIzwfPTh
   Y5u1kkdYQfvvmN5Urcz9SJdKEkpxykqhtQtWc3j4nc0SRhvYvGbsiVzQV
   L7Fv+HqQq4XPnxfDKO8GeYci8mH4tjtcoc18RqS6qhQ2tjTXOtsma3ypB
   92M1vKB+bNAGezBNKDEnlIQg1b/0AQr+Od8rkqdPbcEalqEAq8gK3EbPu
   /OKXTzNXS1zihjcsmJgK3b66ZxNcQz9LIyAP9p5x6V9IgaM7fduj7L5xF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="487061195"
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="487061195"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 22:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,207,1701158400"; 
   d="scan'208";a="723817"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jan 2024 22:07:28 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rR4Vq-0004o0-1T;
	Sat, 20 Jan 2024 06:07:26 +0000
Date: Sat, 20 Jan 2024 14:06:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-next v3 3/3] ixgbe: Cleanup after type convertion
Message-ID: <202401201343.wjSFEBK2-lkp@intel.com>
References: <20240118134332.470907-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118134332.470907-3-jedrzej.jagielski@intel.com>

Hi Jedrzej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Jedrzej-Jagielski/ixgbe-Fix-smatch-warnings-after-type-convertion/20240119-015659
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20240118134332.470907-3-jedrzej.jagielski%40intel.com
patch subject: [PATCH iwl-next v3 3/3] ixgbe: Cleanup after type convertion
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20240120/202401201343.wjSFEBK2-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401201343.wjSFEBK2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401201343.wjSFEBK2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c: In function 'ixgbe_setup_mac_link_82599':
   drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c:774:34: error: 'autoc2' undeclared (first use in this function)
     774 |         u32 pma_pmd_10g_serial = autoc2 & IXGBE_AUTOC2_10G_SERIAL_PMA_PMD_MASK;
         |                                  ^~~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c:774:34: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c:776:13: warning: unused variable 'autoc2' [-Wunused-variable]
     776 |         u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
         |             ^~~~~~


vim +/autoc2 +776 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c

   761	
   762	/**
   763	 *  ixgbe_setup_mac_link_82599 - Set MAC link speed
   764	 *  @hw: pointer to hardware structure
   765	 *  @speed: new link speed
   766	 *  @autoneg_wait_to_complete: true when waiting for completion is needed
   767	 *
   768	 *  Set the link speed in the AUTOC register and restarts link.
   769	 **/
   770	static int ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
   771					      ixgbe_link_speed speed,
   772					      bool autoneg_wait_to_complete)
   773	{
   774		u32 pma_pmd_10g_serial = autoc2 & IXGBE_AUTOC2_10G_SERIAL_PMA_PMD_MASK;
   775		ixgbe_link_speed link_capabilities = IXGBE_LINK_SPEED_UNKNOWN;
 > 776		u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
   777		u32 pma_pmd_1g, link_mode, links_reg, i;
   778		bool autoneg = false;
   779		int status;
   780	
   781		/* holds the value of AUTOC register at this current point in time */
   782		u32 current_autoc = IXGBE_READ_REG(hw, IXGBE_AUTOC);
   783		/* holds the cached value of AUTOC register */
   784		u32 orig_autoc = 0;
   785		/* temporary variable used for comparison purposes */
   786		u32 autoc = current_autoc;
   787	
   788		/* Check to see if speed passed in is supported. */
   789		status = hw->mac.ops.get_link_capabilities(hw, &link_capabilities,
   790							   &autoneg);
   791		if (status)
   792			return status;
   793	
   794		speed &= link_capabilities;
   795	
   796		if (speed == IXGBE_LINK_SPEED_UNKNOWN)
   797			return -EINVAL;
   798	
   799		/* Use stored value (EEPROM defaults) of AUTOC to find KR/KX4 support*/
   800		if (hw->mac.orig_link_settings_stored)
   801			orig_autoc = hw->mac.orig_autoc;
   802		else
   803			orig_autoc = autoc;
   804	
   805		link_mode = autoc & IXGBE_AUTOC_LMS_MASK;
   806		pma_pmd_1g = autoc & IXGBE_AUTOC_1G_PMA_PMD_MASK;
   807	
   808		if (link_mode == IXGBE_AUTOC_LMS_KX4_KX_KR ||
   809		    link_mode == IXGBE_AUTOC_LMS_KX4_KX_KR_1G_AN ||
   810		    link_mode == IXGBE_AUTOC_LMS_KX4_KX_KR_SGMII) {
   811			/* Set KX4/KX/KR support according to speed requested */
   812			autoc &= ~(IXGBE_AUTOC_KX4_KX_SUPP_MASK | IXGBE_AUTOC_KR_SUPP);
   813			if (speed & IXGBE_LINK_SPEED_10GB_FULL) {
   814				if (orig_autoc & IXGBE_AUTOC_KX4_SUPP)
   815					autoc |= IXGBE_AUTOC_KX4_SUPP;
   816				if ((orig_autoc & IXGBE_AUTOC_KR_SUPP) &&
   817				    (hw->phy.smart_speed_active == false))
   818					autoc |= IXGBE_AUTOC_KR_SUPP;
   819			}
   820			if (speed & IXGBE_LINK_SPEED_1GB_FULL)
   821				autoc |= IXGBE_AUTOC_KX_SUPP;
   822		} else if ((pma_pmd_1g == IXGBE_AUTOC_1G_SFI) &&
   823			   (link_mode == IXGBE_AUTOC_LMS_1G_LINK_NO_AN ||
   824			    link_mode == IXGBE_AUTOC_LMS_1G_AN)) {
   825			/* Switch from 1G SFI to 10G SFI if requested */
   826			if ((speed == IXGBE_LINK_SPEED_10GB_FULL) &&
   827			    (pma_pmd_10g_serial == IXGBE_AUTOC2_10G_SFI)) {
   828				autoc &= ~IXGBE_AUTOC_LMS_MASK;
   829				autoc |= IXGBE_AUTOC_LMS_10G_SERIAL;
   830			}
   831		} else if ((pma_pmd_10g_serial == IXGBE_AUTOC2_10G_SFI) &&
   832			   (link_mode == IXGBE_AUTOC_LMS_10G_SERIAL)) {
   833			/* Switch from 10G SFI to 1G SFI if requested */
   834			if ((speed == IXGBE_LINK_SPEED_1GB_FULL) &&
   835			    (pma_pmd_1g == IXGBE_AUTOC_1G_SFI)) {
   836				autoc &= ~IXGBE_AUTOC_LMS_MASK;
   837				if (autoneg)
   838					autoc |= IXGBE_AUTOC_LMS_1G_AN;
   839				else
   840					autoc |= IXGBE_AUTOC_LMS_1G_LINK_NO_AN;
   841			}
   842		}
   843	
   844		if (autoc != current_autoc) {
   845			/* Restart link */
   846			status = hw->mac.ops.prot_autoc_write(hw, autoc, false);
   847			if (status)
   848				return status;
   849	
   850			/* Only poll for autoneg to complete if specified to do so */
   851			if (autoneg_wait_to_complete) {
   852				if (link_mode == IXGBE_AUTOC_LMS_KX4_KX_KR ||
   853				    link_mode == IXGBE_AUTOC_LMS_KX4_KX_KR_1G_AN ||
   854				    link_mode == IXGBE_AUTOC_LMS_KX4_KX_KR_SGMII) {
   855					links_reg = 0; /*Just in case Autoneg time=0*/
   856					for (i = 0; i < IXGBE_AUTO_NEG_TIME; i++) {
   857						links_reg =
   858						       IXGBE_READ_REG(hw, IXGBE_LINKS);
   859						if (links_reg & IXGBE_LINKS_KX_AN_COMP)
   860							break;
   861						msleep(100);
   862					}
   863					if (!(links_reg & IXGBE_LINKS_KX_AN_COMP)) {
   864						status = -EIO;
   865						hw_dbg(hw, "Autoneg did not complete.\n");
   866					}
   867				}
   868			}
   869	
   870			/* Add delay to filter out noises during initial link setup */
   871			msleep(50);
   872		}
   873	
   874		return status;
   875	}
   876	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

