Return-Path: <netdev+bounces-160257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F28A190C7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32797A2B22
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682F211A2B;
	Wed, 22 Jan 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0y+S3e9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54698211A29
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546001; cv=none; b=cSWeeVtCZ4arae1gIkxBHairvqKnfDu706ObvcxNfXixyu7Xoii5aE9P3g6Iq8ss229cMCUtRCCUC+yZSbT3EzWr/KP65OUiyCHnP8b4781VC6axs5foVghjm17GQyHl+KE38lDE9rjPFUFtJyukQO/ZbkidK3aJRmg1Pjat+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546001; c=relaxed/simple;
	bh=Q8zSanwaPlbaSOIcA2GDsawdODNc1waf3cpuE9PTDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mh3V7PWLOZSsk9QR2Klf+SlC6lj9tZ3sBYu9y6CBYEPDVOzHvqsMxRM92IBNXtnk/xK1VK2HFCQm9Za6c6+1gDnrPs96ScWENTxAtaMaLvQUTroo22g5xntU7R/EPfdBOT0Y050EGdpQ39lBL4aLo2v1QV4qYsyv6+B6e/90arA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0y+S3e9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737545998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKGwBZY3jjfJAfYnrFsWygDyQ0Aq1KXSaqo67NUWe+w=;
	b=B0y+S3e9pB/I+55Ht9dCNr+RRyccbKqQOdW19yn++XQkIkCgtfuSPFK5alrgiF+1QYmj5m
	IaUTrDJgUyHqIUtPn0mkSp3niCUKSWW4MaaBueAPKpuEP43o2kanYPADrdLIJBf+oslzsC
	O5XdGq6kJIeSyDFzx5H2Qk5NJwgaxrc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-qMaaS3ZlOv-RYnJyV3q1ew-1; Wed, 22 Jan 2025 06:39:56 -0500
X-MC-Unique: qMaaS3ZlOv-RYnJyV3q1ew-1
X-Mimecast-MFC-AGG-ID: qMaaS3ZlOv-RYnJyV3q1ew
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5dbf25864a9so1203179a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 03:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737545995; x=1738150795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKGwBZY3jjfJAfYnrFsWygDyQ0Aq1KXSaqo67NUWe+w=;
        b=RPXiax7xB11qEPg/fKfHKj5CmSHuasmG96zw96olDHeJNIFxZN+GarWgFKcOa/z71r
         8PgrrF6svSFmupfob5/c9RZKdJfaEad2lNwb+potGZrVJQcti/A+QZTcYQGknx9vHv2i
         cDICXMsnRhoyLlrX+jtNfxvbNjxHRwLFcGKjttS/wlWfxFsoZzSk2yL/EsvexP+IEfhu
         0/Ytsyng5Q0j4loPE5TLsHHcNp8CvewbrAck/Fr0BNcJafhRL47hmIIhYcbci3OqQFwD
         gc0JbNFxEiYeq7H0BNnaR7hWhjDGk2Da/y5E8RADdzTK7oSlX4bTVxAJlNd+aAJEzYsG
         ivPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFX9zS+PPIPxO+w9pmTRKt87T0TCIwkj1SjoTe6M7BzuRMej+gQIZO3S1IoaeXDdHj8bkrsOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoWx2xMS0bEsPAx20+wjM8RrXhBeVzsghOAaqy1qy0+rKV7RD
	uc681q6TDE0N8p/z6OGeCvLEmtp3nqaiQKkFk/RVD3fOiHf10x+W+5/euuZ8F0gyyNGNkX3GVmC
	NcJeP/dMYNQwNrimLZUPz0zyJd+OojLMpcJsn8W3U9JsLQJ/I/DXLnw==
X-Gm-Gg: ASbGncsjvkY8H43ObUT37gtC8+W61AO3CkSzOURnBD/gAWX4XbXjWbTRX0ZF1qegTFf
	kBHfZsUo7nMr8yP6EM/ZgRSXVjFFBiQGlnBvl9/jBj0hPgdnzMSguHDKXythsZ3RhEIqpYh7SsM
	lKzBEufhR916nLh+qJaGwXzqN0FBfb/YQgnmoHZq3lx4g84nXkIo8uAXKXXj2SkHeNXrynwudDP
	/7RbC0EV2H+FN/tbIKyR6BX9PQq/rMOgEvKEOz9Kfp38GIo84nzl2naOE81szuVfVS9wlOuIQtP
	8n2XpZmDVLSyW9C4b6IqBFtcuXvx8Ry7LGR7EqqRlaUqWQ==
