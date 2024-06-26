Return-Path: <netdev+bounces-107019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B291881E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B22283337
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA218F2C8;
	Wed, 26 Jun 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aA/bVsbR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78813AA4C;
	Wed, 26 Jun 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719421374; cv=none; b=Wi4mg6hMzZYppJrMkYDl1U+DTlDOBMKZAiVIb6unTrC/vm+HYyMnHStwQGaOuEsbvlFV9Rj6ozR8HIzhNIYb5TY4GZ2Rj/COddT/o6ksKTKTMy5V8vpi3LYNL7AIaWb/gu/m7HxRMSvSJdU8FjgQ050mBRfU4T33FY9cS1w/c+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719421374; c=relaxed/simple;
	bh=crf8AezQv9UCFPLZ74jHjsfZWl8S/XxU0uraBAjQzMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMv6pQtUblBbcYoxG3RIiaxzr4jQ3FB2vM+5vZg7UX0pn1aetPzlR0FA+vAglFFJkSreoCCqlP/crrCY6vOKHP+7EU9NT2ztHcvzLeD+gjvhVOXDSrLYJqsBG0h6S7SCpMIhYSIYL7B5pmWGQJy05Aq8qfeyBukcJkF0eps5kqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aA/bVsbR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719421371; x=1750957371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crf8AezQv9UCFPLZ74jHjsfZWl8S/XxU0uraBAjQzMY=;
  b=aA/bVsbRg4PwoP5kIbgaTSUYQzZNQe7+acymv+wjLLVHNZdPJFw0S841
   sbOvf8m7ygob2hX1A691Kedwb9msLG7lBVwVlqsy2OFDID0zpsPNN1ukn
   WyM1i9r3dmqWHNnMls1g0zsOsyVn53nJckMIJ8Ndt2ToAx4zH5xzoQojz
   86zIrzc4nsyKmannRDkxuA0Ynfgsluon0WKhJ5R4p6RyP+9be8StFPOLT
   TO2+56J50y9p7o+c9QoqZHp482/3jz/WDakADQpXkgkc8QC1tdZLeokjc
   FG2Qh+KSm5sSNmq7yRCJeSH50nbP8UGzcLec96ZUEBG3p8e2T7bpPJsNY
   w==;
X-CSE-ConnectionGUID: PdlO5aCmRHG4hcvloFCzAQ==
X-CSE-MsgGUID: DXB9ftxMT/SjdSCGRG82CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="39016751"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="39016751"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 10:02:43 -0700
X-CSE-ConnectionGUID: pjM3nqbBTc+NA8Lm4QvFvQ==
X-CSE-MsgGUID: Ti5ud7L3TymmpcXAlIMMYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="81610353"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 26 Jun 2024 10:02:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMW2Z-000FPa-0O;
	Wed, 26 Jun 2024 17:02:39 +0000
