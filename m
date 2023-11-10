Return-Path: <netdev+bounces-47132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE87E8255
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41701C20966
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1C3AC2F;
	Fri, 10 Nov 2023 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0I7YCeF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA083AC22
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:18:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C68B12;
	Fri, 10 Nov 2023 11:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699643879; x=1731179879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ODdoguqhk0VjSYZVSvbWKkA4/MmGgIY12jmGr3aijw=;
  b=J0I7YCeFrjIsNBzgSrspfuwaPA7BFMIhFNm04Hy/u6FXG0G517Z1dWTa
   6XGP/JDibcAxhIfkUkhIA59S8/b4FhW9VBsgJRRf1nAxk4VugNv2Fzez0
   TI47NaF07J3G20qw+fEZHHQD1DxbloUw9HDn98tf9QAZ/jI6Um+w+xWO6
   /666Y8fRnjRhTFS5gt4G8gcI3JUZNn3QziVsn+SanxLHFAanWaBxiG2lW
   fR5Eau8RF2RkgxcgOA9qPsnRimZR2YU09A2+Os8MaD2JPcKzQgmZgPm5A
   f3dgec+ExxNI0g9BdyOlaueDg9Oj2ZpcUWkAOX9Y/mMroK/BeOqvpmrhy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="370427950"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="370427950"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 11:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="767398419"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="767398419"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2023 11:17:54 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r1X0q-0009qY-1e;
	Fri, 10 Nov 2023 19:17:52 +0000
Date: Sat, 11 Nov 2023 03:15:54 +0800
From: kernel test robot <lkp@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of
 cycle_time and interval
Message-ID: <202311110208.GT4trtEk-lkp@intel.com>
References: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107112023.676016-5-faizal.abdul.rahim@linux.intel.com>

Hi Faizal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Faizal-Rahim/net-sched-taprio-fix-too-early-schedules-switching/20231107-192843
base:   net/main
patch link:    https://lore.kernel.org/r/20231107112023.676016-5-faizal.abdul.rahim%40linux.intel.com
patch subject: [PATCH v2 net 4/7] net/sched: taprio: get corrected value of cycle_time and interval
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231111/202311110208.GT4trtEk-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110208.GT4trtEk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110208.GT4trtEk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/sched/sch_taprio.c:227:5: warning: no previous prototype for function 'get_interval' [-Wmissing-prototypes]
     227 | u32 get_interval(const struct sched_entry *entry,
         |     ^
   net/sched/sch_taprio.c:227:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     227 | u32 get_interval(const struct sched_entry *entry,
         | ^
         | static 
>> net/sched/sch_taprio.c:236:5: warning: no previous prototype for function 'get_cycle_time' [-Wmissing-prototypes]
     236 | s64 get_cycle_time(const struct sched_gate_list *oper)
         |     ^
   net/sched/sch_taprio.c:236:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     236 | s64 get_cycle_time(const struct sched_gate_list *oper)
         | ^
         | static 
   2 warnings generated.


vim +/get_interval +227 net/sched/sch_taprio.c

   226	
 > 227	u32 get_interval(const struct sched_entry *entry,
   228			 const struct sched_gate_list *oper)
   229	{
   230		if (entry->correction_active)
   231			return entry->interval + oper->cycle_time_correction;
   232		else
   233			return entry->interval;
   234	}
   235	
 > 236	s64 get_cycle_time(const struct sched_gate_list *oper)
   237	{
   238		if (cycle_corr_active(oper->cycle_time_correction))
   239			return oper->cycle_time + oper->cycle_time_correction;
   240		else
   241			return oper->cycle_time;
   242	}
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

