Return-Path: <netdev+bounces-99026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C8E8D3728
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F421C20974
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D7DDA3;
	Wed, 29 May 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdkFYL8S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E521172C;
	Wed, 29 May 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988255; cv=none; b=nF9+WWPcPnfw6ISavDnA051Ky8EoIU9wBcxhrMqiE9yiIwJuS75H96D/UYXPJOFQd4Tdt7+a/gjKaSv6xojb6+1hHubkOcvkBjAgUoO7q+XBjiP2IXA846elHkUihK71hXqfsmqUFk0TcQndNhA3rpkB0hjx3QG140JD0HbdIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988255; c=relaxed/simple;
	bh=6dp6CQ5w1DQD8AWtQDmEivwojx2VYh+mOmjEdNJDH+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iwb0R0+9lxPSOBnpYPjT9oaY1MXLdvvWMu8Y9kqDUwtvk6UbmzkPM/ctFKTXI/nanALAly4GGXFGd3tjp2lqaZaAqzracZkqNbXrpoouZnkLygBCl/pfwGf08hikeriYwQZRh2nnQE0V64y9e0dzLwhxEPpaXAPEY4dxlQnYDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdkFYL8S; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716988253; x=1748524253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6dp6CQ5w1DQD8AWtQDmEivwojx2VYh+mOmjEdNJDH+M=;
  b=gdkFYL8SPyBm3B5K30yTXobL9zXWZFcDnLmpuWtW9YHppOmnnVq9GbEF
   XGYTFJcvjyxMpgG6SaCudg4hqSyz9uYDPkyXXZx48dHKgJYF8fO1IP8nP
   Mlq4lV/0nHiSV/VdzzLrJeDTtgRIUvcZiqLjb4bw0mf5+FW+JI2NuGUvS
   O/jrDX19d3KSkhL0xVG530O5NY9gmfr8jKHoctYHqdRf2BfFm76LwM4Dp
   9/doNuZHW4eYDbxvl22up4OOB/NH/ileAhtO6HhbQycaYeLbc+7vxxchZ
   SI2g7GWJMqnyoJtBFOUnLY5qBKHhyDy4ebHJw1aBMjIMUlZ4TGL3/G1th
   w==;
X-CSE-ConnectionGUID: xWsqYQkbSKSpowcVCD0J/A==
X-CSE-MsgGUID: vvqv+lNeQh2sANVijzqzcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24522858"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24522858"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:10:52 -0700
X-CSE-ConnectionGUID: sGEiGrnPTEqtDajvKYi4OA==
X-CSE-MsgGUID: zs2YaZVKSBaQFfA4NYLDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35966264"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 29 May 2024 06:10:49 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCJ4o-000Dgd-0W;
	Wed, 29 May 2024 13:10:46 +0000
