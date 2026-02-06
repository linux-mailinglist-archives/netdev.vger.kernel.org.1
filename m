Return-Path: <netdev+bounces-257464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N96qKWhzhWlzBwQAu9opvQ
	(envelope-from <netdev+bounces-257464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:51:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE744FA29C
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 05:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBD3E3016C9F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 04:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B2336EC2;
	Fri,  6 Feb 2026 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSZyDbnS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9A32573C;
	Fri,  6 Feb 2026 04:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770353508; cv=none; b=ruXC4F7n2TxCwSbc290MSzCmZ+Y5Luu4U/5W7wLeacjcnYM+uarFGpKFQ1xkFXCtKXXr9X8hAPnfXJaBNS6ZAwvHkcSHjZ33icWk3mVAUoi2LvX7R3KL+R4GrQghum6G88l8iwVenWbO+frXshlP/LxHHFTSEufIY1LaaF5LxNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770353508; c=relaxed/simple;
	bh=XoYD41piRQAsj7drwNYcIFc+f2x2sYboM5dSb+18cPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYJkFORKA4cCRbgvr6gaPmIR+B6uKz3N4/ah4nhKbxb4lIe9o2HSGzR0baxtvJojB8d518bCEikPsERcM4ObODMkqMZHQId9Srfjr30M2sTLi4aShDvA8bVrX3Q5UbLCzgunJptjV3TJa3LQBfGPHjoyg52oYoSH/pFPyflc3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSZyDbnS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770353508; x=1801889508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XoYD41piRQAsj7drwNYcIFc+f2x2sYboM5dSb+18cPQ=;
  b=SSZyDbnSfeEDPAnoWW8mYv0aDJiKrNE9rkNa/53GvDL4qfRdHkO6amLb
   RTywinqngk1PMTUFaohvz0ZNK3vumfq7+nIop4/7d1LhYq2tYnVHGC32S
   ZOhQ3Bu3dDyntBskQTZ96uzqROw5gXxMSiOrmk7+2e6094NL7c71zZrlT
   Ju0ktf4EM4OeDYL/ZCuWD+siPnHZ30YbUGcHqoa+vg9NFYsUe6xbK1Xv0
   6DNn/NcfeaHv9jgr+MatbuwDU0C9Jdnmi+93VC+u9DnX6UoyzVr2J+vD8
   woHiCClRcPrnWIFB9LruWbytWIbiUtZjyQumEPxyM/+p5s/lI7pcTGBwy
   w==;
X-CSE-ConnectionGUID: j9NvvvS9TxeLXrgarSQ6mA==
X-CSE-MsgGUID: tZrm3BoZSRi0/c483wgVMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82999976"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82999976"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 20:51:47 -0800
X-CSE-ConnectionGUID: v2AKH+1DSfuVfv26FuZ+jA==
X-CSE-MsgGUID: 4CWYJQDOSvSACue4p6WBSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="210690212"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 20:51:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1voDoj-00000000kQu-0Zkp;
	Fri, 06 Feb 2026 04:51:41 +0000
Date: Fri, 6 Feb 2026 12:50:42 +0800
From: kernel test robot <lkp@intel.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc: oe-kbuild-all@lists.linux.dev, Jesper Dangaard Brouer <hawk@kernel.org>,
	bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com,
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, atenart@redhat.com,
	carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2 6/6] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
Message-ID: <202602061245.hvInrQwP-lkp@intel.com>
References: <177032652354.1975497.2269771162710918590.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177032652354.1975497.2269771162710918590.stgit@firesoul>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-257464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE744FA29C
X-Rspamd-Action: no action

Hi Jesper,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesper-Dangaard-Brouer/net-sched-introduce-qdisc-specific-drop-reason-tracing/20260206-052816
base:   net-next/main
patch link:    https://lore.kernel.org/r/177032652354.1975497.2269771162710918590.stgit%40firesoul
patch subject: [PATCH net-next v2 6/6] net: sched: sch_dualpi2: use qdisc_dequeue_drop() for dequeue drops
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260206/202602061245.hvInrQwP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602061245.hvInrQwP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602061245.hvInrQwP-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/sched/sch_dualpi2.c: In function 'dualpi2_qdisc_dequeue':
>> net/sched/sch_dualpi2.c:600:53: error: 'QDISC_DROP_STEP_DROP' undeclared (first use in this function); did you mean 'QDISC_DROP_GENERIC'?
     600 |                         drop_and_retry(q, skb, sch, QDISC_DROP_STEP_DROP);
         |                                                     ^~~~~~~~~~~~~~~~~~~~
         |                                                     QDISC_DROP_GENERIC
   net/sched/sch_dualpi2.c:600:53: note: each undeclared identifier is reported only once for each function it appears in


vim +600 net/sched/sch_dualpi2.c

   581	
   582	static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
   583	{
   584		struct dualpi2_sched_data *q = qdisc_priv(sch);
   585		struct sk_buff *skb;
   586		int credit_change;
   587		u64 now;
   588	
   589		now = ktime_get_ns();
   590	
   591		while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
   592			if (!q->drop_early && must_drop(sch, q, skb)) {
   593				drop_and_retry(q, skb, sch,
   594					       QDISC_DROP_CONGESTED);
   595				continue;
   596			}
   597	
   598			if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
   599				qdisc_qstats_drop(q->l_queue);
 > 600				drop_and_retry(q, skb, sch, QDISC_DROP_STEP_DROP);
   601				continue;
   602			}
   603	
   604			q->c_protection_credit += credit_change;
   605			qdisc_bstats_update(sch, skb);
   606			break;
   607		}
   608	
   609		if (q->deferred_drops_cnt) {
   610			qdisc_tree_reduce_backlog(sch, q->deferred_drops_cnt,
   611						  q->deferred_drops_len);
   612			q->deferred_drops_cnt = 0;
   613			q->deferred_drops_len = 0;
   614		}
   615		return skb;
   616	}
   617	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

