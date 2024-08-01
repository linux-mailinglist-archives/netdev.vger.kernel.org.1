Return-Path: <netdev+bounces-115002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8853944E13
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88332281A6E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4801B14A093;
	Thu,  1 Aug 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="C54bSfmG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF691E4BE
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522694; cv=none; b=tMSTGeR6BjVXbNyB5HidCuIc2+nrPvtdhFFidSc61rjqEDrD3x+x8o/ruTqV1QjBtVidezjvIttWE5rtlPoIwyXdTdQUnck8JgymNXamVewVoEhnt0B6cOwmzfjbEPWp4LlU5OY46WWuM9UWkgtkprujP0zyBlEbsCL4IG/ErLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522694; c=relaxed/simple;
	bh=PXDYvbU7GH3VZGtv9v6mOnvGONlvnBj7L/QfhECgHgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRo0ajz6wNVpaHBRWRIxeYUbRoEtY5UEYhbxisiDY7gRZvYzCpAJ+y/Og/6Y7DFJeSqzJhgmfBUTfZiTIvGWxKoWVsQGZg+V9hWRj1cSsEw2fkgtXKLU4pXoonmdo6ydnf2qoz41QQ/Eucd1IOcVzq8qHVQC6aI2TnL51uOThJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=C54bSfmG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280c55e488so13461155e9.0
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722522689; x=1723127489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z3Lz3qosyEF32MTiE5xSgc58f9slmQkAz9tR4HPKQ7c=;
        b=C54bSfmGYI7/mWgIplPXz+/lSP+8KtlULtwkqsrTCgnlHkcErhutTFqOcfBFlZy4bZ
         UaIIX4Aiwj+3oY4fYYVdM6drkcuTzgYgu1TnJTkgfR9u8srG4J1Px27Tq3gQTtQTOpiG
         ZhrT8jO+Bcv5QT+NueJ1oU/3BX98ZUth4IAsFo6bhSWE/G2I7stssqqxGJjcgQ6IBrMQ
         /kpzJ7SdWa8oX+4zTQIBMFKaGgqrJJ0gWIoHJVBqJgzMZfyZyAwMqcE8EaGz0gUMzIDG
         6kE9qIx8TyU6DpNJ1DDa2OtVzAnVnZTrlFpKghfS4ZCQQxRRCRo1HwxqyYHzs2T9oWqF
         RddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522689; x=1723127489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Lz3qosyEF32MTiE5xSgc58f9slmQkAz9tR4HPKQ7c=;
        b=DEm4Ltfk03dN5pTyRu3esjbxenoo1LJ8M0qzfPFRPbIzIyhM/IaNkj/1lGTZMW+WDr
         hxL4V+ESh0Lc5OnrILoIuDD2tpp4oEC3iYjXTBZOlNiWgnE154I17atWiTW6eHhFoLX5
         STigVWgTVpN9UjNWbIQX8CaAOAEIFuELHNxnLf8+6z/hXgI23nhq0/UipNtlUCTOS4hd
         ksue64J/TJHnU14h+Lr1b42mw7YowyrvToOHwuLarwMueOTvhBadjyugwXa9FlC0ppr3
         hJwDP+D/joa2pfebKXL3KwWLH2bz1RI1cAmCBZS7LZwNxM2h/2/UbPt2GJLfRILIOuSc
         yzWw==
X-Forwarded-Encrypted: i=1; AJvYcCWd2rh3By6H+CEmU48CO6LMwkB8RHSd/b7Xu6FALAsN5L73pewzIyr0EwSA3RZE7IovVQ6BjzmBA9aKsmSwbJp35MjN/syP
X-Gm-Message-State: AOJu0YwwgOhDEXVVb9kOZC9lDT7qCxiIi076YkT/rkYtqGn1rGMBxhQQ
	M6Y7RdqJxAIVNV9vq5xfbj7A5ytk7LBsV/bTSF3JUCOHbu8b5QWsmz/eQIxw0O4=
X-Google-Smtp-Source: AGHT+IGb7HDwg2tDazTbE81+iJfYAqxNeJYAKw9dKzKWM2FBDjvWa5adRw+p6S0L9Qf7m5mqqu64tA==
X-Received: by 2002:a05:600c:138e:b0:424:71f7:77f2 with SMTP id 5b1f17b1804b1-428e47a0825mr17682225e9.16.1722522688520;
        Thu, 01 Aug 2024 07:31:28 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bab9f7esm58248585e9.21.2024.08.01.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:31:28 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:31:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: Jeongjun Park <aha310510@gmail.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, nicolas.dichtel@6wind.com,
	liuhangbin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net,v2] rtnetlink: fix possible deadlock in
 team_port_change_check
