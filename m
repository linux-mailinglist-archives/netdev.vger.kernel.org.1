Return-Path: <netdev+bounces-209574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8ACB0FE3F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0685853BA
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 00:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8869528399;
	Thu, 24 Jul 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFH7yh+q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC547A48
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 00:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753318067; cv=none; b=k0F2WgmowGercsbozR42obNcSUpJebjPDTgQD7Jz7rRLSbtnQDlbu9UN9778323z3jKS3ZTqSnQwuCbChXB9kRY7p2xoWyuGAnvOT4RP5wHSJNLl5TEutJHm6NcM+3CKEka5xca3KxYwePZ6PnMhqwpI6R8bgblpuO2HZ6Pkygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753318067; c=relaxed/simple;
	bh=l0UelMx0CMrRwUKdz+mFZAYL+IfOIZdqgUko8x0m+xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM+sV2B5n2E/UdT/VqHg6I3qwAU10CUbm9owHC3N/Ze5yAJ1FAP4n/9TNiPykWQ6WYQMbqiPA8/mSSBQYPxtuY8SgczpxzemdX955XLMVuYL6KfkF/aLu/lcezdx/n0VgVhBzn3FUbfsK0hhejfTP9wMQgW/zj4xk+j+ZVQ1EdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFH7yh+q; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753318066; x=1784854066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0UelMx0CMrRwUKdz+mFZAYL+IfOIZdqgUko8x0m+xs=;
  b=YFH7yh+q6/DwIqUokDQHhEa917HYvZJCMTa3Of/A2PKOPqe106csCMxP
   btGUHvPuD+LM5JVC+ojlgrv9+nsALFpQVKs7qXvToJ75oDsefkWnNsRKx
   I4p2BiomWyOlaj37hznujGzDKG7TofOSZ9CcXI6aNw4UymC+D/jxZGwMV
   6Vlmq6ia1Temp7GA8O5uYM4EFAavy0B1EMPJeqLuXYrlm8mGzCfZipXAA
   xfi130MyBGYcIf8sTQ4oBAriDfr5+DVPcaSbxEq2G2XSP7GSHFvfkFODM
   fd7ADl7bBW5gr5uzW6UwZtbN1maX9e3PZFJNIgSd/V3JbO3WDeJr1il4/
   g==;
X-CSE-ConnectionGUID: 2Bi7qqx6SwKdNTeyR+9yZA==
X-CSE-MsgGUID: FcADz4v5TlGG1N1qxzBmjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55321379"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="55321379"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 17:47:46 -0700
X-CSE-ConnectionGUID: y6gG0ZAiS06n50mi7Q/rZg==
X-CSE-MsgGUID: TKKPgtSZQjuVqk7kSXW9sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="164136577"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Jul 2025 17:47:43 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uek7Y-000Jxb-2l;
	Thu, 24 Jul 2025 00:47:40 +0000
Date: Thu, 24 Jul 2025 08:46:54 +0800
From: kernel test robot <lkp@intel.com>
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, quic_kapandey@quicinc.com,
	quic_subashab@quicinc.com
Subject: Re: [PATCH] net: Add locking to protect skb->dev access in ip_output
Message-ID: <202507240835.DPHAwhlJ-lkp@intel.com>
References: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>

Hi Sharath,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on next-20250723]
[cannot apply to net/main linus/master horms-ipvs/master v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sharath-Chandra-Vurukala/net-Add-locking-to-protect-skb-dev-access-in-ip_output/20250723-162406
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250723082201.GA14090%40hu-sharathv-hyd.qualcomm.com
patch subject: [PATCH] net: Add locking to protect skb->dev access in ip_output
config: i386-randconfig-003-20250724 (https://download.01.org/0day-ci/archive/20250724/202507240835.DPHAwhlJ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240835.DPHAwhlJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507240835.DPHAwhlJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/ip_output.c: In function 'ip_output':
>> net/ipv4/ip_output.c:438:9: error: 'ret_val' undeclared (first use in this function); did you mean 'pte_val'?
     438 |         ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
         |         ^~~~~~~
         |         pte_val
   net/ipv4/ip_output.c:438:9: note: each undeclared identifier is reported only once for each function it appears in
   net/ipv4/ip_output.c:444:1: warning: control reaches end of non-void function [-Wreturn-type]
     444 | }
         | ^


vim +438 net/ipv4/ip_output.c

   425	
   426	int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
   427	{
   428		struct net_device *dev, *indev = skb->dev;
   429	
   430		IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
   431	
   432		rcu_read_lock();
   433	
   434		dev = skb_dst(skb)->dev;
   435		skb->dev = dev;
   436		skb->protocol = htons(ETH_P_IP);
   437	
 > 438		ret_val = NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
   439				       net, sk, skb, indev, dev,
   440					ip_finish_output,
   441					!(IPCB(skb)->flags & IPSKB_REROUTED));
   442		rcu_read_unlock();
   443		return ret_val;
   444	}
   445	EXPORT_SYMBOL(ip_output);
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