Date: Wed, 29 May 2024 21:10:44 +0800
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
Message-ID: <202405292029.IXat0564-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc1 next-20240529]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Implement-MCTP-over-PCC-Transport/20240529-072115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240513173546.679061-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240529/202405292029.IXat0564-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405292029.IXat0564-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405292029.IXat0564-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_client_rx_callback':
   drivers/net/mctp/mctp-pcc.c:96:23: warning: variable 'buf_ptr_val' set but not used [-Wunused-but-set-variable]
      96 |         unsigned long buf_ptr_val;
         |                       ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_tx':
   drivers/net/mctp/mctp-pcc.c:122:24: warning: variable 'buffer' set but not used [-Wunused-but-set-variable]
     122 |         unsigned char *buffer;
         |                        ^~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from drivers/net/mctp/mctp-pcc.c:7:
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
>> drivers/net/mctp/mctp-pcc.c:287:23: error: invalid use of undefined type 'struct acpi_device'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |                       ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:287:9: note: in expansion of macro 'dev_info'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |         ^~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:287:70: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |                                                                      ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:287:9: note: in expansion of macro 'dev_info'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |         ^~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:288:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     288 |         dev_handle = acpi_device_handle(adev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
   drivers/net/mctp/mctp-pcc.c:288:20: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
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
>> drivers/net/mctp/mctp-pcc.c:329:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     329 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:330:10: error: 'struct acpi_driver' has no member named 'name'
     330 |         .name = "mctp_pcc",
         |          ^~~~
   drivers/net/mctp/mctp-pcc.c:330:17: warning: excess elements in struct initializer
     330 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:330:17: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:331:10: error: 'struct acpi_driver' has no member named 'class'
     331 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:331:18: warning: excess elements in struct initializer
     331 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:331:18: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:332:10: error: 'struct acpi_driver' has no member named 'ids'
     332 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:332:16: warning: excess elements in struct initializer
     332 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:332:16: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:333:10: error: 'struct acpi_driver' has no member named 'ops'
     333 |         .ops = {
         |          ^~~
>> drivers/net/mctp/mctp-pcc.c:333:16: error: extra brace group at end of initializer
     333 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:333:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:333:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:333:16: note: (near initialization for 'mctp_pcc_driver')
>> drivers/net/mctp/mctp-pcc.c:338:10: error: 'struct acpi_driver' has no member named 'owner'
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
>> drivers/net/mctp/mctp-pcc.c:348:14: error: implicit declaration of function 'acpi_bus_register_driver' [-Werror=implicit-function-declaration]
     348 |         rc = acpi_bus_register_driver(&mctp_pcc_driver);
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:350:80: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     350 |                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
         |                                                                                ^
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_mod_exit':
>> drivers/net/mctp/mctp-pcc.c:358:9: error: implicit declaration of function 'acpi_bus_unregister_driver'; did you mean 'platform_unregister_drivers'? [-Werror=implicit-function-declaration]
     358 |         acpi_bus_unregister_driver(&mctp_pcc_driver);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         platform_unregister_drivers
   drivers/net/mctp/mctp-pcc.c: At top level:
>> drivers/net/mctp/mctp-pcc.c:329:27: error: storage size of 'mctp_pcc_driver' isn't known
     329 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +287 drivers/net/mctp/mctp-pcc.c

   278	
   279	static int mctp_pcc_driver_add(struct acpi_device *adev)
   280	{
   281		int inbox_index;
   282		int outbox_index;
   283		acpi_handle dev_handle;
   284		acpi_status status;
   285		struct lookup_context context = {0, 0, 0};
   286	
 > 287		dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
 > 288		dev_handle = acpi_device_handle(adev);
   289		status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices, &context);
   290		if (ACPI_SUCCESS(status)) {
   291			inbox_index = context.inbox_index;
   292			outbox_index = context.outbox_index;
   293			return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index, outbox_index);
   294		}
   295		dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
   296		return -EINVAL;
   297	};
   298	
   299	/* pass in adev=NULL to remove all devices
   300	 */
   301	static void mctp_pcc_driver_remove(struct acpi_device *adev)
   302	{
   303		struct mctp_pcc_ndev *mctp_pcc_dev = NULL;
   304		struct list_head *ptr;
   305		struct list_head *tmp;
   306	
   307		list_for_each_safe(ptr, tmp, &mctp_pcc_ndevs) {
   308			mctp_pcc_dev = list_entry(ptr, struct mctp_pcc_ndev, head);
   309			if (!adev || mctp_pcc_dev->acpi_device == adev) {
   310				struct net_device *ndev;
   311	
   312				mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
   313				mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
   314				ndev = mctp_pcc_dev->mdev.dev;
   315				if (ndev)
   316					mctp_unregister_netdev(ndev);
   317				list_del(ptr);
   318				if (adev)
   319					break;
   320			}
   321		}
   322	};
   323	
   324	static const struct acpi_device_id mctp_pcc_device_ids[] = {
   325		{ "DMT0001", 0},
   326		{ "", 0},
   327	};
   328	
 > 329	static struct acpi_driver mctp_pcc_driver = {
 > 330		.name = "mctp_pcc",
 > 331		.class = "Unknown",
 > 332		.ids = mctp_pcc_device_ids,
 > 333		.ops = {
   334			.add = mctp_pcc_driver_add,
   335			.remove = mctp_pcc_driver_remove,
   336			.notify = NULL,
   337		},
 > 338		.owner = THIS_MODULE,
   339	
   340	};
   341	
   342	static int __init mctp_pcc_mod_init(void)
   343	{
   344		int rc;
   345	
   346		pr_info("initializing MCTP over PCC\n");
   347		INIT_LIST_HEAD(&mctp_pcc_ndevs);
 > 348		rc = acpi_bus_register_driver(&mctp_pcc_driver);
   349		if (rc < 0)
   350			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
   351		return rc;
   352	}
   353	
   354	static __exit void mctp_pcc_mod_exit(void)
   355	{
   356		pr_info("Removing MCTP over PCC transport driver\n");
   357		mctp_pcc_driver_remove(NULL);
 > 358		acpi_bus_unregister_driver(&mctp_pcc_driver);
   359	}
   360	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

