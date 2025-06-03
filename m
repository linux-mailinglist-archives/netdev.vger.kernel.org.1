Return-Path: <netdev+bounces-194825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE6DACCCDA
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 20:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F033A20C8
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C39288C20;
	Tue,  3 Jun 2025 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmhVf85F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93071288C0E;
	Tue,  3 Jun 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975108; cv=none; b=ITpUgfnR3Xt0+neSwH8G275Tton5hf+1KFN9UiiizwYbZ3YuXDGJCxpc756KjdJrXQlYcJKn4Z3jPaMIQTOaJrKghw4rAjng7bjE267mfTktcZU05NIdjn0AvVyNiYTFipNsIzjk8FdT2+JaZRuDnZSKzyR92FxABT/V3/T1ghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975108; c=relaxed/simple;
	bh=1U3f20QhgYmsMJ3kMLROVWXi2OD8UiSgQb9+mJE+C8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCvGkdkFwqlGupD3ndsu1gddKAnujst3QjDmOi++GmJnwKyXwHmLNci6QCWi50G0KkULkwcnhIkYc5HBeQXhbXShf32JIvwepNw0/sN50OxTPDWNkwzfO12vHmanRBvgUcdsHrDZ7cDNST92ozCIViGQ2+nDc2s2QoAprWTN5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmhVf85F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234d3261631so40523165ad.1;
        Tue, 03 Jun 2025 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748975106; x=1749579906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=isnLKnr3g2IvClfMqoRL8xobG9FmrWiy4TH6lGqYqNI=;
        b=BmhVf85FLp5zRKp0hiHQaclyD2KJvLMbU5durztN+6byqeWL6f+DnKaW2JwIMIYn5H
         S9BNeW7ispybmCtQrD4dzfi8ppqdzyd22tfO6+ICobjX8mO7/+o/kau1Vakhm07C2+/s
         qlp3a+GcrBiUxswuqgsFlay29tX637xeKzl4wSTsyDkNuf3+m1iqHYQXito2ONm6vSqp
         vDRj8cCYEFBvk4o+JwTVm7uqaiLzX2Frh+D67L00U64uRJMC34cBPmi7ldPvkMy54rgJ
         Bdxih4DDWArI4APAGExVfgVG3qdCjR1RQQjkYYKuZigZq43kMGLxTSouZOgUSmj8pMFA
         ZZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975106; x=1749579906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isnLKnr3g2IvClfMqoRL8xobG9FmrWiy4TH6lGqYqNI=;
        b=CYEydnGCnOiHJjB3nU+Yac16gcedaPVxGP9EjXUW4zpMBSGlQmZSSPyROwcONn6aZe
         qUtAhbGenS2iYK6FV4VN1XE30O9OgNGeVBTymahoZDrxLbvEflYyJUU8g/hLw/12J3gI
         vS0kd48WuwOQcd73mPB7OKB6NNhGpHGPxzwZ+MbhkGRPyMRZZRGyJ3on+7MtgVqKA4cK
         zHchqJhondPg6lCEr5KETfTmY0hXT/X0WX1vqMjZTmbV0RruUqf7Ep7fDKJVDoyWvXz+
         8G612hlrYxOEEgkujDw2wk6iTnIUDhlg9FrMofQidWZ5/kRnek1WjR6E2Ad837IenJ2G
         XVeA==
X-Forwarded-Encrypted: i=1; AJvYcCVRUZ9SgVRMwcq9QTVwD835Xa60E8pvbOZFq5A7Z8BnlhNbDmSKQ6acIlJKzyv8vwkZhjbNK1Egw4Nz8Ps=@vger.kernel.org, AJvYcCVj7ghrO9eIVIxxHyeEysK3V7Alfo/PJyNUSAmm+lARDx4AqKXr158XRSU3LuDqFNZa+3WEQo1i@vger.kernel.org
X-Gm-Message-State: AOJu0YxThqUufzkIUU9b70m6jAvhYDWk4FZyyjzNSqG+jskIA88liNsM
	OKpatQcMvxat2wZ9m/caYlpT1Y8u/aKFlOvxX8sU2MSVLFZq4GWnk5+0tgUt
