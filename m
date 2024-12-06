Return-Path: <netdev+bounces-149531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABFA9E622A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF711884520
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22A17991;
	Fri,  6 Dec 2024 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="O3NGbEKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71417B652
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733444880; cv=none; b=n7zb/Ha5OzABa80Usx7sXMIxuUYaryltAdQd2G/owaAzB2E3QvdaJ3WjhfG5azun5KeY3ZsgK1SmihQCuK8ziX0mtYSyJCQob4ikDXNsWU1y1ejfu8y4cfIUBI78ZWJeh4cTDmXbWf2ER3h4M1tvMpSALCwGUCxSF/9D+1uRD5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733444880; c=relaxed/simple;
	bh=gurEB20qLPc4NxxkGx7vvw608KFI5HGmD9RkOyPkmV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXFXcLn3oaXdIkFLJLfKB9+5aHXcT3X+zhjjMWvCoA6+lYro9enXBzofB4e4f0VUgYOu3MVXqxztDv27nIz1iFTs5bf+hcwCRgegpK2/xSXd25tFtIe8ph1Dph0mdytscI5ebCFaxOyvbrL9fDHHA0qqHDnaJwvq182VZTTkKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=O3NGbEKm; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BFB640CEB
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 00:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733444876;
	bh=MivuSGCdKstLxqo59xhVbWuDzb+dNtWFJm5+HOIPd5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=O3NGbEKmY6h5Hd8aU5U4M1WOHFGXoXvhEuCJiPPe9fF17OYQeKFJHv4R0nUqWImN+
	 1tuW/jNE6HrWvPe0qr1RDp3XXQPs5XC2msHqaVniFEgAdtPrpUgPrZGU1cfpHf5j/e
	 32bI49sCXk6yf70kq8+nvDp+N4CVPt70DcgWun2pfyBtzkxN40opT2x83EQKp5qNT3
	 yhPMNFyYlVECthhK8FuuIaS+sYkrG0QxpESDTcAfLiIZ2kWdjBRYpicv/OOYvATOqC
	 Ljw65x2D+aIaLgjPgFdIMv+VW7mp3Daqtl69VMOJY3Zre6ODZnbx4SV3PrsGXjrTLu
	 KjMEpiFTksqyA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-215c54e5ceeso13769655ad.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 16:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733444875; x=1734049675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MivuSGCdKstLxqo59xhVbWuDzb+dNtWFJm5+HOIPd5E=;
        b=VsPSXJimj36Pw0o/Qtf5BdKW2GVdmSLqX8jt9y0OOHhl8lLgYz4NUpuwSwvmiscYyA
         0tpjPsgB0JjZ0rF07+wZC91CVOpdA+aZaDpKJFZqKfEsZmokzl1K7ru5XLpOVHpE8cjN
         pP9FcB6KXwsgsVDi1zvUVdhFa8LFNfp6G4RbuRkthQ2xwjQS9Br0mtpo5iop6ZfKw4fc
         YjsVitsPEtjMg6AUyZDPpohHfacDgafzvXztt5FCYS8kYW61drHHDpwxrf9QUiku9Sv0
         5jrU0/3G960OYe+c1DhkTN3Tr0Jyqy61yLV8Bha5wr/cvdXOSP8R2463z36jHc0++To9
         pCFg==
X-Forwarded-Encrypted: i=1; AJvYcCVgeOURP2ucGXFA8mJ+ISj468C+50qnAvefboFWR0nzWHEZ3hMvRX8AUuhKTdffck7qzhd/nvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLiziKQrRoTKJB1AaTmw0b8you4b7JRyC2b0jWP0JX+Bqii+c
	LGTFGgzTBbuwS5YzCgKD7epO+WNTskt8tCdU4CO/aFNhehr6R2+ojajrQbYAuV+JXNX0w69Pog6
	d71r3yif2zxrjwgcK78j0jjfbTi3rv6p5yanmWTKyRO3o4nku2hKocFbEpglWKZjgBhoP7w==
