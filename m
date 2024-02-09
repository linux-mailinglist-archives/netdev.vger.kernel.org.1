Return-Path: <netdev+bounces-70508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780084F528
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 13:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E784B2849E0
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962D936135;
	Fri,  9 Feb 2024 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZu5kw6i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD331A94
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481590; cv=none; b=lA/QTUmtvjojLBe/xj0dQDPLnlAU5NlDJhr3QhTB4a5E6p1hMzBrdT1qXURiRYdtgWQomLz7IWhco7eOhAGVePytEXIEz9sD9e5JuUKGtip8fapam+cQ4ybbVx467HsXNiQwezOyWpmFItqVcvwR5hnjYrN4TX4lL7Phgn3GA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481590; c=relaxed/simple;
	bh=70VXlrFVCBWr5hwjUeNpAFqInIs90LUlUBY2pt8udAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjp3WyWDtohl5kNCfKt1C+g2OyL7W/yEbprYpVp0Nau+2nfq2XupG5FfKzHXQMTJHRPgtr9nm2qCWlH3ozg/MtxI3IQvKEDDWpTWxGerCvxkWjhKindrNpUbfvRsifPsQsW+HKFo24U68otlVwwefEjWJMY6G8Y0WWvVPGCdKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZu5kw6i; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707481588; x=1739017588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=70VXlrFVCBWr5hwjUeNpAFqInIs90LUlUBY2pt8udAQ=;
  b=gZu5kw6isGgt+p4OWxyXY7TgD/wlLcAmHJ8MYgpGIpx/5cdDmwcbrPLp
   EbX5HsaBfFER/ln51BoEa1+3CGQh/yRNJcAYs6XeSq+cptFkN2Vyjnysk
   ofhA3G7RzqTc3P0UyI+Hecxvtg2uyuA2rGvdxKs9Qfs8lPGICvgjD0LG8
   PxtdBEJ23Gd2WRdm4xbJdJW1dyviBt8ejASy3xZkXFA7nvWoz3jz2N8Nj
   HQcNW6PlmKj2jvMB1M8StCIEkljoy9bdRZBh8ZjmWWQ+zReXJ/iHcGVA/
   ezGycE1G7QYP3rmgDFawee2Z+WOWEN1tyoPRG0XKwwVx7js59g3q7+Jbx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1564263"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1564263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="825127893"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="825127893"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2024 04:26:24 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYPxW-0004hg-1W;
	Fri, 09 Feb 2024 12:26:22 +0000
Date: Fri, 9 Feb 2024 20:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] ipmr: use exit_batch_rtnl method
Message-ID: <202402092023.Upwn6RGF-lkp@intel.com>
References: <20240208111646.535705-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208111646.535705-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/ip6mr-use-exit_batch_rtnl-method/20240208-192057
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240208111646.535705-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] ipmr: use exit_batch_rtnl method
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240209/202402092023.Upwn6RGF-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402092023.Upwn6RGF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402092023.Upwn6RGF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/ipmr.c:3134:16: error: incompatible function pointer types initializing 'void (*)(struct list_head *)' with an expression of type 'void (struct list_head *, struct list_head *)' [-Wincompatible-function-pointer-types]
    3134 |         .exit_batch = ipmr_exit_batch_rtnl,
         |                       ^~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +3134 net/ipv4/ipmr.c

  3130	
  3131	static struct pernet_operations ipmr_net_ops = {
  3132		.init = ipmr_net_init,
  3133		.exit = ipmr_net_exit,
> 3134		.exit_batch = ipmr_exit_batch_rtnl,
  3135	};
  3136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

