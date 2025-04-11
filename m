Return-Path: <netdev+bounces-181648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D3A85F79
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397AB1895354
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5771E0E13;
	Fri, 11 Apr 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgOuO29A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962462CA9
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744379035; cv=none; b=XLhF2oi5k5XUp91NVkEqOHOzI7h6WFijP9Anss+K0ARNjAiZa1H5j+UXjARMQteWkba4kO7EqwgwSq9raL91e3xpCkv0MIrRrOQfGK+X47/uJ4zcg2GoJ0iYj1ywMLVRNRWMX5Qq7JRmHFAdhKFaBszbkOhcQ/uE6TgrAyjyMIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744379035; c=relaxed/simple;
	bh=pqHaLPJDGFUQgp5UFALTBo7XsWRP1YBGfAfNOrlRGRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grbi6mK2rKECu9LlegSYIsY1Q0I27gm4iWH/qlDdunPu/QnagftiwKvWIvcffB4W3Ot6/D17AWSQswBCkXkz5PI44oyTLG3moLKvLe3ntZYsRJYIewsDu6z4yfdR4U+PwqYho9AagYRgO2pgM9I8XE+PWR9Zop98SXz8xJmFK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgOuO29A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744379032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8eQRfu1SwDMTUD65YYbxtLcJcUUvfPEbGonaBHeDlEw=;
	b=hgOuO29A71ipuu42/DFk6PyC9OrAAdFwFhL67XWrVYgSq5HcHTCPNhfggPbp8piFn1PYA7
	vc790b3qLgjMHpNrV5xSljLjTqZuZMxmrTtZKHlYPJoqnyKqYNmCtB69PTRovmXoSdioxx
	Eo795f0vS1qFzg0JqgwqwOlR/Wz8wdc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-AcYqTGlfPZugLLmzj-vJqg-1; Fri, 11 Apr 2025 09:43:50 -0400
X-MC-Unique: AcYqTGlfPZugLLmzj-vJqg-1
X-Mimecast-MFC-AGG-ID: AcYqTGlfPZugLLmzj-vJqg_1744379030
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e68e9d9270so1779822a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 06:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744379030; x=1744983830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eQRfu1SwDMTUD65YYbxtLcJcUUvfPEbGonaBHeDlEw=;
        b=lg/+AToDF1bS6RdSF4v3xK0dfGspLBCMjQS1ILTGrsxnJR30iNFRlnFVvllR8vtsGD
         kMfx15KzTGxXCh7e9MHrRiOP6vtKFPwoEL3/yWxM3K+zhkM8XY1xU3FfkyWqS/aLy5P+
         3KzekP3hSxbIpb6PKrh1P1mj5aLBlwb4FXupT9iDTo0/selVAvdge3Zx06FlUMQiByDY
         rQxuXEVevblfEswJ02leYVjDSisyzD4n0s33QwxzWP/88PcNSbaKkY+qg/kaXZCzINS8
         6e2/0U9Cgf775dtp6kRnmKcUM4Xf+v8wBtx3eWV4fec2uOZbyqJt3HYoMvowtud7a1Ny
         axYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ifMFLFynY7HsjVny2h7ND58BA+gvUtRppy6GTHCUPL1tGgh2EXFcncqOGBYbOgA5FWiZgLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqZCZHTXPsN6pD3492CO3EmT+IjB04vlOSSadIlJMhxfhc35f
	YwP0TFkKTLwiQJ3ugQgKrlcja6wp5USAGkkN/bwULB3eJHX21e1NC2w684Zq0F0iB6TpQxtsJx5
	M6J+PtZdKhnGwp97fvo0fNg9z8sDvkvwWkc60yvzbcYVj7rSxr+U/qg==
X-Gm-Gg: ASbGncuY1Oxyd4ESQ6qC4JZcGcbKnpIdIgpyskJNC+whBful0Lxd1CgZwzJDprE2cAB
	GZGW+HiuWikPjQU8m1T7tZwfgRcuoDPR44pD2VaDVkjIw5NjD127D3TKBigZIO7WdGdMd30R2NL
	5hcxJ/zb7MkBdGYW0LH2vZPAENkTI+PqLzukTEGJdWImNycO/nqcFbD5ch2cUSckwNREl44GELW
	DIgWlmMQPrRDck9ZOdKeGKtGXhlo31gadsYIhkZ3bpY5r82a0PxgpECeJZqQ/fonpG9SQT5vha2
	7JR2/z5p1Am49Ku33ReCE2A54rdlfzSANoZnLBW0g7+7F27tDf4ketYDpP1g
X-Received: by 2002:a05:6402:40d5:b0:5e5:437b:74a7 with SMTP id 4fb4d7f45d1cf-5f36f6441c8mr2464159a12.8.1744379029536;
        Fri, 11 Apr 2025 06:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqX68Cv7buhlNWQ6yUC3SFUYIPHgd82ovG6x6fn05G9UUk87m/Y4qhNVGifIURWeZGKX/Zgw==
X-Received: by 2002:a05:6402:40d5:b0:5e5:437b:74a7 with SMTP id 4fb4d7f45d1cf-5f36f6441c8mr2464099a12.8.1744379028891;
        Fri, 11 Apr 2025 06:43:48 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f505744sm1008727a12.57.2025.04.11.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:43:48 -0700 (PDT)
