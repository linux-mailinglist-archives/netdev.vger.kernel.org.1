Return-Path: <netdev+bounces-94117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EB8BE313
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF991C20ABE
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747015DBC0;
	Tue,  7 May 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnwaLcB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2215D5DB
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087301; cv=none; b=LV0bYqc8XDszSGxzSz5Z10loCRQ8Viv1esInQlBRzcRuZ9x9Bv0puicMkm5yCUAt5y/tH3qCeVmN0l4AqMogFGvPI6AxCSS8Ts7jbn57MC+UnWEiuTELVwdqfiLoMCc3CQm8ZU6zVKA5EO8idsi5NMKL2ibKMKmZ+UU4gvVDNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087301; c=relaxed/simple;
	bh=n2Mq5Nu+Xkq5zWeIyowvn6gZM/ZUCpGAlvmf5z/RNW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cflolx0GRyYXEuwvEO0hJ3axWlZemPU3gmL9CeXT1OX8siLc5hGuN1/qzsVvlfW7l2oFNcPRzGBe5h463AIxLbWEj1Vvqo6Y3JJHtcaJRsSYPU4NsdsEYMAlixmse0uOAbLyUE4BfNxIAIDXI5+Gi8om9rRu83FWtZ+OjHF5DuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnwaLcB6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso11565a12.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715087298; x=1715692098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIrrWnnAT5iTVbpxiPvm1Ho3YYT5tUO0A7JLwTOVXK4=;
        b=cnwaLcB62lsChwa8R54ug1CM+hY7lnDJJRjxhXg6XVWDFj5r0z7wf29VCvnZP8Vofl
         1Oyb/OR2ku18OTX2gcvZhUpAXKMFKwunEd3ZhTD0mQKXi2LgZoaWQyoBiU1GoctkaUmt
         Dg93s609D98KxOmH6BTtoG4m2ypHzDPnApLDRn7EYY00dbL+x4Nkdlxgzo9D8hz4ll3p
         yGgcdioSs6UArj8WNAK5q6mgvsTdAhMnwtq9C3uJJDI5zZSZoTSen8pUOaYPjiwxFsV7
         tHd2i1CnRrWCCWRmcRoBGtQe2GB5oeMjFiTct0GDNA/dCwpCEyupQVx+llOpUgwH3qbt
         IHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087298; x=1715692098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIrrWnnAT5iTVbpxiPvm1Ho3YYT5tUO0A7JLwTOVXK4=;
        b=AWSegVJB/tcQZIHCMNvVSTyHjcsVh22QUM9dmUpAhiIgjK3AkBuMT/8uXsLoYca0gP
         d6rCciWP6LIfVGMAcI8PojQx3zLJJjSQRfcwhu/nugn2ANJc6VZmkH0CUgIpsD6sDB4H
         +SyS2FugVgrTKbNBqv/waxi0xDsJK6VooJkss8HNwNSY2CU4lAjP1gRrZM433WQ+UFYJ
         1IoUy9ZjsCZXcZWBc/UCljV3zxEu8FmlFL+rcq7Mc23J18tiOChT+pFQsbKkkt5vWW8p
         4h2HocgJJ4GevVQxh7A219OR11UumqEyP7ydhMmgvsbjNh+6qNPGRgbySpRsIyR2R3FI
         us+w==
X-Forwarded-Encrypted: i=1; AJvYcCWBqiRNIb4SBbZEIOJJ8QJ4kkQOTgThxi2il8Zt2OTmh3N28jGGHXDwUxADdVnf/FW44kaFiuyxp4JTRyNNknGlvtospVb6
X-Gm-Message-State: AOJu0YyJLVQc2NUGpAEKYoG4aR1GpHOVgN0XfP5CcfxTMlohsyY6LA8o
	GxjzH5rWLdwBdCJcFDEaG81mTGt7vHZS9nsB8softHWappB6YgrIJ+tDcItuPKu9pio2G6bA77+
	9n0zHdAPeC/LQAa0iw8MI3RYJ0gRC0YrI7Wy1
