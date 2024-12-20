Return-Path: <netdev+bounces-153653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E67F9F90A4
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73B316CB0D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871E0172BD5;
	Fri, 20 Dec 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJqmLiDz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9718C31
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691783; cv=none; b=rB+DTSMlAiPLnsZZz4QG4e3u3P01nxKhKJVQbNsP0YtD+KoZrn7xummJIyZHVUtDKPKwo/5NDimmtIGRTOPrS8e5mxHmONt9APuTSTaTiKtMtYjeaoksadnQfbY9mULTmgefBHJVpEKaOjEhAqynN1UfsZ/6iPmVzUib/LD09sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691783; c=relaxed/simple;
	bh=fpcL8/eXhdzv8XX4qG8CIg06qhF8l6Jl3e2nleA6Qtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPSAvSfLUVdwsbLEQbhQduzuExp47dZSn4yOAxp4ZmmPRK7avOJPsl7yS1jWqQ+qdCelBuLx341AquHJyP8cxGHyXmjrP+JecTAfWy/WYoRTcJgc8NshxecWZcpriKnD7GWHpteeIhGBxezJVDgHBTEPJlsI4JphGRBM1IWPb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJqmLiDz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734691780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79PeQb+yDjXpAI7pY4e/4qGE53ll5/LkYg4JvYVptU4=;
	b=WJqmLiDzbXXBZCdjcStnysia9BBB24wLRdLBV6S+cz1z5BWhXRmaG8qQZFP0Q9NFkvj7zM
	YEo5vj5/GTm6OJBZ6I0EqaY7lWu3dpLRztmUg3YFhM0rra43KJOaSIA88ykaWLQiIvgxL9
	peBydwD8xK62Sb8Qk1Gm8LryRu8zTzg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-c861_76QMPa9VBSTtCoyIw-1; Fri, 20 Dec 2024 05:49:39 -0500
X-MC-Unique: c861_76QMPa9VBSTtCoyIw-1
X-Mimecast-MFC-AGG-ID: c861_76QMPa9VBSTtCoyIw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e49efd59so892513f8f.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734691778; x=1735296578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79PeQb+yDjXpAI7pY4e/4qGE53ll5/LkYg4JvYVptU4=;
        b=Ev/5EPI0vQWEUV/7XuFhoQSAY/VzIRfth6pW3teKmYQP7mdqr+fLIO7mSVKbODXJ9F
         JNOAzT1GCnK6YPJWnwZLkkEONNF0QTe+cH9E1yyZ99RxG6iDLXnPr3/vvN7yGBLJTZ/b
         3w6zWmBc5J574ejeojZOkSEJt6+CXThHRNGAr5iOyx/OCj4k/re0My4GWYsVgGmqq0Il
         LS4FjTfbGnRIKYWTIrAa539cxJHntHH7/D5ghtmLm2k4hyrnSR46tXjlDdEIRiBecAXF
         44Imfm3bafOwMHxzIdO73CACVZmMuD720actI/x9uXHHlr93DgAf92h5O/G19EmpugYT
         o2hA==
X-Forwarded-Encrypted: i=1; AJvYcCW1K4fC1VjgpJbRL1TLrRhWf4rvdcFdqxOkSToRo0k3kwdF/9deXM//Zu5FC39K666Ft8lhDL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoARelvg9I9FVaT4OmjQ7cY4VFvFWy+e7CF4f1q0RB6vuQyyZk
	S4dFRmnyju9rsOtDzhQ1qPjMOp2HwTypegVN1zJat7Ep7SghljHG9v98D0ZUskXb5KhZA+RkpwO
	v/SLKn9ISXjKRvxY/+1c/V59Ecjz6QoCX9Bg9ZNyudFE8YnzC7do56w==
X-Gm-Gg: ASbGncvfdUJSMKvjm0Q0t+Dmt9zGuhthVHNe9lq7TospKXtpRDt/7bcekdEurAAmEFn
	HyXZGBL4ktEl3X0phpHpnDCLDa2Tg2GjzpNBnvNXQ5ociZzDouNIlX5lgmEuw35vqz4u3OsPc98
	PFEf+P2ymYaOcNwboMd6XjaGxB1+ZYKIO6hLh8n0UiG0VLsO4GLwloOCNjpRUKt23oV+SmLzYyJ
	pWHJCwcnUJt+aXV/yAHDRLzvGgWjRBG7uX8lUIu3A8OV7vplbBkIfmg37mvxHAccYa6UTKcOeX8
	In/yWeqZAfLbFFezl6WCROkZmEdV3Zj7
X-Received: by 2002:a05:6000:4010:b0:382:51ae:7569 with SMTP id ffacd0b85a97d-38a221fae45mr2303073f8f.18.1734691778046;
        Fri, 20 Dec 2024 02:49:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+bB/Kw1tq4MLQwoUR3v3iXpALFjAVHwtoeLFOoROYE+dTEpj2Tnl57eNVBy7xhviP34E31g==
X-Received: by 2002:a05:6000:4010:b0:382:51ae:7569 with SMTP id ffacd0b85a97d-38a221fae45mr2303035f8f.18.1734691777331;
        Fri, 20 Dec 2024 02:49:37 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c25sm76195635e9.8.2024.12.20.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 02:49:36 -0800 (PST)
