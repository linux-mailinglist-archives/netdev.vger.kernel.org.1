Return-Path: <netdev+bounces-144816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1359C8860
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3199DB34ADA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B231FA259;
	Thu, 14 Nov 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX0W7FAo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2101FA252
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580139; cv=none; b=dzkiPnZLD1nNjWwiGB0pgu4tq1uXp7L5HbUtsPSNpKcL93h87FWlnywp44sREc5nptZeev9dviE9Jv/Dy/AMt975+fNk/37Ew4JGKL7gLWkLDjiiohoYX7X7MoeNfC9b1Iaup3l6bCuDDYCQFVuwuCk2uqd1MmFMZodK0vAiHpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580139; c=relaxed/simple;
	bh=mSOoFAS7GLos5np9WRDIwERBr1KMROa14E94IZsN2kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeBvOi3hLrC7GVte3RKnSstt394bn0TJF/t+Aj4gvTav/i8jchBpa0Aao+ejg78pE9vvGPMyPmtAoppcV+j0etbl1doC5UHXi45KXMreINkpaAidSZ9xvoD98zbOyDqNhyCeVfspxx3UUQNVaYGxkXKLhvE/lLlOCi8maPhqlZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX0W7FAo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731580136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3j+0i9lzXsrLcMtjqqIs546kXZUBezX6NRapC01y/iA=;
	b=BX0W7FAot3YPplv5KXd3bxM8INMZAxF7iBu/aTDNeSwoN8y0BSt+QAE02KVD+67eck3xvX
	u2JWG+R0DGW8SHWOVCtjk03kMDL/gM+5vp86YHCkB59wldWmd36EIXXTJj+Pts12P5cnKU
	fDR+MFqzEqwCRHhmx6zAh+09FSGWKMA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-y60fpuFXNSqZtzff3Eitaw-1; Thu, 14 Nov 2024 05:28:55 -0500
X-MC-Unique: y60fpuFXNSqZtzff3Eitaw-1
X-Mimecast-MFC-AGG-ID: y60fpuFXNSqZtzff3Eitaw
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a2c3e75f0so42545866b.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 02:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580133; x=1732184933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j+0i9lzXsrLcMtjqqIs546kXZUBezX6NRapC01y/iA=;
        b=pozjTb2jpkz3+uc/uKK5o2pXj1Gpv48eJ9b+Rf5hkZ7V9DfamplbFHPOiKfZraMxGj
         3XK+LHqpEJcYNqFXftyUabwCJ1831fRphg3/W6CGFDToOK+hrd+dp8pKmfn38YfqRU8z
         l4bL3yYWs3CU9ssCEc4V3cdXIQCGgmXswP7uPkhJc2ofKAx89aNkDiQuZ+DsgyvHN1D+
         HeEm+hcjgwmIKbaUFq/BHg3Xls/ixJGo9pdR1/MEMjuEhoH24DTHak4tPkk06equyYxa
         dd0AFy1toPtLrOLSEXyWRJ+l4MVsetaiK3F+02PYaOclOJfRnWsNlJdzF6P/krzM+zs3
         QUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgbSMwLy/j5sS07pVxevFbNxj00qDmo37csPZQ7rIsPVgBi9/Q0hGboIPekFcY+1G2nx491fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXtBjjVeLSeDzPgDROAo3w0yFh7iZ9p0H9SVvbGtzVs9mdvxp
	AGicI2o2bcPRhic8x9FTgAmQ/S66Tv3Xz4aSzv8mltgdNMpPnsPrC6gM2PxP9lBxqg6V9hvWBEx
	LHu7XIyhH0rhxmsmQRDFvGMazaGR3UgwEoIZE9Cot0CR1vxi44oADbA==
X-Received: by 2002:a17:906:a2c7:b0:aa3:722c:cc8a with SMTP id a640c23a62f3a-aa3722ccf24mr79913266b.40.1731580133336;
        Thu, 14 Nov 2024 02:28:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0FlbUvth7+hOJGzh5Px8aAjrrjmMSwTLUang2GoZd+yqIhuC8OCifNB3tbq891cowKmoxkw==
X-Received: by 2002:a17:906:a2c7:b0:aa3:722c:cc8a with SMTP id a640c23a62f3a-aa3722ccf24mr79909666b.40.1731580132577;
        Thu, 14 Nov 2024 02:28:52 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e045270sm46991566b.146.2024.11.14.02.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:28:51 -0800 (PST)
