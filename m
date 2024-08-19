Return-Path: <netdev+bounces-119682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C3956938
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A342B2832B5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7F166F2E;
	Mon, 19 Aug 2024 11:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8DB1667CD
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066359; cv=none; b=LFvZS8EVRXsRDpH6fb4Xc9d/w+p2hcw+M+xR8emdjfV06BLGNEIopsZ8N3gA0F7DJH0DDFDa1STc383PUIbc6/m8liD43Av8ceDg2VQe3KvPHjijaJJfdjmi24w0vvIj6RIO6mNPhpe3N5L/l99P41EeJZddu/GDuZVknscrArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066359; c=relaxed/simple;
	bh=RS4wtplt+HKtdiOLZDctHqkTH4N/qes2PKYA7J+1upk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=aHtD7eOpQBeUeJHKJJNrPKVxdp1OMDGqpxPA6YgGpsi2t5cuHVuJQSFJurQRd7v3rq5Eh/+KTpp9kuv62ZY6gswFthMwx64ZcjIrNRr3O9YOml11IjmeHwdpblc5pOYbby0srLmYaUERdlgVz5d48sh0iUFdRkjbeFWNRqjpE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d5537a659so152605ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066356; x=1724671156;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpN45RjAlqBKLgRPOwbVK0ppWriQo5EfgnOPvbL1jb0=;
        b=Ti1dDHMAES9mZLwqFNrU7QgoIb1oV9R0ofxZ+T4hUKyN1CvaWSv7oOMWNc2tESangM
         uGBc0y36SGsmAfIm85er2/fjHS378Qkyj/XcGFyBQPfOUWSxTQwWSvoFxfENK3Wd6CTZ
         d9sonB2FPiO6YsIaHjcireIMNA3b33th+skJJMEy4ZqKjpCU3xqcDKQzp01bvE4Hzg0Z
         Nido/Pf6/NMtV57NrqQ9hoDxpvi9yIn2eaEx7TTiJqzfu5huBqOg7Oz2KBoLUQJlTgCN
         HpCPTSVAFsE06ptjPEAc5PTOegTKJOxKu9ca+OE6xOiwY2wOnoPDk2ae9G6sQfp9UJU8
         S3kw==
X-Forwarded-Encrypted: i=1; AJvYcCWYhSiHE6qi89zMm+P9U7M7FgvKpzfOKDOn1X8coetqZeskI+/XMjODN1q0mUV37lQvnFqax78kpkmANqruPt1fu8gq634/
X-Gm-Message-State: AOJu0YzEnA4y8H1Qtd87temf56E7i88l2sz42PiILk4vJrSpPamYVnMw
	Y5rVaMhrm/Z41GoVGReHnqXh8PAkj9ZhrH1r2Vy84KvclEkajE6evoMZeYS+x+c2GEyZAXSkrtx
	FSLOl6kWwNxrXKoNhZegmXb9lF5TZ/5hI3JeTH5TZ8Hci1sQ/Mbje+7w=
X-Google-Smtp-Source: AGHT+IHwtPfJYQR9uUi9WkVWWjAHs+VbSsR3j0gfzWxGUbay2suHV+0fWZiPXfFr+G+RqNZHiy+9jgZ+BE9SsTQ7QQGNBC/ErYfF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170e:b0:39a:eb4d:23c5 with SMTP id
 e9e14a558f8ab-39d26c36cfamr10296045ab.0.1724066356570; Mon, 19 Aug 2024
 04:19:16 -0700 (PDT)
Date: Mon, 19 Aug 2024 04:19:16 -0700
In-Reply-To: <CANp29Y6xOzoQ4UKKta2_a6zaQv-xqadZD0q5QrLtVNj1uPe3BQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c117fe0620077a1e@google.com>
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in cake_enqueue
From: syzbot <syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com>
To: nogikh@google.com
Cc: cake@lists.bufferbloat.net, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, nogikh@google.com, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@toke.dk, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz upstream

Can't upstream, this is final destination.

>
> On Mon, Aug 19, 2024 at 11:54=E2=80=AFAM syzbot
> <syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    a99ef548bba0 bnx2x: Set ivi->vlan field as an integer
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10baacfd9800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7229118d88b4=
a71b
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7fe7b81d602cc1=
e6b94d
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/d555f757c854/di=
sk-a99ef548.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/8e46d450e252/vmlin=
ux-a99ef548.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/bc2197d1b6a7/=
bzImage-a99ef548.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> UBSAN: array-index-out-of-bounds in net/sched/sch_cake.c:1876:6
>> index 65535 is out of range for type 'u16[1025]' (aka 'unsigned short[10=
25]')
>> CPU: 0 UID: 0 PID: 5282 Comm: kworker/0:6 Not tainted 6.11.0-rc3-syzkall=
er-00482-ga99ef548bba0 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 08/06/2024
>> Workqueue: wg-crypt-wg0 wg_packet_tx_worker
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:93 [inline]
>>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
>>  ubsan_epilogue lib/ubsan.c:231 [inline]
>>  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
>>  cake_enqueue+0x785e/0x9340 net/sched/sch_cake.c:1876
>>  dev_qdisc_enqueue+0x4b/0x290 net/core/dev.c:3775
>>  __dev_xmit_skb net/core/dev.c:3871 [inline]
>>  __dev_queue_xmit+0xf4a/0x3e90 net/core/dev.c:4389
>>  dev_queue_xmit include/linux/netdevice.h:3073 [inline]
>>  neigh_hh_output include/net/neighbour.h:526 [inline]
>>  neigh_output include/net/neighbour.h:540 [inline]
>>  ip6_finish_output2+0xfc2/0x1680 net/ipv6/ip6_output.c:137
>>  ip6_finish_output+0x41e/0x810 net/ipv6/ip6_output.c:222
>>  ip6tunnel_xmit include/net/ip6_tunnel.h:161 [inline]
>>  udp_tunnel6_xmit_skb+0x590/0x9d0 net/ipv6/ip6_udp_tunnel.c:111
>>  send6+0x6da/0xaf0 drivers/net/wireguard/socket.c:152
>>  wg_socket_send_skb_to_peer+0x115/0x1d0 drivers/net/wireguard/socket.c:1=
78
>>  wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
>>  wg_packet_tx_worker+0x1bf/0x810 drivers/net/wireguard/send.c:276
>>  process_one_work kernel/workqueue.c:3231 [inline]
>>  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>>  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
>>  kthread+0x2f0/0x390 kernel/kthread.c:389
>>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>  </TASK>
>> ---[ end trace ]---
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
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msg=
id/syzkaller-bugs/00000000000071e6110620064b4c%40google.com.

