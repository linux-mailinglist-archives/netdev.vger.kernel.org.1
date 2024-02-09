Return-Path: <netdev+bounces-70456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066B984F12B
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA711F22D87
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5065BC0;
	Fri,  9 Feb 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqS9DTew"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3BE65BA4
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465682; cv=none; b=teYLXQYzyAcbRWZQ5z82igXKa837jFYFljHIAs1TZv+O7L8kXa8UCzBUmMOmaQ7c5EqOXhxPzwY7WUGRSH/WkmaK+1OhzkV9/qmAVB4A1bDoWRqILMnH3sN30df5EbvsvWjGFplb7VKIubize8y9y/zCVaYSs1cYaLgtuEZSWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465682; c=relaxed/simple;
	bh=23Tii1+UdwXS/AT3hlItIU/kBlSEGIOD+vp0q4cAvig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saDJJ9B6j0HAb/m6w7oMQD0eU1dBEet31xaUudaymcntu6w8oaC8N3EQHows4b2u5dmG33BcsOo+V0nQSEm3dszMTlLr7Yyx157LVNbbROAuTrgacfqS/77Fzx/EqRiSdqZdaRJ+vHsErmIUupAZJJ7ysjkQpsB5ZjCRk4TVY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqS9DTew; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707465680; x=1739001680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=23Tii1+UdwXS/AT3hlItIU/kBlSEGIOD+vp0q4cAvig=;
  b=GqS9DTewfBVyKbBDvQlt8ngWcDrxJ5QeQpjRkIArC1TelIikxmaATwJ9
   +tKF5mf8wcwYjNDU76TxoRcLk0dtQGzzqsD51oYK4f2GmDsu1kcdnqmCB
   F2OvxoemUrHTil4w7O8Rrm6ar7FyJk6iVPh69O7XjSzfObZBMkdzxCWCn
   8rbwe+LaF0Tzr2qrDNPv8hSSHsFEyvkfm9ZrzSbQEHSQKia/v9s/Q0MfU
   9nyLFcRXXd6d/YkTpKacTwyEckawEgPpvHE44q7SdjTh0wTZaXr9f22nF
   karmwPIkmILnNf5xlyPOuDJMybAImFfTOpu9yIc6w+T2gKwRpq4o7NuSq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="12752922"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="12752922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 00:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934364200"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="934364200"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 00:01:17 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYLox-0004Vi-02;
	Fri, 09 Feb 2024 08:01:15 +0000
Date: Fri, 9 Feb 2024 16:01:12 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] ipmr: use exit_batch_rtnl method
Message-ID: <202402091528.IEa4ESwN-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240209/202402091528.IEa4ESwN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240209/202402091528.IEa4ESwN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402091528.IEa4ESwN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/ipmr.c:3134:23: error: initialization of 'void (*)(struct list_head *)' from incompatible pointer type 'void (*)(struct list_head *, struct list_head *)' [-Werror=incompatible-pointer-types]
    3134 |         .exit_batch = ipmr_exit_batch_rtnl,
         |                       ^~~~~~~~~~~~~~~~~~~~
   net/ipv4/ipmr.c:3134:23: note: (near initialization for 'ipmr_net_ops.exit_batch')
   cc1: some warnings being treated as errors


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

