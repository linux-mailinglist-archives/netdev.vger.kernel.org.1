Return-Path: <netdev+bounces-96574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5908C67C4
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3EE1F2349D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329213EFEC;
	Wed, 15 May 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQldqjAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851538615E;
	Wed, 15 May 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781181; cv=none; b=CJpeUCNefqFhccQPlHYmjJPqb9zR9o0h7V8AqkPVYOuBnV9bSvrw2Fhv8Cr6pvRwbbp1T5yvu2rrigKvegcNLqFM7KeAr9YQaEXbuo+9oK8Dr8k97Go5Ic8bYmKaw5Jch+lIUfuxjRcRZgm/HoH8cJXGFDrryHBZLV3/w/OGtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781181; c=relaxed/simple;
	bh=9pUir2Bmh3a4DeHSSjXKEqZRuIlOzGkd0uWlqjnhK78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSeUe5kLJTC1jE+M/tWCkzRKTAZ9nsTxuEGxi5aGyzdp6uok8ZBZqiaP9icTh8c+nJjM+dZqcjAG8BqWqstnPo4UufzAvwEUqFYQxOr46+FYazl1/EzjajuVARYTM6AHmjRen8u8k7N/m1WBf6783+KaYh1GqKXBKKygFVJ3iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQldqjAc; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so38285285e9.1;
        Wed, 15 May 2024 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715781178; x=1716385978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95GL1bfSfGI43AFjQ0o3/46OQyrmlOi1EGkvabP5074=;
        b=JQldqjAcGq6DOn1p3tSFlQL185I5odnhYrZw2su0sVIJ4XizMilg+2zpiHseaaHYNI
         wjcYnxrrQp1rs/JzpX6K1Dpz8y1p6yMZrgSvDZVny5IP9TNPdr8kmuJmlSp5hxxTddIk
         DpLfn2WRCxtRP6D+oKPyJ5m/YblIOkT7duM1UvaIhrrcpZwjt0hpR7aJGgnoupO/mhu1
         D/MZmOz242OcC32goHvWrsgYwAAaDQvsOsF36oMnOW03/yG3DXLAr1aWTNhOHD9Hxww6
         qQJYf/56xdF9m+SRFptpeVAUgJbGzSqLkq3w5BJzIGV36g+5h7bJk4qKswXpW/QPljbC
         Yu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715781178; x=1716385978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95GL1bfSfGI43AFjQ0o3/46OQyrmlOi1EGkvabP5074=;
        b=o18sEHXyaXo78LNEjr1I34/vXZSI/0ighvW69ijr0zaP0f+iom+8YFBQ6NZNLPUmq7
         HZAMvi9ScLVuU7P2Y06HcNKbv0ho9KXnrUW+eXydAfTu5CcuCiJb09jk1E/+FhDS1o7p
         mi8ME6xG5M1TZxN20oTdcTVw3ivBrdUtIM98vkhsptBXqV7eXh4rzdUzAQqBEozFgNf4
         nFB5G4JbVWujr41YOXAp9Kbwmdacx/tpBRcYwikEvVKyk1jFO//A3dXZvwBgZr8BIHJ5
         3/QgILZQzB49Owlb8cz8hOHffl8yaXHTX4ke68GrpuQLwFM+JUiuC19SOsECy1CQxCRi
         mW6w==
X-Forwarded-Encrypted: i=1; AJvYcCWE2fX1i0BUc8ngALLcYM8JmIopXWNdpUtQGRgivcOtbvSi4ePCYz2Gl7f7R0aJAwwu7n4R/TUITk5GjeJvvWCPyk9aSdp4O3S4bPJxmJ/gDTI+DGKR5jz9ESNln95re375W/YF
X-Gm-Message-State: AOJu0YwF6YgkhO+NtcVKPUgnvKR/NUwJ90KWtW/N7rve7UjIHXgOW/tU
	+f3SKwIjZ/VOwUSfPTrWXg86OwTjSAf1RCT7OOKy4Q0uOrz6eBBl
X-Google-Smtp-Source: AGHT+IGuJMF1TezmzfsBj90oV9M1OgugqT9psmSTb3AIY0U4kcS92y3EdkzHHWsTjJnOENRpCdFC8Q==
X-Received: by 2002:a05:600c:45cb:b0:418:d3f4:677b with SMTP id 5b1f17b1804b1-41fead59f38mr153473295e9.17.1715781177607;
        Wed, 15 May 2024 06:52:57 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012a025dbsm135642555e9.23.2024.05.15.06.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 06:52:57 -0700 (PDT)
