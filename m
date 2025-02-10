Return-Path: <netdev+bounces-164711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CFA2ECBD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 13:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6B8163758
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3E221D88;
	Mon, 10 Feb 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bye8pxLW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDD122333D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191227; cv=none; b=uAFPXLuo9Oxz3wWmQ2cfnfiOFhpdO8ShyL6lPeaAxjN91MdDBvS0T7k+Zn1fadwF3hbesMG9o3Isq6cQkWcnXzxS02Uv5E5IL7ZMn3S/Rsr7fbXRXsbKZU39oOuIqce0arH0lKR63Ep6VilYiNJHT0bp/mfqnvClazma8OVdBVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191227; c=relaxed/simple;
	bh=ZZBZ3akWv+ZpJPt5wUANYxLrBGP46bHYLVbBRCXozmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+CWVevC0R3DAuF4F0jwt1aac1Lh4Q0oS6ZKZG1jHO3CvnFUvN5t32FD2OkbbI2A3Qs8Afus+n4IxFjjBxdYNgJo1VVpVLjltqtHZa+6C/JG+ivaoY5YCbAsAi4qwTDW3jCuWkaTwjxwPro7pG3lW3xMZ5LfNa0Ad9Iaw0nxnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bye8pxLW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739191225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+eh3qOjkAFyaCbqREPJPy1zgrNomisIFnz0D7Yt9Iu8=;
	b=Bye8pxLWHFOdNyiqvqW3NuGmG4yxcml2K9SLBwyADi0ruYywRwrZptRV1AlQtZYLbUNhK0
	LupUwWtzJraOi9P+MrD8IRmXVpiY86e6OccK7bqVeHQuJAV3jZwD9o3RtsS07zGGGTcKZ8
	H626eGdZ48TgTzVlG++pz2LtTbFrceI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-RwxZuqd7Pm2pJSRSlcRyGA-1; Mon, 10 Feb 2025 07:40:23 -0500
X-MC-Unique: RwxZuqd7Pm2pJSRSlcRyGA-1
X-Mimecast-MFC-AGG-ID: RwxZuqd7Pm2pJSRSlcRyGA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-439385b08d1so11725035e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 04:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739191222; x=1739796022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eh3qOjkAFyaCbqREPJPy1zgrNomisIFnz0D7Yt9Iu8=;
        b=hGLeEw4N6A2xsyNWyRAbWJDEsmeBvK97FUK863ENQK5Q1bTaUbEoyAvvH/YszaV6QK
         Le3PosyGF/mQyY79rSWY6+2fJTKUlj1XJbW1L94KnHce+qt/DciI8tjwRyW22xEijPZ0
         FM/+1zej0MMrkUlSyFw/ZtNqtuvcqWXZKoK6AW6htfTSiMyGmH4yRMnTWvjSC1CIsMq5
         PsUE0eBDYSKLhElYKa9GQ7TKn/pZ4HNSUWWcWPkcem6SlI54nrVPpIL11CR7TLIV3sqi
         78CNHir2mlpVxDuTAjm4Q+Sh2tbQbs2E4kti1dxTZ9BqM4OXdukXzRzrk8vfQvGYkTAo
         Ll3g==
X-Forwarded-Encrypted: i=1; AJvYcCXuAMiov26oscm8gox3hgRw18lyvAA4g9uneNqXWLe5Kz8ot9JC0SGLyS3m96SbRbhGkRHhEC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzv2YdXkyJwgkpkUVvZ42HV5YsJJWGxqDAZWWJ1a4/G8dK9a4
	4x8w7GqvKirjXTW9wbft+hfpxvCjSWpoG7bAHDUGSWhgMBBbNkw92pkk4tOocq8K9CLSnPNInf+
	y2XukEfsvFEEftM2xWaOwpjasqezXLYgkaW/H7zamAI+VVvNX0MAVRQ==
