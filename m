Return-Path: <netdev+bounces-99077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD08D3A12
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AEA1F27555
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FA615ADB0;
	Wed, 29 May 2024 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2qKF1kv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8851509B4;
	Wed, 29 May 2024 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994656; cv=none; b=MxjZgJO9tFk2+SnnQndnU6gXZsMbBQRmGFeZP13AY6ug9ecMyIgYECdOkpf1fx5VxIOZVAmOkc9OmOiQUZ1rZdGvZYfkRA8vPiRuhDVSFwgCW/vBSnzefEIhqOeks0IQT5Cu2W7vVxnv62kkCemCo9vWnOzroCcCNgFpC79yJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994656; c=relaxed/simple;
	bh=x7UV6JV7JHrcaGiIeKJ3AQ/Qlppm0WtQZ8CeqKn6x5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8Hgi9GdjK7aTgMRVJF8cLv1WTAnMqNSH4F2iEPTgrVH0WMK7Tc7WZieS0RPqUGqV3vlJATRDGqvxXI3hE/1pzsbznpGv6EMl8DvsIcY3s4bOT68cx6eoNl3sPmKAn0BOm8DKnP07eQCaiP5G38F2GrvnieKRxHSb7GESh+viQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2qKF1kv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716994654; x=1748530654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x7UV6JV7JHrcaGiIeKJ3AQ/Qlppm0WtQZ8CeqKn6x5c=;
  b=e2qKF1kvh+8NmNks6GyQwD3mMtpMy2kR7M24+lC3xMMVW6/MjZxE9F+Z
   W8fhdMST9Ce4w0BY+RO7neNPsi2c/baKyGf2b1qBh4vOS0Jgz+IuYqwN1
   m8B6qHYUwm+QULVOS2eXxHZm2kTxBFk7wh1u5MxGWLOZOVTSllxybd61k
   5P3K95UcUjKVB5mbKLP1M0A1XCBDNorZTHpjcXaiYfebwNDdzx2GHnYBO
   48hNdbtppL19S8xEhowmIi6RJvBzIiYtm6p8mj/HGAoOOIKia4oNZlLqu
   spkOuuKYhjKmHT/9tlNEm9sRD7owFnGDBDGBMJaXKE5TquNV/e43/TSpu
   A==;
X-CSE-ConnectionGUID: MxyEEC2MQamz1DTOn6p98A==
X-CSE-MsgGUID: K/8cc2EoTt+lellbwIBFPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="35923072"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35923072"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 07:57:12 -0700
X-CSE-ConnectionGUID: jkQuRVF/SNuWCPvfWkMFdA==
X-CSE-MsgGUID: AmBwaNDUS6+RT86xm/gJ1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35527506"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 29 May 2024 07:57:09 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCKji-000Dpt-20;
	Wed, 29 May 2024 14:57:06 +0000
Date: Wed, 29 May 2024 22:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202405292251.9wZslCTL-lkp@intel.com>
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
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240529/202405292251.9wZslCTL-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405292251.9wZslCTL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405292251.9wZslCTL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: declaration of 'struct acpi_pci_root' will not be visible outside of this function [-Wvisibility]
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^
   drivers/net/mctp/mctp-pcc.c:90:70: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
      90 | static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *)
         |                                                                      ^
   drivers/net/mctp/mctp-pcc.c:96:16: warning: variable 'buf_ptr_val' set but not used [-Wunused-but-set-variable]
      96 |         unsigned long buf_ptr_val;
         |                       ^
   drivers/net/mctp/mctp-pcc.c:122:17: warning: variable 'buffer' set but not used [-Wunused-but-set-variable]
     122 |         unsigned char *buffer;
         |                        ^
>> drivers/net/mctp/mctp-pcc.c:287:16: error: incomplete definition of type 'struct acpi_device'
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |                   ~~~~^
   include/linux/dev_printk.h:160:46: note: expanded from macro 'dev_info'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                     ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/acpi.h:794:8: note: forward declaration of 'struct acpi_device'
     794 | struct acpi_device;
         |        ^
>> drivers/net/mctp/mctp-pcc.c:287:63: error: call to undeclared function 'acpi_device_hid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     287 |         dev_info(&adev->dev, "Adding mctp_pcc device for HID  %s\n", acpi_device_hid(adev));
         |                                                                      ^
   drivers/net/mctp/mctp-pcc.c:287:63: note: did you mean 'acpi_device_dep'?
   include/acpi/acpi_bus.h:41:6: note: 'acpi_device_dep' declared here
      41 | bool acpi_device_dep(acpi_handle target, acpi_handle match);
         |      ^
>> drivers/net/mctp/mctp-pcc.c:288:15: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     288 |         dev_handle = acpi_device_handle(adev);
         |                      ^
>> drivers/net/mctp/mctp-pcc.c:288:13: error: incompatible integer to pointer conversion assigning to 'acpi_handle' (aka 'void *') from 'int' [-Wint-conversion]
     288 |         dev_handle = acpi_device_handle(adev);
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:293:44: error: incomplete definition of type 'struct acpi_device'
     293 |                 return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index, outbox_index);
         |                                                      ~~~~^
   include/linux/acpi.h:794:8: note: forward declaration of 'struct acpi_device'
     794 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:295:15: error: incomplete definition of type 'struct acpi_device'
     295 |         dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                  ~~~~^
   include/linux/dev_printk.h:154:44: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/acpi.h:794:8: note: forward declaration of 'struct acpi_device'
     794 | struct acpi_device;
         |        ^
>> drivers/net/mctp/mctp-pcc.c:329:27: error: variable has incomplete type 'struct acpi_driver'
     329 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^
   drivers/net/mctp/mctp-pcc.c:329:15: note: forward declaration of 'struct acpi_driver'
     329 | static struct acpi_driver mctp_pcc_driver = {
         |               ^
>> drivers/net/mctp/mctp-pcc.c:348:7: error: call to undeclared function 'acpi_bus_register_driver'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     348 |         rc = acpi_bus_register_driver(&mctp_pcc_driver);
         |              ^
>> drivers/net/mctp/mctp-pcc.c:358:2: error: call to undeclared function 'acpi_bus_unregister_driver'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     358 |         acpi_bus_unregister_driver(&mctp_pcc_driver);
         |         ^
   11 warnings and 9 errors generated.


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
   330		.name = "mctp_pcc",
   331		.class = "Unknown",
   332		.ids = mctp_pcc_device_ids,
   333		.ops = {
   334			.add = mctp_pcc_driver_add,
   335			.remove = mctp_pcc_driver_remove,
   336			.notify = NULL,
   337		},
   338		.owner = THIS_MODULE,
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

