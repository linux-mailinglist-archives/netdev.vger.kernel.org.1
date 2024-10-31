Return-Path: <netdev+bounces-140689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B79B7A3D
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF2B20E11
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4A19C543;
	Thu, 31 Oct 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYSCFYzy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1319994D;
	Thu, 31 Oct 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376498; cv=none; b=bs7yC1VVM3hziEzuA0L+ZwIYBPeW6W2pe94QaUBvW1POi2jLgHxgAW/nVqICQDa7hAIGilz+ktpRh77snxkL9XGhk+XCCUubbmVY/ldLNiHlPVLxVr1jMokeGs4mXO+RJEun/Xaw1CRhSKGdupQk+nLxxLP6N4GKKUQlSGHOCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376498; c=relaxed/simple;
	bh=Y7ZW2TLiJTiFT5/GhwReuCB+a+MWFJJLE6XtbOr3WUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fciq3aO4VLLMKP3O9SZZOeh0kBt/v1iTEALe7cUtty3VSopQziYG+4+F6DPAXn+haMbARfIV8fpH79I6UZ+tEATSH3+OjMYIxVpStJxnUI1GhEUdEkxlzsSSF/WKd48pszcPrcWEGAGWDu9O8i92AyO2Zlp7zh8oIcT+ju2cP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYSCFYzy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730376497; x=1761912497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7ZW2TLiJTiFT5/GhwReuCB+a+MWFJJLE6XtbOr3WUk=;
  b=AYSCFYzyy86anbR3ckROUa0kBQu9UdkFS5GRStUEW1rHYZnalSPmmICf
   izIbb+BzNpiJlXVBUmlPDJn8dYKdoc8qnykbskzBi+vPl3H7WjnIJCMsd
   ualxX9RNIe/fmyJ5+EYEX/xryrbG2DWfk/dIKb+oTTIurIDWpucK7k66p
   fIdsFPqz+jVhm4up8vioh4Qabs5OoAf7BkUUnnnlfx8CbEIRgF//EsgqB
   CUNqJIh/DIeHWkLy2qfNLG7rTBUcvU5Ju8JCrl2+8gPwUi0BMM8sB9nLT
   76hYShIyhpKGhCWRngu2lkixYOEUBcCuoTFM0eLeQ791DHjVn+74H4P3+
   Q==;
X-CSE-ConnectionGUID: 1eMSi2bqQRCxV/WNBt3VBQ==
X-CSE-MsgGUID: DYrIaaQTQDGb3BOkO4UaHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30275106"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30275106"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 05:08:16 -0700
X-CSE-ConnectionGUID: XxIYMw2MT/mgw+un73Fgzg==
X-CSE-MsgGUID: 2OHkfEbxTsC+Le0/PKQsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113397104"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Oct 2024 05:08:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6TyD-000g4A-1M;
	Thu, 31 Oct 2024 12:08:09 +0000
Date: Thu, 31 Oct 2024 20:07:43 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202410311939.4FK9lgPt-lkp@intel.com>
References: <20241029165414.58746-3-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029165414.58746-3-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc5 next-20241031]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241030-005644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241029165414.58746-3-admiyo%40os.amperecomputing.com
patch subject: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241031/202410311939.4FK9lgPt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311939.4FK9lgPt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311939.4FK9lgPt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:21:
   include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
   drivers/net/mctp/mctp-pcc.c:237:39: error: invalid use of undefined type 'struct acpi_device'
     237 |         struct device *dev = &acpi_dev->dev;
         |                                       ^~
   In file included from include/linux/printk.h:599,
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
                    from include/linux/acpi.h:13,
                    from drivers/net/mctp/mctp-pcc.c:11:
   drivers/net/mctp/mctp-pcc.c:246:17: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     246 |                 acpi_device_hid(acpi_dev));
         |                 ^~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:245:9: note: in expansion of macro 'dev_dbg'
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:245:22: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'int' [-Wformat=]
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:245:9: note: in expansion of macro 'dev_dbg'
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:245:56: note: format string is defined here
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |                                                       ~^
         |                                                        |
         |                                                        char *
         |                                                       %d
   drivers/net/mctp/mctp-pcc.c:247:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     247 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
