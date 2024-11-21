Return-Path: <netdev+bounces-146625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB29D49D9
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281F02811AB
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDA1A9B27;
	Thu, 21 Nov 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO7vptDF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028914A62A
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180937; cv=none; b=VomSg3N9kbU5Q6Q3FpBTZx6TrbOOB7AtgGbP8wcVNX05vmESqNit5xOcJ06OCKoxTtY+ZDBFn46xpI1b3dc5O4siVYL0kYpl65d8AUffoNzPhCFKqurYSwNpBZ4W9RTFi8wfx71PJJIdjC+1tCegk+JFCuXJjgR3FhdSyxjMG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180937; c=relaxed/simple;
	bh=Et+MyeUBBwbo+Ho9sHMO1ZkHG8oW6vT7dGJOy8DCj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3PxMOrx+kd3B7+IuV0NQrDexkS/4d34MJ5XYE+Cd3+D5dPI49d9HMFVXt5wV7h9cwGFpfN3R6hhhvFS8h1mlZhBiuBvXpXUlirKKx7E1pxuDFLisHNbo3SMCCTfaLYKIW0IVwfvkz3ezyZ7luKDqtAn2W2/nfMREyCg6joo3lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO7vptDF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UhM3T0zK7wAUQ6aYe/q88lHTgWagB7X71lPl9l7iAQ=;
	b=ZO7vptDFDmcf9onp7C9JYHLuj/pX7PG0xdaMqzBUwEArQK4TYr7rWWhynXwVuosQ7hKyOX
	r3EJBV2E+7NwK6kh6t/dSzoT6/spLBvbHzy43ynvIs1nXhVaWZwMNZSva60or5+DNl25+h
	t7ZtgTzQj15GPwqmmyy0PttWRtTCC9E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-cjyXzQdMMlCRwTUZjzELgQ-1; Thu, 21 Nov 2024 04:22:11 -0500
X-MC-Unique: cjyXzQdMMlCRwTUZjzELgQ-1
X-Mimecast-MFC-AGG-ID: cjyXzQdMMlCRwTUZjzELgQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a22a62e80so43729166b.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180930; x=1732785730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UhM3T0zK7wAUQ6aYe/q88lHTgWagB7X71lPl9l7iAQ=;
        b=tWPEmQHNpmVD9T3mn2NrVrhxZVTWnXNVdWUTmG5VaHV5jX1VwRlbp1pN+xBXqDuKCr
         qW/PKbMkzatzW99L0FLXJaXUyH833SzZh13Iu+Pd0Z+7h25CXoSIPvJHM5ffGWGd8Qm4
         dVB0gVvIKRcsGWW5aqbxK9Wl4tJAlsVafI8pIi5W1cCc+5UmIUvsv+ffgDnssbkieCuk
         beCdZ9hLB13jTpf0t5eIFC2YILiefNghFI6gsM0g4MZr4n60wm7i3ucuiePHHj5khQBC
         OxvdcWhFXg0lpyL6qjswrmbxq6U08uRMJhX4JueLtgzzUhM/uFVPAdnZACqrYC3s1fTs
         GyZg==
X-Forwarded-Encrypted: i=1; AJvYcCWExWuRMejh9istuxlqG2z/gcFZ1lon3abH9Z/60trjKo8/eDrKz/4fkreNJmsADiPZ9ZlLF+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3zYst8S74RshDW7CKPd9rNxhjjan9TbC6ocb4NyObf8DQgBG
	QCUW7z60JkX4XZgRFlr0VhweMvjA9ElqXi149u3lpJVUJdEJ6FY8Xf5DGcwD2n1dLBDRvhcePrM
	V5nXm7Guy90dd2yXkKE6b5sUMslpqeyWMtlOLFbUra1+Wz7T1wsQR1w==
X-Gm-Gg: ASbGnctipHCardYCaTK+YKeIxSfz6DE4kqiRPke7rZ/fCNlhw6BAuU9pJs+UM4b/kRM
	KrYeprGmPdhiztPwCpyXQ8CJsAlJbW2Zb4qdWhn9A+bVqObVhbZ9G/mQ19AgllTuqaqZOrg0dsA
	EWgUUQtvY+LVho3I1Gui+ABM5fiGIPSH9BVFO0lIwzFmRGkQXE73QI4BnroTsU5rJ3RQat4/X6+
	0iRO56VTQPBoZsri2xyJwEPi3DMjrB9h1kS2Dk/FDpCzieftd1zPQJE6BxLJ/oKAOMlivoNFbRK
	DuFj9ZBmp+a+uIGdB117Uh21fg==
X-Received: by 2002:a17:907:368a:b0:a9e:b287:2813 with SMTP id a640c23a62f3a-aa4dd52ad60mr613895866b.5.1732180930480;
        Thu, 21 Nov 2024 01:22:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpYURhAqi2+Iv1yCRlEqtYUTNmT6QPL+4sLpjlgm8nBJLv3Pn2th1eX/kMAyjO5FOXeHGCAQ==
