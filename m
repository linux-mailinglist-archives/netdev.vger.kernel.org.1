Return-Path: <netdev+bounces-96319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CE68C4F49
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BDB2829CB
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889F13E3FD;
	Tue, 14 May 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zhe76EoR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAB13E3F0;
	Tue, 14 May 2024 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681600; cv=none; b=aGxL7m/1ZhUJ+3PZL0/ZU0FSMNCY1uuSfjPZm1Q6XmxFcsxs468YzTxMXIIcCF3mxb3CESpYqKiLK3S/2RYAQJE+dVLd/JjZs0SDnWghCcpXEQNsxI7KtDh54pzt1GdD5x8lpct3HkKBAPsBc0CmI4fReo1Pxd3PGS0rwH2ewPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681600; c=relaxed/simple;
	bh=/rb7EJcs6076/DNpD7nMiQCy4Sm6K/7B+G9UwsJ0YPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogkJhIFx0gQfbHe3aVTfw4hyDJrmaf9ZVAweatuME3/ViFUa+t9EoRo5FKqO6Pw1PxHvOaAGHr5VM/XqwvyU4IYg8PlUUBEC+ohs5ECxLQXzu9MM5sNwAo+djrcdHhAZKFLWuq6EjalCf2TJUGpqvKjSvJoG7tXZzWrP8vnQYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zhe76EoR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715681599; x=1747217599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/rb7EJcs6076/DNpD7nMiQCy4Sm6K/7B+G9UwsJ0YPE=;
  b=Zhe76EoREso/GCqxa0LM/YAl7H6w27uYPOMfsde0vk1es8Uxi7OekACn
   z5ILBUcznh9Q6G5O+vKXy/L86M2BO7eaRu1/KExEFMoUdEXz7Y7E2tgga
   T6P4e3k3OFvNEWst77qq6f4iScL88z3rUClECBrkm5f+p+CXZIi1z73YR
   KTbCzVzP65SaUsIXkUsu4bsBXFYVK77B2z1AMqFwHDVIGfeZhy19tQwbA
   9YgvQ3Y6tnfibqOOPXYhSbDrHdzL38ybDF16Sf7AUGhMQLXm4b8881p+z
   2+++r+pMePJrCDmbxqO7Z1fyym0uYG6frWnC+ac6raVm63mSoPNnTX14a
   w==;
X-CSE-ConnectionGUID: PW5+NwG8SSe6HFVWUzUllA==
X-CSE-MsgGUID: HF5BSyK7RZqwQFdNg6N4pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="23051370"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="23051370"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 03:13:18 -0700
X-CSE-ConnectionGUID: j6ICEruVRwinHxF1AaGWUw==
X-CSE-MsgGUID: QM7gHlfIRiihbAw6vog/2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="53842562"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 May 2024 03:13:15 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6p9k-000BMp-2t;
	Tue, 14 May 2024 10:13:12 +0000
Date: Tue, 14 May 2024 18:12:17 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202405141708.3nRcb6g3-lkp@intel.com>
References: <20240513173546.679061-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513173546.679061-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.9 next-20240514]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Implement-MCTP-over-PCC-Transport/20240514-013734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240513173546.679061-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240514/202405141708.3nRcb6g3-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405141708.3nRcb6g3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405141708.3nRcb6g3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:17:
>> include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_client_rx_callback':
>> drivers/net/mctp/mctp-pcc.c:96:23: warning: variable 'buf_ptr_val' set but not used [-Wunused-but-set-variable]
      96 |         unsigned long buf_ptr_val;
         |                       ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_tx':
>> drivers/net/mctp/mctp-pcc.c:122:24: warning: variable 'buffer' set but not used [-Wunused-but-set-variable]
     122 |         unsigned char *buffer;
         |                        ^~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from drivers/net/mctp/mctp-pcc.c:7:
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
   drivers/net/mctp/mctp-pcc.c:287:23: error: invalid use of undefined type 'struct acpi_device'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |                       ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:287:9: note: in expansion of macro 'dev_info'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |         ^~~~~~~~
   drivers/net/mctp/mctp-pcc.c:287:70: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |                                                                      ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:287:9: note: in expansion of macro 'dev_info'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |         ^~~~~~~~
   drivers/net/mctp/mctp-pcc.c:288:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     288 |         dev_handle = acpi_device_handle(adev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
>> drivers/net/mctp/mctp-pcc.c:288:20: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     288 |         dev_handle = acpi_device_handle(adev);
         |                    ^
   drivers/net/mctp/mctp-pcc.c:293:58: error: invalid use of undefined type 'struct acpi_device'
     293 |                 return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index, outbox_index);
         |                                                          ^~
   drivers/net/mctp/mctp-pcc.c:295:22: error: invalid use of undefined type 'struct acpi_device'
     295 |         dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                      ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:295:9: note: in expansion of macro 'dev_err'
     295 |         dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:329:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     329 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:330:10: error: 'struct acpi_driver' has no member named 'name'
     330 |         .name = "mctp_pcc",
         |          ^~~~
>> drivers/net/mctp/mctp-pcc.c:330:17: warning: excess elements in struct initializer
     330 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:330:17: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:331:10: error: 'struct acpi_driver' has no member named 'class'
     331 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:331:18: warning: excess elements in struct initializer
     331 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:331:18: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:332:10: error: 'struct acpi_driver' has no member named 'ids'
     332 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:332:16: warning: excess elements in struct initializer
     332 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:332:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:333:10: error: 'struct acpi_driver' has no member named 'ops'
     333 |         .ops = {
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:333:16: error: extra brace group at end of initializer
     333 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:333:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:333:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:333:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:338:10: error: 'struct acpi_driver' has no member named 'owner'
     338 |         .owner = THIS_MODULE,
         |          ^~~~~
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/alpha/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13:
   include/linux/init.h:182:21: warning: excess elements in struct initializer
     182 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:338:18: note: in expansion of macro 'THIS_MODULE'
     338 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:182:21: note: (near initialization for 'mctp_pcc_driver')
     182 | #define THIS_MODULE ((struct module *)0)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:338:18: note: in expansion of macro 'THIS_MODULE'
     338 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_mod_init':
   drivers/net/mctp/mctp-pcc.c:348:14: error: implicit declaration of function 'acpi_bus_register_driver' [-Werror=implicit-function-declaration]
     348 |         rc = acpi_bus_register_driver(&mctp_pcc_driver);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:350:80: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     350 |                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
         |                                                                                ^
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_mod_exit':
   drivers/net/mctp/mctp-pcc.c:358:9: error: implicit declaration of function 'acpi_bus_unregister_driver'; did you mean 'platform_unregister_drivers'? [-Werror=implicit-function-declaration]
     358 |         acpi_bus_unregister_driver(&mctp_pcc_driver);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         platform_unregister_drivers
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:329:27: error: storage size of 'mctp_pcc_driver' isn't known
     329 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +72 include/acpi/acpi_drivers.h

^1da177e4c3f41 Linus Torvalds 2005-04-16  71  
57283776b2b821 Bjorn Helgaas  2010-03-11 @72  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
6b90f55f63c75c Hanjun Guo     2014-05-06  73  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