X-Gm-Gg: ASbGncs8EOrMzkKAIH5kC1s+ZL2uBTYREtDzbAD4xXqrLuxDs54a4xsXCJO4J4xF48j
	Jr0IE7fDE6bGu2vHGBpCIX2SNTPiZB6EfWoQeMqjNs4/0MN9eWGz2tFq0AR13PjnUrY1270BKLT
	YMIvxzZKcFCNY6ww20OSvPJFLsgY8xr2QaPialSBWu3ojY5xhKoigRxDcWiorqDClCbGGG3CL7a
	aL0UrOIfhRqNDapGx0ySRKPyyJtPJeB3EeKeerkz3QvJ+/dj5sS
X-Received: by 2002:a17:902:e5cd:b0:215:9091:4f56 with SMTP id d9443c01a7336-21614d4528cmr15324305ad.14.1733444874997;
        Thu, 05 Dec 2024 16:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh/VvFCT5z5C2KnGLcEdyl7MPwt/FRnLMuLWN2yQxFP70ZRl02J3qZnmYbnfdapLquaCmkhQ==
X-Received: by 2002:a17:902:e5cd:b0:215:9091:4f56 with SMTP id d9443c01a7336-21614d4528cmr15323905ad.14.1733444874553;
        Thu, 05 Dec 2024 16:27:54 -0800 (PST)
Received: from localhost ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a8f474sm1822663b3a.97.2024.12.05.16.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:27:54 -0800 (PST)
Date: Fri, 6 Dec 2024 09:27:52 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/7] virtio_net: correct
 netdev_tx_reset_queue() invocation point
Message-ID: <wiioftpgwh7j2l2ohepyp2lygqv4t45o57t7tzicfvqrwfpzz6@wrnnnivyargv>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-2-koichiro.den@canonical.com>
 <20241205052729-mutt-send-email-mst@kernel.org>
 <nmjiptygbpqfcveclpzmpgczd3geir72kkczqixfucpgrl3g7u@6dzpd7qijvdm>
 <cv7ph7yna6d5a37k7hoxplyzrbmrdxrcjd67nrttevsta3r54h@35ztxhqaczqd>
 <20241205101611-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205101611-mutt-send-email-mst@kernel.org>

