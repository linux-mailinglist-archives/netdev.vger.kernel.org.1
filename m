Return-Path: <netdev+bounces-194714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE3ACC13F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4516B3A3FF9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 07:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB8B269B0D;
	Tue,  3 Jun 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaoWiPlM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC04B26988E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936070; cv=none; b=rHLUPDmm7HZUfXwe956MiH295rC0Eax8wBpcpwgMkq0tzFa87LIcKFmwEFLoAbREyfPVp3ZbrGQ6uxSBBdx32oZEUH4LyPZCp+N1ukEMEZQcIxoM0LmfVLaHRzaSZdqfgQAbCO+Cx5v+bpJqudAYiYooHFRoWYRJMdiX55GOutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936070; c=relaxed/simple;
	bh=rW9/yqGiV3S9x9WQao6qghKACpjIMMP8euSf951KQjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sqg5JHu4F/41ekJFASnucvaIT7plMZ3uxL2PHbf2p+MUxBXKr5h2KQugSxsKLa59oj94/kP4Uv8Uo/wrEpzEMtCajMeo9wtfpYsmJFXRFeNve3aG60ygiJ2xaJOJPslIuIWDaA2pb44hxheKfOLjE3+yvtxlHZVwHDYXHKgIlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TaoWiPlM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748936067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGZ8ov4IZxTG4JISCQwIvXH2B18I0oSFw28Pds6ZzE8=;
	b=TaoWiPlM8bwEozMGPrNL84FAe34ah7BmiuTmWKpHWkscv6+im0UXozIqo6ZOoDwQk4aSG8
	bIrxG/NKUmJYEUipWoiHtqHI4c5BtExeKVA51GlN66a8PmWZkjStAnkNkwISwf9RdwP2+M
	NucpH3LMFAzmx+8fw3KbPtrfLkCQPjg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-nncMIdLWMPqU4ExAUQv3Lw-1; Tue, 03 Jun 2025 03:34:26 -0400
X-MC-Unique: nncMIdLWMPqU4ExAUQv3Lw-1
X-Mimecast-MFC-AGG-ID: nncMIdLWMPqU4ExAUQv3Lw_1748936065
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ea7e46dfso1579444f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 00:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748936065; x=1749540865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGZ8ov4IZxTG4JISCQwIvXH2B18I0oSFw28Pds6ZzE8=;
        b=ZeW3kS4gRZo38N83+uNd35JZkiGDSIyA5gGR+C09EmH/d77OPF4c83zzwJ9+5reEtn
         SaxELbxKljUuOpMMpCUQaxfiGRewRMSX/WO2FIpHHg7Lve9/AMzNPUaltHBBePKhINXQ
         xjtFYly2v2alx5TgAxIiR9BhPUe+pDeezObaa+PAke6lnB5VNJNKh1B+cGin74t6OT/H
         3z03iAQVDBrWHoCHg9sQpCC/AppMQXU0BOTZ4u+NTDYgvrjvgXS3tam2PNqfPSqvGp+y
         4UmnZQ2Kcz8tL6YAenMPtPuT9YyopW3KJjEaApgi343ptdPLClsdfh7f4CrNdOAhXMIY
         PYkg==
X-Forwarded-Encrypted: i=1; AJvYcCWO7sD5Yv8DZCJvC8+4YWoX49cUHxunu4zIOvKMw0ebJY9kY9MA3SIF2Fdr0x3PKFwlswNpVys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbG+l7U2yi346tV8DaHsP25nP897bc5yU+HRZCL1TLKCP1WEq
	hyG4XoPhhY7fOWVWok1CMPDcLFYqDdKf8Qk79yOdp2L+W0F6WRiBIcPdMwYZ/yUXvgRbhiBJYDO
	UzGqThUvyh6R1qE4YYsC3GtPxauiegRKbGbYxPPdstcJjj5lPHu+fz+TpXA==
X-Gm-Gg: ASbGncttOacVCKdELBEHul7t1fOFsliUFnqIy1kHAzuZpmcccGQcWeb6hZ8nfAn36Zq
	yOybWyGlZkWmip9oxUbEHxH7Yb4d0QST/ndt080JFEyLbFqDL5uJGYMfmgGW1541seKYsdRPGUN
	tens704clDQ0DpCS1rpIKKsosFA8uwvHXvFuXc5QEQrsHIyYsFZVihE71OLNJld7//2bnFKk6Dx
	g3Eyq4Bt25+YvGWSdL4CcF8tfWUo5lgukXluf1ArSotGzo2W7iLuaXMzIwuo/fznW2I2lbBiz9c
	3VB9N+v90kelzbr1VHlqwDOLvTsVe7ZtYJbV6t7JJkbEDFXtCGgQQk6T
