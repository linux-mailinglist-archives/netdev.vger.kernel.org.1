Return-Path: <netdev+bounces-139312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A8D9B16C6
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 12:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF481C20E2E
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 10:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6681CFEAE;
	Sat, 26 Oct 2024 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAsw+Fq+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C52BAEC;
	Sat, 26 Oct 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729936863; cv=none; b=Zl1cvjjKiTZ1B5f2AvJLxpfaWLkJb4qwTFKYtFFohl4hUWbxn3J4NAPNQ3oxmZogZIbaenj7GuqTzZnoO9si2VIechCUKC9LsERBTamXVf9GxtGQkk2avG1X5VgdC6aR1hvpt+zT0Jo9NnFHq14TRWPCr91y6HKcoDwSpsO2r8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729936863; c=relaxed/simple;
	bh=MBEUluzwNl+8pJbFyxJ5uvx7Dtm3uc4YLf+WUTqJ1Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMQX/jcJdpa+Id3VQI1R1nOTnHMOQJtIaeWJgwx0MH/znJr7a42aFOH3P8WsxDSfimeQ7eP92+GriJzxgIGT1fHPpyVauuhC8/LRwv93apfWUgvuLnH3OhIArsi6buJ2WyZxy0XYCFX4gX0033rlts1zP9Q4H0787F39/e+/tUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAsw+Fq+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729936859; x=1761472859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MBEUluzwNl+8pJbFyxJ5uvx7Dtm3uc4YLf+WUTqJ1Fw=;
  b=hAsw+Fq+BreraYOnQckkUCqUxwNcYBNvUZA6j8+BhAJ1DcN0YCtS/4zq
   oZassY4pvforlBWd9doUnKajok7ozUdNo7EEhRSLoFaEY0ONIo00077ko
   R4FKU/HR2tL4RWYcL75UOglNddiIHbNGo51fjJAtE8/gx6Slx17GBx57j
   SGUu49C1p+zh4NHid6ZnqO7YDJbPvRWzp5ZzCXGQtie1xUc7jmOE4Xi+7
   AVyOuXDSK72eEBiZnYCEJJUhQ5EQoWPpZGqQtc75X9iUMXbSN11aELDBH
   KafxvC7D9PRnUpr/FuFxjnqfnkuQpxoq0B2eojN/QQbqyoSG6TQUXbRtM
   w==;
X-CSE-ConnectionGUID: 1SIoqtJfS3i6zwUGVAF4/Q==
X-CSE-MsgGUID: AwmhOZ58SDukXpe7oW4KHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40703389"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40703389"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 03:00:59 -0700
X-CSE-ConnectionGUID: YdIs7TC+R7OJP5dJsfe0mw==
X-CSE-MsgGUID: hIe7ERXcQPCIWP/niYjG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="81314649"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Oct 2024 03:00:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4dbJ-000ZUc-2q;
	Sat, 26 Oct 2024 10:00:53 +0000
Date: Sat, 26 Oct 2024 18:00:12 +0800
From: kernel test robot <lkp@intel.com>
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, justin.iurman@uliege.be
Subject: Re: [PATCH net-next 2/3] net: ipv6: seg6_iptunnel: mitigate
 2-realloc issue
