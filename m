Return-Path: <netdev+bounces-274945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJXQD+5+z2mvwgYAu9opvQ
	(envelope-from <netdev+bounces-274945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:48:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 34046392507
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F28CD301E734
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5475272E7C;
	Fri,  3 Apr 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kka+7354"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0D285406
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206083; cv=none; b=oydtsFysCq3AQBAPzNNKEw4BnBtpM3mKdSpX590bpnklb0OOWKGrBUlXb+8gBfVn4NCVjbXTpfR2/zR1YGdhDpYBueGbWCSzL8SGhERV44jjfUgAZyVGMxqQE8ZNbwYJysuNCMcgpk8m+Qoatu5WmMBNE3n35ieXcxQS+nimtmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206083; c=relaxed/simple;
	bh=plRNuwU/KKf4UAbM/wt+uekBoRfThkWmizP/XyhYQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1q2JkdoGFLoYT//qNn47V2jVL83l0vRHK3F4+G16aeAgVMfFXwP9Ah+b8puame35LIJDKf0dr/rulc0kUtfBMw55oMO0kqcLXFeJyGwUic3fHC2UlYtDS1UwwUEutfk59j1u5cU7gwEM0gsdfc9eGOe32rMsg/adQFXrqeoA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kka+7354; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775206082; x=1806742082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=plRNuwU/KKf4UAbM/wt+uekBoRfThkWmizP/XyhYQqs=;
  b=kka+7354CykPZPTBj15qPd3LnXKmMpMbWPrbjM5cWuUYWVmAicoRKIPs
   wCy5l7HJXFFDXEhm04YUITPgWXmQBAYoaz1jyWXitkVDV2JEVRPSzGjvT
   NYD6vHgshfcPzf+1aJc/IJ+GFD92ESad+F1cFazrOq5Os+kC4z6aEygD7
   OApH0g78cpZ2rZhlhHnxizHUAXOK1hVTw1wILxAJd0bWDnzOMw4Ut+eZo
   7o0JajgJmac0i3pacP/SMnKODBv+ql4RFeiJF2Qp6FGswYeZ3YoH9DJ54
   sNg445qpcXlwvBu37AKwIOxnDWm7GzE49XvmFo0rBJ+E3mEQGCCPQ1vCt
   A==;
X-CSE-ConnectionGUID: tnNUkEGsQsGodTuePYs7Cw==
X-CSE-MsgGUID: oPVRYslZSLm0vyjM7DrTvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76239386"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="76239386"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 01:48:02 -0700
X-CSE-ConnectionGUID: aYnutFtgSwG9robKO913Ww==
X-CSE-MsgGUID: PhYAdxOkRZqoBgdwxpFU3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="222355505"
Received: from lkp-server01.sh.intel.com (HELO 064ad336901d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Apr 2026 01:48:00 -0700
Received: from kbuild by 064ad336901d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w8aC5-0000000017N-0OAP;
	Fri, 03 Apr 2026 08:47:57 +0000
Date: Fri, 3 Apr 2026 16:47:19 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH v3 net-next] net: advance skb_defer_disable_key check in
 napi_consume_skb
Message-ID: <202604031603.YyNxdorw-lkp@intel.com>
References: <20260401033211.44463-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401033211.44463-1-kerneljasonxing@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274945-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 34046392507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-advance-skb_defer_disable_key-check-in-napi_consume_skb/20260403-115110
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260401033211.44463-1-kerneljasonxing%40gmail.com
patch subject: [PATCH v3 net-next] net: advance skb_defer_disable_key check in napi_consume_skb
config: mips-cu1830-neo_defconfig (https://download.01.org/0day-ci/archive/20260403/202604031603.YyNxdorw-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604031603.YyNxdorw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604031603.YyNxdorw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/core/skbuff.c:37:
   net/core/skbuff.c: In function 'napi_consume_skb':
>> net/core/skbuff.c:1522:38: error: 'skb_defer_disable_key' undeclared (first use in this function)
    1522 |         if (!static_branch_unlikely(&skb_defer_disable_key) &&
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/jump_label.h:515:41: note: in expansion of macro 'unlikely_notrace'
     515 | #define static_branch_unlikely(x)       unlikely_notrace(static_key_enabled(&(x)->key))
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:515:58: note: in expansion of macro 'static_key_enabled'
     515 | #define static_branch_unlikely(x)       unlikely_notrace(static_key_enabled(&(x)->key))
         |                                                          ^~~~~~~~~~~~~~~~~~
   net/core/skbuff.c:1522:14: note: in expansion of macro 'static_branch_unlikely'
    1522 |         if (!static_branch_unlikely(&skb_defer_disable_key) &&
         |              ^~~~~~~~~~~~~~~~~~~~~~
   net/core/skbuff.c:1522:38: note: each undeclared identifier is reported only once for each function it appears in
    1522 |         if (!static_branch_unlikely(&skb_defer_disable_key) &&
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/jump_label.h:515:41: note: in expansion of macro 'unlikely_notrace'
     515 | #define static_branch_unlikely(x)       unlikely_notrace(static_key_enabled(&(x)->key))
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:515:58: note: in expansion of macro 'static_key_enabled'
     515 | #define static_branch_unlikely(x)       unlikely_notrace(static_key_enabled(&(x)->key))
         |                                                          ^~~~~~~~~~~~~~~~~~
   net/core/skbuff.c:1522:14: note: in expansion of macro 'static_branch_unlikely'
    1522 |         if (!static_branch_unlikely(&skb_defer_disable_key) &&
         |              ^~~~~~~~~~~~~~~~~~~~~~


vim +/skb_defer_disable_key +1522 net/core/skbuff.c

  1500	
  1501	/**
  1502	 * napi_consume_skb() - consume skb in NAPI context, try to feed skb cache
  1503	 * @skb: buffer to free
  1504	 * @budget: NAPI budget
  1505	 *
  1506	 * Non-zero @budget must come from the @budget argument passed by the core
  1507	 * to a NAPI poll function. Note that core may pass budget of 0 to NAPI poll
  1508	 * for example when polling for netpoll / netconsole.
  1509	 *
  1510	 * Passing @budget of 0 is safe from any context, it turns this function
  1511	 * into dev_consume_skb_any().
  1512	 */
  1513	void napi_consume_skb(struct sk_buff *skb, int budget)
  1514	{
  1515		if (unlikely(!budget || !skb)) {
  1516			dev_consume_skb_any(skb);
  1517			return;
  1518		}
  1519	
  1520		DEBUG_NET_WARN_ON_ONCE(!in_softirq());
  1521	
> 1522		if (!static_branch_unlikely(&skb_defer_disable_key) &&
  1523		    skb->alloc_cpu != smp_processor_id() && !skb_shared(skb)) {
  1524			skb_release_head_state(skb);
  1525			return skb_attempt_defer_free(skb);
  1526		}
  1527	
  1528		if (!skb_unref(skb))
  1529			return;
  1530	
  1531		/* if reaching here SKB is ready to free */
  1532		trace_consume_skb(skb, __builtin_return_address(0));
  1533	
  1534		/* if SKB is a clone, don't handle this case */
  1535		if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
  1536			__kfree_skb(skb);
  1537			return;
  1538		}
  1539	
  1540		skb_release_all(skb, SKB_CONSUMED);
  1541		napi_skb_cache_put(skb);
  1542	}
  1543	EXPORT_SYMBOL(napi_consume_skb);
  1544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

