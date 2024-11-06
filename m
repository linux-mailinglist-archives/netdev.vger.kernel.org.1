Return-Path: <netdev+bounces-142307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491759BE2E2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D94F28415A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AA41DA634;
	Wed,  6 Nov 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcu/GOfH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629C1D9A63
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886127; cv=none; b=LlpEqt+3h7tnd5S47kEUhS/kU75C6FYkvn9+W1ZOwNU9fwZIz7nArUt+mReUUV0L88Tyxww3Psl+TzXZJLIZVE3JBqCTZBMfW/cIVySdKJDAV7mOqGRjzbcOwMzI5g4wkum29tn4D+/i8UuKje7FCI3R+pvW4YHKae58Eup7wY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886127; c=relaxed/simple;
	bh=Bvl36VOmpCQxv3IEs3k+665K4+jeHl2Dl/E6Fh3bEOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le2LMdo75V0lOpkDRTdHGXjDSVBbFbF7huUl44ukUB39a8ZZGjkKKx4IV20nDGe5PfZ5xkERdFfW8s/faXljiJOW+7fb0BlmzrvSGtsr7MiHHAjo2F3pMzVfkbtVoc8r5aU4ATRgMzIyDkFnWcljUYRfIcLYeFW+1st+aWSFLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcu/GOfH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/m2B5XkqveJBUmDhsVEUtZ9/8cFuA0F3GzIlGJUsU0=;
	b=fcu/GOfHpQhmeZBuOKw3zZN2NAobpfXDkXrjEmo2ljBLtplE8JayMw0jA4DX4Yj5kJIcLt
	HH41UevS3q31LhFYxgOEbGLY3s4pp/LwTsSE0ErYW6B7/nasU/9qHs8Xo/cOHASxEQUfny
	gj9BGwOYP6J6MKhyib5+qbLKFsPVHWg=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-WkXq5OI7Pv6adhwmD1sExA-1; Wed, 06 Nov 2024 04:42:02 -0500
X-MC-Unique: WkXq5OI7Pv6adhwmD1sExA-1
X-Mimecast-MFC-AGG-ID: WkXq5OI7Pv6adhwmD1sExA
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-84ffb72a4ffso1339699241.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886121; x=1731490921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/m2B5XkqveJBUmDhsVEUtZ9/8cFuA0F3GzIlGJUsU0=;
        b=pYQAko7Y5vDBAr6rMiBBrs+W98HNOJkQaB0QAUjLY9rXkB4mTQFbxfwV8+O7s2+jEm
         0aKtAuumHxzNS743wG8cSvAFNw/qekhWIBY6f5XUuRDr64qa0QXUX87UN0OKpwplYica
         KLpXc09cBZ/6b4i6eE+L6oHq1GkgeijfXWyUFLqDwP473S614kvMfTvMD20QWU5gWihT
         oeYA99x/RONJroZJQMaZZUAQ1Yo0RRpHvSFUyIFjOpbD240Q6Kl1ko9Fc4DmvIqCOXbZ
         GrVtKPGjFU+yZy2uBKYcKMoOrK14vVbODB/nYmJW/uxTyplBKI0luZBTsfS5lwCXVYbW
         PVtg==
X-Forwarded-Encrypted: i=1; AJvYcCXNcPIH2B7JogMg1o+KHF827G7wDtMQppQdAufnCBa9v47ZgpFKhWUZeNKf7TtQeJAt/X2ioZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8n/Wn2XthR8BfUTcUdFHApMZQTCtU2F0de0tGMNhDmAQhKL7F
	xBDL9VTJYxUBXQPIHeziTA13t94trHahhLW/eZxAOEC0PDbfBhZ5AW5T+70/bHIpE7MKEo5GqWJ
	5degN/donxm/o4aKcc1dWJwdfO891U1yQutDsk2HIkzksQ5ODpRYdSg==
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id ada2fe7eead31-4a95425990amr23379998137.1.1730886120274;
        Wed, 06 Nov 2024 01:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmS9OYo4otT12nfkWmtHNvDCJx/YgNSZ/gBSMflzmUZlx87lhupACD1+p41aeETaeGNvH1KA==
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id ada2fe7eead31-4a95425990amr23379910137.1.1730886118398;
        Wed, 06 Nov 2024 01:41:58 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e992esm612199085a.25.2024.11.06.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:41:57 -0800 (PST)
Date: Wed, 6 Nov 2024 10:41:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	mst@redhat.com, jasowang@redhat.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, gregkh@linuxfoundation.org, 
	imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <lnagtti6isffhiioeevmy5gzdmpiuy7zlztsipryw6brsg37ee@rhvuzi6kraff>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>

On Wed, Nov 06, 2024 at 04:36:04AM -0500, Hyunwoo Kim wrote:
>When hvs is released, there is a possibility that vsk->trans may not
>be initialized to NULL, which could lead to a dangling pointer.
>This issue is resolved by initializing vsk->trans to NULL.
>
>Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>---
>v1 -> v2: Add fixes and cc tags
>---
> net/vmw_vsock/hyperv_transport.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index e2157e387217..56c232cf5b0f 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
> 		vmbus_hvsock_device_unregister(chan);
>
> 	kfree(hvs);
>+	vsk->trans = NULL;
> }
>
> static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
>-- 
>2.34.1
>


