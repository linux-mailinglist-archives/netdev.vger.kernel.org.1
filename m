Return-Path: <netdev+bounces-237693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80932C4F08B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A251897A7D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0937369976;
	Tue, 11 Nov 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG7Q9JZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26461156C6A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878498; cv=none; b=X+tBYmLm1jzOHsbnq4r6BM+86/tb0uUkHQS+moBWdGxMjJ7SoDKR2fHdHGTT5fVsxBjcj0vycRAni+uuLO8wDgotjHL5BYZEu8hh306VwTK+/xkUS/t8aqhAFSzCvZRvsbOhGBZKVT4iXP9C8uCYO6avsWaSNo+YLSosmVmIznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878498; c=relaxed/simple;
	bh=SkJMD8zFDE/jq4iHJv2SH7nhrkj1JoGRdX7YPaDbMaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LviXTqFRSOI/zJ2SKM5CcZ2IcLJNRImswj53+X6W9t+bW70OdVCaY01q+Ns1tniW7xXyQsXbQtm+OM8uJ94scIdw1wm+SGnOG8m79F5p9bnp+HJfiT/m+GYx8lMdUHHALftIS+aWz9QAKj4VwZfieXV3iGuN6+kJ5KY4CHWVytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HG7Q9JZL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-88f2b29b651so434030985a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 08:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762878496; x=1763483296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiEqMJTNWsD2g7cLFr/d5z1U0903SgXVvXdHnjJ9aKo=;
        b=HG7Q9JZLas6D9tzAqqLTXvVtD7UFGtK+hvYJnKWpz9cqD+z/8d/WTU3Ffh35J83lg+
         27EUOaqRR7zZToDYt8L6/N6qlDqma6Ob22fw1QaaRnn+mDx24kPpHj3ZsRzKowJH9OlK
         uNsSeHcOxLgbAAdbPgAt6H7yyZ8zk9LGqe4Aq8ShZ5h37cMyFCm95pm6zcmKAAtrkH6s
         FT9jf3hS7OWW2m9dldsGIlazbtSVdbT0k4zX1WbbqxPYJhI2FGvQXKi5MUGg9eBsdnLr
         mCcaO+EODLodP3+CX7qjT//3vJWO6FJwB4HE0C2uGg6OBWuPeAzisGfpRHqCzmYnlkki
         TFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762878496; x=1763483296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiEqMJTNWsD2g7cLFr/d5z1U0903SgXVvXdHnjJ9aKo=;
        b=rtWZ2a4EIcBZiQmlH10WelkS2rChmZFWiXF1xL/+4zxBe0cKGHRIpuM1rqj9yYoS8a
         hRFZd35teerA+4FQbts81haQF/XzJvyjJtTyL7XylxfP5DDyc7N+nyXoB7E22fQQpAB2
         x8aGf/B3V53fvzgrTocxLNw4lta5UqxQ/XWA7DCgXpPHRDiF5ISx/I3qpGVbDS1kcUll
         AFh/otD6pe+ex5BChmPByVHwhX4V2VfuIzrLbrE8ePlc0dHVUeZoFRiVrSKEbr4NgDi+
         Nj0oTDKMHZopUwxzE8uw9q6RobeN0Fk8k8vC/gd+uXHOHysLTd+erXi35IPGEJemoKfY
         uKEg==
X-Forwarded-Encrypted: i=1; AJvYcCWaKN6QA/9v9y/qSc2EozxXGMpp9zlfqmaSRrBV7/zuEFsB6+u+pOP4Frt0EQzh76W4gTU3CHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG80AhJp8U0XMDNRo87T+gWJx4if/vUlR89Viw6sjbbQbDAam5
	ZM1iZ66tKkKzwwPmBG+MIvcNlJUOCv3VGtPQ3ISySoeJYZC6kpwWa5jV5imq5vNNRcy1iWfvy4W
	kzeXe3+PPpaidcOHykJ5ssQcA7lFTFaC1hjBoKBtZ
X-Gm-Gg: ASbGncthZRdi/yI0Vmo7NiIdmyK7g72VKkUxoNqhh6Uj4I8ab5EsF8duC+eP6E16JM/
	I43Oyn+FCwTIb2B1FFG8GVeU81O+HIqTLLCHfuzIVjvnyht0Udm5MU7jAYEOLnBdMWzu9eYTZTM
	9shZ3Hmy5c19wj0mFTqqU2FFp+BFSDDzTqkIiff9AkdihyfLGQbrVyDb7VXj+WAAQzmqMRyQ2BL
	Uf+QVxoTExHTPVh1kaVV3LTFx81efnVhRXy76K4N1uVjWWR1GoOYJPhI+TEWjG4MlOAdjY=
X-Google-Smtp-Source: AGHT+IFASXKaWN+zH7R8EIk4Xj6iNdYdZKkKJ5ee6ghbIvcGVUk8ZzDu4pF2V2LKB1Cd5TLrtIBb5LfUbdgcyijiLrU=
X-Received: by 2002:a05:622a:180a:b0:4ec:f001:e18b with SMTP id
 d75a77b69052e-4eda4fd279fmr168190461cf.48.1762878495360; Tue, 11 Nov 2025
 08:28:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com> <6913437c.a70a0220.22f260.013b.GAE@google.com>
In-Reply-To: <6913437c.a70a0220.22f260.013b.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Nov 2025 08:28:04 -0800
X-Gm-Features: AWmQ_blf_9glxZ5AdH767oMHySi65k6znYZ5mO9zF7TaFxUwOJxweU17RaMKnKs
Message-ID: <CANn89iKgYo=f+NyOVFfLjkYLczWsqopxt4F5adutf5eY9TAJmA@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net_sched: speedup qdisc dequeue
To: syzbot ci <syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, toke@redhat.com, 
	willemb@google.com, xiyou.wangcong@gmail.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:09=E2=80=AFAM syzbot ci
<syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v2] net_sched: speedup qdisc dequeue
> https://lore.kernel.org/all/20251111093204.1432437-1-edumazet@google.com
> * [PATCH v2 net-next 01/14] net_sched: make room for (struct qdisc_skb_cb=
)->pkt_segs
> * [PATCH v2 net-next 02/14] net: init shinfo->gso_segs from qdisc_pkt_len=
_init()
> * [PATCH v2 net-next 03/14] net_sched: initialize qdisc_skb_cb(skb)->pkt_=
segs in qdisc_pkt_len_init()
> * [PATCH v2 net-next 04/14] net: use qdisc_pkt_len_segs_init() in sch_han=
dle_ingress()
> * [PATCH v2 net-next 05/14] net_sched: use qdisc_skb_cb(skb)->pkt_segs in=
 bstats_update()
> * [PATCH v2 net-next 06/14] net_sched: cake: use qdisc_pkt_segs()
> * [PATCH v2 net-next 07/14] net_sched: add Qdisc_read_mostly and Qdisc_wr=
ite groups
> * [PATCH v2 net-next 08/14] net_sched: sch_fq: move qdisc_bstats_update()=
 to fq_dequeue_skb()
> * [PATCH v2 net-next 09/14] net_sched: sch_fq: prefetch one skb ahead in =
dequeue()
> * [PATCH v2 net-next 10/14] net: prefech skb->priority in __dev_xmit_skb(=
)
> * [PATCH v2 net-next 11/14] net: annotate a data-race in __dev_xmit_skb()
> * [PATCH v2 net-next 12/14] net_sched: add tcf_kfree_skb_list() helper
> * [PATCH v2 net-next 13/14] net_sched: add qdisc_dequeue_drop() helper
> * [PATCH v2 net-next 14/14] net_sched: use qdisc_dequeue_drop() in cake, =
codel, fq_codel
>
> and found the following issue:
> WARNING in sk_skb_reason_drop
>
> Full report is available here:
> https://ci.syzbot.org/series/a9dbee91-6b1f-4ab9-b55d-43f7f50de064
>
> ***
>
> WARNING in sk_skb_reason_drop
>
> tree:      net-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netde=
v/net-next.git
> base:      a0c3aefb08cd81864b17c23c25b388dba90b9dad
> arch:      amd64
> compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~e=
xp1~20250708183702.136), Debian LLD 20.1.8
> config:    https://ci.syzbot.org/builds/a5059d85-d1f8-4036-a0fd-b677b5945=
ea9/config
> C repro:   https://ci.syzbot.org/findings/e529fc3a-766e-4d6c-899a-c35a8fd=
aa940/c_repro
> syz repro: https://ci.syzbot.org/findings/e529fc3a-766e-4d6c-899a-c35a8fd=
aa940/syz_repro
>
> syzkaller0: entered promiscuous mode
> syzkaller0: entered allmulticast mode
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop =
net/core/skbuff.c:1189 [inline]
> WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x=
76/0x170 net/core/skbuff.c:1214
> Modules linked in:
> CPU: 0 UID: 0 PID: 5965 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
> RIP: 0010:sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214
> Code: 20 2e a0 f8 83 fd 01 75 26 41 8d ae 00 00 fd ff bf 01 00 fd ff 89 e=
e e8 08 2e a0 f8 81 fd 00 00 fd ff 77 32 e8 bb 29 a0 f8 90 <0f> 0b 90 eb 53=
 bf 01 00 00 00 89 ee e8 e9 2d a0 f8 85 ed 0f 8e b2
> RSP: 0018:ffffc9000284f3b0 EFLAGS: 00010293
> RAX: ffffffff891fdcd5 RBX: ffff888113587680 RCX: ffff88816e6f3a00
> RDX: 0000000000000000 RSI: 000000006e1a2a10 RDI: 00000000fffd0001
> RBP: 000000006e1a2a10 R08: ffff888113587767 R09: 1ffff110226b0eec
> R10: dffffc0000000000 R11: ffffed10226b0eed R12: ffff888113587764
> R13: dffffc0000000000 R14: 000000006e1d2a10 R15: 0000000000000000
> FS:  000055558e11c500(0000) GS:ffff88818eb38000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000002280 CR3: 000000011053c000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  kfree_skb_reason include/linux/skbuff.h:1322 [inline]
>  tcf_kfree_skb_list include/net/sch_generic.h:1127 [inline]
>  __dev_xmit_skb net/core/dev.c:4258 [inline]
>  __dev_queue_xmit+0x2669/0x3180 net/core/dev.c:4783
>  packet_snd net/packet/af_packet.c:3076 [inline]
>  packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
>  sock_sendmsg_nosec net/socket.c:727 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:742
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2630
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
>  __sys_sendmsg net/socket.c:2716 [inline]
>  __do_sys_sendmsg net/socket.c:2721 [inline]
>  __se_sys_sendmsg net/socket.c:2719 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc1a7b8efc9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff4ba6d968 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fc1a7de5fa0 RCX: 00007fc1a7b8efc9
> RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000007
> RBP: 00007fc1a7c11f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc1a7de5fa0 R14: 00007fc1a7de5fa0 R15: 0000000000000003
>  </TASK>
>

Seems that cls_bpf_classify() is able to change tc_skb_cb(skb)->drop_reason=
,
and this predates my code.

