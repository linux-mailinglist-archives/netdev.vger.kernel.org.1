Return-Path: <netdev+bounces-159733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6EA16AAD
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B345C1885107
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378231B218A;
	Mon, 20 Jan 2025 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpWDvaoY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68F1AF0C2
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368681; cv=none; b=Amm53SAmE0mIXrWhB7+y2IK4zF7jBu05RQwwzTRP7VZlmNFAPxm6/1ndr/iIApUM8E8TBkCslNt2OpJJnmQoUYS21WHKDeN7BdA1mvstmWmaHuRCSzYdJv/qmTJciiswH747gpPgc7vRZQeqLyT77HmHBG2crNyqOETJfmN3XwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368681; c=relaxed/simple;
	bh=yf6HR12vgiphx26xpnRwI/ZSbZ1Lhr+S2Vo9TB07VpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2VXu1ZZ7fHjhdAcKlDiaLI2JCkhXukaXCaEKe59On39NYuCcxupK/95wjncLgq/qXlvso/2DwpQKKY2YGTGmbcrvGmPTfugaLVI8lFlWaHDtY+PGEaQRu3sL/+25epB4DoXDhzEA3CCurCOg4SI9gs7FuR7YV31T5i1wR+bb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpWDvaoY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737368677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LW0AIg+ZzVE0PO3mnBxk2BL4NaV9etOallTabibSD5U=;
	b=VpWDvaoYpYj6d8XYFffrBqmGtFXYnnTQl08+zgByR2y8GlP+clCdPjFB9WXJaqtDo0CxIA
	AnSf8F3sp4k5gPVvo9outshT28vwBOtF446zWuaTfFQ0i2DvzrxPyj477TF3+Iil444JAa
	FaacG+CuVgZzMUr39TXHEf6Lut/qwP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-LODsI45ANXS1f0H9EKR6Sg-1; Mon, 20 Jan 2025 05:24:36 -0500
X-MC-Unique: LODsI45ANXS1f0H9EKR6Sg-1
X-Mimecast-MFC-AGG-ID: LODsI45ANXS1f0H9EKR6Sg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso22808045e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 02:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368675; x=1737973475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW0AIg+ZzVE0PO3mnBxk2BL4NaV9etOallTabibSD5U=;
        b=BrRc8lEyvQbGnyhkqOuxySS3e63FgGyTe9wxIWr2vq/2uYn3ySQxBIqD8LtSfcBJKd
         RpMVcttFM2n6r2g/yD5xnTn9OAd2kyHdxB0z68ZLuTP3z6PUGGqo9KgBJeIa1gOoq95d
         Vv83fg3xzCdNwv0eXKg0ixJ5TQ43ZN5R4QKF45Mr/FZ/L60CeTcbNf/JGaDf1YTk1glJ
         MviRS+Ks4hZCY0xKrOvm5vNKCLAzEzWudZnQ/jdYnYZuGNwXbzXLKngqS/FFbnd0iE8S
         iu4HiaFLOaKi4GpI18TrRVJ+zgNpR+dZogWuEuLwRxycFLDJvTRfne0aw1K/btGDkQM6
         DKsw==
X-Forwarded-Encrypted: i=1; AJvYcCUFYI1m4CSvSH+nc7rRLlSQM96Qdl7MuvTSh7w5noKk7ZHSoxpkMt1vdICbAveXl4rTa08Wq7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrN7bPRIkBlwoyRkXY4c9kcKKLYfJGneolZ9kioQWaG+4Tiqe
	g3Pt2jpQEVBFc7yFk3aPlyhHCkpiQo8UJd8WtVbv0DNvgu3m1BjuTIpN5Ou76+xBB6LtRcqYYAB
	ZQm+cgUlwXSQ1FpxuZvrBomFWOxNCrrEXde8jwTlnJ/1uoIQYiHuHiQ==
X-Gm-Gg: ASbGncsCXzxagsyJ1xa03S7XbH+KjhMcMn0HvrMCTOkFGEF3P3M1psTlVMyp5CPf7qH
	Lx2EEnuUK3O7ms5t1ucM8yWkqvHr82zHAvyltFHk1JlkACEjAoAcW1udXwS8CyyZ+aQXfp+DiJk
	gYu+ODzGzHX3T3BvOpf8kO0h+xwRK+KhPt8A+OiprTyRspgH0i/ZP7wXgcvmenimRIXYcPoWmpA
	lvx0pawI/xFn2efCdN6TO4c3CT6oV90j3tHuY9izf3BwEhL0SpfOgx8djpFvbTJSajC0u1Wzdzl
	zDDAoM5PKN07YC2cjjIGOqaQE1s+ys10xaufaZhk9dMvIw==
X-Received: by 2002:a05:600c:3b0f:b0:434:ffe3:bc7d with SMTP id 5b1f17b1804b1-438913f01a1mr128704515e9.16.1737368675030;
        Mon, 20 Jan 2025 02:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrE1oo70JL1hLkDSzofUD4xLsZ+nRy+bJufSIh/J5HvGrSXyY5lVRiPHjCxgOMZONscT3QZw==
X-Received: by 2002:a05:600c:3b0f:b0:434:ffe3:bc7d with SMTP id 5b1f17b1804b1-438913f01a1mr128703855e9.16.1737368674313;
        Mon, 20 Jan 2025 02:24:34 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389046bab0sm131160305e9.38.2025.01.20.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:24:33 -0800 (PST)
Date: Mon, 20 Jan 2025 11:24:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 5/5] vsock/test: Add test for connect() retries
Message-ID: <pyun3hl67vjel7gc7k67nvelx5bmgw664gvkzauqqv6nkkt5sc@x6hzsedofchl>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-5-c802c803762d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-5-c802c803762d@rbox.co>

On Fri, Jan 17, 2025 at 10:59:45PM +0100, Michal Luczaj wrote:
>Deliberately fail a connect() attempt; expect error. Then verify that
>subsequent attempt (using the same socket) can still succeed, rather than
>fail outright.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 52 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 7f1916e23858b5ba407c34742a05b7bd6cfdcc10..712650f993e9df68ceb68ae02334c2775be09c7c 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1520,6 +1520,53 @@ static void test_seqpacket_transport_uaf_server(const struct test_opts *opts)
> 	control_expectln("DONE");
> }
>
>+static void test_stream_connect_retry_client(const struct test_opts *opts)
>+{
>+	struct sockaddr_vm addr = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = opts->peer_cid,
>+		.svm_port = opts->peer_port
>+	};
>+	int s, alen = sizeof(addr);
>+
>+	s = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (s < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!connect(s, (struct sockaddr *)&addr, alen)) {
>+		fprintf(stderr, "Unexpected connect() #1 success\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("LISTEN");
>+	control_expectln("LISTENING");
>+
>+	if (connect(s, (struct sockaddr *)&addr, alen)) {
>+		perror("connect() #2");
>+		exit(EXIT_FAILURE);
>+	}

What about using the timeout_begin()/timeout_end() we used in all other
places?

>+
>+	close(s);
>+}
>+
>+static void test_stream_connect_retry_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	control_expectln("LISTEN");
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1655,6 +1702,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_transport_uaf_client,
> 		.run_server = test_seqpacket_transport_uaf_server,
> 	},
>+	{
>+		.name = "connectible retry failed connect()",

"SOCK_STREAM retry failed connect()"

(and if you want add a comment on top of the test the in the current
implementation the same path is shared with other connectible socket
like SOCK_SEQPACKET)

The rest LGTM.

Thanks,
Stefano

>+		.run_client = test_stream_connect_retry_client,
>+		.run_server = test_stream_connect_retry_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.47.1
>


