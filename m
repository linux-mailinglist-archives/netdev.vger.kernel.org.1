Return-Path: <netdev+bounces-119889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFFE957587
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567C21F21436
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72281581F9;
	Mon, 19 Aug 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agmrdRYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F549627
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098627; cv=none; b=e1WNQRDggvmJZnYOBP3mTs5iQpEe7rQGjHUZZZixXSToDkb6z7JoUG8uKKfT66o0+JxmlrGwp8n81oTFLOhBwo1+IIRn4vTlssRN1Lf1s7FaiJ11H/jEvGW5luZm1dZQOFj1xoK1wyiyah8PI7yyq4xaMLPcsv67kKjwwwp6EDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098627; c=relaxed/simple;
	bh=vx21SrjktdsbtSbDIQ40rp5dy3lmYsFI0PrEODgHFiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULP+qPhGPsbf+GEM4eJOAspxpQRCzuTLzW92+EyvUCNh1B+F3ga008S+03MkA4lvKeYXIsG5sJxNY8+Hlsm90xP06R11TElMZBz8LCxidx13DUxYReWIhOuJf0W8/k3D9B39edlmqI0xoEZHQSle2UsDdQzpt9JTDCE+dZPRjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agmrdRYZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724098625; x=1755634625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vx21SrjktdsbtSbDIQ40rp5dy3lmYsFI0PrEODgHFiM=;
  b=agmrdRYZ/LrB3mByA6B8kXB8DHIfZyvGIkHqMn7ZurzBkeRc8oayH78f
   FvUWGaZxQQ72at6NsaSLcj6BHVwzziGXKFsDoUJU3QT74j6Tm7fGo8Q0a
   bMlqMH2wYVNYSQEgpPOga/tl/qB5Nzg5lTxeWICBeI952GYvyo8baXk0+
   dzKTvEpU7gsPgur0jQztk+9eVcgYuvDVAEeMoTf7GnvGbckVqsM8UPNUB
   B0SuB5jZL0dfQyyjI+zKq2jOLe+WZDtl21+Jw1OBC/AxJzOuYZdohrFbl
   01gNxi/EiILUDV+80mS6Ugg5m6bGCZIYKtnnmwS6ZVVVmLZdfN48JIeUx
   g==;
X-CSE-ConnectionGUID: Jiks7p2RRJqT7CalVd3CSg==
X-CSE-MsgGUID: p4ii7BhQRfSIpIjZFGpKnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22545674"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22545674"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 13:17:04 -0700
X-CSE-ConnectionGUID: UgnlM4QSR5ikTJm33iWR3Q==
X-CSE-MsgGUID: 6pE7TPDrTfm5TlXm6RDu0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="60454383"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2024 13:17:02 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg8oF-0009Ou-1t;
	Mon, 19 Aug 2024 20:16:59 +0000
Date: Tue, 20 Aug 2024 04:16:24 +0800
From: kernel test robot <lkp@intel.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [PATCHv2 net-next 1/3] bonding: add common function to check
 ipsec device
Message-ID: <202408200345.a4DQ8ecT-lkp@intel.com>
References: <20240819075334.236334-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819075334.236334-2-liuhangbin@gmail.com>

Hi Hangbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Hangbin-Liu/bonding-add-common-function-to-check-ipsec-device/20240819-195504
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240819075334.236334-2-liuhangbin%40gmail.com
patch subject: [PATCHv2 net-next 1/3] bonding: add common function to check ipsec device
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240820/202408200345.a4DQ8ecT-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408200345.a4DQ8ecT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408200345.a4DQ8ecT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/m68k/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:314,
                    from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from drivers/net/bonding/bond_main.c:35:
   drivers/net/bonding/bond_main.c: In function 'bond_ipsec_dev':
>> include/linux/stddef.h:8:14: error: incompatible types when returning type 'void *' but 'struct net_device' was expected
       8 | #define NULL ((void *)0)
         |              ^
   drivers/net/bonding/bond_main.c:434:24: note: in expansion of macro 'NULL'
     434 |                 return NULL;
         |                        ^~~~
>> include/linux/stddef.h:8:14: error: incompatible types when returning type 'void *' but 'struct net_device' was expected
       8 | #define NULL ((void *)0)
         |              ^
   drivers/net/bonding/bond_main.c:442:24: note: in expansion of macro 'NULL'
     442 |                 return NULL;
         |                        ^~~~
>> drivers/net/bonding/bond_main.c:446:16: error: incompatible types when returning type 'struct net_device *' but 'struct net_device' was expected
     446 |         return real_dev;
         |                ^~~~~~~~
   drivers/net/bonding/bond_main.c: In function 'bond_ipsec_offload_ok':
>> drivers/net/bonding/bond_main.c:630:20: error: incompatible types when assigning to type 'struct net_device *' from type 'struct net_device'
     630 |         real_dev = bond_ipsec_dev(xs);
         |                    ^~~~~~~~~~~~~~


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