X-Google-Smtp-Source: AGHT+IGkGm6L4EiXNU4fc7UybKdRBmMSg1rAidexjsDVp+DghcKGIIa/DK6RPPIqRRMDKijvuWf3NQOkNsDLc3w1ubQ=
X-Received: by 2002:a05:6402:35d1:b0:572:554b:ec66 with SMTP id
 4fb4d7f45d1cf-5731310fe6fmr196133a12.3.1715087297784; Tue, 07 May 2024
 06:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507124229.446802-1-leone4fernando@gmail.com>
In-Reply-To: <20240507124229.446802-1-leone4fernando@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 15:08:02 +0200
Message-ID: <CANn89iKhHJDZZSwz1EtecZduNt7HxYW5o_1T0CJ9kqXxNbqMDA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] net: route: improve route hinting
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:43=E2=80=AFPM Leone Fernando <leone4fernando@gmail=
.com> wrote:
>
> In 2017, Paolo Abeni introduced the hinting mechanism [1] to the routing
> sub-system. The hinting optimization improves performance by reusing
> previously found dsts instead of looking them up for each skb.
>
> This patch series introduces a generalized version of the hinting mechani=
sm that
> can "remember" a larger number of dsts. This reduces the number of dst
> lookups for frequently encountered daddrs.
>
> Before diving into the code and the benchmarking results, it's important
> to address the deletion of the old route cache [2] and why
> this solution is different. The original cache was complicated,
> vulnerable to DOS attacks and had unstable performance.
>
> The new input dst_cache is much simpler thanks to its lazy approach,
> improving performance without the overhead of the removed cache
> implementation. Instead of using timers and GC, the deletion of invalid
> entries is performed lazily during their lookups.
> The dsts are stored in a simple, lightweight, static hash table. This
> keeps the lookup times fast yet stable, preventing DOS upon cache misses.
> The new input dst_cache implementation is built over the existing
> dst_cache code which supplies a fast lockless percpu behavior.
>
> The measurement setup is comprised of 2 machines with mlx5 100Gbit NIC.
> I sent small UDP packets with 5000 daddrs (10x of cache size) from one
> machine to the other while also varying the saddr and the tos. I set
> an iptables rule to drop the packets after routing. the receiving
> machine's CPU (i9) was saturated.
>
> Thanks a lot to David Ahern for all the help and guidance!
>
> I measured the rx PPS using ifpps and the per-queue PPS using ethtool -S.
> These are the results:

How device dismantles are taken into account ?

I am currently tracking a bug in dst_cache, triggering sometimes when
running pmtu.sh selftest.

Apparently, dst_cache_per_cpu_dst_set() can cache dst that have no
dst->rt_uncached
linkage.

There is no cleanup (at least in vxlan) to make sure cached dst are
either freed or
their dst->dev changed.