X-Received: by 2002:a05:6402:1ed4:b0:5db:69ee:9149 with SMTP id 4fb4d7f45d1cf-5db7d2fc229mr21360257a12.11.1737545995565;
        Wed, 22 Jan 2025 03:39:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdXT2teo47ew5tzwhaY+ahneuCmM9/jFGU4gcmi/Y1uTv+kEjgMQR22L03VfmghAr/oH/WVA==
X-Received: by 2002:a05:6402:1ed4:b0:5db:69ee:9149 with SMTP id 4fb4d7f45d1cf-5db7d2fc229mr21360231a12.11.1737545994842;
        Wed, 22 Jan 2025 03:39:54 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683c29sm8596865a12.34.2025.01.22.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:39:54 -0800 (PST)
Date: Wed, 22 Jan 2025 12:39:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 4/6] vsock/test: Introduce vsock_connect_fd()
Message-ID: <u364jxu7r6gyynkzvlt3n2jeiklgyyqyb7ws4fod7nzwfe3dru@2dkvlpwnie56>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-4-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-4-aad6069a4e8c@rbox.co>

On Tue, Jan 21, 2025 at 03:44:05PM +0100, Michal Luczaj wrote:
>Distill timeout-guarded vsock_connect_fd(). Adapt callers.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 45 +++++++++++++++++----------------------------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 18 insertions(+), 28 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 31ee1767c8b73c05cfd219c3d520a677df6e66a6..7f7e45a6596c19b09176ea2851a490cdac0f115b 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -119,27 +119,33 @@ int vsock_bind(unsigned int cid, unsigned int port, int type)
> 	return fd;
> }
>
>-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>+int vsock_connect_fd(int fd, unsigned int cid, unsigned int port)
> {
>-	struct sockaddr_vm sa_server = {
>+	struct sockaddr_vm sa = {
> 		.svm_family = AF_VSOCK,
> 		.svm_cid = cid,
> 		.svm_port = port,
> 	};
>-
>-	int client_fd, ret;
>-
>-	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
>+	int ret;
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
>+		ret = connect(fd, (struct sockaddr *)&sa, sizeof(sa));
> 		timeout_check("connect");
> 	} while (ret < 0 && errno == EINTR);
> 	timeout_end();
>
>-	if (ret < 0) {
>+	return ret;
>+}
>+
>+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>+{
>+	int client_fd;
>+
>+	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
>+
>+	if (vsock_connect_fd(client_fd, cid, port)) {
> 		perror("connect");
> 		exit(EXIT_FAILURE);
> 	}
>@@ -150,17 +156,6 @@ int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_po
> /* Connect to <cid, port> and return the file descriptor. */
> int vsock_connect(unsigned int cid, unsigned int port, int type)
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
>-	int ret;
> 	int fd;
>
> 	control_expectln("LISTENING");
>@@ -171,20 +166,14 @@ int vsock_connect(unsigned int cid, unsigned int port, int type)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	timeout_begin(TIMEOUT);
>-	do {
>-		ret = connect(fd, &addr.sa, sizeof(addr.svm));
>-		timeout_check("connect");
>-	} while (ret < 0 && errno == EINTR);
>-	timeout_end();
>-
>-	if (ret < 0) {
>+	if (vsock_connect_fd(fd, cid, port)) {
> 		int old_errno = errno;
>
> 		close(fd);
> 		fd = -1;
> 		errno = old_errno;
> 	}
>+
> 	return fd;
> }
>
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 7736594a15d29449d98bd1e9e19c3acd1a623443..817e11e483cd6596dd32d16061d801a66091c973 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -39,6 +39,7 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> unsigned int parse_port(const char *str);
>+int vsock_connect_fd(int fd, unsigned int cid, unsigned int port);
> int vsock_connect(unsigned int cid, unsigned int port, int type);
> int vsock_accept(unsigned int cid, unsigned int port,
> 		 struct sockaddr_vm *clientaddrp, int type);
>
>-- 
>2.48.1
>


