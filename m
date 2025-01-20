Return-Path: <netdev+bounces-159732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E0AA16AA5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C7616529D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7E1ABEDF;
	Mon, 20 Jan 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUJxKxh1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFD18FDC8
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368416; cv=none; b=CRb2ymRG+s5t4Zm8yem9xdfhs8PYGABpEo4IahQpM11AKJa6HSx1NMKWijBu9Zjcd65LPp6XHyQ423/egK/+Yx2tmpiAlNELJ8HmOEemYLG5B1CMHa+9uT3zt6ilqqWLGiJnI/8+KriKGr1w4HtXo+KVrGIWa7/OZG4rbIrvKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368416; c=relaxed/simple;
	bh=fxS5aIr95xtbbKhwoCve2o0SVM9sdynxpUwKr+VTQLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgZQwBFWubt8mQcpqIFCj85HQqbDTOsR5UGpPeKBO9yn3V2ZHOggy49YzboVmJ4QjYv/YXX1Cm5JLOQsnRIxhfcaivTnGrakWP09QVlL4bXWi+6ykCCKP20+ImAQwsoN3zX2fobvBGJ0EBhmBOReJlEa7NrFZWBUvb/RzrxNaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUJxKxh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737368413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4T6CB9eqvuQZLLOI1dcrYLKVrCbNDCw2kfSU6+r9xo4=;
	b=MUJxKxh1QqCy2gSD/VRvvlvfBsH0U+rLjnhWqXXvLKRPiKqbTSwfetHHCFH9JGtieeu/Tj
	dz8P6rPcNfESss52vTVgb8VAFzwf9P2gEGSJCsc25Bqrh5+mO4Lj/Fdjo6uNafrOvQdCBl
	QkOM0RHsy2xWHeu5z+OtvoMgqzC57OY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-L8E3RGIhM-KS3maqZpZxrw-1; Mon, 20 Jan 2025 05:20:11 -0500
X-MC-Unique: L8E3RGIhM-KS3maqZpZxrw-1
X-Mimecast-MFC-AGG-ID: L8E3RGIhM-KS3maqZpZxrw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3862e986d17so1781668f8f.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 02:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368410; x=1737973210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T6CB9eqvuQZLLOI1dcrYLKVrCbNDCw2kfSU6+r9xo4=;
        b=v/vT+xUPfv7Zn4+SiUcyXnbcETiXNGy1vzGZDMhnPPQ/32GEfmejchxHngtT4Aw06E
         sK7/nZYM6SiBoo9B1FHIi0vJW3n9fq379wOTBNDn5Wdh9FSpQCEDTysNUDUpmdiOhueB
         i/t7UMMZ+caqnid/PozbX7/kFlADbk3COpOV4ndzUCDwVUlOZ4thbUArptLvdroUVhHM
         zQYfqHbWztBUeHPNDznHxRCSR8fJYHehqYpSLPEtBRYNX8ZWG0jAbrtkKTxuJTsxJmFG
         bO4ArqX/tcdISxDnkVajuK7WcUg1uqmHVQG5zaSNGhQDw8O8q1wWJiJGpg8g6NYPElbU
         sykQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTJfYiC892rajgcN1K95RlMeAPh090HxAbPFNLnAv6hRyg/m7InDIqKjQ1HtgDCD8bsVx4JyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwnWTdmktmYDoR15kBxMKOKi0SN54jI552C2QxwYSTKFhuxem
	gnRtgjtwmbHPreXSXsw0wNvramat1xysWmYUnYLz2kxs/oYZhJ+uhPfe/l8qGuSzVnQ/VSvP1zY
	e4LDO4vgvNYqfYuRrKeilMTsXssassE5E88aZTmYC41fYA72EA88RGw==
X-Gm-Gg: ASbGncsBRl1z95YdzzNTkSG3GwuQ0JntT72Iy0m6Uhj195wU92O2Fg73kgNLOd2uMTy
	kjxm1QkX5DobvvdFxvl30Yzt6CPoevDw9n9HezCXi+PnqhJChejEqRG4hiDYn37cJlaYazX4XrC
	xjfp9h2JRZ7jcZJn5mYGloonJuiaVHVeoQ5a6O36XqrkhMNuL+MX3YXFktcZKZ6n0zvDYlnVZI9
	vgSd85mTi/5Y/PZ/SNWdocC5H5SoBLEXxwKHrbKiWtcGaE5JN6RmK0xG+iT3F1AOraF/8n3NDcZ
	aklA8RcnuvIu3MFzv8aYAg//4YaKzLWxDPWVSzxqALGepA==
