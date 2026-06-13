Return-Path: <netdev+bounces-298961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8mK6D5ZMLWrCegQAu9opvQ
	(envelope-from <netdev+bounces-298961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 14:27:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC167E85E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 14:27:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=fVNFhJBH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298961-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298961-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B80930034AB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE537B3E1;
	Sat, 13 Jun 2026 12:26:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58FF3E0221
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 12:26:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353616; cv=none; b=Tc5Bol+FDVh4kpBKn2U1vNs9dEqzQYx9ZUxKA0WoACJurZh8r66Uhur6VBY3qRu7Vnd663aL369vuo8bPef4iuEfEwuzGBjbSKj2cjjiOS7siZwiGc/7PHYYgGyyaZDJFsyq4idUjbsJFFxi/csLCyki+4j+W68LhVuC648sHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353616; c=relaxed/simple;
	bh=+Utq3396aQFNMgv97jxeXtkc7/pqfXum3no/lPBQ9rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9w+StOUQbgkcaRKZ8ke/aZZgNGksaGwleF021uBjdm5GvTMJT7/6G9v6R3CF3xWUQC1JiDDvEd+nfb0VdJG7OAcLLxRBoSXGSJAse1esDNHO5qIo5zXTzJhpZCmgo2mdUNfDQJ93iEMNIS65iYbcrJbd2g3zFM6gtuGs6P9YeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fVNFhJBH; arc=none smtp.client-ip=95.215.58.170
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781353600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezZ4R5waX9NiYNreVYNEdpvd6VvEUg7nWNgpBzpChj4=;
	b=fVNFhJBHstCvbysj7S3frgErmLO4n20mCXB15L0+aV4Iqhg8aSto2Vr8WlJH0WA1SG866W
	M8onNIvAJ3GzcMDUoCACBi/5d7CI4VZD/4b4SasNfgJPN595wjpx7McwgmHxxYJsjFDVX2
	ph6KSW5rORttgaEXHl9PdtIrZhK+1WY=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
Date: Sat, 13 Jun 2026 20:26:26 +0800
Message-ID: <rHZz5_ylT4WggoZ-Ic2Q4w@linux.dev>
In-Reply-To: <41eefa1d-99bf-450d-988e-7dec67c6b61e@gmail.com>
References:
 <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
 <41eefa1d-99bf-450d-988e-7dec67c6b61e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298961-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,redhat.com];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:minhquangbui99@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BBC167E85E

On 2026/6/12 00:24, Bui Quang Minh wrote:
> On 6/11/26 09:56, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > During packet receiving in virtio-net, the rq can be empty, which means
> > "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> > virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> > can be empty too, which means we can't allocate anything from
> > xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
> >
> > However, if the user clean all the data in rx ring and fill the
> > "fill ring" and check the XDP_RING_NEED_WAKEUP flag after
> > xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
> > napi will never be scheduled: the rx ring is empty, which means we will
> > never receive a packet to trigger the further recv fill. The rx ring is
> > empty now, so the user will not check the flag too.
> >
> > Fix this by set the XDP_RING_NEED_WAKEUP flag before
> > xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.
> >
> > Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
> > rq->vq.
> >
> > Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >   drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..4b5b3fa62008 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
> >   				   struct xsk_buff_pool *pool, gfp_t gfp)
> >   {
> >   	struct xdp_buff **xsk_buffs;
> > +	bool need_wakeup;
> >   	dma_addr_t addr;
> >   	int err = 0;
> >   	u32 len, i;
> >   	int num;
> >   
> > +	need_wakeup = xsk_uses_need_wakeup(pool);
> >   	xsk_buffs = rq->xsk_buffs;
> >   
> > +	/* If both rq->vq and fill ring are empty, and then the user submit
> > +	 * all the chunks to the fill ring and check the wake up flag
> > +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> > +	 * we will lose the chance to wake up the rx napi, so we have to
> > +	 * set the need_wakeup flag here.
> > +	 */
> > +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> > +		xsk_set_rx_need_wakeup(pool);
> 

Hi, Bui Quang. Thanks for your reply. I spent some time learning
what you said.

> I think when polling the receive queue, the userspace program needs to 
> check the XDP_RING_NEED_WAKEUP flag if it does not see any packets. The 
> flag check is quite lightweight in my opinion. Here are some examples I find
> 
> - 
> https://github.com/xdp-project/xdp-tools/blob/e9469501622aa22a7e452a671000bec8685edcde/lib/util/xdpsock.c#L1206

You are right, I'm over concerned about this point. My origin
concern is that we can't wake up from the poll syscall in this case:

The chunk of the umem is 2000. In the beginning, the xsk->fill_ring
is filled with 2000 chunk, and then the user fall asleep and don't
do anything.

Kernel: the 2000th packet is received
Kernel: xsk_buff_alloc_batch return 0(xsk->fill_ring is empty and xsk->rx_ring is full)

        User: handle the xsk->rx_ring
        User: fill the xsk->fill_ring with 2000 chunks
        User: check the wake up flag
        User: no need_wakeup flag, fall asleep with poll() syscall

Kernel: call xsk_set_rx_need_wakeup()
Kernel: virio-net rx ringbuf is empty, we can't receive any packet further
Kernel: to call virtnet_add_recvbuf_xsk(), we are dead

But then, I found that we can still be wake up with the 2000th
packet from the poll syscall, which means that the case that
the NAPI and the user can't both be waked up doesn't exist.

> - 
> https://github.com/xdp-project/bpf-examples/blob/43e565901c4287efa863edca7f0e6cd6e35ed896/AF_XDP-forwarding/xsk_fwd.c#L540
> 
> Furthermore, the XDP_RING_NEED_WAKEUP flag related functions does not 
> provide any memory orderings. So even with your patch, I'm worried that 
> this case is possible
> 
> kernel userspace
> 
> xsk_buff_alloc_batch -> failed
>                                                              submit fill 
> ring
>                                                              flag != 
> XDP_RING_NEED_WAKEUP
> // reordering due to lack of memory orderings
> xsk_set_rx_need_wakeup
> 
> I'm not expert here, so correct me if I'm wrong. I think the wake up 
> flag is designed with no orderings so we cannot rely on it to reason and 
> skip further checks.
> 
> > +
> >   	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
[....]
> > +
> 
> Why do we need to set XDP_RING_NEED_WAKEUP even when 
> xsk_buff_alloc_batch succeeds?

Ah, don't mind here. I just thought that if xsk_buff_alloc_batch()
didn't allocate enough chunks as we need, we can wake up
the NAPI as soon as possible, in case that the virtio-net ringbuf
is full and cause packet dropping :)

Anyway, I'll remove the first patch, and send the second patch
only in the V3.

Thanks!
Menglong Dong

> 
> >   	return num;
> >   
> >   err:
> 
> Thanks,
> Quang Minh.
> 
> 
> 
> 





