Return-Path: <netdev+bounces-149249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB39E4E58
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DA4281171
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CFB19F475;
	Thu,  5 Dec 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2c6Aox6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46344192D69
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383845; cv=none; b=tfGRGi8vWM2ljWdyhW91Wnj7sCpeLsN4CNGIIH5PWU+RH8BEGXaELRTit0hBaRcrbutWIbmBoxQmAD9L0HAzkGhwgH3KGnXLbH27n9/+tF4nniq8EXLFXTsRA6XtSg5Yyy11RFsTf+E7Cs6ACUOyns818Ve3f4d/R+h66bQej+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383845; c=relaxed/simple;
	bh=NqD5sF58CDTkWGLmdQtoA41Xrp3VVW6IOdv4y3n/a+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWsHPUr3OJcd05WAC/PcGnwNqb49z+eLvdZQsk0k9ctOBlvoKR4hcmrw2U8MZ11ioACR9R6L77iJbaRpgyjliH0N0isS8YW4hl4JfL6+E4Wx5d/0ByAxb86ywV8DG3eP+IlViY9IZQdYid5G8zHA5ERffQ4HbngQZ4eYHljYYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2c6Aox6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uglk1RW530eU09b0FpjEe0R39b8xto8c48s2s/SUfbY=;
	b=A2c6Aox6u1dr/kxbIkaB/YU9NpBaVmrm8g1rk3/wrMtIdiK0aIhc3Tc8/BoHKnS5hmpVX+
	bFPIS7TW5cIKwJD18kaS3FCFD4l1nAw7zEnI+dEI/48QhWeV8C+MS7vkHoAlaTqNWUVM2A
	E/pJuSt8OeuOb+gysa4ciQP/lJw4ssg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-bJ3Rki2aNQWbqNp3EpFsSg-1; Thu, 05 Dec 2024 02:30:40 -0500
X-MC-Unique: bJ3Rki2aNQWbqNp3EpFsSg-1
X-Mimecast-MFC-AGG-ID: bJ3Rki2aNQWbqNp3EpFsSg
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7fd088ee48aso525403a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 23:30:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383839; x=1733988639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uglk1RW530eU09b0FpjEe0R39b8xto8c48s2s/SUfbY=;
        b=WaEmq0AnIP/IXnvDgn3VSEOHFDJqmOExkxL6P5V/XpX8IEx1A2c3pAS1eUKP5tQVFB
         ea6lJEWXOz9UDP9wyw870DbQszu1z6/k/hckh7fWSYxzWO+wjDYOgThU/EVESrPhrPd/
         jWOcHB7NT59KWYuuvWqfJnf/BKtZLyHhi3u8XtabirMcM58ZpoKhxIkaya2wiBsEL0iX
         QyCNG0Bio8ZmHqx40ENBkkq9BB+sT9wtsaYrMu5g9iSzKVCtjSBsSZYlpM7wOWjJ8tQO
         04Bmdxt3Lu4391GLXaW+VxTqIl7mA0YguQ06wJ/SkdfE8cKrPZA9TCafN1UGDNA/Taln
         3NTw==
X-Forwarded-Encrypted: i=1; AJvYcCWHvVg0yMVeXmFp43GLZB7FT31PUXfiIv67KD4cOb4AGlImNNNqtXkDOFb/5xU3COV4D5en3LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWX1i1cfd3eHijy5E4u0rYERA53H/TH9j9jJhJG2I4xV/+JR3u
	RDaMsJkwpD2g3bZ6BJ993E3x+i4SCjuLiPGqjEn9s1UEWMVdV0otJgD/0lPo9Z/YKefFK2P21hV
	MOvitBxJzPMU8rZeGCOEnggjX8c3eYXWBLspL3XlvGiYXYB7UhEThwmLg07ndRn4rUnwW4nOptK
	weGou8fnJc4LJl2xuXiwN8oxMNFaLu
X-Gm-Gg: ASbGnctqqcrzd3ZPph3tJ1/U23GzdD1o+xdTB6MmGQws0G7UcjIcGg0bmc/QgwN01Vk
	9c0E9NAlBZOc36dQXnSOb50WUrw+O8jb/W2B/
X-Received: by 2002:a17:90b:4d8a:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2ef011fb9ccmr13255024a91.10.1733383839401;
        Wed, 04 Dec 2024 23:30:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMMwL1bTc4PoqKqF8izVq/aJ/lbpuCSSTuhCaNG73vAilLr4eVAuuBIyxLEccKN5ycgYejTdQgAEKMCqurazQ=
X-Received: by 2002:a17:90b:4d8a:b0:2ea:3f34:f194 with SMTP id
 98e67ed59e1d1-2ef011fb9ccmr13254989a91.10.1733383838970; Wed, 04 Dec 2024
 23:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-2-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-2-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:30:27 +0800
