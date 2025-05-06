Return-Path: <netdev+bounces-188302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D82AAC038
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFDE1C27100
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE8E26B2A3;
	Tue,  6 May 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/qR00xV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3926AAAF
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524600; cv=none; b=be8iTFqxja0sPGImKewRYI+LByDhpyhhnC1crbimd4VAm2lHOPr4nHx1JHrUf3zFmhz3CK+thUhJ8EHG04VY36GIz7OO7HjcB7xuLLq7MDxhswBorHDwW5si4J9KGASLDIgYMDt4aOuVOPl9V8+UUkt6kyvlNQk7/9FNxfWwWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524600; c=relaxed/simple;
	bh=OdYxdf2NS9wIbAV3ovwDZCL2iMe9F3X5Sqi4us7Hjcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7mtkWLlfRxZxcuSjz5vKueBsV0rqoaJRGtE9VOx7W4vFec4GIbu0x45CEyPSLc5KXpfLlvt/li1MQwZd51e9RkoBUgK6trkVNQZUgZptPW4wl7qeDc22AuX8lKwLaW1qTweLpnaZM++Wl6Yn2eBfAoTaatzOXP1r0ALEZkc32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/qR00xV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXoAgnolhnIWon+GSP4Yh+No5sQktwbAsoZby2qJ9Oc=;
	b=D/qR00xVZfdpDDdDQo+s+cHuoJP0KyHrnVc0hKFgnt3yZCGxO6OFs5cvsMD+sZEIKTpPfZ
	ioUBv04NSLm3IWgfc6ZBBwnnbQF30y/XW9I3xpyZvcK8WSHAZeLi7l7Vmkpdy0oL3swFZ4
	sJLgM4d0CCjDtS5+WiACaTsdWJTF0GM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-MT_DS228PMWU328_wwxvjA-1; Tue, 06 May 2025 05:43:16 -0400
X-MC-Unique: MT_DS228PMWU328_wwxvjA-1
X-Mimecast-MFC-AGG-ID: MT_DS228PMWU328_wwxvjA_1746524595
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb2fdc6b29so600379766b.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 02:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524595; x=1747129395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXoAgnolhnIWon+GSP4Yh+No5sQktwbAsoZby2qJ9Oc=;
        b=b5N3t4lsRB4qkIeNrCqSFHAqq/o4G+nThGHaPeYLwE9at1A6Nt4aMWGy6qlhE9VNU+
         C0+KqnLGJ64Yk7qIAEQTG2wD73IPyOJS+PtDc3rvzwzohP6cI6s9Y/Y/ZJRDw0thbFNE
         Ld/GPrtviE6BuHygLsZ2GDNWmYRG9nBDs6M/MH5btxQIW7Rht/zFA8FdNtq6F2pC5+if
         Gm3kY9YNJnJBVovIfrdAjDYr3nivum+tm5WOMkKuTj1xKbT72g+seIyzue/6pSFOZmga
         3rJoQzyAZUy5D6aVuwCQRIDl5IhqHvKE77k6I3ipPhZSgRNGfISb32eLIjqazK1fO1iN
         zRtA==
X-Forwarded-Encrypted: i=1; AJvYcCV/tazfZGROSoNGkx6TURufzM5o+bBiHKTM4LWmU3zt9BEFqtuBzdc5BpXEIcR2k8vgcL76Smo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXTM2c6FDRZlPFL+PjeqUI+XY+J0mG++Pw/7t5YRJ62MjN8rT
	X4inuT9A4r9+CSrQlMlCeMw0BCo4dK1zR+Wn3sX+PBZZIM41kR6MCMe8iIUCdlds9WJRgAZjmWl
	gPs2YwQSiuKm8b0qPGNrGjoQ1WXLgoq77I1GkvOkLlWZ2re/3K09ZWQ==
