Return-Path: <netdev+bounces-138366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A309AD14A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150D6B21A18
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE51CCEE1;
	Wed, 23 Oct 2024 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7vl8CU2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163C1AB6F8;
	Wed, 23 Oct 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702077; cv=none; b=PooeEEkFhJDoq4ZnSedZ7AqnbNDL79uw3rVgPlMIVTr9CtYpoYMODiKm3GICb3txaC6TrYk4/IWuN7ZdNBmQM7TzI30KVhMPXNGT1rGbQi+8moY4jVhRBPU0TjLhIk68JVqG3BgnmzqToH0UiVZx5bZmsqw/R11eOwIk6b+IF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702077; c=relaxed/simple;
	bh=mmiQZ3L89WBQ/VbA5HZ+3oDu2nJREkMgINMncEfWUwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo6qPn+vhPX5poMdzkb5xsvnrKDDTlz3KGY+UENABnJriDazxpEpvVqGhmSZy+yYK9FDa1mqfs2ltoClZwX9dhQ304rppaOJXqDCEHj/GOKFCsnA349W8z4U6sX5i5Ybf7QmZsqLAsIbpBZLoZ6SCEcvz3Gz6f0Ehbw+RrJtlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7vl8CU2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729702076; x=1761238076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mmiQZ3L89WBQ/VbA5HZ+3oDu2nJREkMgINMncEfWUwI=;
  b=d7vl8CU2lxyNcszfW2A5Kv/KumPpwxZ9W2Nkxu2dqHKcR2E2mc5Ilyi/
   ugnoD5oUmcjivW3HUNCHknyBv/pNOGnrXpU58/9f6rbYY4LJRDmoKZfes
   MQZ6lydews5dhSPqBhx6ZXnRofk4aiQZheXk2TnY2wapRz60m/Jhsp15Z
   vCohZDIgUuHF2WcWUSEIaahCHiYblFv5dWr+USYdvn8Hv6K3mxvJOsZVq
   fRKWgzYx2kaGJ1JooX6f+mX5kpQT+ewmpoyUR7sERnoXQFeZdWO4p7GDs
   UBve65DcFH/RWDAIjmX39sp3qBRLT//02GSNKqMDt/v9pKclM1iUZGC7I
   Q==;
X-CSE-ConnectionGUID: 0G9vVKDTRKSOUoFeeH/srQ==
X-CSE-MsgGUID: x9oU5cPPRi2WHCmZuC667A==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29410284"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="29410284"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 09:47:55 -0700
X-CSE-ConnectionGUID: Swm1w9nFSIG9FP4egznOew==
X-CSE-MsgGUID: M+UL1oY2S8GCFS+3nYGsIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="84270827"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 23 Oct 2024 09:47:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3eWR-000VB2-26;
	Wed, 23 Oct 2024 16:47:47 +0000
Date: Thu, 24 Oct 2024 00:47:07 +0800
From: kernel test robot <lkp@intel.com>
To: Li Li <dualli@chromium.org>, dualli@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] binder: report txn errors via generic netlink
Message-ID: <202410240012.MJJTBFCx-lkp@intel.com>
References: <20241021182821.1259487-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021182821.1259487-2-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on staging/staging-next staging/staging-linus linus/master v6.12-rc4 next-20241023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/binder-report-txn-errors-via-generic-netlink/20241022-022923
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20241021182821.1259487-2-dualli%40chromium.org
patch subject: [PATCH v3 1/1] binder: report txn errors via generic netlink
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20241024/202410240012.MJJTBFCx-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410240012.MJJTBFCx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410240012.MJJTBFCx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/android/binder_genl.c:160: warning: Function parameter or struct member 'context' not described in 'binder_genl_set_report'
>> drivers/android/binder_genl.c:160: warning: Excess function parameter 'proc' description in 'binder_genl_set_report'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +160 drivers/android/binder_genl.c

   149	
   150	/**
   151	 * binder_genl_set_report() - set binder report flags
   152	 * @proc:	the binder_proc calling the ioctl
   153	 * @pid:	the target process
   154	 * @flags:	the flags to set
   155	 *
   156	 * If pid is 0, the flags are applied to the whole binder context.
   157	 * Otherwise, the flags are applied to the specific process only.
   158	 */
   159	int binder_genl_set_report(struct binder_context *context, u32 pid, u32 flags)
 > 160	{
   161		struct binder_proc *proc;
   162	
   163		if (flags != (flags & (BINDER_REPORT_ALL | BINDER_REPORT_OVERRIDE))) {
   164			pr_err("Invalid binder report flags: %u\n", flags);
   165			return -EINVAL;
   166		}
   167	
   168		if (!pid) {
   169			/* Set the global flags for the whole binder context */
   170			context->report_flags = flags;
   171		} else {
   172			/* Set the per-process flags */
   173			proc = binder_find_proc(pid);
   174			if (!proc) {
   175				pr_err("Invalid binder report pid %u\n", pid);
   176				return -EINVAL;
   177			}
   178	
   179			proc->report_flags = flags;
   180		}
   181	
   182		return 0;
   183	}
   184	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

