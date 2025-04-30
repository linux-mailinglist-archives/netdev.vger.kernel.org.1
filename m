Return-Path: <netdev+bounces-187036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82BAA48F2
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AAC981B1D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAB25B1E2;
	Wed, 30 Apr 2025 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nw2aDXQP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C3230BE2
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009375; cv=none; b=En1etzivuat0pUp/RVL320MB1WPBKKIUzZTRMdDzPJL2qb94GO7eVBvaaRtAbqUJzVMsrd826Nm716oBieeurmOj9cCFnuEbyEf/s1qQAvvnFgrcOu0vCrcSImERCSfzO5OWGmCdzaBlnKr2eb1R/lhTXwIatpJgn5dlnvkz0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009375; c=relaxed/simple;
	bh=mhr10cYfBfC4zr3WVDjrKQCUfiTgNn/5cxCG1MJj3Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keeUObjuIxWkNZKN2mClelFyubboySrko8kD7JXaL9Ii2gjmxyf1ASGX67fJl8ImqRyG6zA9jMW+XMAgfrof9/GtgaBZ0OO188UaiPdA1HRb4LBNQinXGabW/3apOJtZehFYgCdsxV6UA1YxC5rR/EGsDgoazzwrot7fQUcIFwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nw2aDXQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746009372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofEnQUAiXxunrVfb3X1JnXlrqr5QDc+0a3iYkP1Wxqg=;
	b=Nw2aDXQPvrdVvxgHHOz54MIvxgQZlR0cTjnbWVC6gXpgNIhs+hI53dhQO12i1e8XpSWamt
	7aDnWxKwtAc5Li0LTXDP9o1Dz5gY5moiFWtIQ/pyxoLCq1US+LPVX11+Fd7hNOdV4kNJX4
	LhiulHxjd8Tw5RzkcMhv1ojzA4caxLI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-O_56LuH5NWWSBRhXDz6c4Q-1; Wed, 30 Apr 2025 06:36:11 -0400
X-MC-Unique: O_56LuH5NWWSBRhXDz6c4Q-1
X-Mimecast-MFC-AGG-ID: O_56LuH5NWWSBRhXDz6c4Q_1746009370
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e73ff0469cbso1153838276.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 03:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009370; x=1746614170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofEnQUAiXxunrVfb3X1JnXlrqr5QDc+0a3iYkP1Wxqg=;
        b=Ylw+XBhLZgGS1PftMHWEYnpsJkPDpaKru+5h7pxkUdTGtOqTLsC3+7Hf/cSD2iyPww
         bJS9DDmAMo2xvuSajC92tXsCjZRtZ4lKaQvGdN06UakyrbUNpvIXhxIU1LMUMCk96flK
         w9xhl34DrrF37kKFLTA8VTf7109T1QibsUkJ/oRmaUh7IVqJDDetmOiIRcbp+L5drzZK
         yqT5JNAi1rZtdUmakfX9iPHLgmJLWQPkp5uaQ1yAQBfUbWa8GqszEvTPQZyBVtTpTPvw
         pt3VFqPnlfQIR8mgiezZjnUqHkqOGuidln74NkgQkYxPKXPtUVNAkFkpRmFoVR3X5hZj
         dCwg==
X-Forwarded-Encrypted: i=1; AJvYcCXThSG5qtBbCnhsS0R3a1OtUSsNJ1lI7a6cOJFCvJP9D9/nQyJVcAWmXiIZCYTyVYCuOCObd3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoombfI23JSiDvyzaHg4ovezZy57wXdXN47ZU7F36isLpt89HA
	EqgWyV0OOeTJ2x8gXQGy3QtbwOf6rZvZbO3lmZrvvxiJtB8WbSS9kY+HHUpphLPiFtLvpc5a2IL
	69v/aCN2E8oG8+mJfqbftYKZ8nvkwDXdigd49w/aJ/5IsUXSJKdB8bMBmaIvm7MziAWJqt3ycj3
	+rnbwsLckfYYNzJGibnJGb8/5Mr5ON
X-Gm-Gg: ASbGncsiU+143o8EdrduC0CW622NE9QsklBzimNhyWlNtPIn9X5ubmsIfcNJ6Ic9bt6
	2yYrZHaKN5lBUqKwJMlCRh1/4J8ux/E2uORGMyrgywKNkPqV9wLCVNmawO0Qn1eIPaVaBoPA=
X-Received: by 2002:a05:6902:200b:b0:e72:8094:7ef2 with SMTP id 3f1490d57ef6-e7403b434b8mr2679074276.5.1746009370638;
        Wed, 30 Apr 2025 03:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd6mFph/jL7kLcuyN4SBa/2KU+rAGfiImT7cec/RSo77iKESmm4t45Oot64cbpBSJwO29YwZRGDmgsMtUfxOE=
