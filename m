Return-Path: <netdev+bounces-200988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D5AE7A92
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E8162CD1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072FF1DF247;
	Wed, 25 Jun 2025 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehjd1MSk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030728641B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841006; cv=none; b=gFABvH0fBGfOPodyQLulCURuXSiF6VWxWYUE8uYYWu4IoDmuiwl1HI0/NYeJiMZ36Ofa7UMrrXlwN84edD++epdGOKHY3QOKup6zdU0lokC9clNwumm88trTPMAUIrvR3D4zCeK5lxAnEHQGzxFJFeSf1S8+WyTU9Ic22TNVNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841006; c=relaxed/simple;
	bh=BKtDcFi1Di1ki3VEVQwPsdVZaQrBBaEmFv2TZrKgRUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni/8yPW9TZHlXbH8y3RiLEvb13PCi22ULsemLYjtvWFpLNmbx14q+rllgPqqEttVd9weKhysiHnlr4yJm6YHUFQjVJzVaHJdmds+zwrvosxtkOwogjepDU3A2APrbDhOvSUwPNYr3lDEEpHAYz2/n8k39eZcQNIpkSzRXEQqeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ehjd1MSk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750841004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBqo0mSOQ7uYPQmFn/GbeEwpagKUqVWJtoBByFsAo4c=;
	b=Ehjd1MSkvhjTlx03oy4I3RO9VY2YCKhhylowJ8ptvq0lBxVCJKbuFdvQqVIK6NnqnuR00W
	wg07tTR5uX5bnjErS3yia0I85XaymRmpEJ8NDgkLLMZB22WtN9/a9AuJU8Y5TqUZxbR8MX
	uuwDsdYuS8D2LrdvXv6N1964hsQddxM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-fpB32zOePACj8U0Y1zNuOQ-1; Wed, 25 Jun 2025 04:43:22 -0400
X-MC-Unique: fpB32zOePACj8U0Y1zNuOQ-1
X-Mimecast-MFC-AGG-ID: fpB32zOePACj8U0Y1zNuOQ_1750841001
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a56b3dee17so323193f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 01:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750841001; x=1751445801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBqo0mSOQ7uYPQmFn/GbeEwpagKUqVWJtoBByFsAo4c=;
        b=bVHoL+KqNkgBuP78Mc9A5Z0wgI24mbaPQSXplWk+fjQ0HkCdzWUjSyK0xM7tUzNj2w
         rErhKvKw3lZiSsa1qAhTsAikQRBFzd9iHk1062Gst/XS/Q5tG92OwDRB+0tdFf2lACQn
         lDPlcsEXn9apBYa3+6bQk35ojBrxZ8p2CrDiWj5rHpqx8TuRW8Jww7fG8ImLKfjeCwKU
         AO+dRD2nVrWeDzltUamDLVF5qSxJx2XXcWxeWQc7fqK74ov17UAUqHVcx6k6l0VLqVqg
         8/DnNLcCNs65YypKZvGPDvhkKiqvY7CjkgHBLE4ElEVriCVjD1wq/3H4i+UG+4k8Z+CA
         W3ag==
X-Forwarded-Encrypted: i=1; AJvYcCXURl9TZ6KC4GMw1e+5D8QptfwQ/w+aDpWf7KKhNjR2x8tA3anNf0gPTUMYJgSKKHJs/REiaZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3Q2xZEDH7NxZ+vMMcFJlk7aeRXa6Wf3+RrxdVAOz+y3/QIYN
	EZqsn7543Vwf34eiQOOXfpnANr7w7cTBc49OzYZp0QMmWMjod0XxsKDlhThY+rDQJ6Kv03RkcgX
	4oHIp5+4rek2vyEWVYnF6671vA5hoo9OS7/TGXpzZa7h5whQg03I+DpxiIg==
X-Gm-Gg: ASbGncsCXcpdud+7WUKc6onMSUZAcMqMonctgZg2p0LLE+EKpoJQwV2D5521vbqVBez
	g5bWiEG/QZy0kJPcVly/QA+qUbN1Ar6FaNMRrZiWgTKIOrXvAaRQQIUsSXywbOK6cn6WeuNR+ct
	u2qyxVcq/9lYxx7mXoWmizahjfIbPJt1lfZmDaYhUMPxhrtB/v9hIcrHZfBmbqvDkL03LuF+XMr
	7y9WWc6u7JfSp2m6sVBnq13WxQJ0AczQ9y8QLkpso38PLnnRw2SaUtrxEdSALu6lXJ52c6+J4rY
	m8gPv65aVBAL53mZfPmindtCgVGH
X-Received: by 2002:a5d:64e6:0:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a6e71ff6aamr5892462f8f.15.1750841000847;
        Wed, 25 Jun 2025 01:43:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwLmN7pgjPo42yw5pKV9YdU4xug/vMd5HIXDLqwYvt3dwxUtKIILfncsdF1q/xkL+ig67Dmg==
X-Received: by 2002:a5d:64e6:0:b0:3a4:f722:a46b with SMTP id ffacd0b85a97d-3a6e71ff6aamr5892437f8f.15.1750841000364;
        Wed, 25 Jun 2025 01:43:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.151.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45382363f7fsm12918295e9.27.2025.06.25.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 01:43:19 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:43:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>

On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>transport_{g2h,h2g} may become NULL after the NULL check.
>
>Introduce vsock_transport_local_cid() to protect from a potential
>null-ptr-deref.
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_find_cid+0x47/0x90
>Call Trace:
> __vsock_bind+0x4b2/0x720
> vsock_bind+0x90/0xe0
> __sys_bind+0x14d/0x1e0
> __x64_sys_bind+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>Call Trace:
> __x64_sys_ioctl+0x12d/0x190
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>+static u32 vsock_transport_local_cid(const struct vsock_transport **transport)

Why we need double pointer?

>+{
>+	u32 cid = VMADDR_CID_ANY;
>+
>+	mutex_lock(&vsock_register_mutex);
>+	if (*transport)
>+		cid = (*transport)->get_local_cid();
>+	mutex_unlock(&vsock_register_mutex);
>+
>+	return cid;
>+}
>+
> bool vsock_find_cid(unsigned int cid)
> {
>-	if (transport_g2h && cid == transport_g2h->get_local_cid())
>+	if (cid == vsock_transport_local_cid(&transport_g2h))
> 		return true;
>
> 	if (transport_h2g && cid == VMADDR_CID_HOST)
>@@ -2536,18 +2548,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 			       unsigned int cmd, void __user *ptr)
> {
> 	u32 __user *p = ptr;
>-	u32 cid = VMADDR_CID_ANY;
> 	int retval = 0;
>+	u32 cid;
>
> 	switch (cmd) {
> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
> 		/* To be compatible with the VMCI behavior, we prioritize the
> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> 		 */
>-		if (transport_g2h)
>-			cid = transport_g2h->get_local_cid();
>-		else if (transport_h2g)
>-			cid = transport_h2g->get_local_cid();
>+		cid = vsock_transport_local_cid(&transport_g2h);
>+		if (cid == VMADDR_CID_ANY)
>+			cid = vsock_transport_local_cid(&transport_h2g);

I still prefer the old `if ... else if ...`, what is the reason of this
change? I may miss the point.

But overall LGTM!

Thanks,
Stefano

>
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
>
>-- 
>2.49.0
>


