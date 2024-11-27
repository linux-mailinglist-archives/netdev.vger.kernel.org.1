Return-Path: <netdev+bounces-147535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7DA9DA119
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D60B21B47
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FBC2AE6C;
	Wed, 27 Nov 2024 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9K5uYSG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A611713
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677875; cv=none; b=X3G7EKMcexxjIbV/zRVL9PwnW2taU6Oom/csR9zLnP0AJYTiSAYmlJKW/jmhiLOQqnoSh+ey+aOSNubcsV+fSRtXUeissn5jdH31KnWvkmZKFPfHP+kcZATEJ7fJkdC0Y1qFbK9STMHaIX1L8Oj3ouIb4z4ramhfQ6IZ0PszM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677875; c=relaxed/simple;
	bh=1/u+UcElI+MPPVSNKfLQzRGy86qxjLSXFbU0VpGBKGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lthl3cZQUTtklQiwla/t2Vy2cHwrXof5DYKHcZj/jJAos6CT1qMdN7kVi9HReoolvI0OVe1N6Pi5iSRzSPgSTtDc8Tt7CGRfJFqxh+Vd1B2xGCm3ey7rsrYx9sWWnzx/KmQewM1JQ0sHdxHRIVTap3ZfFkVpg/n5A1S++dwWg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9K5uYSG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732677871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q91fMjk0/N0rHJS1h9TgFKLdHdt3dGavzSTZjaXJDGw=;
	b=b9K5uYSGWobZtVp/xWXHJn4PsJXerD/JW2P71SRvAmkR0ving+8Y7GZdSQWWNecWetX5J9
	njGaMy8GL5snH1trLeLteoJOkI4h3A3C7aaZYcMH8s95PaPYdLAzi7JbzudjsxzTpDhip7
	mfpecTpJ5A3BHMh2sF6J+r0SA5/Ej/M=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-A6M0kBYJM62Tii_WeXVuJw-1; Tue, 26 Nov 2024 22:24:29 -0500
X-MC-Unique: A6M0kBYJM62Tii_WeXVuJw-1
X-Mimecast-MFC-AGG-ID: A6M0kBYJM62Tii_WeXVuJw
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4af3cbf03caso278232137.3
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732677868; x=1733282668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q91fMjk0/N0rHJS1h9TgFKLdHdt3dGavzSTZjaXJDGw=;
        b=r4YW23/ttm9qDREp74C2btXCIsYJnyjOAgP3GndfsWiRbTc4mK/qBuQ1x1eDwYsyms
         4ciFPguzbYq9uOe/n6bJD6ECGp7I7qpgeh/GPPn8Fnd4h6RrW8HitfgY9yv7awXmKrEK
         tdHI4NURCCDzpTFhdirAtKAx9+8rcYHLa87LW8CIk6Ifxah1EVO95cbA0LJIuoXk8HT/
         GlzTzJNJLgLZ2RvT/AUoljsiwtI3Xph4C2PlPijh8NaZopwJjECjqJ4vS4bFFV53YgZs
         4bIOnA1CZaNJlT6AsFgBIqxoWGQ2zqIV5Fp+AL7A12gQAHEqgCy8mfI6zZ6FRwzuLDzk
         DukQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjfSGAeD49dgm9IMLxdD0xsnJn7qxLoun4R3buxHDcD1vdAiO8+g3ftZsm9+BNQoGG9w+iMWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sX3JWmQ4akEdiEBJRFB4UGkfv3Ta1FHG8V6E7mJzZTsPtniR
	161/RNbtr4TccKIdwzaNMtzjnaRnxjXbhkG3V+O9brYc2/rG3vONQroKK+uioAmYRaqfynsCKxd
	57ZWXWjUO1gdCLcoRm7TRRpSKFnppmsJDusFZtv8QsTOV7wSd+yEPuXhWuhxOm5FOihHbxTXuSt
	47HH2WwWAUp0yGBDYRAlYrveZzp6WJ
