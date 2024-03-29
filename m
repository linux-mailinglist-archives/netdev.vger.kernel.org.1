Return-Path: <netdev+bounces-83297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118798919C3
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 13:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC1F287102
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82012F5BB;
	Fri, 29 Mar 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSMAQknI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2212F5BE
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715396; cv=none; b=NLoUTKfSYNEzXl/5++M6mQ/nscTGibLDFknaeNyVnalf9M3uVKOMJ7NKE07hqotkjuZ46sUfVFciMJfADTFJqiRCnO/v2YEMKMyHwgmxwW1tOuN37VyswxKDl3nx1qowBE3m02VdlZdLtxi3I9rFg8th7tFv7oTsVR2vFPgeevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715396; c=relaxed/simple;
	bh=zlL5uCtBWx/cCQnKA8sr/TvI8oSJzMNDzwGE/gDiQuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9cVvBC7oYrr/WyaOdC4NrcHH4jsMU5NTO6fD+oGdbqlm8/WFD3t1OOIQjwvB3rlA04MIFiklMhJWZhq2xrOzcZhcBuQUoS8G9b59sNYK92Fx9cCZqfB1VYfQKQlZiHH+1JlHr2pEqutBhXF4/VZ8yRr1OTDldh6k7ayO2iSmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSMAQknI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711715394; x=1743251394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zlL5uCtBWx/cCQnKA8sr/TvI8oSJzMNDzwGE/gDiQuA=;
  b=OSMAQknIKmKzezaQsyGyPKMJroFM98dhiYVMTjEoibC4UoXwzKE/rCdP
   InvBboEwHHbg1HAZpRXWiwgnqxj576ULid8TqXHP8YqhzJ4Fa3hAMor6J
   1dYHD2hwonBL7g05f7QZEG/ALvZ1EHkcTn3M4FLDpegMlKEalkdvC4Mpt
   8epVzJwEvRIqngS4+EU4SQF9MxooVs8rrvkaxrhZ3LZ1J9ve2DOCv3q2b
   DvzVhveI+dRLVp4FhZGnEZOMvOlXMIJ7o8oUmuBwwk6JkkIrii3/YdGZG
   t84uB2CfwTkPn8wpkLoxIvDS87Bs7DDuyCuKYoFfmBvwpa7cMpOdW2m0z
   g==;
X-CSE-ConnectionGUID: VISUTgoMSOyadZ6QIm5d5A==
X-CSE-MsgGUID: sLqd19Y3Rxa3qMAit6/Nnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="9858826"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="9858826"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 05:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="17426697"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Mar 2024 05:29:50 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rqBMh-0003BC-1E;
	Fri, 29 Mar 2024 12:29:47 +0000
Date: Fri, 29 Mar 2024 20:29:35 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 6/8] net: rps: change
 input_queue_tail_incr_save()
Message-ID: <202403292036.FloftiJL-lkp@intel.com>
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
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20240329/202403292036.FloftiJL-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240329/202403292036.FloftiJL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403292036.FloftiJL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/dev.c:89:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> net/core/dev.c:4819:10: error: call to undeclared function 'rps_input_queue_tail_incr'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   tail = rps_input_queue_tail_incr(sd);
                          ^
>> net/core/dev.c:4823:3: error: call to undeclared function 'rps_input_queue_tail_save'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   rps_input_queue_tail_save(qtail, tail);
                   ^
>> net/core/dev.c:5901:4: error: call to undeclared function 'rps_input_queue_head_incr'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           rps_input_queue_head_incr(sd);
                           ^
   net/core/dev.c:5910:4: error: call to undeclared function 'rps_input_queue_head_incr'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           rps_input_queue_head_incr(sd);
                           ^
   net/core/dev.c:6038:4: error: call to undeclared function 'rps_input_queue_head_incr'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                           rps_input_queue_head_incr(sd);
                           ^
   net/core/dev.c:11452:3: error: call to undeclared function 'rps_input_queue_head_incr'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   rps_input_queue_head_incr(oldsd);
                   ^
   net/core/dev.c:11456:3: error: call to undeclared function 'rps_input_queue_head_incr'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   rps_input_queue_head_incr(oldsd);
                   ^
   12 warnings and 7 errors generated.


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