X-Received: by 2002:a05:6902:200b:b0:e72:8094:7ef2 with SMTP id
 3f1490d57ef6-e7403b434b8mr2679053276.5.1746009370232; Wed, 30 Apr 2025
 03:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co> <kz3s5mu7bc5kqb22g6voacrinda3wszwhlda7nnwhm5bciweuc@dpsyq2yfrs7f>
 <cc2d5c7c-a031-402d-b2d7-fe57fa0bf321@rbox.co>
In-Reply-To: <cc2d5c7c-a031-402d-b2d7-fe57fa0bf321@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 30 Apr 2025 12:35:59 +0200
X-Gm-Features: ATxdqUHqbCSxT_egwqwRscXnk2hQ8Isa4NXFhfUyLX35mZgR_JT8VJB4qZt0zWI
Message-ID: <CAGxU2F6Z0Um6GkvsAzH4tBzhQNvZpU3zAJAQ7jPyNp2c-LVo4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] vsock: Move lingering logic to af_vsock core
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Apr 2025 at 12:30, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 4/30/25 11:33, Stefano Garzarella wrote:
> > On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
> >> Lingering should be transport-independent in the long run. In preparation
> >> for supporting other transports, as well the linger on shutdown(), move
> >> code to core.
> >>
> >> Guard against an unimplemented vsock_transport::unsent_bytes() callback.
> >>
> >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> include/net/af_vsock.h                  |  1 +
> >> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
> >> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
> >> 3 files changed, 27 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >> index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
> >> --- a/include/net/af_vsock.h
> >> +++ b/include/net/af_vsock.h
> >> @@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> >>                                   void (*fn)(struct sock *sk));
> >> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> >> bool vsock_find_cid(unsigned int cid);
> >> +void vsock_linger(struct sock *sk, long timeout);
> >>
> >> /**** TAP ****/
> >>
> >> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
> >> --- a/net/vmw_vsock/af_vsock.c
> >> +++ b/net/vmw_vsock/af_vsock.c
> >> @@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
> >>      return err;
> >> }
> >>
> >> +void vsock_linger(struct sock *sk, long timeout)
> >> +{
> >> +    DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >> +    ssize_t (*unsent)(struct vsock_sock *vsk);
> >> +    struct vsock_sock *vsk = vsock_sk(sk);
> >> +
> >> +    if (!timeout)
> >> +            return;
> >> +
> >> +    /* unsent_bytes() may be unimplemented. */
> >> +    unsent = vsk->transport->unsent_bytes;
> >> +    if (!unsent)
> >> +            return;
> >> +
> >> +    add_wait_queue(sk_sleep(sk), &wait);
> >> +
> >> +    do {
> >> +            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
> >> +                    break;
> >> +    } while (!signal_pending(current) && timeout);
> >> +
> >> +    remove_wait_queue(sk_sleep(sk), &wait);
> >> +}
> >> +EXPORT_SYMBOL_GPL(vsock_linger);
> >> +
> >> static int vsock_shutdown(struct socket *sock, int mode)
> >> {
> >>      int err;
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >> index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> >>      vsock_remove_sock(vsk);
> >> }
> >>
> >> -static void virtio_transport_wait_close(struct sock *sk, long timeout)
> >> -{
> >> -    DEFINE_WAIT_FUNC(wait, woken_wake_function);
> >> -    ssize_t (*unsent)(struct vsock_sock *vsk);
> >> -    struct vsock_sock *vsk = vsock_sk(sk);
> >> -
> >> -    if (!timeout)
> >> -            return;
> >> -
> >> -    unsent = vsk->transport->unsent_bytes;
> >> -
> >> -    add_wait_queue(sk_sleep(sk), &wait);
> >> -
> >> -    do {
> >> -            if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
> >> -                    break;
> >> -    } while (!signal_pending(current) && timeout);
> >> -
> >> -    remove_wait_queue(sk_sleep(sk), &wait);
> >> -}
> >> -
> >> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> >>                                             bool cancel_timeout)
> >> {
> >> @@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> >>              (void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
> >>
> >>      if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
> >> -            virtio_transport_wait_close(sk, sk->sk_lingertime);
> >> +            vsock_linger(sk, sk->sk_lingertime);
> >
> > What about removing the `sk->sk_lingertime` parameter here?
> > vsock_linger() can get it from sk.
>
> Certainly. I assume this does not need a separate patch and can be done
> while moving (and de-indenting) the code?

Yep, single patch to implement vsock_linger() in af_vsock.c is fine.

Stefano


