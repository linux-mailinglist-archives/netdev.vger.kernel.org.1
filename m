Return-Path: <netdev+bounces-285365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPXqMr+o/GkNSgAAu9opvQ
	(envelope-from <netdev+bounces-285365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:59:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8FD4EAB3F
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59327301F18A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D1D3C6A43;
	Thu,  7 May 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwu5t12+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoosAJ0O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750B37F8DB
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165568; cv=none; b=MM3XdwVx5dgOOb8wRnlNzk8LTW7fI2v5Iabez2P6B9er6jiP6jvPRzQXiudhfQ9M4WW0InaSD0C9R/pA7df1rGqnpADuMjE14Q5QX547FRX1F8H/6vs3b1EdMBqwxo3AqLdyS1/kikDgWU4Yfs1QKQ9ocVuXQxD38Lk7J7939zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165568; c=relaxed/simple;
	bh=ecrl1iYp1xnobO4BxmeiQm41yhEPr+oCWaARqAkOs0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAVG9EejE3YdcQ7G87N0rvXPyuFTWxJjh+8yT+Y7BwEeHrtr4JcNwqaGSor/oqivog3jBCNpq5l4t3CY7DZFM/lbHclefS0KVSnL/OL+yQPw16bbk1QikBKSHhmTrbHnd5i15zKdiFzemXL6oOgLUwsSF7IaPF8WboRZ38Rwyps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nwu5t12+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoosAJ0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778165566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y78B/0dJ3VS7H6g0/jf9q/rfkjPnyDot3aaQ8HfMN5Y=;
	b=Nwu5t12+HerzCpPFn8nRFz/UR+dBiwUmO7w+Qte63NOnMpL3/lpUn0phRNkRTvxFJpR7eN
	eM9FAvbBmLARydtbbf8MO1+J+qKo17Ho0seT5XsL5qG1/MbAGF/9GBfyE4pqc81No/eKCP
	xh5cY+Gt62lDwPo1W/Kv8cMBCsnlT2w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-TMkW9LzHOxGm6fvQgmrVnw-1; Thu, 07 May 2026 10:52:44 -0400
X-MC-Unique: TMkW9LzHOxGm6fvQgmrVnw-1
X-Mimecast-MFC-AGG-ID: TMkW9LzHOxGm6fvQgmrVnw_1778165563
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b94062e85f9so112156066b.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778165562; x=1778770362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y78B/0dJ3VS7H6g0/jf9q/rfkjPnyDot3aaQ8HfMN5Y=;
        b=DoosAJ0OBrfN6K5HDZHstbmCNpdKHsrLKQvjDa3oIBudqUvLlfs4/N87oNYqCCkNLJ
         aUD36C/Vo+c6dojHviAgrMfT6tiziBFohTgF/QB12rPWps3vOfio4YtzvUl6++t+8U+D
         nD93t1kbt5oDXjcJUrJ/g/ehQjlFsL32PQQIcDoYWaIxOBcVbcxhfonbQgrgqCLaH6oL
         30X421iAPWXhgpkLkBEGy1SPKEAQPJvulqPL1uk48lLCm4Oatvf0RKH9l+RJrhQzicu7
         a6+Z+kJcwPkpZQFhdeSjuzwBblP8ArCntN5hEuBKEB5wuEnZhH5mF4t+WveYKkl+vf6M
         FsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165562; x=1778770362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y78B/0dJ3VS7H6g0/jf9q/rfkjPnyDot3aaQ8HfMN5Y=;
        b=ljJUJhZ06W6fxI+ZRlp7TpydJr/+y0uH2jiUSWjWywcd9xYNS5nU7OLeoLxsbgxnYC
         IeQRC4Gn6GAPtejC9mM0vE3U2UdINCii+itjEmTOKyCZ8uyrgxMBKer6S7Yqv6Kh+t0H
         tpaZfB8ZgC8q8YJjd3dFSrCwbHrfhsKHY+AQjdS8CqWWhrN2ug/J9MX10f/ld+bqYtJZ
         qh+/yUDhx9m8r66CTvxdzPyx234bY5LhP4093xhOFo1yebRk6WEXTvdQ3jVf9L4v8s/r
         CGw7IyQoofwgQgI6rEacSP33fjLrdMRLMXgcU3nDFTpnCLkyjuhOEQWRFZIMPZMAXvBB
         GsAA==
X-Forwarded-Encrypted: i=1; AFNElJ+NdJA4e8w7wfb1p8VIsp4abjXvXKVcQpjnRu2erqgelvYnRF8Ut0sbrI43t2f4lizO5t1J7/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAkOXBinws0aA0XKcyv0h+dQouQ/2xeE+zP930O8cZ8QdCb1a
	lTbkr5NM2onmA8/fvuqhGqmDqwrS5gFegtGJxVdA+n6vsP8MOTZvr+rB4RT7Puic+ZXux8bpy/P
	X+3HborwZO2Q89zNCDwt/2CnfWzV0P7wDGL+1lnKSt74wt+0JXIBLnIdTGjcb9bE2Iw==
X-Gm-Gg: AeBDieuQ2oXGdRdkIal0Ib7luY2VKYYLiBDacL34N/XMRgs2TrMln7g0XXjZOP2r8Wr
	z1GD9CwNztwNmFnrdXkZD/GVKkUn/hsJAwoU7LG9aV17K1GaoikqEqPTuxkr5i3AaxHqW0cyTxB
	AQp3GO1D9Fm1iTV2sHMA+WWDFP4GBd7TT9GukoDRPbOTfMaE2hc0fnfHA4BVJXmNp8yH2hYVBg1
	/1ULgqjvp7ivKgbysSyY0PJFbh45+23WGgk+j5qzugA1pBi2O8rQKvVfIzf/d5EDJU7tRuSIfIF
	Lqs6p3rWzr9nmCu35ZdioJ04GAS6l4qMBhXOEggo0bKz02EG9+fqQrRIbIthUecm5W9Q+eGppXa
	WavPZ9Lex5etRVQiP2LtyNSK7Rk6aMiSygb9vcoHiGu28rVnMg40=
X-Received: by 2002:a17:907:e152:b0:bc9:e1b1:8edf with SMTP id a640c23a62f3a-bc9e1b192e3mr84388866b.12.1778165562150;
        Thu, 07 May 2026 07:52:42 -0700 (PDT)
X-Received: by 2002:a17:907:e152:b0:bc9:e1b1:8edf with SMTP id a640c23a62f3a-bc9e1b192e3mr84386266b.12.1778165561383;
        Thu, 07 May 2026 07:52:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm90853066b.9.2026.05.07.07.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:52:40 -0700 (PDT)
Date: Thu, 7 May 2026 10:52:37 -0400
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
Message-ID: <20260507104701-mutt-send-email-mst@kernel.org>
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
X-Rspamd-Queue-Id: 2A8FD4EAB3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285365-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sberdevices.ru:email,oasis-open.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
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

I'll send something shortly just to give you an idea.


> > 
> > > As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
> > > for the overhead and notifying the other peer, at least until we find a
> > > better solution.
> > > 
> > > Stefano
> > 
> > well if you want to support pathological cases such as 1 byte messages
> > that would mean like 100x reduction no?
> > 
> 
> Yep, but since this patch is already merged, IMHO that is better than losing
> data in those pathological cases.
> 
> Thanks,
> Stefano





