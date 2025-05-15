Return-Path: <netdev+bounces-190654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182CAB81E3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D664188C8FC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6228C5B5;
	Thu, 15 May 2025 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9HUieny"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F30221F2A
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299765; cv=none; b=NcFd43jbYPznevUdq5P04tiIhmevJbPI4eeu1fZpOzSpCqPNbQ0xdm5kR3KRgBrnaSJlkPVwqmI8MV3KF+n42Od4E38VNFfPb0psSP/BWOvseMq6zZzco6jSUxp1x7Mfcq8FsvkSzAx0GUYTBHpH4Ph+1DYyrHydzfnhjTV6nC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299765; c=relaxed/simple;
	bh=BIpkXFG+rljh0U91eGZjzeec0Dbz/itR8jz6IOuih50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgNwFW/liFmVNAS3IhnhDbCX3I93oyP+kGC6T637nRACHSqyC4QrXOMn+bw4RwUTcV0JbPRllmp+SUsSkHsvwYz+D1QO++HvgZdfAtV/u7CjwM5/weRUV/6LjzVMrLcaIBz9hyqRxSMWBXfKFY+HyORTZHC4wRcMTpyr4c/TY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9HUieny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747299761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+L/Ne5clh9kN72UIK/wzbdabfevOSe3T6whBD94ISfo=;
	b=F9HUienyDTe0FYB51Se7MwoiO+IX2zTh7/8zjt7SXBWInRnBfdKScVyqjDnNuba5a2e5/b
	Q5IjRwvkgs3ADClycG4F6enGtd7r9tILKcMXM9Fax5WJ0fQjWne4ED8mfCvJbNMwUue+oZ
	jkWnIqtpMdQ1mPzfpy8jw7JbszrvRn0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53--3qdoSqFN7qIhvBDYC6sJg-1; Thu, 15 May 2025 05:02:38 -0400
X-MC-Unique: -3qdoSqFN7qIhvBDYC6sJg-1
X-Mimecast-MFC-AGG-ID: -3qdoSqFN7qIhvBDYC6sJg_1747299757
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso3793965e9.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299757; x=1747904557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+L/Ne5clh9kN72UIK/wzbdabfevOSe3T6whBD94ISfo=;
        b=RFEfGm4ndxl+wf595kaoqtvBfLRGSsZCPjgO9Jccm2O49HUq379NT9v5rWnFutxZ6G
         PesTu5N+gyjclTBoRLW66t0EQ+ZeDaoZafGSp8AmtzTZSUvBL5B/jlVh5LV8pKrZIGvd
         r/NQDu7zU/ebtOiQZWal0FxDyai3NhNlDViixyRXrPL37R/c9oC/d5Xk3euXWmMLUhy9
         ydIQwJSvZYSGpjYZ46CV2/3sgCbhkitd05Tq/nh3qjH2/glSc64V0zpiP3+gWvwBwoTs
         Vy2Ib8iRi0D1S7AhbJCZZuyvADkJCQ1gOLh8UpMOHUI05T5HlxXvFzrS4Pf0CAUuPGli
         e85Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWjfon1KajSOTQgW/bhpoEura4Dx5FqK0YoqObOsu4c/sx0LNzORM7HC+pwZjKOAD7BekFamU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxwIJsqAg+/m8HmUBvRJUNJiyS2DMGBKMQPW71sO0Y2n2w3O+
	CgA4h7l3aJQe9HWNEARthUR86QmqQ4lVZ/UbXUenb2a01/Wgtevzs0TodVfOCX5q+58z/rlviB/
	ngUi9sHPWZTfYoa69A1ENlPLOaMQ4eBHyuy1xkTHqYRVPJu6U5dqS9OUJTA==
X-Gm-Gg: ASbGncu8OewRICCsene8uvzGIzxkXgGIt4Mb+LD+KaxQqvaM5nKus/Ucmqpb9Dq3Xbf
	lRzO0+K1m7Stbr/lBYNjiiUJZRT11my1r+l2oBtMFIV5qJDSPIXcr3c5kvU1vS6RgHN2AUIbORv
	ygGqj3TCzJm4/3Ozfo/sJvSFp9syDSLiQ86tFyMW+3uVE5HVcgQUfWmWNLI0j38T7em980/bLvl
	wY48Q5G9DCxZxZI2wQ0QB8JoBAjY3cc9hq/HwEpQnFzrfBgvTbiZ4bVBus0XvISfK+5hqQR50gU
	P4THonMCTss2e2PK5+Mph2n/qHh/bvRY5sqNd++Mp20KdbmxPSdZvspEeyc=
