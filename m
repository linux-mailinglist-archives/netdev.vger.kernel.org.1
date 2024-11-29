Return-Path: <netdev+bounces-147802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A16D9DBEA4
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 03:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA366164DED
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAFC154423;
	Fri, 29 Nov 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOzNPLV3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694714D70B
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732846706; cv=none; b=Mz3/umo7MoOLWZpq2LkWs+6d6bfXPmulWecut2WDpOJEf26Pa/KYGLjJQxx7t43kS2VqBsXgoHFAbsEH/YAe8zhTVaItOZtNJcscpISjpijvzLghnD/wSRU/11atkc54l5u3Lgvueupedkq1kgox/udpfWsqneN+PxtTDHjoKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732846706; c=relaxed/simple;
	bh=aO+6DwEbp3byj/rCpOA7ujHOyLMFlcLb72RvilfN9VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh53QPlnzxFUCTTyvDX2EZfs9fRxAVfhZgaw1llT9MWWGpcJ78hzMYnnYmIhsfBkXnkZ1XWyhgfLkLMxD4AD0+vn8TjFy3LPtUqQUXnqKL881IIyWAsWWLfwDFRu2NXWB/G9Rtnjp0jKwrpGpiODS64nNh4SLa7VTxb3mPlx17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOzNPLV3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732846701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dMcGu6Dsg6ulMy0pVMpwTB8oqiI5/b14ykoOQKQjNLs=;
	b=XOzNPLV3mFeqtcJFwuFY179EMKzYQGp2QK6CkXaISsgrwqVuj3Cw4e5n8sYltfCH1w1M01
	APGOn1E5de9CQPJGA7m9b/ZV3yI34i34QOF2hAN55hc/oj3axN/FM1zFcm+zLt1kNLxD9H
	RJV8/yLTN8MNvm979aXpO0WovjfrFJk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-uoK2oJGkNN-0iYqWmVJ8ng-1; Thu, 28 Nov 2024 21:18:17 -0500
X-MC-Unique: uoK2oJGkNN-0iYqWmVJ8ng-1
X-Mimecast-MFC-AGG-ID: uoK2oJGkNN-0iYqWmVJ8ng
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee5f6fa3feso59368a91.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 18:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732846696; x=1733451496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMcGu6Dsg6ulMy0pVMpwTB8oqiI5/b14ykoOQKQjNLs=;
        b=QxOcqnaVgdbMTI5V6Kj+zRbuF23Z/TvPzeUaX/opOrSgoAoX37NU3KnwheVif5SwpB
         /Vr9I3J/JIuKsDbXTZynPUmzSaEzMNeVfzaqvLfyuERxEjqvflqNky7gj5vI16wWWGHx
         bMNlesakhAMhS9AKEeU4laWygqOVpm9GzH3+YDUDryT8wcaaFxHdSpOTOAfEa1ri3EBn
         ZhcRxhjX+tD6EDbmBcbN6KpZwy9+/dsYzkbfjvARelktb80dc1B5JCfq/FuHOhB1NVVm
         eWZdMASrUZUHmhsqjNwq2eGO/1rrz166LW+JtLG1HkTTSEZNUovOEcbxfXgv4C6Yv/wx
         ydtA==
X-Forwarded-Encrypted: i=1; AJvYcCU4S0Ndxw6tbUkAtD2lRDrmqafrE+01Ep6eQt7AVoBoCf3I6EmlDKgTTdKVYjf18ZT/oWl0CZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXfSZNWfIRXnbIJxFjJMGtyFkwmkqpsbEepQXqP8skZH80daV
	jAzzY+Xq3b97rsPpI41pgghqkEDeD39KhtrEYPfyC5XWczWwDVyMZ122iD7RcHTJXWDMyMIecFw
	dLxahqBB3vE3JrTqLebbb+Xf5Md5T48ssljFzMo3XTqqLB3fKJuBpVvdHi9fAMJUHrMX2BoVtjV
	ZpBUNtPmLvd5TKSYtxQaDFintZH4Iz
X-Gm-Gg: ASbGncuuj10koGDh28Vvr9r3Q+eywPwKYEHmJ3nRIwxIc44g8K2C/0m1OjewQ/Lb8Yd
	YUL6LEypToxTf5Tzpe29lMfcQoZqThM4M
X-Received: by 2002:a17:90b:1dd0:b0:2ea:7595:21ec with SMTP id 98e67ed59e1d1-2ee08e9d2a5mr11682232a91.1.1732846696158;
        Thu, 28 Nov 2024 18:18:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbzocn5AxcuTwuKjWxJEQHaO9fR3WP9AiU5OFoD6Q/hZ7J7UxglTXo8FhcMiEyE4uDPDIRQtrI38QbgdrbkNw=
