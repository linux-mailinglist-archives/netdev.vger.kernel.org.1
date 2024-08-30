Return-Path: <netdev+bounces-123537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2406A965450
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66451B23B06
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361827F6;
	Fri, 30 Aug 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HYITPizu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B558D272
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979553; cv=none; b=Tp8uourigOei2P+xVt2xZS0Z3y2HqwV8mktW1Z6stCfqedXJ0FBlahBYArM5uwYN/IRaE3gp1+pjsMFDCRw5XTWcvRpqvNiPCd8SEy4keL1Fhi8nxOUAW4hUwP7hjEWkFsKG6ExTkZRo34NKmv5OG8SRzw+QibH7qPJ1N6hiIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979553; c=relaxed/simple;
	bh=CbgtBfu01v9GpbfNg8UmO/CvtaKvuVF6XgIONCBZFKY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=GqTCbS/voD2xAkyN9TwJQ1ScflaTgKGLu/fFlqTQkQ+tWckyA1ufF+dlxiyjvC+jOkW6ECVAIZ1hUV8kFEokyKPL1HrMJjoXPwy1lVrjgNJao6MgGtCxvaPSmuzmcHN5i6qvvUV1GjsCWg2ILTeCxjdDF/evqnHMjsGaR5xNipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HYITPizu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724979547; h=Message-ID:Subject:Date:From:To;
	bh=vQbCsisdvyDUbwvZ/09puMiNIXvxirZvrp3YIXpb5PA=;
	b=HYITPizuJ9VYdN8X3VQgkhzbNU9VCjptTPUIsalkZcOlt1ve50kBaw2Q3aQnT8vuGsyaPhC+PKN+RnGMzLYvBbopXQkGyd7LoBKB0Vh3iooR3DtJsYvdt+6o5tWThYP/C5qjpUw49S4Z5n2K2fI+wPvHddPjiLNnqYtv6zr2pgA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDuRsnW_1724979546)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 08:59:07 +0800
Message-ID: <1724979266.1598616-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Date: Fri, 30 Aug 2024 08:54:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Darren Kenny <darren.kenny@oracle.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?EugenioP=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 "Si-Wei Liu" <si-wei.liu@oracle.com>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240820125006-mutt-send-email-mst@kernel.org>
 <m2o75l2585.fsf@oracle.com>
In-Reply-To: <m2o75l2585.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 21 Aug 2024 17:47:06 +0100, Darren Kenny <darren.kenny@oracle.com> wrote:
>
> Hi Michael,
>
> On Tuesday, 2024-08-20 at 12:50:39 -04, Michael S. Tsirkin wrote:
> > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> >> leads to regression on VM with the sysctl value of:
> >>
> >> - net.core.high_order_alloc_disable=1
> >
> >
> >
> >
> >> which could see reliable crashes or scp failure (scp a file 100M in size
> >> to VM):
> >>
> >> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> >> of a new frag. When the frag size is larger than PAGE_SIZE,
> >> everything is fine. However, if the frag is only one page and the
> >> total size of the buffer and virtnet_rq_dma is larger than one page, an
> >> overflow may occur. In this case, if an overflow is possible, I adjust
> >> the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> >> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> >> the first buffer of the frag is affected.
> >>
> >> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> >> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> >> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> >> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > Darren, could you pls test and confirm?
>
> Unfortunately with this change I seem to still get a panic as soon as I start a
> download using wget:

It's strange that I can't reproduce your panic.

My test method is to test with net.core.high_order_alloc_disable=1 on the net
branch code. An exception soon occurred (connection disconnected), and then
the kernel panicked.

	while true; do scp vmlinux root@192.168.122.100:; done

Use this patch to recompile virtio_net.ko, restart, configure
net.core.high_order_alloc_disable=1 again, and test for a long time without
problems.

So, could you re-test?

Thanks.




