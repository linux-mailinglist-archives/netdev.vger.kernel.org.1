Return-Path: <netdev+bounces-199687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B1AE167C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AAA4A66F4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F42571B4;
	Fri, 20 Jun 2025 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOlcKu65"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347C2367B6
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408684; cv=none; b=NfKXN/fSh2EpkcaGFex1rWMcZobDIpgygt9gHAn7QTZrkAc97tz+zJk97ytvIhwfcFqrb8dsISC3UgquQAARfM5Pmwp53b4bu4duYFouSa5Z8CXrPYxDOn0sNsJlIeX5wHwoWfGPvyM8ffusObCTcaDbQiAMySviJuq5RIKEnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408684; c=relaxed/simple;
	bh=/X0onNxIoHCituHUtODJAVeY5Sgv6GC2RODQR2Tb0Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4eMOYBINW4sMCOdjnJMmFTKNziXTrpTI1lFk+9Qh6Y46YsGrYh1Jx06B06agSnBElHVqMj6tb4VdSw1Qo1yvIzEqipVkWn2QmS3FPfRTAh53Z+SnZgdntVakuxTQkB3dxlMJaQAHpQGsRcg2sjbhTixhXlZ35Ja2aqpi5TgGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOlcKu65; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750408681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eog4yVEfqOklks2EjdMhzqPgmpWjhS9NGkes1JaQ9/0=;
	b=GOlcKu65tVg2Jo5VKaFuuvR8RsqaiDZA5o4wBoqNw/fOiDX7C72H5aF57RJERTilRfTQL2
	HjV00rs2b8n08+MaJqwe+K6j4MJUi2EPtquEcRp8fKhw25DChjk9CtY9W2qyh7+qE6gSFH
	pmpRDT3nUqiH/Tt8MdairueIshu7bKM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-cg43MKziN1-ZeE-TKrv-Vw-1; Fri, 20 Jun 2025 04:38:00 -0400
X-MC-Unique: cg43MKziN1-ZeE-TKrv-Vw-1
X-Mimecast-MFC-AGG-ID: cg43MKziN1-ZeE-TKrv-Vw_1750408679
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb3487d422so23857806d6.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 01:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408679; x=1751013479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eog4yVEfqOklks2EjdMhzqPgmpWjhS9NGkes1JaQ9/0=;
        b=oeeHX9m5h1OQHKJN7qtv8xv3C0ZNx7ifsXZA9LG6dI3Yy3fPK6URXVWCouFJveMHAS
         5ur/Bog+GVIgJ+9Nuj3BH3wiBfpkB4V/G+Gm4He7cserYelYNQEvXvQyL88w9CcqFSqM
         G+GSuBo9OO1jJywrle1uNFFScusejwbJRlLwAAFNSBOFNWEY6aQCy8XG/5YoZRimgOZS
         rhKBGea41tZTxEo/vT/llRwDN4uuGTg7nOW+d6ps3p1hURPxpgjgEc9YF6fahPhLn1oi
         1rXlRg0u4CGZlq9FEyggTV+9LqrLkcdxuBTHeNJZLSLxYicruzAh/n82jD1FdAdzgrhd
         dUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoHceKmQMx6C3GVxP7oRx+zOPZIpunfy8QBBabb4vdwm9yv3y/ZU6VTuq0Ki730L1cykdSQlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGRGj5zvDwfcVLvVLX9bLP2K/nWCsSdf2gL/R6t/QlzS7HJE2
	nv4YBU7R3J8sd+OMngyaKtof5oEQHQxlao/93LqQHnhD0IxC7BfRSrwx24Pzd8TMKwax8T9LjIR
	14ZDdQdrnWNaZYpmaaD9ZZGrwJeq+h8wVv240Gxvia8sYyO9B8qZfhavrJA==
X-Gm-Gg: ASbGnct2Nwzpsot9jOcwysQDqI1GP5Ksc4SAbkQO094sYXfL4wkYLwv0MPWBV3CugBs
	6cpJY69aI73ZHVfXddaEtD1UCDY1XZcF+AGvorVYbiHRrR1QXMC0PuynXJbfXzMN0i85j8m9L2e
	RTtqmM1VnLY4TEU/2c3fuINj1Ur7iM5gqO8Lxs9pVxRc0VhsxAojabzviowzhZAMOSNzPCMnU1a
	QSPYMh+OOljMZ9q02Hu7LsZxDvbFYjxZMD+Wpe+YuhjnP2XkOrYBOuqy93qr4w8YFX3ay8s8leD
	soiMhyeH4UI66pI7lCo2QVSHQ8mH
X-Received: by 2002:a05:6214:21ef:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6fd0a5bb050mr37553606d6.32.1750408679568;
        Fri, 20 Jun 2025 01:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmA3h6ErxX85wD5sSfG+Vzbb3PR/XLuB7HFc0jjVgeWIZox/+0PegblvBekonQcxrwvk7ztQ==
X-Received: by 2002:a05:6214:21ef:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6fd0a5bb050mr37553336d6.32.1750408679168;
        Fri, 20 Jun 2025 01:37:59 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.182.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0957f69bsm9353816d6.96.2025.06.20.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:37:58 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:37:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] vsock: Fix transport_* TOCTOU
Message-ID: <qvdeycblu6lsk7me77wsgoi3b5fyspz4gnrvl3m5lrqobveqwv@fhuhssggsxtk>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-3-dd2d2ede9052@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250618-vsock-transports-toctou-v1-3-dd2d2ede9052@rbox.co>

On Wed, Jun 18, 2025 at 02:34:02PM +0200, Michal Luczaj wrote:
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
> net/vmw_vsock/af_vsock.c | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 337540efc237c8bc482a6730948fc773c00854f1..133d7c8d2231e5c2e5e6a697de3b104fe05d8020 100644
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
>+		goto unlock;
> 	}
>
> 	if (vsk->transport) {
>-		if (vsk->transport == new_transport)
>-			return 0;
>+		if (vsk->transport == new_transport) {
>+			ret = 0;
>+			goto unlock;
>+		}
>
> 		/* transport->release() must be called with sock lock acquired.
> 		 * This path can only be taken during vsock_connect(), where we
>@@ -508,8 +515,12 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	/* We increase the module refcnt to prevent the transport unloading
> 	 * while there are open sockets assigned to it.
> 	 */
>-	if (!new_transport || !try_module_get(new_transport->module))
>-		return -ENODEV;
>+	if (!new_transport || !try_module_get(new_transport->module)) {
>+		ret = -ENODEV;
>+		goto unlock;
>+	}
>+

I'd add a comment here to explain that we can release it since we
successfully increased the `new_transport` refcnt.

>+	mutex_unlock(&vsock_register_mutex);
>
> 	if (sk->sk_type == SOCK_SEQPACKET) {
> 		if (!new_transport->seqpacket_allow ||
>@@ -528,6 +539,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	vsk->transport = new_transport;
>
> 	return 0;
>+unlock:

I'd call it `err:` so it's clear is the error path.

Thanks,
Stefano

>+	mutex_unlock(&vsock_register_mutex);
>+	return ret;
> }
> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>
>
>-- 
>2.49.0
>


