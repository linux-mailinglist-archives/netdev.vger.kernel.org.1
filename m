Return-Path: <netdev+bounces-188306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F91AAC07A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBBF4E1061
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33721272E5C;
	Tue,  6 May 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwiq0lH0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64650270EB9
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525245; cv=none; b=t1yJT/OP9cJTDTtP0+xef3LnmVhn+wUxcO4gfG/TV3uqSa8wLuRqOOxXqhtLxtXNUIP4Lk0gk4ux2MiYLdMpXxhsggskq+8AF5CJHl2HSmQzL70UujvnXgOgAv5dcZZ1H1QrI05yFUBVZmVdoxVLIvnPe3o4q7tHN68xa8OlSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525245; c=relaxed/simple;
	bh=WZ64pm8mCn6WauOvEK5LHUkaP/YAEqtWPN8ZVB3/f58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOE/L430c/yrhllRw8yHAvbU9hUjHBCHAN6QWdgaRKsnSAWfAmJMU0zlxl7ob4vhtcSJ4ec1kZoax2ZW4iyjlQtumHIgektqrlQz5QNedGR3gd5nl0ECg1HpbG9MpRnPuEmgFR1qsnxDKO6jOJNokAV3snTKOXF+GDuZg7NEbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwiq0lH0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746525242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6B1xjoScf7bsPJTh7xEGagDYN0nDoGDFYe9DHlpFOg=;
	b=Mwiq0lH0P4jffVY+V/d3llJPsV8wIedPkaMJTpKOGI2DHmTpHGW/2xMFJKJ7Zm9AMThwSA
	TEaZEwEsYVes1jkx1BPSbMxfJIlZbJdHEGKqPBSuBO3lErmX+UtpzKlXhaOTmIps7fk08/
	aW8kENlmHIQVjjL/Qtrn8lBJNYIECdU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-QxZOk4NfPY6lpf9eZiKdyg-1; Tue, 06 May 2025 05:54:01 -0400
X-MC-Unique: QxZOk4NfPY6lpf9eZiKdyg-1
X-Mimecast-MFC-AGG-ID: QxZOk4NfPY6lpf9eZiKdyg_1746525240
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac6caf952d7so578316366b.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 02:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746525240; x=1747130040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6B1xjoScf7bsPJTh7xEGagDYN0nDoGDFYe9DHlpFOg=;
        b=qnkuv0nlcHrEowKkOPlGCaGCDGoKN4HjUr34Gb1u6L7870wboWAD4orwlEy8JwH2Tw
         6X/oXF3jRYhv00zy34YBBZcI0cAtLfliYnkr/KnYtwjPXifJcDLggfEyZm2cPbwv6UkE
         S8ru0L8aC5WLH5QwQxq9ZiGtCUDbsGv00Hyu81gPJnSiVkR07gKPyOzhs+nqZjFIOBW/
         zNfgxT2Tomz+zBxoRVOATvmJI5KwdGCMQxybRts9EyuzD4jxlIof6NODfbPlI7T3Nw0M
         5+Cz134mM43V9I7+9nuZrnnR4U7BjNoe8kTTGtvkSHf5cjx5ySDMr1CTwcH1mWHTmM/l
         xuYg==
X-Forwarded-Encrypted: i=1; AJvYcCVOORzQtA8UhO3Z5r5Ue9qA/AkCDjdS2oSqnAhiW/6koP9qu+TeySB6xKfNvmHQgZQTkXnGRiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1n3/EcqyOoz73N9FDfB9Bztz4k75MluWc3XzwSv/+Fu7N3iyp
	zkQKmbDZZLYex85PsGoWTQUmsr+CjAYM4WwPqo5Ix7MJ4GEGEaKJmPD7QhELqTJe0b3ZnnEBVYD
	hzQpEkR640nG4vGrluqeDK5JCR18PBaydqP47BtscwHsnBmtVvRyMjQ==
