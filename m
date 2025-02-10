Return-Path: <netdev+bounces-164643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0010A2E95D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678E83A81D1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D011CC8AE;
	Mon, 10 Feb 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtLAFpRj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A251CAA8D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183091; cv=none; b=hYBsRtGP5DIwRmdd5pdxhNXFowt4j1xT1vwQ33s76oYzzfS2eKmYNV0Codxw2h7vTLxKkCG7GXYetsp6AImhmPgiTjg+f2cEECBAxRRu3FVjAJj7DYTrMELR0SJ+kbLqFe+/Z4EI8V6TK2Vf5TVQ12OAEU/Z6vKfCY7G2VshjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183091; c=relaxed/simple;
	bh=MC6GhJjaeY2C5xOw4+/XFqy9lcuzxj0JI0v1ZaAyp+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGbsj+8Urj29Q4OW9CIB7iHVgr+HdOHRcImLktNl5peivcjDmKYvHS7+hAgdKZOBXPmLo9+ZMtx5nM/bP68jcUtwtbRQF7LJ28XGocGD9ipOGGtJlcKElMOhdx6LG8cFH0LEifwYiG+shu1IlqRr8tdvkQia+LkPnov7saC787g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtLAFpRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739183088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KGQIWELu/U5AoSIa7ITCHff9VGrc0oPYfYC1ThoBsPk=;
	b=CtLAFpRjysj1iKM1a4uZ6FRCUBAUEjuMaGEASFP4oRDz9W1ZWm/6NSdhasaoVAPdlN1dt+
	SgOoyvjHB0tMphM2EpQ1L2OJLn4FzCyCeGsD3JaNPLEvI7t0Iy30NZGhyN4Qll7oQQiubZ
	fwR0dHTXV74rH/scHmh4CcXktI3e0qA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-SZF9jsajMaeA79aL22U_uQ-1; Mon, 10 Feb 2025 05:24:46 -0500
X-MC-Unique: SZF9jsajMaeA79aL22U_uQ-1
X-Mimecast-MFC-AGG-ID: SZF9jsajMaeA79aL22U_uQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dcb65c717so652539f8f.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739183085; x=1739787885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGQIWELu/U5AoSIa7ITCHff9VGrc0oPYfYC1ThoBsPk=;
        b=wEUPYvdLfDzghw/3W7py4HkPNTR0uv8V9p704XT1jXiMFlsCHjFH73TF2cHtTFvQ3l
         T0QjNJi2o4xD1bCwbal/4Oc9aCtGq8lNcAPKihlj5p0CywkALnJoXvpO9KSUZV0B+P8r
         8WiqyYHkhiQ2GyFQZkrR5sxXcMXhCZDhIlMqZ9j+eyDIRx3wfVGEgZQBTYAEkeffSfJL
         8xn3SWhA9EEZ7fUfFUr9GPl5QITMAnHyUbkX6Yi1yxO4Qurjvi4HxH37BUBrbncOGbXI
         MeiIMPawd2hAGghHlbdn2czDMpDP5bf1/YtyWtDx9CIEzG2oz9lE630uOQ3MXYNqOO5A
         ZOpw==
X-Forwarded-Encrypted: i=1; AJvYcCVBTBnjjE/bxBeqGih0SqQtCr3uov40pzK6pqTYFqjygxwBtkBY9pJ0B3T40j4k66YuZH//zag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDolLNu2LZbOEsorq3znWzY2ghwYs4/tn7lcOsb6u1qwGQNrcc
	PJ6mVu31rcwWG1KgrS6LqdgKxKBBqYeqfKbGoekM439NqsmCrNG7ksAkqDabWxNOgXIuCIqtSId
	kt/XITo0AvPBIoH/LvSNJLYpfpANSiYNeB7yGSDW5fIsWsz/Xt1Engg==
X-Gm-Gg: ASbGncuFm0jtDKMW0KHXlXpLFmjQT2zkdAHt4YGy6fZh2i4+YxJuq4RPAHiWmlbyZMe
	VIj4KH/ZCsOSNLByTZiPLIY/oSi5xRvkh/iROdATP1DyPaUh3XjEKZuUWuRwlQA1e51XCbDFDut
	MePXfmU2jZvTSVheVrIO+mWvx2YSnxGSnQjaKR82Kdb5fQQScgz0Aq5sf+zAlxDPimWoQnYqacH
	Ov9xeAwJZo/BaoL1VWNe9W5gKYxZs+QyBWfGMN5cNiCJprX8/hn793xzcsAOq1IvdzjHae1YtIn
	UdlwvZmo
X-Received: by 2002:a5d:5f8f:0:b0:38b:dc3d:e4be with SMTP id ffacd0b85a97d-38dc949201fmr10938004f8f.51.1739183085506;
        Mon, 10 Feb 2025 02:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA4RTNVmX33K3IY4yT7AA2VCL6orUHF3zZA1G3EONeJl4Q/TRSP0DLiiI0HLoJ7mpF9ux++w==
X-Received: by 2002:a5d:5f8f:0:b0:38b:dc3d:e4be with SMTP id ffacd0b85a97d-38dc949201fmr10937960f8f.51.1739183084906;
        Mon, 10 Feb 2025 02:24:44 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc627fecesm10223798f8f.77.2025.02.10.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:24:44 -0800 (PST)
Date: Mon, 10 Feb 2025 11:24:42 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 1/2] vsock: Orphan socket after transport release
Message-ID: <3h4ju6opsomkttmppwvugofepnecqegdb52tsq7n5c5zrvan22@echiriqwccz7>
References: <20250206-vsock-linger-nullderef-v2-0-f8a1f19146f8@rbox.co>
 <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250206-vsock-linger-nullderef-v2-1-f8a1f19146f8@rbox.co>

Hi Michal,

On Thu, Feb 06, 2025 at 12:06:47AM +0100, Michal Luczaj wrote:
>During socket release, sock_orphan() is called without considering that it
>sets sk->sk_wq to NULL. Later, if SO_LINGER is enabled, this leads to a
>null pointer dereferenced in virtio_transport_wait_close().
>
>Orphan the socket only after transport release.
>
>While there, reflow the other comment.
May I ask you why?
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

Code LGTM!

I probably wouldn't have changed that comment because of possible 
conflicts.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thank you,
Luigi