X-Received: by 2002:a05:6000:144d:b0:385:e01b:7df5 with SMTP id ffacd0b85a97d-38bf565c2d0mr13369709f8f.14.1737368409868;
        Mon, 20 Jan 2025 02:20:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaooM+V+2Rdh1iiydqA0iPhei7em7s/ST+KIlTQEVgs+9Vb2sYoT+qXfBJ82sKOevYjCiO6w==
X-Received: by 2002:a05:6000:144d:b0:385:e01b:7df5 with SMTP id ffacd0b85a97d-38bf565c2d0mr13369663f8f.14.1737368409217;
        Mon, 20 Jan 2025 02:20:09 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3275622sm10117770f8f.69.2025.01.20.02.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:20:08 -0800 (PST)
Date: Mon, 20 Jan 2025 11:20:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 4/5] vsock/test: Add test for UAF due to socket
 unbinding
Message-ID: <34yqhvkemx27yoxwodfjdc7rwvuyr6sq2e2nlpyfhzvyscvccq@du25v6ljrebj>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-4-c802c803762d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-4-c802c803762d@rbox.co>

On Fri, Jan 17, 2025 at 10:59:44PM +0100, Michal Luczaj wrote:
>Fail the autobind, then trigger a transport reassign. Socket might get
>unbound from unbound_sockets, which then leads to a reference count
>underflow.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 67 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 67 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 28a5083bbfd600cf84a1a85cec2f272ce6912dd3..7f1916e23858b5ba407c34742a05b7bd6cfdcc10 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1458,6 +1458,68 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
> 	test_stream_credit_update_test(opts, false);
> }
>
>+#define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
>+#define VMADDR_CID_NONEXISTING	42

I would suggest a slightly bigger and weirder CID, this might actually
exist, (e.g. 4242424242)


>+
>+/* Test attempts to trigger a transport release for an unbound socket. This can
>+ * lead to a reference count mishandling.
>+ */
>+static void test_seqpacket_transport_uaf_client(const struct test_opts *opts)
>+{
>+	int sockets[MAX_PORT_RETRIES];
>+	struct sockaddr_vm addr;
>+	int s, i, alen;
>+
>+	s = vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_SEQPACKET);

In my suite this test failed because I have instances where I run it
without vsock_loopback loaded.

26 - connectible transport release use-after-free...bind: Cannot assign requested address

Is it important to use VMADDR_CID_LOCAL or can we use VMADDR_CID_ANY?

>+
>+	alen = sizeof(addr);
>+	if (getsockname(s, (struct sockaddr *)&addr, &alen)) {
>+		perror("getsockname");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (i = 0; i < MAX_PORT_RETRIES; ++i)
>+		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
>+					SOCK_SEQPACKET);
>+
>+	close(s);
>+	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>+	if (s < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!connect(s, (struct sockaddr *)&addr, alen)) {
>+		fprintf(stderr, "Unexpected connect() #1 success\n");
>+		exit(EXIT_FAILURE);
>+	}
>+	/* connect() #1 failed: transport set, sk in unbound list. */
>+
>+	addr.svm_cid = VMADDR_CID_NONEXISTING;
>+	if (!connect(s, (struct sockaddr *)&addr, alen)) {
>+		fprintf(stderr, "Unexpected connect() #2 success\n");
>+		exit(EXIT_FAILURE);
>+	}
>+	/* connect() #2 failed: transport unset, sk ref dropped? */
>+
>+	addr.svm_cid = VMADDR_CID_LOCAL;

Ditto.

>+	addr.svm_port = VMADDR_PORT_ANY;
>+
>+	/* Vulnerable system may crash now. */
>+	bind(s, (struct sockaddr *)&addr, alen);

Should we check the return of this function or do we not care whether
it fails or not?

>+
>+	close(s);
>+	while (i--)
>+		close(sockets[i]);
>+
>+	control_writeln("DONE");
>+}
>+
>+static void test_seqpacket_transport_uaf_server(const struct test_opts *opts)
>+{
>+	control_expectln("DONE");
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1588,6 +1650,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unsent_bytes_client,
> 		.run_server = test_seqpacket_unsent_bytes_server,
> 	},
>+	{
>+		.name = "connectible transport release use-after-free",

If it doesn't matter that it is SOCK_STREAM or SOCK_SEQPACKET, I would
rather test SOCK_STREAM because it is more common.

Anyway, here I would specify which of the two we are testing for
accordance.

"SOCK_STREAM transport release use-after-free".

Tanks for adding this test!
Stefano

>+		.run_client = test_seqpacket_transport_uaf_client,
>+		.run_server = test_seqpacket_transport_uaf_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.47.1
>