Message-ID: <202410261713.GIaQEsJC-lkp@intel.com>
References: <20241025133727.27742-3-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025133727.27742-3-justin.iurman@uliege.be>

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Iurman/net-ipv6-ioam6_iptunnel-mitigate-2-realloc-issue/20241025-214849
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241025133727.27742-3-justin.iurman%40uliege.be
patch subject: [PATCH net-next 2/3] net: ipv6: seg6_iptunnel: mitigate 2-realloc issue
config: i386-buildonly-randconfig-004-20241026 (https://download.01.org/0day-ci/archive/20241026/202410261713.GIaQEsJC-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410261713.GIaQEsJC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410261713.GIaQEsJC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/ipv6/seg6_iptunnel.c:10:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/ipv6/seg6_iptunnel.c:130:9: error: call to undeclared function '__seg6_do_srh_encap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     130 |         return __seg6_do_srh_encap(skb, osrh, proto, NULL);
         |                ^
   net/ipv6/seg6_iptunnel.c:130:9: note: did you mean 'seg6_do_srh_encap'?
   net/ipv6/seg6_iptunnel.c:128:5: note: 'seg6_do_srh_encap' declared here
     128 | int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
         |     ^
     129 | {
     130 |         return __seg6_do_srh_encap(skb, osrh, proto, NULL);
         |                ~~~~~~~~~~~~~~~~~~~
         |                seg6_do_srh_encap
>> net/ipv6/seg6_iptunnel.c:134:5: warning: no previous prototype for function '__seg6_do_srh_encap' [-Wmissing-prototypes]
     134 | int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
         |     ^
   net/ipv6/seg6_iptunnel.c:134:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     134 | int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
         | ^
         | static 
>> net/ipv6/seg6_iptunnel.c:330:9: error: call to undeclared function '__seg6_do_srh_inline'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     330 |         return __seg6_do_srh_inline(skb, osrh, NULL);
         |                ^
   net/ipv6/seg6_iptunnel.c:330:9: note: did you mean 'seg6_do_srh_inline'?
   net/ipv6/seg6_iptunnel.c:328:5: note: 'seg6_do_srh_inline' declared here
     328 | int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
         |     ^
     329 | {
     330 |         return __seg6_do_srh_inline(skb, osrh, NULL);
         |                ~~~~~~~~~~~~~~~~~~~~
         |                seg6_do_srh_inline
>> net/ipv6/seg6_iptunnel.c:334:5: warning: no previous prototype for function '__seg6_do_srh_inline' [-Wmissing-prototypes]
     334 | int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
         |     ^
   net/ipv6/seg6_iptunnel.c:334:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     334 | int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
         | ^
         | static 
   3 warnings and 2 errors generated.


vim +/__seg6_do_srh_encap +130 net/ipv6/seg6_iptunnel.c

   126	
   127	/* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
   128	int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
   129	{
 > 130		return __seg6_do_srh_encap(skb, osrh, proto, NULL);
   131	}
   132	EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
   133	
 > 134	int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
   135				int proto, struct dst_entry *dst)
   136	{
   137		struct net *net = dev_net(skb_dst(skb)->dev);
   138		struct ipv6hdr *hdr, *inner_hdr;
   139		struct ipv6_sr_hdr *isrh;
   140		int hdrlen, tot_len, err;
   141		__be32 flowlabel;
   142	
   143		hdrlen = (osrh->hdrlen + 1) << 3;
   144		tot_len = hdrlen + sizeof(*hdr);
   145	
   146		err = skb_cow_head(skb, tot_len + (!dst ? skb->mac_len
   147							: LL_RESERVED_SPACE(dst->dev)));
   148		if (unlikely(err))
   149			return err;
   150	
   151		inner_hdr = ipv6_hdr(skb);
   152		flowlabel = seg6_make_flowlabel(net, skb, inner_hdr);
   153	
   154		skb_push(skb, tot_len);
   155		skb_reset_network_header(skb);
   156		skb_mac_header_rebuild(skb);
   157		hdr = ipv6_hdr(skb);
   158	
   159		/* inherit tc, flowlabel and hlim
   160		 * hlim will be decremented in ip6_forward() afterwards and
   161		 * decapsulation will overwrite inner hlim with outer hlim
   162		 */
   163	
   164		if (skb->protocol == htons(ETH_P_IPV6)) {
   165			ip6_flow_hdr(hdr, ip6_tclass(ip6_flowinfo(inner_hdr)),
   166				     flowlabel);
   167			hdr->hop_limit = inner_hdr->hop_limit;
   168		} else {
   169			ip6_flow_hdr(hdr, 0, flowlabel);
   170			hdr->hop_limit = ip6_dst_hoplimit(skb_dst(skb));
   171	
   172			memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
   173	
   174			/* the control block has been erased, so we have to set the
   175			 * iif once again.
   176			 * We read the receiving interface index directly from the
   177			 * skb->skb_iif as it is done in the IPv4 receiving path (i.e.:
   178			 * ip_rcv_core(...)).
   179			 */
   180			IP6CB(skb)->iif = skb->skb_iif;
   181		}
   182	
   183		hdr->nexthdr = NEXTHDR_ROUTING;
   184	
   185		isrh = (void *)hdr + sizeof(*hdr);
   186		memcpy(isrh, osrh, hdrlen);
   187	
   188		isrh->nexthdr = proto;
   189	
   190		hdr->daddr = isrh->segments[isrh->first_segment];
   191		set_tun_src(net, skb_dst(skb)->dev, &hdr->daddr, &hdr->saddr);
   192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