Date: Fri, 20 Dec 2024 11:49:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <jkhr2v5zjebxnckmhn3f3dvv5zdzbldkyxbe5kx5m7vzvw6kzi@nrqipygyhlix>
References: <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
 <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
 <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
 <cc04fe7a-aa49-47a7-8d54-7a0e7c5bfbdc@rbox.co>
 <CAGxU2F5K+0s9hnk=uuC_fE=otrH+iSe7OVi1gQbDjr7xt5wY9g@mail.gmail.com>
 <2906e706-bb0d-47c6-a4bb-9f3dc9ff7834@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2906e706-bb0d-47c6-a4bb-9f3dc9ff7834@rbox.co>

On Thu, Dec 19, 2024 at 05:09:42PM +0100, Michal Luczaj wrote:
>On 12/19/24 16:12, Stefano Garzarella wrote:
>> On Thu, 19 Dec 2024 at 16:05, Michal Luczaj <mhal@rbox.co> wrote:
>>>
>>> On 12/19/24 15:48, Stefano Garzarella wrote:
>>>> On Thu, 19 Dec 2024 at 15:36, Michal Luczaj <mhal@rbox.co> wrote:
>>>>>
>>>>> On 12/19/24 09:19, Stefano Garzarella wrote:
>>>>>> ...
>>>>>> I think the best thing though is to better understand how to handle
>>>>>> deassign, rather than checking everywhere that it's not null, also
>>>>>> because in some cases (like the one in virtio-vsock), it's also
>>>>>> important that the transport is the same.
>>>>>
>>>>> My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
>>>>> it impossible-by-design to switch ->transport from non-NULL to NULL in
>>>>> vsock_assign_transport().
>>>>
>>>> I don't know if that's enough, in this case the problem is that some
>>>> response packets are intended for a socket, where the transport has
>>>> changed. So whether it's null or assigned but different, it's still a
>>>> problem we have to handle.
>>>>
>>>> So making it impossible for the transport to be null, but allowing it
>>>> to be different (we can't prevent it from changing), doesn't solve the
>>>> problem for us, it only shifts it.
>>>
>>> Got it. I assumed this issue would be solved by `vsk->transport !=
>>> &t->transport` in the critical place(s).
>>>
>>> (Note that BPF doesn't care if transport has changed; BPF just expects to
>>> have _a_ transport.)
>>>
>>>>> If I'm not mistaken, that would require rewriting vsock_assign_transport()
>>>>> so that a new transport is assigned only once fully initialized, otherwise
>>>>> keep the old one (still unhurt and functional) and return error. Because
>>>>> failing connect() should not change anything under the hood, right?
>>>>>
>>>>
>>>> Nope, connect should be able to change the transport.
>>>>
>>>> Because a user can do an initial connect() that requires a specific
>>>> transport, this one fails maybe because there's no peer with that cid.
>>>> Then the user can redo the connect() to a different cid that requires
>>>> a different transport.
>>>
>>> But the initial connect() failing does not change anything under the hood
>>> (transport should/could stay NULL).
>>
>> Nope, isn't null, it's assigned to a transport, because for example it
>> has to send a packet to connect to the remote CID and wait back for a
>> response that for example says the CID doesn't exist.
>
>Ahh, I think I get it. So the initial connect() passed
>vsock_assign_transport() successfully and then failed deeper in
>vsock_connect(), right? That's fine. Let the socket have a useless
>transport (a valid pointer nevertheless). 

Just to be clear, it's not useless, since it's used to make the 
connection. We know that it's useless just when we report that the 
connection failed, so maybe we should de-assign it when we set 
`sock->state = SS_UNCONNECTED`.

>Sure, upcoming connect() can
>assign a new (possibly useless just as well) transport, but there's no
>reason to allow ->transport becoming NULL.

I'm not sure about this, in the end in the connection failure case, when 
we set `sock->state = SS_UNCONNECTED`, we're returning the socket to a 
pre-connect state, so it might make sense to also reset the transport to 
NULL, so that we have exactly the same conditions.

>
>And a pre-connect socket (where ->transport==NULL) is not an issue, because
>BPF won't let it in any sockmap, so vsock_bpf_recvmsg() won't be reachable.
>
>Anywa, thanks for explaining,
>Michal
>
>PS. Or ignore the above and remove the socket from the sockmap at every
>reconnect? Possible unhash abuse:

I should take a closer look at unhash, but it might make sense!

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5cf8109f672a..8a65153ee186 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -483,6 +483,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		if (vsk->transport == new_transport)
> 			return 0;
>
>+		const struct proto *prot = READ_ONCE(sk->sk_prot);
>+		if (prot->unhash)
>+			prot->unhash(sk);
>+
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
> 		 * have already held the sock lock. In the other cases, this
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 4aa6e74ec295..80deb4d70aea 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -119,6 +119,7 @@ static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *bas
> 	*prot        = *base;
> 	prot->close  = sock_map_close;
> 	prot->recvmsg = vsock_bpf_recvmsg;
>+	prot->unhash = sock_map_unhash;
> 	prot->sock_is_readable = sk_msg_is_readable;
> }
>
>>> Then a successful re-connect assigns
>>> the transport (NULL -> non-NULL). And it's all good because all I wanted to
>>> avoid (because of BPF) was non-NULL -> NULL. Anyway, that's my possibly
>>> shallow understanding :)
>

Note that non-NULL -> NULL should only occur before a connection is 
established, so before any data is passed. Is this a problem for BPF?

Thanks,
Stefano