X-Received: by 2002:a17:90b:1dd0:b0:2ea:7595:21ec with SMTP id
 98e67ed59e1d1-2ee08e9d2a5mr11682198a91.1.1732846695565; Thu, 28 Nov 2024
 18:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126024200.2371546-1-koichiro.den@canonical.com>
 <CACGkMEsJ1X-u=djO2=kJzZdpZH5SX560V9osdpDuySXtfBMpuw@mail.gmail.com>
 <6lkdqvbnlntx3cno5qi7c4nks2ub3bkaycsuq7p433c4vemcmf@fwnhqbo5ehaw>
 <CACGkMEvR4+_iRAFACkXLgX-hGwjfOgd3emiyquzxUHL9wC-b=g@mail.gmail.com>
 <uwpyhnvavs6gnagujf2etse3q4c7vgjtej5bi34546isuefmgk@ebkfjs3wagsp>
 <CACGkMEvmBEfMwko-wJJ_78w+1QhN=r1zJ4wbaCJ1L9TU1Uo1pQ@mail.gmail.com> <judg4yj4adez5y3tm6lojouf6uh7ge3nice2npzzvwklpluj6t@oicfewgnwbll>
In-Reply-To: <judg4yj4adez5y3tm6lojouf6uh7ge3nice2npzzvwklpluj6t@oicfewgnwbll>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Nov 2024 10:18:04 +0800
Message-ID: <CACGkMEu_9aeb5xzKd7r+OFfud=kWOZYREa-8GcDzzppceKszjw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: drain unconsumed tx completions if any before dql_reset
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 12:25=E2=80=AFPM Koichiro Den
<koichiro.den@canonical.com> wrote:
>
> On Thu, Nov 28, 2024 at 10:57:01AM +0800, Jason Wang wrote:
> > On Wed, Nov 27, 2024 at 12:08=E2=80=AFPM Koichiro Den
> > <koichiro.den@canonical.com> wrote:
> > >
> > > On Wed, Nov 27, 2024 at 11:24:15AM +0800, Jason Wang wrote:
> > > > On Tue, Nov 26, 2024 at 12:44=E2=80=AFPM Koichiro Den
> > > > <koichiro.den@canonical.com> wrote:
> > > > >
> > > > > On Tue, Nov 26, 2024 at 11:50:17AM +0800, Jason Wang wrote:
> > > > > > On Tue, Nov 26, 2024 at 10:42=E2=80=AFAM Koichiro Den
> > > > > > <koichiro.den@canonical.com> wrote:
> > > > > > >
> > > > > > > When virtnet_close is followed by virtnet_open, there is a sl=
ight chance
> > > > > > > that some TX completions remain unconsumed. Those are handled=
 during the
