Return-Path: <netdev+bounces-131725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74098F59D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784501C20947
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2FD1AAE31;
	Thu,  3 Oct 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWfVzCjH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CF187323;
	Thu,  3 Oct 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978209; cv=none; b=QmwWoBfmwbGlPtpeRM2qbeNDFoRcn/QCXq7Syp/UjkXdAg8ufTuU2RKKYv4QTnOrKI+ajwbinV0YqdVfPaLZw7Byh/o6fWohfTTP4u/jmMMmwb5VuzRRC8IU8OO0aPHMRAYojYsmuC9RJ1BxK92vjCQCfVJXiou9M5vPTwdowkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978209; c=relaxed/simple;
	bh=15fByFKlnM0nwl8WiuCrjrJavcrzwULnKAaTeMUefgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIHd4GU93Ma5wyArIanvmD84iqNPI6HcPLeATQEo5TKtRzBJY9d+7JRBS+Kw9BEV+fImf5JzgODVuMeKVPY80E1/en2lEtNh4fGOCGJY/NdZTO3Taw14H3iDEvz2e4BXWCwAAyC8Fx574u0o1IbQnkxttMbmYfzB4v83+buO37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWfVzCjH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727978208; x=1759514208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=15fByFKlnM0nwl8WiuCrjrJavcrzwULnKAaTeMUefgM=;
  b=kWfVzCjH6IBzmqxgFGQCJLyMOOgYkxT3LVDCEccmftSeYeCzggM9HCiG
   WrwGCH8dZGtn3qouzCdGSeuNxcMv8To5+UEGhXXoY+Fdh/5X9IzzDbJmU
   StSG3c54pW3B27zzcQOdZCXv88mi3TB/O9v+t77NzLVIkc9P5jZp0th5Q
   UkwENEp0sqSq/r+L1sMDh9rZLHsfCR3yISn6HlV+PNgRKfum7Gfxc+hlX
   LZV5Ay3n7gwSOMwJ2Z3G/OUoVONgKIFLX72H2HBZjWzNRqOZpBwkqEtVF
   Slt3p/CjLlvdase10nVdEXuTPaP+AMe+QMteiBdlN59WgRRceUnapBSK4
   w==;
X-CSE-ConnectionGUID: ariiySXjSbyk7I00jXj1sw==
X-CSE-MsgGUID: 2dcJ76qpSdONqqHTUZG4EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26659209"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="26659209"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:56:47 -0700
X-CSE-ConnectionGUID: uPvYtkkPT1SY0Zytgm2BcA==
X-CSE-MsgGUID: +GwHs6ToRqWvz/pEbDUU7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="105185549"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 03 Oct 2024 10:56:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swQ4A-0000kO-1r;
	Thu, 03 Oct 2024 17:56:42 +0000
Date: Fri, 4 Oct 2024 01:55:56 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, olek2@wp.pl, shannon.nelson@amd.com
Subject: Re: [PATCHv2 net-next 08/10] net: lantiq_etop: use
 module_platform_driver_probe
