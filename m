Return-Path: <netdev+bounces-117002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31B94C4D2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181661C20BFA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18E13774A;
	Thu,  8 Aug 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOa996a6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEE146D6F
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142707; cv=none; b=PbXMdbubfchiLNLlnxrIa79MHoYapyEmwmpKRBYHlU6CfqYSYeuqBv1KYtl+SWmWw4MBQCDD8+8yVdaVw4mjl5M5i15bHsTFDIHHW/GWdSEqO7B4SisZ/UdiTJaJi+HEGDcur/Gt7+OXi01HQyAprg4oD8G4XfnLr/NU8FPPtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142707; c=relaxed/simple;
	bh=S3jI97eXS4xdujSpqv7QnBeHMxczJyVODGS5bRHsHzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObAyeLfgaAYLooY7XqF6mXvIGUPNqtpdfF3thQSPKaQY3qrI50uURmduSes7RDhrKgtxnPhLfKvK9Nx2XHjiCBC7uCNA5LKIWQczWiWcEk1XKBkmLWQo+b3UfNDNMbCMKrdLReFwohxfRLjdE27MDi36FJLDHJkYosDDVLnk1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HOa996a6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723142705; x=1754678705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3jI97eXS4xdujSpqv7QnBeHMxczJyVODGS5bRHsHzA=;
  b=HOa996a6lwvP955aXELof1ySbki70+ZPphxmmGdWJvtpPufGtfkENO63
   uXyCXOdaZuuSS54FCMniKFGxWBARScDboMlgP3QNQvkwkikOi2gEeo4xl
   hFL5+rOJRp9eUQFlHDWVR9e+BlKL7KvCIIrwa+ryK9iU0AvRYrt+XwPFo
   sNV6GbtcWx2KtU0WdQK8svB64DmwIGR8J63b8+L50G49SASqDxLm58Tet
   wrbSB0OoUMD3ECyT5CTFrJEfTdkOTiWckFcyAv1+aoUIug+AZV5Yfqkwu
   v61ADXRtXP11snioOefCQ3Vsg1BvCry0xHLys/tyNm32IcfY9tQh0RMiL
   A==;
X-CSE-ConnectionGUID: lWPhoQGASIWee7svd+beIw==
X-CSE-MsgGUID: CmkNG3HyS4OX6yJ0zMUGhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31964776"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="31964776"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:45:05 -0700
X-CSE-ConnectionGUID: udR9EZjrTzeVbeKBg4SoRw==
X-CSE-MsgGUID: xfRe5Up4Sri8qMIACKliLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="80548693"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 08 Aug 2024 11:45:03 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sc888-0006Q4-0I;
	Thu, 08 Aug 2024 18:44:58 +0000
Date: Fri, 9 Aug 2024 02:44:11 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@chopps.org>
Subject: Re: [PATCH ipsec-next v9 11/17] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <202408090204.4R0W11cX-lkp@intel.com>
References: <20240807211331.1081038-12-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807211331.1081038-12-chopps@chopps.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on netfilter-nf/main linus/master v6.11-rc2]
[cannot apply to klassert-ipsec/master nf-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hopps/net-refactor-common-skb-header-copy-code-for-re-use/20240808-073926
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240807211331.1081038-12-chopps%40chopps.org
patch subject: [PATCH ipsec-next v9 11/17] xfrm: iptfs: add fragmenting of larger than MTU user packets
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240809/202408090204.4R0W11cX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408090204.4R0W11cX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408090204.4R0W11cX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8data.o
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/unicode/utf8-selftest.o
WARNING: modpost: missing MODULE_DESCRIPTION() in security/apparmor/apparmor_policy_unpack_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/find_bit_benchmark.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/cpumask_kunit.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bitmap.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/mxc-clk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/hd44780_common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
>> ERROR: modpost: "___copy_skb_header" [net/xfrm/xfrm_iptfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