> > > > > > > first NAPI poll, but since dql_reset occurs just beforehand, =
it can lead
> > > > > > > to a crash [1].
> > > > > > >
> > > > > > > This issue can be reproduced by running: `while :; do ip l se=
t DEV down;
> > > > > > > ip l set DEV up; done` under heavy network TX load from insid=
e of the
> > > > > > > machine.
> > > > > > >
> > > > > > > To fix this, drain unconsumed TX completions if any before dq=
l_reset,
> > > > > > > allowing BQL to start cleanly.
> > > > > > >
> > > > > > > ------------[ cut here ]------------
> > > > > > > kernel BUG at lib/dynamic_queue_limits.c:99!
> > > > > > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > > > > CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-ne=
xt_main+ #2
> > > > > > > Tainted: [N]=3DTEST
> > > > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> > > > > > > BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > > > > > RIP: 0010:dql_completed+0x26b/0x290
> > > > > > > Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 5=
8 65 ff 0d
> > > > > > > 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <=
0f> 0b 01
> > > > > > > d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> > > > > > > RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> > > > > > > RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 000000008019=
0009
> > > > > > > RDX: 0000000000000000 RSI: 000000000000006a RDI: 000000000000=
0000
> > > > > > > RBP: ffff888102398c00 R08: 0000000000000000 R09: 000000000000=
0000
> > > > > > > R10: 00000000000000ca R11: 0000000000015681 R12: 000000000000=
0001
> > > > > > > R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107a=
ca40
> > > > > > > FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> > > > > > > knlGS:0000000000000000
> > > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > > CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 000000000077=
2ef0
> > > > > > > PKRU: 55555554
> > > > > > > Call Trace:
> > > > > > >  <IRQ>
> > > > > > >  ? die+0x32/0x80
> > > > > > >  ? do_trap+0xd9/0x100
> > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > >  ? do_error_trap+0x6d/0xb0
> > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > >  ? exc_invalid_op+0x4c/0x60
> > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > > > >  ? dql_completed+0x26b/0x290
> > > > > > >  __free_old_xmit+0xff/0x170 [virtio_net]
> > > > > > >  free_old_xmit+0x54/0xc0 [virtio_net]
> > > > > > >  virtnet_poll+0xf4/0xe30 [virtio_net]
> > > > > > >  ? __update_load_avg_cfs_rq+0x264/0x2d0
> > > > > > >  ? update_curr+0x35/0x260
> > > > > > >  ? reweight_entity+0x1be/0x260
> > > > > > >  __napi_poll.constprop.0+0x28/0x1c0
> > > > > > >  net_rx_action+0x329/0x420
> > > > > > >  ? enqueue_hrtimer+0x35/0x90
> > > > > > >  ? trace_hardirqs_on+0x1d/0x80
> > > > > > >  ? kvm_sched_clock_read+0xd/0x20
> > > > > > >  ? sched_clock+0xc/0x30
> > > > > > >  ? kvm_sched_clock_read+0xd/0x20
> > > > > > >  ? sched_clock+0xc/0x30
> > > > > > >  ? sched_clock_cpu+0xd/0x1a0
> > > > > > >  handle_softirqs+0x138/0x3e0
> > > > > > >  do_softirq.part.0+0x89/0xc0
> > > > > > >  </IRQ>
> > > > > > >  <TASK>
> > > > > > >  __local_bh_enable_ip+0xa7/0xb0
> > > > > > >  virtnet_open+0xc8/0x310 [virtio_net]
> > > > > > >  __dev_open+0xfa/0x1b0
> > > > > > >  __dev_change_flags+0x1de/0x250
> > > > > > >  dev_change_flags+0x22/0x60
> > > > > > >  do_setlink.isra.0+0x2df/0x10b0
> > > > > > >  ? rtnetlink_rcv_msg+0x34f/0x3f0
> > > > > > >  ? netlink_rcv_skb+0x54/0x100
> > > > > > >  ? netlink_unicast+0x23e/0x390
> > > > > > >  ? netlink_sendmsg+0x21e/0x490
> > > > > > >  ? ____sys_sendmsg+0x31b/0x350
> > > > > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > > > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > > > > >  ? __nla_validate_parse+0x5f/0xee0
> > > > > > >  ? __pfx___probestub_irq_enable+0x3/0x10
> > > > > > >  ? __create_object+0x5e/0x90
> > > > > > >  ? security_capable+0x3b/0x70
> > > > > > >  rtnl_newlink+0x784/0xaf0
> > > > > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > > > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > > > > >  ? stack_depot_save_flags+0x24/0x6d0
> > > > > > >  ? __pfx_rtnl_newlink+0x10/0x10
> > > > > > >  rtnetlink_rcv_msg+0x34f/0x3f0
> > > > > > >  ? do_syscall_64+0x6c/0x180
> > > > > > >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > > > > > >  netlink_rcv_skb+0x54/0x100
> > > > > > >  netlink_unicast+0x23e/0x390
> > > > > > >  netlink_sendmsg+0x21e/0x490
> > > > > > >  ____sys_sendmsg+0x31b/0x350
> > > > > > >  ? copy_msghdr_from_user+0x6d/0xa0
> > > > > > >  ___sys_sendmsg+0x86/0xd0
> > > > > > >  ? __pte_offset_map+0x17/0x160
> > > > > > >  ? preempt_count_add+0x69/0xa0
> > > > > > >  ? __call_rcu_common.constprop.0+0x147/0x610
> > > > > > >  ? preempt_count_add+0x69/0xa0
> > > > > > >  ? preempt_count_add+0x69/0xa0
> > > > > > >  ? _raw_spin_trylock+0x13/0x60
> > > > > > >  ? trace_hardirqs_on+0x1d/0x80
> > > > > > >  __sys_sendmsg+0x66/0xc0
> > > > > > >  do_syscall_64+0x6c/0x180
> > > > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > RIP: 0033:0x7f41defe5b34
> > > > > > > Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1=
f 44 00 00
> > > > > > > f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <=
48> 3d 00
> > > > > > > f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> > > > > > > RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 0000000=
00000002e
> > > > > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe=
5b34
> > > > > > > RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 000000000000=
0003
> > > > > > > RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 000000000000=
0001
> > > > > > > R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 000000000000=
0003
> > > > > > > R13: 0000000067452259 R14: 0000556ccc28b040 R15: 000000000000=
0000
> > > > > > >  </TASK>
> > > > > > > [...]
> > > > > > > ---[ end Kernel panic - not syncing: Fatal exception in inter=
rupt ]---
> > > > > > >
> > > > > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue =
Limits")
> > > > > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 37 +++++++++++++++++++++++++++++-=
-------
> > > > > > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_ne=
t.c
> > > > > > > index 64c87bb48a41..3e36c0470600 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -513,7 +513,7 @@ static struct sk_buff *virtnet_skb_append=
_frag(struct sk_buff *head_skb,
> > > > > > >                                                struct sk_buff=
 *curr_skb,
> > > > > > >                                                struct page *p=
age, void *buf,
> > > > > > >                                                int len, int t=
ruesize);
> > > > > > > -static void virtnet_xsk_completed(struct send_queue *sq, int=
 num);
