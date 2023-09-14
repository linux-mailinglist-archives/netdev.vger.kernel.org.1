Return-Path: <netdev+bounces-33770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD87A0032
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A6128215E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE42AB43;
	Thu, 14 Sep 2023 09:35:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763682770C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:35:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52D1FC8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694684116; x=1726220116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9DywaM42znADHrWCrVr5tRHSVFmTEcEuvHEVIsSSDB4=;
  b=iWfRd/EISQJE9Xgv6RTi8ERgNHtUsTPdoNi8XGvZ9BZaINlA0PzgUBbn
   1G33huFxSDU0Y0WCcNm7e1xKu+eU5R8JsHki8kvzBbga7gTF3QM5WxMN7
   RWmATEWMv3hiOBPfVKV4eaqkZmJomRYaB3KfHBXwjA+3oRE0pHpZpd3qy
   M+dUjSpo9BJIa0O9TA9vdHq8wlByr+BeSQGkwXsgWweZcvnZxMhSNZl4F
   OYDtGVMjWeNsq4COcMGJX+aTkTb1hUXT/FUBnb8bI9ZCEp18BX5JOh9yP
   Ahkgzr+7aIupU+9amhBIWe5QEgv0zt1og8dfajx6wydYuuWXq3LFQ9EFm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="465274618"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="465274618"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 02:35:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859626041"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="859626041"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2023 02:35:06 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgika-0001RT-1O;
	Thu, 14 Sep 2023 09:35:04 +0000
Date: Thu, 14 Sep 2023 17:34:28 +0800
From: kernel test robot <lkp@intel.com>
To: Heng Guo <heng.guo@windriver.com>, davem@davemloft.net,
	sahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	filip.pudak@windriver.com, heng.guo@windriver.com
Subject: Re: [PATCH 1/1] net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS
 increment after fragment check
Message-ID: <202309141701.7OFxGdE5-lkp@intel.com>
References: <20230914051623.2180843-2-heng.guo@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914051623.2180843-2-heng.guo@windriver.com>

Hi Heng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.6-rc1 next-20230914]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Guo/net-ipv4-ipv6-fix-IPSTATS_MIB_OUTFORWDATAGRAMS-increment-after-fragment-check/20230914-131757
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230914051623.2180843-2-heng.guo%40windriver.com
patch subject: [PATCH 1/1] net: ipv4,ipv6: fix IPSTATS_MIB_OUTFORWDATAGRAMS increment after fragment check
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230914/202309141701.7OFxGdE5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141701.7OFxGdE5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141701.7OFxGdE5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ipv6/ip6_output.c: In function 'ip6_forward_finish':
>> net/ipv6/ip6_output.c:451:27: warning: unused variable 'dst' [-Wunused-variable]
     451 |         struct dst_entry *dst = skb_dst(skb);
         |                           ^~~


vim +/dst +451 net/ipv6/ip6_output.c

e21e0b5f19ac78 Ville Nuorvala    2006-09-22  447  
0c4b51f0054ce8 Eric W. Biederman 2015-09-15  448  static inline int ip6_forward_finish(struct net *net, struct sock *sk,
0c4b51f0054ce8 Eric W. Biederman 2015-09-15  449  				     struct sk_buff *skb)
^1da177e4c3f41 Linus Torvalds    2005-04-16  450  {
71a1c915238c97 Jeff Barnhill     2018-04-05 @451  	struct dst_entry *dst = skb_dst(skb);
71a1c915238c97 Jeff Barnhill     2018-04-05  452  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

