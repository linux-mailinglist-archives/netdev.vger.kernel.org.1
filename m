Return-Path: <netdev+bounces-83277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7BA891850
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 13:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CB31F2271A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80285636;
	Fri, 29 Mar 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1f3Qpmf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6B85297
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714073; cv=none; b=e3XmlYF3PazUSnM8AJJWpLU980bOKTcqT4jtMT2YFOHF/uXHnR12fMuKVVRSz56LSZKb2sosfyrcjtsvNLzkF83bCTCO1kLVIGxh8y+2aO1MWbgjXmODvaJ4+lQg3T3XK1XUil4tI+dTBnfvU2WI99gckQaGGhzgHfTQvrIL64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714073; c=relaxed/simple;
	bh=oj/jfgsVbBSjnzcksD9nnMW5zInQgkSw1MhcxfnlJ+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAIKsz37V8U3j5X4o+9A5+lrxvkhDA9rNQL71VvdFWOMTGgvcjzkIOD44OQQAa9hKngmK3nN1Y9/VxdnRHkyQVoIrBF7nYibf17CFZwvXW4CoFzp4HsJl9DsRFP8V3s9IxaboiE702PB0ZfEQv/44LLb38JbJAi2CQ7Jx+JJgxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1f3Qpmf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711714071; x=1743250071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oj/jfgsVbBSjnzcksD9nnMW5zInQgkSw1MhcxfnlJ+s=;
  b=a1f3QpmfKp4DsnC+0GwnBcqRddSS2NWlnz8zJBZYB7tAxPfgyntbgpdb
   XLpyKmmh8hfFHK6+cT2h+L+BDhVbKfPnk1jD4WOSpYU7S1TcV0eL/kCNQ
   EaJtERyeh/Ky3wlb4CoZiEJkKLPgR5yaCncDieQrenQutaWBn5uAl8+o/
   2US7Z3jh3nrOzgKFojaopL2p/b2HzncGIVc9YCDUqdKFtw+Il+7AnaipP
   IsXldi0nQfoB8ZDDHIFqd8npVdhcD4P13IsGI000ZDw5lvvi7Azqex3Ex
   eNt3iLA1d70RDBkntraiAvyGdvALEkjd2dzO0mpcncol53uzdv84kYhBt
   w==;
X-CSE-ConnectionGUID: GoDojZsATf+ZJ68taZLGEA==
X-CSE-MsgGUID: k6UM3JwNR66TqjFuo5kimA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6734600"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6734600"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 05:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17023112"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 05:07:49 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqB1O-00039y-1a;
	Fri, 29 Mar 2024 12:07:46 +0000
Date: Fri, 29 Mar 2024 20:07:37 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 6/8] net: rps: change
 input_queue_tail_incr_save()
Message-ID: <202403291901.lqImStGD-lkp@intel.com>
References: <20240328170309.2172584-7-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328170309.2172584-7-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-move-kick_defer_list_purge-to-net-core-dev-h/20240329-011413
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240328170309.2172584-7-edumazet%40google.com
patch subject: [PATCH net-next 6/8] net: rps: change input_queue_tail_incr_save()
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240329/202403291901.lqImStGD-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403291901.lqImStGD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403291901.lqImStGD-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/dev.c: In function 'enqueue_to_backlog':
>> net/core/dev.c:4819:24: error: implicit declaration of function 'rps_input_queue_tail_incr' [-Werror=implicit-function-declaration]
    4819 |                 tail = rps_input_queue_tail_incr(sd);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:4823:17: error: implicit declaration of function 'rps_input_queue_tail_save' [-Werror=implicit-function-declaration]
    4823 |                 rps_input_queue_tail_save(qtail, tail);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   net/core/dev.c: In function 'flush_backlog':
>> net/core/dev.c:5901:25: error: implicit declaration of function 'rps_input_queue_head_incr' [-Werror=implicit-function-declaration]
    5901 |                         rps_input_queue_head_incr(sd);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/rps_input_queue_tail_incr +4819 net/core/dev.c

  4781	
  4782	/*
  4783	 * enqueue_to_backlog is called to queue an skb to a per CPU backlog
  4784	 * queue (may be a remote CPU queue).
  4785	 */
  4786	static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
  4787				      unsigned int *qtail)
  4788	{
  4789		enum skb_drop_reason reason;
  4790		struct softnet_data *sd;
  4791		unsigned long flags;
  4792		unsigned int qlen;
  4793		int max_backlog;
  4794		u32 tail;
  4795	
  4796		reason = SKB_DROP_REASON_DEV_READY;
  4797		if (!netif_running(skb->dev))
  4798			goto bad_dev;
  4799	
  4800		reason = SKB_DROP_REASON_CPU_BACKLOG;
  4801		sd = &per_cpu(softnet_data, cpu);
  4802	
  4803		qlen = skb_queue_len_lockless(&sd->input_pkt_queue);
  4804		max_backlog = READ_ONCE(net_hotdata.max_backlog);
  4805		if (unlikely(qlen > max_backlog))
  4806			goto cpu_backlog_drop;
  4807		backlog_lock_irq_save(sd, &flags);
  4808		qlen = skb_queue_len(&sd->input_pkt_queue);
  4809		if (qlen <= max_backlog && !skb_flow_limit(skb, qlen)) {
  4810			if (!qlen) {
  4811				/* Schedule NAPI for backlog device. We can use
  4812				 * non atomic operation as we own the queue lock.
  4813				 */
  4814				if (!__test_and_set_bit(NAPI_STATE_SCHED,
  4815							&sd->backlog.state))
  4816					napi_schedule_rps(sd);
  4817			}
  4818			__skb_queue_tail(&sd->input_pkt_queue, skb);
> 4819			tail = rps_input_queue_tail_incr(sd);
  4820			backlog_unlock_irq_restore(sd, &flags);
  4821	
  4822			/* save the tail outside of the critical section */
> 4823			rps_input_queue_tail_save(qtail, tail);
  4824			return NET_RX_SUCCESS;
  4825		}
  4826	
  4827		backlog_unlock_irq_restore(sd, &flags);
  4828	
  4829	cpu_backlog_drop:
  4830		atomic_inc(&sd->dropped);
  4831	bad_dev:
  4832		dev_core_stats_rx_dropped_inc(skb->dev);
  4833		kfree_skb_reason(skb, reason);
  4834		return NET_RX_DROP;
  4835	}
  4836	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

