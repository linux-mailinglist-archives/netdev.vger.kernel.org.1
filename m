Return-Path: <netdev+bounces-115331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D53E945E39
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BBB2812A5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179391DF66E;
	Fri,  2 Aug 2024 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkziYnTN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177714A0A0
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603640; cv=none; b=lT+Sn5B9duxB+yNCXiX0cPvWblpb8dQ7lRmFmv4s50MneUNw1kEBChG82zFqDi422eU0HPDULQvNKw7GQ633QObHGW2nsTEMds3aVIhV4T/AYUuCVRnQjldnxf/MMNSvGCeuyDo5Y5OD15DCftY3GLBR+ORjny4rmSKkVeVl03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603640; c=relaxed/simple;
	bh=aXtfREe21moAnsrbgFYQDqy98u7LtWvsIWud379cgK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAG+jkt5Ye0zkJfcFu2yqW2Q5n3l/cRQmbx0a4TkFjEEPdfEltDH2XkxAl0PUjVF9of89C3lIYrc1k748MHob3tGIVgwjdNfvFkA2PhNOFimkf3iYh8Xst3EyMtMTQEFTe3TJfpF328EPTMj1trMnclM4bDoze87f4ttSQFvJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkziYnTN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722603638; x=1754139638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXtfREe21moAnsrbgFYQDqy98u7LtWvsIWud379cgK8=;
  b=KkziYnTNB6hYLUVb75wz9A+1mIZvvUQCYVDW0U7Ht9qRPxGByqqJs4/j
   qNtd0yakY7eNL2p11tcFaUttk/iO7szdibis3D9qW0Eg1C+qqD8JAscv4
   Rql0ui7tXDWq9FR4nIZqwYk98IvlVk4sTYstCh1ZMNfbQaZovAodPo530
   N7rBsfzNnlEFXfUO/2UaQg2h+6dwsV6HM/pa6Yh5Dlk66YTjy7vslkCNo
   3902vLUJSRwFvTSRCQGhIR+NHOP63E8Xf6sb9nRxiLkMlUtq8rQPscSym
   cZ6NfE9I5fWiC0Ol3JtSW08ieTT0f13MjbstVkjIIkEGwdZXP36C3ng8c
   A==;
X-CSE-ConnectionGUID: rIgD25yuRpeIFnAhdOSvyA==
X-CSE-MsgGUID: 5PsM6T7LTeaAIMg9VC0YyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="43134628"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="43134628"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 06:00:37 -0700
X-CSE-ConnectionGUID: H+whR/nxRZ+e8SOQFSXqjA==
X-CSE-MsgGUID: 0ZpfasOsQbyl9wjXfKU7CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55027341"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Aug 2024 06:00:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZrtY-000wnD-1q;
	Fri, 02 Aug 2024 13:00:32 +0000
Date: Fri, 2 Aug 2024 21:00:24 +0800
From: kernel test robot <lkp@intel.com>
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, netdev@vger.kernel.org, felipe@sipanda.io
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH 06/12] flow_dissector: UDP encap infrastructure
Message-ID: <202408022046.h8kMQ01e-lkp@intel.com>
References: <20240731172332.683815-7-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731172332.683815-7-tom@herbertland.com>

