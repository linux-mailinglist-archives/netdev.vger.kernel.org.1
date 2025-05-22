Return-Path: <netdev+bounces-192568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2BAC0686
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF131BC3857
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA0261388;
	Thu, 22 May 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOGQsqfu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27543261595
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901153; cv=none; b=nr+NB1wWW1MW7a6o6RE6J4mWfQgo98QuKgUTMSpZk7KEMPf+ZRoq0FnBNOW57Leui3UfvYeVqB9brxDz+hCDMYxqmaBf4T8ALvmw8iuMtsFrM5d7f7sK2LODzhL0LWFH1mLjgDDMvjE6izEPhoD3Wh29B3Exwq6ocBj8SZx8ljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901153; c=relaxed/simple;
	bh=kWJ+8wnhh914ZGBXjyQG8OCRHhwawgFGLPLGp5cMp2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNYxGzhnIGcZT5ZYYMOHSMdlhunrp15nTCRMwYzrwoDzzBCh2d+kfOsXDIZssbWcK8FzW3HGd57VgwhN8eb+T0ZWOpF2Jn2Lz1iEXmL4PynfgNX8ddVstqbYCmfA5l+Fw9sM+OSLCLERgk9YIqJObX2wU9Y5j356AEMLLXfKiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOGQsqfu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4n1+uXd36V+722CeTIUBaJYf703izxjGMMRXpA7T1DQ=;
	b=XOGQsqfudzLhpgaeSSf0V1f8MDcTGdOL643HBcHm55SUSpivV6aS3ysXBzqgAtX0tWsPkm
	9GtLHtJTwP6ccJQlVVWBdWEZ/+fnX/iqkDhKIKYr5YG7rUvDwjEr5XKnP/Q1ekLjn38601
	HxM2/lfIk7Knm9v15JQZLwrlJ+DBm/c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-o2GnCfmMOxKCEKjYFSQvgg-1; Thu, 22 May 2025 04:05:46 -0400
X-MC-Unique: o2GnCfmMOxKCEKjYFSQvgg-1
X-Mimecast-MFC-AGG-ID: o2GnCfmMOxKCEKjYFSQvgg_1747901144
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442f4a3851fso64338775e9.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901144; x=1748505944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n1+uXd36V+722CeTIUBaJYf703izxjGMMRXpA7T1DQ=;
        b=fad7XYbj8w9GVEwus6IhN0Cv7l4sROfdH5UaUzZNiKdd+8YfmtnljidYYnjeQrGo0o
         R15C1qWLnEzXdxmIYsz902kMHFBL4A37UhqUds4b7KtvGm+Kmzi7wF1vXoezXjmq/Gt7
         G7QPSHc/qLsCUTRYKgs3S8KPkHyeizNee71kgeqTnyZoUqXLmUR1VE2BiYi2mwJf8DJC
         dMSDjTEMikKPwkXs0cd/h9xo99XmLw9MQwkDTkuOAmUPw8bHsd1DTLEuZoykXZIgs8yx
         duqIPKkif/CSkxn9gr8wXGXlQOWFe5gFPr6g9/Gedj7YF1xTsRwj16g1LqQeaB06eNf6
         A3GA==
X-Forwarded-Encrypted: i=1; AJvYcCU3XtPZ4GYXKTXh3iKZFmNAtYvSw8PiMDDKP9PjoD2geGJEhawpkenu21XzSItJQ9UxwZBWCaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAY7SgKmBmhtl8v3s2rTRRDsSfjyN8RBOMyugnbL1Rdtw5CMx5
	Q0Rq+mQ5V7d5/wFWBojr7s90NY1dN4+Yt2iIfcp9TQnzqtPMCwMsgx1eB49I/OalHfi72R6eL3Y
	U2SE7Nb0yd+7eqcTShdkL9i6wj+LrOqyC9aIwpHng7EB+Mc5etaatxgupnQ==
X-Gm-Gg: ASbGncvs1WP4fhPCw08dPwqp7M3MkUzaJmdVe4aWrPA+iepaFuT+sMMaSC3IPWjzUW/
	Y8Yy5/QVNPsQ+v/ZjWwKcp/ei461M8skr4VBQAp3apkQQ9jodAjY99+XlKXeN2RQd65noZzNzjh
	OTNeb7eaiTZjareBIEwTg/f+cm3/AGLi9euwL9GguIoGJeYqd4NlUSHdrri+DkRueRP31C495/Y
	mxzkDNWbNbZiTJZMP5a+6wJjkl4u7NTZl+qsWIsrPoDJzABFNl8kwcT8RCvxnORq94AzUHXzUvN
	8lM4ZajDZBmsbR4R1y9l5Dlyfd0HWLXzthSJpTWlcEQNoGv236qsyA7WwE1u
X-Received: by 2002:a05:600c:3ba1:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-442ff03bbaemr215404755e9.27.1747901144394;
        Thu, 22 May 2025 01:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6p/hrwmEdoltdyMAYZsM/Trt1xdM7A/O/RHR4xK1dSQJHwCglht4DgE/PYNhLm3+cM8zWw==
X-Received: by 2002:a05:600c:3ba1:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-442ff03bbaemr215401755e9.27.1747901140327;
        Thu, 22 May 2025 01:05:40 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f381465fsm95350675e9.29.2025.05.22.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:05:39 -0700 (PDT)
Date: Thu, 22 May 2025 10:05:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/5] vsock/test: Add test for an unexpectedly
 lingering close()
Message-ID: <4huzbqatmv5ohwnwbqoeri55a35yyhlm3drlltldy6mgajjkj2@eptml5ykp54h>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
 <20250522-vsock-linger-v6-5-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522-vsock-linger-v6-5-2ad00b0e447e@rbox.co>

On Thu, May 22, 2025 at 01:18:25AM +0200, Michal Luczaj wrote:
>There was an issue with SO_LINGER: instead of blocking until all queued
>messages for the socket have been successfully sent (or the linger timeout
>has been reached), close() would block until packets were handled by the
>peer.
>
>Add a test to alert on close() lingering when it should not.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 52 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 52 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index b3258d6ba21a5f51cf4791514854bb40451399a9..f669baaa0dca3bebc678d00eafa80857d1f0fdd6 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1839,6 +1839,53 @@ static void test_stream_linger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+/* Half of the default to not risk timing out the control channel */
>+#define LINGER_TIMEOUT	(TIMEOUT / 2)
>+
>+static void test_stream_nolinger_client(const struct test_opts *opts)
>+{
>+	bool waited;
>+	time_t ns;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_linger(fd, LINGER_TIMEOUT);
>+	send_byte(fd, 1, 0); /* Left unread to expose incorrect behaviour. */
>+	waited = vsock_wait_sent(fd);
>+
>+	ns = current_nsec();
>+	close(fd);
>+	ns = current_nsec() - ns;
>+
>+	if (!waited) {
>+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+	} else if (DIV_ROUND_UP(ns, NSEC_PER_SEC) >= LINGER_TIMEOUT) {
>+		fprintf(stderr, "Unexpected lingering\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("DONE");
>+}
>+
>+static void test_stream_nolinger_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("DONE");
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1999,6 +2046,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SO_LINGER close() on unread",
>+		.run_client = test_stream_nolinger_client,
>+		.run_server = test_stream_nolinger_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.49.0
>


