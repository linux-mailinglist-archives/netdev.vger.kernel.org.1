Return-Path: <netdev+bounces-203702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16308AF6CAC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EEA1C222B8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814A2D0274;
	Thu,  3 Jul 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka3iuYWZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AEB1D9694
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530827; cv=none; b=mtxqShKaQ9wMv7oIvrM1vxjoZJVcc8mumN8YQDRftJPfcCM1jWgyVfpD9yeT5Lre0iSDvwSyO6DdVt3eFUK4DsEvT2S6fe5VrU70rXHyrivYAkoMGoVqqE78kVfHkCORNC0s8dvmKeLjN1ltX0unS+AR8qcPduIwTmGaDxangtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530827; c=relaxed/simple;
	bh=5PJIzBhJKZAUVsz2r3kI83D6I2kEvYb35khFWlCgkg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+Tsh699HEnmUwKaEfQ+n4y+OKsPGa+q2A/srjGwdN156qQWrTtqHFbtCvp3MWeb2Las785pVzjELguXBIdOW4QQnQ0rvBN5HozI3iXnKYe5pp626Eyb/Ul823dmUs4e1NGIpHIoJ3C27E/Qnu2qlkUiC30Z0LHREB+0ZLn1i0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka3iuYWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751530825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PgfK0MiivLIcqaxzsWTOFNAQYQqm2mXnsaXnPmi5A+g=;
	b=Ka3iuYWZjwRUsMeNiqrK7wO3hnWG4yukMhANdWDB2rp1VOEs12Cphw+GxKetq6QzKwEJow
	HNrDv5FK2BUWtAHUGeoTHu7TEjTdrrOmTn77lfO3qNSjLQgl998mc5YL3WvqdEv+PyDjbV
	NW5sli2uuuUFYgVQDGgp1i0tbvSKqp4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-9nv0ksSyOoSYGSYG3SmIXQ-1; Thu, 03 Jul 2025 04:20:24 -0400
X-MC-Unique: 9nv0ksSyOoSYGSYG3SmIXQ-1
X-Mimecast-MFC-AGG-ID: 9nv0ksSyOoSYGSYG3SmIXQ_1751530823
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453a190819bso30376185e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530823; x=1752135623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgfK0MiivLIcqaxzsWTOFNAQYQqm2mXnsaXnPmi5A+g=;
        b=DDvKolDRMEct3VV6H6XTXVIOXPCQACm1wIIntvELxdrd3OKo7Tcy9Hm6M70g7eAG2E
         I3Kkt3gG4wOAG0nM75NzuRp8xP1eQfSGAxtRno+roCrWD6KR9+YvHUYB+g4Io52n/8kM
         BZnUUbzBGS3rq04GnAFRlLsOBl+k/PYsisduwSKD4t00IEwf2mLvz66FO6evzrGzN07+
         duvqmAFEbyGlxkHKjBHm4V6gYAyFEShF0OUx8x1sWABijsjeEW1bxYeQ9x9rvKokwHKU
         /xMyZdMBBWaaughP/1CloQT3dWOlILN49HLOnnQ8QQ1uituWPq3+vCtS9dnx9Jq/yQ/t
         qCIA==
X-Forwarded-Encrypted: i=1; AJvYcCVTB46xiGSYmTQYSF4lwdAJZ7r3rIK453PKSg35N6qo+otGAC74QgMgQa3hQKibBc/cjbsBpq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweU6gC7NSWbDW1Ew3yf6Mg8LfOSDuna1l6hfUMNQTbhEe0wycD
	n7v95q27x2ygomKZTwwIEKVviGvgaE7I7M8JyrNq9nKVBQ+YOmkX66JZcDFl4QegCntLd3z5/w9
	C6LTsMXC3nUfS1Fp3BikvR9mKe02g/aZo9KJJTRvOXj/PpZ1ybNByTBF4XA==
