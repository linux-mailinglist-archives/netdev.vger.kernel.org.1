Return-Path: <netdev+bounces-285283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EY1EFR7/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:45:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7804E7A93
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39A88300F75A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464F3ECBD0;
	Thu,  7 May 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7Yiu727";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNhdAlWq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546C311959
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154321; cv=none; b=dR4CvhnR3MeLx/NteVACVIzApjOvvzHcoUM8Md0iuCn6f2X49cr9T5WiTB8C0Q6CKzvjeHrHG9BH+IUxeyriPm/P/F8fCz6P3BnUalHgAeZK2a2vr8bgZTAHziRv8EXH9voXSe74fCY0GSrHTuTj9mvfQnYK2LX3dMxR+Je3ljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154321; c=relaxed/simple;
	bh=lvuRrcMHuxAF9URp6OhLBiPGZ+f4f+w8cDaxKKzlWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k73670l6S2XvH2kjwES5YPfyLWOKGwUgS3DfhnhsyRs3qO1YHAhB1o8GKSwLAw/XnB3nF4u4tHaPdW2wOdlajaqFaoitI3Il0jBff0mIlVqD4+HNMTBiPTII5I6J1Yhc332FRRzlENim4XiSGQV0SgkdXBnqLTpCwfBKqvR18H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7Yiu727; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNhdAlWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778154318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
	b=M7Yiu727hNp03W51NM/iY+wvZKynYmQ/PukJUHOhrsWNDN7XxlukYCCS5zs31in12jWjI5
	kGJojC0Bjo7RdEsCKKuj98nFlsOZhEKm0tcDwGlKg5wnu78jS26LkZJPqRB/uNaYUIRJcG
	F4dq98ZnmwkKhTx6vCDHRiMWJc4S6UM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-b4CDeESeOzGcWw5KyfJbow-1; Thu, 07 May 2026 07:45:16 -0400
X-MC-Unique: b4CDeESeOzGcWw5KyfJbow-1
X-Mimecast-MFC-AGG-ID: b4CDeESeOzGcWw5KyfJbow_1778154315
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44f56d5523eso612001f8f.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778154315; x=1778759115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
        b=MNhdAlWqr/A9z8eNgbbotqQHpSYXSAwOKVmAZFEJl6n7MJ8HA0JfURdrImmJqiJM4B
         WHnDI7MUySwIPt++D05HvpDmW+tBiDpqL67h9eAutI5m4zVJFj07hsaiQTfLUdMTy/Jh
         UoJG/FcAKmBIwveKbk3T/gdoGBTzKv1eiyyjkz7HPuKxWmj/X5Y3kauS/RE/wc9Op6kF
         Bup+csZIgeiJIN6ly/Yj2zfrty7ojbTHZ48AAuHNm+wtyQDOZAQ5SVnunJWy6hCz00nq
         IGaLP0opY27jZe787tTAnonpNMSMEv71mfuLjo6Xq2aLfF6tbx8rnPgG0BcEphjdoEvU
         1fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778154315; x=1778759115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XB8uKgfriwIOrN1HH+uQzFZrRsNz6/XjSTKr5IkjkA=;
        b=B7j3Z/wTf1LPt8ehahvJURO134TyNIm1aensM6nkngFQkpOAzyTr7D+tpD6mMtSkoC
         ifTQ1A4sbAa3Gz5rRsV7RApnb3B8/DIfcugDgWX0eoEF52z7GpRRmQTIaKJXNQO+kk+w
         h84Zyz8qTtDXwp8Gi3b8DYD3PXWqua3eYsz7GSQp8hX/55qwZtREBFdX5v9VPfwG4G05
         i+T57r9ha19IxFDnJOxeN5pwBmB/xVUBKrajSWfY6dLbt6rMsXMcBLCLJMsPeOasxz/k
         35u2hmnF4ydl4eLY8orjSm4spiCI4xjnvMcNuUsmEz/aThQ5NqJB++2XIZ9C9DsMmUsq
         +RnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/YGBpz8AJiEAp+BimtXm5Z0CgFodjxKUOVRQlUFzOXGREXDnNCcjWlq2kpWforUcvaL0V8Rqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0soL/dXEirK8fjkEsgopHp9Fozm5tS2SDjKtsJ+CBhWzz9uZ
	U7nzaI9lCfFhHoG/Nm1ATisTGEf6KsRyKlCoUD3gc2S7dU0EZ47eCTgA+kkLeFDXmlSTyZw3oQ4
	3Ufd2qc1uGihBE6rvCIrkkWqk21Bsy5XNiFsllz3gthDUY1LHSN7TMEuAyA==
