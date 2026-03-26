Return-Path: <netdev+bounces-272013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMRYHogixWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:11:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74B33501F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B82C3303436C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA473E4C88;
	Thu, 26 Mar 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWPdoNI1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1743F6600
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526912; cv=none; b=csuILCuxdvPE862u5tkotn9OFi7Cs9gbm7qZAu7YzJpSo15sIg+5q7Uk0nVdUBM9Ophp7cCPW/IRjyhUgYm4yY9LhG//kUjkGkaut/oXwB1myDT+tmhhfcfvVZnwRJ7rMIto1mGeTbRHxYDuDmR/FhPEe98pTOXtNIoWpsxYuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526912; c=relaxed/simple;
	bh=kDjocMmCFSwRx37gmNF+2gImpzJwY2rCLwY4Q2xwfzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXBnEEjJ4O1U+el7O2GI1/1+bCGr4gB+qSWJgkD6l36ekn6QcVORv5dnGhfDurpZyFlch5yNgCnQd7HRUAEAYJA+cHeUGl8zEANgNVSwaWFZg1k1xdYCYyMWLdTuRJX0fl9gtqekroM8/Uuwv08IK8bY2Skfw07YW2uJ5dSLQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWPdoNI1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774526908; x=1806062908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kDjocMmCFSwRx37gmNF+2gImpzJwY2rCLwY4Q2xwfzg=;
  b=NWPdoNI19ePGAg9riiD3uOWfmPNLCJubqb9g0uamSVnTI7h0cJUt2gUk
   pBKs3NuOsgt6LGno5Tgci+6afo/hjaZpGp4AOWKMBkmzxnfqOkb4dICg+
   Zr2gU4mZBJbOP5ewUPUH1LbtuxDVM1tSiHTNPqHGWUxo+3+32XFS9Sav7
   MCi8K3NhoOKtfxXTADvvkqW/g6gxTha9GJQEiRZ5cvIj8mIH8Zga2gwgw
   Y/7L/tOhVahScVNRyYcpanfynuCAuxdbfQPjHuKKpF0O/YTPLnqbzC4Wc
   XFOU/3sm3CTLKk72keq1yaqGeQSPrTPT6pmhaBcb7YaCMjAc665znGImf
   A==;
X-CSE-ConnectionGUID: KPiTUncNRem2e1Slvl2uaA==
X-CSE-MsgGUID: 6VA2Hd5oTBqZfw8HOrlwdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="92963630"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="92963630"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 05:08:27 -0700
X-CSE-ConnectionGUID: +27luCfxS0OUsXYAhLG0VA==
X-CSE-MsgGUID: zWXgcWE6SXqEWhvVCQ1kZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255484732"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Mar 2026 05:08:25 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5jVd-000000008pd-2WU2;
	Thu, 26 Mar 2026 12:08:21 +0000
Date: Thu, 26 Mar 2026 20:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	dsahern@kernel.org, davem@davemloft.net,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions
 on netlink updates
Message-ID: <202603261933.hgl2CPHS-lkp@intel.com>
References: <20260325161020.3516-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325161020.3516-2-fmancera@suse.de>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-272013-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 1D74B33501F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Fernando-Fernandez-Mancera/ipv4-ipv4-handle-devconf-post-set-actions-on-netlink-updates/20260326-020953
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260325161020.3516-2-fmancera%40suse.de
patch subject: [PATCH 2/2 net-next] ipv4: ipv4: handle devconf post-set actions on netlink updates
config: x86_64-buildonly-randconfig-003-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261933.hgl2CPHS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261933.hgl2CPHS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261933.hgl2CPHS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/devinet.c:2131:13: warning: function 'devinet_conf_post_set' has internal linkage but is not defined [-Wundefined-internal]
    2131 | static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
         |             ^
   net/ipv4/devinet.c:2155:8: note: used here
    2155 |                         if (devinet_conf_post_set(net, &in_dev->cnf, nla_type(a), new_value,
         |                             ^
   1 warning generated.


vim +/devinet_conf_post_set +2131 net/ipv4/devinet.c

  2130	
> 2131	static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
  2132					  int attr, int new, int old, int index);
  2133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