X-Gm-Gg: ASbGnctREX4okQPEM/ELHy9RXFo4rOJUSCe165OkovFYU/jSeQrWWDKg6ur9fSaVzeE
	fTCtq1WycAVqh7eiH9TQ4Taoa+ktZ+81fwJSn9iSdeslepFMUmzf0OvUR0cPLmyvg0JOI4U7RKc
	/vQpJYGbPgWd1Td9xqHjzdnanujHI+UCpr1V0hWfk9NlefyVKYIkuK0yWr1uNE3D698m6aunCff
	5Ofo9z29qjjA4jdAzwuIv3f391sd1sQix5v8tUVh0GPpCW+fnv764iJ8iN2OCXKlGn/8xqMVWdg
	rdUaMGaXKTNfYlaSKg==
X-Received: by 2002:a17:907:6eac:b0:ac7:b213:b7e5 with SMTP id a640c23a62f3a-ad1d2ecb11emr249438666b.18.1746524595034;
        Tue, 06 May 2025 02:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2idRnebYQGCDDQ8BywfWXGWGiLs9tHDNaPLdjiBxzUREqjzvsHE6e+fFczVT0Qkx8Sxwyg==
X-Received: by 2002:a17:907:6eac:b0:ac7:b213:b7e5 with SMTP id a640c23a62f3a-ad1d2ecb11emr249435966b.18.1746524594435;
        Tue, 06 May 2025 02:43:14 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540dabsm671051666b.171.2025.05.06.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:43:13 -0700 (PDT)
Date: Tue, 6 May 2025 11:43:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] vsock/test: Expand linger test to ensure
 close() does not misbehave
Message-ID: <g5wemyogxthe43rkigufv7p5wrkegbdxbleujlsrk45dmbmm4l@qdynsbqfjwbk>
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250501-vsock-linger-v4-3-beabbd8a0847@rbox.co>

On Thu, May 01, 2025 at 10:05:24AM +0200, Michal Luczaj wrote:
>There was an issue with SO_LINGER: instead of blocking until all queued
>messages for the socket have been successfully sent (or the linger timeout
>has been reached), close() would block until packets were handled by the
>peer.

This is a new behaviour that only new kernels will follow, so I think
it is better to add a new test instead of extending a pre-existing test
that we described as "SOCK_STREAM SO_LINGER null-ptr-deref".

The old test should continue to check the null-ptr-deref also for old
kernels, while the new test will check the new behaviour, so we can skip
the new test while testing an old kernel.

Thanks,
Stefano

>
>Add a check to alert on close() lingering when it should not.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 30 +++++++++++++++++++++++++++---
> 1 file changed, 27 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..82d0bc20dfa75041f04eada1b4310be2f7c3a0c1 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1788,13 +1788,16 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define	LINGER_TIMEOUT	1	/* seconds */
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
> 		.l_onoff = 1,
>-		.l_linger = 1
>+		.l_linger = LINGER_TIMEOUT
> 	};
>-	int fd;
>+	int bytes_unsent, fd;
>+	time_t ts;
>
> 	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> 	if (fd < 0) {
>@@ -1807,7 +1810,28 @@ static void test_stream_linger_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	/* Byte left unread to expose any incorrect behaviour. */
>+	send_byte(fd, 1, 0);
>+
>+	/* Reuse LINGER_TIMEOUT to wait for bytes_unsent == 0. */
>+	timeout_begin(LINGER_TIMEOUT);
>+	do {
>+		if (ioctl(fd, SIOCOUTQ, &bytes_unsent) < 0) {
>+			perror("ioctl(SIOCOUTQ)");
>+			exit(EXIT_FAILURE);
>+		}
>+		timeout_check("ioctl(SIOCOUTQ) == 0");
>+	} while (bytes_unsent != 0);
>+	timeout_end();
>+
>+	ts = current_nsec();
> 	close(fd);
>+	if ((current_nsec() - ts) / NSEC_PER_SEC > 0) {
>+		fprintf(stderr, "Unexpected lingering on close()\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("DONE");
> }
>
> static void test_stream_linger_server(const struct test_opts *opts)
>@@ -1820,7 +1844,7 @@ static void test_stream_linger_server(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	vsock_wait_remote_close(fd);
>+	control_expectln("DONE");
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>