X-Gm-Gg: ASbGncuIcffP1mjqkaWGheIAl/Aqt/DNZhRTEu5aWUsx2XIy2nldXhFDV3pdQnaRES+
	o7CyuKJygKmgWO/X51tklXWdA+v+EH30pZg/cYxrlWxhmB+dOjJjcdNnkpM0iwWBRb10AbDkBnx
	F6DqWZR5U75cBhksioXrC7AGr8RHTjeDH+j5p6Ju/0FNjQu1ODihIbhRzcvStysQcUW2j/VaFKz
	0jw2Lc1YMWsGwC7XoJMlX3FXlwIyyNsPBsqP10chYuuxtae0wOdDf7RjGWmXc0OpsyN+CVvWabw
	i0q212RjI57IGc5QPTixPcLnBg17irgRAZkkKsLmXVLPq/h9VlzmIw==
X-Received: by 2002:a5d:64ed:0:b0:38d:d8b2:cf0a with SMTP id ffacd0b85a97d-38dd8b2d311mr5422125f8f.31.1739191222432;
        Mon, 10 Feb 2025 04:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTeSl1RLHLzc450XocagDjMuvY6r3TYDHeMR0TsZO2sNf1Ruyqf4Hle1EyYoKCPOvYojpUPw==
X-Received: by 2002:a5d:64ed:0:b0:38d:d8b2:cf0a with SMTP id ffacd0b85a97d-38dd8b2d311mr5422077f8f.31.1739191221664;
        Mon, 10 Feb 2025 04:40:21 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43936bcc04fsm69817105e9.20.2025.02.10.04.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:40:21 -0800 (PST)
Date: Mon, 10 Feb 2025 13:40:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH net v3 1/2] vsock: Orphan socket after transport release
Message-ID: <fbjf5w5ipezxjh4gbxsqfqw5tktkg56yj6bzhmjgekriug54yn@pcwsqsdvoltz>
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
 <20250210-vsock-linger-nullderef-v3-1-ef6244d02b54@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250210-vsock-linger-nullderef-v3-1-ef6244d02b54@rbox.co>

On Mon, Feb 10, 2025 at 01:15:00PM +0100, Michal Luczaj wrote:
>During socket release, sock_orphan() is called without considering that it
>sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>null pointer dereferenced in virtio_transport_wait_close().
>
>Orphan the socket only after transport release.
>
>Partially reverts the 'Fixes:' commit.
>
>KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> lock_acquire+0x19e/0x500
> _raw_spin_lock_irqsave+0x47/0x70
> add_wait_queue+0x46/0x230
> virtio_transport_release+0x4e7/0x7f0
> __vsock_release+0xfd/0x490
> vsock_release+0x90/0x120
> __sock_release+0xa3/0x250
> sock_close+0x14/0x20
> __fput+0x35e/0xa90
> __x64_sys_close+0x78/0xd0
> do_syscall_64+0x93/0x1b0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Reported-by: syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
>Fixes: fcdd2242c023 ("vsock: Keep the binding until socket destruction")
>Tested-by: Luigi Leonardi <leonardi@redhat.com>
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 075695173648d3a4ecbd04e908130efdbb393b41..53a081d49d28ac1c04e7f8057c8a55e7b73cc131 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -824,13 +824,19 @@ static void __vsock_release(struct sock *sk, int level)
> 	 */
> 	lock_sock_nested(sk, level);
>
>-	sock_orphan(sk);
>+	/* Indicate to vsock_remove_sock() that the socket is being released and
>+	 * can be removed from the bound_table. Unlike transport reassignment
>+	 * case, where the socket must remain bound despite vsock_remove_sock()
>+	 * being called from the transport release() callback.
>+	 */
>+	sock_set_flag(sk, SOCK_DEAD);
>
> 	if (vsk->transport)
> 		vsk->transport->release(vsk);
> 	else if (sock_type_connectible(sk->sk_type))
> 		vsock_remove_sock(vsk);
>
>+	sock_orphan(sk);
> 	sk->sk_shutdown = SHUTDOWN_MASK;
>
> 	skb_queue_purge(&sk->sk_receive_queue);
>
>-- 
>2.48.1
>


