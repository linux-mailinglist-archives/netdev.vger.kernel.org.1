Return-Path: <netdev+bounces-191739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075FAABD01F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2FE7AB19C
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD825D8E3;
	Tue, 20 May 2025 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsa6z7D7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5925D52A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725305; cv=none; b=pDucT0li5DPF03boZIT2mPN2BvgyZNmmuacmEaAEkGHnCJJIRwwX1SUrCGp0KtXULLclxURyOh9vIXywzPMLpRxnq21ojAA36/KYOpuVcO7782dc7wrPY72d7mqAkvulk2v1RwhrAO8MwvLxqnMWM4++35RT4pVdoElQvQFXjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725305; c=relaxed/simple;
	bh=4NK1U/Nsr/bYoUJG4HPRwTvy4d3e3dS/pU6xOSYGo6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Haz9Ag6cqwZ13dV+0ir6ZOkC8ozIPKtuwMarUvBU95P21o0IhyisFyQC92gpTAZpvdfCgAWBh5WorWWnSR8TKQgWikNfCj/8naiNgLiGFUovGhKFV81vGRLq6ZjEcAziNbtrzgQmwrmVV9daTaOEIvWaSKh/aOy9MCWZlib5LKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsa6z7D7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747725304; x=1779261304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4NK1U/Nsr/bYoUJG4HPRwTvy4d3e3dS/pU6xOSYGo6A=;
  b=nsa6z7D7QNRP2F4ZYiYlS9KphemXEi9H03OPDU+hEeMozCluMwD+oVEQ
   TMzeUkkrKtaGFREeT6rEdkYsvF4Wn8D0Kpqdje6Vqm933rbLBLQUApUwP
   l9wv7VwfuQmDJ2QLLRSLEBMLsToK9Bxd7vMi8NNCDfBeiMdG586innNhP
   SM5ymb7Iev+tAXkHzBC6qQi5dnM7OXwzGkRe+gvHuLF9EhkDNEKGLAfnQ
   wnf0FOMYjvjFJ5hslO/joB42VFTw973tPzr3wm5aQiUt5NxFs7hbLzTDC
   f9KiOURdeGUtsgS5Nr3zfqrZO2FucNdEzPh7MMmx6GP0DUs/vgw8RjqV2
   g==;
X-CSE-ConnectionGUID: v2mmJm9PSpmxYU3opA4lFw==
X-CSE-MsgGUID: aDcZi6IUSvi7oU2Y4V3S8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="52277302"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="52277302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:15:03 -0700
X-CSE-ConnectionGUID: pyD17p8rTYWQbtrdjnDrsw==
X-CSE-MsgGUID: JQRbffE9Q4+4+N6rnYwxXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139507250"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 May 2025 00:15:02 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHHBj-000MGm-2G;
	Tue, 20 May 2025 07:14:59 +0000
Date: Tue, 20 May 2025 15:14:32 +0800
From: kernel test robot <lkp@intel.com>
To: Duan Jiong <djduanjiong@gmail.com>, ja@ssi.bg, pablo@netfilter.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Duan Jiong <djduanjiong@gmail.com>
Subject: Re: [PATCH] ipvs: skip ipvs snat processing when packet dst is not
 vip
Message-ID: <202505201507.zvDoaADX-lkp@intel.com>
References: <20250519103203.17255-1-djduanjiong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519103203.17255-1-djduanjiong@gmail.com>

Hi Duan,

kernel test robot noticed the following build errors:

[auto build test ERROR on netfilter-nf/main]
[also build test ERROR on horms-ipvs/master linus/master v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Duan-Jiong/ipvs-skip-ipvs-snat-processing-when-packet-dst-is-not-vip/20250519-183312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git main
patch link:    https://lore.kernel.org/r/20250519103203.17255-1-djduanjiong%40gmail.com
patch subject: [PATCH] ipvs: skip ipvs snat processing when packet dst is not vip
config: i386-randconfig-014-20250520 (https://download.01.org/0day-ci/archive/20250520/202505201507.zvDoaADX-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505201507.zvDoaADX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505201507.zvDoaADX-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/netfilter/ipvs/ip_vs_core.c: In function 'handle_response':
>> net/netfilter/ipvs/ip_vs_core.c:1263:32: error: storage size of 'ctinfo' isn't known
    1263 |         enum ip_conntrack_info ctinfo;
         |                                ^~~~~~
>> net/netfilter/ipvs/ip_vs_core.c:1264:30: error: implicit declaration of function 'nf_ct_get' [-Werror=implicit-function-declaration]
    1264 |         struct nf_conn *ct = nf_ct_get(skb, &ctinfo);
         |                              ^~~~~~~~~
>> net/netfilter/ipvs/ip_vs_core.c:1278:24: error: invalid use of undefined type 'struct nf_conn'
    1278 |                     &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.u3,
         |                        ^~
>> net/netfilter/ipvs/ip_vs_core.c:1278:36: error: 'IP_CT_DIR_ORIGINAL' undeclared (first use in this function)
    1278 |                     &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.u3,
         |                                    ^~~~~~~~~~~~~~~~~~
   net/netfilter/ipvs/ip_vs_core.c:1278:36: note: each undeclared identifier is reported only once for each function it appears in
>> net/netfilter/ipvs/ip_vs_core.c:1263:32: warning: unused variable 'ctinfo' [-Wunused-variable]
    1263 |         enum ip_conntrack_info ctinfo;
         |                                ^~~~~~
   net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_in_icmp':
   net/netfilter/ipvs/ip_vs_core.c:1602:15: warning: variable 'outer_proto' set but not used [-Wunused-but-set-variable]
    1602 |         char *outer_proto = "IPIP";
         |               ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +1263 net/netfilter/ipvs/ip_vs_core.c

  1254	
  1255	/* Handle response packets: rewrite addresses and send away...
  1256	 */
  1257	static unsigned int
  1258	handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
  1259			struct ip_vs_conn *cp, struct ip_vs_iphdr *iph,
  1260			unsigned int hooknum)
  1261	{
  1262		struct ip_vs_protocol *pp = pd->pp;
> 1263		enum ip_conntrack_info ctinfo;
> 1264		struct nf_conn *ct = nf_ct_get(skb, &ctinfo);
  1265	
  1266		if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ)
  1267			goto after_nat;
  1268	
  1269		IP_VS_DBG_PKT(11, af, pp, skb, iph->off, "Outgoing packet");
  1270	
  1271		if (skb_ensure_writable(skb, iph->len))
  1272			goto drop;
  1273	
  1274		/* mangle the packet */
  1275		if (ct != NULL &&
  1276		    hooknum == NF_INET_FORWARD &&
  1277		    !ip_vs_addr_equal(af,
> 1278			    &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.u3,
  1279			    &cp->vaddr))
  1280			return NF_ACCEPT;
  1281		if (pp->snat_handler &&
  1282		    !SNAT_CALL(pp->snat_handler, skb, pp, cp, iph))
  1283			goto drop;
  1284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

