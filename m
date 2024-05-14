Return-Path: <netdev+bounces-96337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBD8C538E
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D3EB21D1A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623A129E86;
	Tue, 14 May 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXP9vZ+p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9381292D2;
	Tue, 14 May 2024 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686609; cv=none; b=J2TC++BkNvVruOmQEPkco1W8WtZldpzdgifwGBkYzX+i/NC9EZJQqAUQtUgGV/CZW+ABv2OgzhlwfwBf0y4KQ1cSM+/pP5zsrN9JpRBYtynMeWZRbPCBqn1x0YPDpv5Jkq7FuoI/RW/RCENa3H5oT0w+iF/5EiK0nqFlAFNFVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686609; c=relaxed/simple;
	bh=YPOH09Lf8waYjzXH+D9qx0+KCjKdFS1sZnI5Ft7mCnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwRuqrUIAaKkjYZ8AktCAPi6Aj69/eO1mfZ3dxt9tkOAFDvvu7c5xlFmWjLVSNl3hrFtJpbwjr6eQMcfeXjgz3djAAyGkqJbOTb1fDEmNeuw7d3W89YFMiH5u+nzXv3Sgs8XHnf68eVpXN5gaVAseWEXN0YTKt+8rUt9qCb417g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXP9vZ+p; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715686606; x=1747222606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YPOH09Lf8waYjzXH+D9qx0+KCjKdFS1sZnI5Ft7mCnw=;
  b=YXP9vZ+pXRSUQ67n3tpj0sVLWw4LzSORTd3AN9VYsD8baGgarlgDKOAC
   MZdnvaiKINwL4rZjTCaXz+iH7jZAt1UL8HwoYH4pC8h+ObkK2mLuTNTtj
   awqn0rQ2yHOxPANfuqIa+GOEXIcRo2b6DNNgYUSBhu3WKIaxDdfcQXRUL
   eQYewS6J1x+TcVc3Z7KeflvGhVJ9YPdTbzUeuAXXNbdU4yh++EaHihF7T
   wzx/bA8r1Bh+5nmf5s/MLTIgXs3u3kcKU906JNxL8CzOJLmdIrdYOJJ99
   viWGfS7giF/Jgp0aKUWjYrXlgTMuqjo8yEo25H9xKmGpgNQt82dLTHZ/7
   w==;
X-CSE-ConnectionGUID: mxZOZP/NR+qe6howGIxsCA==
X-CSE-MsgGUID: h/o3dd1VSZmIouSaPAD/ZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="29180842"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29180842"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 04:36:45 -0700
X-CSE-ConnectionGUID: qPpmPOKNR2mSmQvklq+k7Q==
X-CSE-MsgGUID: iJUYB5bZRraVzQ+hErEYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61485223"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 May 2024 04:36:42 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6qSV-000BRX-2w;
	Tue, 14 May 2024 11:36:39 +0000
