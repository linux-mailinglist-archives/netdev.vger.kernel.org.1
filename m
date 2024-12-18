Return-Path: <netdev+bounces-153127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E4A9F6EC8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 21:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF38169BF3
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2BB1FBEAC;
	Wed, 18 Dec 2024 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMAtgjRI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E8158531
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734553049; cv=none; b=L2h6O0W9BBucEbdUw9K5XScAQstcLDFy8sj5BV7c+RVXIKI0LBbLk8u3WUJ5WyrvbZ8det+HcrIcjBxEIAVqx0+a1AzOriisaNBZURQr3qnmTeQooacf/z5gr2t6pbLCZ7Olk886xqOBDvLLTs6C7bOP7TtpLoKg6FHLcDgXaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734553049; c=relaxed/simple;
	bh=os0R3YlpxIFAksdVVec1bCoWOcHEzdEMzQbQ26/Eoq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkyYCMqWjLIYgdp3Lyt/IS6gXooJpRzulfEAw3TzP+4OMdIJZSjwFJVCAfhzpq/9v8RHqtDMEgCkzGu8zYLNGDlRUyMoi6k3MNIbescBoMh0ZfoXy/ZGbbtWw94wYLIDn96suND4fVeori8tElPXB8WsxzJiaA7r0IoxhB/3F5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMAtgjRI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734553048; x=1766089048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=os0R3YlpxIFAksdVVec1bCoWOcHEzdEMzQbQ26/Eoq0=;
  b=NMAtgjRIk3VowIGonxV54r/hQkb+RNJZs9Txd7xTKb3QP42W5V/nnusq
   5/yuazA43QXPgiIF0tEmrYm2SGNqYhkOiTKvCek+/G9LO5++/jNU3HBaO
   a1OkjREjaKLcXA/kthnJXMTvmwMPMoem0uD1oT3Ly2ADQB+ek8MnwsMlw
   A8O2yCmxefC1R8EoX8vJEjJinAO1WzzWYnMWj/3oZ0MJHyuppx4CWc2SR
   kHvMTtASxkw/XslSomfx7gV/uELJjGjWlZqkOSvPES99mcxRQTUzyQXAv
   GL7bbt7q7NQw8kl82zuy+fErn1J5Ag/p6G+Vs37TgEAGGcnbfaf/l6+pL
   Q==;
X-CSE-ConnectionGUID: SVLY1A5eROGNs7THuJoiQg==
X-CSE-MsgGUID: 8Z0uAnZkQiKIIoAi2VYoGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34328591"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="34328591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 12:17:27 -0800
X-CSE-ConnectionGUID: +N1nUnjfSUaj9gak7/gslw==
X-CSE-MsgGUID: AYwPWfvYQXGIUcs7FwgBdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98783251"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 18 Dec 2024 12:17:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tO0Tx-000Gbu-0e;
	Wed, 18 Dec 2024 20:17:21 +0000
Date: Thu, 19 Dec 2024 04:16:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, michael.chan@broadcom.com, tariqt@nvidia.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	jdamato@fastly.com, shayd@nvidia.com, akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 4/8] net: napi: add CPU
 affinity to napi->config
Message-ID: <202412190421.N2xtn20H-lkp@intel.com>
References: <20241218165843.744647-5-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218165843.744647-5-ahmed.zaki@intel.com>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Zaki/net-napi-add-irq_flags-to-napi-struct/20241219-010125
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241218165843.744647-5-ahmed.zaki%40intel.com
patch subject: [Intel-wired-lan] [PATCH net-next v2 4/8] net: napi: add CPU affinity to napi->config
config: arm-randconfig-001-20241219 (https://download.01.org/0day-ci/archive/20241219/202412190421.N2xtn20H-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241219/202412190421.N2xtn20H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412190421.N2xtn20H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/core/dev.c:6716:6: warning: unused variable 'rc' [-Wunused-variable]
    6716 |         int rc;
         |             ^~
   net/core/dev.c:6746:7: warning: unused variable 'rc' [-Wunused-variable]
    6746 |         int  rc;
         |              ^~
>> net/core/dev.c:6766:7: warning: variable 'glue_created' is uninitialized when used here [-Wuninitialized]
    6766 |         if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
         |              ^~~~~~~~~~~~
   net/core/dev.c:6745:19: note: initialize the variable 'glue_created' to silence this warning
    6745 |         bool glue_created;
         |                          ^
         |                           = 0
   3 warnings generated.


vim +/glue_created +6766 net/core/dev.c

  6765	
> 6766		if (!glue_created && flags & NAPIF_IRQ_AFFINITY) {
  6767			glue = kzalloc(sizeof(*glue), GFP_KERNEL);
  6768			if (!glue)
  6769				return;
  6770			glue->notify.notify = netif_irq_cpu_rmap_notify;
  6771			glue->notify.release = netif_napi_affinity_release;
  6772			glue->data = napi;
  6773			glue->rmap = NULL;
  6774			napi->irq_flags |= NAPIF_IRQ_NORMAP;
  6775		}
  6776	}
  6777	EXPORT_SYMBOL(netif_napi_set_irq);
  6778	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

