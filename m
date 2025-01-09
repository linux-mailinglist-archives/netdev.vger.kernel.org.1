Return-Path: <netdev+bounces-156573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C739A07113
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718481670FA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750EB21519C;
	Thu,  9 Jan 2025 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="ZKS+lY4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E7215176
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414034; cv=none; b=eIYXBh9qbY+WbMtNIXd80yhfsyhheWK0LC0mB/BGkOK7d6kLA5XOq0IqCNHASbURVIuXNUNYof/FvqoU38AOwpOGKrqc41V1A5YwqLBVWJfYpflKWfxplcfz0UmU2ElECkVCICgBnua+97kY2FBKxbMsDkAzVgdmYNXPaVPLT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414034; c=relaxed/simple;
	bh=rBwoqe1Wmgh9x9iNyM1XlHYEu8BOmk+OQoy4LiQcr3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDnPA8dtNDiBmdbs8bPtRbEasS6D+ppXvIYB/Tn6QoI/uzFKmn+KmgYYqdZp2Y//8vCtf6ytQBi/jdi2qc2yLBiQ2ZpGR3EM8lBiHOOWn4UOOT+QmNQC8bKIRcurDMF9E0Zx4DouzMTM3OkfhOQTCP06DcnoP+igeJQ28UY0l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=ZKS+lY4q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21670dce0a7so13255875ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736414032; x=1737018832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JDhWYX9BafkKaAXEfR74g4WUJtv8a1JPGzUGgZFFXl0=;
        b=ZKS+lY4qnyBBeYZhAX4+fyeOAOVxQkru1THd9Jfdbb+qpuNhzVEUyTKJM1PKR+lH/L
         nBozaUIIClwlWqeiE5fu8HsABu/a16Tf3UKDhyOQP2sK7IaLviTV16dtxm4m71cq7LpC
         myAjJ1S2xrMA/Wo+2jkJmYNezAVgZRe76km4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736414032; x=1737018832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDhWYX9BafkKaAXEfR74g4WUJtv8a1JPGzUGgZFFXl0=;
        b=vG9Vl/26x2ZCV9jcCy0PEQlq0ZbXf9Fzdk+X1351Zz9RFxs01e9AFr7ecJMHg3hte+
         OTJCYMSiqosTq2Yuto2ksU31mzz70Dz8J4iXce6oiR2oi0YpxOxrzZCkEnDVCCev3ANw
         iyNoXMHS1/A4VWy5j1FZkWBLKisc+fs9GonUVY8hmNUgYxkUrx35sT6r84I6vqzeDsvq
         U0YGiiVvTa0OY40SD1HgwFSXUIE/Ohl7UdfhF0CfJqijiWMHxTGgX9V609kKMKrc+4go
         2u7pBhkAYNW8QdpwyW8jJxoC8MXrNm2vhXGuuoHYwchTybTivosb2A2XVvBSnAYUSyGu
         chRg==
X-Gm-Message-State: AOJu0Ywb3uAqoAieWe+Hj3uIYcsKFNcp2l5ZhpwFSAL/FpDVgKoLyeeJ
	89s0m4olOpGkWTqjKnDFGG59Fa+t12qiEzyAcvYC0w4RM2T0GUJJEifki46d2hg=
X-Gm-Gg: ASbGncu31EDiWMr8qFrmLVHSswK4aCTCSvMLXlxoLmNg0SuEj7ZJe8EfS5GddXy5MOe
	nqMQRwltNA0YTsx7PzCD4Ui79K8Ny/ewLSBTUcf3RQ5S9TgjopknLp2wPHoOo6C6JN7srbyUwba
	VsIaovFjUI0kjY3Kk5EBwDg2tD5ioft4qgtuBZd6Lv8+NbiKWi4BlqQNVHYRtGGnH/ZGxtu+5iZ
	BSy0uM7PfeCq7V+jyUgkSxh0sBaIuoB9S6kx87bW7zzthl+9ylHERcZGgAgyrBKd2yZag==
X-Google-Smtp-Source: AGHT+IFw8wRkiTbU7BGp5mX2JtgxMuWF8qlDA2lSpDsKyjYi8kuXreh7G2BQzMPvk5sogG73DVd5pQ==
X-Received: by 2002:a17:903:249:b0:216:7ee9:2222 with SMTP id d9443c01a7336-21a83ffc1bcmr77965125ad.35.1736414031914;
        Thu, 09 Jan 2025 01:13:51 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a91770b61sm7949675ad.4.2025.01.09.01.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:13:51 -0800 (PST)
Date: Thu, 9 Jan 2025 04:13:44 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
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
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>,
	kvm@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <Z3+TSNfTJr2X8oQV@v4bel-B760M-AORUS-ELITE-AX>
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

For now, it seems better to merge them together.

It seems that covering this scenario will require more analysis and testing.


Regards,
Hyunwoo Kim

