Return-Path: <netdev+bounces-123105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA24963B35
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EB8285C2A
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A9015575B;
	Thu, 29 Aug 2024 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TDeDE3ti"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0328149011
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912497; cv=none; b=cqmMKMgAoqpIPQY5ocN7ADDJe2cHM24jboNRN/+Ov6XkZgNgHX8QxwDuzTkqPLx+gDqMYVSUqyTRI2Yj/DDtJ7xd2fPuVlv2c84pY3AVYq7gogsxMRfozIC6VQi81NjVzm/zkdWrD/EpMX+Te4+aF2B+HrnAkdSqfRn+DSOjKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912497; c=relaxed/simple;
	bh=Hz2i5OBmnT1Ytkr9Jj1kC07gmlddt31ZUcV0YJO5IcQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=g0TSk0X/xhOzGNRNSJzY6RIgquhIXADhQsgm6JKKHsqQMXmRCmIMlh/xrgEmgv0UdrBQNKDI3eWJoVDjItQdoNFVz40SWSTVWGIN+QpaMMVX8dXPyVjszCBsmpCmwzapdU6DN6h59936aLlOrfyGffbfA9arHsLNsPkxo9pn8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TDeDE3ti; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724912491; h=Message-ID:Subject:Date:From:To;
	bh=k6ln6sF2Oiog21Xym93EPP2lGA88WZi5JT1JslSdMVg=;
	b=TDeDE3tikVBThyY7tz+DQehUTM3dQ+hXhndo4QJICn7t/WrKpyTQVxWL8QkQxJe0f4C0gs9DY5FJlRnDis4PcM91rPSsh/ERBPfucFun2qym/quIoouw0+9B1pzI/wChyjke3bVhaI8TDdwB2+TN59lfDrV1JVmgecfzplBZCyA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDs-kT9_1724912489)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 14:21:30 +0800
Message-ID: <1724912338.229802-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Thu, 29 Aug 2024 14:18:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Si-Wei Liu" <si-wei.liu@oracle.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 Darren Kenny <darren.kenny@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240820125006-mutt-send-email-mst@kernel.org>
 <m2o75l2585.fsf@oracle.com>
 <546cc17a-dd57-8260-4737-c45d7b011631@oracle.com>
In-Reply-To: <546cc17a-dd57-8260-4737-c45d7b011631@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 28 Aug 2024 12:57:56 -0700, "Si-Wei Liu" <si-wei.liu@oracle.com> wrote:
> Just in case Xuan missed the last email while his email server kept
> rejecting incoming emails in the last week.: the patch doesn't seem fix
> the regression.
>
> Xuan, given this is not very hard to reproduce and we have clearly
> stated how to, could you try to get the patch verified in house before
> posting to upstream? Or you were unable to reproduce locally?

Of course I have tested it locally first. And the crash reported this time is
different from the previous one. I really don't know where the problem is. I may
make a new patch based on Jason's suggestion, which should solve the problem of
occupied frag space that you have been worried about.

Of course, before sending the patch, I will reproduce and test it.

Thanks.


