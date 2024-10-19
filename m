Return-Path: <netdev+bounces-137234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877029A50A7
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53446B20D84
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB018E762;
	Sat, 19 Oct 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpnV37I5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE03188CB5
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368303; cv=none; b=IdGNgO8WeVGJojNNZMDCo25hRa/w3a4OHzRye6EsaG7boE6v9P+WbhKdHBzX08q1wgEuSYAggFtxjO5e8nrOwcfTa57bEIPssgYOIjsYYwlgtc7lXAWfULZaUqxqP8c5m1KNmw4mFtA/OtTayoDDb5LRR8jhgmly7Dc7wFPktls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368303; c=relaxed/simple;
	bh=T3WsDaf2QEdCz/jajbkE257GkV0F5KRLyuAR4cih4oU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uld6Sm47c3uV4rlFYrUJYNndoHJAqg92k9r8zcixanWkMCQDeYxO4HqMnS5Y+wh/qQSx5SnmSMAoh+w/lmOJqhwILym9T/ndkA/+MCPDySFNgR6G1ONGNu2KVv5bJzpmHjG/643o6YpfN4FsultseSGChBHzr9KaPZYyEx+WJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpnV37I5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729368300; x=1760904300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3WsDaf2QEdCz/jajbkE257GkV0F5KRLyuAR4cih4oU=;
  b=fpnV37I5e2kuhi/tvTXROYL477vetI4VdkEyxHFw4agPpLqdDR/tdrhP
   V6Fy/vCIAbhZfa3KqwB4stjvooBJq8+HkookwsLHYHrXc493euluQZXVc
   ELklrrxlYaKt8BGF8hPeK+vL5w2Z3PxmPVnINj+rlprjWSVyeacDsbov6
   DPnTPO8juREbcyoDSQPpBRQ+4a7JhmWPpr8IJqgc4f0W5xEeVmBvnahV7
   omssn51568kVSE6JtsXmtuqSU1thGdb0/3Fc4Avt54hnuLhiDwtXcPUdm
   1xpG/VR2El2UPuGAKIxQol1iLvqu33lE3ZrazTeOqaQslflSpeINGZ7YB
   w==;
X-CSE-ConnectionGUID: +XWi462+Tyu0n4UOpbzlEQ==
X-CSE-MsgGUID: lMJXcbv+SwyqynXhfkSFPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="39473283"
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="39473283"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 13:04:59 -0700
X-CSE-ConnectionGUID: kVhvfALETiahPgp+nbEiLg==
X-CSE-MsgGUID: Xkv3Wa6ER4yiiL2UTnK4xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,217,1725346800"; 
   d="scan'208";a="83946868"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 19 Oct 2024 13:04:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2Fh1-000PUv-0g;
	Sat, 19 Oct 2024 20:04:55 +0000
Date: Sun, 20 Oct 2024 04:03:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 05/11] ipv4: Use per-netns RTNL helpers in
 inet_rtm_newaddr().
Message-ID: <202410200325.SaEJmyZS-lkp@intel.com>
References: <20241018012225.90409-6-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018012225.90409-6-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Define-RTNL_FLAG_DOIT_PERNET-for-per-netns-RTNL-doit/20241018-092802
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241018012225.90409-6-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 05/11] ipv4: Use per-netns RTNL helpers in inet_rtm_newaddr().
config: x86_64-randconfig-122-20241019 (https://download.01.org/0day-ci/archive/20241020/202410200325.SaEJmyZS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410200325.SaEJmyZS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410200325.SaEJmyZS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/devinet.c:941:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_list @@
   net/ipv4/devinet.c:941:9: sparse:     expected void *p
   net/ipv4/devinet.c:941:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_list
>> net/ipv4/devinet.c:941:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_ifaddr [noderef] __rcu *ifa_next @@
   net/ipv4/devinet.c:941:9: sparse:     expected void *p
   net/ipv4/devinet.c:941:9: sparse:     got struct in_ifaddr [noderef] __rcu *ifa_next
   net/ipv4/devinet.c: note: in included file:
>> include/linux/inetdevice.h:261:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *p @@     got struct in_device [noderef] __rcu *const ip_ptr @@
   include/linux/inetdevice.h:261:54: sparse:     expected void *p
   include/linux/inetdevice.h:261:54: sparse:     got struct in_device [noderef] __rcu *const ip_ptr
   net/ipv4/devinet.c: note: in included file (through include/linux/inetdevice.h):
>> include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *
>> include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *
>> include/linux/rtnetlink.h:147:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/linux/rtnetlink.h:147:16: sparse:    void [noderef] __rcu *
   include/linux/rtnetlink.h:147:16: sparse:    void *

vim +941 net/ipv4/devinet.c

   935	
   936	static struct in_ifaddr *find_matching_ifa(struct net *net, struct in_ifaddr *ifa)
   937	{
   938		struct in_device *in_dev = ifa->ifa_dev;
   939		struct in_ifaddr *ifa1;
   940	
 > 941		in_dev_for_each_ifa_rtnl_net(net, ifa1, in_dev) {
   942			if (ifa1->ifa_mask == ifa->ifa_mask &&
   943			    inet_ifa_match(ifa1->ifa_address, ifa) &&
   944			    ifa1->ifa_local == ifa->ifa_local)
   945				return ifa1;
   946		}
   947	
   948		return NULL;
   949	}
   950	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