Message-ID: <202410040101.1HX2nS2j-lkp@intel.com>
References: <20241001184607.193461-9-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001184607.193461-9-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-lantiq_etop-use-netif_receive_skb_list/20241002-025104
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241001184607.193461-9-rosenp%40gmail.com
patch subject: [PATCHv2 net-next 08/10] net: lantiq_etop: use module_platform_driver_probe
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20241004/202410040101.1HX2nS2j-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040101.1HX2nS2j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040101.1HX2nS2j-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/lantiq_etop.c:21:
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected identifier or '(' before '&' token
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
   include/linux/platform_device.h:320:19: note: in definition of macro 'module_platform_driver_probe'
     320 | static int __init __platform_driver##_init(void) \
         |                   ^~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/init.h:214:17: error: pasting "_" and "&" does not give a valid preprocessing token
     214 |         __PASTE(_, fn))))))
         |                 ^
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/init.h:214:9: note: in expansion of macro '__PASTE'
     214 |         __PASTE(_, fn))))))
         |         ^~~~~~~
   include/linux/init.h:280:42: note: in expansion of macro '__initcall_id'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |                                          ^~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:311:41: note: in expansion of macro '__define_initcall'
     311 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:316:24: note: in expansion of macro 'device_initcall'
     316 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   include/linux/platform_device.h:325:1: note: in expansion of macro 'module_init'
     325 | module_init(__platform_driver##_init); \
         | ^~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c:689:1: note: in expansion of macro 'module_platform_driver_probe'
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/printk.h:6,
                    from include/linux/kernel.h:31,
                    from drivers/net/ethernet/lantiq_etop.c:7:
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '&' token
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
   include/linux/init.h:269:27: note: in definition of macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:218:9: note: in expansion of macro '__PASTE'
     218 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:219:9: note: in expansion of macro '__PASTE'
     219 |         __PASTE(prefix,                                         \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:220:9: note: in expansion of macro '__PASTE'
     220 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:221:9: note: in expansion of macro '__PASTE'
     221 |         __PASTE(__iid, id))))
         |         ^~~~~~~
   include/linux/init.h:276:17: note: in expansion of macro '__initcall_name'
     276 |                 __initcall_name(initcall, __iid, id),           \
         |                 ^~~~~~~~~~~~~~~
   include/linux/init.h:280:9: note: in expansion of macro '__unique_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:209:9: note: in expansion of macro '__PASTE'
     209 |         __PASTE(__KBUILD_MODNAME,                               \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:210:9: note: in expansion of macro '__PASTE'
     210 |         __PASTE(__,                                             \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:211:9: note: in expansion of macro '__PASTE'
     211 |         __PASTE(__COUNTER__,                                    \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:212:9: note: in expansion of macro '__PASTE'
     212 |         __PASTE(_,                                              \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:213:9: note: in expansion of macro '__PASTE'
     213 |         __PASTE(__LINE__,                                       \
         |         ^~~~~~~
   include/linux/compiler_types.h:84:22: note: in expansion of macro '___PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/init.h:214:9: note: in expansion of macro '__PASTE'
     214 |         __PASTE(_, fn))))))
         |         ^~~~~~~
   include/linux/init.h:280:42: note: in expansion of macro '__initcall_id'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |                                          ^~~~~~~~~~~~~
   include/linux/init.h:282:35: note: in expansion of macro '___define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:311:41: note: in expansion of macro '__define_initcall'
     311 | #define device_initcall(fn)             __define_initcall(fn, 6)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/init.h:316:24: note: in expansion of macro 'device_initcall'
     316 | #define __initcall(fn) device_initcall(fn)
         |                        ^~~~~~~~~~~~~~~
   include/linux/module.h:88:25: note: in expansion of macro '__initcall'
      88 | #define module_init(x)  __initcall(x);
         |                         ^~~~~~~~~~
   include/linux/platform_device.h:325:1: note: in expansion of macro 'module_init'
     325 | module_init(__platform_driver##_init); \
         | ^~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c:689:1: note: in expansion of macro 'module_platform_driver_probe'
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected identifier or '(' before '&' token
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
   include/linux/platform_device.h:326:20: note: in definition of macro 'module_platform_driver_probe'
     326 | static void __exit __platform_driver##_exit(void) \
         |                    ^~~~~~~~~~~~~~~~~
>> include/linux/init.h:319:27: error: pasting "__exitcall_" and "&" does not give a valid preprocessing token
     319 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                           ^~~~~~~~~~~
   include/linux/module.h:100:25: note: in expansion of macro '__exitcall'
     100 | #define module_exit(x)  __exitcall(x);
         |                         ^~~~~~~~~~
   include/linux/platform_device.h:330:1: note: in expansion of macro 'module_exit'
     330 | module_exit(__platform_driver##_exit);
         | ^~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c:689:1: note: in expansion of macro 'module_platform_driver_probe'
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '&' token
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
   include/linux/init.h:319:40: note: in definition of macro '__exitcall'
     319 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                                        ^~
   include/linux/platform_device.h:330:1: note: in expansion of macro 'module_exit'
     330 | module_exit(__platform_driver##_exit);
         | ^~~~~~~~~~~
   drivers/net/ethernet/lantiq_etop.c:689:1: note: in expansion of macro 'module_platform_driver_probe'
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/lantiq_etop.c:682:31: warning: 'ltq_mii_driver' defined but not used [-Wunused-variable]
     682 | static struct platform_driver ltq_mii_driver = {
         |                               ^~~~~~~~~~~~~~
>> drivers/net/ethernet/lantiq_etop.c:618:1: warning: 'ltq_etop_probe' defined but not used [-Wunused-function]
     618 | ltq_etop_probe(struct platform_device *pdev)
         | ^~~~~~~~~~~~~~


vim +689 drivers/net/ethernet/lantiq_etop.c

   616	
   617	static int __init
 > 618	ltq_etop_probe(struct platform_device *pdev)
   619	{
   620		struct net_device *dev;
   621		struct ltq_etop_priv *priv;
   622		int err;
   623		int i;
   624	
   625		ltq_etop_membase = devm_platform_ioremap_resource(pdev, 0);
   626		if (IS_ERR(ltq_etop_membase)) {
   627			dev_err(&pdev->dev, "failed to remap etop engine %d", pdev->id);
   628			return PTR_ERR(ltq_etop_membase);
   629		}
   630	
   631		dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
   632					      4, 4);
   633		if (!dev)
   634			return -ENOMEM;
   635		dev->netdev_ops = &ltq_eth_netdev_ops;
   636		dev->ethtool_ops = &ltq_etop_ethtool_ops;
   637		priv = netdev_priv(dev);
   638		priv->pdev = pdev;
   639		priv->pldata = dev_get_platdata(&pdev->dev);
   640		priv->netdev = dev;
   641		spin_lock_init(&priv->lock);
   642		SET_NETDEV_DEV(dev, &pdev->dev);
   643	
   644		err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
   645		if (err < 0)
   646			return dev_err_probe(&pdev->dev, err,
   647					     "unable to read tx-burst-length property");
   648	
   649		err = device_property_read_u32(&pdev->dev, "lantiq,rx-burst-length", &priv->rx_burst_len);
   650		if (err < 0)
   651			return dev_err_probe(&pdev->dev, err,
   652					     "unable to read rx-burst-length property");
   653	
   654		for (i = 0; i < MAX_DMA_CHAN; i++) {
   655			if (IS_TX(i))
   656				netif_napi_add_weight(dev, &priv->ch[i].napi,
   657						      ltq_etop_poll_tx, 8);
   658			else if (IS_RX(i))
   659				netif_napi_add_weight(dev, &priv->ch[i].napi,
   660						      ltq_etop_poll_rx, 32);
   661			priv->ch[i].netdev = dev;
   662		}
   663	
   664		err = devm_register_netdev(&pdev->dev, dev);
   665		if (err)
   666			return err;
   667	
   668		platform_set_drvdata(pdev, dev);
   669		return 0;
   670	}
   671	
   672	static void ltq_etop_remove(struct platform_device *pdev)
   673	{
   674		struct net_device *dev = platform_get_drvdata(pdev);
   675	
   676		if (dev) {
   677			netif_tx_stop_all_queues(dev);
   678			ltq_etop_hw_exit(dev);
   679		}
   680	}
   681	
 > 682	static struct platform_driver ltq_mii_driver = {
   683		.remove_new = ltq_etop_remove,
   684		.driver = {
   685			.name = "ltq_etop",
   686		},
   687	};
   688	
 > 689	module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
   690	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

