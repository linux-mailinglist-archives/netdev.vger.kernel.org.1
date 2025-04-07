Return-Path: <netdev+bounces-179765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8660DA7E7B7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FF31899AF2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D12144C8;
	Mon,  7 Apr 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7nJZdcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEE4879B
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045044; cv=none; b=sdBnNzzxBfNtsesTkKrNeDFMICpu+ONlrL2Sp6PLtRuAT9wGA6dxTp+bX4ZLsNz52Mn2LHoysmyzpRAoxch3QBb27fwjb3Vv78/5ChfDA0G/Df53c1k7wS3Ss82rR5LM+Dp4ApIwfAr0EprpDdnEwMrOLjEd2lgQIwQruuzlSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045044; c=relaxed/simple;
	bh=xavmz/HAokZzT87/ICDfarP0MdbzGAYxW789N0zQSwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eos6uEnRXfNZxV/LU0bpoiU8Y+sGivS3s3QSyitw1+Ui449+hz1GZ2caSjQGVtevrc7jZc/NmPpm6D7jYg/4OVIhBP7xDHh8NB0vT0SCzxC1pN9Z+mjWd+PV5PygQPyAulw3XdAKa9RpppenJuJUwxwyuujmDlnAep241it2esM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7nJZdcM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223f4c06e9fso41715305ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744045042; x=1744649842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjN3AtqnRZmTtL8CjWIY99mZuRYU5a+XRqA80N2gGrM=;
        b=j7nJZdcMJi86P8S/oyxD8vUnCzYvF3mVV6+OXy4xl3WvSSuL5kBI1iFbclwTlw6Jb1
         33jtbx/vw2PEMY26cTUNZjqBA/F/LLrIird5NYavi28fQtufXtX8jJPL64lMfcS+YKvI
         spgA4d4C8zeXtNQ0LwNvJvpk2S81Qn5TcuZPww2esiF3CDDPLv0lO/u36VQDudi75yUo
         NgDO9FjRm05dqG4vZASSFxkCDsRHUB+fVDZoThdGcN0jY1TKhwVnLjl3c8Fd890DHHu5
         wUhbM2Om7GH2JDxXoFCkxg81rY/UWCvZWFjG6zEL8RX1/SmQhX3SR6eFkoyiN36G9Yu5
         cKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744045042; x=1744649842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjN3AtqnRZmTtL8CjWIY99mZuRYU5a+XRqA80N2gGrM=;
        b=kKJj5hl4bNP0mycm7hSRMwiAoyX3lVj4hXnT+OC57LPZ3AsvkbhAXk4NKuG3+va3A5
         MoVXqCUETcGg6tf7Va4ph7fmYMnrWtEoJnLgMO/VJljpNteXUO4ZzhxZJrq0pOm7NqAA
         0sOTG6W1EPxP419Htiky1QOHa9d7uq8m24hf/vPJk4pMx7vo6Mq0G79PORVXgTGsVTRT
         98pXTiaKTT0GBDBQBH3WSzsV4QVniHOpHWzOcQDOfk5VUputdo4XYhoXgtlobY1pOWml
         eTpqeFUjP86wSpsuCZ3rTJuP94j8ceSxxwDgjCvUOh22X9s3UljuF0qK/CW+rtbnukYT
         o8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX9w0Hvvop7Jugzj8cwsqtuQDRQgfOj4D5x93djBA90I9sYm05WooPM354feVbYkHO/wb6JvIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSAdQw1vOQGOJsfyh16ozUgmbp/zvmgBXNoHG+ZKqkoclD+DI
	TdLc+n72zuZ45c8dsURsZa+z4dxIcv7a8Bkj0tdKMixR2tdjbFQ=
