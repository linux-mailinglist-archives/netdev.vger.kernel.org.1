Return-Path: <netdev+bounces-187087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1AEAA4DE1
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363B81B66CFC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04925D90F;
	Wed, 30 Apr 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gl2v0wFe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A120DD52
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021047; cv=none; b=eP3+F4wdI3BZ6hZ3RYvH+ApG0OH4HiH6GKGxV5qTiOWu/64ECAgJ4/Xil9pReI6f7nXqJahJezSAF8Js72B0dGL8wyYvfVaTStvfAi3ufzFVA0LycLnOzFiZyWGqI+zMCSHxP2fW2K6lnnz/gg+wcK8QtaRwPQPY7PhsWNgffRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021047; c=relaxed/simple;
	bh=XkIQo7LPf5Ok9RWGc7zcJBFMi0NL+uFcvQctnQlXXsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8fcqQB8WWP4qHfl4UpTVvgtKz0WNCCNuGoFcnySlVCRnUfn//8VW33pWYdzoe1Yf/T0ssjMmDjihmtebmQKEqI6nBxZlumWaBDq/qSZoTxvrkAmDFQ0XJTT8j75kvqf5DzqcR4GMZuuLc1EAi63fbn0ffLxQ1lZAgbmiNwxFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gl2v0wFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746021044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtvDQU7c0DbWPgBlbfWVJ21g70tkL57uEZ0WOXCqKjE=;
	b=Gl2v0wFemrgjL10u4IGP79x5N5gf+Wflg8XkupA1C6trbconM3fJEvX/ne4ZYfyO9gRRHe
	9cTx+S+9WKp8ryc/ZFyw9lLRurMrXqhU22mu8fjEkAuSqe2NlJ0SxqsguUa3IeUfYQr0o5
	YqFcH0I43R93R4iRJUCbsA3cMkkWv9U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-tZQ19hp6NzywnGIBO6V-ag-1; Wed, 30 Apr 2025 09:50:43 -0400
X-MC-Unique: tZQ19hp6NzywnGIBO6V-ag-1
X-Mimecast-MFC-AGG-ID: tZQ19hp6NzywnGIBO6V-ag_1746021042
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb94dbd01fso594027466b.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 06:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746021042; x=1746625842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtvDQU7c0DbWPgBlbfWVJ21g70tkL57uEZ0WOXCqKjE=;
        b=pC72FakXgoOyTVf2XHHfJd/E7DDtYuOF5c8EQYERz1tYeMsFIBnT6cZe5SFvqmibKQ
         V2zq5OqKoJLucXPZKikM54+jE3yvqtL6pRs91S+JAqfsHmr1CrIS2Ilw54PUV7VXkume
         U1Zk7VtNvtC+XJDooSC0ZxsmBp1p/rAncKuwa38PI7gMKHyPWtDjgjb+GpOPjPKoTn2O
         acPsPjqev3Bi3ZySKtmKXs/z2SiGIiJood4VLMXlVawnCi8o3eKVh5vOfV5L0bqZTbEk
         N0f5J0yTLxFeFRio7HnHCndiopr1oDCij/Gj7NegVBaOeUgm+slO3vBqF0dGpajPMuZM
         PMZw==
X-Forwarded-Encrypted: i=1; AJvYcCV5fh3k+kBWXWRmPfXQRvGVUyBpLQIns1jFWaomZvNlbZbxhsZCs9HCmGxd5JrNZEk9rpqKWpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNP9sSQeFO3yqa3h788sm5DOiBqieTJkdE1DHDz39mQWHulviD
	+7bn0w1Kv0WbW4LOt4Z8F9DfxKXCkt8zLJsAWU+OTMT++7ksrNWZqn6SIj1s0uWSDDbzpvJwQdK
	9B5EKm+Wbq8no0vBPlRsCeChJgHa8DpD9ivxyx7q2RnxB6L5cj7J7Sw==
X-Gm-Gg: ASbGncvC8Mk9zkAviTqY0TH77UEcVMq47mN63BXwRElNyuDvI9Ve7dM3n5ZUgKBtwA4
	2r8omx+Dbp6R4rP26wrKAVKAavKf2iw2EXSieUTUlCqwtUGnBvk6NaFJswZEHGJmUAkB+N3/cmB
	zU0KDsRtfDFmlTMocpaDBc9Hf/SCsIoul/lsPUEUEdq8wqQnuC+NJ1f8jZMhpcsuK3QTewDaNkc
	9d2fT9dI9o19c71Hc03mhN7SyrPn+361ZKVTdJMeRARoXjpAzwAwNAnWFCedR8gL551fPCSZM4J
	Zus2Ez49da1OYc3DnA==
X-Received: by 2002:a17:907:9408:b0:acb:baff:fd5f with SMTP id a640c23a62f3a-acee21e5fdamr268767266b.35.1746021042154;
        Wed, 30 Apr 2025 06:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmc4F5C0ScUDooY60QYw9aKFDqWQU9lPIHKeft/Gghe0ofd5YKvvbBWiYfVKu3t+CO5GkTQ==
X-Received: by 2002:a17:907:9408:b0:acb:baff:fd5f with SMTP id a640c23a62f3a-acee21e5fdamr268763966b.35.1746021041545;
        Wed, 30 Apr 2025 06:50:41 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec5d0d74esm277482766b.117.2025.04.30.06.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:50:40 -0700 (PDT)
