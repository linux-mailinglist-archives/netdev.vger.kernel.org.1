Return-Path: <netdev+bounces-140724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D269B7B69
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75431281639
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E119DF62;
	Thu, 31 Oct 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAcOYc0c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919E19F110;
	Thu, 31 Oct 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380230; cv=none; b=qlfBRfYrlAnvALcSu9UPrXVYT1tZBWQL3I6Mf5eaVyI6PpwarDjKbJmUDlXLbIwxBr/DfKG+zhnBbsswU70CfG7MIbXB/rsxRFA+xTBYVQg3YaXQAxFz6nQCd7Zrbx/7pKp72RPm0hVc69pAC9Mm/Ab2Eop7dk/0K85dSLZvWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380230; c=relaxed/simple;
	bh=Ws4nFLQqfgbxQOnLOFS16yMCjEu3wZ5jnket4MtMOrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVnAMs2esAa+I9RUDK8hCjrUteyEGyDdVKn/JS6jOCnvZMEb/S98a6RzfGc+9X0RvcBjCC0X74U5KngrhvNNT0XCqrhiF1QJZ4S7i72KbuhSqA9LsOAycA+EBcMHsvw/+NCdUdXpUF7vGYICFBaUxoljEQxqqTjSHLErvFYTTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAcOYc0c; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730380226; x=1761916226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ws4nFLQqfgbxQOnLOFS16yMCjEu3wZ5jnket4MtMOrk=;
  b=ZAcOYc0c/UIq7cr8jwg/O4uhM3NakieuvHdFO3NJ9IwYCiu7gk/sRPRD
   MPMGsMsvo+1S5yLNb0BmsVGhYnQQ/hx4Vy3NmCMHYVrsmV3Mn/AB+Kouv
   BTj/oYzCyZIv4pNYZSaPbin9UxPEbgC7NQrE2TS+Kw+JzctGVw+H9bPvX
   Es29tw9lVd9ZMwnXxcK0RSzTWxb+n2X1AwLBzd/oUJPb8FYb4tqsrs33x
   91TTsvoqcIAh63pxLFlNwmlLMaKSucSDlQYQZ32P3Y4KunHFEmGxXfBXk
   caIqQeCds/hBwR95aPNAH5ej9Ca2CEgXGJ/PZixDu+ROsgu96VinTW2V5
   Q==;
X-CSE-ConnectionGUID: FOClypPsTC+ugZhZE7AiSg==
X-CSE-MsgGUID: +V8wnyv+RLGWejMTFyibtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47572642"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47572642"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 06:10:20 -0700
X-CSE-ConnectionGUID: m3YLlGEcREuPMDz+uUjwbg==
X-CSE-MsgGUID: PTzwQAYEQEG429s16g1aCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82777249"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Oct 2024 06:10:16 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6UwH-000g7S-0y;
	Thu, 31 Oct 2024 13:10:13 +0000
Date: Thu, 31 Oct 2024 21:09:51 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202410312048.W6PV1dIU-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.12-rc5 next-20241031]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241030-005644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241029165414.58746-3-admiyo%40os.amperecomputing.com
patch subject: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241031/202410312048.W6PV1dIU-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410312048.W6PV1dIU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410312048.W6PV1dIU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:12:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/mctp/mctp-pcc.c:12:
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
   In file included from drivers/net/mctp/mctp-pcc.c:12:
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
   In file included from drivers/net/mctp/mctp-pcc.c:12:
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
   In file included from drivers/net/mctp/mctp-pcc.c:21:
>> include/acpi/acpi_drivers.h:72:43: warning: declaration of 'struct acpi_pci_root' will not be visible outside of this function [-Wvisibility]
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^
>> drivers/net/mctp/mctp-pcc.c:237:32: error: incomplete definition of type 'struct acpi_device'
     237 |         struct device *dev = &acpi_dev->dev;
         |                               ~~~~~~~~^
   include/linux/acpi.h:801:8: note: forward declaration of 'struct acpi_device'
     801 | struct acpi_device;
         |        ^
>> drivers/net/mctp/mctp-pcc.c:246:3: error: call to undeclared function 'acpi_device_hid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     246 |                 acpi_device_hid(acpi_dev));
         |                 ^
   drivers/net/mctp/mctp-pcc.c:246:3: note: did you mean 'acpi_device_dep'?
   include/acpi/acpi_bus.h:41:6: note: 'acpi_device_dep' declared here
      41 | bool acpi_device_dep(acpi_handle target, acpi_handle match);
         |      ^
>> drivers/net/mctp/mctp-pcc.c:246:3: warning: format specifies type 'char *' but the argument has type 'int' [-Wformat]
     245 |         dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
         |                                                       ~~
         |                                                       %d
     246 |                 acpi_device_hid(acpi_dev));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:247:15: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     247 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^
>> drivers/net/mctp/mctp-pcc.c:247:13: error: incompatible integer to pointer conversion assigning to 'acpi_handle' (aka 'void *') from 'int' [-Wint-conversion]
     247 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:290:10: error: incomplete definition of type 'struct acpi_device'
     290 |         acpi_dev->driver_data = mctp_pcc_ndev;
         |         ~~~~~~~~^
   include/linux/acpi.h:801:8: note: forward declaration of 'struct acpi_device'
     801 | struct acpi_device;
         |        ^
>> drivers/net/mctp/mctp-pcc.c:317:27: error: variable has incomplete type 'struct acpi_driver'
     317 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^
   drivers/net/mctp/mctp-pcc.c:317:15: note: forward declaration of 'struct acpi_driver'
     317 | static struct acpi_driver mctp_pcc_driver = {
         |               ^
>> drivers/net/mctp/mctp-pcc.c:326:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     326 | module_acpi_driver(mctp_pcc_driver);
         | ^
         | int
>> drivers/net/mctp/mctp-pcc.c:326:20: error: a parameter list without types is only allowed in a function definition
     326 | module_acpi_driver(mctp_pcc_driver);
         |                    ^
   9 warnings and 8 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +237 drivers/net/mctp/mctp-pcc.c

   231	
   232	static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
   233	{
   234		struct mctp_pcc_lookup_context context = {0, 0, 0};
   235		struct mctp_pcc_hw_addr mctp_pcc_hw_addr;
   236		struct mctp_pcc_ndev *mctp_pcc_ndev;
 > 237		struct device *dev = &acpi_dev->dev;
   238		struct net_device *ndev;
   239		acpi_handle dev_handle;
   240		acpi_status status;
   241		int mctp_pcc_mtu;
   242		char name[32];
   243		int rc;
   244	
   245		dev_dbg(dev, "Adding mctp_pcc device for HID  %s\n",
 > 246			acpi_device_hid(acpi_dev));
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
 > 317	static struct acpi_driver mctp_pcc_driver = {
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

