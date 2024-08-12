Return-Path: <netdev+bounces-117620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77194E941
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA81C21ADE
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8942816CD16;
	Mon, 12 Aug 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKw1X4qS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A416D9A2
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453605; cv=none; b=pNgxBUIUWAhWHQVXNOYPlREvdcDkGyB8bMYngKcfc978Fyb1TA2VTmNNUHgQNgkOxKX3R3TqPCvN1CMBNZQ5+URuW5+uBCetAAudmrYLYIVvUSFsv0dWM1uTmc6wO+fmdMioCzGLqlJ9DLiXys3x0/hO/372Iany/OA0edBZ38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453605; c=relaxed/simple;
	bh=4903o0Gxm9S2KRs2tL3qBkHRdHaKxdPP61YxuBSYSok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da2gKdVart2xKyTuFRwbj1ysJ6h9u6YMvfN0gvZdBBOY9X7lx1XKt9ycmrLBTERQCboYM3pPt+B3XZBARP1zeXaj31ccRmm2IEoexm2Bqy2ht1fMKXn2LvGUHU6p1GB36axuIlzEtTm6PyGDlkU67VbMq43UuldhvQQTHZZ2UOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKw1X4qS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723453601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/OK5TTFOJekdHMnGIUU3vizmn/d2YxTUJutAY1KYUk=;
	b=HKw1X4qSMqCqFfySwWd2puTjIHa9KWzQdWOgAxirvw3pgbll7YPqrqq9aepE1QNODGNyTc
	JXdVUlL1O2WJu3wFe/2g544t2fHEaIVCiHUBBdHIoyQco9+xhKpJHJ9jKh+bbauX3iK3pi
	PVxqXt5AaxgIeBCHvNJ3MBJI1o5e8j0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-3VcZB6TaPM-i-95JclEpsA-1; Mon, 12 Aug 2024 05:06:33 -0400
X-MC-Unique: 3VcZB6TaPM-i-95JclEpsA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef22e62457so42963421fa.2
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 02:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723453591; x=1724058391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/OK5TTFOJekdHMnGIUU3vizmn/d2YxTUJutAY1KYUk=;
        b=uyQGeqIb1kHJAD/VTg01du5ql+ssfRy8FvBO7Jax2W/BmOE6NovRfDTlabNxLMcg4u
         CZQOhxIWR97wYPVxKRPypM8cC0ZjdvcOSATJZ9QUIZYrfhrzBMHaZZE+XiT/wRZpvGLx
         XvfYwgQIWxTeqzMuB5vU3lT6y1pQz4MzlQGODAcG97l5NCw4gmi2QDXsomZMFGN2/C3Y
         RGAsu59mDrlnPCkY8jH9cHk1qlpWtCVqm2DTW+TGOzCTrrpg0KmnFeV/JhxIrWC24kKN
         gmw15rUh9A6oRBag+BMDmoJQqFV9LyEN0wy4Rf3XtEJa0dkEuhw/XBs2KsuXfaLkKgla
         zoLA==
X-Gm-Message-State: AOJu0Yzx2VnfG26XV5J0bhieuHZBjlguqMl85ELiHgcnnnO0Lrn3bAoD
	k1ooNSts7A2RwdQYpR46zKIgDhQHOEc3SduyKGeBMjvOV7J9yBtR5+u6eW/GSEMaVmd0oKanYLI
	ZYg1i6SKOl52YhI4VGedHF5sBevvZlvWcksizJrl5fH0ltuJcRHgKWvWxiRmdyg==
X-Received: by 2002:a05:6512:68c:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-530ee981756mr6180583e87.11.1723453591582;
        Mon, 12 Aug 2024 02:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDiJnYt6CnszI4XqFKJUcy5IhAQ8K4wWN1bwE7aP4/eaq/ZWMytHZunrBfn3on4sNHZzKmPw==
X-Received: by 2002:a05:6512:68c:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-530ee981756mr6180540e87.11.1723453590576;
        Mon, 12 Aug 2024 02:06:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:d1a0:5d86:9899:95ec:4118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea09sm6908779f8f.71.2024.08.12.02.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:06:29 -0700 (PDT)
Date: Mon, 12 Aug 2024 05:06:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	virtualization@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>,
	syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix recursive ->recvmsg calls
Message-ID: <20240812050620-mutt-send-email-mst@kernel.org>
References: <20240812022153.86512-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812022153.86512-1-xiyou.wangcong@gmail.com>

