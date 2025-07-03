Return-Path: <netdev+bounces-203771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C3AF7208
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68E57A1EA2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB92E2EF3;
	Thu,  3 Jul 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKWn5ARH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70C2DE6E2
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541897; cv=none; b=uWT8iir9VTafEnDLT54NpqlRh/imCYuETGx2/W5h4Ke3a0qJfh/bqBqaIbdgmF/Rg3xsTfWD0DPHGV2ZUOk7y9ANt7B+v+mNtWPoFaFqRWfTjUnZm3BpJI6/oauBpFk0Oo4yEV9ZZ+sKkg2LhTq5jLrDb9o6moo7gnCVMsRlCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541897; c=relaxed/simple;
	bh=BsV0eSUAnrB3wda6T9wzig3D/sNdr+8qBzppAP467XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc29bi+b7HzKKkYaI0CeWkkfT6Uh47OH7vFbf9OR+Rp+3ipaTMgHdiUYYfZEqrpkG6ZxweEQ/IewMJ3OuZW/67vJ7aT5zWJn/dC85KHz3CAFbtvH2kyt0mYAB+JhyUIB8YDPyi4+s7d79hqmJgSfZcCJvBQ5POyd4FP7sMhFLjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKWn5ARH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751541895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Ys+B0kKW0I1OmxDH3RChxDm9/AfOdFHpxEknTEX7s=;
	b=UKWn5ARHmQ9AO9G3hZRhtpm5gPe4z0r9vdj/UXxBusXHHd1vvjMrSlYhG+rO50pEzXhxPY
	drD2zf5lOcjmtwtzDvYPOOH05UODaKQs6XWf+rOauqNVcMxWbs/CvhZL17jCXHg3EooMPF
	f3B/QAye2EvYzPwFVVhqppGxYUHD/Q8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-4UzqYhzCP4e2PRRreCx1GA-1; Thu, 03 Jul 2025 07:24:53 -0400
X-MC-Unique: 4UzqYhzCP4e2PRRreCx1GA-1
X-Mimecast-MFC-AGG-ID: 4UzqYhzCP4e2PRRreCx1GA_1751541893
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453a5d50b81so27878455e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 04:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751541893; x=1752146693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Ys+B0kKW0I1OmxDH3RChxDm9/AfOdFHpxEknTEX7s=;
        b=W8ytrPXPBM16Us4K6vxSnaG6b6n+MYpp6RL+2E01zTrXvcMM/ibwiRBWjajdlYXye4
         92Z4WQgYd8UVisu4OGYMZWmZGsVxWIykd+/l47U3of3xI8vq2iXXsfm/nrIIxf80mS1/
         AvP4amGWOkBi48dp2ixVZqB1L9mb/ls2eFJq4KPWzEBBPWgxirnHzZaCV3gkBbuH1Mis
         qcXTV7YqA6pMZEqziMLHTEejTAREUcGaMzvfLDvHdXOhgMULo6hSvxJJ04YJYEatvaKq
         ThcqvVgrqmDQTYpibHkh71oIljSB/uWooDFfF8KvsGBYuulabCBbWSH9JhILeKEmUNJj
         oLPw==
X-Gm-Message-State: AOJu0YyHEWOVXAXTUDjD2IfysPtqCH5nFSZfERTIgLr5qD4iSw2Qyutl
	CsV5DUFk0YbCJtmXRZ9HtvaLA+cy31HHuvho/nVjM2jlipXhcQIiw87SPhlfxedpQN9YXQEtwd6
	Gi9Y9RGTyRcFuTYb96I9aJM7yCQDtg4GBQ61VxERILYnSeohHG6fIXY7QkQ==
X-Gm-Gg: ASbGncvJeLF5/E3Z1TSrZvDEquBh04fW43gaR6Fw6lpuj50I1uxMApMeilADIKwO0wZ
	Fc4sG9hsuBjbUOIsOTbPrkZhFEfVX1vxsqt9BCCz3mljj2C1+XPEyI22xlLjpOA5iSjQNO7DsiG
	uPzO89b/RPp7S7nm+UC3ooprig2JKswDAatk2+1ngLgz/bFpPSwXcV6MC4N+tDwQfei+fnIamfj
	c4rRCL+pNdPPt5YhJTitQeZ1lihPQSmsAlSRUkiTt7++IKbQkn0TSV23Ny7L6NQf9p0NzUVQ4+v
	l7EbIDh6JgDqYcso
X-Received: by 2002:a05:600c:3b9f:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454a4311ca9mr61059065e9.29.1751541892607;
        Thu, 03 Jul 2025 04:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ4owisLty2PWAU9CFlsOOvJcG4PRg4iHjZY5ASRNKjngFo9l8E2RNGlgQIxnBwYpnCVU+kw==
X-Received: by 2002:a05:600c:3b9f:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-454a4311ca9mr61058815e9.29.1751541892171;
        Thu, 03 Jul 2025 04:24:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9978c83sm24183675e9.13.2025.07.03.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 04:24:51 -0700 (PDT)
Date: Thu, 3 Jul 2025 07:24:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] vsock: fix `vsock_proto` declaration
Message-ID: <20250703072443-mutt-send-email-mst@kernel.org>
References: <20250703112329.28365-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703112329.28365-1-sgarzare@redhat.com>

On Thu, Jul 03, 2025 at 01:23:29PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> >From commit 634f1a7110b4 ("vsock: support sockmap"), `struct proto
> vsock_proto`, defined in af_vsock.c, is not static anymore, since it's
> used by vsock_bpf.c.
> 
> If CONFIG_BPF_SYSCALL is not defined, `make C=2` will print a warning:
>     $ make O=build C=2 W=1 net/vmw_vsock/
>       ...
>       CC [M]  net/vmw_vsock/af_vsock.o
>       CHECK   ../net/vmw_vsock/af_vsock.c
>     ../net/vmw_vsock/af_vsock.c:123:14: warning: symbol 'vsock_proto' was not declared. Should it be static?
> 
> Declare `vsock_proto` regardless of CONFIG_BPF_SYSCALL, since it's defined
> in af_vsock.c, which is built regardless of CONFIG_BPF_SYSCALL.
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/net/af_vsock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index d56e6e135158..d40e978126e3 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -243,8 +243,8 @@ int __vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  int vsock_dgram_recvmsg(struct socket *sock, struct msghdr *msg,
>  			size_t len, int flags);
>  
> -#ifdef CONFIG_BPF_SYSCALL
>  extern struct proto vsock_proto;
> +#ifdef CONFIG_BPF_SYSCALL
>  int vsock_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
>  void __init vsock_bpf_build_proto(void);
>  #else
> -- 
> 2.50.0


