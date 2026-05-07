Return-Path: <netdev+bounces-285537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULabHuIW/WlLXgAAu9opvQ
	(envelope-from <netdev+bounces-285537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3654EFE5A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE7F33030B11
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738C36AB53;
	Thu,  7 May 2026 22:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0PJPcVY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="o9sWL/2G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104732F76D
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194139; cv=none; b=EWunGqRIWbMHnkSWjMqPXoKzI2PuL1a4d5JTJNb8HsBICFCwfr4kv83mrQr1wHLXfJVxlm12Q1JHvu6yngIFLCiPVrAFenUu/cdICeB6Kj1Y4lVh7eWlIAEbw7n3AD3yawSwUMy/ZmO9TOo1ylkQ3gBrW/knC3y8OksIFXA9Iws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194139; c=relaxed/simple;
	bh=BOBbAgP1kW6uKOQVgLZtl0MMPw6nRobWP7sw+hwoYLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob6wO3JjKkNqVmzeNxvQF2RBQ1a3PhazIr7jlCWE0zJ6zwPA0U90uAyzbEN8m7lx5/A4kFjReq/vL4y6pPaUdy+z/aelYQsInw9Iay5vrAJI5vaarqS+7tfAnSfp8WpC09sWvLqTjtix+00vIJoyAkZhmMQ0CEsgeYK/Iof+xDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0PJPcVY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o9sWL/2G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778194135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPT1X+oC0leIfuWLURPCfFHnp45mO9+EM3uTl+c8wSM=;
	b=O0PJPcVYVx92EJmpzoTVhvRuaEio7cASjdjsUzubLl7VLrVQXTi4Vzk60/NZo6zerp8gND
	dt8NMAaFGn3tuqKelYW3iTMqcA+xCkE9yIpDwbONZLp7Z/SVhAxENuTbqfXngxTomEonv+
	FJvNNpOggh/dP9Nx2yQfQRyu77DII6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-UHOY3ZPKPLOsmnKhG5B7Kg-1; Thu, 07 May 2026 18:48:54 -0400
X-MC-Unique: UHOY3ZPKPLOsmnKhG5B7Kg-1
X-Mimecast-MFC-AGG-ID: UHOY3ZPKPLOsmnKhG5B7Kg_1778194133
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44d83e45febso1974990f8f.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778194133; x=1778798933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qPT1X+oC0leIfuWLURPCfFHnp45mO9+EM3uTl+c8wSM=;
        b=o9sWL/2GaRc2Rl/XwtW3k8W0dVhzjaJx+x+sJ2NSrqWGXg/H7U7NCnwyQc28ITjV5U
         yfv+lsO87ez2W+cNnPWxQGnBdWv30J5iKDxOYLbDdRwT5LApjXZBU0UTp0YgUaSLH+C+
         pIppIowmsxJC+tq53VQK7iDvSeuUkdYleNKXqM7lSnESWE/2yItYznwk2pAO5zmox0Bi
         XRs6vF52H1Ik9YFSauFH64Tzce6Mn2p8C9UwOMmVKqJwBXOJPaHALhp+ZqryyYaJGtR6
         kiDypo0TjawoWJVp/kiT5TWDV1qZIx6TPtqwFherxQLTM/U6OaQtqg4IuJa8jaxoWE10
         jgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194133; x=1778798933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPT1X+oC0leIfuWLURPCfFHnp45mO9+EM3uTl+c8wSM=;
        b=eFo26STv3Rlj1G/5vvH8umzRRS7Z/klpk0o2NhI+lf3P6hGvcddS8MDa+0oQ0URp8h
         OTzFhssDRDIRRRhoN/EVAlqDvZNfkX47zezfH2UmLyzf7b28LKlLnAAAFpnQsRXp54O7
         jNUb2aEtBaqwfsagW4GjNOrgEyo4j6E94ECgszkUS1eL0KWLYO2QkS9XX4csAsuksGlw
         kk75WZb4jyHhd1Iprt7dywYOxqxXmmf8HopZyeT9v6yROnuG5OnV0vNQP524qz0hok+O
         DxNfSwGfq5dbrFgcicdfP4272p6Hz750yHe0NX23JN+cUMweUSdZ9Ix0sdRRMsM933J4
         ZOXg==
X-Forwarded-Encrypted: i=1; AFNElJ/UNJRLNteq4pJ4Fs+ksGm+Fx2wH9+X/QCrRYL6dImzUu3VTMPFuz2wXBYgJLlRwx1f/uclB7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuC+CySp4WxJRI1AorkcdyO6TneMhIxnCUBmooYLY5zqg+rPwh
	1Q14qbM9STdhsshkudJH6KflcS7tkrg9oNYkEhUVxfJkqI3jEsNNE3Z+zqLG1RGXL/IYLdX+u7A
	T/au1fhUW5Q7d1LL7rn1YcYnxBazJE3yFu8ZDmCTPgqxXQhtDkhmHkZK7bw==
X-Gm-Gg: AeBDievJJtv3PwOlw844boa+UWwwPyXKN7u52VEalkas5FLMyymUpNFPZX0G7NDxIPv
	R6Wc+xV0N3ZaOMTLRXMmV28jJJDq9NX922WQNMxiwZrg3P+7QO5dicXchRgrhjLYdrv18ml/Aju
	zFOiGTVmx9zKrZlrdZgTrFM/WYqX3WlopDRyyaZ2/+ZjoiB5ClEXnOvgJ8ALb8exQct6GwqI3++
	BAeXq+j3l3JmS277/PQa096FVRNuaZ2bwyU9/NU8hc1Md1IfQJZXp8a8mIRRkKXgc4QKzVqZU6A
	aChuHc4TpI2zeSJaNf3rq9BrpE5PHpAz1wx8YOTmltqir/ZwtgECrByu+p3n67skcfGdxR4vOXR
	pipVuomu+fhlioMbMkTyGPWIG6+2tGLM7izZd24Mi
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr16989215e9.7.1778194132381;
        Thu, 07 May 2026 15:48:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr16988775e9.7.1778194131780;
        Thu, 07 May 2026 15:48:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45417124ee4sm2480248f8f.28.2026.05.07.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:48:51 -0700 (PDT)
Date: Thu, 7 May 2026 18:48:47 -0400
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
Message-ID: <20260507163710-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afyMCyBvZpzWrLtO@sgarzare-redhat>
X-Rspamd-Queue-Id: AB3654EFE5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285537-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sberdevices.ru:email,oasis-open.org:url,anthropic.com:email,alibaba.com:email,linux.dev:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
> On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> > > On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> > > > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > > > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > > > > > >
> > > > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > > > > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > > > > > >
> > > > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > > > > > >a very large number of packets can be queued
> > > > > > > >because vvs->rx_bytes stays at 0.
> > > > > > > >
> > > > > > > >Fix this by estimating the skb metadata size:
> > > > > > > >
> > > > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > > > > > >
> > > > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > > > >Cc: Jason Wang <jasowang@redhat.com>
> > > > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > > > > > >Cc: kvm@vger.kernel.org
> > > > > > > >Cc: virtualization@lists.linux.dev
> > > > > > > >---
> > > > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > > > > > >                                       u32 len)
> > > > > > > > {
> > > > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > > > > > >+
> > > > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > > > > > >               return false;
> > > > > > >
> > > > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > > > > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > > > > >
> > > > > > > This takes only the payload into account, so it’s true that this problem
> > > > > > > exists; however, perhaps we should also inform the other peer of a lower
> > > > > > > credit balance, otherwise the other peer will believe it has much more
> > > > > > > credit than it actually does, send a large payload, and then the packet
> > > > > > > will be discarded and the data lost (there are no retransmissions,
> > > > > > > etc.).
> > > > > >
> > > > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > > > > > state to account credit")
> > > > > > and find a better fix then?
> > > > >
> > > > > IIRC the same issue was there before the commit fixed by that one (commit
> > > > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> > > > > not sure about reverting it TBH.
> > > > >
> > > > > CCing Arseniy and Bobby.
> > > > >
> > > > > >
> > > > > > There is always a discrepancy between skb->len and skb->truesize.
> > > > > > You will not be able to announce a 1MB window, and accept one milliion
> > > > > > skb of 1-byte each.
> > > > > >
> > > > > > This kind of contract is broken.
> > > > > >
> > > > >
> > > > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
> > > > > should at least inform the other peer that we're out of space.
> > > > >
> > > > > @Stefan, @Michael, do you think we can do something in the spec to avoid
> > > > > this issue and in some way take into account also the metadata in the
> > > > > credit. I mean to avoid the 1-byte packets flooding.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Why do we need the metadata? Just don't keep it around if you begin
> > > > running low on memory.
> > > 
> > > I don't think removing the skuffs will be easy; we added them for ebpf,
> > > zero-copy, and seqpacket as well.
> > 
> > You do not need to remove them completely.
> > 
> > > For now, we're already doing something:
> > > merging the skuffs if they don't have EOM set.
> > 
> > 
> > Right that's good. You could go further and merge with EOM too
> > if you stick the info about message boundaries somewhere else.
> 
> This adds a lot of complexity IMO, but we can try.
> 
> Do you have something in mind?

BER is clearly overkill but here's a POC that claude made for me,
just to give u an idea. It's clearly has a ton of issues,
for example I dislike how GFP_ATOMIC is handled.
Yet it seems to work fine in light testing.

-->


vsock/virtio: use DWARF ULEB128 to record EOM boundaries, enable cross-EOM skb coalescing

virtio_transport_recv_enqueue() currently refuses to coalesce an
incoming skb with the previous one when the previous skb carries
VIRTIO_VSOCK_SEQ_EOM.  This forces one skb per seqpacket message.
For workloads with many small or zero-byte messages the per-skb
overhead (~960 bytes) dominates, causing unbounded memory growth.

Decouple message boundary tracking from the skb structure: store
boundary offsets in a compact side buffer using DWARF ULEB128
encoding with the EOR flag folded into the low bit, then allow
the data of multiple complete messages to be coalesced into a single
skb.

Cross-EOM coalescing fires only when:
- both the tail skb and the incoming packet carry EOM (complete msgs)
- the incoming packet fits in the tail skb's tailroom
- no BPF psock is attached (read_skb expects one msg per skb)

On allocation failure the code falls back to separate skbs (existing
behaviour).  Credit accounting is unchanged; the boundary buffer is
capped at PAGE_SIZE.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index f91704731057..e36b9ab28372 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -12,6 +12,7 @@
 struct virtio_vsock_skb_cb {
 	bool reply;
 	bool tap_delivered;
+	bool has_boundary_entries;
 	u32 offset;
 };
 
@@ -167,6 +168,12 @@ struct virtio_vsock_sock {
 	u32 buf_used;
 	struct sk_buff_head rx_queue;
 	u32 msg_count;
+
+	/* ULEB128-encoded seqpacket message boundary buffer */
+	u8 *boundary_buf;
+	u32 boundary_len;
+	u32 boundary_alloc;
+	u32 boundary_off;
 };
 
 struct virtio_vsock_pkt_info {
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..81654f70f72c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -11,6 +11,7 @@
 #include <linux/sched/signal.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
+#include <linux/skmsg.h>
 #include <linux/virtio_vsock.h>
 #include <uapi/linux/vsockmon.h>
 
@@ -26,6 +27,91 @@
 /* Threshold for detecting small packets to copy */
 #define GOOD_COPY_LEN  128
 
+#define VSOCK_BOUNDARY_BUF_INIT	64
+#define VSOCK_BOUNDARY_BUF_MAX	PAGE_SIZE
+
+/* ULEB128 boundary encoding: value = (msg_len << 1) | eor.
+ * Each byte carries 7 data bits; bit 7 is set on all but the last byte.
+ * Max 5 bytes for a u32 msg_len (33 bits with eor shift).
+ */
+static int vsock_uleb_encode_boundary(u8 *buf, u32 msg_len, bool eor)
+{
+	u64 val = ((u64)msg_len << 1) | eor;
+	int n = 0;
+
+	do {
+		buf[n] = val & 0x7f;
+		val >>= 7;
+		if (val)
+			buf[n] |= 0x80;
+		n++;
+	} while (val);
+
+	return n;
+}
+
+static int vsock_uleb_decode_boundary(const u8 *buf, u32 avail,
+				      u32 *msg_len, bool *eor)
+{
+	u64 val = 0;
+	int shift = 0;
+	int n = 0;
+
+	do {
+		if (n >= avail || shift >= 35)
+			return -EINVAL;
+		val |= (u64)(buf[n] & 0x7f) << shift;
+		shift += 7;
+	} while (buf[n++] & 0x80);
+
+	*eor = val & 1;
+	*msg_len = val >> 1;
+	return n;
+}
+
+static void vsock_boundary_buf_compact(struct virtio_vsock_sock *vvs)
+{
+	if (vvs->boundary_off == 0)
+		return;
+
+	vvs->boundary_len -= vvs->boundary_off;
+	memmove(vvs->boundary_buf, vvs->boundary_buf + vvs->boundary_off,
+		vvs->boundary_len);
+	vvs->boundary_off = 0;
+}
+
+static int vsock_boundary_buf_ensure(struct virtio_vsock_sock *vvs, u32 needed)
+{
+	u32 new_alloc;
+	u8 *new_buf;
+
+	if (vvs->boundary_alloc >= needed)
+		return 0;
+
+	/* Reclaim consumed space before growing */
+	if (vvs->boundary_off) {
+		needed -= vvs->boundary_off;
+		vsock_boundary_buf_compact(vvs);
+		if (vvs->boundary_alloc >= needed)
+			return 0;
+	}
+
+	new_alloc = max(needed, vvs->boundary_alloc ? vvs->boundary_alloc * 2
+						    : VSOCK_BOUNDARY_BUF_INIT);
+	if (new_alloc > VSOCK_BOUNDARY_BUF_MAX)
+		new_alloc = VSOCK_BOUNDARY_BUF_MAX;
+	if (new_alloc < needed)
+		return -ENOMEM;
+
+	new_buf = krealloc(vvs->boundary_buf, new_alloc, GFP_ATOMIC);
+	if (!new_buf)
+		return -ENOMEM;
+
+	vvs->boundary_buf = new_buf;
+	vvs->boundary_alloc = new_alloc;
+	return 0;
+}
+
 static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
 					       bool cancel_timeout);
 static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
@@ -682,41 +768,74 @@ virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
 	total = 0;
 	len = msg_data_left(msg);
 
-	skb_queue_walk(&vvs->rx_queue, skb) {
-		struct virtio_vsock_hdr *hdr;
+	skb = skb_peek(&vvs->rx_queue);
+	if (skb && VIRTIO_VSOCK_SKB_CB(skb)->has_boundary_entries) {
+		u32 msg_len, offset;
+		size_t bytes;
+		bool eor;
+		int ret;
 
-		if (total < len) {
-			size_t bytes;
+		ret = vsock_uleb_decode_boundary(
+			vvs->boundary_buf + vvs->boundary_off,
+			vvs->boundary_len - vvs->boundary_off,
+			&msg_len, &eor);
+		if (ret < 0)
+			goto unlock;
+
+		offset = VIRTIO_VSOCK_SKB_CB(skb)->offset;
+		bytes = min(len, (size_t)msg_len);
+
+		if (bytes) {
 			int err;
 
-			bytes = len - total;
-			if (bytes > skb->len)
-				bytes = skb->len;
-
 			spin_unlock_bh(&vvs->rx_lock);
-
-			/* sk_lock is held by caller so no one else can dequeue.
-			 * Unlock rx_lock since skb_copy_datagram_iter() may sleep.
-			 */
-			err = skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
+			err = skb_copy_datagram_iter(skb, offset,
 						     &msg->msg_iter, bytes);
 			if (err)
 				return err;
-
 			spin_lock_bh(&vvs->rx_lock);
 		}
 
-		total += skb->len;
-		hdr = virtio_vsock_hdr(skb);
+		total = msg_len;
+		if (eor)
+			msg->msg_flags |= MSG_EOR;
+	} else {
+		skb_queue_walk(&vvs->rx_queue, skb) {
+			struct virtio_vsock_hdr *hdr;
 
-		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
-			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
-				msg->msg_flags |= MSG_EOR;
+			if (total < len) {
+				size_t bytes;
+				int err;
 
-			break;
+				bytes = len - total;
+				if (bytes > skb->len)
+					bytes = skb->len;
+
+				spin_unlock_bh(&vvs->rx_lock);
+
+				err = skb_copy_datagram_iter(
+					skb,
+					VIRTIO_VSOCK_SKB_CB(skb)->offset,
+					&msg->msg_iter, bytes);
+				if (err)
+					return err;
+
+				spin_lock_bh(&vvs->rx_lock);
+			}
+
+			total += skb->len;
+			hdr = virtio_vsock_hdr(skb);
+
+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
+				if (le32_to_cpu(hdr->flags) &
+				    VIRTIO_VSOCK_SEQ_EOR)
+					msg->msg_flags |= MSG_EOR;
+				break;
+			}
 		}
 	}
 
+unlock:
 	spin_unlock_bh(&vvs->rx_lock);
 
 	return total;
@@ -740,57 +859,105 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	while (!msg_ready) {
-		struct virtio_vsock_hdr *hdr;
-		size_t pkt_len;
-
-		skb = __skb_dequeue(&vvs->rx_queue);
+		skb = skb_peek(&vvs->rx_queue);
 		if (!skb)
 			break;
-		hdr = virtio_vsock_hdr(skb);
-		pkt_len = (size_t)le32_to_cpu(hdr->len);
 
-		if (dequeued_len >= 0) {
+		if (VIRTIO_VSOCK_SKB_CB(skb)->has_boundary_entries) {
 			size_t bytes_to_copy;
+			u32 msg_len, offset;
+			bool eor;
+			int ret;
 
-			bytes_to_copy = min(user_buf_len, pkt_len);
+			ret = vsock_uleb_decode_boundary(
+				vvs->boundary_buf + vvs->boundary_off,
+				vvs->boundary_len - vvs->boundary_off,
+				&msg_len, &eor);
+			if (ret < 0)
+				break;
+			vvs->boundary_off += ret;
 
-			if (bytes_to_copy) {
+			offset = VIRTIO_VSOCK_SKB_CB(skb)->offset;
+			bytes_to_copy = min(user_buf_len, (size_t)msg_len);
+
+			if (bytes_to_copy && dequeued_len >= 0) {
 				int err;
 
-				/* sk_lock is held by caller so no one else can dequeue.
-				 * Unlock rx_lock since skb_copy_datagram_iter() may sleep.
-				 */
 				spin_unlock_bh(&vvs->rx_lock);
-
-				err = skb_copy_datagram_iter(skb, 0,
+				err = skb_copy_datagram_iter(skb, offset,
 							     &msg->msg_iter,
 							     bytes_to_copy);
-				if (err) {
-					/* Copy of message failed. Rest of
-					 * fragments will be freed without copy.
-					 */
-					dequeued_len = err;
-				} else {
-					user_buf_len -= bytes_to_copy;
-				}
-
 				spin_lock_bh(&vvs->rx_lock);
+				if (err)
+					dequeued_len = err;
+				else
+					user_buf_len -= bytes_to_copy;
 			}
 
 			if (dequeued_len >= 0)
-				dequeued_len += pkt_len;
-		}
+				dequeued_len += msg_len;
 
-		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
+			VIRTIO_VSOCK_SKB_CB(skb)->offset += msg_len;
 			msg_ready = true;
 			vvs->msg_count--;
 
-			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
+			if (eor)
 				msg->msg_flags |= MSG_EOR;
-		}
 
-		virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
-		kfree_skb(skb);
+			virtio_transport_dec_rx_pkt(vvs, msg_len, msg_len);
+
+			if (VIRTIO_VSOCK_SKB_CB(skb)->offset >= skb->len) {
+				__skb_unlink(skb, &vvs->rx_queue);
+				kfree_skb(skb);
+			}
+
+			if (vvs->boundary_off >= vvs->boundary_len / 2)
+				vsock_boundary_buf_compact(vvs);
+		} else {
+			struct virtio_vsock_hdr *hdr;
+			size_t pkt_len;
+
+			skb = __skb_dequeue(&vvs->rx_queue);
+			if (!skb)
+				break;
+			hdr = virtio_vsock_hdr(skb);
+			pkt_len = (size_t)le32_to_cpu(hdr->len);
+
+			if (dequeued_len >= 0) {
+				size_t bytes_to_copy;
+
+				bytes_to_copy = min(user_buf_len, pkt_len);
+
+				if (bytes_to_copy) {
+					int err;
+
+					spin_unlock_bh(&vvs->rx_lock);
+					err = skb_copy_datagram_iter(
+						skb, 0, &msg->msg_iter,
+						bytes_to_copy);
+					if (err)
+						dequeued_len = err;
+					else
+						user_buf_len -= bytes_to_copy;
+					spin_lock_bh(&vvs->rx_lock);
+				}
+
+				if (dequeued_len >= 0)
+					dequeued_len += pkt_len;
+			}
+
+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
+				msg_ready = true;
+				vvs->msg_count--;
+
+				if (le32_to_cpu(hdr->flags) &
+				    VIRTIO_VSOCK_SEQ_EOR)
+					msg->msg_flags |= MSG_EOR;
+			}
+
+			virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
+			kfree_skb(skb);
+		}
 	}
 
 	spin_unlock_bh(&vvs->rx_lock);
@@ -1132,6 +1299,7 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 
 	virtio_transport_cancel_close_work(vsk, true);
 
+	kfree(vvs->boundary_buf);
 	kfree(vvs);
 	vsk->trans = NULL;
 }
@@ -1224,6 +1392,11 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
 	 * removing it.
 	 */
 	__skb_queue_purge(&vvs->rx_queue);
+	kfree(vvs->boundary_buf);
+	vvs->boundary_buf = NULL;
+	vvs->boundary_len = 0;
+	vvs->boundary_alloc = 0;
+	vvs->boundary_off = 0;
 	vsock_remove_sock(vsk);
 }
 
@@ -1395,23 +1568,62 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 	    !skb_is_nonlinear(skb)) {
 		struct virtio_vsock_hdr *last_hdr;
 		struct sk_buff *last_skb;
+		bool last_has_eom;
+		bool has_eom;
 
 		last_skb = skb_peek_tail(&vvs->rx_queue);
 		last_hdr = virtio_vsock_hdr(last_skb);
+		last_has_eom = le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM;
+		has_eom = le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM;
 
-		/* If there is space in the last packet queued, we copy the
-		 * new packet in its buffer. We avoid this if the last packet
-		 * queued has VIRTIO_VSOCK_SEQ_EOM set, because this is
-		 * delimiter of SEQPACKET message, so 'pkt' is the first packet
-		 * of a new message.
-		 */
-		if (skb->len < skb_tailroom(last_skb) &&
-		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
-			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
-			free_pkt = true;
-			last_hdr->flags |= hdr->flags;
-			le32_add_cpu(&last_hdr->len, len);
-			goto out;
+		if (skb->len < skb_tailroom(last_skb)) {
+			if (!last_has_eom) {
+				/* Same-message coalescing (existing path) */
+				memcpy(skb_put(last_skb, skb->len),
+				       skb->data, skb->len);
+				free_pkt = true;
+				last_hdr->flags |= hdr->flags;
+				le32_add_cpu(&last_hdr->len, len);
+				goto out;
+			}
+
+			/* Cross-EOM: coalesce complete messages into one skb,
+			 * recording message boundaries in a compact BER buffer.
+			 * Only when incoming packet also has EOM (complete msg).
+			 */
+			if (has_eom && !sk_psock(sk_vsock(vsk))) {
+				bool prev_eor, cur_eor;
+				u8 tmp[12];
+				int n = 0;
+
+				cur_eor = le32_to_cpu(hdr->flags) &
+					  VIRTIO_VSOCK_SEQ_EOR;
+
+				if (!VIRTIO_VSOCK_SKB_CB(last_skb)->has_boundary_entries) {
+					u32 prev_len = le32_to_cpu(last_hdr->len);
+
+					prev_eor = le32_to_cpu(last_hdr->flags) &
+						   VIRTIO_VSOCK_SEQ_EOR;
+					n += vsock_uleb_encode_boundary(
+						tmp + n, prev_len, prev_eor);
+				}
+				n += vsock_uleb_encode_boundary(
+					tmp + n, len, cur_eor);
+
+				if (!vsock_boundary_buf_ensure(
+					    vvs, vvs->boundary_len + n)) {
+					memcpy(vvs->boundary_buf +
+					       vvs->boundary_len, tmp, n);
+					vvs->boundary_len += n;
+					VIRTIO_VSOCK_SKB_CB(last_skb)->has_boundary_entries = true;
+					memcpy(skb_put(last_skb, skb->len),
+					       skb->data, skb->len);
+					free_pkt = true;
+					last_hdr->flags |= hdr->flags;
+					le32_add_cpu(&last_hdr->len, len);
+					goto out;
+				}
+			}
 		}
 	}
 


