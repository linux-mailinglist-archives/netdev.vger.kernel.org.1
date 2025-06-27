Return-Path: <netdev+bounces-201897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63BAEB621
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52AE1644A1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196FD29552F;
	Fri, 27 Jun 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kquQzk6P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91A32951CE
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023257; cv=none; b=IYJPzpR21uBvsBDzVJfo/yU7iLtWjaFaP1KnFv/qYdAJOeby4lpoZHCD3uBAIk+SRsH3FmXMHp1blqksMM6GijSXavwFo/ABVhi4bpW6VIVAPAorYwGQZgOQWlbNVa5Dtg/W92AWEwwBFH/wBKqcpwbMx25NVnvzbr16M2yMs7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023257; c=relaxed/simple;
	bh=dXWnn7LRNgYSd9Ptz+gNhbI4WjCi1nbyBt9UJ7BlkwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnojh60LWrG3TXubW/d8md9slagSatH87DWcSHQ+g4stwkkcNJteuKWjjd/NUBaIjXPm6gtxdQsSsnCmyoyrsq8BWK1xhTuS0zGfuNpR/4PZN+xmhzuIbY8JOW0UhZtkpjD15snV+dUAMNzwc470B+Db4aMXwGO+zaVqx67WvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kquQzk6P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751023255; x=1782559255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dXWnn7LRNgYSd9Ptz+gNhbI4WjCi1nbyBt9UJ7BlkwU=;
  b=kquQzk6P2QeYO+bo74HGfRsuftKpmyf2Rv9+raAIBZhfPddtOjp2iiAp
   GEzIyGSgJazVATouRFl0WyQv5/sSof5l5vVubhSg74NsORXeYJvvLOS7g
   QhHkqhi96q9d5Phg5tFHiJmHyaI7X40KXZxJAyw5VrGGjGJBoI19Friu2
   hiccANoxxn8SeoH/VqCPswQoesbxDsI7edzCFFPn38Vc5zG5MNAzyMto1
   f8BBcDOH8QTzs89L/wr/oM037JSqNNrtILniU2gYYVwfs75/bj4tuXe8P
   HMXwEKS+x7/IZntPgF0L276fzv42q8RZieOOjcmv4sk0PA091btspf82z
   Q==;
X-CSE-ConnectionGUID: QlcP5xX0Toiy/F46lklb8Q==
X-CSE-MsgGUID: 7CZLgIzmTPWxEK/TcS2Jdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="75882161"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="75882161"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 04:20:54 -0700
X-CSE-ConnectionGUID: 0Nz8ah7ISTyS7vNpCwvXbA==
X-CSE-MsgGUID: 9VBG8FSUQC+SiDZzYKakRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152523373"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 27 Jun 2025 04:20:51 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uV78T-000W7S-0z;
	Fri, 27 Jun 2025 11:20:49 +0000
Date: Fri, 27 Jun 2025 19:19:59 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next 1/2] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
Message-ID: <202506271810.8Sd035zs-lkp@intel.com>
References: <20250626120247.1255223-1-jakub@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626120247.1255223-1-jakub@cloudflare.com>

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/selftests-net-Cover-port-sharing-scenarios-with-IP_LOCAL_PORT_RANGE/20250626-200955
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250626120247.1255223-1-jakub%40cloudflare.com
patch subject: [PATCH net-next 1/2] tcp: Consider every port when connecting with IP_LOCAL_PORT_RANGE
config: sparc64-randconfig-r123-20250627 (https://download.01.org/0day-ci/archive/20250627/202506271810.8Sd035zs-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250627/202506271810.8Sd035zs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506271810.8Sd035zs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/inet_hashtables.c:1036:26: sparse: sparse: restricted __be32 degrades to integer

vim +1036 net/ipv4/inet_hashtables.c

  1007	
  1008	/* True on source address conflict with another socket. False otherwise.
  1009	 * Caller must hold hashbucket lock for this tb.
  1010	 */
  1011	static inline bool check_bound(const struct sock *sk,
  1012				       const struct inet_bind_bucket *tb)
  1013	{
  1014		const struct inet_bind2_bucket *tb2;
  1015		const struct sock *sk2;
  1016	
  1017		hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
  1018	#if IS_ENABLED(CONFIG_IPV6)
  1019			if (sk->sk_family == AF_INET6) {
  1020				if (tb2->addr_type == IPV6_ADDR_ANY ||
  1021				    ipv6_addr_equal(&tb2->v6_rcv_saddr,
  1022						    &sk->sk_v6_rcv_saddr))
  1023					return true;
  1024				continue;
  1025			}
  1026	
  1027			/* Check for ipv6 non-v6only wildcard sockets */
  1028			if (tb2->addr_type == IPV6_ADDR_ANY)
  1029				sk_for_each_bound(sk2, &tb2->owners)
  1030					if (!sk2->sk_ipv6only)
  1031						return true;
  1032	
  1033			if (tb2->addr_type != IPV6_ADDR_MAPPED)
  1034				continue;
  1035	#endif
> 1036			if (tb2->rcv_saddr == INADDR_ANY ||
  1037			    tb2->rcv_saddr == sk->sk_rcv_saddr)
  1038				return true;
  1039		}
  1040	
  1041		return false;
  1042	}
  1043	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