Date: Thu, 14 Nov 2024 11:28:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v6 3/3] vsock/test: verify socket options after setting
 them
Message-ID: <yo2qj7psn3sqtyqgsfn6y2qtwcmyb4j7gwuffg34gwqwkrsyox@4aff3wvdrdgu>
References: <20241113143557.1000843-1-kshk@linux.ibm.com>
 <20241113143557.1000843-4-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241113143557.1000843-4-kshk@linux.ibm.com>

On Wed, Nov 13, 2024 at 08:35:57AM -0600, Konstantin Shkolnyy wrote:
>Replace setsockopt() calls with calls to functions that follow
>setsockopt() with getsockopt() and check that the returned value and its
>size are the same as have been set. (Except in vsock_perf.)
>
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/control.c             |   9 +-
> tools/testing/vsock/msg_zerocopy_common.c |  10 --
> tools/testing/vsock/msg_zerocopy_common.h |   1 -
> tools/testing/vsock/util.c                | 144 ++++++++++++++++++++++
> tools/testing/vsock/util.h                |   7 ++
> tools/testing/vsock/vsock_perf.c          |  10 ++
> tools/testing/vsock/vsock_test.c          |  49 +++-----
> tools/testing/vsock/vsock_test_zerocopy.c |   2 +-
> tools/testing/vsock/vsock_uring_test.c    |   2 +-
> 9 files changed, 181 insertions(+), 53 deletions(-)
>
>diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
>index d2deb4b15b94..875ef0cfa415 100644
>--- a/tools/testing/vsock/control.c
>+++ b/tools/testing/vsock/control.c
>@@ -27,6 +27,7 @@
>
> #include "timeout.h"
> #include "control.h"
>+#include "util.h"
>
> static int control_fd = -1;
>
>@@ -50,7 +51,6 @@ void control_init(const char *control_host,
>
> 	for (ai = result; ai; ai = ai->ai_next) {
> 		int fd;
>-		int val = 1;
>
> 		fd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> 		if (fd < 0)
>@@ -65,11 +65,8 @@ void control_init(const char *control_host,
> 			break;
> 		}
>
>-		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
>-			       &val, sizeof(val)) < 0) {
>-			perror("setsockopt");
>-			exit(EXIT_FAILURE);
>-		}
>+		setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
>+				"setsockopt SO_REUSEADDR");
>
> 		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
> 			goto next;
>diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
>index 5a4bdf7b5132..8622e5a0f8b7 100644
>--- a/tools/testing/vsock/msg_zerocopy_common.c
>+++ b/tools/testing/vsock/msg_zerocopy_common.c
>@@ -14,16 +14,6 @@
>
> #include "msg_zerocopy_common.h"
>
>-void enable_so_zerocopy(int fd)
>-{
>-	int val = 1;
>-
>-	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
>-		perror("setsockopt");
>-		exit(EXIT_FAILURE);
>-	}
>-}
>-

