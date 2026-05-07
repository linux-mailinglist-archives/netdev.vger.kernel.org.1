Return-Path: <netdev+bounces-285321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNZ7HeyM/GleRAAAu9opvQ
	(envelope-from <netdev+bounces-285321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:00:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5804E8B03
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B13C4301AEE8
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C783F661F;
	Thu,  7 May 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMS7XDQC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DItTEA3b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA73AF672
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158793; cv=none; b=sRXcLsHZ02naJziZA3vRW6boDIzjLJgzfx3f37cmRkrtslDzHAMbd4n1182x0iI4mx/5uXjz9qkjXId2PBHRC/5Opbvp03rtinXWVP2mfOvcCBLWtPdczivaGJzRNxNoXrC1HaslIYzM/bLByuG6nJSNX850K+I2+wpzyyokeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158793; c=relaxed/simple;
	bh=a1ipHP4vJKqQ1PCjSE2XOtkD4KIsGKmi/PHR4V/X8j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ovpuq5n2+72nhP/UUtpM2vF5G1rFpayk/FJ+ZrFuWetLDrbk2CN1yWkNAgsj3RGSFbZ2T+k5q+dFSEtNTWE/95L6ky3xGNyCDPHuSd6TGeI9751FX99HsibBXgXXYw5THaKxtzMDe5Y6bLHpbkiLr3z5RzRMZ8LEwU7CwYwQz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMS7XDQC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DItTEA3b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778158790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6a38SeOw0jKuyeFe5c6jTpEyvp+0L5OzxyUUit2nySo=;
	b=QMS7XDQCsaQrA3mg3xtUrl/JYKHE0ACssZmlVurxQWyLysrM8jfEGmBmphJhvjkfF4PUdw
	pskur5x3KaJn/vADX7+oJpE4BAqRtBD0yhW9kxpRxBVU1Y1qjg4ToHY+Y6WJ4iwcMoC3Wf
	RGDif214PuoU9AmQUmJW7lee03SwKYc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hggsQGe3MWiScMMxI3ADDg-1; Thu, 07 May 2026 08:59:49 -0400
X-MC-Unique: hggsQGe3MWiScMMxI3ADDg-1
X-Mimecast-MFC-AGG-ID: hggsQGe3MWiScMMxI3ADDg_1778158788
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44a122a5128so660115f8f.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778158788; x=1778763588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6a38SeOw0jKuyeFe5c6jTpEyvp+0L5OzxyUUit2nySo=;
        b=DItTEA3bKvo5kjeeQrFa10ewmnGzrlUsSLGGv2f1RXo4YteMJFBuqq3H+mNBh6d7jE
         3BiG6phzUHEQpiJTfu6QuG1rD1RrR63BSCic4igHJ3hHQQwxAviP0M4a6c1i1KkEipuv
         /z9gA5FvlvYlReHz8tNSNf9rKyp84X1asKn0i2xj46n5aAF/tn4rmDTHd/WGnhL4J3od
         XV746VTC/1l/m8i7+MnqVYmcWxuzG4S+sTOjugMzpC/yfm6LTki4EhT7Co4T1flNLiDK
         180s+Uyyp2t/WAG0lrVTeJLFaO1gcKl0BjDvfd2wAKhKR2nnge9ilftdQ+q6m8Y/Ty+7
         tCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158788; x=1778763588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a38SeOw0jKuyeFe5c6jTpEyvp+0L5OzxyUUit2nySo=;
        b=YAGhT0UtNLvHYVhpS+OruI9saeDQXCrMjfzuOpR9XUyRdXpC7K1kD1GyaOF2iQ6fm0
         vhZHY/fgjNqDHQni2xKx0c1HQnIVe+CVO5XlmMc3+IJfhypdyPQ1E+2y8IVvivPPhz+A
         URrBXJj5swOnu+QLHSc6nShaiEFZPfbwZWo7fnnPtQRcWqD9gmHa/FeU0qOmW9x3Fqk/
         +yZ8IQHOCCIB884V8deR8wqKtmT0Z5zZS/jQWwpWxr/MHMzJKIRPNHmMyCzdO6HjWzFS
         PNcE8cjHYmC2pXKJX3s2CDbKsOnNnVBB/Kxhkcy978XBhShiI6DRIHBovirh9k6l94lb
         8GjA==
X-Forwarded-Encrypted: i=1; AFNElJ+fHp6orR3s3bqgKhlSsOkodOCfiBfDZBoWUS1jpl4SuknpD1Cs+mw/Ezymj3tp8c1B21pzy2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16ALO0SznB6VrF9xvlS9Twce27V4Bp/0MjmJD0vdWulj8xA+9
	njDvI0Nkt62xZwunth1qNM1S1oJx65pNlzBBfaxOUquTz3sd0FMS7LAe94vv2D7K+OMgefSPbD3
	0GuU4JHeYf77i3L4wuCKHoNbJgwtlWAZAaF8qW7m5pC3nfQTZ0VepWvlBJvGiZT0ZQw==
X-Gm-Gg: AeBDietaapWVBKxVG7y3Q8Zjb+JrhVzIOw4sozK9ly0HmpRa0ScKZ0wK6wadnI8Dw3B
	zIgu7gKWwOiRstjSAhrQjiyzR5JYJVFou9wOzbgf/2+1pkqm6QxMQDl0cXf+j6aqXWNHrJ1oth6
	IUv5BmOrwGv35cFLr3KtzyBZwpqVz/qIxhhVoFwX7PsolXeNtABB1D1w7t6epbU58a5cx5tMn5M
	kfnh0AYd4OWa1L9OPnpuYZUHCNspeagC3CfjUdhcRahS5noYlH9tZ8ZHkK1xu5rcYnGBxp6ahV0
	oNgdL6TThr/0eCsppM+jjKWDxVb6uif6GrAJer1z7UYdsRIiNZbFjypob4QYY/UfrGV/Hu1791J
	V7KwiNd9rBbwy9jdFkspxsC/vey4HgVTOKhsIOwWDnS+Fw6e9R63syRVBemCCw5GZ2LSvFsXk+A
	==
X-Received: by 2002:a5d:5d89:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-4515d5c5750mr12867091f8f.29.1778158787140;
        Thu, 07 May 2026 05:59:47 -0700 (PDT)
X-Received: by 2002:a5d:5d89:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-4515d5c5750mr12867018f8f.29.1778158786505;
        Thu, 07 May 2026 05:59:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2203csm20313623f8f.37.2026.05.07.05.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:59:45 -0700 (PDT)
Date: Thu, 7 May 2026 14:59:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afyMCyBvZpzWrLtO@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507074113-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: DF5804E8B03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285321-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
>On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
>> On Wed, May 06, 2026 at 11:37:45AM -0400, Michael S. Tsirkin wrote:
>> > On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
>> > > On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
>> > > > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > > > >
>> > > > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>> > > > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>> > > > > >
>> > > > > >virtio_transport_recv_enqueue() skips coalescing for packets
>> > > > > >with VIRTIO_VSOCK_SEQ_EOM.
>> > > > > >
>> > > > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>> > > > > >a very large number of packets can be queued
>> > > > > >because vvs->rx_bytes stays at 0.
>> > > > > >
>> > > > > >Fix this by estimating the skb metadata size:
>> > > > > >
>> > > > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
>> > > > > >
>> > > > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>> > > > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > > > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>> > > > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > > > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > > > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> > > > > >Cc: Jason Wang <jasowang@redhat.com>
>> > > > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> > > > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
>> > > > > >Cc: kvm@vger.kernel.org
>> > > > > >Cc: virtualization@lists.linux.dev
>> > > > > >---
>> > > > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
>> > > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
>> > > > > >
>> > > > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>> > > > > >--- a/net/vmw_vsock/virtio_transport_common.c
>> > > > > >+++ b/net/vmw_vsock/virtio_transport_common.c
>> > > > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>> > > > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>> > > > > >                                       u32 len)
>> > > > > > {
>> > > > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
>> > > > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> > > > > >+
>> > > > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> > > > > >               return false;
>> > > > >
>> > > > > I'm not sure about this fix, I mean that maybe this is incomplete.
>> > > > > In virtio-vsock, there is a credit mechanism between the two peers:
>> > > > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
>> > > > >
>> > > > > This takes only the payload into account, so it’s true that this problem
>> > > > > exists; however, perhaps we should also inform the other peer of a lower
>> > > > > credit balance, otherwise the other peer will believe it has much more
>> > > > > credit than it actually does, send a large payload, and then the packet
>> > > > > will be discarded and the data lost (there are no retransmissions,
>> > > > > etc.).
>> > > >
>> > > > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
>> > > > state to account credit")
>> > > > and find a better fix then?
>> > >
>> > > IIRC the same issue was there before the commit fixed by that one (commit
>> > > 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
>> > > not sure about reverting it TBH.
>> > >
>> > > CCing Arseniy and Bobby.
>> > >
>> > > >
>> > > > There is always a discrepancy between skb->len and skb->truesize.
>> > > > You will not be able to announce a 1MB window, and accept one milliion
>> > > > skb of 1-byte each.
>> > > >
>> > > > This kind of contract is broken.
>> > > >
>> > >
>> > > Yep, I agree, but before we start discarding data (and losing it), IMHO we
>> > > should at least inform the other peer that we're out of space.
>> > >
>> > > @Stefan, @Michael, do you think we can do something in the spec to avoid
>> > > this issue and in some way take into account also the metadata in the
>> > > credit. I mean to avoid the 1-byte packets flooding.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > Why do we need the metadata? Just don't keep it around if you begin
>> > running low on memory.
>>
>> I don't think removing the skuffs will be easy; we added them for ebpf,
>> zero-copy, and seqpacket as well.
>
>You do not need to remove them completely.
>
>> For now, we're already doing something:
>> merging the skuffs if they don't have EOM set.
>
>
>Right that's good. You could go further and merge with EOM too
>if you stick the info about message boundaries somewhere else.

This adds a lot of complexity IMO, but we can try.

Do you have something in mind?

>
>> As a quick fix, I'm thinking of reducing the `buf_alloc` value to account
>> for the overhead and notifying the other peer, at least until we find a
>> better solution.
>>
>> Stefano
>
>well if you want to support pathological cases such as 1 byte messages
>that would mean like 100x reduction no?
>

Yep, but since this patch is already merged, IMHO that is better than 
losing data in those pathological cases.

Thanks,
Stefano


