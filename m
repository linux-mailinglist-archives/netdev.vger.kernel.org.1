Return-Path: <netdev+bounces-237726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC6FC4FA16
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 20:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F44E0ED8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034C1329E7E;
	Tue, 11 Nov 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTE7DWMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56732A3D7
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890272; cv=none; b=brHdcLQuwTrwOC75rblmpYN47z1bHCHA5MQBqP1FiuuGztRdqtitXYzu62o3epTNO27LO09IzBtMeIvUwpkC4lm1KFkp1H73R8SyWfiMwhTQ9rDdYNNilWCFcgHMM8m5Tl8CUIwO3GEUR8gOyYeQU7kIiaXQqxr2Cq9jl7TaYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890272; c=relaxed/simple;
	bh=htpmaQecpKfV3tKEE7C5na3pqOPEsOhfgDMa+kTY6fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMtj6kZ5r9NJMVha2dA8/clXwFDyqaPY3pR+MIYgI+GutiO8OdJd5Sw7YVYrnY6zjLm6R4F641tmgYjMNy2Mplgi6lY2sUoWUrZFNR2B1L1yQjJqLaYOAYZn51Ni3htKr7Rs6SccnPPDG82OxiyTVVXzlyToegjAA+oFv2ups14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTE7DWMG; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so918341cf.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762890270; x=1763495070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ne0eOOxRnSxl7HVZ1a8hogwoWma9i5QuZuVNjMUX+k=;
        b=vTE7DWMG+xqnXvcVr90qU59KsToU5AJ2Se0QOJhsrHOjNQ1YsctqulF9ISUWoLQdfX
         vyBbLzF7h1By/nG7qw5m1nuKKvUSb0zrHzRQ7zZN693w/p338SCgsps1yQS+rPgB51K1
         E524EbJ85xmFw7ne/lHGJXo31GqA5Nv4nOriT7Oagxyvljav5YTTyqJiwu48ZhYDCKLj
         E1cZXR55OZK86JbShfn1OQFqC3PfbaJ1oOHHCM5h6/0Wjxud0qUADOp+M9Sc5HGyBRH6
         UQSUp02gNYemcbkTMblBFtjF7LxwvcD0ja5QA1DUfcyI15UUiBrC14uS2BoUvuYO0BM5
         2P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890270; x=1763495070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Ne0eOOxRnSxl7HVZ1a8hogwoWma9i5QuZuVNjMUX+k=;
        b=N0JUD/hQpbqEV6GsHcvhwiXm/hAqTK4WQ8aA4bm/wPR3tt2z+qvrPqiPOT74DaVewc
         3LZ444573WreHZ2d+11GEuWsVyr1sqMMJO2DiKtwOWKwrOvO91nGKVw0sqwD0bqF3Z1l
         jS7Zuwp4dLAi9/hj0wn0AJOWeH3f9DNPeHrtt9esSxml4uvPWM03Gw495TBSxjGysTdG
         50RxhKfLdLjVHIvDCHHTL979ReYHesgoUmw8q5YeZCX2MNaZoKGRAbPfEZCdfy0tZlRh
         jBABLWEPt9+ufKNqa4l4fWGycrosUMqz6/FO0i8GCZ/zAoNKV/upE/kkTDg233SKTMGN
         jWhA==
X-Forwarded-Encrypted: i=1; AJvYcCUx/U0bYQhiTWwui8530qoIM4LSh3/M2g5PzGYbRn4UztWM3fG5QlSjAAw1TQA+4yDbPiiqyT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6YvDjjrbeEekDP5DvpItx7CnwPpOch8Hn7Tr9Sn1y+CdLhYU
	ZFTd2s5EE1FMBomqvB20LnvX4E4yw8iLgUE0E5ni5du/Fya/tLXPYTcmFqxi5+Ky9hVwGGiUdjj
	CUrsApj31aFwQvBM2b/1SRX4YL5YekD1M/6OyMqJu
X-Gm-Gg: ASbGncve7EF6ZJIF6C+Jrl9U5A2Kly227rOfMyWd9muI34/yDYv1xwqFBjO2MHgzrMQ
	XUaapSRYsYCbyuuctnLcEGZazI9xyZEqyozZIPoh6durb23Hznzoc+o6Dd9PVewNwl+WrMjj0yS
	z15g2zAql9yyt2NrRPUS4UYhNY4k+vUu91u+HSOWPVEQFy1Rw8XmZtTrj1XtwFNpNXisIyTa0ZO
	UIlUHTADQTT4izUr14WweeWeDVCvfPqYN0alS5hJAmly1VMI7y7XeDDR/6D2XAbCd+/Xcra5r4S
	I2F1gxgh/sfJZEpx
