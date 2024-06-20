Return-Path: <netdev+bounces-105211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96413910218
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4599B212D9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D01AAE1E;
	Thu, 20 Jun 2024 11:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTd57bA7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8B15B118;
	Thu, 20 Jun 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881563; cv=none; b=b9sdRFFfM8G4Ncr3rPHa8NGHdyr1bnePHJkk3XlbZVN5NX+2MmEOKr/iok5FXQiAQx0WS8TyVOSMsd2s9BY2ZMLj2mb7nL/LOZfdTHbs2mDaxDp4ViKeia/M6T1kICynKJC3HbzW3NAIqUndgdTizEKXbNO6oCkmQWOCR6yYEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881563; c=relaxed/simple;
	bh=bMctWlD7zukpTaZLikbgI4muHaEbgguS6iDYYVOts4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUIL43qaAXn6cYCkTOneqQZ9NDioyzeKvbCZ1d6AwVnEWiIltLGdDya82bT47PMcFZKCyl83I+URwJH9RBhJv1HDOXvpIhjnSiU1PQb0ETW6v0ZarC2vB+wL516ZW203NiO+IVEX0qrslqAIUpQMPdbqYKieht/coBlBVUkhURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTd57bA7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718881560; x=1750417560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bMctWlD7zukpTaZLikbgI4muHaEbgguS6iDYYVOts4Y=;
  b=lTd57bA7thh95xjPgyH+MpfU8PHTYwU8vBdmd0Am2vDuOrP4cCG5BYnN
   kaMyIfeTv+EO++f20Wm/55jAtxyQGHOyIpPUXkERmqZZiYDNvwG/Ioel4
   r+4Vm7mNUVVoSexL3ascjrJAhzDnEPx/9UjDwCok5vJksAQX3TkYBRn/c
   V+3s+hQqisextPjVwaYlGU7ygWk8hmlwQMOTrJdbQdMvxGIpHL1iKOM3l
   e/dlzq5E9voOJ0EL0RdvROzHPrdq6OSG84hnwlU/MaxEtcQCNQuU/N+A8
   5ZOHO23M8HwpXSPIti/+nr/Nfx7rs0kGslpTCUJ+MNRDKAqgYUXtmlcW+
   Q==;
X-CSE-ConnectionGUID: emd/SPcmS9SLI/pWuBN0og==
X-CSE-MsgGUID: 0kB0M/wGTq6NVWYvmWaVsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15680575"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15680575"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 04:06:00 -0700
X-CSE-ConnectionGUID: tAiPoIFUTM6nKmUtPzXfWg==
X-CSE-MsgGUID: HYi2uvTKQoe7+KIdfUesqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="65456940"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Jun 2024 04:05:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKFc2-0007YE-1a;
	Thu, 20 Jun 2024 11:05:54 +0000
Date: Thu, 20 Jun 2024 19:05:41 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202406201832.4oSZmptU-lkp@intel.com>
References: <20240619200552.119080-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619200552.119080-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc4 next-20240619]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240620-040816
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240619200552.119080-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20240620/202406201832.4oSZmptU-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406201832.4oSZmptU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406201832.4oSZmptU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/mctp/mctp-pcc.c:17:
   include/acpi/acpi_drivers.h:72:43: warning: 'struct acpi_pci_root' declared inside parameter list will not be visible outside of this definition or declaration
      72 | struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
         |                                           ^~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_tx':
>> drivers/net/mctp/mctp-pcc.c:116:13: warning: unused variable 'rc' [-Wunused-variable]
     116 |         int rc;
         |             ^~
   drivers/net/mctp/mctp-pcc.c: In function 'create_mctp_pcc_netdev':
   drivers/net/mctp/mctp-pcc.c:223:17: error: invalid use of undefined type 'struct acpi_device'
     223 |         acpi_dev->driver_data = mctp_pcc_dev;
         |                 ^~
   In file included from include/linux/printk.h:573,
                    from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/net/mctp/mctp-pcc.c:7:
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_driver_add':
   drivers/net/mctp/mctp-pcc.c:291:22: error: invalid use of undefined type 'struct acpi_device'
     291 |         dev_dbg(&adev->dev, "Adding mctp_pcc device for HID  %s\n",
         |                      ^~
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
   drivers/net/mctp/mctp-pcc.c:291:9: note: in expansion of macro 'dev_dbg'
     291 |         dev_dbg(&adev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:292:17: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     292 |                 acpi_device_hid(adev));
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
   drivers/net/mctp/mctp-pcc.c:291:9: note: in expansion of macro 'dev_dbg'
     291 |         dev_dbg(&adev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:293:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     293 |         dev_handle = acpi_device_handle(adev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
   drivers/net/mctp/mctp-pcc.c:293:20: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     293 |         dev_handle = acpi_device_handle(adev);
         |                    ^
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14:
   drivers/net/mctp/mctp-pcc.c:297:30: error: invalid use of undefined type 'struct acpi_device'
     297 |                 dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:297:17: note: in expansion of macro 'dev_err'
     297 |                 dev_err(&adev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                 ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:302:50: error: invalid use of undefined type 'struct acpi_device'
     302 |         return create_mctp_pcc_netdev(adev, &adev->dev, inbox_index,
         |                                                  ^~
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:336:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     336 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:337:10: error: 'struct acpi_driver' has no member named 'name'
     337 |         .name = "mctp_pcc",
         |          ^~~~
   drivers/net/mctp/mctp-pcc.c:337:17: warning: excess elements in struct initializer
     337 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:337:17: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:338:10: error: 'struct acpi_driver' has no member named 'class'
     338 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:338:18: warning: excess elements in struct initializer
     338 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:338:18: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:339:10: error: 'struct acpi_driver' has no member named 'ids'
     339 |         .ids = mctp_pcc_device_ids,
         |          ^~~


vim +/rc +116 drivers/net/mctp/mctp-pcc.c

   109	
   110	static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
   111	{
   112		struct mctp_pcc_hdr pcc_header;
   113		struct mctp_pcc_ndev *mpnd;
   114		void __iomem *buffer;
   115		unsigned long flags;
 > 116		int rc;
   117	
   118		ndev->stats.tx_bytes += skb->len;
   119		ndev->stats.tx_packets++;
   120		mpnd = netdev_priv(ndev);
   121	
   122		spin_lock_irqsave(&mpnd->lock, flags);
   123		buffer = mpnd->pcc_comm_outbox_addr;
   124		pcc_header.signature = PCC_MAGIC | mpnd->hw_addr.outbox_index;
   125		pcc_header.flags = PCC_HEADER_FLAGS;
   126		memcpy(pcc_header.mctp_signature, MCTP_SIGNATURE, SIGNATURE_LENGTH);
   127		pcc_header.length = skb->len + SIGNATURE_LENGTH;
   128		memcpy_toio(buffer, &pcc_header, sizeof(struct mctp_pcc_hdr));
   129		memcpy_toio(buffer + sizeof(struct mctp_pcc_hdr), skb->data, skb->len);
   130		mpnd->out_chan->mchan->mbox->ops->send_data(mpnd->out_chan->mchan,
   131							    NULL);
   132		spin_unlock_irqrestore(&mpnd->lock, flags);
   133	
   134		dev_consume_skb_any(skb);
   135		return NETDEV_TX_OK;
   136	}
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