>> drivers/net/mctp/mctp-pcc.c:247:20: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     247 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^
   drivers/net/mctp/mctp-pcc.c:290:17: error: invalid use of undefined type 'struct acpi_device'
     290 |         acpi_dev->driver_data = mctp_pcc_ndev;
         |                 ^~
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:317:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     317 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:318:10: error: 'struct acpi_driver' has no member named 'name'
     318 |         .name = "mctp_pcc",
         |          ^~~~
   drivers/net/mctp/mctp-pcc.c:318:17: warning: excess elements in struct initializer
     318 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:318:17: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:319:10: error: 'struct acpi_driver' has no member named 'class'
     319 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:319:18: warning: excess elements in struct initializer
     319 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:319:18: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:320:10: error: 'struct acpi_driver' has no member named 'ids'
     320 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:320:16: warning: excess elements in struct initializer
     320 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:320:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:321:10: error: 'struct acpi_driver' has no member named 'ops'
     321 |         .ops = {
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:321:16: error: extra brace group at end of initializer
     321 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:321:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:321:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:321:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:326:1: warning: data definition has no type or storage class
     326 | module_acpi_driver(mctp_pcc_driver);
         | ^~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:326:1: error: type defaults to 'int' in declaration of 'module_acpi_driver' [-Werror=implicit-int]
>> drivers/net/mctp/mctp-pcc.c:326:1: warning: parameter names (without types) in function declaration
   drivers/net/mctp/mctp-pcc.c:317:27: error: storage size of 'mctp_pcc_driver' isn't known
     317 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:317:27: warning: 'mctp_pcc_driver' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +247 drivers/net/mctp/mctp-pcc.c

   231	
   232	static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
   233	{
   234		struct mctp_pcc_lookup_context context = {0, 0, 0};
   235		struct mctp_pcc_hw_addr mctp_pcc_hw_addr;
   236		struct mctp_pcc_ndev *mctp_pcc_ndev;
   237		struct device *dev = &acpi_dev->dev;
   238		struct net_device *ndev;
   239		acpi_handle dev_handle;
   240		acpi_status status;
   241		int mctp_pcc_mtu;
   242		char name[32];
   243		int rc;
   244	
   245		dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
   246			acpi_device_hid(acpi_dev));
 > 247		dev_handle = acpi_device_handle(acpi_dev);
   248		status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
   249					     &context);
   250		if (!ACPI_SUCCESS(status)) {
   251			dev_err(dev, "FAILURE to lookup PCC indexes from CRS");
   252			return -EINVAL;
   253		}
   254	
   255		//inbox initialization
   256		snprintf(name, sizeof(name), "mctpipcc%d", context.inbox_index);
   257		ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
   258				    mctp_pcc_setup);
   259		if (!ndev)
   260			return -ENOMEM;
   261	
   262		mctp_pcc_ndev = netdev_priv(ndev);
   263		rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
   264		if (rc)
   265			goto cleanup_netdev;
   266		spin_lock_init(&mctp_pcc_ndev->lock);
   267	
   268		rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->inbox,
   269						 context.inbox_index);
   270		if (rc)
   271			goto cleanup_netdev;
   272		mctp_pcc_ndev->inbox.client.rx_callback = mctp_pcc_client_rx_callback;
   273	
   274		//outbox initialization
   275		rc = mctp_pcc_initialize_mailbox(dev, &mctp_pcc_ndev->outbox,
   276						 context.outbox_index);
   277		if (rc)
   278			goto cleanup_netdev;
   279	
   280		mctp_pcc_hw_addr.parent_id = cpu_to_be32(0);
   281		mctp_pcc_hw_addr.inbox_id = cpu_to_be16(context.inbox_index);
   282		mctp_pcc_hw_addr.outbox_id = cpu_to_be16(context.outbox_index);
   283		ndev->addr_len = sizeof(mctp_pcc_hw_addr);
   284		dev_addr_set(ndev, (const u8 *)&mctp_pcc_hw_addr);
   285	
   286		mctp_pcc_ndev->acpi_device = acpi_dev;
   287		mctp_pcc_ndev->inbox.client.dev = dev;
   288		mctp_pcc_ndev->outbox.client.dev = dev;
   289		mctp_pcc_ndev->mdev.dev = ndev;
   290		acpi_dev->driver_data = mctp_pcc_ndev;
   291	
   292		/* There is no clean way to pass the MTU to the callback function
   293		 * used for registration, so set the values ahead of time.
   294		 */
   295		mctp_pcc_mtu = mctp_pcc_ndev->outbox.chan->shmem_size -
   296			sizeof(struct mctp_pcc_hdr);
   297		ndev->mtu = MCTP_MIN_MTU;
   298		ndev->max_mtu = mctp_pcc_mtu;
   299		ndev->min_mtu = MCTP_MIN_MTU;
   300	
   301		/* ndev needs to be freed before the iomemory (mapped above) gets
   302		 * unmapped,  devm resources get freed in reverse to the order they
   303		 * are added.
   304		 */
   305		rc = register_netdev(ndev);
   306		return rc;
   307	cleanup_netdev:
   308		free_netdev(ndev);
   309		return rc;
   310	}
   311	
   312	static const struct acpi_device_id mctp_pcc_device_ids[] = {
   313		{ "DMT0001"},
   314		{}
   315	};
   316	
   317	static struct acpi_driver mctp_pcc_driver = {
   318		.name = "mctp_pcc",
   319		.class = "Unknown",
   320		.ids = mctp_pcc_device_ids,
   321		.ops = {
   322			.add = mctp_pcc_driver_add,
   323		},
   324	};
   325	
 > 326	module_acpi_driver(mctp_pcc_driver);
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