Date: Fri, 11 Apr 2025 15:43:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] vsock: Linger on unsent data
Message-ID: <p5toijsqhehc4kp7gztto3nmrqa33f62duozoxn7u5hh6d2xpe@lfzy6kdszegf>
References: <20250407-vsock-linger-v1-0-1458038e3492@rbox.co>
 <20250407-vsock-linger-v1-1-1458038e3492@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250407-vsock-linger-v1-1-1458038e3492@rbox.co>

On Mon, Apr 07, 2025 at 08:41:43PM +0200, Michal Luczaj wrote:
>Change the behaviour of a lingering close(): instead of waiting for all
>data to be consumed, block until data is considered sent, i.e. until worker
>picks the packets and decrements virtio_vsock_sock::bytes_unsent down to 0.
>
>Do linger on shutdown() just as well.

I think this should go in a separate patch.

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 25 +++++++++++++++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 25 +++----------------------
> 3 files changed, 29 insertions(+), 22 deletions(-)
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
>index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..383c6644d047589035c0439c47d1440273e67ea9 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1013,6 +1013,29 @@ static int vsock_getname(struct socket *sock,
> 	return err;
> }
>
>+void vsock_linger(struct sock *sk, long timeout)
>+{
>+	if (timeout) {

I would prefer to avoid a whole nested block and return immediately
in such a case. (It's pre-existing, but since we are moving this code
I'd fix it).

	if (!timeout)
		return;

>+		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>+		struct vsock_sock *vsk = vsock_sk(sk);
>+

transport->unsent_bytes can be NULL, this will panic with hyperv or
vmci transport, especially because we now call this function in
vsock_shutdown().

I'd skip that call if transports don't implement it, but please add
a comment on top of this function about that.

>+		unsent = vsk->transport->unsent_bytes;
>+		if (!unsent)
>+			return;
>+
>+		add_wait_queue(sk_sleep(sk), &wait);
>+
>+		do {
>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+				break;
>+		} while (!signal_pending(current) && timeout);
>+
>+		remove_wait_queue(sk_sleep(sk), &wait);
>+	}
>+}
>+EXPORT_SYMBOL_GPL(vsock_linger);
>+
> static int vsock_shutdown(struct socket *sock, int mode)
> {
> 	int err;
>@@ -1056,6 +1079,8 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 		if (sock_type_connectible(sk->sk_type)) {
> 			sock_reset_flag(sk, SOCK_DONE);
> 			vsock_send_shutdown(sk, mode);
>+			if (sock_flag(sk, SOCK_LINGER))
>+				vsock_linger(sk, sk->sk_lingertime);
> 		}
> 	}
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d8809655fe522749fbbc9025df71f071bd..66ff2e694e474ad16f70248cc1dc235f4e1ebaa1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1192,23 +1192,6 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> 	vsock_remove_sock(vsk);
> }
>
>-static void virtio_transport_wait_close(struct sock *sk, long timeout)
>-{
>-	if (timeout) {
>-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-
>-		add_wait_queue(sk_sleep(sk), &wait);
>-
>-		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  sock_flag(sk, SOCK_DONE), &wait))
>-				break;
>-		} while (!signal_pending(current) && timeout);
>-
>-		remove_wait_queue(sk_sleep(sk), &wait);
>-	}
>-}

Anyway in this patch we are doing 3 things:
1. check unsent_bytes during wait_close()
2. move wait_close in af_vsock.c adding vsock_linger()
3. call vsock_linger() also during vsock_shutdown()

I think this is a clear signal that we need to split it into at least
3 patches.

>-
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout)
> {
>@@ -1279,15 +1262,13 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> 		(void)virtio_transport_shutdown(vsk, SHUTDOWN_MASK);
>
> 	if (sock_flag(sk, SOCK_LINGER) && !(current->flags & PF_EXITING))
>-		virtio_transport_wait_close(sk, sk->sk_lingertime);
>+		vsock_linger(sk, sk->sk_lingertime);

Might it make sense, as you did for vsock_shutdown(), to move this
to af_vsock.c (in another patch) so that we support it for all
transports?

>
>-	if (sock_flag(sk, SOCK_DONE)) {
>+	if (sock_flag(sk, SOCK_DONE))
> 		return true;
>-	}

Please avoid this unrelated changes, if you really want to fix them,
add another patch in the series where to fix them.

>
> 	sock_hold(sk);
>-	INIT_DELAYED_WORK(&vsk->close_work,
>-			  virtio_transport_close_timeout);
>+	INIT_DELAYED_WORK(&vsk->close_work, virtio_transport_close_timeout);

Ditto.

These 2 could go together in a single `cleanup` patch, although I
usually avoid it so that `git blame` makes sense. But if we want to
make checkpatch happy, that's fine.

Thanks,
Stefano

> 	vsk->close_work_scheduled = true;
> 	schedule_delayed_work(&vsk->close_work, VSOCK_CLOSE_TIMEOUT);
> 	return false;
>
>-- 
>2.49.0
>


