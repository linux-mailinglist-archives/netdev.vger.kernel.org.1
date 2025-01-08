Return-Path: <netdev+bounces-156422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09451A06564
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446913A72BA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E71F708D;
	Wed,  8 Jan 2025 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="EjdWt7UK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFD15852E
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364689; cv=none; b=Yu1OiVXZDJmBfifwt03TLyvZrCK2uLP0WsOMz2ORGO8tRssWx+EemLfHwd/74KfReejQHSxkSCPyx6wkBV60JKw6VDVLOIj1uzZEH0eo7L9+qmCrPvH4XQeR6iS3YKih71V9Zg+3zAyLh3/hV8Sed3sBr1IkwEnDmoA88+lqxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364689; c=relaxed/simple;
	bh=5b1MJ0amuIx6mkoE9SwD4e2ebV7znRTHvoH2P67Bib8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol2S8JFawt1GFupoiHWsR/c9L7l521Gtf3c1MnmFZCpSh31Dly//mNeqfALxhUCquGjZ/Qhyr8lbSQnQnxD7NGWVhlNAEMGu8oVaJxg+Q9CcTiumcBmnQ7tPkRE8nwig2jFGkuJyFflBW158f1nUfrDFmHX9juOiW5jyAQP/sek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=EjdWt7UK; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21a1e6fd923so1955735ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 11:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1736364687; x=1736969487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jtvo4ir8kxjljq7eka2U506iji5/r9yiGfObZJA9Hk=;
        b=EjdWt7UK2dCH98wTukK4CTeGQYayGHZLKvnNk31xsL26juOnQefnWXIVGMzhQnG1Hi
         Ki01tbNSWvC3vgSMxuxBVGoUUuF++z9IdYxMF7kQeUmD+EgHHCSMNCKLBboBtWEJuJcZ
         wRoz6yo9wqWrGatWpZUaiqaNN98ozbttAVusY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364687; x=1736969487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jtvo4ir8kxjljq7eka2U506iji5/r9yiGfObZJA9Hk=;
        b=aJVJq/QczAmJtr5exc0Vk2ualzN9k/0MK3R+9m+h9wxqaUQCszzbuowB9hxIWtMUkD
         62Jl2dhTduRNDGz/3ha7wa3S6F2+1j4AS2Cs40TMG8wr6ubYoRYWnECDyPi3E4A8Icj3
         ahEFk6krw5p4oYsR2ju+BuWCW4Je41FfPaRBiPvgH5cVHCTRW8NgUu0g23Wua0sfFVDQ
         17+8h+UgCG7dbWYwM98QS4X0Mh/EI5KZPZKE/9ivvV4mQQ8gXikqfZbn4ldRIgjEMW/C
         NGklWCAwJSm/Q/P4+vDhJVTWLeAtgJPbErSeQd8TTpkMIgapSaoVfjqNxGacNH6dDb6y
         KfHA==
X-Gm-Message-State: AOJu0YxzI6rzq/RXOrV3vsdwj9B+hHLPb0REZ0P25/sFDU6WfJemEY4x
	jC3n6qU3AYu2g2oSruESKenv+ARDsAasiABCWeKhodE4AYGSJu8B4uvUW5EjNoM=
X-Gm-Gg: ASbGnctqJKBDpyNdJm00bOiKlJ4J3zRy7Wmc55dKtHrJD7jI87X/5yEMozkH6RFevk/
	YgdRQuT0MYDOnSd3lP2+f3GH/B5BdrJjaFitUT8q1FyPeV/tAdyxrZfXkCJjDg4CeqXdlMWtB3L
	mUO35KAgE5ap1dKQOGfkUydFQE+YIRnc7rzvQZm1ApSJCVhp/iDyXr2UPfIJkhzfkU2Sr+GFzhn
	KE4hO3rPEYhZFQgpeYCn+3YOESnA5XdpHPqljOFFcOI0rl1boG5OFhspOqKAldJQRFd7Q==
X-Google-Smtp-Source: AGHT+IF6d1lxbSLuWO/THk+x8aSRyMXzHsLrJNMSbGKpqc+WLXQkKiPlHLgXRv3O4vL92v4Ati9bOw==
X-Received: by 2002:a05:6a21:398:b0:1e1:ae83:ad04 with SMTP id adf61e73a8af0-1e88d134c3emr6681500637.27.1736364686950;
        Wed, 08 Jan 2025 11:31:26 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbbabsm37006185b3a.101.2025.01.08.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:31:26 -0800 (PST)
Date: Wed, 8 Jan 2025 14:31:19 -0500
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
	kvm@vger.kernel.org, v4bel@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108180617.154053-2-sgarzare@redhat.com>

