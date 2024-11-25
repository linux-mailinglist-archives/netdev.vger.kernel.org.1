Return-Path: <netdev+bounces-147198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 832479D831B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F82B26383
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AF0191499;
	Mon, 25 Nov 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOZYhNoF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63381426C
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528480; cv=none; b=DV2I9xJ3Y5tRoEmusNuniFqDYjC+nauXLbv21x/WXGNm+R40GYdAYvQNwBmJ2XxZYpN1gTc1FEtkRnPD4gg72KBFR8bncQ/KCpQRQo9BH6LZzt2gLLXkEstv3pLVxiCzNY6DwfnQLhIgBRbJZQNlu+nU6DltPTy3GAvFehDOCq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528480; c=relaxed/simple;
	bh=8LWejlKEaYxvvegcxS3dkgnlT0u99V8hub9WNJnMKRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDfb7OeLE36ogZp/XMbRu4s/vazvRgjjko0/gfuxOTeRD2PxZK9is/Tac2alIs+8fimJegx1R5ot8BSfnHs0mPFgTXPF3rNWS6OthrUSCmxXTJ5b2Uuvf1O4/wMGre8v0ySL7L+CoCDFFcV9wzuoCBBRMxejsC2hfKIzAXzr5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOZYhNoF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732528478; x=1764064478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8LWejlKEaYxvvegcxS3dkgnlT0u99V8hub9WNJnMKRY=;
  b=YOZYhNoFWycQaTA0daYdQwcGO84VNyjLVx1gsbizrzTRpaNP0H1QmNVK
   SHKuCWiElfOGPg1jVkX+Ka/5cnOqxcDI6pyspGMr50fiXzeXXJxDdzfu9
   xn62ZL4GK3CrRNp85t6zJE3vY/U61vY7IpSUlpCDXUpjhUSwPDqQ/QuOx
   Z+IF8QDNhXZqP4wW2ImBIhKzizLd75FAoy2rA7LJir9SBNkurWlidLZfs
   svxIKB8VcCgmulPDJoQqN+CtSCLnzS5ukEScXLrDz52KuAQVOOtRtx4AA
   DfK15DPgm6OWDVevYjJpNwrqGq3XMFaKZIhmlxPC4uleNYpeYVaQCqKyL
   A==;
X-CSE-ConnectionGUID: Bi3f1fZxRAK4hfw3+cLnOw==
X-CSE-MsgGUID: wX7+XaK6RVCrb66hvPwaVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="36405901"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="36405901"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:54:38 -0800
X-CSE-ConnectionGUID: SXKfI93MRjqFv844HnjH+A==
X-CSE-MsgGUID: xZnl602YSIuoKCaqEwjMOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="122059625"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Nov 2024 01:54:36 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFVnc-000681-2t;
	Mon, 25 Nov 2024 09:54:32 +0000
Date: Mon, 25 Nov 2024 17:53:38 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: Re: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
Message-ID: <202411251722.Mg6UtrLH-lkp@intel.com>
References: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Abeni/ipmr-add-debug-check-for-mr-table-cleanup/20241125-104108
base:   net/main
patch link:    https://lore.kernel.org/r/23bd87600f046ce1f1c93513b6ac8f8152b22bf4.1732270911.git.pabeni%40redhat.com
patch subject: [PATCH net 1/3] ipmr: add debug check for mr table cleanup
config: mips-ip22_defconfig (https://download.01.org/0day-ci/archive/20241125/202411251722.Mg6UtrLH-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251722.Mg6UtrLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251722.Mg6UtrLH-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv6/ip6mr.c: In function 'ip6mr_can_free_table':
>> net/ipv6/ip6mr.c:346:46: error: 'struct netns_ipv6' has no member named 'mr6_rules_ops'; did you mean 'fib6_rules_ops'?
     346 |         return !check_net(net) || !net->ipv6.mr6_rules_ops;
         |                                              ^~~~~~~~~~~~~
         |                                              fib6_rules_ops


vim +346 net/ipv6/ip6mr.c

   343	
   344	static bool ip6mr_can_free_table(struct net *net)
   345	{
 > 346		return !check_net(net) || !net->ipv6.mr6_rules_ops;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

