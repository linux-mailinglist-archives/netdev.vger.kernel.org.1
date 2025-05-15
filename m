Return-Path: <netdev+bounces-190791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C99AB8CCB
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92D27B183B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA52253B52;
	Thu, 15 May 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PVHg8tI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BC253959
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327670; cv=none; b=osyWWcQ4qf+dca1ecNPH1Mo35i6hu4Hkdbf5ZyZqMwnCnKMZbY1zc0gjTf717yiXB4q1Un4OROSnmFtEme/RosrPjzRRToXSIHJadt7v9rU6vIjQURaB2heyAyp2GlaCPzZPiSg7Y5H8gcRq+XYJun6y09vC9NCUlryuJ/UKsXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327670; c=relaxed/simple;
	bh=gJUimSQkK6P0BlqKS9f/d3L594RA8rfFRuO48hE8BzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L38WpFxqASua1vMbCRzGxdh//yae9luMJ64jBVwYTzYzw5dQrbIeFWJ3CWMJLuY3QkSdZ95bCWG5ulPelcdLCxFRXa3dDCWr36sxLlMal6wY4JPXr9uHFeRTKCDLbrx0LazWKoWm7WhPzpiTk/y9w0qco+0zTnNHznc3v47NeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PVHg8tI+; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747327669; x=1778863669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uKyVcK3ZKLE6nZgBjAnOQrZd2sYc+pb2VFzulxnUweA=;
  b=PVHg8tI+NzGs8WteznTpMqZ6cquMOkf3L9UoCImdJehKt+1YbmkoILC9
   d41SmzJ5oMwl1bgvTjAJlJa3sL1xuzbJ7Jqq6q0Qy4YGd4OQ5XZ+0EDIe
   +s5z1votF+RdGKxjesByUdkynNPnh0m87EP/xlUk5LcjXxGmviBQpP5aD
   fzxlLa+FMXBYUphTweKnkNunAMu6uuC4DI0EiT7ryicIdbkD4P5/+Gnmz
   oE/urcuXWWzydbOsH8mkuSEFTsBZ57CK6thFBGDXeoLLIYtcM2j1QmV3P
   u4qIq1ueOULfkDSsZM2a5Hj0Lqs8vlrYRIhTDn1fSyKnZL9oqY0xNYkck
   g==;
X-IronPort-AV: E=Sophos;i="6.15,291,1739836800"; 
   d="scan'208";a="490382676"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 16:47:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:21596]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.48:2525] with esmtp (Farcaster)
 id bcf6eba5-92ba-47d6-b805-5397201cc0ca; Thu, 15 May 2025 16:47:42 +0000 (UTC)
