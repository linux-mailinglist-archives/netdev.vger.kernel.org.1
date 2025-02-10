Return-Path: <netdev+bounces-164638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7047FA2E8D1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C1A3A1360
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA1B1C3BF8;
	Mon, 10 Feb 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeBbq3MS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5439189902
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739182568; cv=none; b=dxEeIiMqaA2SbU8qe5r7T0X6yiKb03cD19SjcaqBddWXh2Bp9OX2mJ416cxv1aeD0PxVwrfD0aye7VOrh2XkxHFGCT5XktaCMyekExRZCVhiWav6wV5CFa/gCDIBuna4SUpQgNr687JMWXkURYRyvoGl2R59Uz/+Aj/uonpnpeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739182568; c=relaxed/simple;
	bh=p5WUXwy0MVXPNMhTdeCzdF4yaFQYosHveP/Gs6BTPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V16U0xr9/h2qJyNsM7y64qoLsk6GCKK7mJDA2HvDBwn6OKmX3DME0P8TM0hBZD0H8CYxKLIMBDsP6PWFcVuqE23/c1EJqGt3yAzxC2cNcvWHBZhHDSBapvKA2zBGZ44yhPWxilQu2XUSePn6NRgRL5XZTX/qVgE9epoplbVjrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeBbq3MS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739182562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9sJEC/icQo18bVFXRpigQVdBJdFsITaqQvJCE/XAEo=;
	b=eeBbq3MSyxLWqXEy+MT0HCQW3qY1CbsdgvzxlVErxf2otuocUCoxrJk6TvM0fgfVwGohAn
	CT6fiQ4q+6GtRWlqUoynzGq9uU458Gcxxn4QW4wXJM6h/GYtC7dXhZB6u6ON+dQXFvHO7J
	SY27l7cXIbJxWBB7eBZU2uJ0o5WXLJU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-El8R0Nv4MhWPjP9UjxMAfw-1; Mon, 10 Feb 2025 05:15:57 -0500
X-MC-Unique: El8R0Nv4MhWPjP9UjxMAfw-1
X-Mimecast-MFC-AGG-ID: El8R0Nv4MhWPjP9UjxMAfw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947979ce8so2505105e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739182556; x=1739787356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9sJEC/icQo18bVFXRpigQVdBJdFsITaqQvJCE/XAEo=;
        b=mIe3FW3VGK6L5EjGqR3vWcDYdafzMq8I7657quDAyFwt7FZgS56EePzh+f4ks3mg8g
         259iQOIG43K0HW+FA1Of6JHy+LAPyRIkvgjg1GIdOT7qNzDaXM6Gq9bKckusGRNS7JF9
         2EnrLTlgEw9RZcVdQWacEewiAj9FrNMpQf3lEe2LYDfbabP6/zIjqnZXt+pUkJnNcsvY
         mDXP7dgRL83gt1P2xqYk8AFHZSZrnnAhHKxKg3GVvw1fC6Cnxg0QVlp2U367PFiTPdrF
         ldAS+SpwxJwo3+RK4d8D2clI61aC4VVyBZmGbCGlzssMTkqvDvB5RNnjkClTHNWpLCIC
         NQVw==
X-Forwarded-Encrypted: i=1; AJvYcCUiLx2eVa0UwRnfW8vH5MBfPKxmDICWhqj3ORJnC2t69PRvr8WTM23rD/6DPE21y+cFAuMWA0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0FrXSDLlzjTCVLezwSFJ7mBAJCUAZbAtcRIRqwvm8urX9qy0
	6p5Bx+PGOw6sY99u6kL/Hje2p6z7bmfxqd2hOQLn0psI/NXbClcnq21fp9SkrKNUHAlvK7hEiHE
	n0ZIKWjWDPaGvcmOL1oc63QkPWGsOh4uglDXnOOHo6xcL3qOm+8tqbw==
X-Gm-Gg: ASbGncumzjoJko5prmaESSDQHbBrhQS8EEBtYxD7HoEJ9wtf9w0+Z4LNRhRmnTVccf6
	Dg3oAbeoUrd337wI5ItcIWDLu1e8bqpWUuY4FvJub8kwPi6zJ+YO0UB1sPX2JiMzhfj6OGv+0fq
	6PyHDK22TNLkF1xQGZEmqmSxmkGcksO9XqKISsrP2+aoVbCHtbDckZV1wGG8vTRJm+xYSkR67YK
	SyagtwXQhrTFcV1zOnHIikKSxFCYA876wm6towj3p5n18D6CaRUAQpDtwX5eCBw9cnSR5sZ8R/R
	1Opo6+f4LKMIqkDeGtGLgpT2xrM2DTFRtwFZSjuxN3SQpaAFMgPyhQ==
X-Received: by 2002:a05:600c:35cb:b0:434:f917:2b11 with SMTP id 5b1f17b1804b1-439249b2b99mr83682265e9.21.1739182555832;
        Mon, 10 Feb 2025 02:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzyHmFxq9APlvZ5/KjMZW8FMS6DvOra/FJmHwifoO1Pq3YL3SAL/TwgqtRqswE/KetCkJU4A==
X-Received: by 2002:a05:600c:35cb:b0:434:f917:2b11 with SMTP id 5b1f17b1804b1-439249b2b99mr83681645e9.21.1739182554738;
        Mon, 10 Feb 2025 02:15:54 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4480sm175997295e9.27.2025.02.10.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:15:54 -0800 (PST)
Date: Mon, 10 Feb 2025 11:15:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, Luigi Leonardi <leonardi@redhat.com>
Subject: Re: [PATCH net v2 1/2] vsock: Orphan socket after transport release
Message-ID: <zboo362son7nvmvoigmcj2v23gdcdpb364sxqzo5xndxuqqnmy@27cgbg6bxte2>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
 <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>

On Thu, Feb 06, 2025 at 12:06:47AM +0100, Michal Luczaj wrote:
>During socket release, sock_orphan() is called without considering that it
>sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>null pointer dereferenced in virtio_transport_wait_close().
>
>Orphan the socket only after transport release.
>
>While there, reflow the other comment.
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
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 075695173648d3a4ecbd04e908130efdbb393b41..85d20891b771a25b8172a163983054a2557f98c1 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -817,20 +817,25 @@ static void __vsock_release(struct sock *sk, int level)
> 	vsk = vsock_sk(sk);
> 	pending = NULL;	/* Compiler warning. */
>
>-	/* When "level" is SINGLE_DEPTH_NESTING, use the nested
>-	 * version to avoid the warning "possible recursive locking
>-	 * detected". When "level" is 0, lock_sock_nested(sk, level)
>-	 * is the same as lock_sock(sk).
>+	/* When "level" is SINGLE_DEPTH_NESTING, use the nested version to avoid
>+	 * the warning "possible recursive locking detected". When "level" is 0,
>+	 * lock_sock_nested(sk, level) is the same as lock_sock(sk).

This comment is formatted “weird” because recently in commit
135ffc7becc8 ("bpf, vsock: Invoke proto::close on close()") we reduced
the indentation without touching the comment.

Since this is a fix we may have to backport into stable branches without
that commit, I would avoid touching it to avoid unnecessary conflicts.

The rest LGTM!

Thanks for the quick fix and sorry for the late reply but FOSDEM-flu
caught me.

Thanks,
Stefano

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