X-Gm-Gg: ASbGncsMbuFkC+hV7bv+gpgCzgB1uQSrkEge+2KlXT9gZlc49QX5SIIudthOIoo3EVl
	MVPNUcA1X6CzF5y0sjP2OcZfshtM/j6in1E4N4O5reXjQ+FLNwPEQ62Vnq0pU4d3KEaXRZ5I9Bi
	citz5ZChFRagoo+IHoQlboFkVU5K0ie/05s7woR+BacK094Kupnifd4fReKWD5idsy6t2wFKOg6
	X7YAKqKqILs3Q/lsWZhRgOWFHvydTs722WHQbpsc7UVIXCJYbJ3wKvxfevygge486WSeDkZ6NmG
	e7FiwocDaY69bC91uDGVJT1fOgA=
X-Received: by 2002:a05:600c:548e:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-454acdecf4cmr12821485e9.15.1751530822626;
        Thu, 03 Jul 2025 01:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOrUfpUNiIuQYIchc6nRH2gLgD7pUNLwLBaAp2Du7pJA/QiHS2M+US3/T3JQKKd1t8cLhjKQ==
X-Received: by 2002:a05:600c:548e:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-454acdecf4cmr12820865e9.15.1751530821910;
        Thu, 03 Jul 2025 01:20:21 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5963csm17999165f8f.79.2025.07.03.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:20:21 -0700 (PDT)
Date: Thu, 3 Jul 2025 10:20:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock: Fix transport_* TOCTOU
Message-ID: <u36jztpit63o2b33ulnmax2xrw2c6hgrkwabto3fccocdmay7w@xlpkemxcgve4>
References: <20250702-vsock-transports-toctou-v3-0-0a7e2e692987@rbox.co>
 <20250702-vsock-transports-toctou-v3-2-0a7e2e692987@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250702-vsock-transports-toctou-v3-2-0a7e2e692987@rbox.co>

On Wed, Jul 02, 2025 at 03:38:44PM +0200, Michal Luczaj wrote:
>Transport assignment may race with module unload. Protect new_transport
>from becoming a stale pointer.
>
>This also takes care of an insecure call in vsock_use_local_transport();
>add a lockdep assert.
>
>BUG: unable to handle page fault for address: fffffbfff8056000
>Oops: Oops: 0000 [#1] SMP KASAN
>RIP: 0010:vsock_assign_transport+0x366/0x600
>Call Trace:
> vsock_connect+0x59c/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 39473b9e0829f240045262aef00cbae82a425dcc..9b2af5c63f7c2ae575c160415bd77208a3980835 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>
> static bool vsock_use_local_transport(unsigned int remote_cid)
> {
>+	lockdep_assert_held(&vsock_register_mutex);
>+
> 	if (!transport_local)
> 		return false;
>
>@@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	remote_flags = vsk->remote_addr.svm_flags;
>
>+	mutex_lock(&vsock_register_mutex);
>+
> 	switch (sk->sk_type) {
> 	case SOCK_DGRAM:
> 		new_transport = transport_dgram;
>@@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			new_transport = transport_h2g;
> 		break;
> 	default:
>-		return -ESOCKTNOSUPPORT;
>+		ret = -ESOCKTNOSUPPORT;
>+		goto err;
> 	}
>
> 	if (vsk->transport) {
>-		if (vsk->transport == new_transport)
>-			return 0;
>+		if (vsk->transport == new_transport) {
>+			ret = 0;
>+			goto err;
>+		}
>
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
>@@ -508,8 +515,16 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	/* We increase the module refcnt to prevent the transport unloading
> 	 * while there are open sockets assigned to it.
> 	 */
>-	if (!new_transport || !try_module_get(new_transport->module))
>-		return -ENODEV;
>+	if (!new_transport || !try_module_get(new_transport->module)) {
>+		ret = -ENODEV;
>+		goto err;
>+	}
>+
>+	/* It's safe to release the mutex after a successful try_module_get().
>+	 * Whichever transport `new_transport` points at, it won't go await

Little typo, s/await/away

Up to you to resend or not. My R-b stay for both cases.

Thanks,
Stefano

>+	 * until the last module_put() below or in vsock_deassign_transport().
>+	 */
>+	mutex_unlock(&vsock_register_mutex);
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>@@ -528,6 +543,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	vsk->transport = new_transport;
>
> 	return 0;
>+err:
>+	mutex_unlock(&vsock_register_mutex);
>+	return ret;
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>
>-- 
>2.49.0
>