Hi Tom,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.11-rc1 next-20240802]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Herbert/skbuff-Unconstantify-struct-net-argument-in-flowdis-functions/20240802-084418
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240731172332.683815-7-tom%40herbertland.com
patch subject: [PATCH 06/12] flow_dissector: UDP encap infrastructure
config: um-defconfig (https://download.01.org/0day-ci/archive/20240802/202408022046.h8kMQ01e-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 430b90f04533b099d788db2668176038be38c53b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240802/202408022046.h8kMQ01e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408022046.h8kMQ01e-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: .tmp_vmlinux1 has a LOAD segment with RWX permissions
   /usr/bin/ld: net/core/flow_dissector.o: in function `__skb_flow_dissect':
>> net/core/flow_dissector.c:874:(.ltext+0x1ff9): undefined reference to `__udp6_lib_lookup'
   clang: error: linker command failed with exit code 1 (use -v to see invocation)


vim +874 net/core/flow_dissector.c

   809	
   810	static enum flow_dissect_ret
   811	__skb_flow_dissect_udp(const struct sk_buff *skb, struct net *net,
   812			       struct flow_dissector *flow_dissector,
   813			       void *target_container, const void *data,
   814			       int *p_nhoff, int hlen, __be16 *p_proto,
   815			       u8 *p_ip_proto, int bpoff, unsigned int flags)
   816	{
   817		enum flow_dissect_ret ret;
   818		const struct udphdr *udph;
   819		struct udphdr _udph;
   820		struct sock *sk;
   821		__u8 encap_type;
   822		int nhoff;
   823	
   824		if (!(flags & FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS))
   825			return FLOW_DISSECT_RET_OUT_GOOD;
   826	
   827		switch (*p_proto) {
   828		case htons(ETH_P_IP): {
   829			const struct iphdr *iph;
   830			struct iphdr _iph;
   831	
   832			iph = __skb_header_pointer(skb, bpoff, sizeof(_iph), data,
   833						   hlen, &_iph);
   834			if (!iph)
   835				return FLOW_DISSECT_RET_OUT_BAD;
   836	
   837			udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
   838						    hlen, &_udph);
   839			if (!udph)
   840				return FLOW_DISSECT_RET_OUT_BAD;
   841	
   842			rcu_read_lock();
   843			/* Look up the UDPv4 socket and get the encap_type */
   844			sk = __udp4_lib_lookup(net, iph->saddr, udph->source,
   845					       iph->daddr, udph->dest,
   846					       inet_iif(skb), inet_sdif(skb),
   847					       net->ipv4.udp_table, NULL);
   848			if (!sk || !udp_sk(sk)->encap_type) {
   849				rcu_read_unlock();
   850				return FLOW_DISSECT_RET_OUT_GOOD;
   851			}
   852	
   853			encap_type = udp_sk(sk)->encap_type;
   854			rcu_read_unlock();
   855	
   856			break;
   857		}
   858		case htons(ETH_P_IPV6): {
   859			const struct ipv6hdr *iph;
   860			struct ipv6hdr _iph;
   861	
   862			iph = __skb_header_pointer(skb, bpoff, sizeof(_iph), data,
   863						   hlen, &_iph);
   864			if (!iph)
   865				return FLOW_DISSECT_RET_OUT_BAD;
   866	
   867			udph = __skb_header_pointer(skb, *p_nhoff, sizeof(_udph), data,
   868						    hlen, &_udph);
   869			if (!udph)
   870				return FLOW_DISSECT_RET_OUT_BAD;
   871	
   872			rcu_read_lock();
   873			/* Look up the UDPv6 socket and get the encap_type */
 > 874			sk = __udp6_lib_lookup(net, &iph->saddr, udph->source,
   875					       &iph->daddr, udph->dest,
   876					       inet_iif(skb), inet_sdif(skb),
   877					       net->ipv4.udp_table, NULL);
   878			if (!sk || !udp_sk(sk)->encap_type) {
   879				rcu_read_unlock();
   880				return FLOW_DISSECT_RET_OUT_GOOD;
   881			}
   882	
   883			encap_type = udp_sk(sk)->encap_type;
   884			rcu_read_unlock();
   885	
   886			break;
   887		}
   888		default:
   889			return FLOW_DISSECT_RET_OUT_GOOD;
   890		}
   891	
   892		nhoff = *p_nhoff + sizeof(struct udphdr);
   893		ret = FLOW_DISSECT_RET_OUT_GOOD;
   894	
   895		switch (encap_type) {
   896		default:
   897			break;
   898		}
   899	
   900		switch (ret) {
   901		case FLOW_DISSECT_RET_PROTO_AGAIN:
   902			*p_ip_proto = 0;
   903			fallthrough;
   904		case FLOW_DISSECT_RET_IPPROTO_AGAIN:
   905			*p_nhoff = nhoff;
   906			break;
   907		default:
   908			break;
   909		}
   910	
   911		return ret;
   912	}
   913	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

