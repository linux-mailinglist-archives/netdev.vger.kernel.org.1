Return-Path: <netdev+bounces-212014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37545B1D3EE
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CCA166A95
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ACC2236F4;
	Thu,  7 Aug 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ixx2o0CU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AE4A02
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553782; cv=none; b=LJTPUe6z0fWrBRYXZwCb5GTAFNHGOtCtq/w37dJ34OgBVNtxOk4BU+feK9ysiL+60x+Ja8TiAZz4vq4TX5LmWmH3486AdCjXl8J39Rn0GPIZgm5Uq9OAjD0I4yDx8fxY4kdCkk5ZXIZDCWbCcijqr8handTHjFL6quCnVj2r3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553782; c=relaxed/simple;
	bh=xSHLdlTVJtVo8nQl5jpul19NJdAbbaY8TRUqxRCTtpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr4ijRdYbvK7Qnl+cZxgyyp+tL29eEQrj7nv6JNKnKHWXHdK4baVmcuog6740qcvNgLF09i1WQ81pZx6fWm24zLh6VBe6nrmvNsmQnfu4WNSmETFzK+RRgCZnC6qfh8TDfoxOurEnr+0xA96VhGVCrdZgO5HPgWQw4JsUzKNkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ixx2o0CU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754553779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dSK1iSTNaXrZ4AN3yprnVA4DT/75MZHS1xYFpkZ2lnc=;
	b=Ixx2o0CU0m567FFVYFr3xZltpT+DamXunWeqH9bdOaDrSI1dEqm+xSUG2qqzkRyHBo7084
	IFrOEYHZ2GfZuplMjWCAATbG+R2U0EXDivtzPKzlHiDqm0RgNziX7A0B+bXrNy1EMigAI4
	t34HTsSjVJqyAXlNCalYwL7/JA2LAfY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-bBh5lS-sPLiEqoISk1hKrQ-1; Thu, 07 Aug 2025 04:02:58 -0400
X-MC-Unique: bBh5lS-sPLiEqoISk1hKrQ-1
X-Mimecast-MFC-AGG-ID: bBh5lS-sPLiEqoISk1hKrQ_1754553777
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-719a4ccfcb6so10068717b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 01:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553777; x=1755158577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSK1iSTNaXrZ4AN3yprnVA4DT/75MZHS1xYFpkZ2lnc=;
        b=V1YVtcdWMslKXAnHVOKBW9M9W/j34ZINq3kuPDptDUxi+PE7YbRJIlgJJ6wdyN9Uh9
         GlLKyneVFeTUjK+Eq0bEVURH+GVqci48bollSWq09wESq5Z9KSENosWXWkk5NxeDs48l
         3TS+gGCk0KJD4zGCigRfINLfvr3BpOflyj/YwF/52SI6CBgEBEZVcVvndM4/aTVCOwmU
         nXTD5vTeTrYpyr1026DyRF6If7tUeAN1NxWiugoq3euYilG2wEdu9JiUFo42biYKhYyp
         x9lNpbh3svZBTEfGwlHWZoThVrgnxqmWmP4UslA3WepcUHkvKCek1h9uhqvefv811u0N
         h9Zw==
X-Gm-Message-State: AOJu0YycruVlTYJzg7PQ3LB9cJd7QIuZHCJjJZ61YjkTS7XCebRbkGPL
	BjBbsXsUGhYJtwoR2LFzqdofxEzZGXsLwxI7myDbqh6KFYah0iYfZaq66bzik70aDl7yAO78XFF
	/aRTolTd9p6kJHwDRjk239nrzfzbXVCPhc6RW94Wh0undDviRGiDaczfJdA==
X-Gm-Gg: ASbGnctmITNm/TvwhCNdbSyUFLO6/5G6tG9LlmLu3EwrryHS7b4gQxo2YGG68ALKu1+
	r6O/mKN0e/TugID5jX+lm810ahRR75d93xZtUV8pcDHSwnuqcyDG8br3cpHuFNQPlv5M/DCD+C3
	9QgRcfnZKmG0edsL5Tj/lmZ0CYesHyTAM5uzXliz1Mh+885VPQStIDKs5nXysar2zBBcYqM6tog
	JLqSWG5YzmLWsmgka0QW2WUPyozYya9p+A5YOIKoWyl4LZxd7Bq8h7awMZy9e0A2CzxfDV1pR9y
	3NWTTqMrTs/xHC+GEh+pdDZhp3qKgsANCtQeYKbwT5GTw/4ArT7OpjObMjoFIDm6ZZuXynmZKDX
	N+15w7NsYLOkWjOM=
X-Received: by 2002:a05:690c:e1e:b0:70d:f3f9:1898 with SMTP id 00721157ae682-71bcc833e83mr77517107b3.35.1754553777287;
        Thu, 07 Aug 2025 01:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1c7TKsMNnBRh62xCcT6/BlQdfdj0ibell23NbQ0F8+CQr1wYoBFjU4y4sktLodjTNK4jqbA==
X-Received: by 2002:a05:690c:e1e:b0:70d:f3f9:1898 with SMTP id 00721157ae682-71bcc833e83mr77516527b3.35.1754553776614;
        Thu, 07 Aug 2025 01:02:56 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a59e009sm44344657b3.53.2025.08.07.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 01:02:56 -0700 (PDT)
Date: Thu, 7 Aug 2025 10:02:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] vsock: Do not allow binding to VMADDR_PORT_ANY
Message-ID: <5xay32omz7hmdys53oub34dsp6654bw6flelc77e3kk6ltpeeg@n2x3qf5psf52>
References: <20250807041811.678-1-markovicbudimir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250807041811.678-1-markovicbudimir@gmail.com>

On Thu, Aug 07, 2025 at 04:18:11AM +0000, Budimir Markovic wrote:
>It is possible for a vsock to autobind to VMADDR_PORT_ANY. This can
>cause a use-after-free when a connection is made to the bound socket.
>The socket returned by accept() also has port VMADDR_PORT_ANY but is not
>on the list of unbound sockets. Binding it will result in an extra
>refcount decrement similar to the one fixed in fcdd2242c023 (vsock: Keep
>the binding until socket destruction).
>
>Modify the check in __vsock_bind_connectible() to also prevent binding
>to VMADDR_PORT_ANY.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
>Signed-off-by: Budimir Markovic <markovicbudimir@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for the fix!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Please next time use `./scripts/get_maintainer.pl` to cc all the
maintainers and mailing lists.

If this patch will not be merged, resend it (with my R-b) to all the
maintainers/list. I'll be offline for the next 2 weeks, so remember to
carry my R-b.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ead6a3c14..bebb355f3 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -689,7 +689,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 		unsigned int i;
>
> 		for (i = 0; i < MAX_PORT_RETRIES; i++) {
>-			if (port <= LAST_RESERVED_PORT)
>+			if (port == VMADDR_PORT_ANY ||
>+			    port <= LAST_RESERVED_PORT)
> 				port = LAST_RESERVED_PORT + 1;
>
> 			new_addr.svm_port = port++;
>-- 
>2.49.1
>


