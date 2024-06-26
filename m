Return-Path: <netdev+bounces-107069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D79919ACF
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F131F274EE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476519309C;
	Wed, 26 Jun 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdyOxEX+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CA193072;
	Wed, 26 Jun 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719441769; cv=none; b=R3MtBfRK8asC4tGLlY6HsFgzSQfP55jv1rMN6yYn2oK9i5kbMNCIdNr0xWc7dH//7y7GBMw7Up/egvU37pHj7Rj8tiVxospwPJLhalQsc7uderyRkNso+uxiSuTYS7XlzumeFEjBgcNepqglTdoEVc43JYojjfeHL64SPr22u6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719441769; c=relaxed/simple;
	bh=6Gvpn1YxFj/EbKU8uOHwNsaKTjA1vZNHzno/TrAxfGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoNlvAik/6O8c7EF9oO/4LjIiLxqVJ1MEgYMdFlc/qnXrLmiRXx2NqJqm73gHF8iSB4BTRXr2h3jpecuofyrSG5AU0rr7xrG1R8nd+0qwHiduZsVDdHJbh6aenUwVvCIiByhREKHqPVhXvqdKJx3a1r5LcJ7Lbp4H1n1C3Qn87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdyOxEX+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719441768; x=1750977768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Gvpn1YxFj/EbKU8uOHwNsaKTjA1vZNHzno/TrAxfGU=;
  b=ZdyOxEX+5Nk+Z/ld5DU35XRLRknFyTXhcNM1Ojx755Am+Qi6VZwXjPCv
   IAyOgESIN9d9FO7T0dy0yJfmNA5hpAxnSgmefFjCHYsNxNbvlyZjv6fCi
   zL2nJik364mxNAbt3rEonyoylkNYVKj+7CRl4UTys8lIJ+Px57mfW2NVo
   hgr08+ER7WQrfYmA3qPOLsBJIVKdiU9b6HVw7nTqBv3XUHUoxwwUH+tM1
   +mnz5A+Q8+epybz6EHKWRk0w7GTKT0LuietxHK9U9PbMRdkxUbANFu7wO
   1/jEC9tTdpucxuHHGqxYtGGeDynC4FT1b+K4jxqYLNO0IsNFqiFKeNyFd
   A==;
X-CSE-ConnectionGUID: 0Sq7LgNIRyShsHo3doVe9Q==
X-CSE-MsgGUID: 3o1jPyeURJOZzk+o90UODQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16222940"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="16222940"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 15:42:47 -0700
X-CSE-ConnectionGUID: F6sHt5gXT8msrSf3kPT+gQ==
X-CSE-MsgGUID: PSGbGGpwTnuo8zO3f3rnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; 
   d="scan'208";a="48612906"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2024 15:42:43 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMbLd-000FdG-0g;
	Wed, 26 Jun 2024 22:42:41 +0000
Date: Thu, 27 Jun 2024 06:42:19 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202406270625.2MuBj55z-lkp@intel.com>
References: <20240625185333.23211-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625185333.23211-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc5 next-20240625]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240626-052432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240625185333.23211-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v3 3/3] mctp pcc: Implement MCTP over PCC Transport
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240627/202406270625.2MuBj55z-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad79a14c9e5ec4a369eed4adf567c22cc029863f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270625.2MuBj55z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270625.2MuBj55z-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: declaration of 'struct acpi_pci_root' will not be visible outside of this function [-Wvisibility]
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^
   drivers/net/mctp/mctp-pcc.c:214:19: error: incomplete definition of type 'struct acpi_device'
     214 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |                  ~~~~~~~~^
   include/linux/dev_printk.h:165:18: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                         ^~~
   include/linux/dynamic_debug.h:274:7: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                            ^~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/acpi.h:792:8: note: forward declaration of 'struct acpi_device'
     792 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:215:3: error: call to undeclared function 'acpi_device_hid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     215 |                 acpi_device_hid(acpi_dev));
         |                 ^
   drivers/net/mctp/mctp-pcc.c:215:3: note: did you mean 'acpi_device_dep'?
   include/acpi/acpi_bus.h:41:6: note: 'acpi_device_dep' declared here
      41 | bool acpi_device_dep(acpi_handle target, acpi_handle match);
         |      ^
   drivers/net/mctp/mctp-pcc.c:216:15: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     216 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^
   drivers/net/mctp/mctp-pcc.c:216:13: error: incompatible integer to pointer conversion assigning to 'acpi_handle' (aka 'void *') from 'int' [-Wint-conversion]
     216 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:220:20: error: incomplete definition of type 'struct acpi_device'
     220 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                          ~~~~~~~~^
   include/linux/dev_printk.h:154:44: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/acpi.h:792:8: note: forward declaration of 'struct acpi_device'
     792 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:225:17: error: incomplete definition of type 'struct acpi_device'
     225 |         dev = &acpi_dev->dev;
         |                ~~~~~~~~^
   include/linux/acpi.h:792:8: note: forward declaration of 'struct acpi_device'
     792 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:271:10: error: incomplete definition of type 'struct acpi_device'
     271 |         acpi_dev->driver_data = mctp_pcc_dev;
         |         ~~~~~~~~^
   include/linux/acpi.h:792:8: note: forward declaration of 'struct acpi_device'
     792 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:326:27: error: variable has incomplete type 'struct acpi_driver'
     326 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^
   drivers/net/mctp/mctp-pcc.c:326:15: note: forward declaration of 'struct acpi_driver'
     326 | static struct acpi_driver mctp_pcc_driver = {
         |               ^
>> drivers/net/mctp/mctp-pcc.c:337:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     337 | module_acpi_driver(mctp_pcc_driver);
         | ^
         | int
>> drivers/net/mctp/mctp-pcc.c:337:20: error: a parameter list without types is only allowed in a function definition
     337 | module_acpi_driver(mctp_pcc_driver);
         |                    ^
   6 warnings and 10 errors generated.


vim +/int +337 drivers/net/mctp/mctp-pcc.c

   325	
 > 326	static struct acpi_driver mctp_pcc_driver = {
   327		.name = "mctp_pcc",
   328		.class = "Unknown",
   329		.ids = mctp_pcc_device_ids,
   330		.ops = {
   331			.add = mctp_pcc_driver_add,
   332			.remove = mctp_pcc_driver_remove,
   333		},
   334		.owner = THIS_MODULE,
   335	};
   336	
 > 337	module_acpi_driver(mctp_pcc_driver);
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

