Return-Path: <netdev+bounces-156569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40CA070A9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00BC3A2E9B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F25A21506F;
	Thu,  9 Jan 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCG16E1G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F52010FD
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413306; cv=none; b=YrHrbvZk6RzlLHZoH4tP3bzysPKEU4FUPeY0sOBqMK17ZRxFOEC+QeNkOyfmMhf5tR1aqJ//mDG2i5aCOwxIEs1GzGtXSD6CblQUgqD5pmHn36TKwR2KGttuRHeTPxfEZSIaT8LIiHCUQt9QQj5AwUkNkzWkLYAX8LmaYfFKpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413306; c=relaxed/simple;
	bh=+sIdD58FlzLJ0SpEVOPekmjkzCRZ+9ERthJqbNbAqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qj1drgcA5UvPRERqWFp5cEVZL79LuWwmirD5o2uxAqsgeDVbxaFSZxBgCzMj/SV7ujg1e3Y8QfoYhPfCVGnbGB9IhpaF3CCeuZhPkOSFLK08oT6+uErE3gzP3fPKBWZvI+zk6jHnhftduXqUSUBjHJYIygpeWm5+SpwGxqi5uEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCG16E1G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736413303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/+PvGvb8cisc0+olaJcorud7NkJpehAn5lKv6sXjgA=;
	b=MCG16E1GWEBauWz8SCWH/nWY3nOZMdC8q8LyiGwXuvWukaVO4wJRKulDBu8uZWbDNJJe8C
	x8RZOoutUHb0nSqfRi9MDQ5bvudZpnaTGzhckyp0zj0QRJEYCJbdeX5kZgubIhzh5q/mNQ
	NuUFpHFlw61HUo6zET83dJo5yPBH3cI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-IBXQU8DIPR2RXNtI_Odigg-1; Thu, 09 Jan 2025 04:01:41 -0500
X-MC-Unique: IBXQU8DIPR2RXNtI_Odigg-1
X-Mimecast-MFC-AGG-ID: IBXQU8DIPR2RXNtI_Odigg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab2b300e5daso68377866b.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 01:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736413299; x=1737018099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/+PvGvb8cisc0+olaJcorud7NkJpehAn5lKv6sXjgA=;
        b=kAFMo3glFeNqy1FUF/I4SZcJyLymOOXQoUnV0w5lzFtyfM//NtlWuU4BeSUw807shL
         vVtLOAtTsllMRRgS9kN20lM0/TeK/aR5RZwcbIImgLIJV/K0+SH15mmwLuh7h/S9Ppoa
         evoYeB5y57NNpmRluIc2vScjjfbNd/9Yqlo1joMLTUC0Ct41WfijqdVrDW0S6ptm8QG0
         woG72o22wF7ox0BMYb0gPgORbUnz+7ARheYqROlVRSQ/flSddvYQ1CqEhnBhDvYNGgot
         XpYXXf59WkcuQIzKqWXetdU+pGkBDARm+kjZgs+SpOi7W1U4fD5prBmmO4XrldcrZ2em
         YV9g==
X-Gm-Message-State: AOJu0YyU2IIyPqJIlddzX4GIA/FMR7g0UTECTKW1g8XOxZpqKGW78XKZ
	IcVLkXm29DJYkE5D4BjtiX+0FleUxFvxSPw0BRuJZbWgydzyCYQU2GpYPQsaOkKUhm5s10SPVOo
	R+WJaOZNUOmvelx2xTE9UT3M/2qhsKloEIsGBg5sE8yz1vYr1FOtX49JfPbQK9zUj
X-Gm-Gg: ASbGncsVfmI5QaMop2QBMDmo67QwiSIWxn2HJ7QW4e5mLfVzmLkN8zvA6ZaGIP7LLK9
	rNrwwyGmoAcB7Vldk1bsakfR00ObJ9CrFhLQ7XeqeoJ4tTzPt1vexvbzeju+s2eWBcg2HwhbJpT
	OkuF860aeUcDowdzUlpsEZIujrIzuinq4Po5aUrrbD1gST/9yvKWHXjmND6PJU0yTUed/kcvNXI
	LbdMkAlR4CMDn//uDQQa5gelIOqqudZ3Evc7I07V1fLg/mZOaELQf/1xlk=
X-Received: by 2002:a17:907:a08e:b0:ab2:c1e5:397c with SMTP id a640c23a62f3a-ab2c1e53ab3mr223775666b.29.1736413299316;
        Thu, 09 Jan 2025 01:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOV9JHlol/Wmiz7E/zdqdsLMLcaiajVGTKl716cWZNRFMuCfB7oQmf+Zga+/+By1e+6a2YiA==
X-Received: by 2002:a17:907:a08e:b0:ab2:c1e5:397c with SMTP id a640c23a62f3a-ab2c1e53ab3mr223769366b.29.1736413298532;
        Thu, 09 Jan 2025 01:01:38 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f067sm50679166b.14.2025.01.09.01.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 01:01:37 -0800 (PST)
