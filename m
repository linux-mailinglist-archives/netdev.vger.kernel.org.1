Return-Path: <netdev+bounces-122494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563896184A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40C2284613
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555951D31A8;
	Tue, 27 Aug 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrLA69B/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BC1D31A7
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788758; cv=none; b=V4mFNgEkjHAk+yKUHLvLY8mCLlm4BKYPithOyPUxLspIKCYgJfBrzIiRg3/T2VjHNbsYa3g0XfLWJ1YovfE2wUFgqa/1LQpTvY3m5jQ+MWMQHgleIep0A9aBH6Ekn+4b7F4jN5HvZGP1VABSX+ybQJYddF9lXk3/ji3o7XMjNEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788758; c=relaxed/simple;
	bh=9Xdnj7In63B3Pt/+CpcyLB8pLHtmr9lnlOtEhuF5NM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqYfcx2Kj74HzMVHQqos0SG0dv1mv+QY9NThkUhHqprFTqBEnDUttrX25lRvGdryD15ISXziEgtqrjPxgwUjV1tMsytTPB4kNitQHjozeIfkXTOBs2x5k7X9etu8uDzoVaAUQtNNrASlEoeEkJu/aGGluZzOco4KuAQjzFth/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrLA69B/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724788756; x=1756324756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Xdnj7In63B3Pt/+CpcyLB8pLHtmr9lnlOtEhuF5NM0=;
  b=mrLA69B/W7mIGKxImb1HFzrTH7pwEYHoT9knQyPCZGE2NoggFu0jcx9O
   82E4uvYgqbFpMr4cRwqwlObIk6jv0I/D1HwvxU7uYnml5ZzHK8zpu6nsi
   WQAhUeQGvPEDQxfOaE6PI9pk6jO94A6aVxszCA1DWAdgPs8eQmIoVpsNb
   YMq1BhegezyUaGdHvJpyJkdCHtevAdvDg0KbY/6WXeGogbU7rWlf9sewr
   RQEPLMwBOcOXK+scOfr1VuIzqVE0tSCXhdAFo/GM+NSIU+aTlonr8qI0V
   pe4Td6YjmTT4V0bzrCzowrb7CRWLpA6qvrJ+kJ7PNUGfgCmm5ReBhWB/q
   A==;
X-CSE-ConnectionGUID: 3ChsgIOrTp+F6Nya0Gu+xA==
X-CSE-MsgGUID: Al143l3HSKaLiFr6eoEOtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="45808088"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="45808088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:59:15 -0700
X-CSE-ConnectionGUID: d/HPXipGQfGg1JiOdEOMHg==
X-CSE-MsgGUID: FoDR3zVtT+6o/FJNF1nSQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63016573"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Aug 2024 12:59:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj2LO-000K2I-2a;
	Tue, 27 Aug 2024 19:59:10 +0000
Date: Wed, 28 Aug 2024 03:59:05 +0800
From: kernel test robot <lkp@intel.com>
To: Brett Creeley <brett.creeley@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, shannon.nelson@amd.com,
	brett.creeley@amd.com
Subject: Re: [PATCH v2 net-next 5/5] ionic: convert Rx queue buffers to use
 page_pool
Message-ID: <202408280318.gE2lxcpO-lkp@intel.com>
References: <20240826184422.21895-6-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826184422.21895-6-brett.creeley@amd.com>

Hi Brett,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Brett-Creeley/ionic-debug-line-for-Tx-completion-errors/20240827-024626
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240826184422.21895-6-brett.creeley%40amd.com
patch subject: [PATCH v2 net-next 5/5] ionic: convert Rx queue buffers to use page_pool
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240828/202408280318.gE2lxcpO-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280318.gE2lxcpO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280318.gE2lxcpO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:28,
                    from include/linux/skbuff.h:13,
                    from include/linux/ip.h:16,
                    from drivers/net/ethernet/pensando/ionic/ionic_txrx.c:4:
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c: In function 'ionic_rx_build_skb':
>> include/linux/minmax.h:93:37: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '65536' to '0' [-Woverflow]
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                     ^
   include/linux/minmax.h:96:9: note: in expansion of macro '__cmp_once_unique'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ^~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:203:28: note: in expansion of macro 'min_t'
     203 |                 frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
         |                            ^~~~~
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c: In function 'ionic_rx_fill':
>> include/linux/minmax.h:93:37: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '65536' to '0' [-Woverflow]
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                     ^
   include/linux/minmax.h:96:9: note: in expansion of macro '__cmp_once_unique'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ^~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:797:34: note: in expansion of macro 'min_t'
     797 |                 first_frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
         |                                  ^~~~~
>> include/linux/minmax.h:93:37: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '65536' to '0' [-Woverflow]
      93 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
         |                                     ^
   include/linux/minmax.h:96:9: note: in expansion of macro '__cmp_once_unique'
      96 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:213:27: note: in expansion of macro '__cmp_once'
     213 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
         |                           ^~~~~~~~~~
   drivers/net/ethernet/pensando/ionic/ionic_txrx.c:832:36: note: in expansion of macro 'min_t'
     832 |                         frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE);
         |                                    ^~~~~


vim +93 include/linux/minmax.h

d03eba99f5bf7c David Laight   2023-09-18  91  
017fa3e8918784 Linus Torvalds 2024-07-28  92  #define __cmp_once_unique(op, type, x, y, ux, uy) \
017fa3e8918784 Linus Torvalds 2024-07-28 @93  	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
017fa3e8918784 Linus Torvalds 2024-07-28  94  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