X-Gm-Gg: AeBDiesQcyizh+zmzA2xuVlq7sTQSIGwi6oWIdT08KSQhw9cMCkdxb4l18k9oq9Bz8D
	A+npNrTTvwmAtBDjbehdHnQjaZ+CQKOdOOZ045vnaHJnKF9FC4/wCeKK9lAlwt4ojdCGWe1Uhta
	nlMQlfz5f96YUKtBLcBXLAgPd8sWxqWPxXlyJLsv+FHKO8w1IZDJCZ/iCNnMxS7YMsF1/78QeSQ
	pb/62qa2/AKqGqpLsqC4M9LAPH3G6cFhvdKP+bFKnZrJyvMVdkZ9FGj+XO52jp6FK94LTOQK22T
	TYwNjiLhLMMvXbiljauTjGfkFHBhjnafl10vRTTsXlpmgc6B/PG54HiA8hjBvs1aprJDbNuTiip
	Pa6Kou/FnOHaEdjtPjlabMShY5DTsehiKXKyjbTM6JyCNe/w0pSs=
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4515d5c567emr12448720f8f.33.1778154315111;
        Thu, 07 May 2026 04:45:15 -0700 (PDT)
X-Received: by 2002:a05:6000:200b:b0:43d:7b85:6c95 with SMTP id ffacd0b85a97d-4515d5c567emr12448641f8f.33.1778154314419;
        Thu, 07 May 2026 04:45:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm20870119f8f.31.2026.05.07.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:45:13 -0700 (PDT)
Date: Thu, 7 May 2026 07:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260507074113-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afxVH2So9BbZ3Gta@sgarzare-redhat>
X-Rspamd-Queue-Id: CD7804E7A93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285283-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,sberdevices.ru:email,oasis-open.org:url]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > >
> > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > > > >
> > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > > > >
> > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > > > >a very large number of packets can be queued
> > > > > >because vvs->rx_bytes stays at 0.
> > > > > >
> > > > > >Fix this by estimating the skb metadata size:
> > > > > >
> > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > > > >
> > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > >Cc: Jason Wang <jasowang@redhat.com>
> > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > > > >Cc: kvm@vger.kernel.org
> > > > > >Cc: virtualization@lists.linux.dev
> > > > > >---
> > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > > > >                                       u32 len)
> > > > > > {
> > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > > > >+
> > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > > > >               return false;
> > > > >
> > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > > >
> > > > > This takes only the payload into account, so it’s true that this problem
> > > > > exists; however, perhaps we should also inform the other peer of a lower
> > > > > credit balance, otherwise the other peer will believe it has much more
> > > > > credit than it actually does, send a large payload, and then the packet
> > > > > will be discarded and the data lost (there are no retransmissions,
> > > > > etc.).
> > > >
> > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > > > state to account credit")
> > > > and find a better fix then?
> > > 
> > > IIRC the same issue was there before the commit fixed by that one (commit
> > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> > > not sure about reverting it TBH.
> > > 
> > > CCing Arseniy and Bobby.
> > > 
> > > >
> > > > There is always a discrepancy between skb->len and skb->truesize.
> > > > You will not be able to announce a 1MB window, and accept one milliion
> > > > skb of 1-byte each.
> > > >
> > > > This kind of contract is broken.
> > > >
> > > 
> > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
> > > should at least inform the other peer that we're out of space.
> > > 
> > > @Stefan, @Michael, do you think we can do something in the spec to avoid
> > > this issue and in some way take into account also the metadata in the
> > > credit. I mean to avoid the 1-byte packets flooding.
> > > 
> > > Thanks,
> > > Stefano
> > 
> > Why do we need the metadata? Just don't keep it around if you begin
> > running low on memory.
> 
> I don't think removing the skuffs will be easy; we added them for ebpf,
> zero-copy, and seqpacket as well.

You do not need to remove them completely.

> For now, we're already doing something:
> merging the skuffs if they don't have EOM set.


Right that's good. You could go further and merge with EOM too
if you stick the info about message boundaries somewhere else.

> As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
> for the overhead and notifying the other peer, at least until we find a
> better solution.
> 
> Stefano

well if you want to support pathological cases such as 1 byte messages
that would mean like 100x reduction no?


