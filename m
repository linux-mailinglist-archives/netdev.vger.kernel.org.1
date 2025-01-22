Return-Path: <netdev+bounces-160258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E23F6A190CC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958FF1880827
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A0211492;
	Wed, 22 Jan 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FF7oOljy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE5189902
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546194; cv=none; b=WddzPbWnC3DDWUlWlkagkaBaVxRwhCiNBQD48LY+t27aWMhjGVSmrtdPnTrLO9mCKSUvAbCCXLWlFWSb/HkLtBhn+nrm1mH59MB6a3zfoU5nL7FU2TB9uFiJwqGUBm2JY38/5I5Izt17/MTY7zm5pxDtsJYm2WxfXPq2wKm4SdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546194; c=relaxed/simple;
	bh=mgzvt4umNHoXs8XJ+1+b/D6WHDMtdfA8aDIoZCFM8Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT1nebRHq6F/VhtWHs4VhKGkJwojPVuqvu6nRFU3WFqXGQsbUeg1qd/WZhRKw+PCBOyqb1syTd0MQ5oIVXPlj4DJMXCfa9v3wlBO80NQAnyMqHiuFRCMaBSOmwU/aencOCyNlfuSotItsKeMubNL8xryXpHuP43N5cTvgiuQCg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FF7oOljy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737546191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3GYyjzBqCG+claBaOdJiQZk2Z5BcPT/2xiOiobpLviQ=;
	b=FF7oOljyuDU9m6VFmqzwUVeXHNmRHacYUAQEhNH0KJXbaDWcFwb3I7L5TZ9ajR00RoItrk
	lb4+8C0wOt/h7j/Wyv13eB4xDsPVthtLA033QE/+haXwHUUVjGiQ92w1YAswRxxRWf8zvK
	d60aK/EDPVKYnnZ7/EP+EEVvSeeep5o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-E0Vp0HUmOF6snY65hcb3BA-1; Wed, 22 Jan 2025 06:43:10 -0500
X-MC-Unique: E0Vp0HUmOF6snY65hcb3BA-1
X-Mimecast-MFC-AGG-ID: E0Vp0HUmOF6snY65hcb3BA
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa68952272bso714555966b.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 03:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546189; x=1738150989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GYyjzBqCG+claBaOdJiQZk2Z5BcPT/2xiOiobpLviQ=;
        b=rWSDaBH6KAPVq2Y0zhLitS8q9hLs1BV22AIXf0gvD0NMwAR77A+jjUdIDclY9Vg1yD
         TEetQjMaJe8VfSlXkB/nUgOMhJn3qVEoqE8wZ/pP0kLItQi9DDSahKS6TermExoXdQ3R
         1N2cgZCib8ANcjclEcD4EHvKQHvucvZyYeyraHhoP0ADxWUP17Y4afsw877cQmgoM4Wa
         FcmJhEB4go+NG6yon3lCMo3DXppJQl4qPYewxjiXC3kw4E7ptB+cbIxNcslaKA+0RP0B
         wmLuaid9LpkFJX3nIUeC3CTcfzqF5ejRQbGe5gRoEVY41ZG7SYWJ4ZJgliqJ+ReZT23a
         Kpjg==
X-Forwarded-Encrypted: i=1; AJvYcCWXhTsIemV/LT4dd0X+DjSCQCOz5UvLZEra+g5CRECG69Yw8hLasirotWTqNGDzaRUu7tX5lNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDEJ4KbNCWg6Q4MHuX6rPy1pnMCC7U3tx77AcdkjBhOls416z
	8urm+Hmx6C/lAGCiFnny0nyaLFEw0ELh/Kkrou9KnbRETjDZuTlzaW3JVRvnBbrNx1eMWE/hs/A
	IT8gr0ZrfVyercYsjM4FK4TXpCv0SyKTX6bfmQxl9Mj45m/5uPu59JA==
X-Gm-Gg: ASbGnctL6CbkXlvzsnpR0c73ISG787/r5+iRUtc7zSQl/F+mlyVl2uN39X5JmfG4Fx5
	rxMtcJD0f3T4nkZMvmf9qzJN2gErOIkQZJUTPHN3zts5lEsXSBMs0YIrmOW9vmb9J1WCsrd13I7
	XVDWCnHfF6vgBIvHpTS+tdFEAja9NJ0yRtz7e8XCOLO9k1x53zK6ISyhVQTmBU6KjDJpJZANaql
	+MyNAREhpArDVLGQQnrddNpcG4T7HPSMo6T5yNRvGE/2IFzZjOAaskV0kx+S2tuS9MlfIWRGnwl
	4Xa7h1mIoD8kjP7pZE7I5ayr7UXRleHMPQlUbw2fzg5THw==
X-Received: by 2002:a17:907:7f17:b0:ab2:b5f1:5698 with SMTP id a640c23a62f3a-ab38b44e10emr2212270666b.38.1737546189223;
        Wed, 22 Jan 2025 03:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpp0cwlArVA3kQvguRZY09Ut2TLmWGAT/nTZOZWieOfeJ01dHzZA/Mfy+mINxUfP/zj66Qmw==
X-Received: by 2002:a17:907:7f17:b0:ab2:b5f1:5698 with SMTP id a640c23a62f3a-ab38b44e10emr2212266966b.38.1737546188445;
        Wed, 22 Jan 2025 03:43:08 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f1e404sm906113666b.98.2025.01.22.03.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:43:07 -0800 (PST)
Date: Wed, 22 Jan 2025 12:43:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 5/6] vsock/test: Add test for UAF due to socket
 unbinding
Message-ID: <ot2oabmdq5t34rikuiahcrjvvby4xnaxm7vf6p4nxqmasvy5xj@u3p4wla6qvrq>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-5-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-5-aad6069a4e8c@rbox.co>

On Tue, Jan 21, 2025 at 03:44:06PM +0100, Michal Luczaj wrote:
>Fail the autobind, then trigger a transport reassign. Socket might get
>unbound from unbound_sockets, which then leads to a reference count
>underflow.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 58 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 58 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 28a5083bbfd600cf84a1a85cec2f272ce6912dd3..572e0fd3e5a841f846fb304a24192f63d57ec052 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1458,6 +1458,59 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
> 	test_stream_credit_update_test(opts, false);
> }
>
>+#define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
>+
>+/* Test attempts to trigger a transport release for an unbound socket. This can
>+ * lead to a reference count mishandling.
>+ */
>+static void test_stream_transport_uaf_client(const struct test_opts *opts)
>+{
>+	int sockets[MAX_PORT_RETRIES];
>+	struct sockaddr_vm addr;
>+	int fd, i, alen;
>+
>+	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>+
>+	alen = sizeof(addr);
>+	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
>+		perror("getsockname");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < MAX_PORT_RETRIES; ++i)
>+		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
>+					SOCK_STREAM);
>+
>+	close(fd);
>+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
>+		perror("Unexpected connect() #1 success");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Vulnerable system may crash now. */
>+	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>+		perror("Unexpected connect() #2 success");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+	while (i--)
>+		close(sockets[i]);
>+
>+	control_writeln("DONE");
>+}
>+
>+static void test_stream_transport_uaf_server(const struct test_opts *opts)
>+{
>+	control_expectln("DONE");
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1588,6 +1641,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unsent_bytes_client,
> 		.run_server = test_seqpacket_unsent_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM transport release use-after-free",
>+		.run_client = test_stream_transport_uaf_client,
>+		.run_server = test_stream_transport_uaf_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.48.1
>