X-Gm-Gg: ASbGnctIh/twLmlpLNKVVR2tWIXGLFUBIGb/OVI5UqnT3dH72N3wN7VOtJg+N1Si5np
	v3z8s1Jd3Iyc/87lCN0vQjuyRwbkpT4D2
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id ada2fe7eead31-4af447ba11amr2480000137.4.1732677868404;
        Tue, 26 Nov 2024 19:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENLpNHXVdEJkHfKOZ6y3NH0owSwITH1IrhuBh+8vAIoAuNm3dDd/e+WuEr/MLMpgiQz6hr18VjYjytXU3cWrU=
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id
 ada2fe7eead31-4af447ba11amr2479984137.4.1732677867940; Tue, 26 Nov 2024
 19:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126024200.2371546-1-koichiro.den@canonical.com>
 <CACGkMEsJ1X-u=djO2=kJzZdpZH5SX560V9osdpDuySXtfBMpuw@mail.gmail.com> <6lkdqvbnlntx3cno5qi7c4nks2ub3bkaycsuq7p433c4vemcmf@fwnhqbo5ehaw>
In-Reply-To: <6lkdqvbnlntx3cno5qi7c4nks2ub3bkaycsuq7p433c4vemcmf@fwnhqbo5ehaw>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Nov 2024 11:24:15 +0800
Message-ID: <CACGkMEvR4+_iRAFACkXLgX-hGwjfOgd3emiyquzxUHL9wC-b=g@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: drain unconsumed tx completions if any before dql_reset
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:44=E2=80=AFPM Koichiro Den
<koichiro.den@canonical.com> wrote:
>
> On Tue, Nov 26, 2024 at 11:50:17AM +0800, Jason Wang wrote:
> > On Tue, Nov 26, 2024 at 10:42=E2=80=AFAM Koichiro Den
> > <koichiro.den@canonical.com> wrote:
> > >
> > > When virtnet_close is followed by virtnet_open, there is a slight cha=
nce
> > > that some TX completions remain unconsumed. Those are handled during =
the
> > > first NAPI poll, but since dql_reset occurs just beforehand, it can l=
ead
> > > to a crash [1].
> > >
> > > This issue can be reproduced by running: `while :; do ip l set DEV do=
wn;
> > > ip l set DEV up; done` under heavy network TX load from inside of the
> > > machine.
> > >
> > > To fix this, drain unconsumed TX completions if any before dql_reset,
> > > allowing BQL to start cleanly.
> > >
> > > ------------[ cut here ]------------
> > > kernel BUG at lib/dynamic_queue_limits.c:99!
> > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+=
 #2