X-Received: by 2002:a05:6000:2303:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a4f89dcc3amr10777711f8f.42.1748936064727;
        Tue, 03 Jun 2025 00:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGekbDNecdjQ6X2LglfERanw6xFXa9R4votcNrIbvinDs10plhgGJLYQyYNskjzw++qgcRa7w==
X-Received: by 2002:a05:6000:2303:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a4f89dcc3amr10777679f8f.42.1748936064264;
        Tue, 03 Jun 2025 00:34:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa27b4sm147958215e9.15.2025.06.03.00.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 00:34:23 -0700 (PDT)
Message-ID: <d74f610d-679a-4cb2-804b-8c4c40260143@redhat.com>
Date: Tue, 3 Jun 2025 09:34:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
To: Stanislav Fomichev <stfomichev@gmail.com>,
 syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
 <aD5Sfmu0qXuskU-q@mini-arch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aD5Sfmu0qXuskU-q@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 3:40 AM, Stanislav Fomichev wrote:
> On 06/02, syzbot wrote:
>> syzbot found the following issue on:
>>
>> HEAD commit:    7d4e49a77d99 Merge tag 'mm-nonmm-stable-2025-05-31-15-28' ..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1298600c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ea0d63949bc4278
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
>> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/eb4b617767b5/disk-7d4e49a7.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/d0be53c5da74/vmlinux-7d4e49a7.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/9a5769a0ff61/bzImage-7d4e49a7.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
>>
>> netdevsim netdevsim1 netdevsim0: unset [0, 0] type 1 family 0 port 8472 - 0
>> netdevsim netdevsim1 netdevsim0: unset [1, 0] type 2 family 0 port 6081 - 0
>> ============================================
>> WARNING: possible recursive locking detected
>> 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 Not tainted
>> --------------------------------------------
>> syz.1.2750/15558 is trying to acquire lock:
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10549 [inline]
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
>>
>> but task is already holding lock:
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
>> ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
>> and the lock comparison function returns 0:
>>
>> other info that might help us debug this:
>>  Possible unsafe locking scenario:
>>
>>        CPU0
>>        ----
>>   lock(&dev_instance_lock_key#20);
>>   lock(&dev_instance_lock_key#20);
>>
>>  *** DEADLOCK ***
>>
>>  May be due to missing lock nesting notation
>>
>> 2 locks held by syz.1.2750/15558:
>>  #0: ffffffff8f50b248 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x1d0/0x1990 net/ethtool/ioctl.c:3489
>>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
>>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
>>  #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
>>
>> stack backtrace:
>> CPU: 0 UID: 0 PID: 15558 Comm: syz.1.2750 Not tainted 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 PREEMPT(full) 
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
>> Call Trace:
>>  <TASK>
>>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>  print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3044
>>  check_deadlock kernel/locking/lockdep.c:3096 [inline]
>>  validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3898
>>  __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>>  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>>  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>>  netdev_lock include/linux/netdevice.h:2756 [inline]
>>  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
>>  netdev_sync_lower_features net/core/dev.c:10549 [inline]
>>  __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
>>  netdev_change_features+0x72/0xd0 net/core/dev.c:10791
>>  bond_compute_features+0x615/0x680 drivers/net/bonding/bond_main.c:1614
>>  bond_slave_netdev_event drivers/net/bonding/bond_main.c:4112 [inline]
>>  bond_netdev_event+0x72e/0xe80 drivers/net/bonding/bond_main.c:4157
>>  notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
>>  call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
>>  call_netdevice_notifiers net/core/dev.c:2282 [inline]
>>  netdev_features_change+0x85/0xc0 net/core/dev.c:1571
>>  __dev_ethtool net/ethtool/ioctl.c:3457 [inline]
>>  dev_ethtool+0x1520/0x1990 net/ethtool/ioctl.c:3490
>>  dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:758
>>  sock_do_ioctl+0x22c/0x300 net/socket.c:1204
>>  sock_ioctl+0x576/0x790 net/socket.c:1311
>>  vfs_ioctl fs/ioctl.c:51 [inline]
>>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7fa86e38e969
>> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007fa86b98f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 00007fa86e5b6320 RCX: 00007fa86e38e969
>> RDX: 0000200000000080 RSI: 0000000000008946 RDI: 0000000000000006
>> RBP: 00007fa86e410ab1 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 0000000000000000 R14: 00007fa86e5b6320 R15: 00007fa86e6dfa28
>>  </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
> 
> I'll keep poking this, but I hope to get a reproducer at some point.
> The features are evidently changed on the slave device (since it's the
> netdevsim who's lock is grabbed twice), but I can't understand which
> ethtool call leads to it.

FWIW, looking at the console log, the program that triggered the splat is:

447.453794ms ago: executing program 1 (id=2750):
bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, 0x0, 0x0)
syz_emit_ethernet(0x4a, &(0x7f0000000080)={@local, @link_local={0x1,
0x80, 0xc2, 0x0, 0x0, 0xe}, @void, {@ipv4={0x800, @tcp={{0x5, 0x4, 0x0,
0x0, 0x3c, 0x0, 0x0, 0x0, 0x6, 0x0, @rand_addr=0x64010102, @local},
{{0x4001, 0x0, 0x41424344, 0x41424344, 0x0, 0x6, 0xa, 0x0, 0x1, 0x0,
0x0, {[@md5sig={0x13, 0x12, "473ecfd2106a00"}]}}}}}}}, 0x0)
socketpair$unix(0x1, 0x3, 0x0,
&(0x7f0000000080)={<r0=>0xffffffffffffffff, <r1=>0xffffffffffffffff})
openat$audio(0xffffff9c, 0x0, 0x402, 0x0)
connect$unix(r0, &(0x7f000057eff8)=@abs, 0x6e)
sendmmsg$unix(r1, &(0x7f00000bd000), 0x318, 0x0)
recvmmsg(r0, &(0x7f00000000c0), 0x10106, 0x2, 0x0)
prctl$PR_SCHED_CORE(0x3e, 0x1, 0x0, 0x2, 0x0)
socket$netlink(0x10, 0x3, 0xe)
sendmsg(r1, &(0x7f0000000180)={0x0, 0x0, 0x0}, 0x0)
sched_setattr(0x0, &(0x7f0000000100)={0x38, 0x5, 0x0, 0x0, 0x0, 0xb49,
0x9, 0x8, 0x0, 0x3}, 0x0)
bpf$MAP_CREATE(0x0, 0x0, 0x0)
socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000240)={0xffffffffffffffff,
<r2=>0xffffffffffffffff})
ioctl$sock_SIOCETHTOOL(r2, 0x8946, &(0x7f0000000080)={'netdevsim0\x00',
&(0x7f0000000000)=@ethtool_sfeatures={0x3b, 0x2, [{0xfe}, {0xfffffff9}]}})
bpf$PROG_LOAD(0x5, 0x0, 0x0)
r3 = socket$netlink(0x10, 0x3, 0x10)
socketpair$unix(0x1, 0x3, 0x0, 0x0)
getsockopt$sock_cred(r3, 0x1, 0x11, &(0x7f0000000180)={0x0, <r4=>0x0,
<r5=>0x0}, &(0x7f0000000240)=0xc)
bpf$BPF_PROG_RAW_TRACEPOINT_LOAD(0x5, &(0x7f00000006c0)={0x1, 0x4, 0x0,
&(0x7f0000000040)='GPL\x00', 0x8, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x0,
0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x10, 0x203, @void, @value}, 0x94)
r6 = syz_open_dev$sndctrl(&(0x7f0000000000), 0x1, 0x0)
ioctl$SNDRV_CTL_IOCTL_ELEM_READ(r6, 0xc4c85512, &(0x7f0000000280)={{0x6,
0x0, 0x0, 0x0, 'syz0\x00'}, 0x0, [0x0, 0x0, 0x0, 0xffffffffffffffff,
0xffffffefffffffff, 0x0, 0x3, 0x0, 0x0, 0x4, 0x0, 0x0,
0xffffffffbfffffff, 0x0, 0x0, 0x0, 0x3, 0x80000000, 0x3, 0x0, 0x0, 0x4,
0x0, 0x6, 0x0, 0x40, 0x0, 0xfffffffffffffffd, 0x100200000, 0x0, 0x0,
0x8, 0x0, 0x0, 0x9, 0x0, 0x10000, 0x1000, 0x0, 0x3, 0xfffffffffffffffd,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x3, 0x0, 0x7, 0x10000, 0x7785, 0x0, 0x4,
0x4, 0x8, 0x0, 0xfffffffffffffffe, 0x0, 0x8, 0x0, 0x0, 0x80000000000,
0x0, 0x4, 0x0, 0xfffffffffffffffe, 0x0, 0x0, 0x0, 0xfffffffffffffffe,
0x0, 0x4000000000, 0x0, 0x80000000000000, 0x0, 0xfffffffffffffffc, 0x0,
0x0, 0xfffffffffffffffe, 0x0, 0x2000, 0x0, 0x0, 0x0, 0x0, 0x0,
0xfffffffffffffffd, 0x0, 0x0, 0x0, 0x100, 0x0, 0xfffffffffffffffd, 0x0,
0x0, 0x0, 0x2, 0x0, 0x0, 0x3, 0x2, 0x0, 0x0, 0xc0c0, 0x0, 0x0, 0x0, 0x0,
0x1, 0x0, 0x3, 0x0, 0xffffffffffeffffc, 0x0, 0x8000000000001, 0x0, 0x0,
0x0, 0x0, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x20000000, 0x0, 0x80]})
bind$netlink(r3, &(0x7f0000514ff4)={0x10, 0x0, 0x2, 0x2ff7afedf}, 0xc)
mmap(&(0x7f0000000000/0xb36000)=nil, 0xb36000, 0xb635773f06ebbeee,
0x8031, 0xffffffffffffffff, 0x0)
mlock(&(0x7f0000000000/0x800000)=nil, 0x800000)
madvise(&(0x7f0000000000/0x600000)=nil, 0x600003, 0x19)
mount$fuse(0x0, 0x0, &(0x7f0000002100), 0x0, &(0x7f00000008c0)={{},
0x2c, {'rootmode', 0x3d, 0x4000}, 0x2c, {'user_id', 0x3d, r4}, 0x2c, {},
0x2c, {[{@blksize={'blksize', 0x3d, 0x1000}}, {@max_read={'max_read',
0x3d, 0x3}}, {@blksize={'blksize', 0x3d, 0x1000}},
{@max_read={'max_read', 0x3d, 0x3}}, {@blksize={'blksize', 0x3d,
0x1400}}, {@blksize}]}})
read$FUSE(0xffffffffffffffff, &(0x7f0000006380)={0x2020, 0x0, 0x0, 0x0,
<r7=>0x0}, 0x2020)
r8 = socket(0x10, 0x2, 0x0)
ioctl$KVM_SET_PIT(0xffffffffffffffff, 0x4048aec9,
&(0x7f0000000080)={[{0x80000000, 0x0, 0x0, 0x3, 0x0, 0x10, 0x6, 0x0,
0x2, 0x0, 0xa, 0x0, 0x4}, {0xa, 0x0, 0x0, 0x0, 0x40, 0x1, 0x8, 0xff,
0x7, 0x0, 0x4, 0x0, 0xfffffffffffffff7}, {0x200000, 0xc, 0x21, 0x53,
0x0, 0x2, 0x0, 0x0, 0x58, 0xb, 0x0, 0x0, 0x8080}], 0x3fb})
sendmsg$nl_route(r8, &(0x7f0000000140)={0x0, 0x0,
&(0x7f0000000100)={&(0x7f0000000780)=ANY=[@ANYBLOB="2ea8d2811b2a246ba8a8a78787aee7bb20c96807b6d8761f859ec6fa331e777591ed11248a94c0cfc19c61fe7c081ddaf685d4d5b414a01ac8d511cfb5d75e8878514da879142e585b1f9213b0f04d67baae20dd2e742f1286afc7a9bb0ad44aa05e2e3db382651792f2945409e7c6dda83d14fef1fb50a3cb8d0a189d28277f501a04c5d4414479db27bd23c1fbdf28124c317129fe42ebf9",
@ANYRES8, @ANYRES64, @ANYRESOCT=r2, @ANYRES32, @ANYRES16=r7,
@ANYRESDEC=r5], 0x30}, 0x1, 0x0, 0x0, 0xc885}, 0x4000880)

and the suspect ethtool operation should be:

ioctl$sock_SIOCETHTOOL(r2, 0x8946, &(0x7f0000000080)={'netdevsim0\x00',
&(0x7f0000000000)=@ethtool_sfeatures={0x3b, 0x2, [{0xfe}, {0xfffffff9}]}})

Since syzkaller has no reproducer, I guess the splat depends on some
additional state/race, but I don't see how/where the lower -> bond ->
lowers features update chain is (should be) interrupted to break this
double lock.

/P