X-Google-Smtp-Source: AGHT+IF9mCDpU1yzyR1HG9m8YuT+vZXlpTIieVOm5Cm29CCQnUcqJyKc0Oni4v73BdQN2BRSdnRgSJo3XfugvrfcKZg=
X-Received: by 2002:a05:622a:14cc:b0:4e8:a1eb:3e2d with SMTP id
 d75a77b69052e-4eddbc93237mr6982411cf.2.1762890269649; Tue, 11 Nov 2025
 11:44:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com> <6913437c.a70a0220.22f260.013b.GAE@google.com>
 <CANn89iKgYo=f+NyOVFfLjkYLczWsqopxt4F5adutf5eY9TAJmA@mail.gmail.com> <CANn89iJ5p3xY_LJcexq8n2-91A6ERPV6yqjPGphD_w6wr_NHew@mail.gmail.com>
In-Reply-To: <CANn89iJ5p3xY_LJcexq8n2-91A6ERPV6yqjPGphD_w6wr_NHew@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Nov 2025 11:44:18 -0800
X-Gm-Features: AWmQ_blhebAKfq1Rf_pnUahgnUHm_s4vQ8jWvQ8r085ZqBnfMirbsjdfyFtoV5E
Message-ID: <CANn89iKLDetsEpMrFU4F_XbTF_N0ranLkzJvf1qG=o-ecfseZg@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net_sched: speedup qdisc dequeue
To: syzbot ci <syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, toke@redhat.com, 
	willemb@google.com, xiyou.wangcong@gmail.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:23=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Nov 11, 2025 at 8:28=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Nov 11, 2025 at 6:09=E2=80=AFAM syzbot ci
> > <syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot ci has tested the following series
> > >
> > > [v2] net_sched: speedup qdisc dequeue
> > > https://lore.kernel.org/all/20251111093204.1432437-1-edumazet@google.=
com
> > > * [PATCH v2 net-next 01/14] net_sched: make room for (struct qdisc_sk=
b_cb)->pkt_segs
> > > * [PATCH v2 net-next 02/14] net: init shinfo->gso_segs from qdisc_pkt=
_len_init()
> > > * [PATCH v2 net-next 03/14] net_sched: initialize qdisc_skb_cb(skb)->=
pkt_segs in qdisc_pkt_len_init()
> > > * [PATCH v2 net-next 04/14] net: use qdisc_pkt_len_segs_init() in sch=
_handle_ingress()
> > > * [PATCH v2 net-next 05/14] net_sched: use qdisc_skb_cb(skb)->pkt_seg=
s in bstats_update()
> > > * [PATCH v2 net-next 06/14] net_sched: cake: use qdisc_pkt_segs()
> > > * [PATCH v2 net-next 07/14] net_sched: add Qdisc_read_mostly and Qdis=
c_write groups
> > > * [PATCH v2 net-next 08/14] net_sched: sch_fq: move qdisc_bstats_upda=
te() to fq_dequeue_skb()
> > > * [PATCH v2 net-next 09/14] net_sched: sch_fq: prefetch one skb ahead=
 in dequeue()
