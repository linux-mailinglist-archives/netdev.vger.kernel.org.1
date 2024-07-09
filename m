Return-Path: <netdev+bounces-110375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7392C201
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860301F22714
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF775187862;
	Tue,  9 Jul 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFLT06DL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910518563E
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544166; cv=none; b=sqw7kJWrRaUQi39nWKuxsqtKX/+kzuv2Bqb3KSIgfRRQHTliN2ja+iICHFldac+hg5CfIxgixXoNHvhiSNikbuwsOSlC4kJpk4q3fIh13PGn5S1m2wMNv9YDTpLB7j2ZXI7h0tGCKYInJP7LXlNV1jbmz2/8eJuqDn7i2UQmM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544166; c=relaxed/simple;
	bh=6QIC2NGwO+XgGtkUd9Wkjhu0uofXwkeUchnH9lAlmC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skGnRZyHQG8/4Exr+1f7SWvYZArqXUFIB0ZjJkM0Ubx362CVnR57HnqETtyYD8zSKqORPzUle5EQcWtVmSREoIRhb81cmyQpQBZYfVMbYKc/IaciGN+7uAcm9qiog6a2sW9epwKCEaXSzNbs6N+ZD5jba06fBOnVw/G/uxlvHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFLT06DL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1faf7700399so1016825ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720544164; x=1721148964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJbSEbMqNiDrQteUchvBRbl2mIdENCqdHdrAgbGdloo=;
        b=OFLT06DL0Syv5Wi8SWNg8KjEut5HPe0Pbl7FIhLfkdlOmnxJs0/m0DBbSb1ztOxkye
         kLgnmq107CKnQMpsahbRpTLwxEtJJ9L1GVnygX1u9NWB3XQbQSmUcU/dqx3O70wjxwxM
         ly/S9CnQzbh5F5UIQh4pEcBbdQbC6UqucMpWwTYSQrlItfsDAHDueOFhdmxhsCdiplFV
         p9NImUcNGtbLiituS51hgqqD1s5g1t3dSbrS7kxL6FIwBYRHNeydmmgMZMVcbmi6IObQ
         gyfF58tV3Zab2UEGpyrBd9JU+N45irODd/dnoyO1bjP678w0Ja0+tCWnOmnk6xBWxUhC
         xn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720544164; x=1721148964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJbSEbMqNiDrQteUchvBRbl2mIdENCqdHdrAgbGdloo=;
        b=EwPXbdWAtI7wCdcCcSPRVjzmko5pPLwPD7gY255e4okKvnTykePzKGKVlFR4NuY+Zi
         Q57WfSGGCy4ofmGOv/Zpom4wParYsjMuBXc9lExFus/yY/PI6+OD7Iji3q7J7iT7F0pr
         zpJDWIe1prbDKCf/hFyw8oK04Qi4Ly1FhPOYxSTSzWvnnCdMQuLSmt+XQKBL3BuEDksL
         UffAYnXmZ4FQtq6XDMTl1S8GERxp0/aO4Fs/cpBtYlGvCK0DdrfgRo6agtftSpq6j91k
         zpjw7uLtuU/cumG8h5o1pt5TwEGNMm/kInMvyWZgrS2SymUNHlzCT8hgYpOO864iOc9P
         cxYw==
X-Forwarded-Encrypted: i=1; AJvYcCUSLPLcXkz5jTl/k7GK4buLjDX8aNDvHP0wS9GhNObSg36BovoK5tE7vQCk/uxyt2VMqRbsh6360g5UeXlv9EG45aDfoLIq
X-Gm-Message-State: AOJu0Yztz99sHQVOflnQ29Yh5X6LI0Al5l46ZvL2OU3Re7KtnlXdWopW
	y5qh7hS691ek60qPExGqzqO3kLMuXua8gY9teuQKgIsljbevjEfq
X-Google-Smtp-Source: AGHT+IHgoevzj+/wfjcLUuw+Ugezq3Hk8+0MeskrjA7lhOnVL1meGjKyBMH4XHlS/kKic9Tdw+NHKg==
X-Received: by 2002:a17:903:41cc:b0:1f9:b19b:4255 with SMTP id d9443c01a7336-1fbb6f13a60mr32565955ad.4.1720544164335;
        Tue, 09 Jul 2024 09:56:04 -0700 (PDT)