Message-ID: <ZqucPsGsnwZ2QOXa@nanopsycho.orion>
References: <20240731150940.14106-1-aha310510@gmail.com>
 <CANn89iJn8XT86yyvqD6ZZvjV7eAxBjUd6rddL6NNaXVRimOXhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJn8XT86yyvqD6ZZvjV7eAxBjUd6rddL6NNaXVRimOXhg@mail.gmail.com>

Thu, Aug 01, 2024 at 08:28:20AM CEST, edumazet@google.com wrote:
>On Wed, Jul 31, 2024 at 5:10 PM Jeongjun Park <aha310510@gmail.com> wrote:
>>
>> In do_setlink() , do_set_master() is called when dev->flags does not have
>> the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called,
>> which generates the NETDEV_UP event. This causes a deadlock as it tries to
>> acquire 'team->lock' again.
>>
>> To solve this, we need to unlock 'team->lock' before calling dev_open()
>> in team_port_add() and then reacquire the lock when dev_open() returns.
>> Since the implementation acquires the lock in advance when the team
>> structure is used inside dev_open(), data races will not occur even if it
>> is briefly unlocked.
>>
>> ============================================
>> WARNING: possible recursive locking detected
>> 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0 Not tainted
>> --------------------------------------------
>> syz.0.15/5889 is trying to acquire lock:
>> ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
>> ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
>>
>> but task is already holding lock:
>> ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975
>>
>> other info that might help us debug this:
>>  Possible unsafe locking scenario:
>>
>>        CPU0
>>        ----
>>   lock(team->team_lock_key#2);
>>   lock(team->team_lock_key#2);
>>
>>  *** DEADLOCK ***
>>
>>  May be due to missing lock nesting notation
>>
>> 2 locks held by syz.0.15/5889:
>>  #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>>  #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
>>  #1: ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975
>>
>> stack backtrace:
>> CPU: 1 UID: 0 PID: 5889 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:93 [inline]
>>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
>>  check_deadlock kernel/locking/lockdep.c:3061 [inline]
>>  validate_chain kernel/locking/lockdep.c:3855 [inline]
>>  __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
>>  lock_acquire kernel/locking/lockdep.c:5759 [inline]
>>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
>>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>>  __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>>  team_port_change_check drivers/net/team/team_core.c:2950 [inline]
>>  team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
>>  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
>>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
>>  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>>  call_netdevice_notifiers net/core/dev.c:2046 [inline]
>>  __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
>>  dev_change_flags+0x10c/0x160 net/core/dev.c:8914
>>  vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
>>  notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
>>  call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
>>  call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>>  call_netdevice_notifiers net/core/dev.c:2046 [inline]
>>  dev_open net/core/dev.c:1515 [inline]
>>  dev_open+0x144/0x160 net/core/dev.c:1503
>>  team_port_add drivers/net/team/team_core.c:1216 [inline]
>>  team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
>>  do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
>>  do_setlink+0x306d/0x4060 net/core/rtnetlink.c:2907
>>  __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
>>  rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
>>  rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
>>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
>>  netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
>>  netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
>>  netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
>>  sock_sendmsg_nosec net/socket.c:730 [inline]
>>  __sock_sendmsg net/socket.c:745 [inline]
>>  ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
>>  ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
>>  __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
>>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fc07ed77299
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fc07fb7f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> RAX: ffffffffffffffda RBX: 00007fc07ef05f80 RCX: 00007fc07ed77299
>> RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
>> RBP: 00007fc07ede48e6 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 000000000000000b R14: 00007fc07ef05f80 R15: 00007ffeb5c0d528
>>
>> Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
>> Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bringing it up"")
>> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>> ---
>>  drivers/net/team/team_core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
>> index ab1935a4aa2c..ee595c3c6624 100644
>> --- a/drivers/net/team/team_core.c
>> +++ b/drivers/net/team/team_core.c
>> @@ -1212,8 +1212,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
>>                            portname);
>>                 goto err_port_enter;
>>         }
>> -
>> +       mutex_unlock(&team->lock);
>
>Why would this be safe ?
>
>All checks done in team_port_add() before this point would need to be
>redone after mutex_lock() ?
>
>If another mutex (rtnl ?) is already protecting this path, this would
>suggest team->lock should be removed,
>and RTNL should be used in all needed paths.

I agree. The problem is, not all other paths rely on rtnl, they rely on
team->lock instead. I believe that the best solution is to remove
team->lock entirely.

I looked into it, the only problem I see is team_nl_fill_one_option_get()
function. That operates without rtnl being held. Taking rtnl here is too
heavy, given that it may be repeatedly used to fetch hash stats.
It's read only, could be probably converted to RCU. It's in my todo list,
once I have some spare cycles.




>
>>         err = dev_open(port_dev, extack);
>> +       mutex_lock(&team->lock);
>
>
>
>>         if (err) {
>>                 netdev_dbg(dev, "Device %s opening failed\n",
>>                            portname);
>> --

