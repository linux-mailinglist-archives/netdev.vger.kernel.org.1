Return-Path: <netdev+bounces-94455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2B8BF866
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9E61F23E99
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8E47A5C;
	Wed,  8 May 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxYskzG9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872752C861
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715156541; cv=none; b=ClEAtwdKcDt49kQxXeOXQ09XzGOMCWiLsW75+h/yXzIQKkSPku5JMZUrKEIohLckJgNJLi9TO1lbomDhRGvoU307aG/qdt8UavzZ76Nl0ZyXUd3yj6TzRdRxJh3VAWPvEGg4YEXGD8d8KE5jrukJ4petdkDLsMtvupu+LoGCv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715156541; c=relaxed/simple;
	bh=ygFz4Xi5KPzs5xGDIbJIGzXq1wtvM0/GTF+V51fuSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3go0sCtjd1zg0zx3OfqPdLlPJtJvMMC4YDObRG1gEeyg5600GyALDiptC737U6qXFq9RHMEJwhJtNCLGh8vB0gwBAhqZDnpfsSKXgOL9PSzeIvbnCs0LrJc1QKfb2K8pbPJvxaqJl2chJq5J8C1b2hSZxCdPWbAv7lkPvQBKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxYskzG9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715156538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WECjWQs8mty4SiAVTCtSfnAeiyCSuc/uRnEzCXqgsoI=;
	b=DxYskzG9Fo5AEhpVBmEE4qj9dE0yKXe1hNDaRLi6J3Rv8LKSMBeXQYVHdZaxDY6SZ9o6BC
	Dyia4HLJMaekDnCi0JX5/2wDRUnkkdOm7pXrWh/DsgE356VKJrcszn8LcGA2iecwTT9i6V
	rjmdDmlAYvqQgR7ZiFWKvuwGctUlQU4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-UF3DzY6DOPuwITiHdCrqbg-1; Wed, 08 May 2024 04:22:15 -0400
X-MC-Unique: UF3DzY6DOPuwITiHdCrqbg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a599b55056bso233274066b.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 01:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715156534; x=1715761334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WECjWQs8mty4SiAVTCtSfnAeiyCSuc/uRnEzCXqgsoI=;
        b=D5BkbZ52XkiEJ7dlKzZNHRRwmfSLEITboFHkath5G9KJmDuu24qAH1c4uVHCHwR+FW
         BsREYHwtjGyMaRuOFzpR22Q1CDA13w9+dxPCSj59AZJY4SCGtQwTYRzwvB8RcYZ8i3B5
         IYPbU/VSR22JJRHPB+NOInqfgEWrcIcQNpK6hvVAAL8CZiBFOnBmLsHjMZWjByDGJSfM
         v/l/olzjA4Vjp4gm5+SvvFnXZFuUdVtF3bsTOJVwT/8zKQ5gOAt9eaybVCH6tYccwqYi
         BL+u2KN5h4KjgDvaZSePyUXaAweMViIjzhuJKLwk5R+oLIhaqlPJfS9odElQ7aVhwheY
         MzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ChqIWaaFz6fix/JlxFwZLiVzyfnh57pHHhpALaqjuuEwIVnIBQAl0inXBaM6uYJk8A1wyf/p1UuihZJFiqIST0xomAT+
X-Gm-Message-State: AOJu0YyVNX57/98THJjgS7P25gVO3CTqjYF0iWKV0qs1gnbRm5rF24s6
	3jiqYaN03G1mF3BvmZVfo9t/7TU3uj3ilj6gPzzQp2gCY2qx2PzJA8Wu6fFvrMV698WZW0/0JeN
	0D6Ju3gww0k55doprxT8FE7981EbJ2WIAY4JRSm2rvLEyw6rxmO+9j2j2C0iWug==
X-Received: by 2002:a17:906:74d:b0:a59:bb20:9964 with SMTP id a640c23a62f3a-a59fb94b8f0mr124742366b.23.1715156534183;
        Wed, 08 May 2024 01:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU9a/9Dj60z9UWENRsQNKFMOX3GbrPe06GNksU418kuNjSLQfi4iB448HOWm6NjY8xN34DpA==
X-Received: by 2002:a17:906:74d:b0:a59:bb20:9964 with SMTP id a640c23a62f3a-a59fb94b8f0mr124740166b.23.1715156533853;
        Wed, 08 May 2024 01:22:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
        by smtp.gmail.com with ESMTPSA id cf14-20020a170906b2ce00b00a59ef203579sm1645424ejb.138.2024.05.08.01.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:22:13 -0700 (PDT)