Date: Thu, 27 Jun 2024 01:02:07 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202406270051.3C6XAHU8-lkp@intel.com>
References: <20240625185333.23211-4-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625185333.23211-4-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc5 next-20240625]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20240626-052432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20240625185333.23211-4-admiyo%40os.amperecomputing.com
patch subject: [PATCH v3 3/3] mctp pcc: Implement MCTP over PCC Transport
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20240627/202406270051.3C6XAHU8-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270051.3C6XAHU8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406270051.3C6XAHU8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:214:9: note: in expansion of macro 'dev_dbg'
     214 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:215:17: error: implicit declaration of function 'acpi_device_hid'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     215 |                 acpi_device_hid(acpi_dev));
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
   drivers/net/mctp/mctp-pcc.c:214:9: note: in expansion of macro 'dev_dbg'
     214 |         dev_dbg(&acpi_dev->dev, "Adding mctp_pcc device for HID  %s\n",
         |         ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:216:22: error: implicit declaration of function 'acpi_device_handle'; did you mean 'acpi_device_dep'? [-Werror=implicit-function-declaration]
     216 |         dev_handle = acpi_device_handle(acpi_dev);
         |                      ^~~~~~~~~~~~~~~~~~
         |                      acpi_device_dep
   drivers/net/mctp/mctp-pcc.c:216:20: warning: assignment to 'acpi_handle' {aka 'void *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
     216 |         dev_handle = acpi_device_handle(acpi_dev);
         |                    ^
   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14:
   drivers/net/mctp/mctp-pcc.c:220:34: error: invalid use of undefined type 'struct acpi_device'
     220 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                                  ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/mctp/mctp-pcc.c:220:17: note: in expansion of macro 'dev_err'
     220 |                 dev_err(&acpi_dev->dev, "FAILURE to lookup PCC indexes from CRS");
         |                 ^~~~~~~
   drivers/net/mctp/mctp-pcc.c:225:24: error: invalid use of undefined type 'struct acpi_device'
     225 |         dev = &acpi_dev->dev;
         |                        ^~
   drivers/net/mctp/mctp-pcc.c:271:17: error: invalid use of undefined type 'struct acpi_device'
     271 |         acpi_dev->driver_data = mctp_pcc_dev;
         |                 ^~
   drivers/net/mctp/mctp-pcc.c: At top level:
   drivers/net/mctp/mctp-pcc.c:326:15: error: variable 'mctp_pcc_driver' has initializer but incomplete type
     326 | static struct acpi_driver mctp_pcc_driver = {
         |               ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:327:10: error: 'struct acpi_driver' has no member named 'name'
     327 |         .name = "mctp_pcc",
         |          ^~~~
   drivers/net/mctp/mctp-pcc.c:327:17: warning: excess elements in struct initializer
     327 |         .name = "mctp_pcc",
         |                 ^~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:327:17: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:328:10: error: 'struct acpi_driver' has no member named 'class'
     328 |         .class = "Unknown",
         |          ^~~~~
   drivers/net/mctp/mctp-pcc.c:328:18: warning: excess elements in struct initializer
     328 |         .class = "Unknown",
         |                  ^~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:328:18: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:329:10: error: 'struct acpi_driver' has no member named 'ids'
     329 |         .ids = mctp_pcc_device_ids,
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:329:16: warning: excess elements in struct initializer
     329 |         .ids = mctp_pcc_device_ids,
         |                ^~~~~~~~~~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:329:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:330:10: error: 'struct acpi_driver' has no member named 'ops'
     330 |         .ops = {
         |          ^~~
   drivers/net/mctp/mctp-pcc.c:330:16: error: extra brace group at end of initializer
     330 |         .ops = {
         |                ^
   drivers/net/mctp/mctp-pcc.c:330:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:330:16: warning: excess elements in struct initializer
   drivers/net/mctp/mctp-pcc.c:330:16: note: (near initialization for 'mctp_pcc_driver')
   drivers/net/mctp/mctp-pcc.c:334:10: error: 'struct acpi_driver' has no member named 'owner'
     334 |         .owner = THIS_MODULE,
         |          ^~~~~
   In file included from arch/parisc/include/asm/alternative.h:18,
                    from arch/parisc/include/asm/barrier.h:5,
                    from include/linux/list.h:11,
                    from include/linux/resource_ext.h:9:
   include/linux/init.h:180:21: warning: excess elements in struct initializer
     180 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:334:18: note: in expansion of macro 'THIS_MODULE'
     334 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:180:21: note: (near initialization for 'mctp_pcc_driver')
     180 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:334:18: note: in expansion of macro 'THIS_MODULE'
     334 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:337:1: warning: data definition has no type or storage class
     337 | module_acpi_driver(mctp_pcc_driver);
         | ^~~~~~~~~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:337:1: error: type defaults to 'int' in declaration of 'module_acpi_driver' [-Werror=implicit-int]
>> drivers/net/mctp/mctp-pcc.c:337:1: warning: parameter names (without types) in function declaration
   drivers/net/mctp/mctp-pcc.c:326:27: error: storage size of 'mctp_pcc_driver' isn't known
     326 | static struct acpi_driver mctp_pcc_driver = {
         |                           ^~~~~~~~~~~~~~~
>> drivers/net/mctp/mctp-pcc.c:326:27: warning: 'mctp_pcc_driver' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +337 drivers/net/mctp/mctp-pcc.c

   325	
 > 326	static struct acpi_driver mctp_pcc_driver = {
   327		.name = "mctp_pcc",
   328		.class = "Unknown",
   329		.ids = mctp_pcc_device_ids,
   330		.ops = {
   331			.add = mctp_pcc_driver_add,
   332			.remove = mctp_pcc_driver_remove,
   333		},
   334		.owner = THIS_MODULE,
   335	};
   336	
 > 337	module_acpi_driver(mctp_pcc_driver);
   338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

