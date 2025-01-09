Return-Path: <netdev+bounces-156571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F399A070D3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BEE1666EB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00E215172;
	Thu,  9 Jan 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Whvbh5or"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10F214A97
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413592; cv=none; b=bMAVY9BqSmiEHLCtxuabQDWGgljXpKkH24VMxqLpz4dwDK8r7aS4NQQr9cL3Fgy8amqpBVBMFUTZIggJHP/M2om/Upda/NGD3wkb9edrwTfXAr47/gV0k0V4OHg7CxzL9abWIK2t8LG95LBgNC19F7R3OI4yYbp5n7rCd8dXjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413592; c=relaxed/simple;
	bh=/QGyM01prQzG0mTpP+PKjbu8zo0LVi9zV42sNzHhZxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3F+wlpnhkun2JzSh0jyFtR+dXz4Km1o/od9UkVFBoWtmIrav/3cHRSC9yIcVAVveCpexBafY8ezQW8m6Ts8xyinmyCh8U4WLw9vjbVZ6bDvq2tO9vySfkWGIMobCDfyehzu72Y1prUrwLQ/f+tKmpX2H/RuhAmsawneRDG7OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Whvbh5or; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736413589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq/6xWdewBnkqjsFyBmYvqMniHrBBGp8CbrRgVyKKlI=;
	b=Whvbh5orYuTCqLwVHoOe0a+RxoqDJtRe4cTJxtqEWoGcruR0bb7Q2OW2B7Uc3nes7A8AzE
	+/Q/uk5UZiDK1lcfwyKXgT3TTNI/mPazwG4XlDj7+NrzcgZhcRJloA5LUAFdlysOrNUPZa
	BgUX8xbsAMjAqmXOpxCZG3Jr9syQ9zA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-W0PlVZUNNP-te-AXZsZsLA-1; Thu, 09 Jan 2025 04:06:27 -0500
X-MC-Unique: W0PlVZUNNP-te-AXZsZsLA-1
X-Mimecast-MFC-AGG-ID: W0PlVZUNNP-te-AXZsZsLA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa680e17f6dso57245266b.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 01:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413587; x=1737018387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq/6xWdewBnkqjsFyBmYvqMniHrBBGp8CbrRgVyKKlI=;
        b=kVYy0NdBZwaDwBxgyo5iqY0MzdmwASu2AEYAQzn3fMqcSQAoQ+01Ae5GvKEv0YU25g
         wg9yyOE2SmeQYDsnKFPwQ7X+JQy7AcLYXFezPBNW4lII0suHooQdFk9xGBsO5MLzty4F
         BR+Zvj6QvrwJqe+/JDfXL1074suC9w6nhAIqRS9MGpUawaqTw8v84BRGl+vpDee9WwUr
         rowgqBTmvkVCfxF5pPnntA8OwAmMPPOI75ThDZgPVa2Ip+yBWnIQFBUZHdpxQlbR4GLH
         8qRsCP6jQ3KYvbvS609+kij6Gd1nCeGYmCxj6/rvtXwBubxkIQbSqEqhqG1AEky1gWla
         h00w==
X-Forwarded-Encrypted: i=1; AJvYcCUWUZLH3/6CPr6oZp8MP+MBNxgcgnZ2nqRzlTMYG3IQ2yp7ihIck6FMkpRTFNHYqaZ+fsOBmMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkOWs9T8JEHg8qC2SYqU1Aooqf1ARRCPLh9SaAOZKrHUxZ3Kr
	BTZM5yY4nQ3OKwfCEJvHEAZmxMlu7YwU2yC6JFlycPqj1ZOx516LvHsuVUObDSoUeO/unA04abz
	Og9je7PJiXUTiui9JWAmxPUixi6F0yzwcQQ92o5qOVdqHem+dCXdirg==
X-Gm-Gg: ASbGncvbxF8uVf2MVP/Hxs94GSaA7vrtYPw/TZ/hmyMIi4fFrISgho24fUkKcicpg8o
	wduYAMJrwuA3hA+Rdgc/sottf3y0u7GLl13OYBAz5Cq4lgIA4vJfRcUTKmJU2+rGegKo4HgBAzk
	B3g9iEgaDDQwya83ukw4C0FFo4bbkR3z7yVArol/S93qHfFHiFwuSiNBpKrHBTekzAlJVrLz3St
	pTJPLVNxXg+L7wGerTPFXrtI3a+dy880y8AFzKo8FrmK1bYwkc=
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id 4fb4d7f45d1cf-5d972e00027mr12379751a12.5.1736413585676;
        Thu, 09 Jan 2025 01:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMeDUq48ZiEO5NB+/CECsRZI/hOj1DbWFgJdIBm69MXifXS36ORET2SuFFSlHmTy+PIRAewQ==
X-Received: by 2002:a05:6402:530f:b0:5d1:2377:5af3 with SMTP id 4fb4d7f45d1cf-5d972e00027mr12379693a12.5.1736413585228;
        Thu, 09 Jan 2025 01:06:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm49942566b.93.2025.01.09.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:06:24 -0800 (PST)
Date: Thu, 9 Jan 2025 04:06:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Hyunwoo Kim <v4bel@theori.io>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wongi Lee <qwerty@theori.io>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtualization@lists.linux.dev,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <20250109040604-mutt-send-email-mst@kernel.org>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
 <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>

