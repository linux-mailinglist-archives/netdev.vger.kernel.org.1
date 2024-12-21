Return-Path: <netdev+bounces-153900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEE9FA00D
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 11:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DAE1641F2
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 10:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87791F2C30;
	Sat, 21 Dec 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGeN96xK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD61F2C28;
	Sat, 21 Dec 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734775290; cv=none; b=ndRtUN9/euD79UXQ211BTrz1os59DGjkapLAbQ4q1XyLaXdwEC8vqdfEJZ/WyZ33zQA1hh1h4Qe/6tQEYsknv6x0pehElNKaBCaj1zlveFbFzmgstLPq3sIIsxcnF4Po0dOauDI9SrwyHIfN/1nuEQCEwKmMxnRKCq5PpEFpRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734775290; c=relaxed/simple;
	bh=klfr5iDrlwgyFse2esVRRcM5EeFYLG3zxkM25WwC5pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha0j+y7PWn/i3vZc2VbtKKSaZJGOb1L7YBkTgQfFbEokyBYxoJYZFSyLx+UCpj4JC7a8MEato7o61eGHVKhNJkL3JMFQM83SkG27BifmHCYvObB9pbdMtITShjBravnDu1kNetXttnqXuqmQQl0+HqP6bCCaCBtyH3blAb1fQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGeN96xK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734775289; x=1766311289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=klfr5iDrlwgyFse2esVRRcM5EeFYLG3zxkM25WwC5pE=;
  b=LGeN96xK6hTfiVawBn53gXqcaLsrOID85TGlrnq8XCTY5U5fBSZw50EJ
   7ylf7q06oQ1rtwPQDVZA1LB1gH+WF6huxhRm20Q7XtuJJmqkLM7prjEPB
   2ed94REImtWyE2C657MbQg8W28Begf39VNejshfLPtlSjG9QmtLk3Ckvc
   +K/hCuLLx2vMBaMBU5ArPd+o5pCPlOtZTe2WtkTiMVHtf98R0tlfjZ0cS
   n+oxkOQb+yRQhAA1QC8gM1sTvyZOJQL8X3+jSKwqbPqNPd0LOiDEEvtP9
   ZXAX9cjsplFzZi02qGNiilVuzLWSWf5Q/lKjpV5nYKclsqONslW8w99Gj
   A==;
X-CSE-ConnectionGUID: H1mNKHWUSxeCu5wadQhPzw==
X-CSE-MsgGUID: OAhig7NEQzmC3+3oiQPfww==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35460286"
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="35460286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 02:01:29 -0800
X-CSE-ConnectionGUID: OOvwgj4wRa+1P3ewiSL91g==
X-CSE-MsgGUID: o425voEzQGKH0fcxkd42AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,253,1728975600"; 
   d="scan'208";a="129562415"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Dec 2024 02:01:22 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOwIR-000281-08;
	Sat, 21 Dec 2024 10:01:19 +0000
Date: Sat, 21 Dec 2024 18:01:05 +0800
From: kernel test robot <lkp@intel.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH v7 6/7] rust: Add read_poll_timeout functions
Message-ID: <202412211700.9lWP3KmT-lkp@intel.com>
References: <20241220061853.2782878-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220061853.2782878-7-fujita.tomonori@gmail.com>

Hi FUJITA,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0c5928deada15a8d075516e6e0d9ee19011bb000]

url:    https://github.com/intel-lab-lkp/linux/commits/FUJITA-Tomonori/rust-time-Add-PartialEq-Eq-PartialOrd-Ord-trait-to-Ktime/20241220-142722
base:   0c5928deada15a8d075516e6e0d9ee19011bb000
patch link:    https://lore.kernel.org/r/20241220061853.2782878-7-fujita.tomonori%40gmail.com
patch subject: [PATCH v7 6/7] rust: Add read_poll_timeout functions
config: microblaze-randconfig-r131-20241221 (https://download.01.org/0day-ci/archive/20241221/202412211700.9lWP3KmT-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241221/202412211700.9lWP3KmT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412211700.9lWP3KmT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:1080:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1080:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1080:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2179:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/core.c:2179:39: sparse:     expected struct task_struct *donor
   kernel/sched/core.c:2179:39: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/core.c:2190:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2190:65: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2190:65: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5641:15: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *donor @@     got struct task_struct [noderef] __rcu *donor @@
   kernel/sched/core.c:5641:15: sparse:     expected struct task_struct *donor
   kernel/sched/core.c:5641:15: sparse:     got struct task_struct [noderef] __rcu *donor
   kernel/sched/core.c:6653:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6653:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6653:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:7199:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7199:17: sparse:    struct task_struct *
   kernel/sched/core.c:7199:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:8901:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct task_struct * @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:8901:16: sparse:     expected struct task_struct *
   kernel/sched/core.c:8901:16: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:10116:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:10116:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:10116:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1490:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:591:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/sched.h:1490:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:624:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:640:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:677:21: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:678:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:718:21: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:719:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/sched.h:2258:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2258:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2258:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2258:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2258:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2258:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2258:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2258:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2258:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2269:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2269:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2269:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2481:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2481:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2481:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2481:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2481:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2481:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2269:26: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2269:26: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2269:26: sparse:    struct task_struct *
   kernel/sched/sched.h:2458:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2458:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2458:9: sparse:    struct task_struct *
>> kernel/sched/core.c:8722:31: sparse: sparse: marked inline, but without a definition

vim +8722 kernel/sched/core.c

  8721	
> 8722	void __might_resched_precision(const char *file, int len, int line, unsigned int offsets)
  8723	{
  8724		/* Ratelimiting timestamp: */
  8725		static unsigned long prev_jiffy;
  8726	
  8727		unsigned long preempt_disable_ip;
  8728	
  8729		/* WARN_ON_ONCE() by default, no rate limit required: */
  8730		rcu_sleep_check();
  8731	
  8732		if ((resched_offsets_ok(offsets) && !irqs_disabled() &&
  8733		     !is_idle_task(current) && !current->non_block_count) ||
  8734		    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
  8735		    oops_in_progress)
  8736			return;
  8737	
  8738		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
  8739			return;
  8740		prev_jiffy = jiffies;
  8741	
  8742		/* Save this before calling printk(), since that will clobber it: */
  8743		preempt_disable_ip = get_preempt_disable_ip(current);
  8744	
  8745		pr_err("BUG: sleeping function called from invalid context at %.*s:%d\n",
  8746		       len, file, line);
  8747		pr_err("in_atomic(): %d, irqs_disabled(): %d, non_block: %d, pid: %d, name: %s\n",
  8748		       in_atomic(), irqs_disabled(), current->non_block_count,
  8749		       current->pid, current->comm);
  8750		pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
  8751		       offsets & MIGHT_RESCHED_PREEMPT_MASK);
  8752	
  8753		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
  8754			pr_err("RCU nest depth: %d, expected: %u\n",
  8755			       rcu_preempt_depth(), offsets >> MIGHT_RESCHED_RCU_SHIFT);
  8756		}
  8757	
  8758		if (task_stack_end_corrupted(current))
  8759			pr_emerg("Thread overran stack, or stack corrupted\n");
  8760	
  8761		debug_show_held_locks(current);
  8762		if (irqs_disabled())
  8763			print_irqtrace_events(current);
  8764	
  8765		print_preempt_disable_ip(offsets & MIGHT_RESCHED_PREEMPT_MASK,
  8766					 preempt_disable_ip);
  8767	
  8768		dump_stack();
  8769		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
  8770	}
  8771	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

