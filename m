Return-Path: <netdev+bounces-111222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA50930444
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 09:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397A31C21252
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C429401;
	Sat, 13 Jul 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMMkJ5UC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202CE1EB3D;
	Sat, 13 Jul 2024 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720855935; cv=none; b=AdO05OFzlgPyLNmTOnUEz3QfOc6y0w4xS3g2eIH9X9GXbLaAsjJ7s4/Nzw0WjhrLm2ehsiyNCNEw2Fa2Z/6EXcJX0+xxxN6n92uj9fAJ0pDgay3ck9peZj+ZouG3OqReEn49JUWX5juS5ZV+B2m8kkHySadyaK6uLP3K2ZuNQOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720855935; c=relaxed/simple;
	bh=mwDTPRkfNchC5/Y3ux1Cfe/4c0ldtchcJ3Ovdk5oW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRJWw9rfXSmoAd7y9haATPgYOqYxCh0FPpK+a89Y5Cht4kytS5c9YT9TYKcxq8oVp5lFlMtNUk/zAkW7wZqUE+a3kChIXTZn2kujuS1dgn6FAKBZILpW+GSFDMBXjvzhtCHgMjCazjfrjiV5KZpR9MPE7bP6q2+aUDUAIZ4vijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMMkJ5UC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720855933; x=1752391933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mwDTPRkfNchC5/Y3ux1Cfe/4c0ldtchcJ3Ovdk5oW4o=;
  b=IMMkJ5UCSDDXBYt8e3qsisK5S/RT1O/aT9RAqmG7HAY5A//Xs3eLmgJN
   VSNm3VFG2WDOHxokDbldgdfcdu3lwSZQ6Qka+IauqoVonHE1uVmXR05nw
   zux8xE4+NejGUXLvErdYtVfPyVKrBDIRfcrGVtCUJ18+U0mocsOajjtN1
   WjeWFqQr34hVIEzb3pU2FsRzs8vfAf1p1AgVuz8Gu2qhUc1V1UR4eqGNl
   Tzp8TpflMNmSfY3GwpJrFgXJqVuqv+bXR5jt2e46f8SxIojykZRRerJZe
   floEEg57NXNbwgy49PLb5mx0r25VATzOU64WqCGKZVHJ2jEtGNxMUlC58
   w==;
X-CSE-ConnectionGUID: aRB5y7zIRmShE5y8IRyjVw==
X-CSE-MsgGUID: O+4lUtFvRXqs2+hq8zCU/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29697447"
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="29697447"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2024 00:32:12 -0700
X-CSE-ConnectionGUID: vmA62OhrRsW3wXjqTOcZXg==
X-CSE-MsgGUID: N/GFeW4ZSbiIk7EqFBvR1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,205,1716274800"; 
   d="scan'208";a="49074907"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jul 2024 00:32:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSXEk-000bq2-0K;
	Sat, 13 Jul 2024 07:32:06 +0000
Date: Sat, 13 Jul 2024 15:31:44 +0800
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
Subject: Re: [PATCH v5 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202407131538.hqt58AQS-lkp@intel.com>
References: <20240712023626.1010559-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712023626.1010559-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc7 next-20240712]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240712-104202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240712023626.1010559-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v5 3/3] mctp pcc: Implement MCTP over PCC Transport
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240713/202407131538.hqt58AQS-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131538.hqt58AQS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131538.hqt58AQS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   In file included from include/linux/printk.h:570,
                    from include/asm-generic/bug.h:22,
                    from arch/sh/include/asm/bug.h:112,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/sh/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/net/mctp/mctp-pcc.c:7:
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
   drivers/net/mctp/mctp-pcc.c:212:26: error: invalid use of undefined type 'struct acpi_device'
     212 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |                          ^~
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
   drivers/net/mctp/mctp-pcc.c:212:9: note: in expansion of macro 'dev_dbg'
     212 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:213:17: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Wimplicit-function-declaration]
     213 |                 acpi_device_hid(acpi_dev));
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
   drivers/net/mctp/mctp-pcc.c:212:9: note: in expansion of macro 'dev_dbg'
     212 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:214:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Wimplicit-function-declaration]
     214 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
>> drivers/net/mctp/mctp-pcc.c:214:20: error: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     214 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14:
   drivers/net/mctp/mctp-pcc.c:218:34: error: invalid use of undefined type 'struct acpi_device'
     218 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                                  ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:218:17: note: in expansion of macro 'dev_err'
     218 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                 ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:223:24: error: invalid use of undefined type 'struct acpi_device'
     223 |         dev = &acpi_dev->dev;
         |                        ^~
   drivers/net/mctp/mctp-pcc.c:268:17: error: invalid use of undefined type 'struct acpi_device'
     268 |         acpi_dev->driver_data = mctp_pcc_dev;
         |                 ^~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_remove':
   drivers/net/mctp/mctp-pcc.c:297:47: error: implicit declaration of function 'acpi_driver_data'; did you mean 'acpi_get_data'? [-Wimplicit-function-declaration]
     297 |         struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
         |                                               ^~~~~~~~~~~~~~~~
         |                                               acpi_get_data