On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
> If the socket has been de-assigned or assigned to another transport,
> we must discard any packets received because they are not expected
> and would cause issues when we access vsk->transport.
> 
> A possible scenario is described by Hyunwoo Kim in the attached link,
> where after a first connect() interrupted by a signal, and a second
> connect() failed, we can find `vsk->transport` at NULL, leading to a
> NULL pointer dereference.
> 
> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> Reported-by: Hyunwoo Kim <v4bel@theori.io>
> Reported-by: Wongi Lee <qwerty@theori.io>
> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9acc13ab3f82..51a494b69be8 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>  
>  	lock_sock(sk);
>  
> -	/* Check if sk has been closed before lock_sock */
> -	if (sock_flag(sk, SOCK_DONE)) {
> +	/* Check if sk has been closed or assigned to another transport before
> +	 * lock_sock (note: listener sockets are not assigned to any transport)
> +	 */
> +	if (sock_flag(sk, SOCK_DONE) ||
> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {

If a race scenario with vsock_listen() is added to the existing 
race scenario, the patch can be bypassed.

In addition to the existing scenario:
```
                     cpu0                                                      cpu1

                                                               socket(A)

                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
                                                                 vsock_bind()

                                                               listen(A)
                                                                 vsock_listen()
  socket(B)

  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
    vsock_connect()
      lock_sock(sk);
      virtio_transport_connect()
        virtio_transport_connect()
          virtio_transport_send_pkt_info()
            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
              queue_work(vsock_loopback_work)
      sk->sk_state = TCP_SYN_SENT;
      release_sock(sk);
                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
                                                                   sk = vsock_find_bound_socket(&dst);
                                                                   virtio_transport_recv_listen(sk, skb)
                                                                     child = vsock_create_connected(sk);
                                                                     vsock_assign_transport()
                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
                                                                     vsock_insert_connected(vchild);
                                                                       list_add(&vsk->connected_table, list);
                                                                     virtio_transport_send_response(vchild, skb);
                                                                       virtio_transport_send_pkt_info()
                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
                                                                           queue_work(vsock_loopback_work)

                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
                                                                   sk = vsock_find_bound_socket(&dst);
                                                                   lock_sock(sk);
                                                                   case TCP_SYN_SENT:
                                                                   virtio_transport_recv_connecting()
                                                                     sk->sk_state = TCP_ESTABLISHED;
                                                                   release_sock(sk);

                                                               kill(connect(B));
      lock_sock(sk);
      if (signal_pending(current)) {
      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
      sock->state = SS_UNCONNECTED;    // [1]
      release_sock(sk);

  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
    vsock_connect(B)
      lock_sock(sk);
      vsock_assign_transport()
        virtio_transport_release()
          virtio_transport_close()
            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
            virtio_transport_shutdown()
              virtio_transport_send_pkt_info()
                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                  queue_work(vsock_loopback_work)
            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
        vsock_deassign_transport()
          vsk->transport = NULL;
        return -ESOCKTNOSUPPORT;
      release_sock(sk);
                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
                                                                   virtio_transport_recv_connected()
                                                                     virtio_transport_reset()
                                                                       virtio_transport_send_pkt_info()
                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
                                                                           queue_work(vsock_loopback_work)
  listen(B)
    vsock_listen()
      if (sock->state != SS_UNCONNECTED)    // [2]
      sk->sk_state = TCP_LISTEN;    // [3]

                                                               vsock_loopback_work()
                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
								   ...
							       
  virtio_transport_close_timeout()
    virtio_transport_do_close()
      vsock_stream_has_data()
        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref 

```
(Yes, This is quite a crazy scenario, but it can actually be induced)

Since sock->state is set to SS_UNCONNECTED during the first connect()[1], 
it can pass the sock->state check[2] in vsock_listen() and set 
sk->sk_state to TCP_LISTEN[3].
If this happens, the check in the patch with 
`sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can 
still occur.

More specifically, because the sk_state has changed to TCP_LISTEN, 
virtio_transport_recv_disconnecting() will not be called by the 
loopback worker. However, a null-ptr-deref may occur in 
virtio_transport_close_timeout(), which is scheduled by 
virtio_transport_close() called in the flow of the second connect()[5].
(The patch no longer cancels the virtio_transport_close_timeout() worker)

And even if the `sk->sk_state != TCP_LISTEN` check is removed from the 
patch, it seems that a null-ptr-deref will still occur due to 
virtio_transport_close_timeout(). 
It might be necessary to add worker cancellation at the 
appropriate location.

