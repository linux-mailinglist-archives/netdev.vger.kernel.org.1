Return-Path: <netdev+bounces-70613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101A84FCAB
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF619281FC0
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186DF81ACB;
	Fri,  9 Feb 2024 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2+vLWT9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3063F80BF2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506023; cv=none; b=o43ZnyXVoMPpueJlBf3NdFoo9vQLBmxn6RA50KWQ0YIrf8Zpv1mfztR46vZ8u4N1DnsrOer2jAMV0XfgbfBNRaGPkQPpiD4swIP/+vqJPrza8It06AwC8Rec79q5jGZOW27JVORL/0nwXoSNVStwM/gQyh16ZTRlRX63vAgkoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506023; c=relaxed/simple;
	bh=eHB7QBHh+T6Lh5L2BVMMrcndgbG5XA/FWMWUmQnur7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNKaQLXQTFIabdNlHcmAIPIfVuFkhfSQcHCvr33c9bI7tVmIFEzs817vAVzxjYRxr+SBOz15MTKZFHgc5jdL1i1/giZUKQoHWkDFwbWZ3jOEOeoivTYiAUKpqwupmX+VvsubkUbIprfDwaHpYVud0c9obbspmkuuOrG8LG2CCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2+vLWT9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707506021; x=1739042021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eHB7QBHh+T6Lh5L2BVMMrcndgbG5XA/FWMWUmQnur7o=;
  b=d2+vLWT9muZabGjN+JTH/3ydRPWWmIEc+ZB4hcAsqoIfFyS2WnboT+ni
   38YFppcXVquN0Eyh7d7GHASEab4MOSluPDEB+7VsI5pKsfQD9BHvxWGX2
   osG245IkZXCQFYfvIH/gg6hc/H+4hbJb11wfIYwLHKepRDc5cLk0fMkuy
   TjOIAggYIUvw3BOyt2llgw2fLhqFOyH+OpurClOArviOgn7cTkG+tpzXG
   xfqlPw5loSa6g+GOPKjaMir24LfO8VKw3XpK0Rv/N7AbQQgrcvn5ndNc4
   8lB9lWZkjipRA64WyqdWvnSpt7U8zWdi2BEefTqWZxMFRKe2DgbAvNmUy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5279936"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5279936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2223415"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2024 11:13:38 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYWJc-00052w-1N;
	Fri, 09 Feb 2024 19:13:36 +0000
Date: Sat, 10 Feb 2024 03:13:31 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 10/13] net: add netdev_set_operstate() helper
Message-ID: <202402100218.Gmr6NGqc-lkp@intel.com>
References: <20240208141154.1131622-11-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208141154.1131622-11-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-annotate-data-races-around-dev-name_assign_type/20240208-222037
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240208141154.1131622-11-edumazet%40google.com
patch subject: [PATCH v2 net-next 10/13] net: add netdev_set_operstate() helper
config: sh-sh2007_defconfig (https://download.01.org/0day-ci/archive/20240210/202402100218.Gmr6NGqc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402100218.Gmr6NGqc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402100218.Gmr6NGqc-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: net/core/rtnetlink.o: in function `set_operstate':
>> net/core/rtnetlink.c:873:(.text+0x1140): undefined reference to `__cmpxchg_called_with_bad_pointer'
   sh4-linux-ld: net/core/rtnetlink.o: in function `netdev_set_operstate':
   net/core/rtnetlink.c:855:(.text+0x16d0): undefined reference to `__cmpxchg_called_with_bad_pointer'


vim +873 net/core/rtnetlink.c

93582d8ffc1ff5 Eric Dumazet      2024-02-08  857  
93b2d4a208eeb1 David S. Miller   2008-02-17  858  static void set_operstate(struct net_device *dev, unsigned char transition)
b00055aacdb172 Stefan Rompf      2006-03-20  859  {
93582d8ffc1ff5 Eric Dumazet      2024-02-08  860  	unsigned char operstate = READ_ONCE(dev->operstate);
b00055aacdb172 Stefan Rompf      2006-03-20  861  
b00055aacdb172 Stefan Rompf      2006-03-20  862  	switch (transition) {
b00055aacdb172 Stefan Rompf      2006-03-20  863  	case IF_OPER_UP:
b00055aacdb172 Stefan Rompf      2006-03-20  864  		if ((operstate == IF_OPER_DORMANT ||
eec517cdb4810b Andrew Lunn       2020-04-20  865  		     operstate == IF_OPER_TESTING ||
b00055aacdb172 Stefan Rompf      2006-03-20  866  		     operstate == IF_OPER_UNKNOWN) &&
eec517cdb4810b Andrew Lunn       2020-04-20  867  		    !netif_dormant(dev) && !netif_testing(dev))
b00055aacdb172 Stefan Rompf      2006-03-20  868  			operstate = IF_OPER_UP;
b00055aacdb172 Stefan Rompf      2006-03-20  869  		break;
b00055aacdb172 Stefan Rompf      2006-03-20  870  
eec517cdb4810b Andrew Lunn       2020-04-20  871  	case IF_OPER_TESTING:
abbc79280abc5e Juhee Kang        2022-08-31  872  		if (netif_oper_up(dev))
eec517cdb4810b Andrew Lunn       2020-04-20 @873  			operstate = IF_OPER_TESTING;
eec517cdb4810b Andrew Lunn       2020-04-20  874  		break;
eec517cdb4810b Andrew Lunn       2020-04-20  875  
b00055aacdb172 Stefan Rompf      2006-03-20  876  	case IF_OPER_DORMANT:
abbc79280abc5e Juhee Kang        2022-08-31  877  		if (netif_oper_up(dev))
b00055aacdb172 Stefan Rompf      2006-03-20  878  			operstate = IF_OPER_DORMANT;
b00055aacdb172 Stefan Rompf      2006-03-20  879  		break;
3ff50b7997fe06 Stephen Hemminger 2007-04-20  880  	}
b00055aacdb172 Stefan Rompf      2006-03-20  881  
93582d8ffc1ff5 Eric Dumazet      2024-02-08  882  	netdev_set_operstate(dev, operstate);
b00055aacdb172 Stefan Rompf      2006-03-20  883  }
b00055aacdb172 Stefan Rompf      2006-03-20  884  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