Message-ID: <c8ff8557-9e2c-4316-8642-fd7ab1553ffb@gmail.com>
Date: Wed, 15 May 2024 15:52:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/4] net: route: improve route hinting
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240507124229.446802-1-leone4fernando@gmail.com>
 <CANn89iKhHJDZZSwz1EtecZduNt7HxYW5o_1T0CJ9kqXxNbqMDA@mail.gmail.com>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <CANn89iKhHJDZZSwz1EtecZduNt7HxYW5o_1T0CJ9kqXxNbqMDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On Tue, May 7, 2024 at 2:43 PM Leone Fernando <leone4fernando@gmail.com> wrote:
>>
>> In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
>> sub-system. The hinting optimization improves performance by reusing
>> previously found dsts instead of looking them up for each skb.
>>
>> This patch series introduces a generalized version of the hinting mechanism that
>> can "remember" a larger number of dsts. This reduces the number of dst
>> lookups for frequently encountered daddrs.
>>
>> Before diving into the code and the benchmarking results, it's important
>> to address the deletion of the old route cache [2] and why
>> this solution is different. The original cache was complicated,
>> vulnerable to DOS attacks and had unstable performance.
>>
>> The new input dst_cache is much simpler thanks to its lazy approach,
>> improving performance without the overhead of the removed cache
>> implementation. Instead of using timers and GC, the deletion of invalid
>> entries is performed lazily during their lookups.
>> The dsts are stored in a simple, lightweight, static hash table. This
>> keeps the lookup times fast yet stable, preventing DOS upon cache misses.
>> The new input dst_cache implementation is built over the existing
>> dst_cache code which supplies a fast lockless percpu behavior.
>>
>> The measurement setup is comprised of 2 machines with mlx5 100Gbit NIC.
>> I sent small UDP packets with 5000 daddrs (10x of cache size) from one
>> machine to the other while also varying the saddr and the tos. I set
>> an iptables rule to drop the packets after routing. the receiving
>> machine's CPU (i9) was saturated.
>>
>> Thanks a lot to David Ahern for all the help and guidance!
>>
>> I measured the rx PPS using ifpps and the per-queue PPS using ethtool -S.
>> These are the results:
> 
> How device dismantles are taken into account ?
> 
> I am currently tracking a bug in dst_cache, triggering sometimes when
> running pmtu.sh selftest.
> 
> Apparently, dst_cache_per_cpu_dst_set() can cache dst that have no
> dst->rt_uncached
> linkage.

The dst_cache_input that was introduced in this series caches input
routes that are owned by the fib tree.
These routes have a rt_uncached linkage. So I think this bug will not
replicate to dst_cache_input.

