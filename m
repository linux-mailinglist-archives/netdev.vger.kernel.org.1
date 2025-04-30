Return-Path: <netdev+bounces-187007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC3AA475C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780541C04C1D
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08C235045;
	Wed, 30 Apr 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeeTB7Z6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA821A433
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005817; cv=none; b=uHxeyDoOBWjhPD3QmeWxZ1f+2nw8042c4MA9LS/l9cgQHH5HBCfaBWrmg2ci8KnFRD6whiLgBpi/YNV0WvrrJG6TGTY8VPB4j/OBOjhVn8OKCkSOgoviYhqXimNdN707qBF5CbQ4BJe6X0G3LxutzL+eJs/PXVX85ctuGYPshjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005817; c=relaxed/simple;
	bh=5Ocuw4e8b8MCvcgZG8tAmtt1ISXlU0QTVvz2XLE1ZV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z64InvZWMDiAqfGvj3laXTjlVs32EENPgjKuZ0lghmKs59ngC8/c9glN8eDhAfZZDokgZWRJ0hAaxHW5CpHkN/O0wFM038CGkhw5TuhhAlB4ofO7F23rZdKi8rboHYiH6Ik5Eul7OE2D7oFDiXbFcswltvZOVt1BdE6a9Uv8n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeeTB7Z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PklXpf2mtZZMeIyH7dbSdoSYGX/kozHo8SVimCxZe+I=;
	b=KeeTB7Z6/9MviPxJ8tRBCq53NUHyiBiM1JHQLCQTBNyCUy8Wn0vw9q0D+bL+uvMXkeohPz
	R5nhldRXpE2XrZPsQszIC7I9bGXqNkm/b6H9pYx5jF2d+El4GgjqB46llChJeftqQ62zdM
	XsfWAxjBmASMTSZqzMMjcpVEwTynF54=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-61ONQVz0N0GDD_uQswPnTg-1; Wed, 30 Apr 2025 05:36:49 -0400
X-MC-Unique: 61ONQVz0N0GDD_uQswPnTg-1
X-Mimecast-MFC-AGG-ID: 61ONQVz0N0GDD_uQswPnTg_1746005806
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5f437158fe3so5704397a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 02:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005806; x=1746610606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PklXpf2mtZZMeIyH7dbSdoSYGX/kozHo8SVimCxZe+I=;
        b=mpCuIXgsiSpcTGpSwP6kE/mqpGLkViNqWYv5Z0viBuMt8iYFxiCbmh+xWoykEq0w+l
         ZsxHBqC+Xvh7C1deTpZ4rnGAocykPBDRmcQ6+yI3wpZsLr2aODOPgHf1WJFTFosc0d0b
         Ows5Xx2Pe9tSjms5UsBU6gk/iZDr2SZNsxq7xpGmPQ1LVsWxshAJnwKRFovfzgPlew+B
         zutmGtLZKXsvum4QjHcHzKZkK7rcrb1tmpfgK30aF/6+SniBrEmhmxwu4XkV/OqueqX6
         6zoK9R7cCM11f69pH/JjBUw3y79Hem8Bo4XZnaeOpKGf7PWptO36meo5w4lFxo/2P5+f
         8y1g==
X-Forwarded-Encrypted: i=1; AJvYcCUb1LH7hTcdVpjPDkFrYFOoi8yj8niMtjNih7ro+JeGvJ+L5tFqRj1HYJcytU96l2k3e+9t39k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3bYp9rlRFT6VfYBRVqY6cjMLdnARFAUFlAlmEZ+c8P763BKU
	XFFqG/IG+uIk5Ub3pA76qnLSF3MQmzEpn7tsIiOhaG0VRqR5/iFmG1ddZpgfvtd4X3qoRcXg6Ox
	tlV6q+uZRlgpl+aDdG3RKjBbZZt05ExQYSj5G/jnaBLXuROvVIxMkMg==
