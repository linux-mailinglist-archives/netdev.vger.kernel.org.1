Return-Path: <netdev+bounces-158182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE68A10D02
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732D21889BE2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476071D63E2;
	Tue, 14 Jan 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjYWUmc1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274A1B5EB5
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874448; cv=none; b=qHDf7+TY1tgWtc3bJFTdZ5N/fx7+VTy2iUPXkwQdOJoQePzXclsS2ron4xWLegCyLy+S5BeZToMwQOjhe1zdEZ/7CP3ccChyrtmexqw66tKqGuPGWHKJHouYhNK60Sb9iHl6w3xWaQB7CmIxcem+sCMlSM7N8aCy4qnXACFT/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874448; c=relaxed/simple;
	bh=PnXeLqUdisPMiUvtJK29ZfDryrcT0j50INGh5N22yL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4A5drfuNi1E2NROyzRdGOiBRdBxk45snRL72u0qHM1EEPwV7nNfUFCnivNUvTF+PRpsJLMBOm3XhIn3FgBz62blgYNOXli2vqfkvcyx++0PsUZU7q3XhHg3ZlmcijGoTbFgXhF0jH4TUI770PPwNjPPBmZdxwSO2CkxYZDNIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjYWUmc1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874445; x=1768410445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PnXeLqUdisPMiUvtJK29ZfDryrcT0j50INGh5N22yL4=;
  b=LjYWUmc13DFKobp2qh35/+KutcTnV0MCwS26aXhoLx1X0A2pGNAl7YCj
   5C/GOuN6/SIKSUSgCqI4UHrvhuEIzHX0tq2Yb34EjcxpcBjq4VENhVc9q
   Ltp+SokhK4CeKVsegJxUfnH8lFen1UCAZqGB3sKIn6hhC7W8MJOmSSpAf
   q0QHr/HEaBWfem8Edrgrq1CXlTHrw9FJ4hmo32CxE7krjtkGzbgrzjxd0
   we+F6dS6qIK7bnNAJP602zx8/l5RLHbrYQeKPJaUNOiMEXXsknuejFxLr
   xAiXxLhoPGkDua5b5GlLa3ExSROxfemKBVXC/ix2z/z3pRwrf/5HjAwMW
   g==;
X-CSE-ConnectionGUID: h67v5Jh3R3ir4Ke5bUBDBg==
X-CSE-MsgGUID: o7z2HBNyQy+CeRGxiWj8ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="24783250"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="24783250"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:07:25 -0800
X-CSE-ConnectionGUID: Jo+qxxn/TQeubswEiLU6lQ==
X-CSE-MsgGUID: m/pLrimzQlujdWYd3OxPeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105376998"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jan 2025 09:07:21 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXkNr-000Oml-12;
	Tue, 14 Jan 2025 17:07:19 +0000
Date: Wed, 15 Jan 2025 01:06:26 +0800
From: kernel test robot <lkp@intel.com>
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	ast@fiberby.net, Shuang Li <shuali@redhat.com>
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in
 tc_run
Message-ID: <202501150051.z1HfVwib-lkp@intel.com>
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>

Hi Xin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Long/net-sched-refine-software-bypass-handling-in-tc_run/20250114-025301
base:   net/main
patch link:    https://lore.kernel.org/r/17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin%40gmail.com
patch subject: [PATCHv2 net] net: sched: refine software bypass handling in tc_run
config: i386-buildonly-randconfig-004-20250114 (https://download.01.org/0day-ci/archive/20250115/202501150051.z1HfVwib-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250115/202501150051.z1HfVwib-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501150051.z1HfVwib-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/static_key.h:1,
                    from arch/x86/include/asm/nospec-branch.h:6,
                    from arch/x86/include/asm/irqflags.h:9,
                    from include/linux/irqflags.h:18,
                    from arch/x86/include/asm/special_insns.h:10,
                    from arch/x86/include/asm/processor.h:25,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from net/sched/cls_api.c:12:
   net/sched/cls_api.c: In function 'tcf_proto_destroy':
>> net/sched/cls_api.c:422:44: error: 'tcf_bypass_check_needed_key' undeclared (first use in this function)
     422 |                         static_branch_dec(&tcf_bypass_check_needed_key);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:525:63: note: in definition of macro 'static_branch_dec'
     525 | #define static_branch_dec(x)            static_key_slow_dec(&(x)->key)
         |                                                               ^
   net/sched/cls_api.c:422:44: note: each undeclared identifier is reported only once for each function it appears in
     422 |                         static_branch_dec(&tcf_bypass_check_needed_key);
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:525:63: note: in definition of macro 'static_branch_dec'
     525 | #define static_branch_dec(x)            static_key_slow_dec(&(x)->key)
         |                                                               ^
   net/sched/cls_api.c: In function 'tc_new_tfilter':
   net/sched/cls_api.c:2385:52: error: 'tcf_bypass_check_needed_key' undeclared (first use in this function)
    2385 |                                 static_branch_inc(&tcf_bypass_check_needed_key);
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jump_label.h:301:74: note: in definition of macro 'static_key_slow_inc'
     301 | #define static_key_slow_inc(key)        static_key_fast_inc_not_disabled(key)
         |                                                                          ^~~
   net/sched/cls_api.c:2385:33: note: in expansion of macro 'static_branch_inc'
    2385 |                                 static_branch_inc(&tcf_bypass_check_needed_key);
         |                                 ^~~~~~~~~~~~~~~~~


vim +/tcf_bypass_check_needed_key +422 net/sched/cls_api.c

   415	
   416	static void tcf_proto_destroy(struct tcf_proto *tp, bool rtnl_held,
   417				      bool sig_destroy, struct netlink_ext_ack *extack)
   418	{
   419		tp->ops->destroy(tp, rtnl_held, extack);
   420		if (tp->usesw && tp->counted) {
   421			if (!atomic_dec_return(&tp->chain->block->useswcnt))
 > 422				static_branch_dec(&tcf_bypass_check_needed_key);
   423			tp->counted = false;
   424		}
   425		if (sig_destroy)
   426			tcf_proto_signal_destroyed(tp->chain, tp);
   427		tcf_chain_put(tp->chain);
   428		module_put(tp->ops->owner);
   429		kfree_rcu(tp, rcu);
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