Date: Wed, 30 Apr 2025 15:50:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] vsock: Move lingering logic to af_vsock
 core
Message-ID: <t4ltq5zni4x7ahcntnhjeyzaj5hxciqzto3t6ubjfn2klb5ici@zhhlqjw33lie>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
 <oo5tmbu7okyqojwxt4xked4jvq6jqydrddowspz3p66nsjzajt@36mxuduci4am>
 <fa71ef5e-7603-4241-bfd3-7aa7b5ea8945@rbox.co>
 <CAGxU2F62CTUKVjuG9Fjo29E6uopVzOK8zgr+HwooqMr4V_RvLQ@mail.gmail.com>
 <f1943412-ccbf-4913-a5c5-818f0f586db1@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f1943412-ccbf-4913-a5c5-818f0f586db1@rbox.co>

On Wed, Apr 30, 2025 at 01:11:48PM +0200, Michal Luczaj wrote:
>On 4/30/25 12:37, Stefano Garzarella wrote:
>> On Wed, 30 Apr 2025 at 12:33, Michal Luczaj <mhal@rbox.co> wrote:
>>>
>>> On 4/30/25 11:36, Stefano Garzarella wrote:
>>>> On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
>>>>> Lingering should be transport-independent in the long run. In preparation
>>>>> for supporting other transports, as well the linger on shutdown(), move
>>>>> code to core.
>>>>>
>>>>> Guard against an unimplemented vsock_transport::unsent_bytes() callback.
>>>>>
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>> ---
>>>>> include/net/af_vsock.h                  |  1 +
>>>>> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
>>>>> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
>>>>> 3 files changed, 27 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>>>>> index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
>>>>> --- a/include/net/af_vsock.h
>>>>> +++ b/include/net/af_vsock.h
>>>>> @@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
>>>>>                                   void (*fn)(struct sock *sk));
>>>>> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
>>>>> bool vsock_find_cid(unsigned int cid);
>>>>> +void vsock_linger(struct sock *sk, long timeout);
>>>>>
>>>>> /**** TAP ****/
>>>>>
>>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>>> index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
>>>>> --- a/net/vmw_vsock/af_vsock.c
>>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>>> @@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
>>>>>      return err;
>>>>> }
>>>>>
>>>>> +void vsock_linger(struct sock *sk, long timeout)
>>>>> +{
>>>>> +    DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>>>> +    ssize_t (*unsent)(struct vsock_sock *vsk);
>>>>> +    struct vsock_sock *vsk = vsock_sk(sk);
>>>>> +
>>>>> +    if (!timeout)
>>>>> +            return;
>>>>> +
>>>>> +    /* unsent_bytes() may be unimplemented. */
>>>>> +    unsent = vsk->transport->unsent_bytes;
>>>>> +    if (!unsent)
>>>>> +            return;
>>>>> +
>>>>> +    add_wait_queue(sk_sleep(sk), &wait);
>>>>> +
>>>>> +    do {
>>>>> +            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>>>>> +                    break;
>>>>> +    } while (!signal_pending(current) && timeout);
>>>>> +
>>>>> +    remove_wait_queue(sk_sleep(sk), &wait);
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(vsock_linger);
>>>>> +
>>>>> static int vsock_shutdown(struct socket *sock, int mode)
>>>>> {
>>>>>      int err;
>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>> index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>> @@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
>>>>>      vsock_remove_sock(vsk);
>>>>> }
>>>>>
>>>>> -static void virtio_transport_wait_close(struct sock *sk, long timeout)
>>>>> -{
>>>>> -    DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>>>> -    ssize_t (*unsent)(struct vsock_sock *vsk);
>>>>> -    struct vsock_sock *vsk = vsock_sk(sk);
>>>>> -
>>>>> -    if (!timeout)
>>>>> -            return;
>>>>> -
>>>>> -    unsent = vsk->transport->unsent_bytes;
>>>>> -
>>>>> -    add_wait_queue(sk_sleep(sk), &wait);
>>>>> -
>>>>> -    do {
>>>>> -            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>>>>> -                    break;
>>>>> -    } while (!signal_pending(current) && timeout);
>>>>> -
>>>>> -    remove_wait_queue(sk_sleep(sk), &wait);
>>>>> -}
>>>>> -
>>>>> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>>>>>                                             bool cancel_timeout)
>>>>> {
>>>>> @@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
>>>>>              (void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>>>>>
>>>>>      if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>>>>> -            virtio_transport_wait_close(sk, sk->sk_lingertime);
>>>>> +            vsock_linger(sk, sk->sk_lingertime);
>>>>
>>>> Ah, I'd also move the check in that function, I mean:
>>>>
>>>> void vsock_linger(struct sock *sk) {
>>>>       ...
>>>>       if (!sock_flag(sk, SOCK_LINGER) || (current->flags & PF_EXITING))
>>>>               return;
>>>>
>>>>       ...
>>>> }
>>>
>>> One note: if we ever use vsock_linger() in vsock_shutdown(), the PF_EXITING
>>> condition would be unnecessary checked for that caller, right?
>>
>> Right, for shutdown it should always be false, so maybe better to keep
>> the check in the caller.
>
>Or split it? Check `!sock_flag(sk, SOCK_LINGER) || !timeout` in
>vsock_linger() and defer `!(flags & PF_EXITING)` to whoever does the socket
>release?
>

Yep, this is also fine with me!

Stefano


