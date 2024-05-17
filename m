Return-Path: <netdev+bounces-97040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CFE8C8DD1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 23:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1831A285D51
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DC140395;
	Fri, 17 May 2024 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5vEFyTp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C839FFD;
	Fri, 17 May 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981990; cv=none; b=rHrh88Q4EE9V3KRZEaOmj7EV9BtdKoQDdfdFuZ7irzR3ph/RNHuNWYe1lzHxWDeM0qaVLaQ5Np+K72j6bkWJzsnzqMIVe8ruFE9qISD3DVFhgkxWykVbx0dwrXlReG9A2UJa/jPloZKJyO5ePoad4AnKtOUDwnzrDVUpYPLHTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981990; c=relaxed/simple;
	bh=2SS4RimWdSKvDc8cYyQUQTKo0de1Bc26jlHfZplTVjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYfSdVx/LjYw6eoxHgx4hBu7GkfhBOHwi5TCOQyw1dW+diEX749xeuOJ1+NzlN3WvpTHZxFjrXz+eDvO1MOHU3tgt/IARFuJQFhyEUP/uEIzKUKb79wMQiBk7t1rw+yaOZ+dctH/M6kXGYgFf3n93j6utxNIF+y/HwtCv9gElec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5vEFyTp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715981987; x=1747517987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SS4RimWdSKvDc8cYyQUQTKo0de1Bc26jlHfZplTVjE=;
  b=J5vEFyTpnVvnOKkJSStUGWO9PBRkSwaPrvmipmVn0vBrOKBGuZV098+k
   u5ns1CJ+uUeK31K9Wyw+drtCwu+E9aM0xCztDcnllKt820oX2CE+7DnvV
   5uhD3w7uJ3L4Bfks5xa8TQBI//fbze4E0ZEyxKl8RTg28XhKDaRH5JqKj
   rklNwTKbNfbnGORcg0DuoB/uOUWWn51m/9qKmq9q2P0ItNQRamigw7x8j
   Om9T+NkTIRmG1wW/NotRv1YkwX3UhSyoSlEZRatY1DJvOOzFLVwthlVsA
   yKFlMeQINo/rgX3faEzXEdXPmSe4LdCVYc8ErUYYJSZcxkM7MMf5DctLT
   g==;
X-CSE-ConnectionGUID: KlXoS4UxRPm+TIRTqelx9w==
X-CSE-MsgGUID: AYwRRiQETJ2Br4KIYUvTGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12356749"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="12356749"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 14:39:46 -0700
X-CSE-ConnectionGUID: gkIVbgFKR4KZwf7oGFI1XQ==
X-CSE-MsgGUID: zsKfyn7DTkeY+sy0JqMShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="36827114"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 17 May 2024 14:39:41 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s85Fv-00019g-0g;
	Fri, 17 May 2024 21:37:44 +0000
Date: Sat, 18 May 2024 05:34:18 +0800
From: kernel test robot <lkp@intel.com>
To: ye.xingchen@zte.com.cn, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, dsahern@kernel.org, ncardwell@google.com,
	soheil@google.com, mfreemon@cloudflare.com, lixiaoyan@google.com,
	david.laight@aculab.com, haiyangz@microsoft.com,
	ye.xingchen@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	xu.xin16@zte.com.cn, zhang.yunkai@zte.com.cn, fan.yu9@zte.com.cn
Subject: Re: [PATCH net-next] icmp: Add icmp_timestamp_ignore_all to control
 ICMP_TIMESTAMP
Message-ID: <202405180545.RQgwvazz-lkp@intel.com>
References: <20240517172639229ec5bN7VBV7SGEHkSK5K6f@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517172639229ec5bN7VBV7SGEHkSK5K6f@zte.com.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/icmp-Add-icmp_timestamp_ignore_all-to-control-ICMP_TIMESTAMP/20240517-172903
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240517172639229ec5bN7VBV7SGEHkSK5K6f%40zte.com.cn
patch subject: [PATCH net-next] icmp: Add icmp_timestamp_ignore_all to control ICMP_TIMESTAMP
config: arm-clps711x_defconfig (https://download.01.org/0day-ci/archive/20240518/202405180545.RQgwvazz-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fa9b1be45088dce1e4b602d451f118128b94237b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405180545.RQgwvazz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405180545.RQgwvazz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/icmp.c:69:
   In file included from include/linux/inet.h:42:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/ipv4/icmp.c:1157:16: warning: variable 'net' is uninitialized when used here [-Wuninitialized]
    1157 |         if (READ_ONCE(net->ipv4.sysctl_icmp_timestamp_ignore_all))
         |                       ^~~
   include/asm-generic/rwonce.h:50:14: note: expanded from macro 'READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |                     ^
   include/asm-generic/rwonce.h:44:72: note: expanded from macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   net/ipv4/icmp.c:1155:17: note: initialize the variable 'net' to silence this warning
    1155 |         struct net *net;
         |                        ^
         |                         = NULL
   2 warnings generated.


vim +/net +1157 net/ipv4/icmp.c

  1144	
  1145	/*
  1146	 *	Handle ICMP Timestamp requests.
  1147	 *	RFC 1122: 3.2.2.8 MAY implement ICMP timestamp requests.
  1148	 *		  SHOULD be in the kernel for minimum random latency.
  1149	 *		  MUST be accurate to a few minutes.
  1150	 *		  MUST be updated at least at 15Hz.
  1151	 */
  1152	static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
  1153	{
  1154		struct icmp_bxm icmp_param;
  1155		struct net *net;
  1156	
> 1157		if (READ_ONCE(net->ipv4.sysctl_icmp_timestamp_ignore_all))
  1158			return SKB_NOT_DROPPED_YET;
  1159	
  1160		/*
  1161		 *	Too short.
  1162		 */
  1163		if (skb->len < 4)
  1164			goto out_err;
  1165	
  1166		/*
  1167		 *	Fill in the current time as ms since midnight UT:
  1168		 */
  1169		icmp_param.data.times[1] = inet_current_timestamp();
  1170		icmp_param.data.times[2] = icmp_param.data.times[1];
  1171	
  1172		BUG_ON(skb_copy_bits(skb, 0, &icmp_param.data.times[0], 4));
  1173	
  1174		icmp_param.data.icmph	   = *icmp_hdr(skb);
  1175		icmp_param.data.icmph.type = ICMP_TIMESTAMPREPLY;
  1176		icmp_param.data.icmph.code = 0;
  1177		icmp_param.skb		   = skb;
  1178		icmp_param.offset	   = 0;
  1179		icmp_param.data_len	   = 0;
  1180		icmp_param.head_len	   = sizeof(struct icmphdr) + 12;
  1181		icmp_reply(&icmp_param, skb);
  1182		return SKB_NOT_DROPPED_YET;
  1183	
  1184	out_err:
  1185		__ICMP_INC_STATS(dev_net(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
  1186		return SKB_DROP_REASON_PKT_TOO_SMALL;
  1187	}
  1188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