> > > > > > > +static void virtnet_xsk_completed(struct send_queue *sq, int=
 num, bool drain);
> > > > > > >
> > > > > > >  enum virtnet_xmit_type {
> > > > > > >         VIRTNET_XMIT_TYPE_SKB,
> > > > > > > @@ -580,7 +580,8 @@ static void sg_fill_dma(struct scatterlis=
t *sg, dma_addr_t addr, u32 len)
> > > > > > >  }
> > > > > > >
> > > > > > >  static void __free_old_xmit(struct send_queue *sq, struct ne=
tdev_queue *txq,
> > > > > > > -                           bool in_napi, struct virtnet_sq_f=
ree_stats *stats)
> > > > > > > +                           bool in_napi, struct virtnet_sq_f=
ree_stats *stats,
> > > > > > > +                           bool drain)
> > > > > > >  {
> > > > > > >         struct xdp_frame *frame;
> > > > > > >         struct sk_buff *skb;
> > > > > > > @@ -620,7 +621,8 @@ static void __free_old_xmit(struct send_q=
ueue *sq, struct netdev_queue *txq,
> > > > > > >                         break;
> > > > > > >                 }
> > > > > > >         }
> > > > > > > -       netdev_tx_completed_queue(txq, stats->napi_packets, s=
tats->napi_bytes);
> > > > > > > +       if (!drain)
> > > > > > > +               netdev_tx_completed_queue(txq, stats->napi_pa=
ckets, stats->napi_bytes);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void virtnet_free_old_xmit(struct send_queue *sq,
> > > > > > > @@ -628,10 +630,21 @@ static void virtnet_free_old_xmit(struc=
t send_queue *sq,
> > > > > > >                                   bool in_napi,
> > > > > > >                                   struct virtnet_sq_free_stat=
s *stats)
> > > > > > >  {
> > > > > > > -       __free_old_xmit(sq, txq, in_napi, stats);
> > > > > > > +       __free_old_xmit(sq, txq, in_napi, stats, false);
> > > > > > >
> > > > > > >         if (stats->xsk)
> > > > > > > -               virtnet_xsk_completed(sq, stats->xsk);
> > > > > > > +               virtnet_xsk_completed(sq, stats->xsk, false);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void virtnet_drain_old_xmit(struct send_queue *sq,
> > > > > > > +                                  struct netdev_queue *txq)
> > > > > > > +{
> > > > > > > +       struct virtnet_sq_free_stats stats =3D {0};
> > > > > > > +
> > > > > > > +       __free_old_xmit(sq, txq, false, &stats, true);
> > > > > > > +
> > > > > > > +       if (stats.xsk)
> > > > > > > +               virtnet_xsk_completed(sq, stats.xsk, true);
> > > > > > >  }
> > > > > >
> > > > > > Are we sure this can drain the queue? Note that the device is n=
ot stopped.
> > > > >
> > > > > Thanks for reviewing. netif_tx_wake_queue can be invoked before t=
he "drain"
> > > > > point I added e.g. via virtnet_config_changed_work, so it seems t=
hat I need
> > > > > to ensure it's stopped (DRV_XOFF) before the "drain" and wake it =
afterwards.
> > > > > Please let me know if I=E2=80=99m mistaken.
> > > >
> > > > Not sure I get you, but I meant we don't reset the device so it can
> > >
> > > I was wondering whether there would be a scenario where the tx queue =
is
> > > woken up and some new packets from the upper layer reach dql_queued()
> > > before the drain point, which also could cause the crash.
> >
> > Ok.
> >
> > >
> > > > keep raising tx interrupts:
> > > >
> > > > virtnet_drain_old_xmit()
> > > > netdev_tx_reset_queue()
> > > > skb_xmit_done()
> > > > napi_enable()
> > > > netdev_tx_completed_queue() // here we might still surprise the bql=
?
> > >
> > > Indeed, virtqueue_disable_cb() is needed before the drain point.
> >
> > Two problems:
> >
> > 1) device/virtqueue is not reset, it can still process the packets
> > after virtnet_drain_old_xmit()
> > 2) virtqueue_disable_cb() just does its best effort, it can't
> > guarantee no interrupt after that.
> >
> > To drain TX, the only reliable seems to be:
> >
> > 1) reset a virtqueue (or a device)
> > 2) drain by using free_old_xmit()
> > 3) netif_reset_tx_queue() // btw this seems to be better done in close =
not open
>
> Thank you for the clarification.
> As for 1), I may be missing something but what if VIRTIO_F_RING_RESET is
> not supported. A device reset in this context feels a bit excessive to me
> (just my two cents though) if in virtnet_open, so as you said, it seems
> better done in close in that regard as well.