Since the new API has a different name (i.e.
`enable_so_zerocopy_check()`), this `enable_so_zerocopy()` could stay
here, anyway I don't want to be too picky, I'm totally fine with this
change since it's now only used by vsock_perf ;-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> void vsock_recv_completion(int fd, const bool *zerocopied)
> {
> 	struct sock_extended_err *serr;
>diff --git a/tools/testing/vsock/msg_zerocopy_common.h b/tools/testing/vsock/msg_zerocopy_common.h
>index 3763c5ccedb9..ad14139e93ca 100644
>--- a/tools/testing/vsock/msg_zerocopy_common.h
>+++ b/tools/testing/vsock/msg_zerocopy_common.h
>@@ -12,7 +12,6 @@
> #define VSOCK_RECVERR	1
> #endif
>
>-void enable_so_zerocopy(int fd);
> void vsock_recv_completion(int fd, const bool *zerocopied);
>
> #endif /* MSG_ZEROCOPY_COMMON_H */
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index a3d448a075e3..e79534b52477 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -651,3 +651,147 @@ void free_test_iovec(const struct iovec *test_iovec,
>
> 	free(iovec);
> }
>+
>+/* Set "unsigned long long" socket option and check that it's indeed set */
>+void setsockopt_ull_check(int fd, int level, int optname,
>+	unsigned long long val, char const *errmsg)
>+{
>+	unsigned long long chkval;
>+	socklen_t chklen;
>+	int err;
>+
>+	err = setsockopt(fd, level, optname, &val, sizeof(val));
>+	if (err) {
>+		fprintf(stderr, "setsockopt err: %s (%d)\n",
>+				strerror(errno), errno);
>+		goto fail;
>+	}
>+
>+	chkval = ~val; /* just make storage != val */
>+	chklen = sizeof(chkval);
>+
>+	err = getsockopt(fd, level, optname, &chkval, &chklen);
>+	if (err) {
>+		fprintf(stderr, "getsockopt err: %s (%d)\n",
>+				strerror(errno), errno);
>+		goto fail;
>+	}
>+
>+	if (chklen != sizeof(chkval)) {
>+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
>+				chklen);
>+		goto fail;
>+	}
>+
>+	if (chkval != val) {
>+		fprintf(stderr, "value mismatch: set %llu got %llu\n", val,
>+				chkval);
>+		goto fail;
>+	}
>+	return;
>+fail:
>+	fprintf(stderr, "%s  val %llu\n", errmsg, val);
>+	exit(EXIT_FAILURE);
>+;
>+}
>+
>+/* Set "int" socket option and check that it's indeed set */
>+void setsockopt_int_check(int fd, int level, int optname, int val,
>+		char const *errmsg)
>+{
>+	int chkval;
>+	socklen_t chklen;
>+	int err;
>+
>+	err = setsockopt(fd, level, optname, &val, sizeof(val));
>+	if (err) {
>+		fprintf(stderr, "setsockopt err: %s (%d)\n",
>+				strerror(errno), errno);
>+		goto fail;
>+	}
>+
>+	chkval = ~val; /* just make storage != val */
>+	chklen = sizeof(chkval);
>+
>+	err = getsockopt(fd, level, optname, &chkval, &chklen);
>+	if (err) {
>+		fprintf(stderr, "getsockopt err: %s (%d)\n",
>+				strerror(errno), errno);
>+		goto fail;
>+	}
>+
>+	if (chklen != sizeof(chkval)) {
>+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
>+				chklen);
>+		goto fail;
>+	}
>+
>+	if (chkval != val) {
>+		fprintf(stderr, "value mismatch: set %d got %d\n",
>+				val, chkval);
>+		goto fail;
>+	}
>+	return;
>+fail:
>+	fprintf(stderr, "%s val %d\n", errmsg, val);
>+	exit(EXIT_FAILURE);
>+}
>+
>+static void mem_invert(unsigned char *mem, size_t size)
>+{
>+	size_t i;
>+
>+	for (i = 0; i < size; i++)
>+		mem[i] = ~mem[i];
>+}
>+
>+/* Set "timeval" socket option and check that it's indeed set */
>+void setsockopt_timeval_check(int fd, int level, int optname,
>+		struct timeval val, char const *errmsg)
>+{
>+	struct timeval chkval;
>+	socklen_t chklen;
>+	int err;
>+
>+	err = setsockopt(fd, level, optname, &val, sizeof(val));
>+	if (err) {
>+		fprintf(stderr, "setsockopt err: %s (%d)\n",
>+				strerror(errno), errno);
>+		goto fail;
>+	}
>+
>+	 /* just make storage != val */
>+	chkval = val;
>+	mem_invert((unsigned char *) &chkval, sizeof(chkval));
>+	chklen = sizeof(chkval);
>+
>+	err = getsockopt(fd, level, optname, &chkval, &chklen);
>+	if (err) {
>+		fprintf(stderr, "getsockopt err: %s (%d)\n",
>+				strerror(errno), errno);
>+		goto fail;
>+	}
>+
>+	if (chklen != sizeof(chkval)) {
>+		fprintf(stderr, "size mismatch: set %zu got %d\n", sizeof(val),
>+				chklen);
>+		goto fail;
>+	}
>+
>+	if (memcmp(&chkval, &val, sizeof(val)) != 0) {
>+		fprintf(stderr, "value mismatch: set %ld:%ld got %ld:%ld\n",
>+				val.tv_sec, val.tv_usec,
>+				chkval.tv_sec, chkval.tv_usec);
>+		goto fail;
>+	}
>+	return;
>+fail:
>+	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
>+	exit(EXIT_FAILURE);
>+}
>+
>+void enable_so_zerocopy_check(int fd)
>+{
>+	setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
>+			"setsockopt SO_ZEROCOPY");
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index fff22d4a14c0..f189334591df 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -68,4 +68,11 @@ unsigned long iovec_hash_djb2(const struct iovec *iov, size_t iovnum);
> struct iovec *alloc_test_iovec(const struct iovec *test_iovec, int iovnum);
> void free_test_iovec(const struct iovec *test_iovec,
> 		     struct iovec *iovec, int iovnum);
>+void setsockopt_ull_check(int fd, int level, int optname,
>+		unsigned long long val, char const *errmsg);
>+void setsockopt_int_check(int fd, int level, int optname, int val,
>+		char const *errmsg);
>+void setsockopt_timeval_check(int fd, int level, int optname,
>+		struct timeval val, char const *errmsg);
>+void enable_so_zerocopy_check(int fd);
> #endif /* UTIL_H */
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 8e0a6c0770d3..75971ac708c9 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -251,6 +251,16 @@ static void run_receiver(int rcvlowat_bytes)
> 	close(fd);
> }
>
>+static void enable_so_zerocopy(int fd)
>+{
>+	int val = 1;
>+
>+	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
>+		perror("setsockopt");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
> static void run_sender(int peer_cid, unsigned long to_send_bytes)
> {
> 	time_t tx_begin_ns;
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index c7af23332e57..0b514643a9a5 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -444,17 +444,12 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
>
> 	sock_buf_size = SOCK_BUF_SIZE;
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>-		       &sock_buf_size, sizeof(sock_buf_size))) {
>-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>-		exit(EXIT_FAILURE);
>-	}
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+			sock_buf_size,
>+			"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &sock_buf_size, sizeof(sock_buf_size))) {
>-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>-		exit(EXIT_FAILURE);
>-	}
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       sock_buf_size, "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>
> 	/* Ready to receive data. */
> 	control_writeln("SRVREADY");
>@@ -586,10 +581,8 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
> 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
> 	tv.tv_usec = 0;
>
>-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
>-		perror("setsockopt(SO_RCVTIMEO)");
>-		exit(EXIT_FAILURE);
>-	}
>+	setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
>+			"setsockopt(SO_RCVTIMEO)");
>
> 	read_enter_ns = current_nsec();
>
>@@ -855,11 +848,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>-		       &lowat_val, sizeof(lowat_val))) {
>-		perror("setsockopt(SO_RCVLOWAT)");
>-		exit(EXIT_FAILURE);
>-	}
>+	setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
>+		       lowat_val, "setsockopt(SO_RCVLOWAT)");
>
> 	control_expectln("SRVSENT");
>
>@@ -1383,11 +1373,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	/* size_t can be < unsigned long long */
> 	sock_buf_size = buf_size;
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &sock_buf_size, sizeof(sock_buf_size))) {
>-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>-		exit(EXIT_FAILURE);
>-	}
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       sock_buf_size, "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>
> 	if (low_rx_bytes_test) {
> 		/* Set new SO_RCVLOWAT here. This enables sending credit
>@@ -1396,11 +1383,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 		 */
> 		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>
>-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>-			       &recv_buf_size, sizeof(recv_buf_size))) {
>-			perror("setsockopt(SO_RCVLOWAT)");
>-			exit(EXIT_FAILURE);
>-		}
>+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       recv_buf_size, "setsockopt(SO_RCVLOWAT)");
> 	}
>
> 	/* Send one dummy byte here, because 'setsockopt()' above also
>@@ -1442,11 +1426,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 		recv_buf_size++;
>
> 		/* Updating SO_RCVLOWAT will send credit update. */
>-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>-			       &recv_buf_size, sizeof(recv_buf_size))) {
>-			perror("setsockopt(SO_RCVLOWAT)");
>-			exit(EXIT_FAILURE);
>-		}
>+		setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       recv_buf_size, "setsockopt(SO_RCVLOWAT)");
> 	}
>
> 	fds.fd = fd;
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>index 04c376b6937f..9d9a6cb9614a 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.c
>+++ b/tools/testing/vsock/vsock_test_zerocopy.c
>@@ -162,7 +162,7 @@ static void test_client(const struct test_opts *opts,
> 	}
>
> 	if (test_data->so_zerocopy)
>-		enable_so_zerocopy(fd);
>+		enable_so_zerocopy_check(fd);
>
> 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
>
>diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
>index 6c3e6f70c457..5c3078969659 100644
>--- a/tools/testing/vsock/vsock_uring_test.c
>+++ b/tools/testing/vsock/vsock_uring_test.c
>@@ -73,7 +73,7 @@ static void vsock_io_uring_client(const struct test_opts *opts,
> 	}
>
> 	if (msg_zerocopy)
>-		enable_so_zerocopy(fd);
>+		enable_so_zerocopy_check(fd);
>
> 	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
>
>-- 
>2.34.1
>