X-Gm-Gg: ASbGncsVvrdUSeHaTXw8I/3OCdd2l1fkK2WWr29YlUC8vqsH0WylDJwYGosNDWDk8Af
	9g+7Y8e9RTeVvMrG9eGuScj5e20LfTeUqFAf7/RuSv9TDQOtSPPaZEJFaXiyt37jKqimoY+ghgg
	wzRHDDaYGnuipNppF5kTnyNerD3fypxbelMPp0mfaUnMi2cB3EXXO4V4zC4h7xgPuvl9cN3bXOA
	i6mu8KcerZ10igd0DnuEuOUCnZKmQ6m+Kz1MlJl5GD+tIUxE4EupOpitcYykY96mzpepWnF78Ex
	ITLNMzbgnRmU2ZZ7oZBX916u5HuGTlDqvldpvi8hASB9Er6VqJHCvSrsNFrRXMRjR4Xck/pxMps
	IkUnG3XyZ3+OEWcd8wBhUzDxoJbLq4j4ODA==
X-Google-Smtp-Source: AGHT+IE0ULE/TBdkpjLtcTf7FJAYX62k72Q5f7IeBE6IzSqnZ1/L0dWtG8rhFCNrP9yr7cVlkMTmOg==
X-Received: by 2002:a17:902:d2cf:b0:234:bfcb:5c21 with SMTP id d9443c01a7336-235390e3a8amr278841435ad.19.1748975105488;
        Tue, 03 Jun 2025 11:25:05 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506bc8612sm90464125ad.28.2025.06.03.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:25:05 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:25:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
Message-ID: <aD8-ANDt1JZELMYw@mini-arch>
References: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
 <aD5Sfmu0qXuskU-q@mini-arch>
 <d74f610d-679a-4cb2-804b-8c4c40260143@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d74f610d-679a-4cb2-804b-8c4c40260143@redhat.com>

