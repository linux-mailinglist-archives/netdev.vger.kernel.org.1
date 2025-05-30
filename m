Return-Path: <netdev+bounces-194407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC249AC94B4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7071BC52B4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A312367C1;
	Fri, 30 May 2025 17:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB52367AF
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626026; cv=none; b=nZUf+/oVW88nwjvZzAXx0ETIichRPy058V+v9qXGEdpGmZ4/DfRAE3RP+oyxCOFGn4lm+wZEe2CFG6dh6hjXzhz14gxpqfzwvD2zM/1PykqmJzDCdTzd0RLbbwTPPczpLJLFgz2lqLbbZhftHRBWUe5XxtbHm/szfOWjhnSiXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626026; c=relaxed/simple;
	bh=QnFT4UTcUmVIF557XHeZIxprQLC4uimKa9zu22sXfkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=StsB+VG41qdPYRtFCNjR9PQ8VeN1pgAbgtptIJGHpUe2QBuY84Jvo0KM5qyNFkN4Sm9CQYjulCdFQkQJXrwDITgi2/SEu/PdkPtXZ7ls342sZW+ay13hyvgQZf8A5m0jH3BmBcDY6RYNxiueJFQg8gCeo6y3YQ76HK11P6R5hAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3dd81f9ce43so25014275ab.0
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748626024; x=1749230824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEnE3UPKhcy+AwEGJgtE9Olu+DiLoFVrDFd7ZrO9MFg=;
        b=GfF9C55F5cwj4fhdZjobIZV6j6U7O1m7frgFfOIGOcZyddG4ESSHlKcPwqehdbY/CB
         SG4KtjyiRf+GORcNNmlx64OtfOpUQREbtsN/7NDgZ/T98A2RswR+lKIUt2wbHj7Bs+4q
         5rVEHFtFjWWo0yWppCW/mcOovt9JjqK9NPqZwOGz0a3aT+rVzYB1BrN3uWVrTGotrlQO
         O7ntBx48eyopB7CzQ5VuzPsitIRPbBNoxoA44xo+N8TMl/6URpkSncC4VHyoD4nCgse5
         XOvtbZFX8C3U/WRgpVSbV7ydzjA1UE4kwD6g0BKzOrdSGbhoWFcMzrKXb7MWi5twdcnq
         X3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUKvCXlE2tQoGTprpqrk7eOjMC3sMo/rIJXKc2L+9ZM3NyWRw9GHYW94VR2PrqvfB6E5vSatoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvB0ng/iYkSJpWCeXNyQy/f4Cy5rFNt8TrAsl4wwXmzewKxX9N
	th1xrbHva/oDsGRnyCI4mviGmccoHXU2gKLpMfPXts9BKg7lPOMSY9aj4qB5yGL7+BjkA3ZC0Mz
	ZSK6FTrgenm5g9SjGY5S9ZutH8+qUfGW7GH5K2mK7mIZpwarjMk+zmp5PbzQ=
X-Google-Smtp-Source: AGHT+IGLEwYnF4NLSDCGONGXRq9cSsMDPGPvX/rO+eobb5oy+6F/LXDkf3vpZt1ktE3onG9mjJtHCD8NWls3pJa9JWvUafFgsj94
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2789:b0:3d9:6cb6:fa52 with SMTP id
 e9e14a558f8ab-3dd99bf713dmr49207495ab.12.1748626023784; Fri, 30 May 2025
 10:27:03 -0700 (PDT)
Date: Fri, 30 May 2025 10:27:03 -0700
In-Reply-To: <87r006nj7e.fsf@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6839ea67.a00a0220.d8eae.000c.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in nsim_fib_event_nb
From: syzbot <syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com>
To: andrew@lunn.ch, charmitro@posteo.net, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for lo to become free. Usage count = 601
ref_tracker: lo@ffff888031d42610 has 600/600 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4330 [inline]
     netdev_tracker_alloc include/linux/netdevice.h:4342 [inline]
     netdev_get_by_index+0x79/0xb0 net/core/dev.c:1006
     fib6_nh_init+0x1c4/0x2030 net/ipv6/route.c:3590
     ip6_route_info_create_nh+0x139/0x870 net/ipv6/route.c:3866
     ip6_route_mpath_info_create_nh net/ipv6/route.c:5429 [inline]
     ip6_route_multipath_add net/ipv6/route.c:5544 [inline]
     inet6_rtm_newroute+0x8ca/0x1d90 net/ipv6/route.c:5729
     rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
     netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
     netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
     netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
     netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
     sock_sendmsg_nosec net/socket.c:712 [inline]
     __sock_sendmsg+0x219/0x270 net/socket.c:727
     ____sys_sendmsg+0x505/0x830 net/socket.c:2566
     ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
     __sys_sendmsg net/socket.c:2652 [inline]
     __do_sys_sendmsg net/socket.c:2657 [inline]
     __se_sys_sendmsg net/socket.c:2655 [inline]
     __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f



Tested on:

commit:         a5ecfdd9 ipv6: Fix ECMP validation for multipath routes
git tree:       https://github.com/charmitro/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1151bff4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1787205a40c165
dashboard link: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.

