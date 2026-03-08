Return-Path: <netdev+bounces-265228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C0XIA8ErWncxAEAu9opvQ
	(envelope-from <netdev+bounces-265228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 06:07:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA922E8D7
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 06:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67E1B3008C9E
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 05:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7503128DF;
	Sun,  8 Mar 2026 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GY3oOv45"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3783368A1
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 05:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772946440; cv=none; b=FgqcdrOL+50Rq7t2VBGOp509q3D2JpKFe34VmXe6aQ5mAvSqvKdonnrXB9z2op3rfMvVkJ89I7qGbN1Jqg38f5Eab1fzdLGJhyjZZAQeA1aKfOghBnUa+AE1w+pzjO31vjmOm1P0yFdbKqoE/mu/nljKABMMM7nmYTGma9WN+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772946440; c=relaxed/simple;
	bh=PoRRun1BrhuZi8h7yUzp/FrTozKQZcf2gZHWG2DVOMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5gP1U121A8kXueq2/k88W3Vo4LTH2N+I6U6tKM3YWb78hDkFCDzudNBzD4l766fw7RPzJNk1Ws35xinOCW7wMShzFo79oOKulq63n5sFT1RCwb4mATFzZT8zq8yflKR1KVw9B9sEubDi3fvo7+OhdPbJzZx9FnYgt4Y0340cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GY3oOv45; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772946440; x=1804482440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PoRRun1BrhuZi8h7yUzp/FrTozKQZcf2gZHWG2DVOMY=;
  b=GY3oOv45tddSmNHK0iEdbUNGW43YI7Kt/5gA1lKh1p0cDZAgEQ1eXYLW
   8FUd6m18oPYfE6kLb9pkWZhCR340JJsTN5QeHmNxezfRDLlNJkbxet2f/
   5GQYdEY+r+ah144fMrs6oB3a8sZdUUM2SZ7+y9h7pq58VpooiFILovNtm
   3MxBlVVJFuBdaU9K1JOBdIGYEFe0xqjSH9EOnMZ/0sVIvVq6O+T3PHN+5
   596T/s3wd2kWmjE10CIuYBgNSmn6k1e3QXla9IeuRF/kB0bb93DEeT6xu
   yC6hLFV2zl1QLqt49lhQKZNICM8nXT1x/Fhks0UArCWrPyjNsKIQt/XA7
   g==;
X-CSE-ConnectionGUID: XLku1OjkTZyI75LT5dZndQ==
X-CSE-MsgGUID: Mv1HRiYyRsiKcv6xxHrjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="84329233"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="84329233"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 21:07:19 -0800
X-CSE-ConnectionGUID: yvAT1GjpSTauFybyja8tCw==
X-CSE-MsgGUID: HiLVP5tFQKqisV/SxtTzcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="223527466"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 07 Mar 2026 21:07:17 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz6ME-000000002dB-2Tlg;
	Sun, 08 Mar 2026 05:07:14 +0000
Date: Sun, 8 Mar 2026 06:06:35 +0100
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
	ilias.apalodimas@linaro.org
Subject: Re: [PATCH net] page_pool: store detach_time as ktime_t to avoid
 false-negatives
Message-ID: <202603080650.SZhWEYVL-lkp@intel.com>
References: <20260307204022.1897614-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307204022.1897614-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 86DA922E8D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265228-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.981];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Jakub,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Kicinski/page_pool-store-detach_time-as-ktime_t-to-avoid-false-negatives/20260308-044057
base:   net/main
patch link:    https://lore.kernel.org/r/20260307204022.1897614-1-kuba%40kernel.org
patch subject: [PATCH net] page_pool: store detach_time as ktime_t to avoid false-negatives
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260308/202603080650.SZhWEYVL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080650.SZhWEYVL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080650.SZhWEYVL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/page_pool_user.c:248:5: error: call to undeclared function 'ktime_to_seconds'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     248 |                          ktime_to_seconds(pool->user.detach_time)))
         |                          ^
   net/core/page_pool_user.c:248:5: note: did you mean 'ktime_get_seconds'?
   include/linux/timekeeping.h:59:17: note: 'ktime_get_seconds' declared here
      59 | extern time64_t ktime_get_seconds(void);
         |                 ^
   1 error generated.


vim +/ktime_to_seconds +248 net/core/page_pool_user.c

   214	
   215	static int
   216	page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
   217			  const struct genl_info *info)
   218	{
   219		size_t inflight, refsz;
   220		unsigned int napi_id;
   221		void *hdr;
   222	
   223		hdr = genlmsg_iput(rsp, info);
   224		if (!hdr)
   225			return -EMSGSIZE;
   226	
   227		if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_ID, pool->user.id))
   228			goto err_cancel;
   229	
   230		if (pool->slow.netdev->ifindex != LOOPBACK_IFINDEX &&
   231		    nla_put_u32(rsp, NETDEV_A_PAGE_POOL_IFINDEX,
   232				pool->slow.netdev->ifindex))
   233			goto err_cancel;
   234	
   235		napi_id = pool->p.napi ? READ_ONCE(pool->p.napi->napi_id) : 0;
   236		if (napi_id_valid(napi_id) &&
   237		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_NAPI_ID, napi_id))
   238			goto err_cancel;
   239	
   240		inflight = page_pool_inflight(pool, false);
   241		refsz =	PAGE_SIZE << pool->p.order;
   242		if (nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT, inflight) ||
   243		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
   244				 inflight * refsz))
   245			goto err_cancel;
   246		if (pool->user.detach_time &&
   247		    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
 > 248				 ktime_to_seconds(pool->user.detach_time)))
   249			goto err_cancel;
   250	
   251		if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
   252			goto err_cancel;
   253	
   254		genlmsg_end(rsp, hdr);
   255	
   256		return 0;
   257	err_cancel:
   258		genlmsg_cancel(rsp, hdr);
   259		return -EMSGSIZE;
   260	}
   261	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

