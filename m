Return-Path: <netdev+bounces-99048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422518D389A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ECE1C22604
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E419C1F61C;
	Wed, 29 May 2024 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D89YYKgO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABECC1CA87;
	Wed, 29 May 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991452; cv=none; b=B/2jJ0aay4+KeRefmu0HOehxHWOyWX9k1e98q8zegyXGHBLahX1hqAFd7zXf+3wlP8BCxfq06KCR6PaK0eIXSirqAsvL+xB8vuSfv70YpUQNtvNEEo/bVsmj115HOlAyRKqQ1BU7ZDavBIWeZfx2edAKCl5wr5Sy23G1CK+AV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991452; c=relaxed/simple;
	bh=Oc1H07y0jRLxTFN5y/S84JM5HQMEjIr8gUC39Qrmmyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhC9x0p6hopIRyGZyNDqtuvD+A6uqQxJoTQi7QlXisJjOE0W3NKohRzey8y0RNsZRJl2cihzQZk1YkZAUvQHKpJSKcd8Ymh5I0pX5aonzCH10UVh+2KxbW48yc7LR59HJPyU/13uDMCQIascm3aRTU9m7HJsEWfEc8eKn3dy/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D89YYKgO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716991450; x=1748527450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oc1H07y0jRLxTFN5y/S84JM5HQMEjIr8gUC39Qrmmyg=;
  b=D89YYKgOEoh19lUdMe5CE3wZhCvH54s9wuhWLeABoRynsKsKK+d4MDfY
   DpYSj5wY6q6UtEieeoLWjd6Y4iYgNQT3zrjTVSKIwoRxFIHwL8G34kdwJ
   y234wnio2yHp2+Ykg/5nT7daMO6DSIjIoG499aMY7NPO9jlBRnab9z9KY
   X4eXRwYkj2bE9KlInJoBrnkmOoQ2xneKD+llnq4FpaKXVg2h9J6DujoMm
   Vcs0HKMHZ67BH2eJsYzRi+CKcm/7XELq+1TJWv+kPYOfXfDYGaM7jfo79
   816pdzr9fdhqHZaom3sXnHWeYS6TT1TvHqLox/UIKEt8KreY7DEJNFwRN
   Q==;
X-CSE-ConnectionGUID: Cv/gB+IEQs+kTEMsVziXhQ==
X-CSE-MsgGUID: 6RJX6N66QTqY7VrS/Xlt8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13578166"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13578166"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 07:04:09 -0700
X-CSE-ConnectionGUID: XdGc49rKQQeSm5R69vg+jg==
X-CSE-MsgGUID: bnLG2Wr2Qbil8Om9TEOxwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="39962477"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 29 May 2024 07:04:06 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCJuN-000Dl3-32;
	Wed, 29 May 2024 14:04:03 +0000
Date: Wed, 29 May 2024 22:03:48 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202405292134.LNr25Q9s-lkp@intel.com>
References: <20240528191823.17775-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528191823.17775-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc1 next-20240529]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240529-072116
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240528191823.17775-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240529/202405292134.LNr25Q9s-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405292134.LNr25Q9s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405292134.LNr25Q9s-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
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
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:28:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: declaration of 'struct acpi_pci_root' will not be visible outside of this function [-Wvisibility]
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^
>> drivers/net/mctp/mctp-pcc.c:193:3: error: call to undeclared function 'devm_ioremap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     193 |                 devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
         |                 ^