Date: Thu, 9 Jan 2025 10:01:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, kvm@vger.kernel.org, 
	imv4bel@gmail.com
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <77plpkw3mp4r3ue4ubmh4yhqfo777koiu65dqfqfxmjgc5uq57@aifi6mhtgtuj>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Jan 08, 2025 at 02:31:19PM -0500, Hyunwoo Kim wrote:
>On Wed, Jan 08, 2025 at 07:06:16PM +0100, Stefano Garzarella wrote:
>> If the socket has been de-assigned or assigned to another transport,
>> we must discard any packets received because they are not expected
>> and would cause issues when we access vsk->transport.
>>
>> A possible scenario is described by Hyunwoo Kim in the attached link,
>> where after a first connect() interrupted by a signal, and a second
>> connect() failed, we can find `vsk->transport` at NULL, leading to a
>> NULL pointer dereference.
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Reported-by: Hyunwoo Kim <v4bel@theori.io>
>> Reported-by: Wongi Lee <qwerty@theori.io>
>> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..51a494b69be8 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>  	lock_sock(sk);
>>
>> -	/* Check if sk has been closed before lock_sock */
>> -	if (sock_flag(sk, SOCK_DONE)) {
>> +	/* Check if sk has been closed or assigned to another transport before
>> +	 * lock_sock (note: listener sockets are not assigned to any transport)
>> +	 */
>> +	if (sock_flag(sk, SOCK_DONE) ||
>> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>
>If a race scenario with vsock_listen() is added to the existing
>race scenario, the patch can be bypassed.
>
>In addition to the existing scenario:
>```
>                     cpu0                                                      cpu1
>
>                                                               socket(A)
>
>                                                               bind(A, {cid: VMADDR_CID_LOCAL, port: 1024})
>                                                                 vsock_bind()
>
>                                                               listen(A)
>                                                                 vsock_listen()
>  socket(B)
>
>  connect(B, {cid: VMADDR_CID_LOCAL, port: 1024})
>    vsock_connect()
>      lock_sock(sk);
>      virtio_transport_connect()
>        virtio_transport_connect()
>          virtio_transport_send_pkt_info()
>            vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_REQUEST)
>              queue_work(vsock_loopback_work)
>      sk->sk_state = TCP_SYN_SENT;
>      release_sock(sk);
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_REQUEST)
>                                                                   sk = vsock_find_bound_socket(&dst);
>                                                                   virtio_transport_recv_listen(sk, skb)
>                                                                     child = vsock_create_connected(sk);
>                                                                     vsock_assign_transport()
>                                                                       vvs = kzalloc(sizeof(*vvs), GFP_KERNEL);
>                                                                     vsock_insert_connected(vchild);
>                                                                       list_add(&vsk->connected_table, list);
>                                                                     virtio_transport_send_response(vchild, skb);
>                                                                       virtio_transport_send_pkt_info()
>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RESPONSE)
>                                                                           queue_work(vsock_loopback_work)
>
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RESPONSE)
>                                                                   sk = vsock_find_bound_socket(&dst);
>                                                                   lock_sock(sk);
>                                                                   case TCP_SYN_SENT:
>                                                                   virtio_transport_recv_connecting()
>                                                                     sk->sk_state = TCP_ESTABLISHED;
>                                                                   release_sock(sk);
>
>                                                               kill(connect(B));
>      lock_sock(sk);
>      if (signal_pending(current)) {
>      sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>      sock->state = SS_UNCONNECTED;    // [1]
>      release_sock(sk);
>
>  connect(B, {cid: VMADDR_CID_HYPERVISOR, port: 1024})
>    vsock_connect(B)
>      lock_sock(sk);
>      vsock_assign_transport()
>        virtio_transport_release()
>          virtio_transport_close()
>            if (!(sk->sk_state == TCP_ESTABLISHED || sk->sk_state == TCP_CLOSING))
>            virtio_transport_shutdown()
>              virtio_transport_send_pkt_info()
>                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                  queue_work(vsock_loopback_work)
>            schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);	// [5]
>        vsock_deassign_transport()
>          vsk->transport = NULL;
>        return -ESOCKTNOSUPPORT;
>      release_sock(sk);
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>                                                                   virtio_transport_recv_connected()
>                                                                     virtio_transport_reset()
>                                                                       virtio_transport_send_pkt_info()
>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>                                                                           queue_work(vsock_loopback_work)
>  listen(B)
>    vsock_listen()
>      if (sock->state != SS_UNCONNECTED)    // [2]
>      sk->sk_state = TCP_LISTEN;    // [3]
>
>                                                               vsock_loopback_work()
>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>								   if ((sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {    // [4]
>								   ...
>							
>  virtio_transport_close_timeout()
>    virtio_transport_do_close()
>      vsock_stream_has_data()
>        return vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>
>```
>(Yes, This is quite a crazy scenario, but it can actually be induced)
>
>Since sock->state is set to SS_UNCONNECTED during the first connect()[1],
>it can pass the sock->state check[2] in vsock_listen() and set
>sk->sk_state to TCP_LISTEN[3].
>If this happens, the check in the patch with
>`sk->sk_state != TCP_LISTEN` will pass[4], and a null-ptr-deref can
>still occur.)
>
>More specifically, because the sk_state has changed to TCP_LISTEN,
>virtio_transport_recv_disconnecting() will not be called by the
>loopback worker. However, a null-ptr-deref may occur in
>virtio_transport_close_timeout(), which is scheduled by
>virtio_transport_close() called in the flow of the second connect()[5].
>(The patch no longer cancels the virtio_transport_close_timeout() worker)
>
>And even if the `sk->sk_state != TCP_LISTEN` check is removed from the
>patch, it seems that a null-ptr-deref will still occur due to
>virtio_transport_close_timeout().
>It might be necessary to add worker cancellation at the
>appropriate location.

Thanks for the analysis!

Do you have time to cook a proper patch to cover this scenario?
Or we should mix this fix together with your patch (return 0 in 
vsock_stream_has_data()) while we investigate a better handling?

Thanks,
Stefano