Probably, most NIC has a way to stop its TX which is missed in
virtio-net. So we don't have more choices other than device reset when
there's no virtqueue reset.

Or we can limit the BQL to virtqueue reset, AF_XDP used to suffer from
the exact issue when there's no virtqueue reset. That's why virtqueue
reset is invented and AF_XDP is limited to virtqueue reset.

>
> >
> > Or I wonder if this can be easily fixed by just removing
> > netdev_tx_reset_queue()?
>
> Perhaps introducing a variant of dql_reset() that clears all stall histor=
y
> would suffice? To avoid excessively long stall_max to be possibly recorde=
d.

Not sure, it looks like the problem still, bql might still be
surprised when it might get completed tx packets when it think it
hasn't sent any?

Thanks

>
> Thanks
>
> >
> > Thanks
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > >  /* Converting between virtqueue no. and kernel tx/rx queue n=
o.
> > > > > > > @@ -1499,7 +1512,8 @@ static bool virtnet_xsk_xmit(struct sen=
d_queue *sq, struct xsk_buff_pool *pool,
> > > > > > >         /* Avoid to wakeup napi meanless, so call __free_old_=
xmit instead of
> > > > > > >          * free_old_xmit().
> > > > > > >          */
> > > > > > > -       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi-=
>sq), true, &stats);
> > > > > > > +       __free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi-=
>sq), true,
> > > > > > > +                       &stats, false);
> > > > > > >
> > > > > > >         if (stats.xsk)
> > > > > > >                 xsk_tx_completed(sq->xsk_pool, stats.xsk);
> > > > > > > @@ -1556,10 +1570,13 @@ static int virtnet_xsk_wakeup(struct =
net_device *dev, u32 qid, u32 flag)
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > -static void virtnet_xsk_completed(struct send_queue *sq, int=
 num)
> > > > > > > +static void virtnet_xsk_completed(struct send_queue *sq, int=
 num, bool drain)
> > > > > > >  {
> > > > > > >         xsk_tx_completed(sq->xsk_pool, num);
> > > > > > >
> > > > > > > +       if (drain)
> > > > > > > +               return;
> > > > > > > +
> > > > > > >         /* If this is called by rx poll, start_xmit and xdp x=
mit we should
> > > > > > >          * wakeup the tx napi to consume the xsk tx queue, be=
cause the tx
> > > > > > >          * interrupt may not be triggered.
> > > > > > > @@ -3041,6 +3058,7 @@ static void virtnet_disable_queue_pair(=
struct virtnet_info *vi, int qp_index)
> > > > > > >
> > > > > > >  static int virtnet_enable_queue_pair(struct virtnet_info *vi=
, int qp_index)
> > > > > > >  {
> > > > > > > +       struct netdev_queue *txq =3D netdev_get_tx_queue(vi->=
dev, qp_index);
> > > > > > >         struct net_device *dev =3D vi->dev;
> > > > > > >         int err;
> > > > > > >
> > > > > > > @@ -3054,7 +3072,10 @@ static int virtnet_enable_queue_pair(s=
truct virtnet_info *vi, int qp_index)
> > > > > > >         if (err < 0)
> > > > > > >                 goto err_xdp_reg_mem_model;
> > > > > > >
> > > > > > > -       netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp=
_index));
> > > > > > > +       /* Drain any unconsumed TX skbs transmitted before th=
e last virtnet_close */
> > > > > > > +       virtnet_drain_old_xmit(&vi->sq[qp_index], txq);
> > > > > > > +
> > > > > > > +       netdev_tx_reset_queue(txq);
> > > > > > >         virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_i=
ndex].napi);
> > > > > > >         virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->=
sq[qp_index].napi);
> > > > > > >
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > >
> > >
> >
>


