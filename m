Return-Path: <netdev+bounces-143174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495FB9C1560
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA30CB22315
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA5126BE1;
	Fri,  8 Nov 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQr1+wiI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5E7DA95;
	Fri,  8 Nov 2024 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039714; cv=none; b=h8Dkxgx9FiSMTkIa4VPQSMfRJn2aHeC9N+l3+bAuo2i+TrSH8SZtOtTLFyGiR8fFHUb9+V0QrwMtJmkhPO6oSxuSeTFTw5Y3vswZ0DGpm9TZaekafBq8FDgRs0b1GFe/u1FIoAisY8awboSH4frIQl0TxH8k1AGYF8YUJW1sics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039714; c=relaxed/simple;
	bh=1n2L2doiBZ2X85DwBXNbtzaJ+cTWmnfXCmDSppPtlYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGNS/Q2onAbtoJsVFqy4J/nRyMfn91J8MLPSk/SOYeFr7JCOHnvhb5lV7WW+0POymMN5VHT3qUgHcb7YAfmRNs7/1NevRAd1IP3swsRWxP+qtowYKn/AJZlxZJc2cB3uUVblUwJI2e4R9tn3FhpYa30W5xzq0GCffnKBL0UBR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQr1+wiI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731039712; x=1762575712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1n2L2doiBZ2X85DwBXNbtzaJ+cTWmnfXCmDSppPtlYE=;
  b=EQr1+wiIxJYWSByfAZlfnIe7QakaRkFdcbhTlfoBdgX02w/FVpXDT1bx
   HXkoraHg8PphAP2LDwifTYBPbNWmxqybg6NxRvi57xAswKBIWXuHQWat7
   E02xdg1oppexsWGN2bfuM68kuzaI5/LZ6o4NmSGmaFK95cJTabaf8XZHa
   agbFAHE5RYHTc4DjbhUiBpMl87ly3lx1x98lI3qc9S5qlLfT9r9XaRFSw
   ziqxZsBxlNWxTRwJmcAsHKYKrGnPjV/PTFxNT8xUXAcJ2Vloo9oDmRmSm
   zZM/H7FDe/DiZqCD/w79dHxexDyxrOVkrDVZiXmAS/uWzWZY7SVyyiAyV
   A==;
X-CSE-ConnectionGUID: ojVMK+7vQKijWmH8HI4WUA==
X-CSE-MsgGUID: gH6As6RoRTOwQOq/aWnY0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34696146"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="34696146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 20:21:52 -0800
X-CSE-ConnectionGUID: Y0PcV1vwTCKm5JHftQYVfw==
X-CSE-MsgGUID: jytUMIO2S7WVovrh9bs/VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="90188296"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 Nov 2024 20:21:48 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9GVG-000r0k-1Z;
	Fri, 08 Nov 2024 04:21:46 +0000
Date: Fri, 8 Nov 2024 12:21:37 +0800
From: kernel test robot <lkp@intel.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
Message-ID: <202411081130.CxioaC2A-lkp@intel.com>
References: <20241107212309.3097362-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-6-almasrymina@google.com>

Hi Mina,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mina-Almasry/net-page_pool-rename-page_pool_alloc_netmem-to-_netmems/20241108-052530
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241107212309.3097362-6-almasrymina%40google.com
patch subject: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241108/202411081130.CxioaC2A-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241108/202411081130.CxioaC2A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411081130.CxioaC2A-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:40,
                    from include/linux/if_ether.h:19,
                    from arch/s390/include/asm/diag.h:12,
                    from arch/s390/include/asm/kvm_para.h:25,
                    from include/uapi/linux/kvm_para.h:37,
                    from include/linux/kvm_para.h:5,
                    from include/linux/kvm_host.h:41,
                    from arch/s390/kernel/asm-offsets.c:11:
   include/net/netmem.h: In function 'netmem_prefetch':
>> include/net/netmem.h:179:9: error: implicit declaration of function 'prefetch' [-Wimplicit-function-declaration]
     179 |         prefetch(netmem_to_page(netmem));
         |         ^~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/s390/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/prefetch +179 include/net/netmem.h

   173	
   174	static inline void netmem_prefetch(netmem_ref netmem)
   175	{
   176		if (netmem_is_net_iov(netmem))
   177			return;
   178	
 > 179		prefetch(netmem_to_page(netmem));

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