X-Farcaster-Flow-ID: bcf6eba5-92ba-47d6-b805-5397201cc0ca
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 16:47:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 16:47:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 0/7] ipv6: Follow up for RTNL-free RTM_NEWROUTE series.
Date: Thu, 15 May 2025 09:46:13 -0700
Message-ID: <20250515164731.48991-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1d9bd2b1-9438-4605-b74a-8bab84bd95f5@redhat.com>
References: <1d9bd2b1-9438-4605-b74a-8bab84bd95f5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 15 May 2025 11:02:34 +0200
> On 5/15/25 4:05 AM, Kuniyuki Iwashima wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Wed, 14 May 2025 18:45:02 -0700
> >> On Wed, 14 May 2025 13:18:53 -0700 Kuniyuki Iwashima wrote:
> >>> Patch 1 removes rcu_read_lock() in fib6_get_table().
> >>> Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
> >>>  was short-term fix and is no longer used.
> >>> Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
> >>> Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.
> >>
> >> Hi! Something in the following set of patches is making our CI time out.
> >> The problem seems to be:
> >>
> >> [    0.751266] virtme-init: waiting for udev to settle
> >> Timed out for waiting the udev queue being empty.
> >> [  120.826428] virtme-init: udev is done
> >>
> >> +team: grab team lock during team_change_rx_flags
> >> +net: mana: Add handler for hardware servicing events
> >> +ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
> >> +ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
> >> +Revert "ipv6: Factorise ip6_route_multipath_add()."
> >> +Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
> >> +ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
> >> +inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
> >> +ipv6: Remove rcu_read_lock() in fib6_get_table().
> >> +net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead
> >>  amd-xgbe: read link status twice to avoid inconsistencies
> >> +net: phy: fixed_phy: remove fixed_phy_register_with_gpiod
> >>  drivers: net: mvpp2: attempt to refill rx before allocating skb
> >> +selftest: af_unix: Test SO_PASSRIGHTS.
> >> +af_unix: Introduce SO_PASSRIGHTS.
> >> +af_unix: Inherit sk_flags at connect().
> >> +af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> >> +net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
> >> +tcp: Restrict SO_TXREHASH to TCP socket.
> >> +scm: Move scm_recv() from scm.h to scm.c.
> >> +af_unix: Don't pass struct socket to maybe_add_creds().
> >> +af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
> >>
> >> I haven't dug into it, gotta review / apply other patches :(
> >> Maybe you can try to repro? 
> > 
> > I think I was able to reproduce it with SO_PASSRIGHTS series
> > with virtme-ng (but not with normal qemu with AL2023 rootfs).
> > 
> > After 2min, virtme-ng showed the console.
> > 
> > [    1.461450] virtme-ng-init: triggering udev coldplug
> > [    1.533147] virtme-ng-init: waiting for udev to settle
> > [  121.588624] virtme-ng-init: Timed out for waiting the udev queue being empty.
> > [  121.588710] virtme-ng-init: udev is done
> > [  121.593214] virtme-ng-init: initialization done
> >           _      _
> >    __   _(_)_ __| |_ _ __ ___   ___       _ __   __ _
> >    \ \ / / |  __| __|  _   _ \ / _ \_____|  _ \ / _  |
> >     \ V /| | |  | |_| | | | | |  __/_____| | | | (_| |
> >      \_/ |_|_|   \__|_| |_| |_|\___|     |_| |_|\__  |
> >                                                 |___/
> >    kernel version: 6.15.0-rc4-virtme-00071-gceba111cf5e7 x86_64
> >    (CTRL+d to exit)
> > 
> > 
> > Will investigate the cause.
> > 
> > Sorry, but please drop the series and kick the CI again.
> 
> FTR I think some CI iterations survived the boot and hit the following,
> in several forwarding tests (i.e. router-multipath-sh)

Oh thanks!

I learnt "make TARGETS=net run_tests" doesn't run forwarding tests.

Will fix in v2.


> 
> [  922.307796][ T6194] =============================
> [  922.308069][ T6194] WARNING: suspicious RCU usage
> [  922.308339][ T6194] 6.15.0-rc5-virtme #1 Not tainted
> [  922.308596][ T6194] -----------------------------
> [  922.308860][ T6194] ./include/net/addrconf.h:347 suspicious
> rcu_dereference_check() usage!
> [  922.309352][ T6194]
> [  922.309352][ T6194] other info that might help us debug this:
> [  922.309352][ T6194]
> [  922.310105][ T6194]
> [  922.310105][ T6194] rcu_scheduler_active = 2, debug_locks = 1
> [  922.310501][ T6194] 1 lock held by ip/6194:
> [  922.310704][ T6194]  #0: ffff888012942630
> (&tb->tb6_lock){+...}-{3:3}, at: ip6_route_multipath_add+0x743/0x1450
> [  922.311255][ T6194]
> [  922.311255][ T6194] stack backtrace:
> [  922.311577][ T6194] CPU: 1 UID: 0 PID: 6194 Comm: ip Not tainted
> 6.15.0-rc5-virtme #1 PREEMPT(full)
> [  922.311583][ T6194] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  922.311585][ T6194] Call Trace:
> [  922.311589][ T6194]  <TASK>
> [  922.311591][ T6194]  dump_stack_lvl+0xb0/0xd0
> [  922.311605][ T6194]  lockdep_rcu_suspicious+0x166/0x270
> [  922.311619][ T6194]  rt6_multipath_rebalance.part.0+0x70c/0x8a0
> [  922.311628][ T6194]  fib6_add_rt2node+0xa36/0x2c00
> [  922.311668][ T6194]  fib6_add+0x38d/0xec0
> [  922.311699][ T6194]  ip6_route_multipath_add+0x75b/0x1450
> [  922.311753][ T6194]  inet6_rtm_newroute+0xb2/0x120
> [  922.311795][ T6194]  rtnetlink_rcv_msg+0x710/0xc00
> [  922.311819][ T6194]  netlink_rcv_skb+0x12f/0x360
> [  922.311869][ T6194]  netlink_unicast+0x449/0x710
> [  922.311891][ T6194]  netlink_sendmsg+0x721/0xbe0
> [  922.311922][ T6194]  ____sys_sendmsg+0x7aa/0xa10
> [  922.311954][ T6194]  ___sys_sendmsg+0xed/0x170
> [  922.312031][ T6194]  __sys_sendmsg+0x108/0x1a0
> [  922.312061][ T6194]  do_syscall_64+0xc1/0x1d0
> [  922.312069][ T6194]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  922.312074][ T6194] RIP: 0033:0x7f8e77c649a7
> [  922.312078][ T6194] Code: 0a 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff
> eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00
> 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89
> 74 24 10
> [  922.312081][ T6194] RSP: 002b:00007ffd73480708 EFLAGS: 00000246
> ORIG_RAX: 000000000000002e
> [  922.312086][ T6194] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
> 00007f8e77c649a7
> [  922.312088][ T6194] RDX: 0000000000000000 RSI: 00007ffd73480770 RDI:
> 0000000000000005
> [  922.312090][ T6194] RBP: 00007ffd73480abc R08: 0000000000000038 R09:
> 0000000000000000
> [  922.312092][ T6194] R10: 000000000b9c6910 R11: 0000000000000246 R12:
> 00007ffd73481a80
> [  922.312094][ T6194] R13: 00000000682562aa R14: 0000000000498600 R15:
> 00007ffd7348499b
> [  922.312108][ T6194]  </TASK>
> 
> see:
> 
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-05-15--03-00&executor=vmksft-forwarding-dbg&pw-n=0&pass=0
> 
> Thanks,
> 
> Paolo