On Sun, Aug 11, 2024 at 07:21:53PM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After a vsock socket has been added to a BPF sockmap, its prot->recvmsg
> has been replaced with vsock_bpf_recvmsg(). Thus the following
> recursiion could happen:
> 
> vsock_bpf_recvmsg()
>  -> __vsock_recvmsg()
>   -> vsock_connectible_recvmsg()
>    -> prot->recvmsg()
>     -> vsock_bpf_recvmsg() again
> 
> We need to fix it by calling the original ->recvmsg() without any BPF
> sockmap logic in __vsock_recvmsg().
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
> Tested-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
> Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/net/af_vsock.h    |  4 ++++
>  net/vmw_vsock/af_vsock.c  | 50 +++++++++++++++++++++++----------------
>  net/vmw_vsock/vsock_bpf.c |  4 ++--
>  3 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 535701efc1e5..24d970f7a4fa 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -230,8 +230,12 @@ struct vsock_tap {
>  int vsock_add_tap(struct vsock_tap *vt);
>  int vsock_remove_tap(struct vsock_tap *vt);
>  void vsock_deliver_tap(struct sk_buff *build_skb(void *opaque), void *opaque);
> +int __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +				int flags);
>  int vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  			      int flags);
> +int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> +			  size_t len, int flags);
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags);
>  
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 4b040285aa78..0ff9b2dd86ba 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1270,25 +1270,28 @@ static int vsock_dgram_connect(struct socket *sock,
>  	return err;
>  }
>  
> +int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
> +			  size_t len, int flags)
> +{
> +	struct sock *sk = sock->sk;
> +	struct vsock_sock *vsk = vsock_sk(sk);
> +
> +	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
> +}
> +
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags)
>  {
>  #ifdef CONFIG_BPF_SYSCALL
> +	struct sock *sk = sock->sk;
>  	const struct proto *prot;
> -#endif
> -	struct vsock_sock *vsk;
> -	struct sock *sk;
>  
> -	sk = sock->sk;
> -	vsk = vsock_sk(sk);
> -
> -#ifdef CONFIG_BPF_SYSCALL
>  	prot = READ_ONCE(sk->sk_prot);
>  	if (prot != &vsock_proto)
>  		return prot->recvmsg(sk, msg, len, flags, NULL);
>  #endif
>  
> -	return vsk->transport->dgram_dequeue(vsk, msg, len, flags);
> +	return __vsock_dgram_recvmsg(sock, msg, len, flags);
>  }
>  EXPORT_SYMBOL_GPL(vsock_dgram_recvmsg);
>  
> @@ -2174,15 +2177,12 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>  }
>  
>  int
> -vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> -			  int flags)
> +__vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +			    int flags)
>  {
>  	struct sock *sk;
>  	struct vsock_sock *vsk;
>  	const struct vsock_transport *transport;
> -#ifdef CONFIG_BPF_SYSCALL
> -	const struct proto *prot;
> -#endif
>  	int err;
>  
>  	sk = sock->sk;
> @@ -2233,14 +2233,6 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		goto out;
>  	}
>  
> -#ifdef CONFIG_BPF_SYSCALL
> -	prot = READ_ONCE(sk->sk_prot);
> -	if (prot != &vsock_proto) {
> -		release_sock(sk);
> -		return prot->recvmsg(sk, msg, len, flags, NULL);
> -	}
> -#endif
> -
>  	if (sk->sk_type == SOCK_STREAM)
>  		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>  	else
> @@ -2250,6 +2242,22 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	release_sock(sk);
>  	return err;
>  }
> +
> +int
> +vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> +			  int flags)
> +{
> +#ifdef CONFIG_BPF_SYSCALL
> +	struct sock *sk = sock->sk;
> +	const struct proto *prot;
> +
> +	prot = READ_ONCE(sk->sk_prot);
> +	if (prot != &vsock_proto)
> +		return prot->recvmsg(sk, msg, len, flags, NULL);
> +#endif
> +
> +	return __vsock_connectible_recvmsg(sock, msg, len, flags);
> +}
>  EXPORT_SYMBOL_GPL(vsock_connectible_recvmsg);
>  
>  static int vsock_set_rcvlowat(struct sock *sk, int val)
> diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
> index a3c97546ab84..c42c5cc18f32 100644
> --- a/net/vmw_vsock/vsock_bpf.c
> +++ b/net/vmw_vsock/vsock_bpf.c
> @@ -64,9 +64,9 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
>  	int err;
>  
>  	if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET)
> -		err = vsock_connectible_recvmsg(sock, msg, len, flags);
> +		err = __vsock_connectible_recvmsg(sock, msg, len, flags);
>  	else if (sk->sk_type == SOCK_DGRAM)
> -		err = vsock_dgram_recvmsg(sock, msg, len, flags);
> +		err = __vsock_dgram_recvmsg(sock, msg, len, flags);
>  	else
>  		err = -EPROTOTYPE;
>  
> -- 
> 2.34.1


