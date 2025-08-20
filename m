Return-Path: <netdev+bounces-215258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C53FB2DCE5
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B283A4DA9
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C434308F05;
	Wed, 20 Aug 2025 12:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70649307AEA
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693691; cv=none; b=RNUgoOW7VkxhkZW96Zst+GtRzSkYZpakIM2LiwFGNCvF0Q+F02SvrfLX8XyiO2V2CrDSR+ejuPxIuwHlrHm/0IuKPqRm+fI4YRTiHMd6NJv2VOfPlq5fZzx+wnuV/rHJImhpTdkO38KYltg9vXwItyAvukL/jUW+WU0sdgJ5ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693691; c=relaxed/simple;
	bh=x78F7lRawwe1Z0wXQDL/XNv/NO5uAviym5okoWYCCG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bkxMSEYZDLm0NKTdRwEAvUDot4oCREYvgg7ApL4J4IzUDZ+pphXECiaHg4zSSresQKfS0RItyV+J+0K3Yf+tldBu+gb3W7G88zA8XDm/VXWmfWa61grkZHgVSeT+5GzYNnwzOsSoueuGmeuPpBiRbTYzJWfrKHyyQuDcS8z5exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432e140b8so720600039f.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 05:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693688; x=1756298488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79PojQnQKnnfTCReFZXRMGbZgUX1Dqbfz+VlKTtOi18=;
        b=OlB+h8CnctYJqBHJJyQe1VsNE3O/2sd9TLlfibLeedV49CVqBaRodZeKyt3RabFoCA
         85/ssgdWqFJXBpQK8rQF04HMSd0qQ3Sj2kXSR/GowIZ5KW9inZiokTfJWl+89GReNoSF
         4quiSoF3By5+IOIzkdxyiAVFDbRRaFW0NAllm0eXr3HbFcYiv2Um7O9IsjjdNYIVrXU8
         aA+B0hZRGw5kvecKtn6K+ndO5XqJrRtFZ1VtdODtAmFU+FTSCeovilcd1mvQsCAdEjQv
         M4jpPDvVAMTcj6DHiPm0ojF0OnSOiM3aNJ4CrOwBfdGucKpRbcrJdW8zXYelxyf9yp2c
         rtVA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyEUSTWPcZxBDuicxRfYaXirfwuE47PGn5lp4vD/pFAj+5DfumooSJL75DUeO7JGnp+ILZkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetkVMbqQ/jrlBatJvUgtEp/VRnywyuQpmMvLOeLDpiq/Bw/ez
	KqINKX5vFs/yQ0ZxeQODkvpkQfQoCqJyX3liIma1rsBpdyGAlJ02eH9EpNipzLRCiwb7hswW5uo
	o7Q3yg/QRZOUFfbNHtcJYAoMkab0puImzYNW+8SQAjlqWzFyE8sBQWFXHqCg=
X-Google-Smtp-Source: AGHT+IFbfTZVAfWArENtiYam9/cfnU1Ih1mBxJ8G64Cy9UG+vCbIq/2GwOYnouO9KA9ie9GdDmE6X0qZekWRu8sDNSc09b/nGd6w
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388b:b0:87c:1d65:3aeb with SMTP id
 ca18e2360f4ac-884717e502bmr595120439f.2.1755693688491; Wed, 20 Aug 2025
 05:41:28 -0700 (PDT)
Date: Wed, 20 Aug 2025 05:41:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a5c278.050a0220.3d78fd.0000.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in subflow_data_ready (4)
From: syzbot <syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b19a97d57c15 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174817a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=0ff6b771b4f7a5bce83b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b19a97d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d6e98c49ae62/vmlinux-b19a97d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c90ded1d8e17/bzImage-b19a97d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 33 at net/mptcp/subflow.c:1515 subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1515
Modules linked in:
CPU: 3 UID: 0 PID: 33 Comm: ksoftirqd/3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1515
Code: 89 ee e8 78 61 3c f6 40 84 ed 75 21 e8 8e 66 3c f6 44 89 fe bf 07 00 00 00 e8 c1 61 3c f6 41 83 ff 07 74 09 e8 76 66 3c f6 90 <0f> 0b 90 e8 6d 66 3c f6 48 89 df e8 e5 ad ff ff 31 ff 89 c5 89 c6
RSP: 0018:ffffc900006cf338 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888031acd100 RCX: ffffffff8b7f2abf
RDX: ffff88801e6ea440 RSI: ffffffff8b7f2aca RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000004 R11: 0000000000002c10 R12: ffff88802ba69900
R13: 1ffff920000d9e67 R14: ffff888046f81800 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880d69bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560fc0ca1670 CR3: 0000000032c3a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 tcp_data_queue+0x13b0/0x4f90 net/ipv4/tcp_input.c:5197
 tcp_rcv_state_process+0xfdf/0x4ec0 net/ipv4/tcp_input.c:6922
 tcp_v6_do_rcv+0x492/0x1740 net/ipv6/tcp_ipv6.c:1672
 tcp_v6_rcv+0x2976/0x41e0 net/ipv6/tcp_ipv6.c:1918
 ip6_protocol_deliver_rcu+0x188/0x1520 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x1e4/0x4b0 net/ipv6/ip6_input.c:489
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:500
 dst_input include/net/dst.h:471 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ipv6_rcv+0x264/0x650 net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:5979
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6092
 process_backlog+0x442/0x15e0 net/core/dev.c:6444
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7494
 napi_poll net/core/dev.c:7557 [inline]
 net_rx_action+0xa9f/0xfe0 net/core/dev.c:7684
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 run_ksoftirqd kernel/softirq.c:968 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:960
 smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

