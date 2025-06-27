Return-Path: <netdev+bounces-201787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54CAEB0F8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F21172CF1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06923AE84;
	Fri, 27 Jun 2025 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLYDaLQL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64723A563
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011740; cv=none; b=H/ayzMJc5Qp4wCPDYJgqdFYUbn8K41R6XSv8kTqfxHpURSiR+iG9RQKm7Hn6exapB73Gn37dwDSKFsIVFgV7wIHgsfJLzs6h57qWCacYDdzM+drLlxJjEuGpgKqBfphssYZKrr1BCrnbe4GNrBQu+cE9wwvKB3SA0r2HDFF5NKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011740; c=relaxed/simple;
	bh=4atm7a3aa7XLLdZNBlU0QoQBXv7fksZDQmZpN4oS3ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdmiHDCoODB7ZsFdL2cZx80xUEBkaIcL3ds9HILRLoy+QOOKaJhTj3fqfUhR1XdscdThBNiLzBVSN9i9GUV4cAh5Gsjf0kLRFWA7hL1BljK8zYXOdJHfp3JQxtRi9XAwPSV+dCDuJdCaKNZZv6UI1iFl19+pDPycqLJW7RbUlVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLYDaLQL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751011737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1zTV14SPJKhyzAQ+CnMR/zcHPupL9X+uwgLCPBgwIs=;
	b=ZLYDaLQLvljrIUIZxVPaVq8JzNnpcdErqImpcRKAdAWOMf8gK668FOo8Z/w3NgKKsVmNbO
	Uicmo0abJ2d1lAfUip+enLPE66W46yTJazDmeQwLAhf1XuoZ/ToC/wgutG8WUm84QAcH6v
	detpEWTIEW9S55YxHzkBHKrCc8X2dgA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-RjX82uq9NwOYNJ8n4qRQqw-1; Fri, 27 Jun 2025 04:08:55 -0400
X-MC-Unique: RjX82uq9NwOYNJ8n4qRQqw-1
X-Mimecast-MFC-AGG-ID: RjX82uq9NwOYNJ8n4qRQqw_1751011735
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3184712fd8so1474993a12.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 01:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011734; x=1751616534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1zTV14SPJKhyzAQ+CnMR/zcHPupL9X+uwgLCPBgwIs=;
        b=L3Z24NOtlR0Fdllx00ewunaBa6FLcuXsxtdSU7iP214Geot+igNE/l80NGwRfHZx5K
         ebH/5A8FuIIfoyAgcV+zWYjxq6jYAKs1+mg7P7iHFvG6depmcSrxEfHpTua+n0NXKgjs
         hf8cObvcRnCVb99a1Rr+N4qPOrx7zpB7eFYMFE3fmIdAxEDnR5g3cFqh5vm/N9KIWwMg
         BPnX7aUF4oIGwd0CUANcxDqUpnJ1U4Pdsw46pq8BOYqehvaAmSIzEjtxrnV0vIgrtn66
         iS0jHxIXih6M/GCQabV+DSMCgHJbCyVxxRGAFeZj5lT+TaWmBlPGVxsq2AIFHlYzgYi7
         28vg==
X-Forwarded-Encrypted: i=1; AJvYcCVT+FekBg8/2lBgyJpFwXktDUtIk3rcZd61R9jEjO7bzZFLJsCGqCd8pR5GU3mzDYuuqbyaLnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOy7MPje/WfVJQBMYTq7h+JxZC7uJZ4AjzpYXq49PBFi6x4oB
	rT8PGwlCnutu5AgaQNGaKCRpqZ8wj44bjidbE5z1p8wl/FHCB0DkjMRIiPFHAD/7NdS7aX9uyd5
	o2HZYbJZ+OG1wRmXfpSuPFWbeFoCnkwOE/sP9f7RnufSv+k9CXeYXTDSFh5UQUD2Aww==
X-Gm-Gg: ASbGncvotm7TE2fH9equ4HO7t42LlOrwruxQklaGNY+Jw5nEqKAQiOWiZoJFXX37K1d
	FmznlGZAzJPBQ+hU+A5czZYe7Tdd7HRXSmfKpPMmOgcRN20VtQYHkw+z6ENKE0p7AqOvLOh+wJw
	mzBMjg/ZH6PV6Af0W2LXflBPp0PY2g0izJ19/e0tjEcANnL2hwZ1CclBIoU2dyYbD0crrSB/EXV
	m5yLnF9KChiWo2m2XtykiLTpGIP7q44i02NMN728W3wa7LmiIUwD0OU7wFbG8luQvFLfknAhyJ4
	RNx5C9UarNzvqJ8QcxhtA21oPmY=
X-Received: by 2002:a05:6a21:4606:b0:1f5:7280:1cf2 with SMTP id adf61e73a8af0-220a12dcb62mr3298239637.12.1751011734524;
        Fri, 27 Jun 2025 01:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr/5FfyhGN+rz6LQcfj5dGER/OaxguGxdnRTL3rMKPiYqAnq1lmuYeWjQctcVkptzzUcr5EQ==
X-Received: by 2002:a05:6a21:4606:b0:1f5:7280:1cf2 with SMTP id adf61e73a8af0-220a12dcb62mr3298206637.12.1751011734091;
        Fri, 27 Jun 2025 01:08:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541bd1fsm1597968b3a.47.2025.06.27.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:08:53 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:08:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 2/3] vsock: Fix transport_* TOCTOU
Message-ID: <l6yqfwqjzygrs74shfsiptexwqydw3ts2eiuet2te3b7sseelo@ygussce5st4h>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>

On Fri, Jun 20, 2025 at 09:52:44PM +0200, Michal Luczaj wrote:
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
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 63a920af5bfe6960306a3e5eeae0cbf30648985e..a1b1073a2c89f865fcdb58b38d8e7feffcf1544f 100644
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

		/* transport->release() must be called with sock lock acquired.
		 * This path can only be taken during vsock_connect(), where we
		 * have already held the sock lock. In the other cases, this
		 * function is called on a new socket which is not assigned to
		 * any transport.
		 */
		vsk->transport->release(vsk);
		vsock_deassign_transport(vsk);

Thinking back to this patch, could there be a deadlock between call
vsock_deassign_transport(), which call module_put(), now with the
`vsock_register_mutex` held, and the call to vsock_core_unregister()
usually made by modules in the exit function?

Thanks,
Stefano

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


