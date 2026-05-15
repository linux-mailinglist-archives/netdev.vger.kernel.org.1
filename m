Return-Path: <netdev+bounces-288227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEs/N6HaBmrsoQIAu9opvQ
	(envelope-from <netdev+bounces-288227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:34:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988054B636
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 10:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425FD309C277
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25B40626A;
	Fri, 15 May 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGr/MaE3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmxdUbc5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7B3E3DAF
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833807; cv=none; b=uLr1+ytJOL87dX2g4Hw0+5PF+1tIMLeqmrq4ZBlUtaMWo921OiQfBtLyyAY2pEzjisGj5v7AgU4FdcdhyyXzLiDp6TCfV4IgJ717qJyhYH29Sx3KPtb0wQdmzyTexiC0/EMYrcHvmlW+/oDMLgdMEG7eB1QdK6DPFZIxWvFtSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833807; c=relaxed/simple;
	bh=EQ7IwlxGHE0J1foFsB+9uj3saln4eg27mwKY3T8VjcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX2zNBrDeJfUIaS99T+wJRW5jcqC3RGYa5SwL1UIPE+Tyurf1m9Cd/dowclnRJ/+JcvAkrs+aMZJaPPYDvwoa7AWuSBL7JJuPEEhRTTJre9XS+tutPb9bwGwqj6q445+q+f2fNw43Re9YxttAnjjl2IunDrDlT4PYLwZ+LACNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGr/MaE3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmxdUbc5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778833805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=muOsFm1ckUowqiVN5FPZIYRSKzSTI/TAawbrF7fG7TI=;
	b=AGr/MaE3pFzgwFyh0NsHByGGQl5Mr92JCoIYHGWZfoto0DH4V9INPCo1rTC9BgD/wcD8eF
	uDJGcT8U6flHSr/QYwCGTg73EZ5IO6H0XC6Bwp6W0nnv6lpQiDtI/EesOfhPPoK74DIx6C
	YxzqDshkEWSOI6w3PMDGE9vqyyWYUwg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-2Awt3KjwOoOEAm_utyvCZA-1; Fri, 15 May 2026 04:30:03 -0400
X-MC-Unique: 2Awt3KjwOoOEAm_utyvCZA-1
X-Mimecast-MFC-AGG-ID: 2Awt3KjwOoOEAm_utyvCZA_1778833802
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44dad1b938fso5290484f8f.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778833802; x=1779438602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=muOsFm1ckUowqiVN5FPZIYRSKzSTI/TAawbrF7fG7TI=;
        b=PmxdUbc5CflJjPmqKIUV8ucavZ1sGzkpV000ZVWk7ucG2NRsviLfUl/umTc+KRKyYT
         bpzb1mzwERikfW+FwEXSOTibPcDEufQVEv6+HBN8AL00HHH9inBH32oLMbZnsIKIFYVz
         z8qhVJa5Sb+toM8JrtYbCv+SqliHzYE3Ur4SW43+gj2ZW/k3j9JM9nNlKT9l+38CNdJC
         jy2eQS4cBPYWt0pIWcG7/holM87B53LguOQkXUOPvcC+NFPC/pr07gamW13aRtPi21tg
         /6B8vkj7t0l0qmfburX7MU61QpPdpVFj+re6EerJi4O1DG7HczsOl0Psp4+FLgiY68fy
         3noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778833802; x=1779438602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muOsFm1ckUowqiVN5FPZIYRSKzSTI/TAawbrF7fG7TI=;
        b=q6o+dVivecqUO0kwpdm/rkdzWGwaZaJCPX8wR6o5JbxLrkSvxn71bTDMP9pnBJB61D
         WnkVyhPnDPvMC7t4l+LnCpvr/8YsP5dYBkaaaoLvcFcEN4JF8Tpb95+QYL9S2qEZs3YI
         IhOTEV9JVJAEIje+SIl5HVhuRgZMOvIaCQxPN5vnwprk6fxE1rhGzrW7C/9gObp3Ut/C
         CzsB2VMgKL0QzO71aaaz3y3qzstQtF2z0fZNXTOXZORBBUkXqseVdv97L9lMNqQOYrMB
         BhsG8k7TfP+dndnH3ze5AaQmKfuOrf0pRv3j3vEOLy5IyK15M5tJJIPfJb4BHNJKnOfc
         e32Q==
X-Gm-Message-State: AOJu0YwL8UMneTPgDb0qH/EMAi7E6aVywprHzBYjwtXoKgD7mgDTF6uK
	ULq99gTAR5gMuJ306+JQP6fgJueG29PcwerT3d6NFkhtiaL1vvFcf3890ML9DES+yUif8HVPjHS
	V7EmWxiYwW+Xbo05L+CcEllJzKvWuScHth6DGRWePk/SxEa7J2TnTOdBq/w==
X-Gm-Gg: Acq92OHVZJjqDRfq7smC6QlUoI6doU8GLc3brjabtn0XSrcEzmReNxQdRXsE9JXIVkx
	B+ckOmXEw+N8K6pT22XPdXQyik+r3RgpF1Kx5pjeV7emmt2FUW86DHGdPhqkwyiJp1pN+XLpTGY
	3zXS7HS1YZOOONQvS4vBfn8jGLxt1YHfE2IQeqVuJInRtfXjSfZ5TnqRuzbhrn49e31d+m1JvKY
	UEGpj759MbiD8ChjCwjzZABnRPF+VysNLVjT0rDla+f9TogIgYdtZstKixIgkpYsMkCDV9SPbhn
	aV4AVz+gJdSGodZ8ZHIG4fk2rvlorQ7XUkp+nT50tTPpcg8HQPkRHWlzjzYjfuyA8BYQLmccf5w
	G06XIujEpNJzPAAsmX2f2KecOwDiXO4zFuC03htXm0lCeeRkCUCg62uRR0GfH9MPfErWSqEw+4Q
	==
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id 5b1f17b1804b1-48fe5fd483amr29432215e9.3.1778833800741;
        Fri, 15 May 2026 01:30:00 -0700 (PDT)
X-Received: by 2002:a05:600c:a11c:b0:48a:5970:2003 with SMTP id 5b1f17b1804b1-48fe5fd483amr29431715e9.3.1778833800267;
        Fri, 15 May 2026 01:30:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm13729817f8f.32.2026.05.15.01.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 01:29:59 -0700 (PDT)
Date: Fri, 15 May 2026 10:29:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agbWNqhzvEHVBvC2@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260514134347-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: 8988054B636
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288227-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
>On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
>> On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >
>> > On Thu, May 14, 2026 at 04:57:16PM +0200, Stefano Garzarella wrote:
>> > > On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
>> > > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > > >
>> > > > When there is no more space to queue an incoming packet, the packet is
>> > > > silently dropped. This causes data loss without any notification to
>> > > > either peer, since there is no retransmission.
>> > > >
>> > > > Under normal circumstances, this should never happen. However, it could
>> > > > happen if the other peer doesn't respect the credit, or if the skb
>> > > > overhead, which we recently began to take into account with commit
>> > > > 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
>> > > > is too high.
>> > > >
>> > > > Fix this by resetting the connection and setting the local socket error
>> > > > to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
>> > > > packet, so both peers are explicitly notified of the failure rather than
>> > > > silently losing data.
>> > > >
>> > > > Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
>> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > > ---
>> > > > net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
>> > > > 1 file changed, 14 insertions(+), 5 deletions(-)
>> > > >
>> > > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> > > > index 989cc252d3d3..4a4ac69d1ad1 100644
>> > > > --- a/net/vmw_vsock/virtio_transport_common.c
>> > > > +++ b/net/vmw_vsock/virtio_transport_common.c
>> > > > @@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
>> > > >     return err;
>> > > > }
>> > > >
>> > > > -static void
>> > > > +static bool
>> > > > virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> > > >                           struct sk_buff *skb)
>> > > > {
>> > > > @@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> > > >     spin_lock_bh(&vvs->rx_lock);
>> > > >
>> > > >     can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
>> > > > -   if (!can_enqueue) {
>> > > > -           free_pkt = true;
>> > > > +   if (!can_enqueue)
>> > > >             goto out;
>> > > > -   }
>> > > >
>> > > >     if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>> > > >             vvs->msg_count++;
>> > > > @@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>> > > >     spin_unlock_bh(&vvs->rx_lock);
>> > > >     if (free_pkt)
>> > > >             kfree_skb(skb);
>> > > > +
>> > > > +   return can_enqueue;
>> > > > }
>> > > >
>> > > > static int
>> > > > @@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
>> > > >
>> > > >     switch (le16_to_cpu(hdr->op)) {
>> > > >     case VIRTIO_VSOCK_OP_RW:
>> > > > -           virtio_transport_recv_enqueue(vsk, skb);
>> > > > +           if (!virtio_transport_recv_enqueue(vsk, skb)) {
>> > > > +                   /* There is no more space to queue the packet, so let's
>> > > > +                    * close the connection; otherwise, we'll lose data.
>> > > > +                    */
>> > > > +                   (void)virtio_transport_reset(vsk, skb);
>> > > > +                   sk->sk_state = TCP_CLOSE;
>> > > > +                   sk->sk_err = ENOBUFS;
>> > > > +                   sk_error_report(sk);
>> > >
>> > > sashiko reported some issues related to setting TCP_CLOSE state and not
>> > > removing the socket from the connect table:
>> > > https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com
>> > >
>> > > I'll change this by calling virtio_transport_do_close() and
>> > > vsock_remove_sock() in the next version.
>> > >
>> > > Stefano
>> > >
>> > > > +                   break;
>> > > > +           }
>> > > >             vsock_data_ready(sk);
>> > > >             return err;
>> > > >     case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>> > > > --
>> > > > 2.54.0
>> > > >
>> >
>> >
>> > And so the bag of hacks grows. I feel this is energy not well spent.
>> > Please, let us fix this properly *first*. And then worry about how to
>> > backport.  Maybe it will not be so terrible to backport after all.
>> >
>>
>> TBH I don't think this is an hack, but an issue we should fix in any case.
>> Regarding the second patch, I see your point, but it's a big change
>> that worries me. I'd like some more time to fix it properly without
>> rushing. Staying calm without realizing that userspace is broken like
>> we are now without this series :-(
>>
>> That said, evaluating further, I think we have a similar issue also
>> with STREAM on the host side where the skb usually doesn't free space,
>> so we need a merge strategy also there.
>>
>> So, I'd like to have time to fix both definitely. If you have time and
>> want to go ahead, please do.
>>
>> Thanks,
>> Stefano
>
>Well my patch was a start, we just need a strategy how to avoid copying
>everything, right?

Yep, and then there's the question of how to handle EOM without a 
payload, but I think that's a special case. In theory, we don't support 
sending it, but I'm not sure if POSIX allows it or not.

That said, is it okay if I send a v4 of this series?

(I'm not sure if I'll be able to work on the merging next week)

Stefano