X-Received: by 2002:a17:907:368a:b0:a9e:b287:2813 with SMTP id a640c23a62f3a-aa4dd52ad60mr613891666b.5.1732180929759;
        Thu, 21 Nov 2024 01:22:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f42d4b5dsm56844866b.112.2024.11.21.01.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:22:09 -0800 (PST)
Date: Thu, 21 Nov 2024 10:22:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
Message-ID: <7wufhaaytdjp3m3xv7jrdadqjg75is5eirv4bzmjzmezc7v7ls@p52fm6y537di>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co>

On Mon, Nov 18, 2024 at 10:03:43PM +0100, Michal Luczaj wrote:
>vsock defines a BPF callback to be invoked when close() is called. However,
>this callback is never actually executed. As a result, a closed vsock
>socket is not automatically removed from the sockmap/sockhash.
>
>Introduce a dummy vsock_close() and make vsock_release() call proto::close.
>
>Note: changes in __vsock_release() look messy, but it's only due to indent
>level reduction and variables xmas tree reorder.
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 67 +++++++++++++++++++++++++++++-------------------
> 1 file changed, 40 insertions(+), 27 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 919da8edd03c838cbcdbf1618425da6c5ec2df1a..b52b798aa4c2926c3f233aad6cd31b4056f6fee2 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -117,12 +117,14 @@
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
> static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
>+static void vsock_close(struct sock *sk, long timeout);
>
> /* Protocol family. */
> struct proto vsock_proto = {
> 	.name = "AF_VSOCK",
> 	.owner = THIS_MODULE,
> 	.obj_size = sizeof(struct vsock_sock),
>+	.close = vsock_close,
> #ifdef CONFIG_BPF_SYSCALL
> 	.psock_update_sk_prot = vsock_bpf_update_proto,
> #endif
>@@ -797,39 +799,37 @@ static bool sock_type_connectible(u16 type)
>
> static void __vsock_release(struct sock *sk, int level)
> {
>-	if (sk) {
>-		struct sock *pending;
>-		struct vsock_sock *vsk;
>-
>-		vsk = vsock_sk(sk);
>-		pending = NULL;	/* Compiler warning. */
>+	struct vsock_sock *vsk;
>+	struct sock *pending;
>
>-		/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>-		 * version to avoid the warning "possible recursive locking
>-		 * detected". When "level" is 0, lock_sock_nested(sk, level)
>-		 * is the same as lock_sock(sk).
>-		 */
>-		lock_sock_nested(sk, level);
>+	vsk = vsock_sk(sk);
>+	pending = NULL;	/* Compiler warning. */
>
>-		if (vsk->transport)
>-			vsk->transport->release(vsk);
>-		else if (sock_type_connectible(sk->sk_type))
>-			vsock_remove_sock(vsk);
>+	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>+	 * version to avoid the warning "possible recursive locking
>+	 * detected". When "level" is 0, lock_sock_nested(sk, level)
>+	 * is the same as lock_sock(sk).
>+	 */
>+	lock_sock_nested(sk, level);
>
>-		sock_orphan(sk);
>-		sk->sk_shutdown = SHUTDOWN_MASK;
>+	if (vsk->transport)
>+		vsk->transport->release(vsk);
>+	else if (sock_type_connectible(sk->sk_type))
>+		vsock_remove_sock(vsk);
>
>-		skb_queue_purge(&sk->sk_receive_queue);
>+	sock_orphan(sk);
>+	sk->sk_shutdown = SHUTDOWN_MASK;
>
>-		/* Clean up any sockets that never were accepted. */
>-		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
>-			__vsock_release(pending, SINGLE_DEPTH_NESTING);
>-			sock_put(pending);
>-		}
>+	skb_queue_purge(&sk->sk_receive_queue);
>
>-		release_sock(sk);
>-		sock_put(sk);
>+	/* Clean up any sockets that never were accepted. */
>+	while ((pending = vsock_dequeue_accept(sk)) != NULL) {
>+		__vsock_release(pending, SINGLE_DEPTH_NESTING);
>+		sock_put(pending);
> 	}
>+
>+	release_sock(sk);
>+	sock_put(sk);
> }
>
> static void vsock_sk_destruct(struct sock *sk)
>@@ -901,9 +901,22 @@ void vsock_data_ready(struct sock *sk)
> }
> EXPORT_SYMBOL_GPL(vsock_data_ready);
>
>+/* Dummy callback required by sockmap.
>+ * See unconditional call of saved_close() in sock_map_close().
>+ */
>+static void vsock_close(struct sock *sk, long timeout)
>+{
>+}
>+
> static int vsock_release(struct socket *sock)
> {
>-	__vsock_release(sock->sk, 0);
>+	struct sock *sk = sock->sk;
>+
>+	if (!sk)
>+		return 0;

Compared with before, now we return earlier and so we don't set SS_FREE, 
could it be risky?

I think no, because in theory we have already set it in a previous call, 
right?

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>+
>+	sk->sk_prot->close(sk, 0);
>+	__vsock_release(sk, 0);
> 	sock->sk = NULL;
> 	sock->state = SS_FREE;
>
>
>-- 
>2.46.2
>