Date: Wed, 8 May 2024 10:22:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <luigi.leonardi@outlook.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kuba@kernel.org, stefanha@redhat.com, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, kvm@vger.kernel.org, 
	jasowang@redhat.com, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] vsock: add support for SIOCOUTQ ioctl
 for all vsock socket types.
Message-ID: <t752lxu3kwqypmdgr36nrd63pfigdgi22xhjawitr6mhjz2u4g@7xa3ucifp2sc>
References: <20240408133749.510520-1-luigi.leonardi@outlook.com>
 <AS2P194MB21708B8955BEC4C0D2EF822B9A002@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <AS2P194MB21708B8955BEC4C0D2EF822B9A002@AS2P194MB2170.EURP194.PROD.OUTLOOK.COM>

On Mon, Apr 08, 2024 at 03:37:47PM GMT, Luigi Leonardi wrote:
>This add support for ioctl(s) for SOCK_STREAM SOCK_SEQPACKET and SOCK_DGRAM
>in AF_VSOCK.
>The only ioctl available is SIOCOUTQ/TIOCOUTQ, which returns the number
>of unsent bytes in the socket. This information is transport-specific
>and is delegated to them using a callback.
>
>Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> include/net/af_vsock.h   |  3 +++
> net/vmw_vsock/af_vsock.c | 51 +++++++++++++++++++++++++++++++++++++---
> 2 files changed, 51 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 535701efc1e5..7d67faa7bbdb 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -169,6 +169,9 @@ struct vsock_transport {
> 	void (*notify_buffer_size)(struct vsock_sock *, u64 *);
> 	int (*notify_set_rcvlowat)(struct vsock_sock *vsk, int val);
>
>+	/* SIOCOUTQ ioctl */
>+	int (*unsent_bytes)(struct vsock_sock *vsk);
>+
> 	/* Shutdown. */
> 	int (*shutdown)(struct vsock_sock *, int);
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 54ba7316f808..fc108283409a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -112,6 +112,7 @@
> #include <net/sock.h>
> #include <net/af_vsock.h>
> #include <uapi/linux/vm_sockets.h>
>+#include <uapi/asm-generic/ioctls.h>
>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -1292,6 +1293,50 @@ int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> }
> EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
>
>+static int vsock_do_ioctl(struct socket *sock, unsigned int cmd,
>+			  int __user *arg)
>+{
>+	struct sock *sk = sock->sk;
>+	struct vsock_sock *vsk;
>+	int retval;
>+
>+	vsk = vsock_sk(sk);
>+
>+	switch (cmd) {
>+	case SIOCOUTQ: {
>+		int n_bytes;
>+
>+		if (vsk->transport->unsent_bytes) {

Should we also check the `vsk->transport` is not null?

I also suggest an early return, or to have the shortest branch on top
for readability:

		if (!vsk->transport || !vsk->transport->unsent_bytes) {
			retval = -EOPNOTSUPP;
			break;
		}

Thanks,
Stefano

>+			if (sock_type_connectible(sk->sk_type) && sk->sk_state == TCP_LISTEN) {
>+				retval = -EINVAL;
>+				break;
>+			}
>+
>+			n_bytes = vsk->transport->unsent_bytes(vsk);
>+			if (n_bytes < 0) {
>+				retval = n_bytes;
>+				break;
>+			}
>+
>+			retval = put_user(n_bytes, arg);
>+		} else {
>+			retval = -EOPNOTSUPP;
>+		}
>+		break;
>+	}
>+	default:
>+		retval = -ENOIOCTLCMD;
>+	}
>+
>+	return retval;
>+}
>+
>+static int vsock_ioctl(struct socket *sock, unsigned int cmd,
>+		       unsigned long arg)
>+{
>+	return vsock_do_ioctl(sock, cmd, (int __user *)arg);
>+}
>+
> static const struct proto_ops vsock_dgram_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -1302,7 +1347,7 @@ static const struct proto_ops vsock_dgram_ops = {
> 	.accept = sock_no_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = sock_no_listen,
> 	.shutdown = vsock_shutdown,
> 	.sendmsg = vsock_dgram_sendmsg,
>@@ -2286,7 +2331,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
> 	.setsockopt = vsock_connectible_setsockopt,
>@@ -2308,7 +2353,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
> 	.accept = vsock_accept,
> 	.getname = vsock_getname,
> 	.poll = vsock_poll,
>-	.ioctl = sock_no_ioctl,
>+	.ioctl = vsock_ioctl,
> 	.listen = vsock_listen,
> 	.shutdown = vsock_shutdown,
> 	.setsockopt = vsock_connectible_setsockopt,
>-- 
>2.34.1
>


