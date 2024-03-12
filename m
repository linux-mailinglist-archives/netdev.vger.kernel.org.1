Return-Path: <netdev+bounces-79346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D5A878D00
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626521C20C45
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF316FF2B;
	Tue, 12 Mar 2024 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNUxPaCz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7123A0
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210610; cv=none; b=qOD/2mruXjz1CnCilV5r6daDTv2wnSflHgaNTIUV5CA9hk8McqfN0I/vdRdYiIBD3HSsiEAr9OYImIjCYinf2SV7tBnurswZZTMA2R2k40N55zamJ2eralubUREVgUuCOGxVdKIHrDCfS8NchTQA8k3NquThzQaG+XVE+tK5ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210610; c=relaxed/simple;
	bh=yEnH/acpM541agRe7qHU1yFlavkSJr3HsbepFl8mdmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZcU04c9qJDo/jvU6UzSZ7z6Jg+idBwt7o4uC7S4UPinpfZntEyxBs+W6YG+V/Y7tgDQYpGg6WS5/QFpgHRNKL9Nwclk/s8mzjmAYAZ6PpyYy/twY2BtYgIC4xAw8tYoqRQ5XpkynE6qAZzMBudaJyOa4MNUfqiPlLsx7Q1FGJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNUxPaCz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710210608; x=1741746608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yEnH/acpM541agRe7qHU1yFlavkSJr3HsbepFl8mdmI=;
  b=gNUxPaCzcSzsDHvTp0pES9qmxJeqU9ds0cPlutFtfBueFnnvtzIqWNoY
   EPt4xEUVeLNzPo3dxvfaS1B11po/+2puwtcd8K7x4ONwaDSiUq47W+vDY
   DeUiF2xotZgCnIUmlniNerxAuz4XMzUXm/CzpERmV9Nb75ScsXbwJnOlA
   A+tqXmb1x3ji3neHppqSm/yohL2T1yfsGqX3ziNNTRFgYNz0odoKD6sUk
   uSmqMC7KMDwhJv2tos533U9ZwYzNO3NlE00EwFAOzNFC8YBtkgwnLgZWr
   gUu5T3QZ+3NKhArHIciHKXF3U492KWofTSxj3w7sfE41MWRiXrfwKJ3Dp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16344364"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16344364"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 19:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="42290517"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Mar 2024 19:30:07 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjru0-0009fB-1i;
	Tue, 12 Mar 2024 02:30:04 +0000
Date: Tue, 12 Mar 2024 10:29:16 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: [net-next:main 4/19] WARNING: modpost: vmlinux: section mismatch in
 reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <202403121032.WDY8ftKq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   f095fefacdd35b4ea97dc6d88d054f2749a73d07
commit: de5f84338970815b9fdd3497a975fb572d11e0b5 [4/19] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
config: xtensa-randconfig-001-20240311 (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403121032.WDY8ftKq-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x58 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

