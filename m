Return-Path: <netdev+bounces-149126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885B9E45B5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30FB28522F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1103152E1C;
	Wed,  4 Dec 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nC6RrKHz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EE2391A2
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 20:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733344222; cv=none; b=EYTcw9x+0Z1Q5cRcgnfjb042O1Jl62jkJpE30mFdci6da21xZus3zcsRPsqj8UJdkF3CCdhWG53ue6GB2XtZ4jh13SeKG44xHGsSKv0YgZIjrkbQqz+s3qc0tV305T2fIhr62DTJskqtlo/yiK++BqtWal0PLgRlY1wuIcDwrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733344222; c=relaxed/simple;
	bh=Hqvk2t+BsLSphs4WfQUre5lwOKVlFGQ6Nxe5CPShoMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/sFRCEeOr//XzHWq8Wk2MBsyn+1M+SR9hiYWx+h1+HrkBT6ZXHUkatP89z09nivlYKlj7A7Doetv2ze1SNam7a2QtMEXZzUFVnLzkAqKFDQe3ijEMcrNa5WtiIzQWO9vBOS665NiHHxV6oBO2OifQY+H9cyO8yx4Fq2l8s2Nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nC6RrKHz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733344220; x=1764880220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hqvk2t+BsLSphs4WfQUre5lwOKVlFGQ6Nxe5CPShoMA=;
  b=nC6RrKHzVubJUglLj+0DqckszGyN5hubIROfoScUgpTfOEZK5q3TnWoS
   nTluqMFiYjnE+4oUkfgDXWUWMCIzYpf57NQnYAoyVcMDrDkgvcRSJ0UbC
   ljwTJLyVoPQAmyDl5HTNuqza7r5owbpAidVnLV3uq6HOp5xs55wu0AGFe
   vHCJSfpNPbPTtxtU0fczZmYBT24MCmyZhxJkYf8Lcn6/sz+Zlq55m8kyr
   A6wdXL9Gi6M4lt3mECyLNBhEpDX1Prxpj7F0mWqzAPT4LY46rx12sZXsg
   QK8EGYEvFr1aNGCn5TcFP/zfwAaGukIQJKuIU6BLax1aL4sLdKecONRAl
   g==;
X-CSE-ConnectionGUID: TE/v5xJnQRa2kime5XkjIw==
X-CSE-MsgGUID: zA6dHgNvRT2j2NozS5mjFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33550822"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33550822"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:30:20 -0800
X-CSE-ConnectionGUID: IrFc6JW0RjSOHUrx4Mgv3w==
X-CSE-MsgGUID: adn2N2IWTPuik/VHoASs1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="93951250"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Dec 2024 12:30:19 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIw0m-0003Sf-0y;
	Wed, 04 Dec 2024 20:30:16 +0000
Date: Thu, 5 Dec 2024 04:29:39 +0800
From: kernel test robot <lkp@intel.com>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v11 5/8] ixgbe: Add support
 for EEPROM dump in E610 device
Message-ID: <202412050450.s26ZxK1U-lkp@intel.com>
References: <20241204143112.29411-6-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204143112.29411-6-piotr.kwapulinski@intel.com>

Hi Piotr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Piotr-Kwapulinski/ixgbe-Add-support-for-E610-FW-Admin-Command-Interface/20241204-223603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20241204143112.29411-6-piotr.kwapulinski%40intel.com
patch subject: [Intel-wired-lan] [PATCH iwl-next v11 5/8] ixgbe: Add support for EEPROM dump in E610 device
config: i386-buildonly-randconfig-003 (https://download.01.org/0day-ci/archive/20241205/202412050450.s26ZxK1U-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050450.s26ZxK1U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050450.s26ZxK1U-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c:2083: warning: expecting prototype for ixgbe_init_eeprom_params_E610(). Prototype was for ixgbe_init_eeprom_params_e610() instead


vim +2083 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c

  2072	
  2073	/**
  2074	 * ixgbe_init_eeprom_params_E610 - Initialize EEPROM params
  2075	 * @hw: pointer to hardware structure
  2076	 *
  2077	 * Initialize the EEPROM parameters ixgbe_eeprom_info within the ixgbe_hw
  2078	 * struct in order to set up EEPROM access.
  2079	 *
  2080	 * Return: the operation exit code
  2081	 */
  2082	int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw)
> 2083	{
  2084		struct ixgbe_eeprom_info *eeprom = &hw->eeprom;
  2085		u32 gens_stat;
  2086		u8 sr_size;
  2087	
  2088		if (eeprom->type != ixgbe_eeprom_uninitialized)
  2089			return 0;
  2090	
  2091		eeprom->type = ixgbe_flash;
  2092	
  2093		gens_stat = IXGBE_READ_REG(hw, GLNVM_GENS);
  2094		sr_size = FIELD_GET(GLNVM_GENS_SR_SIZE_M, gens_stat);
  2095	
  2096		/* Switching to words (sr_size contains power of 2). */
  2097		eeprom->word_size = BIT(sr_size) * IXGBE_SR_WORDS_IN_1KB;
  2098	
  2099		hw_dbg(hw, "Eeprom params: type = %d, size = %d\n", eeprom->type,
  2100		       eeprom->word_size);
  2101	
  2102		return 0;
  2103	}
  2104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