Date: Tue, 14 May 2024 19:36:27 +0800
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
Message-ID: <202405141800.J2dxEpiu-lkp@intel.com>
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
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.9 next-20240514]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Implement-MCTP-over-PCC-Transport/20240514-013734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240513173546.679061-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH 1/3] mctp pcc: Implement MCTP over PCC Transport
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240514/202405141800.J2dxEpiu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405141800.J2dxEpiu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405141800.J2dxEpiu-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:8:
   In file included from include/linux/if_arp.h:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
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
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
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
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
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
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/net/mctp/mctp-pcc.c:17:
>> include/acpi/acpi_drivers.h:72:43: warning: declaration of 'struct acpi_pci_root' will not be visible outside of this function [-Wvisibility]
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^
>> drivers/net/mctp/mctp-pcc.c:90:70: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
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
   include/linux/dev_printk.h:150:46: note: expanded from macro 'dev_info'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
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
   include/linux/dev_printk.h:144:44: note: expanded from macro 'dev_err'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
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

    89	
  > 90	static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *)
    91	{
    92		struct sk_buff *skb;
    93		struct mctp_pcc_packet *mpp;
    94		struct mctp_skb_cb *cb;
    95		int data_len;
    96		unsigned long buf_ptr_val;
    97		struct mctp_pcc_ndev *mctp_pcc_dev = container_of(c, struct mctp_pcc_ndev, inbox_client);
    98		void *skb_buf;
    99	
   100		mpp = (struct mctp_pcc_packet *)mctp_pcc_dev->pcc_comm_inbox_addr;
   101		buf_ptr_val = (unsigned long)mpp;
   102		data_len = readl(&mpp->pcc_header.length) + MCTP_HEADER_LENGTH;
   103		skb = netdev_alloc_skb(mctp_pcc_dev->mdev.dev, data_len);
   104		if (!skb) {
   105			mctp_pcc_dev->mdev.dev->stats.rx_dropped++;
   106			return;
   107		}
   108		skb->protocol = htons(ETH_P_MCTP);
   109		skb_buf = skb_put(skb, data_len);
   110		memcpy_fromio(skb_buf, mpp, data_len);
   111		skb_reset_mac_header(skb);
   112		skb_pull(skb, sizeof(struct mctp_pcc_hdr));
   113		skb_reset_network_header(skb);
   114		cb = __mctp_cb(skb);
   115		cb->halen = 0;
   116		skb->dev =  mctp_pcc_dev->mdev.dev;
   117		netif_rx(skb);
   118	}
   119	
   120	static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
   121	{
   122		unsigned char *buffer;
   123		struct mctp_pcc_ndev *mpnd;
   124		struct mctp_pcc_packet  *mpp;
   125		unsigned long flags;
   126		int rc;
   127	
   128		netif_stop_queue(ndev);
   129		ndev->stats.tx_bytes += skb->len;
   130		mpnd = (struct mctp_pcc_ndev *)netdev_priv(ndev);
   131		spin_lock_irqsave(&mpnd->lock, flags);
   132		buffer =  mpnd->pcc_comm_outbox_addr;
   133		mpp = mctp_pcc_extract_data(skb, mpnd->pcc_comm_outbox_addr, mpnd->hw_addr.outbox_index);
   134		rc = mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan, mpp);
   135		spin_unlock_irqrestore(&mpnd->lock, flags);
   136	
   137		dev_consume_skb_any(skb);
   138		netif_start_queue(ndev);
   139		if (!rc)
   140			return NETDEV_TX_OK;
   141		return NETDEV_TX_BUSY;
   142	}
   143	
   144	static const struct net_device_ops mctp_pcc_netdev_ops = {
   145		.ndo_start_xmit = mctp_pcc_tx,
   146		.ndo_uninit = NULL
   147	};
   148	
   149	static void  mctp_pcc_setup(struct net_device *ndev)
   150	{
   151		ndev->type = ARPHRD_MCTP;
   152		ndev->hard_header_len = 0;
   153		ndev->addr_len = sizeof(struct mctp_pcc_hw_addr);
   154		ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
   155		ndev->flags = IFF_NOARP;
   156		ndev->netdev_ops = &mctp_pcc_netdev_ops;
   157		ndev->needs_free_netdev = true;
   158	}
   159	
   160	static int create_mctp_pcc_netdev(struct acpi_device *acpi_dev,
   161					  struct device *dev, int inbox_index,
   162					  int outbox_index)
   163	{
   164		int rc;
   165		int mctp_pcc_mtu;
   166		char name[32];
   167		struct net_device *ndev;
   168		struct mctp_pcc_ndev *mctp_pcc_dev;
   169		struct mctp_pcc_hw_addr physical_link_addr;
   170	
   171		snprintf(name, sizeof(name), "mctpipcc%x", inbox_index);
   172		ndev = alloc_netdev(sizeof(struct mctp_pcc_ndev), name, NET_NAME_ENUM, mctp_pcc_setup);
   173		if (!ndev)
   174			return -ENOMEM;
   175		mctp_pcc_dev = (struct mctp_pcc_ndev *)netdev_priv(ndev);
   176		INIT_LIST_HEAD(&mctp_pcc_dev->head);
   177		spin_lock_init(&mctp_pcc_dev->lock);
   178	
   179		mctp_pcc_dev->outbox_client.tx_prepare = NULL;
   180		mctp_pcc_dev->outbox_client.tx_done = NULL;
   181		mctp_pcc_dev->hw_addr.inbox_index = inbox_index;
   182		mctp_pcc_dev->hw_addr.outbox_index = outbox_index;
   183		mctp_pcc_dev->inbox_client.rx_callback = mctp_pcc_client_rx_callback;
   184		mctp_pcc_dev->cleanup_channel = pcc_mbox_free_channel;
   185		mctp_pcc_dev->out_chan =
   186			pcc_mbox_request_channel(&mctp_pcc_dev->outbox_client,
   187						 outbox_index);
   188		if (IS_ERR(mctp_pcc_dev->out_chan)) {
   189			rc = PTR_ERR(mctp_pcc_dev->out_chan);
   190			goto free_netdev;
   191		}
   192		mctp_pcc_dev->in_chan =
   193			pcc_mbox_request_channel(&mctp_pcc_dev->inbox_client,
   194						 inbox_index);
   195		if (IS_ERR(mctp_pcc_dev->in_chan)) {
   196			rc = PTR_ERR(mctp_pcc_dev->in_chan);
   197			goto cleanup_out_channel;
   198		}
   199		mctp_pcc_dev->pcc_comm_inbox_addr =
   200			devm_ioremap(dev, mctp_pcc_dev->in_chan->shmem_base_addr,
   201				     mctp_pcc_dev->in_chan->shmem_size);
   202		if (!mctp_pcc_dev->pcc_comm_inbox_addr) {
   203			rc = -EINVAL;
   204			goto cleanup_in_channel;
   205		}
   206		mctp_pcc_dev->pcc_comm_outbox_addr =
   207			devm_ioremap(dev, mctp_pcc_dev->out_chan->shmem_base_addr,
   208				     mctp_pcc_dev->out_chan->shmem_size);
   209		if (!mctp_pcc_dev->pcc_comm_outbox_addr) {
   210			rc = -EINVAL;
   211			goto cleanup_in_channel;
   212		}
   213		mctp_pcc_dev->acpi_device = acpi_dev;
   214		mctp_pcc_dev->inbox_client.dev = dev;
   215		mctp_pcc_dev->outbox_client.dev = dev;
   216		mctp_pcc_dev->mdev.dev = ndev;
   217	
   218	/* There is no clean way to pass the MTU to the callback function
   219	 * used for registration, so set the values ahead of time.
   220	 */
   221		mctp_pcc_mtu = mctp_pcc_dev->out_chan->shmem_size -
   222			sizeof(struct mctp_pcc_hdr);
   223		ndev->mtu = mctp_pcc_mtu;
   224		ndev->max_mtu = mctp_pcc_mtu;
   225		ndev->min_mtu = MCTP_MIN_MTU;
   226	
   227		physical_link_addr.inbox_index =
   228			htonl(mctp_pcc_dev->hw_addr.inbox_index);
   229		physical_link_addr.outbox_index =
   230			htonl(mctp_pcc_dev->hw_addr.outbox_index);
   231		dev_addr_set(ndev, (const u8 *)&physical_link_addr);
   232		rc = register_netdev(ndev);
   233		if (rc)
   234			goto cleanup_in_channel;
   235		list_add_tail(&mctp_pcc_dev->head, &mctp_pcc_ndevs);
   236		return 0;
   237	cleanup_in_channel:
   238		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->in_chan);
   239	cleanup_out_channel:
   240		mctp_pcc_dev->cleanup_channel(mctp_pcc_dev->out_chan);
   241	free_netdev:
   242		unregister_netdev(ndev);
   243		free_netdev(ndev);
   244		return rc;
   245	}
   246	
   247	struct lookup_context {
   248		int index;
   249		int inbox_index;
   250		int outbox_index;
   251	};
   252	
   253	static acpi_status lookup_pcct_indices(struct acpi_resource *ares, void *context)
   254	{
   255		struct acpi_resource_address32 *addr;
   256		struct lookup_context *luc = context;
   257	
   258		switch (ares->type) {
   259		case 0x0c:
   260		case 0x0a:
   261			break;
   262		default:
   263			return AE_OK;
   264		}
   265	
   266		addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
   267		switch (luc->index) {
   268		case 0:
   269			luc->outbox_index = addr[0].address.minimum;
   270			break;
   271		case 1:
   272			luc->inbox_index = addr[0].address.minimum;
   273			break;
   274		}
   275		luc->index++;
   276		return AE_OK;
   277	}
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

