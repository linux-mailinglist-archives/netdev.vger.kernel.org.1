Return-Path: <netdev+bounces-146623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D79D49CC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268B71F20593
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2AE1BD4F8;
	Thu, 21 Nov 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA3pPajj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8B158D79
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180843; cv=none; b=cnb3mxrMuntlDxjxX2RqC0cs8d9xXnPHVAC+h0Q8ZfjKUm/Leke3pwTtf9gfe1HAuxk62P/bOWsdw7RiZUvZpaZjN0sYHg3VKLCFZmYoydDUy+wemBIQnl8yhvShBBYQOlCS/n3u2JdRjz4w1JM4P+W5iNmk0FtiihXkQ/9Zgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180843; c=relaxed/simple;
	bh=z3IzFqz6CGkWpS7Db68UfSWXKU8RdvRO9o8tJ0fBkns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcDqv6LIH524t09qcUieqdHJDYUYbFQcQo+c4YrLAYBy7ieovjqhLVBeleM9hPcWxWa5mAPhagMARAUqIlduzd/cIxJZIO5woch+gDftMymhYcivfpeMTnZEK0vUQuKOpblug/lgNngepG5sQSisXERrGV3UTRz8sjw96EsQdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA3pPajj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pe+KersGjDEJYz4W2aLOhFHR+iyviK6f7r1oEzw1+cc=;
	b=GA3pPajjraHX7fGf6YnZT6SIEOQU/yT6NM3l/bNdiPUAfx5A8kOdDMFzkm4xizXL+k89lh
	k8v/6hzM9DaZHxvxjMHT9xWx3N5RZe1xycZVQxdErkrQb5FGxAV9OLr9TVMcCGqFWuYIOO
	eijIfCm5p+ujfdmM36/UCS2aMidqjBs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-O4IhJyjaMjCzeaeMvz-V_g-1; Thu, 21 Nov 2024 04:20:39 -0500
X-MC-Unique: O4IhJyjaMjCzeaeMvz-V_g-1
X-Mimecast-MFC-AGG-ID: O4IhJyjaMjCzeaeMvz-V_g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99efe7369dso62571666b.0
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180838; x=1732785638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe+KersGjDEJYz4W2aLOhFHR+iyviK6f7r1oEzw1+cc=;
        b=owSqrBAUhuiDV45VbRl6gTTNyCi7VBqo1YUzjOEAwSls7X5U3e2eW2mqiqOpmx/Gw1
         jgJpfu2+6s6LTjgCzwUga6T/BvwFVs8r1SkdGKBy8olz3cN+Z0WrDzmZKX/xMiGPhs0a
         MEOYuxQM+YMZtgvTAQukKmxF6m+OzF3UmRgF8b8Rc8vE2S0kofOPByYp9tADkcyEcHkG
         TuLMOWUZkCXMvFLRqPzwTRJPNmYiEJqtimNHei49RV2AAUcSoCr0CKA8u9kuhlBeTa4K
         NHC6Usb1V/v94NAjEojz4YL5tZ2i/RGsmZE3sd5GXWe+NqzGl82+V1Ls7M2h7mwuEuIo
         VOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkGVcLCTKIe8su7zm6xxLFQPL3lCV2AOvyuVv8PEyHcja+5iTOVTV6EUn9f4mnQSUmsw5BSbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUehpBrt0x6H4X8af/sRN2MbGsggd/+h3RQQPj8twoPSu4plQ
	ZcPmes2HwausPizPMxBPyvm7how6nDuwBupUg72YZR7oP7uYtuzHVFEx1diaYQTwzjn1PHZKYtt
	6BzDbzko3jHEOxlNhSlQxW+zZ19IMhDpgBrfqYPu/PvP1xBzJ5jGHVw==
X-Received: by 2002:a17:907:2d91:b0:a9a:b818:521d with SMTP id a640c23a62f3a-aa4efb8cd32mr245016066b.18.1732180838231;
        Thu, 21 Nov 2024 01:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR9VubEFl+IO+AiFGGZg/eRdEemUzuJZ7gugoLasmFePLIWVWdepkm95op+xuk3Bl3LojEEA==
X-Received: by 2002:a17:907:2d91:b0:a9a:b818:521d with SMTP id a640c23a62f3a-aa4efb8cd32mr245013366b.18.1732180837663;
        Thu, 21 Nov 2024 01:20:37 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4380c16sm56352166b.202.2024.11.21.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:20:37 -0800 (PST)
Date: Thu, 21 Nov 2024 10:20:34 +0100
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
Subject: Re: [PATCH bpf 1/4] bpf, vsock: Fix poll() missing a queue
Message-ID: <rkuislntcknwmj65mghggj3k7jzzp5s5pbs36zacijjhcoag64@p5srullnpbqu>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>

On Mon, Nov 18, 2024 at 10:03:41PM +0100, Michal Luczaj wrote:
>When a verdict program simply passes a packet without redirection, sk_msg
>is enqueued on sk_psock::ingress_msg. Add a missing check to poll().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)

Yep, in vsock_bpf.c we set `prot->sock_is_readable = sk_msg_is_readable`,
so it LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index dfd29160fe11c4675f872c1ee123d65b2da0dae6..919da8edd03c838cbcdbf1618425da6c5ec2df1a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1054,6 +1054,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		mask |= EPOLLRDHUP;
> 	}
>
>+	if (sk_is_readable(sk))
>+		mask |= EPOLLIN | EPOLLRDNORM;
>+
> 	if (sock->type == SOCK_DGRAM) {
> 		/* For datagram sockets we can read if there is something in
> 		 * the queue and write as long as the socket isn't shutdown for
>
>-- 
>2.46.2
>