>> drivers/net/mctp/mctp-pcc.c:192:36: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     192 |         mctp_pcc_dev->pcc_comm_inbox_addr =
         |                                           ^
     193 |                 devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     194 |                              mctp_pcc_dev->in_chan->shmem_size);
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:199:37: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Wint-conversion]
     199 |         mctp_pcc_dev->pcc_comm_outbox_addr =
         |                                            ^
     200 |                 devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     201 |                              mctp_pcc_dev->out_chan->shmem_size);
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:276:15: error: incomplete definition of type 'struct acpi_device'
     276 |         dev_dbg(&adev->dev, "Adding mctp_pcc device for HID  %s\n",
         |                  ~~~~^
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
   include/linux/acpi.h:794:8: note: forward declaration of 'struct acpi_device'
     794 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:277:3: error: call to undeclared function 'acpi_device_hid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     277 |                 acpi_device_hid(adev));
         |                 ^
   drivers/net/mctp/mctp-pcc.c:277:3: note: did you mean 'acpi_device_dep'?
   include/acpi/acpi_bus.h:41:6: note: 'acpi_device_dep' declared here
      41 | bool acpi_device_dep(acpi_handle target, acpi_handle match);
         |      ^
   drivers/net/mctp/mctp-pcc.c:278:15: error: call to undeclared function 'acpi_device_handle'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     278 |         dev_handle = acpi_device_handle(adev);
         |                      ^
   drivers/net/mctp/mctp-pcc.c:278:13: error: incompatible integer to pointer conversion assigning to 'acpi_handle' (aka 'void *') from 'int' [-Wint-conversion]
     278 |         dev_handle = acpi_device_handle(adev);
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:282:16: error: incomplete definition of type 'struct acpi_device'
     282 |                 dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                          ~~~~^
   include/linux/dev_printk.h:154:44: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                   ^~~
   include/linux/dev_printk.h:110:11: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   include/linux/acpi.h:794:8: note: forward declaration of 'struct acpi_device'
     794 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:287:43: error: incomplete definition of type 'struct acpi_device'
     287 |         return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index,
         |                                              ~~~~^
   include/linux/acpi.h:794:8: note: forward declaration of 'struct acpi_device'
     794 | struct acpi_device;
         |        ^
   drivers/net/mctp/mctp-pcc.c:322:27: error: variable has incomplete type 'struct acpi_driver'
     322 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^
   drivers/net/mctp/mctp-pcc.c:322:15: note: forward declaration of 'struct acpi_driver'
     322 | static struct acpi_driver mctp_pcc_driver = {
         |               ^
   drivers/net/mctp/mctp-pcc.c:341:7: error: call to undeclared function 'acpi_bus_register_driver'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     341 |         rc = acpi_bus_register_driver(&mctp_pcc_driver);
         |              ^
   drivers/net/mctp/mctp-pcc.c:351:2: error: call to undeclared function 'acpi_bus_unregister_driver'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     351 |         acpi_bus_unregister_driver(&mctp_pcc_driver);
         |         ^
   18 warnings and 12 errors generated.


vim +/devm_ioremap +193 drivers/net/mctp/mctp-pcc.c

   154	
   155	static int create_mctp_pcc_netdev(struct acpi_device *acpi_dev,
   156					  struct device *dev, int inbox_index,
   157					  int outbox_index)
   158	{
   159		struct mctp_pcc_ndev *mctp_pcc_dev;
   160		struct net_device *ndev;
   161		int mctp_pcc_mtu;
   162		char name[32];
   163		int rc;
   164	
   165		snprintf(name, sizeof(name), "mctpipcc%d", inbox_index);
   166		ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM,
   167				    mctp_pcc_setup);
   168		if (!ndev)
   169			return -ENOMEM;
   170		mctp_pcc_dev = (struct mctp_pcc_ndev *)netdev_priv(ndev);
   171		INIT_LIST_HEAD(&mctp_pcc_dev->next);
   172		spin_lock_init(&mctp_pcc_dev->lock);
   173	
   174		mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
   175		mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
   176		mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
   177		mctp_pcc_dev->cleanup_channel = pcc_mbox_free_channel;
   178		mctp_pcc_dev->out_chan =
   179			pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
   180						 outbox_index);
   181		if (IS_ERR(mctp_pcc_dev->out_chan)) {
   182			rc = PTR_ERR(mctp_pcc_dev->out_chan);
   183			goto free_netdev;
   184		}
   185		mctp_pcc_dev->in_chan =
   186			pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
   187						 inbox_index);
   188		if (IS_ERR(mctp_pcc_dev->in_chan)) {
   189			rc = PTR_ERR(mctp_pcc_dev->in_chan);
   190			goto cleanup_out_channel;
   191		}
 > 192		mctp_pcc_dev->pcc_comm_inbox_addr =
 > 193			devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
   194				     mctp_pcc_dev->in_chan->shmem_size);
   195		if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
   196			rc = -EINVAL;
   197			goto cleanup_in_channel;
   198		}
   199		mctp_pcc_dev->pcc_comm_outbox_addr =
   200			devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
   201				     mctp_pcc_dev->out_chan->shmem_size);
   202		if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
   203			rc = -EINVAL;
   204			goto cleanup_in_channel;
   205		}
   206		mctp_pcc_dev->acpi_device = acpi_dev;
   207		mctp_pcc_dev->inbox_client.dev = dev;
   208		mctp_pcc_dev->outbox_client.dev = dev;
   209		mctp_pcc_dev->mdev.dev = ndev;
   210	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