Received: from ?IPV6:2620:15c:2c1:200:c9fd:85dd:f0e2:77cc? ([2620:15c:2c1:200:c9fd:85dd:f0e2:77cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11a4csm18318375ad.15.2024.07.09.09.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 09:56:03 -0700 (PDT)
Message-ID: <8f064e3a-b7cb-4aea-bbdb-c4d6a809759f@gmail.com>
Date: Tue, 9 Jul 2024 09:56:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: dsahern@gmail.com, adrian.oliver@menlosecurity.com
References: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/9/24 8:37 AM, Omid Ehtemam-Haghighi wrote:
> Soft lockups have been observed on a cluster of Linux-based edge routers
> located in a highly dynamic environment. Using the `bird` service, these
> routers continuously update BGP-advertised routes due to frequently
> changing nexthop destinations, while also managing significant IPv6
> traffic. The lockups occur during the traversal of the multipath
> circular linked-list in the `fib6_select_path` function, particularly
> while iterating through the siblings in the list. The issue typically
> arises when the nodes of the linked list are unexpectedly deleted
> concurrently on a different core—indicated by their 'next' and
> 'previous' elements pointing back to the node itself and their reference
> count dropping to zero. This results in an infinite loop, leading to a
> soft lockup that triggers a system panic via the watchdog timer.
>
> To fix this issue, I applied RCU primitives in the problematic code
> sections, which successfully resolved the issue within our testing
> parameters and in the production environment where the issue was first
> observed. Additionally, all references to fib6_siblings have been updated
> to annotate or use the RCU APIs.
>
> A test script that reproduces this issue is included with this patch. The
> script periodically updates the routing table while generating a heavy load
> of outgoing IPv6 traffic through multiple iperf3 clients. I have tested
> this script on various machines, ranging from low to high performance, as
> detailed in the comment section of the test script. It consistently induces
> soft lockups within a minute.
>
> Kernel log:
>
>   0 [ffffbd13003e8d30] machine_kexec at ffffffff8ceaf3eb
>   1 [ffffbd13003e8d90] __crash_kexec at ffffffff8d0120e3
>   2 [ffffbd13003e8e58] panic at ffffffff8cef65d4
>   3 [ffffbd13003e8ed8] watchdog_timer_fn at ffffffff8d05cb03
>   4 [ffffbd13003e8f08] __hrtimer_run_queues at ffffffff8cfec62f
>   5 [ffffbd13003e8f70] hrtimer_interrupt at ffffffff8cfed756
>   6 [ffffbd13003e8fd0] __sysvec_apic_timer_interrupt at ffffffff8cea01af
>   7 [ffffbd13003e8ff0] sysvec_apic_timer_interrupt at ffffffff8df1b83d
> -- <IRQ stack> --
>   8 [ffffbd13003d3708] asm_sysvec_apic_timer_interrupt at ffffffff8e000ecb
>      [exception RIP: fib6_select_path+299]
>      RIP: ffffffff8ddafe7b  RSP: ffffbd13003d37b8  RFLAGS: 00000287
>      RAX: ffff975850b43600  RBX: ffff975850b40200  RCX: 0000000000000000
>      RDX: 000000003fffffff  RSI: 0000000051d383e4  RDI: ffff975850b43618
>      RBP: ffffbd13003d3800   R8: 0000000000000000   R9: ffff975850b40200
>      R10: 0000000000000000  R11: 0000000000000000  R12: ffffbd13003d3830
>      R13: ffff975850b436a8  R14: ffff975850b43600  R15: 0000000000000007
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   9 [ffffbd13003d3808] ip6_pol_route at ffffffff8ddb030c
> 10 [ffffbd13003d3888] ip6_pol_route_input at ffffffff8ddb068c
> 11 [ffffbd13003d3898] fib6_rule_lookup at ffffffff8ddf02b5
> 12 [ffffbd13003d3928] ip6_route_input at ffffffff8ddb0f47
> 13 [ffffbd13003d3a18] ip6_rcv_finish_core.constprop.0 at ffffffff8dd950d0
> 14 [ffffbd13003d3a30] ip6_list_rcv_finish.constprop.0 at ffffffff8dd96274
> 15 [ffffbd13003d3a98] ip6_sublist_rcv at ffffffff8dd96474
> 16 [ffffbd13003d3af8] ipv6_list_rcv at ffffffff8dd96615
> 17 [ffffbd13003d3b60] __netif_receive_skb_list_core at ffffffff8dc16fec
> 18 [ffffbd13003d3be0] netif_receive_skb_list_internal at ffffffff8dc176b3
> 19 [ffffbd13003d3c50] napi_gro_receive at ffffffff8dc565b9
> 20 [ffffbd13003d3c80] ice_receive_skb at ffffffffc087e4f5 [ice]
> 21 [ffffbd13003d3c90] ice_clean_rx_irq at ffffffffc0881b80 [ice]
> 22 [ffffbd13003d3d20] ice_napi_poll at ffffffffc088232f [ice]
> 23 [ffffbd13003d3d80] __napi_poll at ffffffff8dc18000
> 24 [ffffbd13003d3db8] net_rx_action at ffffffff8dc18581
> 25 [ffffbd13003d3e40] __do_softirq at ffffffff8df352e9
> 26 [ffffbd13003d3eb0] run_ksoftirqd at ffffffff8ceffe47
> 27 [ffffbd13003d3ec0] smpboot_thread_fn at ffffffff8cf36a30
> 28 [ffffbd13003d3ee8] kthread at ffffffff8cf2b39f
> 29 [ffffbd13003d3f28] ret_from_fork at ffffffff8ce5fa64
> 30 [ffffbd13003d3f50] ret_from_fork_asm at ffffffff8ce03cbb
>
> Reported-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Tested-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>
> Signed-off-by: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>

Can you also add a Fixes: tag, and cc edumazet@google.com next time ?


> ---
> v2:
> 	* list_del_rcu() is applied exclusively to legacy multipath code
> 	* All occurrences of fib6_siblings have been modified to utilize RCU
> 	  APIs for annotation and usage.
> 	* Additionally, a test script for reproducing the reported
> 	  issue is included
> ---
>   include/net/ip6_fib.h                         |   2 +-
>   net/ipv6/ip6_fib.c                            |  24 +-
>   net/ipv6/route.c                              |  40 ++--
>   tools/testing/selftests/net/Makefile          |   1 +
>   .../net/ipv6_route_update_soft_lockup.sh      | 217 ++++++++++++++++++
>   5 files changed, 260 insertions(+), 24 deletions(-)
>   create mode 100755 tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
>
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 6cb867ce4878..167ef421bcb0 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -166,7 +166,7 @@ struct fib6_info {
>   	 * to speed up lookup.
>   	 */
>   	union {
> -		struct list_head	fib6_siblings;
> +		struct list_head __rcu	fib6_siblings;
>   		struct list_head	nh_list;
>   	};
>   	unsigned int			fib6_nsiblings;
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 83e4f9855ae1..6202575b2c20 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -518,7 +518,7 @@ int fib6_tables_dump(struct net *net, struct notifier_block *nb,
>   static int fib6_dump_node(struct fib6_walker *w)
>   {
>   	int res;
> -	struct fib6_info *rt;
> +	struct fib6_info *rt, *sibling, *last_sibling;
>   
>   	for_each_fib6_walker_rt(w) {
>   		res = rt6_dump_route(rt, w->args, w->skip_in_node);
> @@ -540,10 +540,16 @@ static int fib6_dump_node(struct fib6_walker *w)
>   		 * last sibling of this route (no need to dump the
>   		 * sibling routes again)
>   		 */
> -		if (rt->fib6_nsiblings)
> -			rt = list_last_entry(&rt->fib6_siblings,
> -					     struct fib6_info,
> -					     fib6_siblings);
> +		rcu_read_lock();
> +		if (rt->fib6_nsiblings) {
> +			last_sibling = rt;
> +			list_for_each_entry_rcu(sibling, &rt->fib6_siblings,
> +						fib6_siblings)
> +				last_sibling = sibling;
> +
> +			rt = last_sibling;
> +		}
> +		rcu_read_unlock();


After this rcu_read_unlock(), there is no protection left.

I think fib6_dump_node() is already called under rcu_read_lock().

(This used to be RTNL in older kernels)

Please lets not add add rcu_read_lock()/rcu_read_unlock() pairs blindly.