> There is no cleanup (at least in vxlan) to make sure cached dst are
> either freed or
> their dst->dev changed.
> 
> 
> TEST: ipv6: cleanup of cached exceptions - nexthop objects          [ OK ]
> [ 1001.344490] vxlan: __vxlan_fdb_free calling
> dst_cache_destroy(ffff8f12422cbb90)
> [ 1001.345253] dst_cache_destroy dst_cache=ffff8f12422cbb90
> ->cache=0000417580008d30
> [ 1001.378615] vxlan: __vxlan_fdb_free calling
> dst_cache_destroy(ffff8f12471e31d0)
> [ 1001.379260] dst_cache_destroy dst_cache=ffff8f12471e31d0
> ->cache=0000417580008608
> [ 1011.349730] unregister_netdevice: waiting for veth_A-R1 to become
> free. Usage count = 7
> [ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 1/6 users at
> [ 1011.350562]      dst_alloc+0x76/0x160
> [ 1011.350562]      ip6_dst_alloc+0x25/0x80
> [ 1011.350562]      ip6_pol_route+0x2a8/0x450
> [ 1011.350562]      ip6_pol_route_output+0x1f/0x30
> [ 1011.350562]      fib6_rule_lookup+0x163/0x270
> [ 1011.350562]      ip6_route_output_flags+0xda/0x190
> [ 1011.350562]      ip6_dst_lookup_tail.constprop.0+0x1d0/0x260
> [ 1011.350562]      ip6_dst_lookup_flow+0x47/0xa0
> [ 1011.350562]      udp_tunnel6_dst_lookup+0x158/0x210
> [ 1011.350562]      vxlan_xmit_one+0x4c6/0x1550 [vxlan]
> [ 1011.350562]      vxlan_xmit+0x535/0x1500 [vxlan]
> [ 1011.350562]      dev_hard_start_xmit+0x7b/0x1e0
> [ 1011.350562]      __dev_queue_xmit+0x20c/0xe40
> [ 1011.350562]      arp_xmit+0x1d/0x50
> [ 1011.350562]      arp_send_dst+0x7f/0xa0
> [ 1011.350562]      arp_solicit+0xf6/0x2f0
> [ 1011.350562]
> [ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 3/6 users at
> [ 1011.350562]      dst_alloc+0x76/0x160
> [ 1011.350562]      ip6_dst_alloc+0x25/0x80
> [ 1011.350562]      ip6_pol_route+0x2a8/0x450
> [ 1011.350562]      ip6_pol_route_output+0x1f/0x30
> [ 1011.350562]      fib6_rule_lookup+0x163/0x270
> [ 1011.350562]      ip6_route_output_flags+0xda/0x190
> [ 1011.350562]      ip6_dst_lookup_tail.constprop.0+0x1d0/0x260
> [ 1011.350562]      ip6_dst_lookup_flow+0x47/0xa0
> [ 1011.350562]      udp_tunnel6_dst_lookup+0x158/0x210
> [ 1011.350562]      vxlan_xmit_one+0x4c6/0x1550 [vxlan]
> [ 1011.350562]      vxlan_xmit+0x535/0x1500 [vxlan]
> [ 1011.350562]      dev_hard_start_xmit+0x7b/0x1e0
> [ 1011.350562]      __dev_queue_xmit+0x20c/0xe40
> [ 1011.350562]      ip6_finish_output2+0x2ea/0x6e0
> [ 1011.350562]      ip6_finish_output+0x143/0x320
> [ 1011.350562]      ip6_output+0x74/0x140
> [ 1011.350562]
> [ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 1/6 users at
> [ 1011.350562]      netdev_get_by_index+0xc0/0xe0
> [ 1011.350562]      fib6_nh_init+0x1a9/0xa90
> [ 1011.350562]      rtm_new_nexthop+0x6fa/0x1580
> [ 1011.350562]      rtnetlink_rcv_msg+0x155/0x3e0
> [ 1011.350562]      netlink_rcv_skb+0x61/0x110
> [ 1011.350562]      rtnetlink_rcv+0x19/0x20
> [ 1011.350562]      netlink_unicast+0x23f/0x380
> [ 1011.350562]      netlink_sendmsg+0x1fc/0x430
> [ 1011.350562]      ____sys_sendmsg+0x2ef/0x320
> [ 1011.350562]      ___sys_sendmsg+0x86/0xd0
> [ 1011.350562]      __sys_sendmsg+0x67/0xc0
> [ 1011.350562]      __x64_sys_sendmsg+0x21/0x30
> [ 1011.350562]      x64_sys_call+0x252/0x2030
> [ 1011.350562]      do_syscall_64+0x6c/0x190
> [ 1011.350562]      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1011.350562]
> [ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 1/6 users at
> [ 1011.350562]      ipv6_add_dev+0x136/0x530
> [ 1011.350562]      addrconf_notify+0x19d/0x770
> [ 1011.350562]      notifier_call_chain+0x65/0xd0
> [ 1011.350562]      raw_notifier_call_chain+0x1a/0x20
> [ 1011.350562]      call_netdevice_notifiers_info+0x54/0x90
> [ 1011.350562]      register_netdevice+0x61e/0x790
> [ 1011.350562]      veth_newlink+0x230/0x440
> [ 1011.350562]      __rtnl_newlink+0x7d2/0xaa0
> [ 1011.350562]      rtnl_newlink+0x4c/0x70
> [ 1011.350562]      rtnetlink_rcv_msg+0x155/0x3e0
> [ 1011.350562]      netlink_rcv_skb+0x61/0x110
> [ 1011.350562]      rtnetlink_rcv+0x19/0x20
> [ 1011.350562]      netlink_unicast+0x23f/0x380
> [ 1011.350562]      netlink_sendmsg+0x1fc/0x430
> [ 1011.350562]      ____sys_sendmsg+0x2ef/0x320
> [ 1011.350562]      ___sys_sendmsg+0x86/0xd0
> [ 1011.350562]