X-Received: by 2002:a05:600c:510e:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-442f84ca35amr18976125e9.4.1747299757304;
        Thu, 15 May 2025 02:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbWCAqNbSZnG+IrKRJNnPuMKWsFn8p2HcJO8hkeoc9rVv/gMsqSDBAe2v04eaBRjiyDSm8Iw==
X-Received: by 2002:a05:600c:510e:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-442f84ca35amr18975805e9.4.1747299756877;
        Thu, 15 May 2025 02:02:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm59999575e9.20.2025.05.15.02.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:02:36 -0700 (PDT)
Message-ID: <1d9bd2b1-9438-4605-b74a-8bab84bd95f5@redhat.com>
Date: Thu, 15 May 2025 11:02:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 0/7] ipv6: Follow up for RTNL-free
 RTM_NEWROUTE series.
To: Kuniyuki Iwashima <kuniyu@amazon.com>, kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org
References: <20250514184502.22f4c4e6@kernel.org>
 <20250515020944.19464-1-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250515020944.19464-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 4:05 AM, Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Wed, 14 May 2025 18:45:02 -0700
>> On Wed, 14 May 2025 13:18:53 -0700 Kuniyuki Iwashima wrote:
>>> Patch 1 removes rcu_read_lock() in fib6_get_table().
>>> Patch 2 removes rtnl_is_held arg for lwtunnel_valid_encap_type(), which
>>>  was short-term fix and is no longer used.
>>> Patch 3 fixes RCU vs GFP_KERNEL report by syzkaller.
>>> Patch 4~7 reverts GFP_ATOMIC uses to GFP_KERNEL.
>>
>> Hi! Something in the following set of patches is making our CI time out.
>> The problem seems to be:
>>
>> [    0.751266] virtme-init: waiting for udev to settle
>> Timed out for waiting the udev queue being empty.
>> [  120.826428] virtme-init: udev is done
>>
>> +team: grab team lock during team_change_rx_flags
>> +net: mana: Add handler for hardware servicing events
>> +ipv6: Revert two per-cpu var allocation for RTM_NEWROUTE.
>> +ipv6: Pass gfp_flags down to ip6_route_info_create_nh().
>> +Revert "ipv6: Factorise ip6_route_multipath_add()."
>> +Revert "ipv6: sr: switch to GFP_ATOMIC flag to allocate memory during seg6local LWT setup"
>> +ipv6: Narrow down RCU critical section in inet6_rtm_newroute().
>> +inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
>> +ipv6: Remove rcu_read_lock() in fib6_get_table().
>> +net/mlx5e: Reuse per-RQ XDP buffer to avoid stack zeroing overhead
>>  amd-xgbe: read link status twice to avoid inconsistencies
>> +net: phy: fixed_phy: remove fixed_phy_register_with_gpiod
>>  drivers: net: mvpp2: attempt to refill rx before allocating skb
>> +selftest: af_unix: Test SO_PASSRIGHTS.
>> +af_unix: Introduce SO_PASSRIGHTS.
>> +af_unix: Inherit sk_flags at connect().
>> +af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
>> +net: Restrict SO_PASS{CRED,PIDFD,SEC} to AF_{UNIX,NETLINK,BLUETOOTH}.
>> +tcp: Restrict SO_TXREHASH to TCP socket.
>> +scm: Move scm_recv() from scm.h to scm.c.
>> +af_unix: Don't pass struct socket to maybe_add_creds().
>> +af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
>>
>> I haven't dug into it, gotta review / apply other patches :(
>> Maybe you can try to repro? 
> 
> I think I was able to reproduce it with SO_PASSRIGHTS series
> with virtme-ng (but not with normal qemu with AL2023 rootfs).
> 
> After 2min, virtme-ng showed the console.
> 
> [    1.461450] virtme-ng-init: triggering udev coldplug
> [    1.533147] virtme-ng-init: waiting for udev to settle
> [  121.588624] virtme-ng-init: Timed out for waiting the udev queue being empty.
> [  121.588710] virtme-ng-init: udev is done
> [  121.593214] virtme-ng-init: initialization done
>           _      _
>    __   _(_)_ __| |_ _ __ ___   ___       _ __   __ _
>    \ \ / / |  __| __|  _   _ \ / _ \_____|  _ \ / _  |
>     \ V /| | |  | |_| | | | | |  __/_____| | | | (_| |
>      \_/ |_|_|   \__|_| |_| |_|\___|     |_| |_|\__  |
>                                                 |___/
>    kernel version: 6.15.0-rc4-virtme-00071-gceba111cf5e7 x86_64
>    (CTRL+d to exit)
> 
> 
> Will investigate the cause.
> 
> Sorry, but please drop the series and kick the CI again.

FTR I think some CI iterations survived the boot and hit the following,
in several forwarding tests (i.e. router-multipath-sh)

[  922.307796][ T6194] =============================
[  922.308069][ T6194] WARNING: suspicious RCU usage
[  922.308339][ T6194] 6.15.0-rc5-virtme #1 Not tainted
[  922.308596][ T6194] -----------------------------
[  922.308860][ T6194] ./include/net/addrconf.h:347 suspicious
rcu_dereference_check() usage!
[  922.309352][ T6194]
[  922.309352][ T6194] other info that might help us debug this:
[  922.309352][ T6194]
[  922.310105][ T6194]
[  922.310105][ T6194] rcu_scheduler_active = 2, debug_locks = 1
[  922.310501][ T6194] 1 lock held by ip/6194:
[  922.310704][ T6194]  #0: ffff888012942630
(&tb->tb6_lock){+...}-{3:3}, at: ip6_route_multipath_add+0x743/0x1450
[  922.311255][ T6194]
[  922.311255][ T6194] stack backtrace:
[  922.311577][ T6194] CPU: 1 UID: 0 PID: 6194 Comm: ip Not tainted
6.15.0-rc5-virtme #1 PREEMPT(full)
[  922.311583][ T6194] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  922.311585][ T6194] Call Trace:
[  922.311589][ T6194]  <TASK>
[  922.311591][ T6194]  dump_stack_lvl+0xb0/0xd0
[  922.311605][ T6194]  lockdep_rcu_suspicious+0x166/0x270
[  922.311619][ T6194]  rt6_multipath_rebalance.part.0+0x70c/0x8a0
[  922.311628][ T6194]  fib6_add_rt2node+0xa36/0x2c00
[  922.311668][ T6194]  fib6_add+0x38d/0xec0
[  922.311699][ T6194]  ip6_route_multipath_add+0x75b/0x1450
[  922.311753][ T6194]  inet6_rtm_newroute+0xb2/0x120
[  922.311795][ T6194]  rtnetlink_rcv_msg+0x710/0xc00
[  922.311819][ T6194]  netlink_rcv_skb+0x12f/0x360
[  922.311869][ T6194]  netlink_unicast+0x449/0x710
[  922.311891][ T6194]  netlink_sendmsg+0x721/0xbe0
[  922.311922][ T6194]  ____sys_sendmsg+0x7aa/0xa10
[  922.311954][ T6194]  ___sys_sendmsg+0xed/0x170
[  922.312031][ T6194]  __sys_sendmsg+0x108/0x1a0
[  922.312061][ T6194]  do_syscall_64+0xc1/0x1d0
[  922.312069][ T6194]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  922.312074][ T6194] RIP: 0033:0x7f8e77c649a7
[  922.312078][ T6194] Code: 0a 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff
eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00
00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89
74 24 10
[  922.312081][ T6194] RSP: 002b:00007ffd73480708 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
[  922.312086][ T6194] RAX: ffffffffffffffda RBX: 0000000000000001 RCX:
00007f8e77c649a7
[  922.312088][ T6194] RDX: 0000000000000000 RSI: 00007ffd73480770 RDI:
0000000000000005
[  922.312090][ T6194] RBP: 00007ffd73480abc R08: 0000000000000038 R09:
0000000000000000
[  922.312092][ T6194] R10: 000000000b9c6910 R11: 0000000000000246 R12:
00007ffd73481a80
[  922.312094][ T6194] R13: 00000000682562aa R14: 0000000000498600 R15:
00007ffd7348499b
[  922.312108][ T6194]  </TASK>

see:

https://netdev.bots.linux.dev/contest.html?branch=net-next-2025-05-15--03-00&executor=vmksft-forwarding-dbg&pw-n=0&pass=0

Thanks,

Paolo