>
> [  144.055630] Kernel panic - not syncing: corrupted stack end detected inside scheduler
> [  144.056249] CPU: 8 PID: 37894 Comm: sleep Kdump: loaded Not tainted 6.10.0-1.el8uek.x86_64 #2
> [  144.056850] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-4.module+el8.9.0+90173+a3f3e83a 04/01/2014
> [  144.057585] Call Trace:
> [  144.057791]  <TASK>
> [  144.057973]  panic+0x347/0x370
> [  144.058223]  schedule_debug.isra.0+0xfb/0x100
> [  144.058565]  __schedule+0x58/0x6a0
> [  144.058838]  ? refill_stock+0x26/0x50
> [  144.059120]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.059473]  do_task_dead+0x42/0x50
> [  144.059752]  do_exit+0x31e/0x4b0
> [  144.060011]  ? __audit_syscall_entry+0xee/0x150
> [  144.060352]  do_group_exit+0x30/0x80
> [  144.060633]  __x64_sys_exit_group+0x18/0x20
> [  144.060946]  do_syscall_64+0x8c/0x1c0
> [  144.061228]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.061570]  ? __audit_filter_op+0xbe/0x140
> [  144.061873]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.062204]  ? audit_reset_context+0x232/0x310
> [  144.062514]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.062851]  ? syscall_exit_work+0x103/0x130
> [  144.063148]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.063473]  ? syscall_exit_to_user_mode+0x77/0x220
> [  144.063813]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.064142]  ? do_syscall_64+0xb9/0x1c0
> [  144.064411]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.064747]  ? do_syscall_64+0xb9/0x1c0
> [  144.065018]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.065345]  ? do_read_fault+0x109/0x1b0
> [  144.065628]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.065961]  ? do_fault+0x1aa/0x2f0
> [  144.066212]  ? handle_pte_fault+0x102/0x1a0
> [  144.066503]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.066836]  ? __handle_mm_fault+0x5ed/0x710
> [  144.067137]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.067464]  ? __count_memcg_events+0x72/0x110
> [  144.067779]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.068106]  ? count_memcg_events.constprop.0+0x26/0x50
> [  144.068457]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.068788]  ? handle_mm_fault+0xae/0x320
> [  144.069068]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  144.069395]  ? do_user_addr_fault+0x34a/0x6b0
> [  144.069708]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  144.070049] RIP: 0033:0x7fc5524f9c66
> [  144.070307] Code: Unable to access opcode bytes at 0x7fc5524f9c3c.
> [  144.070720] RSP: 002b:00007ffee052beb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> [  144.071214] RAX: ffffffffffffffda RBX: 00007fc5527bb860 RCX: 00007fc5524f9c66
> [  144.071684] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> [  144.072146] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff78
> [  144.072608] R10: 00007ffee052bdef R11: 0000000000000246 R12: 00007fc5527bb860
> [  144.073076] R13: 0000000000000002 R14: 00007fc5527c4528 R15: 0000000000000000
> [  144.073543]  </TASK>
> [  144.074780] Kernel Offset: 0x37c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>
> Thanks,
>
> Darren.
>
> >> ---
> >>  drivers/net/virtio_net.c | 12 +++++++++---
> >>  1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index c6af18948092..e5286a6da863 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> >>  	void *buf, *head;
> >>  	dma_addr_t addr;
> >>
> >> -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> >> -		return NULL;
> >> -
> >>  	head = page_address(alloc_frag->page);
> >>
> >>  	dma = head;
> >> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> >>  	len = SKB_DATA_ALIGN(len) +
> >>  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >>
> >> +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> >> +		return -ENOMEM;
> >> +
> >>  	buf = virtnet_rq_alloc(rq, len, gfp);
> >>  	if (unlikely(!buf))
> >>  		return -ENOMEM;
> >> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >>  	 */
> >>  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> >>
> >> +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> >> +		return -ENOMEM;
> >> +
> >> +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> >> +		len -= sizeof(struct virtnet_rq_dma);
> >> +
> >>  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> >>  	if (unlikely(!buf))
> >>  		return -ENOMEM;
> >> --
> >> 2.32.0.3.g01195cf9f
>
>