Message-ID: <CACGkMEstoBomsuV+hvAbG-2JH8irKcwhG0eq2JhCK-ax1RNY+g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] virtio_net: correct netdev_tx_reset_queue()
 invocation point
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtnet_close is followed by virtnet_open, some TX completions can
> possibly remain unconsumed, until they are finally processed during the
> first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> before RX napi enable") was not sufficient to eliminate all BQL crash
> cases for virtio-net.
>
> This issue can be reproduced with the latest net-next master by running:
> `while :; do ip l set DEV down; ip l set DEV up; done` under heavy networ=
k
> TX load from inside the machine.
>
> netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
> the device is not stopped in any case. For BQL core part, it's just like
> traffic nearly ceases to exist for some period. For stall detector added
> to BQL, even if virtnet_close could somehow lead to some TX completions
> delayed for long, followed by virtnet_open, we can just take it as stall
> as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
> based on BQL"). Note also that users can still reset stall_max via sysfs.
>
> So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
> eliminates the BQL crashes. Note that netdev_tx_reset_queue() is now
> explicitly required in freeze/restore path, so this patch adds it to
> free_unused_bufs().
>
> [1]:
> ------------[ cut here ]------------
> kernel BUG at lib/dynamic_queue_limits.c:99!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
> Tainted: [N]=3DTEST
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:dql_completed+0x26b/0x290
> Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
> 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
> d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
> RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
> RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
> R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
> FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
> PKRU: 55555554
> Call Trace:
>  <IRQ>
>  ? die+0x32/0x80
>  ? do_trap+0xd9/0x100
>  ? dql_completed+0x26b/0x290
>  ? dql_completed+0x26b/0x290
>  ? do_error_trap+0x6d/0xb0
>  ? dql_completed+0x26b/0x290
>  ? exc_invalid_op+0x4c/0x60
>  ? dql_completed+0x26b/0x290
>  ? asm_exc_invalid_op+0x16/0x20
>  ? dql_completed+0x26b/0x290
>  __free_old_xmit+0xff/0x170 [virtio_net]
>  free_old_xmit+0x54/0xc0 [virtio_net]
>  virtnet_poll+0xf4/0xe30 [virtio_net]
>  ? __update_load_avg_cfs_rq+0x264/0x2d0
>  ? update_curr+0x35/0x260
>  ? reweight_entity+0x1be/0x260
>  __napi_poll.constprop.0+0x28/0x1c0
>  net_rx_action+0x329/0x420
>  ? enqueue_hrtimer+0x35/0x90
>  ? trace_hardirqs_on+0x1d/0x80
>  ? kvm_sched_clock_read+0xd/0x20
>  ? sched_clock+0xc/0x30
>  ? kvm_sched_clock_read+0xd/0x20
>  ? sched_clock+0xc/0x30
>  ? sched_clock_cpu+0xd/0x1a0
>  handle_softirqs+0x138/0x3e0
>  do_softirq.part.0+0x89/0xc0
>  </IRQ>
>  <TASK>
>  __local_bh_enable_ip+0xa7/0xb0
>  virtnet_open+0xc8/0x310 [virtio_net]
>  __dev_open+0xfa/0x1b0
>  __dev_change_flags+0x1de/0x250
>  dev_change_flags+0x22/0x60
>  do_setlink.isra.0+0x2df/0x10b0
>  ? rtnetlink_rcv_msg+0x34f/0x3f0
>  ? netlink_rcv_skb+0x54/0x100
>  ? netlink_unicast+0x23e/0x390
>  ? netlink_sendmsg+0x21e/0x490
>  ? ____sys_sendmsg+0x31b/0x350
>  ? avc_has_perm_noaudit+0x67/0xf0
>  ? cred_has_capability.isra.0+0x75/0x110
>  ? __nla_validate_parse+0x5f/0xee0
>  ? __pfx___probestub_irq_enable+0x3/0x10
>  ? __create_object+0x5e/0x90
>  ? security_capable+0x3b/0x70
>  rtnl_newlink+0x784/0xaf0
>  ? avc_has_perm_noaudit+0x67/0xf0
>  ? cred_has_capability.isra.0+0x75/0x110
>  ? stack_depot_save_flags+0x24/0x6d0
>  ? __pfx_rtnl_newlink+0x10/0x10
>  rtnetlink_rcv_msg+0x34f/0x3f0
>  ? do_syscall_64+0x6c/0x180
>  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x54/0x100
>  netlink_unicast+0x23e/0x390
>  netlink_sendmsg+0x21e/0x490
>  ____sys_sendmsg+0x31b/0x350
>  ? copy_msghdr_from_user+0x6d/0xa0
>  ___sys_sendmsg+0x86/0xd0
>  ? __pte_offset_map+0x17/0x160
>  ? preempt_count_add+0x69/0xa0
>  ? __call_rcu_common.constprop.0+0x147/0x610
>  ? preempt_count_add+0x69/0xa0
>  ? preempt_count_add+0x69/0xa0
>  ? _raw_spin_trylock+0x13/0x60
>  ? trace_hardirqs_on+0x1d/0x80
>  __sys_sendmsg+0x66/0xc0
>  do_syscall_64+0x6c/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f41defe5b34
> Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
> f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
> RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
> RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
> R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
> R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
>  </TASK>
> [...]
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


