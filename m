Return-Path: <netdev+bounces-160354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE8A195F7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27C016BFD9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DA211287;
	Wed, 22 Jan 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1QJbze+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370A12B71
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737561677; cv=none; b=k2qVc7dKwTFTzuxcLyvpgkg8noxC2OgI6O+mBV/oJUCLmTU41Q0csYKnjXql4XjxkOezB/qn88b077mS4lUU495xfC9RWo8T/psOMWF9avgVJLUXk41X2mI9ysX2cyL5Dx1rtwIyFWYM0YfbwSdEGl44+TMdgC6MdqU87NShPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737561677; c=relaxed/simple;
	bh=QDATWEJUjWuzNKG8OAAcMl8/rarR3yMkDbeCKXtDEYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1VEHsp/QWCLBzCTTjOdg+chz+8x62290Zq7I6dJ7ZdJ0vGkJvncg18gKzLUIywAY9OTOw2Lw4stObPHDXPWtzra2HVfWuz7knaPSG/KBmi9iaFml+GC5eQzRLleYc9se7SKZwOjX7YJcwQ7wdHdjxOR/JSXcKvNtaO9GtuMrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1QJbze+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737561674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMKUEN5MHdAxy6GkxwuxV79GlOrnXUk2pyO8Oo1XZa8=;
	b=D1QJbze+gpx5mUg/2wliX2uXWJkCF3j16OBiW25JqDljoQoTSUPSENJrzuoty+hpZnuQKb
	P3bgYeYaL12/g9wiaGUVPJVMVhvZ5Ak4efYsndHz4pjPPfT0EDmH1/tIR6kRlqoH+L/690
	mQC3Q7kx3Yng40Y0usrEsGymV3MNZ3E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-gmTU8M_APGG6YR1WsK38zA-1; Wed, 22 Jan 2025 11:01:12 -0500
X-MC-Unique: gmTU8M_APGG6YR1WsK38zA-1
X-Mimecast-MFC-AGG-ID: gmTU8M_APGG6YR1WsK38zA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b6e1c50ef1so1025338585a.2
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737561672; x=1738166472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMKUEN5MHdAxy6GkxwuxV79GlOrnXUk2pyO8Oo1XZa8=;
        b=BMUQ1ZMRsuFncYMpIzYZJq8LgXQbNlL/cbJDk1kqUlHsHeAlRTOqIshIfMmtKDwa7R
         6nUlEqIN4TcOIJGV8wbH18RwA6zudb2odi5UCB2VpdZNSlN8KMQXsmmLZ2N4olQG5b2Q
         7XuHy5tdrtnBmqqD2vnXGAdxUthV3qQvxTNVL7OVmiA+xwJa5m72/Z4T3yt4ufqtpe6i
         fjoJ78nsexb2WcfqErO/Y9f1Lsu/5N6G5l/dK7ybKf/fzGi3OBWKdnwGK2L8fQTpQTRx
         jzSZGzDDUra8ctyTBAsP97nh1RtUxE0ktJer5TbDl8bg31VWgoyWw2hEMkymnyxWNOe8
         ifPA==
X-Forwarded-Encrypted: i=1; AJvYcCXYlEvzNVfhFFh9LMmS6GiSQB2Dp1jHa3YTAY2M5PCY9dbeCNNO04s3Jp7UfGxQReF27WOy22E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxixxbGrIHtbnGA7vOxYMNg7HT7wVrFM+wSyFNsgEPBQGeQrOKH
	i398v6OukA62F/inRIRcQXu+fNQvnknTo5Xldf3XcBKiM1gHw+0IZnKU7n5osAY8Eix/Ulet/jc
	R69v9QG+zyUTdo+Ja5dZLTcKxowtghIcS826LlW9S67xVk3SXoTtrVw==
X-Gm-Gg: ASbGncs9bH3M9vt5lhJxN+u5eTnAFGQCZdNtki8YaecsiXdi66GRzMuBSU7KWzZf1MD
	tpq3tumBl+fsonEu/MoXsHg9RrdZDTLPb5OJTkHNUda8yPPc6GEjDt2l4u/X9ifINpAA6n9h6K7
	8bRO/quDj8W1p7aIEcxr4d+Zpfl9cMzQGHdBF+MOkD4SLctMv/+Rk1Bc0s0EWz4Qm/5o3f3emdG
	jrKDV4COPcytdE3hJSPBDVm/SbiuioHHDv+la8nL9M/v3CrZl0J1qED2AndOXa4AllZevJjtQ==
X-Received: by 2002:a05:620a:4094:b0:7b6:db05:1435 with SMTP id af79cd13be357-7be6320c108mr3150895285a.10.1737561671998;
        Wed, 22 Jan 2025 08:01:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2zGkE94SUjCftUqQ/6Wsu0C5dAR/r3uSM8TXId9D4r2wyxUWiBhUy9no8+elSdb5HQRT1+w==
X-Received: by 2002:a05:620a:4094:b0:7b6:db05:1435 with SMTP id af79cd13be357-7be6320c108mr3150891285a.10.1737561671681;
        Wed, 22 Jan 2025 08:01:11 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614743easm674872885a.24.2025.01.22.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:01:11 -0800 (PST)
Date: Wed, 22 Jan 2025 17:01:07 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 3/6] vsock/test: Introduce vsock_bind()
Message-ID: <xzvqojpgicztj3waxetzemx5kzmjy57yl5hv5t7y2sh4bda27l@wwvuhac6zkgg>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-3-aad6069a4e8c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-3-aad6069a4e8c@rbox.co>

On Tue, Jan 21, 2025 at 03:44:04PM +0100, Michal Luczaj wrote:
>Add a helper for socket()+bind(). Adapt callers.
>
>Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 17 +-----------
> 3 files changed, 25 insertions(+), 49 deletions(-)
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
If you need to send a v3, it would be nice to have a comment for 
vsock_bind, as there used to be one.
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
>2.48.1
>

Thanks for the patch, I left small a comment, but if no v3 is needed 
then:

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