> > > * [PATCH v2 net-next 10/14] net: prefech skb->priority in __dev_xmit_=
skb()
> > > * [PATCH v2 net-next 11/14] net: annotate a data-race in __dev_xmit_s=
kb()
> > > * [PATCH v2 net-next 12/14] net_sched: add tcf_kfree_skb_list() helpe=
r
> > > * [PATCH v2 net-next 13/14] net_sched: add qdisc_dequeue_drop() helpe=
r
> > > * [PATCH v2 net-next 14/14] net_sched: use qdisc_dequeue_drop() in ca=
ke, codel, fq_codel
> > >
> > > and found the following issue:
> > > WARNING in sk_skb_reason_drop
> > >
> > > Full report is available here:
> > > https://ci.syzbot.org/series/a9dbee91-6b1f-4ab9-b55d-43f7f50de064
> > >
> > > ***
> > >
> > > WARNING in sk_skb_reason_drop
> > >
> > > tree:      net-next
> > > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/n=
etdev/net-next.git
> > > base:      a0c3aefb08cd81864b17c23c25b388dba90b9dad
> > > arch:      amd64
> > > compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976=
-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > config:    https://ci.syzbot.org/builds/a5059d85-d1f8-4036-a0fd-b677b=
5945ea9/config
> > > C repro:   https://ci.syzbot.org/findings/e529fc3a-766e-4d6c-899a-c35=
a8fdaa940/c_repro
> > > syz repro: https://ci.syzbot.org/findings/e529fc3a-766e-4d6c-899a-c35=
a8fdaa940/syz_repro
> > >
> > > syzkaller0: entered promiscuous mode
> > > syzkaller0: entered allmulticast mode
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_d=
rop net/core/skbuff.c:1189 [inline]
> > > WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_dro=
p+0x76/0x170 net/core/skbuff.c:1214
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 5965 Comm: syz.0.17 Not tainted syzkaller #0 PREEM=
PT(full)
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debia=
n-1.16.2-1 04/01/2014
> > > RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
> > > RIP: 0010:sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214
> > > Code: 20 2e a0 f8 83 fd 01 75 26 41 8d ae 00 00 fd ff bf 01 00 fd ff =
89 ee e8 08 2e a0 f8 81 fd 00 00 fd ff 77 32 e8 bb 29 a0 f8 90 <0f> 0b 90 e=
b 53 bf 01 00 00 00 89 ee e8 e9 2d a0 f8 85 ed 0f 8e b2
> > > RSP: 0018:ffffc9000284f3b0 EFLAGS: 00010293
> > > RAX: ffffffff891fdcd5 RBX: ffff888113587680 RCX: ffff88816e6f3a00
> > > RDX: 0000000000000000 RSI: 000000006e1a2a10 RDI: 00000000fffd0001
> > > RBP: 000000006e1a2a10 R08: ffff888113587767 R09: 1ffff110226b0eec
> > > R10: dffffc0000000000 R11: ffffed10226b0eed R12: ffff888113587764
> > > R13: dffffc0000000000 R14: 000000006e1d2a10 R15: 0000000000000000
> > > FS:  000055558e11c500(0000) GS:ffff88818eb38000(0000) knlGS:000000000=
0000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000200000002280 CR3: 000000011053c000 CR4: 00000000000006f0
> > > Call Trace:
> > >  <TASK>
> > >  kfree_skb_reason include/linux/skbuff.h:1322 [inline]
> > >  tcf_kfree_skb_list include/net/sch_generic.h:1127 [inline]
> > >  __dev_xmit_skb net/core/dev.c:4258 [inline]
> > >  __dev_queue_xmit+0x2669/0x3180 net/core/dev.c:4783
> > >  packet_snd net/packet/af_packet.c:3076 [inline]
> > >  packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
> > >  sock_sendmsg_nosec net/socket.c:727 [inline]
> > >  __sock_sendmsg+0x21c/0x270 net/socket.c:742
> > >  ____sys_sendmsg+0x505/0x830 net/socket.c:2630
> > >  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
> > >  __sys_sendmsg net/socket.c:2716 [inline]
> > >  __do_sys_sendmsg net/socket.c:2721 [inline]
> > >  __se_sys_sendmsg net/socket.c:2719 [inline]
> > >  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
> > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7fc1a7b8efc9
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007fff4ba6d968 EFLAGS: 00000246 ORIG_RAX: 000000000000002=
e
> > > RAX: ffffffffffffffda RBX: 00007fc1a7de5fa0 RCX: 00007fc1a7b8efc9
> > > RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000007
> > > RBP: 00007fc1a7c11f91 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 00007fc1a7de5fa0 R14: 00007fc1a7de5fa0 R15: 0000000000000003
> > >  </TASK>
> > >
> >
> > Seems that cls_bpf_classify() is able to change tc_skb_cb(skb)->drop_re=
ason,
> > and this predates my code.
>
> struct bpf_skb_data_end {
>   struct qdisc_skb_cb qdisc_cb;
>   void *data_meta;
>    void *data_end;
> };
>
> So anytime BPF calls bpf_compute_data_pointers(), it overwrites
> tc_skb_cb(skb)->drop_reason,
> because offsetof(   ..., data_meta) =3D=3D offsetof(... drop_reason)
>
> CC Victor and Daniel

Quick and dirty patch to save/restore the space.

diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 7fbe42f0e5c2b7aca0a28c34cd801c3a767c804e..004d8fe2f29d89bd7df82d90b7a=
1e2881f7a463b
100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -82,11 +82,16 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *=
skb,
                                       const struct tcf_proto *tp,
                                       struct tcf_result *res)
 {
+       struct bpf_skb_data_end *cb =3D (struct bpf_skb_data_end *)skb->cb;
        struct cls_bpf_head *head =3D rcu_dereference_bh(tp->root);
        bool at_ingress =3D skb_at_tc_ingress(skb);
        struct cls_bpf_prog *prog;
+       void *save[2];
        int ret =3D -1;

+       save[0] =3D cb->data_meta;
+       save[1] =3D cb->data_end;
+
        list_for_each_entry_rcu(prog, &head->plist, link) {
                int filter_res;

@@ -133,7 +138,8 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff *=
skb,

                break;
        }
-
+       cb->data_meta =3D save[0];
+       cb->data_end =3D save[1];
        return ret;
 }

