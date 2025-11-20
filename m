Return-Path: <netdev+bounces-240569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68EC764B5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3878B2C7E8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733513570A6;
	Thu, 20 Nov 2025 20:58:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FF2D062F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672314; cv=none; b=f0phDVzfFoRbl8y8AZPhXDtJ9ZGoTGS/dUnBlGbJ+k6+EoRVzsSfms4FS67fYWl7Mn25jFJbLH6y861hCkBiLjClcK3cJILSuGRoIPZvungr8+ViBOcAEOzVVHtq3WXzu5vYv2/agIhQA/bus67Tn/jl/ymFUuafKTjxzpoOXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672314; c=relaxed/simple;
	bh=U1JaPEvAFIFM5GBCerQtXTCxm6A+HV551Vy1xWavn0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n5fX0vwyBLoHsd1yPuSH2/aqKTn6NqVjAtf8hLRQrIA2etW8c/2iB4UhaDyYV/LPQCrDv8DUiGifTyfUM4jU3Rc3mwVtAyU7wSRPpvFHOuwuWs+EL4CP81nsFWzKNnvQ42oTWwC7MfHK8NCBBxN7D03bwG7nWWxjbTTvExpy4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-43470d72247so15319875ab.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672309; x=1764277109;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JatGuBdz8ZGZO1wKcI2oQG5Aywx+T8e7anUEr9P78xU=;
        b=iZvW36+6oBptTc8+D5YYGIqdueCTw9JpvIpjVTb84XgnmGdQd2Ahdql9zsuM8F0RzN
         WMiNXKeTNDpeiqkZUj9K3Kw3Eo55SREpQfKn2plGaNW3VDqHXLCtiGuwX+o3m7qfbJVT
         NMwum5KX71lW0ASYsp+qoVE1vcYgWr2orEnUL3+zfTHAcFzMotvJJNW9lrRMtz52nPM1
         zIBy19UtQmds1RBGHD/znt0Hxc6X7+juH17bHn5pJNPYFU+PUZTudhJiEyzTpMFGnNMY
         k9RZppSuo86bHLuVKje4y0j4WRyKQQYQu1w2aqvEdbGH4lP+/kl2HkHwaf3OgQUwMvoT
         T3sA==
X-Forwarded-Encrypted: i=1; AJvYcCUcn8z6ZslSJbnBdoR2lH+nqcrZEjDh9AzJo5dExCOxypMeR9eiRL5YjURG//XiRjJdqQs387Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IlZOrHzGPAehDOqzn424qfRO55wHYfVrtsgDxvQBZjky1iu/
	tV56GlREGm7llOsS/7SNSbBuRfF5S4L8coDXxlN71iTqrP7EtpE+LVKlwHhIHHQFKaDxhYnXTFr
	HBW29+ZTsppn0JueDvBQZt8akHAqe/FS5+Gq8rk9ocybuKuADaG2RmMvJcmk=
X-Google-Smtp-Source: AGHT+IGYAvS2Z0gKNmabp2o3OeNbFYDd3Y5OgjHJ1mJxa32vG5Vaj/kFbBiY2n//s2+U8qQQLrQDSK3tsD2UqMZlARM9XD73lXM4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:435:a148:cbe with SMTP id
 e9e14a558f8ab-435b8e9da74mr783315ab.41.1763672308949; Thu, 20 Nov 2025
 12:58:28 -0800 (PST)
Date: Thu, 20 Nov 2025 12:58:28 -0800
In-Reply-To: <68a5c278.050a0220.3d78fd.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691f80f4.a70a0220.2ea503.003a.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready (4)
From: syzbot <syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8e621c9a3375 Merge tag 'net-6.18-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12887a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=0ff6b771b4f7a5bce83b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c9a12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117a2a12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6be75789d60e/disk-8e621c9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62e7a40cfe48/vmlinux-8e621c9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e523caa536d/bzImage-8e621c9a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15 at net/mptcp/subflow.c:1519 subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1519
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1519
Code: 89 ee e8 88 f8 72 f6 40 84 ed 75 21 e8 9e fd 72 f6 44 89 fe bf 07 00 00 00 e8 d1 f8 72 f6 41 83 ff 07 74 09 e8 86 fd 72 f6 90 <0f> 0b 90 e8 7d fd 72 f6 48 89 df e8 e5 ad ff ff 31 ff 89 c5 89 c6
RSP: 0018:ffffc90000147380 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888030aa72c0 RCX: ffffffff8b4959ef
RDX: ffff88801d2cbc80 RSI: ffffffff8b4959fa RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000004 R11: 00000d230000000c R12: ffff888033463c00
R13: 1ffff92000028e70 R14: ffff88802f9bbc00 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff888124a0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f841c04df98 CR3: 0000000078b7e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tcp_data_ready+0x110/0x550 net/ipv4/tcp_input.c:5355
 tcp_data_queue+0x1aa6/0x5000 net/ipv4/tcp_input.c:5445
 tcp_rcv_state_process+0xfb6/0x6490 net/ipv4/tcp_input.c:7159
 tcp_v4_do_rcv+0x68e/0x10a0 net/ipv4/tcp_ipv4.c:1954
 tcp_v4_rcv+0x3077/0x4db0 net/ipv4/tcp_ipv4.c:2374
 ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x3f2/0x720 net/ipv4/ip_input.c:239
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:260
 dst_input include/net/dst.h:474 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:453 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_rcv+0x2e0/0x600 net/ipv4/ip_input.c:573
 __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:6079
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6192
 process_backlog+0x439/0x15e0 net/core/dev.c:6544
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x97f/0xef0 net/core/dev.c:7784
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:622
 run_ksoftirqd kernel/softirq.c:1063 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:1055
 smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