TEST: ipv6: cleanup of cached exceptions - nexthop objects          [ OK ]
[ 1001.344490] vxlan: __vxlan_fdb_free calling
dst_cache_destroy(ffff8f12422cbb90)
[ 1001.345253] dst_cache_destroy dst_cache=3Dffff8f12422cbb90
->cache=3D0000417580008d30
[ 1001.378615] vxlan: __vxlan_fdb_free calling
dst_cache_destroy(ffff8f12471e31d0)
[ 1001.379260] dst_cache_destroy dst_cache=3Dffff8f12471e31d0
->cache=3D0000417580008608
[ 1011.349730] unregister_netdevice: waiting for veth_A-R1 to become
free. Usage count =3D 7
[ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 1/6 users at
[ 1011.350562]      dst_alloc+0x76/0x160
[ 1011.350562]      ip6_dst_alloc+0x25/0x80
[ 1011.350562]      ip6_pol_route+0x2a8/0x450
[ 1011.350562]      ip6_pol_route_output+0x1f/0x30
[ 1011.350562]      fib6_rule_lookup+0x163/0x270
[ 1011.350562]      ip6_route_output_flags+0xda/0x190
[ 1011.350562]      ip6_dst_lookup_tail.constprop.0+0x1d0/0x260
[ 1011.350562]      ip6_dst_lookup_flow+0x47/0xa0
[ 1011.350562]      udp_tunnel6_dst_lookup+0x158/0x210
[ 1011.350562]      vxlan_xmit_one+0x4c6/0x1550 [vxlan]
[ 1011.350562]      vxlan_xmit+0x535/0x1500 [vxlan]
[ 1011.350562]      dev_hard_start_xmit+0x7b/0x1e0
[ 1011.350562]      __dev_queue_xmit+0x20c/0xe40
[ 1011.350562]      arp_xmit+0x1d/0x50
[ 1011.350562]      arp_send_dst+0x7f/0xa0
[ 1011.350562]      arp_solicit+0xf6/0x2f0
[ 1011.350562]
[ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 3/6 users at
[ 1011.350562]      dst_alloc+0x76/0x160
[ 1011.350562]      ip6_dst_alloc+0x25/0x80
[ 1011.350562]      ip6_pol_route+0x2a8/0x450
[ 1011.350562]      ip6_pol_route_output+0x1f/0x30
[ 1011.350562]      fib6_rule_lookup+0x163/0x270
[ 1011.350562]      ip6_route_output_flags+0xda/0x190
[ 1011.350562]      ip6_dst_lookup_tail.constprop.0+0x1d0/0x260
[ 1011.350562]      ip6_dst_lookup_flow+0x47/0xa0
[ 1011.350562]      udp_tunnel6_dst_lookup+0x158/0x210
[ 1011.350562]      vxlan_xmit_one+0x4c6/0x1550 [vxlan]
[ 1011.350562]      vxlan_xmit+0x535/0x1500 [vxlan]
[ 1011.350562]      dev_hard_start_xmit+0x7b/0x1e0
[ 1011.350562]      __dev_queue_xmit+0x20c/0xe40
[ 1011.350562]      ip6_finish_output2+0x2ea/0x6e0
[ 1011.350562]      ip6_finish_output+0x143/0x320
[ 1011.350562]      ip6_output+0x74/0x140
[ 1011.350562]
[ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 1/6 users at
[ 1011.350562]      netdev_get_by_index+0xc0/0xe0
[ 1011.350562]      fib6_nh_init+0x1a9/0xa90
[ 1011.350562]      rtm_new_nexthop+0x6fa/0x1580
[ 1011.350562]      rtnetlink_rcv_msg+0x155/0x3e0
[ 1011.350562]      netlink_rcv_skb+0x61/0x110
[ 1011.350562]      rtnetlink_rcv+0x19/0x20
[ 1011.350562]      netlink_unicast+0x23f/0x380
[ 1011.350562]      netlink_sendmsg+0x1fc/0x430
[ 1011.350562]      ____sys_sendmsg+0x2ef/0x320
[ 1011.350562]      ___sys_sendmsg+0x86/0xd0
[ 1011.350562]      __sys_sendmsg+0x67/0xc0
[ 1011.350562]      __x64_sys_sendmsg+0x21/0x30
[ 1011.350562]      x64_sys_call+0x252/0x2030
[ 1011.350562]      do_syscall_64+0x6c/0x190
[ 1011.350562]      entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1011.350562]
[ 1011.350562] ref_tracker: veth_A-R1@000000009392ed3b has 1/6 users at
[ 1011.350562]      ipv6_add_dev+0x136/0x530
[ 1011.350562]      addrconf_notify+0x19d/0x770
[ 1011.350562]      notifier_call_chain+0x65/0xd0
[ 1011.350562]      raw_notifier_call_chain+0x1a/0x20
[ 1011.350562]      call_netdevice_notifiers_info+0x54/0x90
[ 1011.350562]      register_netdevice+0x61e/0x790
[ 1011.350562]      veth_newlink+0x230/0x440
[ 1011.350562]      __rtnl_newlink+0x7d2/0xaa0
[ 1011.350562]      rtnl_newlink+0x4c/0x70
[ 1011.350562]      rtnetlink_rcv_msg+0x155/0x3e0
[ 1011.350562]      netlink_rcv_skb+0x61/0x110
[ 1011.350562]      rtnetlink_rcv+0x19/0x20
[ 1011.350562]      netlink_unicast+0x23f/0x380
[ 1011.350562]      netlink_sendmsg+0x1fc/0x430
[ 1011.350562]      ____sys_sendmsg+0x2ef/0x320
[ 1011.350562]      ___sys_sendmsg+0x86/0xd0
[ 1011.350562]