X-Gm-Gg: ASbGncs5nrFhcqRCzlgL6ZgmWfPwZ92UeVpcAmbAPvvlv0oiOQvIk2NwLtSkQFzMaXq
	42s/fouKIgKiwbl/Kl2NG8BZFgls08eU76+JSUxq54Qt7+w6fKVUMgJpnDEEGiVs5jzKCLWk5rt
	sQo67p0B+HOU3TB1G3vZoQvA5O8tJETHud30VfUsEic8s6GXdYMI1Ep7Rf1wHeE9oWmqn6NBzwY
	4y/t//UQyrleQUKbL03vy04ygb2EejhVGQD+kQ3y8C6sjiK5iq+RVsFmV5A7uq6gO2TmN9VEt8z
	DfVot36RzB7Zns/pUw==
X-Received: by 2002:a17:907:8d87:b0:aca:de15:f2ad with SMTP id a640c23a62f3a-ad1d46ddad0mr219300066b.60.1746525239843;
        Tue, 06 May 2025 02:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/1oV0zciKaW3O1wacg9c1zps+3AHOJS/RUO5rgbV5p2b2yw5R1zfs8RHPWnIxlOh3Hh5OJQ==
X-Received: by 2002:a17:907:8d87:b0:aca:de15:f2ad with SMTP id a640c23a62f3a-ad1d46ddad0mr219295266b.60.1746525239247;
        Tue, 06 May 2025 02:53:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77b8fe52sm7425752a12.55.2025.05.06.02.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:53:58 -0700 (PDT)
Date: Tue, 6 May 2025 11:53:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] vsock: Move lingering logic to af_vsock
 core
Message-ID: <hcme242wm3h33zvbo6g6xinhbsjkeaawhsjjutxrhkjoh6xhin@gm5yvzv4ao7k>
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-2-beabbd8a0847@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250501-vsock-linger-v4-2-beabbd8a0847@rbox.co>

On Thu, May 01, 2025 at 10:05:23AM +0200, Michal Luczaj wrote:
>Lingering should be transport-independent in the long run. In preparation
>for supporting other transports, as well the linger on shutdown(), move
>code to core.
>
>Generalize by querying vsock_transport::unsent_bytes(), guard against the
>callback being unimplemented. Do not pass sk_lingertime explicitly. Pull
>SOCK_LINGER check into vsock_linger().
>
>Flatten the function. Remove the nested block by inverting the condition:
>return early on !timeout.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 30 ++++++++++++++++++++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 23 ++---------------------
> 3 files changed, 33 insertions(+), 21 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 9e85424c834353d016a527070dd62e15ff3bfce1..d56e6e135158939087d060dfcf65d3fdaea53bf3 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
> 				     void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock 
> *psk);
> bool vsock_find_cid(unsigned int cid);
>+void vsock_linger(struct sock *sk);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..a31ad6b141cd38d1806df4b5d417924bb8607e32 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,36 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk)
>+{
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	long timeout;
>+
>+	if (!sock_flag(sk, SOCK_LINGER))
>+		return;
>+
>+	timeout = sk->sk_lingertime;
>+	if (!timeout)
>+		return;
>+
>+	/* unsent_bytes() may be unimplemented. */

This comment IMO should be enriched, as it is now it doesn't add much to 
the code. I'm thinking on something like this:
     Transports must implement `unsent_bytes` if they want to support
     SOCK_LINGER through `vsock_linger()` since we use it to check when
     the socket can be closed.

The rest LGTM!

Thanks,
Stefano

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
>index 
>045ac53f69735e1979162aea8c9ab5961407640c..aa308f285bf1bcf4c689407033de854c6f85a639 
>100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,25 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	if (timeout) {
>-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-		struct vsock_sock *vsk = vsock_sk(sk);
>-
>-		add_wait_queue(sk_sleep(sk), &wait);
>-
>-		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  virtio_transport_unsent_bytes(vsk) == 0,
>-					  &wait))
>-				break;
>-		} while (!signal_pending(current) && timeout);
>-
>-		remove_wait_queue(sk_sleep(sk), &wait);
>-	}
>-}
>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1280,8 +1261,8 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 	if ((sk->sk_shutdown & SHUTDOWN_MASK) != SHUTDOWN_MASK)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
>-	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+	if (!(current->flags & PF_EXITING))
>+		vsock_linger(sk);
>
> 	if (sock_flag(sk, SOCK_DONE)) {
> 		return true;
>
>-- 
>2.49.0
>


