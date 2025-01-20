Return-Path: <netdev+bounces-159724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDDBA16A72
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE07A17D8
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C62E1B4237;
	Mon, 20 Jan 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmLU7uAB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D01B4F23
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367600; cv=none; b=fsgilOA/n72ohYJt7RTveQ+jjls7OnxZCi3p1GzpVqeHBjj3wKi5PIy5dB7m4XswVsIzfwwF7oNDsp1olPp64ZOOeDh6M7PZnaqiBDOefoJIMt4xWlBnOzm6GPj8Ix/m4meRmfJNeTz2CjGdfji1g+v7DZjXgciFjacdO+N0ZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367600; c=relaxed/simple;
	bh=oL5aHmhw7VLtvwjPSsgGX7JK+M1B8eDeLZyxlQElreg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqYt4LYqKk/XZONzw+gPg5mNGP59DZWCHe22+Mz4Fw4rNZdT7+FdMAdrylZZOgr8gfgZtX7GX2hnu4N7RSw7/mYhpHAqVGvV3VfUNuIYuLr4qDjr8YMCK8GLhClCTWoryjKDKl9tPupiU97Ll4HQNDxRdbZQhlC0qcHjWHt6JVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmLU7uAB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737367597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A9szb4/Rigi+hOcaxwYZwoYZLRZ8YudCAzJVCNyuETs=;
	b=BmLU7uABxHdhU1Bj2oEj2Z/zto2LAI2zhfAtSCqQqW2QvYgak0L+DG088pgIjGIC0mvsjT
	p7ARHMr/mO+Sc5zX7k9GqSDKSK8tE5mUBMYjH5nvCnVfDJN3BUwVmzgagj81c0izuy32ne
	iyuKyHzPcx48FAmKSnBXX2OOmA+hfjM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-otkfHZOIPbq_ykGQbM6ZTA-1; Mon, 20 Jan 2025 05:06:35 -0500
X-MC-Unique: otkfHZOIPbq_ykGQbM6ZTA-1
X-Mimecast-MFC-AGG-ID: otkfHZOIPbq_ykGQbM6ZTA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43624b08181so21363735e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 02:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367594; x=1737972394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9szb4/Rigi+hOcaxwYZwoYZLRZ8YudCAzJVCNyuETs=;
        b=NVatmQAf7KSmx01r35iH2U97QYk5LPdl4lQHAReawgEiIpkKX29kTMkhabwwdrbDfr
         rC7Kmq3SHa5gzZyZsD5xMcA/HzwrHapd8WpiB5AEnhnHVfoGlH5/I63FPh7O/KWKxmWo
         ldtF6wQVWcaK8fBcjrKIcqpyJyvBIz8yWT9K4IX2Sr/goETLeptCaaHOkAqhqwvSUYge
         K2dDScDr//bo6zYnJ7OsRxP+2yyj2Fttn9B4Bsj2rtBrQicldWMmu+bec3swtBwBHzxq
         CvKr5Cy5Jvr5VJ880AFoVoTXhWiBQyVgBitH+c8tgdLWLpdRoC2XC/pKzv31iHMFI3P1
         aufw==
X-Forwarded-Encrypted: i=1; AJvYcCUbwOLdE2SFvL4QhiZCB/ZzqJGeRrTSwBYntymD5mf3n37YOIoqzvjDKldgbD6xx0W6H1zRQjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3w+lOo9MghUtcq1NQirecUkV4ASmStQQLW8J7dZMSDOqbs8ye
	VasbLjxzGNfSlec4m1wU8jxkhbaLbxEcOa63pCyNl49s2XaIj90FVmnx2ZqDoLLkLuukgqnxfFk
	s8olqd3ammeXUNn05Z/e/N26nrT3wLPhiqNVFltPdWRwVAjGfIkomfw==
X-Gm-Gg: ASbGncvaPavayYXpBrvspebIbHYz/VW7soRcgHjLgZpfLwhueseM5EuQtWvQmFvChDQ
	w23GqjmmkPa6m/W4aRAcJC5KZX+K47OnP6AIF0SjdRnXUJzOD3oEGlWXjeFi1HLFpUh5DDmX8Ka
	yILhTJfbCJuGS7cNzkRm2YnCUOrYnFTwZ5RINNQniqn4gP3iYpkz9gEWzr2WyZtSJzZ81gd/zSV
	YIntzhApZgrx+wAKUIDg5wb9OrzFbVYZcKEQNMN4DVGgXLkawDdKKbQ0+T9Jz4WVPoSWIZnNH7w
	H7CcCOHkdvJ9cBYhJw0+TGPLPqsq5GtM+EfYRPR4ah4gVA==