On 06/03, Paolo Abeni wrote:
> On 6/3/25 3:40 AM, Stanislav Fomichev wrote:
> > On 06/02, syzbot wrote:
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    7d4e49a77d99 Merge tag 'mm-nonmm-stable-2025-05-31-15-28' ..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1298600c580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ea0d63949bc4278
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
> >> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/eb4b617767b5/disk-7d4e49a7.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/d0be53c5da74/vmlinux-7d4e49a7.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/9a5769a0ff61/bzImage-7d4e49a7.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
> >>
> >> netdevsim netdevsim1 netdevsim0: unset [0, 0] type 1 family 0 port 8472 - 0
> >> netdevsim netdevsim1 netdevsim0: unset [1, 0] type 2 family 0 port 6081 - 0
> >> ============================================
> >> WARNING: possible recursive locking detected
> >> 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 Not tainted
> >> --------------------------------------------
> >> syz.1.2750/15558 is trying to acquire lock:
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10549 [inline]
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
> >>
> >> but task is already holding lock:
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
> >> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
> >> and the lock comparison function returns 0:
> >>
> >> other info that might help us debug this:
> >>  Possible unsafe locking scenario:
> >>
> >>        CPU0
> >>        ----
> >>   lock(&dev_instance_lock_key#20);
> >>   lock(&dev_instance_lock_key#20);
> >>
> >>  *** DEADLOCK ***
> >>
> >>  May be due to missing lock nesting notation
> >>
> >> 2 locks held by syz.1.2750/15558:
> >>  #0: ffffffff8f50b248 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x1d0/0x1990 net/ethtool/ioctl.c:3489
> >>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> >>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
> >>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
> >>
> >> stack backtrace:
> >> CPU: 0 UID: 0 PID: 15558 Comm: syz.1.2750 Not tainted 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 PREEMPT(full) 
> >> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> >> Call Trace:
> >>  <TASK>
> >>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >>  print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3044
> >>  check_deadlock kernel/locking/lockdep.c:3096 [inline]
> >>  validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3898
> >>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
> >>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >>  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >>  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
> >>  netdev_lock include/linux/netdevice.h:2756 [inline]
> >>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >>  netdev_sync_lower_features net/core/dev.c:10549 [inline]
> >>  __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
> >>  netdev_change_features+0x72/0xd0 net/core/dev.c:10791
> >>  bond_compute_features+0x615/0x680 drivers/net/bonding/bond_main.c:1614
> >>  bond_slave_netdev_event drivers/net/bonding/bond_main.c:4112 [inline]
> >>  bond_netdev_event+0x72e/0xe80 drivers/net/bonding/bond_main.c:4157
> >>  notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
> >>  call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
> >>  call_netdevice_notifiers net/core/dev.c:2282 [inline]
> >>  netdev_features_change+0x85/0xc0 net/core/dev.c:1571
> >>  __dev_ethtool net/ethtool/ioctl.c:3457 [inline]
> >>  dev_ethtool+0x1520/0x1990 net/ethtool/ioctl.c:3490
> >>  dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:758
> >>  sock_do_ioctl+0x22c/0x300 net/socket.c:1204
> >>  sock_ioctl+0x576/0x790 net/socket.c:1311
> >>  vfs_ioctl fs/ioctl.c:51 [inline]
> >>  __do_sys_ioctl fs/ioctl.c:907 [inline]
> >>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
> >>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> RIP: 0033:0x7fa86e38e969
> >> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> >> RSP: 002b:00007fa86b98f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> >> RAX: ffffffffffffffda RBX: 00007fa86e5b6320 RCX: 00007fa86e38e969
> >> RDX: 0000200000000080 RSI: 0000000000008946 RDI: 0000000000000006
> >> RBP: 00007fa86e410ab1 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> >> R13: 0000000000000000 R14: 00007fa86e5b6320 R15: 00007fa86e6dfa28
> >>  </TASK>
> >>
> >>
> >> ---
> >> This report is generated by a bot. It may contain errors.
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
> >> syzbot engineers can be reached at syzkaller@googlegroups.com.
> >>
> >> syzbot will keep track of this issue. See:
> >> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >>
> >> If the report is already addressed, let syzbot know by replying with:
> >> #syz fix: exact-commit-title
> >>
> >> If you want to overwrite report's subsystems, reply with:
> >> #syz set subsystems: new-subsystem
> >> (See the list of subsystem names on the web dashboard)
> >>
> >> If the report is a duplicate of another one, reply with:
> >> #syz dup: exact-subject-of-another-report
> >>
> >> If you want to undo deduplication, reply with:
> >> #syz undup
> > 
> > I'll keep poking this, but I hope to get a reproducer at some point.
> > The features are evidently changed on the slave device (since it's the
> > netdevsim who's lock is grabbed twice), but I can't understand which
> > ethtool call leads to it.
> 
> FWIW, looking at the console log, the program that triggered the splat is:
> 
> 447.453794ms ago: executing program 1 (id=2750):
> bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, 0x0, 0x0)
> syz_emit_ethernet(0x4a, &(0x7f0000000080)={@local, @link_local={0x1,
> 0x80, 0xc2, 0x0, 0x0, 0xe}, @void, {@ipv4={0x800, @tcp={{0x5, 0x4, 0x0,
> 0x0, 0x3c, 0x0, 0x0, 0x0, 0x6, 0x0, @rand_addr=0x64010102, @local},
> {{0x4001, 0x0, 0x41424344, 0x41424344, 0x0, 0x6, 0xa, 0x0, 0x1, 0x0,
> 0x0, {[@md5sig={0x13, 0x12, "473ecfd2106a00"}]}}}}}}}, 0x0)
> socketpair$unix(0x1, 0x3, 0x0,
> &(0x7f0000000080)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
> openat$audio(0xffffff9c, 0x0, 0x402, 0x0)
> connect$unix(r0, &(0x7f000057eff8)=@abs, 0x6e)
> sendmmsg$unix(r1, &(0x7f00000bd000), 0x318, 0x0)
> recvmmsg(r0, &(0x7f00000000c0), 0x10106, 0x2, 0x0)
> prctl$PR_SCHED_CORE(0x3e, 0x1, 0x0, 0x2, 0x0)
> socket$netlink(0x10, 0x3, 0xe)
> sendmsg(r1, &(0x7f0000000180)={0x0, 0x0, 0x0}, 0x0)
> sched_setattr(0x0, &(0x7f0000000100)={0x38, 0x5, 0x0, 0x0, 0x0, 0xb49,
> 0x9, 0x8, 0x0, 0x3}, 0x0)
> bpf$MAP_CREATE(0x0, 0x0, 0x0)
> socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000240)={0xffffffffffffffff,
> <r2=>0xffffffffffffffff})
> ioctl$sock_SIOCETHTOOL(r2, 0x8946, &(0x7f0000000080)={'netdevsim0\x00',
> &(0x7f0000000000)=@ethtool_sfeatures={0x3b, 0x2, [{0xfe}, {0xfffffff9}]}})
> bpf$PROG_LOAD(0x5, 0x0, 0x0)
> r3 = socket$netlink(0x10, 0x3, 0x10)
> socketpair$unix(0x1, 0x3, 0x0, 0x0)
> getsockopt$sock_cred(r3, 0x1, 0x11, &(0x7f0000000180)={0x0, <r4=>0x0,
> <r5=>0x0}, &(0x7f0000000240)=0xc)
> bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f00000006c0)={0x1, 0x4, 0x0,
> &(0x7f0000000040)='GPL\x00', 0x8, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x0,
> 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0x0, 0x10, 0x203, @void, @value}, 0x94)
> r6 = syz_open_dev$sndctrl(&(0x7f0000000000), 0x1, 0x0)
> ioctl$SNDRV_CTL_IOCTL_ELEM_READ(r6, 0xc4c85512, &(0x7f0000000280)={{0x6,
> 0x0, 0x0, 0x0, 'syz0\x00'}, 0x0, [0x0, 0x0, 0x0, 0xffffffffffffffff,
> 0xffffffefffffffff, 0x0, 0x3, 0x0, 0x0, 0x4, 0x0, 0x0,
> 0xffffffffbfffffff, 0x0, 0x0, 0x0, 0x3, 0x80000000, 0x3, 0x0, 0x0, 0x4,
> 0x0, 0x6, 0x0, 0x40, 0x0, 0xfffffffffffffffd, 0x100200000, 0x0, 0x0,
> 0x8, 0x0, 0x0, 0x9, 0x0, 0x10000, 0x1000, 0x0, 0x3, 0xfffffffffffffffd,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x0, 0x7, 0x10000, 0x7785, 0x0, 0x4,
> 0x4, 0x8, 0x0, 0xfffffffffffffffe, 0x0, 0x8, 0x0, 0x0, 0x80000000000,
> 0x0, 0x4, 0x0, 0xfffffffffffffffe, 0x0, 0x0, 0x0, 0xfffffffffffffffe,
> 0x0, 0x4000000000, 0x0, 0x80000000000000, 0x0, 0xfffffffffffffffc, 0x0,
> 0x0, 0xfffffffffffffffe, 0x0, 0x2000, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0xfffffffffffffffd, 0x0, 0x0, 0x0, 0x100, 0x0, 0xfffffffffffffffd, 0x0,
> 0x0, 0x0, 0x2, 0x0, 0x0, 0x3, 0x2, 0x0, 0x0, 0xc0c0, 0x0, 0x0, 0x0, 0x0,
> 0x1, 0x0, 0x3, 0x0, 0xffffffffffeffffc, 0x0, 0x8000000000001, 0x0, 0x0,
> 0x0, 0x0, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x20000000, 0x0, 0x80]})
> bind$netlink(r3, &(0x7f0000514ff4)={0x10, 0x0, 0x2, 0x2ff7afedf}, 0xc)
> mmap(&(0x7f0000000000/0xb36000)=nil, 0xb36000, 0xb635773f06ebbeee,
> 0x8031, 0xffffffffffffffff, 0x0)
> mlock(&(0x7f0000000000/0x800000)=nil, 0x800000)
> madvise(&(0x7f0000000000/0x600000)=nil, 0x600003, 0x19)
> mount$fuse(0x0, 0x0, &(0x7f0000002100), 0x0, &(0x7f00000008c0)={{},
> 0x2c, {'rootmode', 0x3d, 0x4000}, 0x2c, {'user_id', 0x3d, r4}, 0x2c, {},
> 0x2c, {[{@blksize={'blksize', 0x3d, 0x1000}}, {@max_read={'max_read',
> 0x3d, 0x3}}, {@blksize={'blksize', 0x3d, 0x1000}},
> {@max_read={'max_read', 0x3d, 0x3}}, {@blksize={'blksize', 0x3d,
> 0x1400}}, {@blksize}]}})
> read$FUSE(0xffffffffffffffff, &(0x7f0000006380)={0x2020, 0x0, 0x0, 0x0,
> <r7=>0x0}, 0x2020)
> r8 = socket(0x10, 0x2, 0x0)
> ioctl$KVM_SET_PIT(0xffffffffffffffff, 0x4048aec9,
> &(0x7f0000000080)={[{0x80000000, 0x0, 0x0, 0x3, 0x0, 0x10, 0x6, 0x0,
> 0x2, 0x0, 0xa, 0x0, 0x4}, {0xa, 0x0, 0x0, 0x0, 0x40, 0x1, 0x8, 0xff,
> 0x7, 0x0, 0x4, 0x0, 0xfffffffffffffff7}, {0x200000, 0xc, 0x21, 0x53,
> 0x0, 0x2, 0x0, 0x0, 0x58, 0xb, 0x0, 0x0, 0x8080}], 0x3fb})
> sendmsg$nl_route(r8, &(0x7f0000000140)={0x0, 0x0,
> &(0x7f0000000100)={&(0x7f0000000780)=ANY=[@ANYBLOB="2ea8d2811b2a246ba8a8a78787aee7bb20c96807b6d8761f859ec6fa331e777591ed11248a94c0cfc19c61fe7c081ddaf685d4d5b414a01ac8d511cfb5d75e8878514da879142e585b1f9213b0f04d67baae20dd2e742f1286afc7a9bb0ad44aa05e2e3db382651792f2945409e7c6dda83d14fef1fb50a3cb8d0a189d28277f501a04c5d4414479db27bd23c1fbdf28124c317129fe42ebf9",
> @ANYRES8, @ANYRES64, @ANYRESOCT=r2, @ANYRES32, @ANYRES16=r7,
> @ANYRESDEC=r5], 0x30}, 0x1, 0x0, 0x0, 0xc885}, 0x4000880)
> 
> and the suspect ethtool operation should be:
> 
> ioctl$sock_SIOCETHTOOL(r2, 0x8946, &(0x7f0000000080)={'netdevsim0\x00',
> &(0x7f0000000000)=@ethtool_sfeatures={0x3b, 0x2, [{0xfe}, {0xfffffff9}]}})
> 
> Since syzkaller has no reproducer, I guess the splat depends on some
> additional state/race, but I don't see how/where the lower -> bond ->
> lowers features update chain is (should be) interrupted to break this
> double lock.

Yes, thanks, I've seen it as well. It flips 3 lower feature bits which
should not affect lro (the only bit we sync) :-(