On Thu, Dec 05, 2024 at 10:17:59AM -0500, Michael S. Tsirkin wrote:
> On Thu, Dec 05, 2024 at 10:16:35PM +0900, Koichiro Den wrote:
> > On Thu, Dec 05, 2024 at 09:43:38PM +0900, Koichiro Den wrote:
> > > On Thu, Dec 05, 2024 at 05:33:36AM -0500, Michael S. Tsirkin wrote:
> > > > On Wed, Dec 04, 2024 at 02:07:18PM +0900, Koichiro Den wrote:
> > > > > When virtnet_close is followed by virtnet_open, some TX completions can
> > > > > possibly remain unconsumed, until they are finally processed during the
> > > > > first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> > > > > [1].
> > > > 
> > > > 
> > > > So it's a bugfix. Why net-next not net?
> > > 
> > > I was mistaken (I just read netdev-FAQ again). I'll resend to net, with
> > > adjustments reflecting your feedback.
> > > 
> > > > 
> > > > > Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() call
> > > > > before RX napi enable") was not sufficient to eliminate all BQL crash
> > > > > cases for virtio-net.
> > > > > 
> > > > > This issue can be reproduced with the latest net-next master by running:
> > > > > `while :; do ip l set DEV down; ip l set DEV up; done` under heavy network
> > > > > TX load from inside the machine.
> > > > > 
> > > > > netdev_tx_reset_queue() can actually be dropped from virtnet_open path;
> > > > > the device is not stopped in any case. For BQL core part, it's just like
> > > > > traffic nearly ceases to exist for some period. For stall detector added
> > > > > to BQL, even if virtnet_close could somehow lead to some TX completions
> > > > > delayed for long, followed by virtnet_open, we can just take it as stall
> > > > > as mentioned in commit 6025b9135f7a ("net: dqs: add NIC stall detector
> > > > > based on BQL"). Note also that users can still reset stall_max via sysfs.
> > > > > 
> > > > > So, drop netdev_tx_reset_queue() from virtnet_enable_queue_pair(). This
> > > > > eliminates the BQL crashes. Note that netdev_tx_reset_queue() is now
> > > > > explicitly required in freeze/restore path, so this patch adds it to
> > > > > free_unused_bufs().
> > > > 
> > > > I don't much like that free_unused_bufs now has this side effect.
> > > > I think would be better to just add a loop in virtnet_restore.
> > > > Or if you want to keep it there, pls rename the function
> > > > to hint it does more.
> > > 
> > > It makes sense. I would go for the former. Thanks.
> > 
> > Hmm, as Jacob pointed out in v1
> > (https://lore.kernel.org/all/20241202181445.0da50076@kernel.org/),
> > it looks better to follow the rule of thumb.
> 
> OK then. I'm fine with keeping your code as is, just a squash,
> and add a comment
> 
> 	/*
> 	 * Rule of thumb is netdev_tx_reset_queue() should follow any
> 	 * skb freeing not followed by netdev_tx_completed_queue()
> 	 */

Ok, thanks for the review!

> 
> > Taking both suggestions
> > from Jacob and you, adding a loop to remove_vq_common(), just after
> > free_unused_bufs(), seems more fitting now, like this:
> > 
> >      static void remove_vq_common(struct virtnet_info *vi)
> >      {
> >     +       int i;
> >     +
> >             virtio_reset_device(vi->vdev);
> >     
> >             /* Free unused buffers in both send and recv, if any. */
> >             free_unused_bufs(vi);
> >     
> >     +       /* Tx unused buffers flushed, so reset BQL counter */
> >     +       for (i = 0; i < vi->max_queue_pairs; i++)
> >     +               netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> >     +
> >             free_receive_bufs(vi);
> > 
> > What do you think?
> > 
> > Thanks,
> > 
> > -Koichiro Den
> > 
> > > 
> > > > 
> > > > 
> > > > > 
> > > > > [1]:
> > > > > ------------[ cut here ]------------
> > > > > kernel BUG at lib/dynamic_queue_limits.c:99!
> > > > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > > CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
> > > > > Tainted: [N]=TEST
> > > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
> > > > > BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > > > RIP: 0010:dql_completed+0x26b/0x290
> > > > > Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
> > > > > 4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
> > > > > d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
> > > > > RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
> > > > > RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
> > > > > RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
> > > > > RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
> > > > > R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
> > > > > R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
> > > > > FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
> > > > > knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
> > > > > PKRU: 55555554
> > > > > Call Trace:
> > > > >  <IRQ>
> > > > >  ? die+0x32/0x80
> > > > >  ? do_trap+0xd9/0x100
> > > > >  ? dql_completed+0x26b/0x290
> > > > >  ? dql_completed+0x26b/0x290
> > > > >  ? do_error_trap+0x6d/0xb0
> > > > >  ? dql_completed+0x26b/0x290
> > > > >  ? exc_invalid_op+0x4c/0x60
> > > > >  ? dql_completed+0x26b/0x290
> > > > >  ? asm_exc_invalid_op+0x16/0x20
> > > > >  ? dql_completed+0x26b/0x290
> > > > >  __free_old_xmit+0xff/0x170 [virtio_net]
> > > > >  free_old_xmit+0x54/0xc0 [virtio_net]
> > > > >  virtnet_poll+0xf4/0xe30 [virtio_net]
> > > > >  ? __update_load_avg_cfs_rq+0x264/0x2d0
> > > > >  ? update_curr+0x35/0x260
> > > > >  ? reweight_entity+0x1be/0x260
> > > > >  __napi_poll.constprop.0+0x28/0x1c0
> > > > >  net_rx_action+0x329/0x420
> > > > >  ? enqueue_hrtimer+0x35/0x90
> > > > >  ? trace_hardirqs_on+0x1d/0x80
> > > > >  ? kvm_sched_clock_read+0xd/0x20
> > > > >  ? sched_clock+0xc/0x30
> > > > >  ? kvm_sched_clock_read+0xd/0x20
> > > > >  ? sched_clock+0xc/0x30
> > > > >  ? sched_clock_cpu+0xd/0x1a0
> > > > >  handle_softirqs+0x138/0x3e0
> > > > >  do_softirq.part.0+0x89/0xc0
> > > > >  </IRQ>
> > > > >  <TASK>
> > > > >  __local_bh_enable_ip+0xa7/0xb0
> > > > >  virtnet_open+0xc8/0x310 [virtio_net]
> > > > >  __dev_open+0xfa/0x1b0
> > > > >  __dev_change_flags+0x1de/0x250
> > > > >  dev_change_flags+0x22/0x60
> > > > >  do_setlink.isra.0+0x2df/0x10b0
> > > > >  ? rtnetlink_rcv_msg+0x34f/0x3f0
> > > > >  ? netlink_rcv_skb+0x54/0x100
> > > > >  ? netlink_unicast+0x23e/0x390
> > > > >  ? netlink_sendmsg+0x21e/0x490
> > > > >  ? ____sys_sendmsg+0x31b/0x350
> > > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > > >  ? __nla_validate_parse+0x5f/0xee0
> > > > >  ? __pfx___probestub_irq_enable+0x3/0x10
> > > > >  ? __create_object+0x5e/0x90
> > > > >  ? security_capable+0x3b/0x70
> > > > >  rtnl_newlink+0x784/0xaf0
> > > > >  ? avc_has_perm_noaudit+0x67/0xf0
> > > > >  ? cred_has_capability.isra.0+0x75/0x110
> > > > >  ? stack_depot_save_flags+0x24/0x6d0
> > > > >  ? __pfx_rtnl_newlink+0x10/0x10
> > > > >  rtnetlink_rcv_msg+0x34f/0x3f0
> > > > >  ? do_syscall_64+0x6c/0x180
> > > > >  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > >  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> > > > >  netlink_rcv_skb+0x54/0x100
> > > > >  netlink_unicast+0x23e/0x390
> > > > >  netlink_sendmsg+0x21e/0x490
> > > > >  ____sys_sendmsg+0x31b/0x350
> > > > >  ? copy_msghdr_from_user+0x6d/0xa0
> > > > >  ___sys_sendmsg+0x86/0xd0
> > > > >  ? __pte_offset_map+0x17/0x160
> > > > >  ? preempt_count_add+0x69/0xa0
> > > > >  ? __call_rcu_common.constprop.0+0x147/0x610
> > > > >  ? preempt_count_add+0x69/0xa0
> > > > >  ? preempt_count_add+0x69/0xa0
> > > > >  ? _raw_spin_trylock+0x13/0x60
> > > > >  ? trace_hardirqs_on+0x1d/0x80
> > > > >  __sys_sendmsg+0x66/0xc0
> > > > >  do_syscall_64+0x6c/0x180
> > > > >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > RIP: 0033:0x7f41defe5b34
> > > > > Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
> > > > > f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
> > > > > f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
> > > > > RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> > > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
> > > > > RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
> > > > > RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
> > > > > R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
> > > > > R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
> > > > >  </TASK>
> > > > > [...]
> > > > > ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> > > > > 
> > > > > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > > > > Cc: <stable@vger.kernel.org> # v6.11+
> > > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 64c87bb48a41..48ce8b3881b6 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3054,7 +3054,6 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> > > > >  	if (err < 0)
> > > > >  		goto err_xdp_reg_mem_model;
> > > > >  
> > > > > -	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
> > > > >  	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> > > > >  	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
> > > > >  
> > > > > @@ -6243,6 +6242,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
> > > > >  		struct virtqueue *vq = vi->sq[i].vq;
> > > > >  		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> > > > >  			virtnet_sq_free_unused_buf(vq, buf);
> > > > > +		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> > > > >  		cond_resched();
> > > > >  	}
> > > > >  
> > > > > -- 
> > > > > 2.43.0
> > > > 
> 