>> drivers/net/mctp/mctp-pcc.c:297:47: error: initialization of 'struct mctp_pcc_ndev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:309:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     309 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:310:10: error: 'struct acpi_driver' has no member named 'name'
     310 |         .name = "mctp_pcc",
         |          ^~~~
   drivers/net/mctp/mctp-pcc.c:310:17: warning: excess elements in struct initializer
     310 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:310:17: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:311:10: error: 'struct acpi_driver' has no member named 'class'
     311 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:311:18: warning: excess elements in struct initializer
     311 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:311:18: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:312:10: error: 'struct acpi_driver' has no member named 'ids'
     312 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:312:16: warning: excess elements in struct initializer
     312 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:312:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:313:10: error: 'struct acpi_driver' has no member named 'ops'
     313 |         .ops = {
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:313:16: error: extra brace group at end of initializer
     313 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:313:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:313:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:313:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:319:1: warning: data definition has no type or storage class
     319 | module_acpi_driver(mctp_pcc_driver);
         | ^~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:319:1: error: type defaults to 'int' in declaration of 'module_acpi_driver' [-Wimplicit-int]
>> drivers/net/mctp/mctp-pcc.c:319:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/net/mctp/mctp-pcc.c:309:27: error: storage size of 'mctp_pcc_driver' isn't known
     309 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:309:27: warning: 'mctp_pcc_driver' defined but not used [-Wunused-variable]


vim +214 drivers/net/mctp/mctp-pcc.c

   197	
   198	static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
   199	{
   200		struct lookup_context context = {0, 0, 0};
   201		struct mctp_pcc_ndev *mctp_pcc_dev;
   202		struct net_device *ndev;
   203		acpi_handle dev_handle;
   204		acpi_status status;
   205		struct device *dev;
   206		int mctp_pcc_mtu;
   207		int outbox_index;
   208		int inbox_index;
   209		char name[32];
   210		int rc;
   211	
   212		dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
   213			acpi_device_hid(acpi_dev));
 > 214		dev_handle = acpi_device_handle(acpi_dev);
   215		status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
   216					     &context);
   217		if (!ACPI_SUCCESS(status)) {
   218			dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
   219			return -EINVAL;
   220		}
   221		inbox_index = context.inbox_index;
   222		outbox_index = context.outbox_index;
   223		dev = &acpi_dev->dev;
   224	
   225		snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
   226		ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
   227				    mctp_pcc_setup);
   228		if (!ndev)
   229			return -ENOMEM;
   230		mctp_pcc_dev = netdev_priv(ndev);
   231		spin_lock_init(&mctp_pcc_dev->lock);
   232	
   233		mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
   234		mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
   235		mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
   236		mctp_pcc_dev->out_chan =
   237			pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
   238						 outbox_index);
   239		if (IS_ERR(mctp_pcc_dev->out_chan)) {
   240			rc = PTR_ERR(mctp_pcc_dev->out_chan);
   241			goto free_netdev;
   242		}
   243		mctp_pcc_dev->in_chan =
   244			pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
   245						 inbox_index);
   246		if (IS_ERR(mctp_pcc_dev->in_chan)) {
   247			rc = PTR_ERR(mctp_pcc_dev->in_chan);
   248			goto cleanup_out_channel;
   249		}
   250		mctp_pcc_dev->pcc_comm_inbox_addr =
   251			devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
   252				     mctp_pcc_dev->in_chan->shmem_size);
   253		if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
   254			rc = -EINVAL;
   255			goto cleanup_in_channel;
   256		}
   257		mctp_pcc_dev->pcc_comm_outbox_addr =
   258			devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
   259				     mctp_pcc_dev->out_chan->shmem_size);
   260		if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
   261			rc = -EINVAL;
   262			goto cleanup_in_channel;
   263		}
   264		mctp_pcc_dev->acpi_device = acpi_dev;
   265		mctp_pcc_dev->inbox_client.dev = dev;
   266		mctp_pcc_dev->outbox_client.dev = dev;
   267		mctp_pcc_dev->mdev.dev = ndev;
   268		acpi_dev->driver_data = mctp_pcc_dev;
   269	
   270		/* There is no clean way to pass the MTU
   271		 * to the callback function used for registration,
   272		 * so set the values ahead of time.
   273		 */
   274		mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
   275			sizeof(struct mctp_pcc_hdr);
   276		ndev->mtu = MCTP_MIN_MTU;
   277		ndev->max_mtu = mctp_pcc_mtu;
   278		ndev->min_mtu = MCTP_MIN_MTU;
   279	
   280		rc = register_netdev(ndev);
   281		if (rc)
   282			goto cleanup_in_channel;
   283		return 0;
   284	
   285	cleanup_in_channel:
   286		pcc_mbox_free_channel(mctp_pcc_dev->in_chan);
   287	cleanup_out_channel:
   288		pcc_mbox_free_channel(mctp_pcc_dev->out_chan);
   289	free_netdev:
   290		unregister_netdev(ndev);
   291		free_netdev(ndev);
   292		return rc;
   293	}
   294	
   295	static void mctp_pcc_driver_remove(struct acpi_device *adev)
   296	{
 > 297		struct mctp_pcc_ndev *mctp_pcc_ndev = acpi_driver_data(adev);
   298	
   299		pcc_mbox_free_channel(mctp_pcc_ndev->out_chan);
   300		pcc_mbox_free_channel(mctp_pcc_ndev->in_chan);
   301		mctp_unregister_netdev(mctp_pcc_ndev->mdev.dev);
   302	}
   303	
   304	static const struct acpi_device_id mctp_pcc_device_ids[] = {
   305		{ "DMT0001", 0},
   306		{ "", 0},
   307	};
   308	
   309	static struct acpi_driver mctp_pcc_driver = {
   310		.name = "mctp_pcc",
   311		.class = "Unknown",
   312		.ids = mctp_pcc_device_ids,
   313		.ops = {
   314			.add = mctp_pcc_driver_add,
   315			.remove = mctp_pcc_driver_remove,
   316		},
   317	};
   318	
 > 319	module_acpi_driver(mctp_pcc_driver);
   320	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

