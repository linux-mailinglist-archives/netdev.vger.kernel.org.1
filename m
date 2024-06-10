Return-Path: <netdev+bounces-102163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B2901B78
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38CB1C21080
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859111B5A4;
	Mon, 10 Jun 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dst6LuXi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB1803A;
	Mon, 10 Jun 2024 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002568; cv=none; b=cFBMAVE7MDKbAwfNlEBHzV/gK0HRuUkAImfggglY4DeAlnInQyHuYe/VEvA1/r7zeep7HtwM7Rp7M0aj2nLnB1XWvNMynhOmqRRMrwDdzpT3adglZ2Gi7zUoW/DNGSHa4NEbAvXKrPR4p+b5SOEjFmh++YVknSLYLU837+fnMwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002568; c=relaxed/simple;
	bh=9x5lfg5IbS2UuO0/g8a59A4OC0SvPJLLx6ic7z+Xr14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feoX356+eXtScsIFFCXBXfu0+ezha+r+VCnNVx4ypw9NGjQ8D8MsJw8bAhAVsGK7Lw4CproqHVvtFdsAXqXabT75GIrOvPojJhfRBxbTvtekB1ZwGR0QThFplY93cfGjjVqsXElsRrwPOKOVMXsWkP7aSQtwBfmAcAlfF/7VQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dst6LuXi; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718002565; x=1749538565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9x5lfg5IbS2UuO0/g8a59A4OC0SvPJLLx6ic7z+Xr14=;
  b=Dst6LuXigxP6RhLsFmHPU6jXxwa35csGmG0m316mDIh6AeauVKWdqOau
   QUqvcmeR4oROwe3i3pzeZfFRw2jsOPAi6nlMKkZcePvcz0JUFW1EGaMCd
   eNntt/JGIFJnjr5W2TSlNa1Ul57kUPAQKrjXZx+y5muHON/D42Zwt/8yh
   8CAsoZq7W09TikxPBTeH0yKjF3qIUZP+1XQayOCGAQCW8GMLmncgJkFFb
   9Adyj5T7cx6z5NV6+pMwSrffL1lAEWISk9F9oPIXtJ0zIhDZVFvppeqtv
   Gmqd1TcSchDLi7FyevtOnAIC5twDUj7vqNROh11RcTMj955cXwbjjiPPD
   w==;
X-CSE-ConnectionGUID: Ua7UZcqNR1GUI1hTBkZ19A==
X-CSE-MsgGUID: D4KHS+0rRSy1P86OYU+U/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="37173137"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="37173137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 23:56:05 -0700
X-CSE-ConnectionGUID: e8ykSEwdS3G3DA5FIAt9wA==
X-CSE-MsgGUID: /5hJAPHkQaCvwzCCQyfC/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="76428104"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 09 Jun 2024 23:56:02 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGYwh-0001vE-2E;
	Mon, 10 Jun 2024 06:55:59 +0000
Date: Mon, 10 Jun 2024 14:55:15 +0800
From: kernel test robot <lkp@intel.com>
To: Richard chien <m8809301@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard chien <richard.chien@hpe.com>
Subject: Re: [PATCH] igb: Add support for firmware update
Message-ID: <202406101404.oWWqbJmG-lkp@intel.com>
References: <20240609081526.5621-1-richard.chien@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609081526.5621-1-richard.chien@hpe.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on tnguy-net-queue/dev-queue linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-chien/igb-Add-support-for-firmware-update/20240609-162047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20240609081526.5621-1-richard.chien%40hpe.com
patch subject: [PATCH] igb: Add support for firmware update
config: alpha-randconfig-r112-20240610 (https://download.01.org/0day-ci/archive/20240610/202406101404.oWWqbJmG-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240610/202406101404.oWWqbJmG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406101404.oWWqbJmG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:923:34: sparse: sparse: cast to restricted __le16
   drivers/net/ethernet/intel/igb/igb_ethtool.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/stackdepot.h, ...):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +923 drivers/net/ethernet/intel/igb/igb_ethtool.c

   874	
   875	static int igb_get_eeprom(struct net_device *netdev,
   876	                          struct ethtool_eeprom *eeprom, u8 *bytes)
   877	{
   878	        struct igb_adapter *adapter = netdev_priv(netdev);
   879	        struct e1000_hw *hw = &adapter->hw;
   880	        u16 *eeprom_buff;
   881	        int first_word, last_word;
   882	        int ret_val = 0;
   883	        struct e1000_nvm_access *nvm;
   884	        u32 magic;
   885	        u16 i;
   886	
   887	        if (eeprom->len == 0)
   888	                return -EINVAL;
   889	
   890	        magic = hw->vendor_id | (hw->device_id << 16);
   891	        if (eeprom->magic && eeprom->magic != magic) {
   892	                nvm = (struct e1000_nvm_access *)eeprom;
   893	                ret_val = igb_nvmupd_command(hw, nvm, bytes);
   894	                return ret_val;
   895	        }
   896	          
   897	        /* normal ethtool get_eeprom support */
   898	        eeprom->magic = hw->vendor_id | (hw->device_id << 16);
   899	
   900	        first_word = eeprom->offset >> 1;
   901	        last_word = (eeprom->offset + eeprom->len - 1) >> 1;
   902	
   903	        eeprom_buff = kmalloc(sizeof(u16) *
   904	                        (last_word - first_word + 1), GFP_KERNEL);
   905	        if (!eeprom_buff)
   906	                return -ENOMEM;
   907	
   908	        if (hw->nvm.type == e1000_nvm_eeprom_spi)
   909	                ret_val = e1000_read_nvm(hw, first_word,
   910	                                         last_word - first_word + 1,
   911	                                         eeprom_buff);
   912	        else {
   913	                for (i = 0; i < last_word - first_word + 1; i++) {
   914	                        ret_val = e1000_read_nvm(hw, first_word + i, 1,
   915	                                                 &eeprom_buff[i]);
   916	                        if (ret_val)
   917	                                break;
   918	                }
   919	        }
   920	
   921	        /* Device's eeprom is always little-endian, word addressable */
   922	        for (i = 0; i < last_word - first_word + 1; i++)
 > 923	                eeprom_buff[i] = le16_to_cpu(eeprom_buff[i]);
   924	
   925	        memcpy(bytes, (u8 *)eeprom_buff + (eeprom->offset & 1),
   926	                        eeprom->len);
   927	        kfree(eeprom_buff);
   928	
   929	        return ret_val;
   930	}
   931	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