X-Gm-Gg: ASbGncuM13z9+lxlY1jsDxIpl4p8gAPvTlyS7kOrO/UO/4WR11TUznzGay4zEttfOty
	MSNvEP3r2fqB/CvQUtSbVBieFT08qI4M/A8Gecouyp2nlnIXkQIE3sceriKwHFhmnntGtCTn1dK
	cCL407Bty03pPvatEMbBz5cAAEf3/vSRcpbHsH4Vsebay1bUxVjomMEdse+ZzmWbMnhGyuQt0a8
	T8ZP2Fs5WNNtJy6thpKDZbXMzOG3VpfgY7epQEexOvp9h72H60iA7dQVhIdlxWVFDXdI3oYasPO
	lTwHkEeCFhiA4KZJLg==
X-Received: by 2002:a05:6402:2709:b0:5f0:48df:25ae with SMTP id 4fb4d7f45d1cf-5f89ab673f7mr1878516a12.2.1746005806254;
        Wed, 30 Apr 2025 02:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHof0+CLIrQBgrHPd0uIgVEPaVcOjpvBaOfPCPKfVxm8p9SM0QtTIrzlcOdGN1NnRYvxDRhEg==
X-Received: by 2002:a05:6402:2709:b0:5f0:48df:25ae with SMTP id 4fb4d7f45d1cf-5f89ab673f7mr1878477a12.2.1746005805553;
        Wed, 30 Apr 2025 02:36:45 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013fef5esm8463493a12.18.2025.04.30.02.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:36:44 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:36:30 +0200
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
Message-ID: <oo5tmbu7okyqojwxt4xked4jvq6jqydrddowspz3p66nsjzajt@36mxuduci4am>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250430-vsock-linger-v3-3-ddbe73b53457@rbox.co>

On Wed, Apr 30, 2025 at 11:10:29AM +0200, Michal Luczaj wrote:
>Lingering should be transport-independent in the long run. In preparation
>for supporting other transports, as well the linger on shutdown(), move
>code to core.
>
>Guard against an unimplemented vsock_transport::unsent_bytes() callback.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 23 +----------------------
> 3 files changed, 27 insertions(+), 22 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9e85424c834353d016a527070dd62e15ff3bfce1..bd8b88d70423051dd05fc445fe37971af631ba03 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+void vsock_linger(struct sock *sk, long timeout);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..946b37de679a0e68b84cd982a3af2a959c60ee57 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,31 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk, long timeout)
>+{
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+
>+	if (!timeout)
>+		return;
>+
>+	/* unsent_bytes() may be unimplemented. */
>+	unsent = vsk->transport->unsent_bytes;
>+	if (!unsent)
>+		return;
>+
>+	add_wait_queue(sk_sleep(sk), &wait);
>+
>+	do {
>+		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+			break;
>+	} while (!signal_pending(current) && timeout);
>+
>+	remove_wait_queue(sk_sleep(sk), &wait);
>+}
>+EXPORT_SYMBOL_GPL(vsock_linger);
>+
> static int vsock_shutdown(struct socket *sock, int mode)
> {
> 	int err;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4425802c5d718f65aaea425ea35886ad64e2fe6e..9230b8358ef2ac1f6e72a5961bae39f9093c8884 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,27 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-	ssize_t (*unsent)(struct vsock_sock *vsk);
>-	struct vsock_sock *vsk = vsock_sk(sk);
>-
>-	if (!timeout)
>-		return;
>-
>-	unsent = vsk->transport->unsent_bytes;
>-
>-	add_wait_queue(sk_sleep(sk), &wait);
>-
>-	do {
>-		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>-			break;
>-	} while (!signal_pending(current) && timeout);
>-
>-	remove_wait_queue(sk_sleep(sk), &wait);
>-}
>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1283,7 +1262,7 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
> 	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+		vsock_linger(sk, sk->sk_lingertime);

Ah, I'd also move the check in that function, I mean:

void vsock_linger(struct sock *sk) {
	...
	if (!sock_flag(sk, SOCK_LINGER) || (current->flags & PF_EXITING))
		return;

	...
}

Or, if we move the call to vsock_linger() in __vsock_release(), we can
do the check there.

Thanks,
Stefano

>
> 	if (sock_flag(sk, SOCK_DONE)) {
> 		return true;
>
>-- 
>2.49.0
>
>