X-Gm-Gg: ASbGncuY7Vu6q8xWm9EAHDJ8+pK+dER1loxHpy1zCfENKfFvCQ3JBBBIjKWK8UGucPW
	o0PTCmyK5Ygq2mqMsaJ5UzPw7WcAd4fJcB0PTIjZ0d7T5nKvCcSk/VpsFfmvxiyLfx9OfTbPuFP
	1CFAg70ryL2MgoB9GHbUfW9oZd54JcgL/e71TmI8Nzjop32y32/AhOTU6HFhE2qOuLShBz5hzgQ
	E7vmRsPlE3mSJKRtq7tGLFb9XXgt/4W67Q+Lw50IyN1SxWPca5Is4sKI4/y/OO2pgcl19X0SS5C
	eg6x8+WRECx+s29Yj3qHQxxFq5zsuTMMZ+ouJkaYOhyV
X-Google-Smtp-Source: AGHT+IEXHuh4nUJQHvgcnTBT5ZfLB5zHUwrruKt4E+2QQo2ck+e1uxd+zA60zlTOv4yqoe5vBwHN3g==
X-Received: by 2002:a17:902:f686:b0:21f:1348:10e6 with SMTP id d9443c01a7336-22ab5e377e0mr2700745ad.13.1744045042123;
        Mon, 07 Apr 2025 09:57:22 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-229787728cfsm83641225ad.228.2025.04.07.09.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:57:21 -0700 (PDT)
Date: Mon, 7 Apr 2025 09:57:20 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] rtnetlink: Fix bad unlock balance in do_setlink().
Message-ID: <Z_QD8CX_M1ISSC0b@mini-arch>
References: <20250407164229.24414-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407164229.24414-1-kuniyu@amazon.com>

On 04/07, Kuniyuki Iwashima wrote:
> When validate_linkmsg() fails in do_setlink(), we jump to the errout
> label and calls netdev_unlock_ops() even though we have not called
> netdev_lock_ops() as reported by syzbot.  [0]
> 
> Let's return an error directly in such a case.
> 
> [0]
> WARNING: bad unlock balance detected!
> 6.14.0-syzkaller-12504-g8bc251e5d874 #0 Not tainted
> 
> syz-executor814/5834 is trying to release lock (&dev_instance_lock_key) at:
> [<ffffffff89f41f56>] netdev_unlock include/linux/netdevice.h:2756 [inline]
> [<ffffffff89f41f56>] netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
> [<ffffffff89f41f56>] do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 1 lock held by syz-executor814/5834:
>  #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd68/0x1fe0 net/core/rtnetlink.c:4064
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 5834 Comm: syz-executor814 Not tainted 6.14.0-syzkaller-12504-g8bc251e5d874 #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_unlock_imbalance_bug+0x185/0x1a0 kernel/locking/lockdep.c:5296
>  __lock_release kernel/locking/lockdep.c:5535 [inline]
>  lock_release+0x1ed/0x3e0 kernel/locking/lockdep.c:5887
>  __mutex_unlock_slowpath+0xee/0x800 kernel/locking/mutex.c:907
>  netdev_unlock include/linux/netdevice.h:2756 [inline]
>  netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
>  do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
>  rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
>  rtnl_newlink+0x1619/0x1fe0 net/core/rtnetlink.c:4065
>  rtnetlink_rcv_msg+0x80f/0xd70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:727
>  ____sys_sendmsg+0x523/0x860 net/socket.c:2566
>  ___sys_sendmsg net/socket.c:2620 [inline]
>  __sys_sendmsg+0x271/0x360 net/socket.c:2652
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f8427b614a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff9b59f3a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fff9b59f578 RCX: 00007f8427b614a9
> RDX: 0000000000000000 RSI: 0000200000000300 RDI: 0000000000000004
> RBP: 00007f8427bd4610 R08: 000000000000000c R09: 00007fff9b59f578
> R10: 000000000000001b R11: 0000000000000246 R12: 0000000000000001
> R13:
> 
> Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
> Reported-by: syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=45016fe295243a7882d3
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