On Thu, Jan 09, 2025 at 10:01:31AM +0100, Stefano Garzarella wrote:
> On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
> > On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
> > > If the socket has been de-assigned or assigned to another transport,
> > > we must discard any packets received because they are not expected
> > > and would cause issues when we access vsk->transport.
> > > 
> > > A possible scenario is described by Hyunwoo Kim in the attached link,
> > > where after a first connect() interrupted by a signal, and a second
> > > connect() failed, we can find `vsk->transport` at NULL, leading to a
> > > NULL pointer dereference.
> > > 
> > > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > > Reported-by: Hyunwoo Kim <v4bel@theori.io>
> > > Reported-by: Wongi Lee <qwerty@theori.io>
> > > Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 9acc13ab3f82..51a494b69be8 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> > > 
> > >  	lock_sock(sk);
> > > 
> > > -	/* Check if sk has been closed before lock_sock */
> > > -	if (sock_flag(sk, SOCK_DONE)) {
> > > +	/* Check if sk has been closed or assigned to another transport before
> > > +	 * lock_sock (note: listener sockets are not assigned to any transport)
> > > +	 */
> > > +	if (sock_flag(sk, SOCK_DONE) ||
> > > +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
> > 
> > If a race scenario with vsock_listen() is added to the existing
> > race scenario, the patch can be bypassed.
> > 
> > In addition to the existing scenario:
> > ```
> >                     cpu0                                                      cpu1
> > 
> >                                                               socket(A)
> > 
> >                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
> >                                                                 vsock_bind()
> > 
> >                                                               listen(A)
> >                                                                 vsock_listen()
> >  socket(B)
> > 
> >  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
> >    vsock_connect()
> >      lock_sock(sk);
> >      virtio_transport_connect()
> >        virtio_transport_connect()
> >          virtio_transport_send_pkt_info()
> >            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
> >              queue_work(vsock_loopback_work)
> >      sk->sk_state = TCP_SYN_SENT;
> >      release_sock(sk);
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
> >                                                                   sk = vsock_find_bound_socket(&dst);
> >                                                                   virtio_transport_recv_listen(sk, skb)
> >                                                                     child = vsock_create_connected(sk);
> >                                                                     vsock_assign_transport()
> >                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
> >                                                                     vsock_insert_connected(vchild);
> >                                                                       list_add(&vsk->connected_table, list);
> >                                                                     virtio_transport_send_response(vchild, skb);
> >                                                                       virtio_transport_send_pkt_info()
> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> >                                                                           queue_work(vsock_loopback_work)
> > 
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
> >                                                                   sk = vsock_find_bound_socket(&dst);
> >                                                                   lock_sock(sk);
> >                                                                   case TCP_SYN_SENT:
> >                                                                   virtio_transport_recv_connecting()
> >                                                                     sk->sk_state = TCP_ESTABLISHED;
> >                                                                   release_sock(sk);
> > 
> >                                                               kill(connect(B));
> >      lock_sock(sk);
> >      if (signal_pending(current)) {
> >      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
> >      sock->state = SS_UNCONNECTED;    // [1]
> >      release_sock(sk);
> > 
> >  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
> >    vsock_connect(B)
> >      lock_sock(sk);
> >      vsock_assign_transport()
> >        virtio_transport_release()
> >          virtio_transport_close()
> >            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
> >            virtio_transport_shutdown()
> >              virtio_transport_send_pkt_info()
> >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> >                  queue_work(vsock_loopback_work)
> >            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
> >        vsock_deassign_transport()
> >          vsk->transport = NULL;
> >        return -ESOCKTNOSUPPORT;
> >      release_sock(sk);
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
> >                                                                   virtio_transport_recv_connected()
> >                                                                     virtio_transport_reset()
> >                                                                       virtio_transport_send_pkt_info()
> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
> >                                                                           queue_work(vsock_loopback_work)
> >  listen(B)
> >    vsock_listen()
> >      if (sock->state != SS_UNCONNECTED)    // [2]
> >      sk->sk_state = TCP_LISTEN;    // [3]
> > 
> >                                                               vsock_loopback_work()
> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
> > 								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
> > 								   ...
> > 							
> >  virtio_transport_close_timeout()
> >    virtio_transport_do_close()
> >      vsock_stream_has_data()
> >        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
> > 
> > ```
> > (Yes, This is quite a crazy scenario, but it can actually be induced)
> > 
> > Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
> > it can pass the sock->state check[2] in vsock_listen() and set
> > sk->sk_state to TCP_LISTEN[3].
> > If this happens, the check in the patch with
> > `sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
> > still occur.)
> > 
> > More specifically, because the sk_state has changed to TCP_LISTEN,
> > virtio_transport_recv_disconnecting() will not be called by the
> > loopback worker. However, a null-ptr-deref may occur in
> > virtio_transport_close_timeout(), which is scheduled by
> > virtio_transport_close() called in the flow of the second connect()[5].
> > (The patch no longer cancels the virtio_transport_close_timeout() worker)
> > 
> > And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
> > patch, it seems that a null-ptr-deref will still occur due to
> > virtio_transport_close_timeout().
> > It might be necessary to add worker cancellation at the
> > appropriate location.
> 
> Thanks for the analysis!
> 
> Do you have time to cook a proper patch to cover this scenario?
> Or we should mix this fix together with your patch (return 0 in
> vsock_stream_has_data()) while we investigate a better handling?
> 
> Thanks,
> Stefano

better combine them imho. 


