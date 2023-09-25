Return-Path: <netdev+bounces-36066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984507ACE12
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 446D3281365
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8C1116;
	Mon, 25 Sep 2023 02:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB53139A
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 02:26:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32DDD3
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695608787; x=1727144787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q7KZnD+OweNbFKPAwXooi6SlHogRzpFGBSpsJx27HIQ=;
  b=gFZLxVyj8WQO/fds1mCPEomzwarXLNoNeS4gKvuepghdcfmcMw9IzcG6
   11T88I4r5d9kPPo87LLiO3dsjs3ACz2Re8Q7o7HCanmuUJIfG57ZJatkz
   PIIlAl2fcZeZ8MGuUGF+XVtfL0VOTSpz+GjoCcBd2N0zrkC//p389fyMX
   2Kw1Tk7ttMut4iCPfzAFGyooyhcosu23SFr6Ylkq4JQcKSDlxe4bmJmmQ
   krTTLApOSQEdg9EO+yTXRB8BsqOcLyZSBbOZcfF3XFXZupFsh65/KQCIe
   O7Olsvr8I2jx1bOH0oTn+Qmzffgl7l3vg3yMdCRUyx2TlA5eoX8GPLsbT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378419835"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="378419835"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748191644"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="748191644"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Sep 2023 19:26:16 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qkbIc-0000n9-1g;
	Mon, 25 Sep 2023 02:26:14 +0000
Date: Mon, 25 Sep 2023 10:25:20 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Willem de Bruijn <willemb@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/4] net_sched: sch_fq: add fast path for mostly
 idle qdisc
Message-ID: <202309251006.HEmH6uZd-lkp@intel.com>
References: <20230920125418.3675569-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920125418.3675569-4-edumazet@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net_sched-sch_fq-struct-sched_data-reorg/20230920-205744
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230920125418.3675569-4-edumazet%40google.com
patch subject: [PATCH net-next 3/4] net_sched: sch_fq: add fast path for mostly idle qdisc
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230925/202309251006.HEmH6uZd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309251006.HEmH6uZd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309251006.HEmH6uZd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/sched/sch_fq.c:550:1: warning: unused label 'queue' [-Wunused-label]
   queue:
   ^~~~~~
   1 warning generated.


vim +/queue +550 net/sched/sch_fq.c

   505	
   506	
   507	static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
   508			      struct sk_buff **to_free)
   509	{
   510		struct fq_sched_data *q = qdisc_priv(sch);
   511		struct fq_flow *f;
   512	
   513		if (unlikely(sch->q.qlen >= sch->limit))
   514			return qdisc_drop(skb, sch, to_free);
   515	
   516		q->ktime_cache = ktime_get_ns();
   517		if (!skb->tstamp) {
   518			fq_skb_cb(skb)->time_to_send = q->ktime_cache;
   519		} else {
   520			/* Check if packet timestamp is too far in the future. */
   521			if (fq_packet_beyond_horizon(skb, q)) {
   522				if (q->horizon_drop) {
   523						q->stat_horizon_drops++;
   524						return qdisc_drop(skb, sch, to_free);
   525				}
   526				q->stat_horizon_caps++;
   527				skb->tstamp = q->ktime_cache + q->horizon;
   528			}
   529			fq_skb_cb(skb)->time_to_send = skb->tstamp;
   530		}
   531	
   532		f = fq_classify(sch, skb);
   533		if (unlikely(f->qlen >= q->flow_plimit && f != &q->internal)) {
   534			q->stat_flows_plimit++;
   535			return qdisc_drop(skb, sch, to_free);
   536		}
   537	
   538		if (fq_flow_is_detached(f)) {
   539			fq_flow_add_tail(&q->new_flows, f);
   540			if (time_after(jiffies, f->age + q->flow_refill_delay))
   541				f->credit = max_t(u32, f->credit, q->quantum);
   542		}
   543	
   544		if (unlikely(f == &q->internal)) {
   545			q->stat_internal_packets++;
   546		} else {
   547			if (f->qlen == 0)
   548				q->inactive_flows--;
   549		}
 > 550	queue:
   551		f->qlen++;
   552		/* Note: this overwrites f->age */
   553		flow_queue_add(f, skb);
   554	
   555		qdisc_qstats_backlog_inc(sch, skb);
   556		sch->q.qlen++;
   557	
   558		return NET_XMIT_SUCCESS;
   559	}
   560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