X-Received: by 2002:a05:600c:5692:b0:436:76bf:51cc with SMTP id 5b1f17b1804b1-437c6b2dcf4mr163938155e9.12.1737367594161;
        Mon, 20 Jan 2025 02:06:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExPdc8ilZ1EoTX/lgT+u0ckd4EhldQiK3bNVGABmKC9G3Vg90VuxP6ydJ25TSvnbQg/HdE2A==
X-Received: by 2002:a05:600c:5692:b0:436:76bf:51cc with SMTP id 5b1f17b1804b1-437c6b2dcf4mr163937735e9.12.1737367593570;
        Mon, 20 Jan 2025 02:06:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f610sm132221715e9.20.2025.01.20.02.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:06:33 -0800 (PST)
Date: Mon, 20 Jan 2025 11:06:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 3/5] vsock/test: Introduce vsock_bind()
Message-ID: <kyiugvciavdrxb5y6gtuegmvla5tbohlqrrq7terl6xmpykmjo@tnw7fg6dkfdh>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-3-c802c803762d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-3-c802c803762d@rbox.co>

On Fri, Jan 17, 2025 at 10:59:43PM +0100, Michal Luczaj wrote:
>Add a helper for socket()+bind(). Adapt callers.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 17 +-----------
> 3 files changed, 25 insertions(+), 49 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..31ee1767c8b73c05cfd219c3d520a677df6e66a6 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -96,33 +96,42 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>+int vsock_bind(unsigned int cid, unsigned int port, int type)
> {
>-	struct sockaddr_vm sa_client = {
>-		.svm_family = AF_VSOCK,
>-		.svm_cid = VMADDR_CID_ANY,
>-		.svm_port = bind_port,
>-	};
>-	struct sockaddr_vm sa_server = {
>+	struct sockaddr_vm sa = {
> 		.svm_family = AF_VSOCK,
> 		.svm_cid = cid,
> 		.svm_port = port,
> 	};
>+	int fd;
>
>-	int client_fd, ret;
>-
>-	client_fd = socket(AF_VSOCK, type, 0);
>-	if (client_fd < 0) {
>+	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
> 		perror("socket");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (bind(client_fd, (struct sockaddr *)&sa_client, sizeof(sa_client))) {
>+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa))) {
> 		perror("bind");
> 		exit(EXIT_FAILURE);
> 	}
>
>+	return fd;
>+}
>+
>+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>+{
>+	struct sockaddr_vm sa_server = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = cid,
>+		.svm_port = port,
>+	};
>+
>+	int client_fd, ret;
>+
>+	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
>+
> 	timeout_begin(TIMEOUT);
> 	do {
> 		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
>@@ -192,28 +201,9 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
> /* Listen on <cid, port> and return the file descriptor. */
> static int vsock_listen(unsigned int cid, unsigned int port, int type)
> {
>-	union {
>-		struct sockaddr sa;
>-		struct sockaddr_vm svm;
>-	} addr = {
>-		.svm = {
>-			.svm_family = AF_VSOCK,
>-			.svm_port = port,
>-			.svm_cid = cid,
>-		},
>-	};
> 	int fd;
>
>-	fd = socket(AF_VSOCK, type, 0);
>-	if (fd < 0) {
>-		perror("socket");
>-		exit(EXIT_FAILURE);
>-	}
>-
>-	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
>-		perror("bind");
>-		exit(EXIT_FAILURE);
>-	}
>+	fd = vsock_bind(cid, port, type);
>
> 	if (listen(fd, 1) < 0) {
> 		perror("listen");
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index ba84d296d8b71e1bcba2abdad337e07aac45e75e..7736594a15d29449d98bd1e9e19c3acd1a623443 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -43,6 +43,7 @@ int vsock_connect(unsigned int cid, unsigned int port, int type);
> int vsock_accept(unsigned int cid, unsigned int port,
> 		 struct sockaddr_vm *clientaddrp, int type);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
>+int vsock_bind(unsigned int cid, unsigned int port, int type);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
> int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 48f17641ca504316d1199926149c9bd62eb2921d..28a5083bbfd600cf84a1a85cec2f272ce6912dd3 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -108,24 +108,9 @@ static void test_stream_bind_only_client(const struct test_opts *opts)
>
> static void test_stream_bind_only_server(const struct test_opts *opts)
> {
>-	union {
>-		struct sockaddr sa;
>-		struct sockaddr_vm svm;
>-	} addr = {
>-		.svm = {
>-			.svm_family = AF_VSOCK,
>-			.svm_port = opts->peer_port,
>-			.svm_cid = VMADDR_CID_ANY,
>-		},
>-	};
> 	int fd;
>
>-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>-
>-	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
>-		perror("bind");
>-		exit(EXIT_FAILURE);
>-	}
>+	fd = vsock_bind(VMADDR_CID_ANY, opts->peer_port, SOCK_STREAM);
>
> 	/* Notify the client that the server is ready */
> 	control_writeln("BIND");
>
>-- 
>2.47.1
>