>
> Thanks,
> -Siwei
>
> On 8/21/2024 9:47 AM, Darren Kenny wrote:
> > Hi Michael,
> >
> > On Tuesday, 2024-08-20 at 12:50:39 -04, Michael S. Tsirkin wrote:
> >> On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> >>> leads to regression on VM with the sysctl value of:
> >>>
> >>> - net.core.high_order_alloc_disable=1
> >>
> >>
> >>
> >>> which could see reliable crashes or scp failure (scp a file 100M in size
> >>> to VM):
> >>>
> >>> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> >>> of a new frag. When the frag size is larger than PAGE_SIZE,
> >>> everything is fine. However, if the frag is only one page and the
> >>> total size of the buffer and virtnet_rq_dma is larger than one page, an
> >>> overflow may occur. In this case, if an overflow is possible, I adjust
> >>> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> >>> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> >>> the first buffer of the frag is affected.
> >>>
> >>> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> >>> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> >>> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>
> >> Darren, could you pls test and confirm?
> > Unfortunately with this change I seem to still get a panic as soon as I start a
> > download using wget:
> >
> > [  144.055630] Kernel panic - not syncing: corrupted stack end detected inside scheduler
> > [  144.056249] CPU: 8 PID: 37894 Comm: sleep Kdump: loaded Not tainted 6.10.0-1.el8uek.x86_64 #2
> > [  144.056850] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
> > [  144.057585] Call Trace:
> > [  144.057791]  <TASK>
> > [  144.057973]  panic+0x347/0x370
> > [  144.058223]  schedule_debug.isra.0+0xfb/0x100
> > [  144.058565]  __schedule+0x58/0x6a0
> > [  144.058838]  ? refill_stock+0x26/0x50
> > [  144.059120]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.059473]  do_task_dead+0x42/0x50
> > [  144.059752]  do_exit+0x31e/0x4b0
> > [  144.060011]  ? __audit_syscall_entry+0xee/0x150
> > [  144.060352]  do_group_exit+0x30/0x80
> > [  144.060633]  __x64_sys_exit_group+0x18/0x20
> > [  144.060946]  do_syscall_64+0x8c/0x1c0
> > [  144.061228]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.061570]  ? __audit_filter_op+0xbe/0x140
> > [  144.061873]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.062204]  ? audit_reset_context+0x232/0x310
> > [  144.062514]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.062851]  ? syscall_exit_work+0x103/0x130
> > [  144.063148]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.063473]  ? syscall_exit_to_user_mode+0x77/0x220
> > [  144.063813]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.064142]  ? do_syscall_64+0xb9/0x1c0
> > [  144.064411]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.064747]  ? do_syscall_64+0xb9/0x1c0
> > [  144.065018]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.065345]  ? do_read_fault+0x109/0x1b0
> > [  144.065628]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.065961]  ? do_fault+0x1aa/0x2f0
> > [  144.066212]  ? handle_pte_fault+0x102/0x1a0
> > [  144.066503]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.066836]  ? __handle_mm_fault+0x5ed/0x710
> > [  144.067137]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.067464]  ? __count_memcg_events+0x72/0x110
> > [  144.067779]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.068106]  ? count_memcg_events.constprop.0+0x26/0x50
> > [  144.068457]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.068788]  ? handle_mm_fault+0xae/0x320
> > [  144.069068]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [  144.069395]  ? do_user_addr_fault+0x34a/0x6b0
> > [  144.069708]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  144.070049] RIP: 0033:0x7fc5524f9c66
> > [  144.070307] Code: Unable to access opcode bytes at 0x7fc5524f9c3c.
> > [  144.070720] RSP: 002b:00007ffee052beb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> > [  144.071214] RAX: ffffffffffffffda RBX: 00007fc5527bb860 RCX: 00007fc5524f9c66
> > [  144.071684] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> > [  144.072146] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff78
> > [  144.072608] R10: 00007ffee052bdef R11: 0000000000000246 R12: 00007fc5527bb860
> > [  144.073076] R13: 0000000000000002 R14: 00007fc5527c4528 R15: 0000000000000000
> > [  144.073543]  </TASK>
> > [  144.074780] Kernel Offset: 0x37c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> >
> > Thanks,
> >
> > Darren.
> >
> >>> ---
> >>>   drivers/net/virtio_net.c | 12 +++++++++---
> >>>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>> index c6af18948092..e5286a6da863 100644
> >>> --- a/drivers/net/virtio_net.c
> >>> +++ b/drivers/net/virtio_net.c
> >>> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >>>   	void *buf, *head;
> >>>   	dma_addr_t addr;
> >>>
> >>> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> >>> -		return NULL;
> >>> -
> >>>   	head = page_address(alloc_frag->page);
> >>>
> >>>   	dma = head;
> >>> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >>>   	len = SKB_DATA_ALIGN(len) +
> >>>   	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >>>
> >>> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> >>> +		return -ENOMEM;
> >>> +
> >>>   	buf = virtnet_rq_alloc(rq, len, gfp);
> >>>   	if (unlikely(!buf))
> >>>   		return -ENOMEM;
> >>> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >>>   	 */
> >>>   	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> >>>
> >>> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> >>> +		return -ENOMEM;
> >>> +
> >>> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> >>> +		len -= sizeof(struct virtnet_rq_dma);
> >>> +
> >>>   	buf = virtnet_rq_alloc(rq, len + room, gfp);
> >>>   	if (unlikely(!buf))
> >>>   		return -ENOMEM;
> >>> --
> >>> 2.32.0.3.g01195cf9f
>