> > > Tainted: [N]=3DTEST
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> > > BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > RIP: 0010:dql_completed+0x26b/0x290
> > > Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff =
0d
> > > 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 0=
1
> > > d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> > > RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> > > RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
> > > RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
> > > RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
> > > R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
> > > FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> > > knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
> > > PKRU: 55555554
> > > Call Trace:
> > >  <IRQ>
> > >  ? die+0x32/0x80
> > >  ? do_trap+0xd9/0x100
> > >  ? dql_completed+0x26b/0x290
> > >  ? dql_completed+0x26b/0x290
> > >  ? do_error_trap+0x6d/0xb0
> > >  ? dql_completed+0x26b/0x290
> > >  ? exc_invalid_op+0x4c/0x60
> > >  ? dql_completed+0x26b/0x290
> > >  ? asm_exc_invalid_op+0x16/0x20
> > >  ? dql_completed+0x26b/0x290
> > >  __free_old_xmit+0xff/0x170 [virtio_net]
> > >  free_old_xmit+0x54/0xc0 [virtio_net]
> > >  virtnet_poll+0xf4/0xe30 [virtio_net]
> > >  ? __update_load_avg_cfs_rq+0x264/0x2d0
> > >  ? update_curr+0x35/0x260
> > >  ? reweight_entity+0x1be/0x260
> > >  __napi_poll.constprop.0+0x28/0x1c0
> > >  net_rx_action+0x329/0x420
> > >  ? enqueue_hrtimer+0x35/0x90
> > >  ? trace_hardirqs_on+0x1d/0x80
> > >  ? kvm_sched_clock_read+0xd/0x20
> > >  ? sched_clock+0xc/0x30
> > >  ? kvm_sched_clock_read+0xd/0x20
> > >  ? sched_clock+0xc/0x30
> > >  ? sched_clock_cpu+0xd/0x1a0
> > >  handle_softirqs+0x138/0x3e0
> > >  do_softirq.part.0+0x89/0xc0
> > >  </IRQ>
> > >  <TASK>
> > >  __local_bh_enable_ip+0xa7/0xb0
> > >  virtnet_open+0xc8/0x310 [virtio_net]
> > >  __dev_open+0xfa/0x1b0
> > >  __dev_change_flags+0x1de/0x250
> > >  dev_change_flags+0x22/0x60
> > >  do_setlink.isra.0+0x2df/0x10b0
> > >  ? rtnetlink_rcv_msg+0x34f/0x3f0
> > >  ? netlink_rcv_skb+0x54/0x100
> > >  ? netlink_unicast+0x23e/0x390
> > >  ? netlink_sendmsg+0x21e/0x490
> > >  ? ____sys_sendmsg+0x31b/0x350
> > >  ? avc_has_perm_noaudit+0x67/0xf0
> > >  ? cred_has_capability.isra.0+0x75/0x110
> > >  ? __nla_validate_parse+0x5f/0xee0
> > >  ? __pfx___probestub_irq_enable+0x3/0x10
> > >  ? __create_object+0x5e/0x90
> > >  ? security_capable+0x3b/0x70
> > >  rtnl_newlink+0x784/0xaf0
> > >  ? avc_has_perm_noaudit+0x67/0xf0
> > >  ? cred_has_capability.isra.0+0x75/0x110
> > >  ? stack_depot_save_flags+0x24/0x6d0
> > >  ? __pfx_rtnl_newlink+0x10/0x10
> > >  rtnetlink_rcv_msg+0x34f/0x3f0
> > >  ? do_syscall_64+0x6c/0x180
> > >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > >  netlink_rcv_skb+0x54/0x100
> > >  netlink_unicast+0x23e/0x390
> > >  netlink_sendmsg+0x21e/0x490
> > >  ____sys_sendmsg+0x31b/0x350
> > >  ? copy_msghdr_from_user+0x6d/0xa0
> > >  ___sys_sendmsg+0x86/0xd0
> > >  ? __pte_offset_map+0x17/0x160
> > >  ? preempt_count_add+0x69/0xa0
> > >  ? __call_rcu_common.constprop.0+0x147/0x610
> > >  ? preempt_count_add+0x69/0xa0
> > >  ? preempt_count_add+0x69/0xa0
> > >  ? _raw_spin_trylock+0x13/0x60
> > >  ? trace_hardirqs_on+0x1d/0x80
> > >  __sys_sendmsg+0x66/0xc0
> > >  do_syscall_64+0x6c/0x180
> > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > RIP: 0033:0x7f41defe5b34
> > > Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 =
00
> > > f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 0=
0
> > > f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> > > RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002=
e
> > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
> > > RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
> > > RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
> > > R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
> > > R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
> > >  </TASK>
> > > [...]
> > > ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]--=
-
> > >
> > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > Cc: <stable@vger.kernel.org> # v6.11+
> > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > ---
> > >  drivers/net/virtio_net.c | 37 +++++++++++++++++++++++++++++--------
> > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 64c87bb48a41..3e36c0470600 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -513,7 +513,7 @@ static struct sk_buff *virtnet_skb_append_frag(st=
ruct sk_buff *head_skb,
> > >                                                struct sk_buff *curr_s=
kb,
> > >                                                struct page *page, voi=
d *buf,
> > >                                                int len, int truesize)=
;
> > > -static void virtnet_xsk_completed(struct send_queue *sq, int num);
> > > +static void virtnet_xsk_completed(struct send_queue *sq, int num, bo=
ol drain);
> > >
> > >  enum virtnet_xmit_type {
> > >         VIRTNET_XMIT_TYPE_SKB,
> > > @@ -580,7 +580,8 @@ static void sg_fill_dma(struct scatterlist *sg, d=
ma_addr_t addr, u32 len)
> > >  }
> > >
> > >  static void __free_old_xmit(struct send_queue *sq, struct netdev_que=
ue *txq,
> > > -                           bool in_napi, struct virtnet_sq_free_stat=
s *stats)
> > > +                           bool in_napi, struct virtnet_sq_free_stat=
s *stats,
> > > +                           bool drain)
> > >  {
> > >         struct xdp_frame *frame;
> > >         struct sk_buff *skb;
> > > @@ -620,7 +621,8 @@ static void __free_old_xmit(struct send_queue *sq=
, struct netdev_queue *txq,
> > >                         break;
> > >                 }
> > >         }
> > > -       netdev_tx_completed_queue(txq, stats->napi_packets, stats->na=
pi_bytes);
> > > +       if (!drain)
> > > +               netdev_tx_completed_queue(txq, stats->napi_packets, s=
tats->napi_bytes);
> > >  }
> > >
> > >  static void virtnet_free_old_xmit(struct send_queue *sq,
> > > @@ -628,10 +630,21 @@ static void virtnet_free_old_xmit(struct send_q=
ueue *sq,
> > >                                   bool in_napi,
> > >                                   struct virtnet_sq_free_stats *stats=
)
> > >  {
> > > -       __free_old_xmit(sq, txq, in_napi, stats);
> > > +       __free_old_xmit(sq, txq, in_napi, stats, false);
> > >
> > >         if (stats->xsk)
> > > -               virtnet_xsk_completed(sq, stats->xsk);
> > > +               virtnet_xsk_completed(sq, stats->xsk, false);
> > > +}
> > > +
> > > +static void virtnet_drain_old_xmit(struct send_queue *sq,
> > > +                                  struct netdev_queue *txq)
> > > +{
> > > +       struct virtnet_sq_free_stats stats =3D {0};
> > > +
> > > +       __free_old_xmit(sq, txq, false, &stats, true);
> > > +
> > > +       if (stats.xsk)
> > > +               virtnet_xsk_completed(sq, stats.xsk, true);
> > >  }
> >
> > Are we sure this can drain the queue? Note that the device is not stopp=
ed.
>
> Thanks for reviewing. netif_tx_wake_queue can be invoked before the "drai=
n"
> point I added e.g. via virtnet_config_changed_work, so it seems that I ne=
ed
> to ensure it's stopped (DRV_XOFF) before the "drain" and wake it afterwar=
ds.
> Please let me know if I=E2=80=99m mistaken.

Not sure I get you, but I meant we don't reset the device so it can
keep raising tx interrupts:

virtnet_drain_old_xmit()
netdev_tx_reset_queue()
skb_xmit_done()
napi_enable()
netdev_tx_completed_queue() // here we might still surprise the bql?

Thanks

>
> >
> > >
> > >  /* Converting between virtqueue no. and kernel tx/rx queue no.
> > > @@ -1499,7 +1512,8 @@ static bool virtnet_xsk_xmit(struct send_queue =
*sq, struct xsk_buff_pool *pool,
> > >         /* Avoid to wakeup napi meanless, so call __free_old_xmit ins=
tead of
> > >          * free_old_xmit().
> > >          */
> > > -       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), tr=
ue, &stats);
> > > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), tr=
ue,
> > > +                       &stats, false);
> > >
> > >         if (stats.xsk)
> > >                 xsk_tx_completed(sq->xsk_pool, stats.xsk);
> > > @@ -1556,10 +1570,13 @@ static int virtnet_xsk_wakeup(struct net_devi=
ce *dev, u32 qid, u32 flag)
> > >         return 0;
> > >  }
> > >
> > > -static void virtnet_xsk_completed(struct send_queue *sq, int num)
> > > +static void virtnet_xsk_completed(struct send_queue *sq, int num, bo=
ol drain)
> > >  {
> > >         xsk_tx_completed(sq->xsk_pool, num);
> > >
> > > +       if (drain)
> > > +               return;
> > > +
> > >         /* If this is called by rx poll, start_xmit and xdp xmit we s=
hould
> > >          * wakeup the tx napi to consume the xsk tx queue, because th=
e tx
> > >          * interrupt may not be triggered.
> > > @@ -3041,6 +3058,7 @@ static void virtnet_disable_queue_pair(struct v=
irtnet_info *vi, int qp_index)
> > >
> > >  static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> > >  {
> > > +       struct netdev_queue *txq =3D netdev_get_tx_queue(vi->dev, qp_=
index);
> > >         struct net_device *dev =3D vi->dev;
> > >         int err;
> > >
> > > @@ -3054,7 +3072,10 @@ static int virtnet_enable_queue_pair(struct vi=
rtnet_info *vi, int qp_index)
> > >         if (err < 0)
> > >                 goto err_xdp_reg_mem_model;
> > >
> > > -       netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index))=
;
> > > +       /* Drain any unconsumed TX skbs transmitted before the last v=
irtnet_close */
> > > +       virtnet_drain_old_xmit(&vi->sq[qp_index], txq);
> > > +
> > > +       netdev_tx_reset_queue(txq);
> > >         virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].na=
pi);
> > >         virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_in=
dex].napi);
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
> > Thanks
> >
>


