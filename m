Return-Path: <netdev+bounces-99029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2F8D3777
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B85028792B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7755C10A03;
	Wed, 29 May 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgju41kX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617B12B82;
	Wed, 29 May 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988888; cv=none; b=JYXs7KarK1ZkQbuVZ+WhpLEMb8XTaILiNu6WRx8fcvxh9tISx2VXz4RiEN4Dkxo0aliRFgOdb62bS1CeA0WEC0JZ2LXLRM817NXuQAEW7tVxSZBSIjaY29AOBdyGqNCP7xqUOe5iLx0XQ13VBjeXWfcgfJWw8GiiOHa/PZ7MKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988888; c=relaxed/simple;
	bh=fUQHYwNl7zcp4QNb8POCu3jUGN7bcqSedR6ot/+vHPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy3CE64/RzKPQCW60mL3x+4cf8r8fBV9AovYb5WF4YZDT1wPkFWAdhmKvySTtuanLvBOgPvDf1D5z8YA2kQ7aq+lfKUgscFtmmEUOc4YrNgT20sjOG3KmtZcDBIHm7ipQChLCtOlNWeXZWsBEv3ZyUSQl6EZ/mR+kxhvUYu13fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgju41kX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716988887; x=1748524887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fUQHYwNl7zcp4QNb8POCu3jUGN7bcqSedR6ot/+vHPU=;
  b=kgju41kXqisu4QG4iA5ZIh1ktXNzQgyDzG00FXD6EGWnDVroYF44PMW6
   ueHbnfpXyTJqUrKyM6sPkKp5PR8ZJJXLD9y8P1KmEtEs3ABUhun1HcSxL
   qHrbgs6A9LQaYvByMfNXTbIVTrdmaW7NvBdonPoee4zdLd3t0+GPkcpne
   Bty/jBD321MQ4TNhE/1oMqT7aw56MqUxCrk6bpmdfL7/VVr+xidtRQnUl
   cOfKnLfAAYOYpAeu928ez8WOa8aJhSbd+Jdjju0YGBfhzCoAeiYvstplK
   PNEvYehIMFpVyiDupFCXfzSYc9a7T2mzWRjzRkjKMI4O9CmzJgNUmZYaV
   w==;
X-CSE-ConnectionGUID: ka6w4kFcTdWcxv/etIulNw==
X-CSE-MsgGUID: 5CEZxv0GTvGCtdP8a0/M8g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24804936"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="24804936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 06:21:27 -0700
X-CSE-ConnectionGUID: pAp8tyZ8QZiCnq4QgPZaJA==
X-CSE-MsgGUID: 9WHNBzE2RLyKZ166qLkHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="35406511"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 29 May 2024 06:21:23 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCJF3-000Dh5-1N;
	Wed, 29 May 2024 13:21:21 +0000
Date: Wed, 29 May 2024 21:21:16 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <202405292136.ZyuCa1Fc-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240529/202405292136.ZyuCa1Fc-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405292136.ZyuCa1Fc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405292136.ZyuCa1Fc-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/mctp/mctp-pcc.c:331:10: error: 'struct acpi_driver' has no member named 'owner'
     331 |         .owner = THIS_MODULE,
         |          ^~~~~
   In file included from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/loongarch/include/asm/bug.h:60,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/loongarch/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/net/mctp/mctp-pcc.c:7:
>> include/linux/init.h:180:21: error: initialization of 'const char *' from incompatible pointer type 'struct module *' [-Werror=incompatible-pointer-types]
     180 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:331:18: note: in expansion of macro 'THIS_MODULE'
     331 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   include/linux/init.h:180:21: note: (near initialization for 'mctp_pcc_driver.drv.name')
     180 | #define THIS_MODULE (&__this_module)
         |                     ^
   drivers/net/mctp/mctp-pcc.c:331:18: note: in expansion of macro 'THIS_MODULE'
     331 |         .owner = THIS_MODULE,
         |                  ^~~~~~~~~~~
   drivers/net/mctp/mctp-pcc.c:322:45: warning: missing braces around initializer [-Wmissing-braces]
     322 | static struct acpi_driver mctp_pcc_driver = {
         |                                             ^
   drivers/net/mctp/mctp-pcc.c: In function 'mctp_pcc_mod_init':
   drivers/net/mctp/mctp-pcc.c:343:80: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
     343 |                 ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
         |                                                                                ^
   cc1: some warnings being treated as errors


vim +180 include/linux/init.h

f2511774863487e Arjan van de Ven 2009-12-13  177  
5b20755b7780464 Masahiro Yamada  2023-11-26  178  #ifdef MODULE
5b20755b7780464 Masahiro Yamada  2023-11-26  179  extern struct module __this_module;
5b20755b7780464 Masahiro Yamada  2023-11-26 @180  #define THIS_MODULE (&__this_module)
5b20755b7780464 Masahiro Yamada  2023-11-26  181  #else
5b20755b7780464 Masahiro Yamada  2023-11-26  182  #define THIS_MODULE ((struct module *)0)
5b20755b7780464 Masahiro Yamada  2023-11-26  183  #endif
5b20755b7780464 Masahiro Yamada  2023-11-26  184  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

