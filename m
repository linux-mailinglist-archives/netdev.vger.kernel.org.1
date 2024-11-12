Return-Path: <netdev+bounces-144004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3389C5151
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B124B1F2212B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4720C02B;
	Tue, 12 Nov 2024 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAYKfXPQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446DC20C00A
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401932; cv=none; b=mIAjKRyLFJrFUXN7NoKnPyuRCXL6EHgQmK30YJ6uu5SghmD4SXn6nIZ1bQnrDnZTfJLaYSQX3zB8K3NTQMDxuYQ7jr4PbDwIL4NFo1Imffomg10f2XTWBtGKcqzZ0h5pCS0I6B9xE7RoYu3xLG3v7WV6+5Es+HVaV+WsJClcfyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401932; c=relaxed/simple;
	bh=reEMUAi1QnDqIWb4QcQl+4DP5qs65V5sOCNGSMiDabU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEDiXGcrRpVeOua6y8kuYYjw6mnxo2MlKsZ9A2PtJNh/+tpQEWhH0bTR8NIelQQpAi2P/uEYRKyzKnaE8aGXLAyaNMqama3FQhbC5mFbbYUE7WP07yTReokjLGydAJM5v/nJSvDFRuZiZ+xIGAhBwBcW0kX976loCx0TY8Ow8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAYKfXPQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731401928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPptTmbxDsypCGvPECMl6oSCV1GXbmYdDQ4GWXHyOFo=;
	b=XAYKfXPQGpblegpWquQrNzAM9i4oOQN4Cn/NwcIg0M4U6zYtj8AAsekbP8QNJCHCcYktKu
	kHSnp4XRjghk+z7FdtGZh6kvulqE/o098LqD4MN5ua44VvoeMehfi+BC/Ub5i+jLXT/2X8
	lvg+v1+TcWuJ2zvanGHH2o3U3iSeGtw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-XTAferi1NPet9058UQgw0Q-1; Tue, 12 Nov 2024 03:58:46 -0500
X-MC-Unique: XTAferi1NPet9058UQgw0Q-1
X-Mimecast-MFC-AGG-ID: XTAferi1NPet9058UQgw0Q
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539e0fa6f3dso4064089e87.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 00:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401925; x=1732006725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPptTmbxDsypCGvPECMl6oSCV1GXbmYdDQ4GWXHyOFo=;
        b=T/jytd+S7cOo7OBYYgPTg4ncgw1cE615nY2Nd20hYZDdl0BQl2fTQA1s47eRTcDV7a
         FjtdI5XFC0Xf7qSBIqfRJvd8T9wONCRQAOXsaeuBlyPnm7sD0mY8EPt5IqcrvvDnblNy
         o9l7NQbFLX+VKQ/7Mcgt3lz/eUp8bMLsdQpnp+AHcd9w1b+fhyQKUtzHiEoWPLHB8hsZ
         zEC7KbcSpdD4A1122ASQkk7HD6uxDLoGjtjLAwWIjw4j22JQayCXmtdhMaOTXh4QEGxl
         8/vc6Bt1Q76UCCpxQqVj8LuWjjkBbnCuWtIrr3KMtxm6EgTDGHTgf8OH0KZau29iObwu
         SNEw==
X-Forwarded-Encrypted: i=1; AJvYcCUmOUWDfRHKfm9Xkix1qhUSFuMtwGwMMZoSgUDPawdOLzvMIkYe0E3pW0wTR4n+R5AQLQGwqr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyYcLH6VsHyzWkAtaLyL7YIlYp+UFMa5msAvvrW2A5Vfco0Z1
	1P/oOqmVpbPl6zC9vZKwEiZLvQG7FBEu4a0YeeJMvqJIUDsxdTErg8WKzeo9J8Pbu9qRyVDoMAT
	28fAWMShgJ7kT0GkOgohSLTN42myvlBftXgYvn8frLEwO4GW4o7PLPw==
X-Received: by 2002:a05:6512:230e:b0:536:a4f1:d214 with SMTP id 2adb3069b0e04-53d862c6e44mr11355537e87.19.1731401924687;
        Tue, 12 Nov 2024 00:58:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHESdaruTqKXD8wNS5cPcSQBu3Jt/KOIsg2NV8sVzgjBpgWNkRHfN86pa3KSfybNzE1Ut550w==
X-Received: by 2002:a05:6512:230e:b0:536:a4f1:d214 with SMTP id 2adb3069b0e04-53d862c6e44mr11355505e87.19.1731401923910;
        Tue, 12 Nov 2024 00:58:43 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4ab89sm701336966b.64.2024.11.12.00.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:58:43 -0800 (PST)
Date: Tue, 12 Nov 2024 09:58:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 3/3] vsock/test: verify socket options after setting
 them
Message-ID: <bltkmoxf6xsknimf6ccrxuritfc3ipxhbqkibq7jzddg6yewcv@ijcc44qmqsm3>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-4-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241108011726.213948-4-kshk@linux.ibm.com>

On Thu, Nov 07, 2024 at 07:17:26PM -0600, Konstantin Shkolnyy wrote:
>Replace setsockopt() calls with calls to functions that follow
>setsockopt() with getsockopt() and check that the returned value and its
>size are the same as have been set.
>
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/Makefile              |   8 +-
> tools/testing/vsock/control.c             |   8 +-
> tools/testing/vsock/msg_zerocopy_common.c |   8 +-
> tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
> tools/testing/vsock/util_socket.h         |  19 +++
> tools/testing/vsock/vsock_perf.c          |  24 ++--
> tools/testing/vsock/vsock_test.c          |  40 +++---
> 7 files changed, 208 insertions(+), 48 deletions(-)
> create mode 100644 tools/testing/vsock/util_socket.c
> create mode 100644 tools/testing/vsock/util_socket.h
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 6e0b4e95e230..1ec0b3a67aa4 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -1,12 +1,12 @@
> # SPDX-License-Identifier: GPL-2.0-only
> all: test vsock_perf
> test: vsock_test vsock_diag_test vsock_uring_test
>-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o
>-vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>-vsock_perf: vsock_perf.o msg_zerocopy_common.o
>+vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o util_socket.o
>+vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o util_socket.o
>+vsock_perf: vsock_perf.o msg_zerocopy_common.o util_socket.o

I would add the new functions to check setsockopt in util.c

vsock_perf is more of a tool to measure performance than a test, so
we can avoid calling these checks there, tests should cover all
cases regardless of vsock_perf.

>
> vsock_uring_test: LDLIBS = -luring
>-vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>+vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o util_socket.o
>
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include 
> -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow 
> -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
>diff --git a/tools/testing/vsock/control.c b/tools/testing/vsock/control.c
>index d2deb4b15b94..f1fd809ac9d5 100644
>--- a/tools/testing/vsock/control.c
>+++ b/tools/testing/vsock/control.c
>@@ -27,6 +27,7 @@
>
> #include "timeout.h"
> #include "control.h"
>+#include "util_socket.h"
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
>@@ -65,11 +65,9 @@ void control_init(const char *control_host,
> 			break;
> 		}
>
>-		if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR,
>-			       &val, sizeof(val)) < 0) {
>-			perror("setsockopt");
>+		if (!setsockopt_int_check(fd, SOL_SOCKET, SO_REUSEADDR, 1,
>+				"setsockopt SO_REUSEADDR"))
> 			exit(EXIT_FAILURE);
>-		}
>
> 		if (bind(fd, ai->ai_addr, ai->ai_addrlen) < 0)
> 			goto next;
>diff --git a/tools/testing/vsock/msg_zerocopy_common.c b/tools/testing/vsock/msg_zerocopy_common.c
>index 5a4bdf7b5132..4edb1b6974c0 100644
>--- a/tools/testing/vsock/msg_zerocopy_common.c
>+++ b/tools/testing/vsock/msg_zerocopy_common.c
>@@ -13,15 +13,13 @@
> #include <linux/errqueue.h>
>
> #include "msg_zerocopy_common.h"
>+#include "util_socket.h"
>
> void enable_so_zerocopy(int fd)
> {
>-	int val = 1;
>-
>-	if (setsockopt(fd, SOL_SOCKET, SO_ZEROCOPY, &val, sizeof(val))) {
>-		perror("setsockopt");
>+	if (!setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
>+			"setsockopt SO_ZEROCOPY"))
> 		exit(EXIT_FAILURE);
>-	}
> }
>
> void vsock_recv_completion(int fd, const bool *zerocopied)
>diff --git a/tools/testing/vsock/util_socket.c b/tools/testing/vsock/util_socket.c
>new file mode 100644
>index 000000000000..e791da160624
>--- /dev/null
>+++ b/tools/testing/vsock/util_socket.c
>@@ -0,0 +1,149 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * Socket utility functions.
>+ *
>+ * Copyright IBM Corp. 2024
>+ */
>+#include <errno.h>
>+#include <inttypes.h>
>+#include <stdio.h>
>+#include <string.h>
>+#include <sys/socket.h>
>+#include "util_socket.h"
>+
>+/* Set "unsigned long long" socket option and check that it's indeed set */
>+bool setsockopt_ull_check(int fd, int level, int optname,
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
>+	return true;
>+fail:
>+	fprintf(stderr, "%s  val %llu\n", errmsg, val);
>+	return false;
>+}
>+
>+/* Set "int" socket option and check that it's indeed set */
>+bool setsockopt_int_check(int fd, int level, int optname, int val,
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
>+	return true;
>+fail:
>+	fprintf(stderr, "%s val %d\n", errmsg, val);
>+	return false;
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
>+bool setsockopt_timeval_check(int fd, int level, int optname,
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
>+	return true;
>+fail:
>+	fprintf(stderr, "%s val %ld:%ld\n", errmsg, val.tv_sec, val.tv_usec);
>+	return false;
>+}
>diff --git a/tools/testing/vsock/util_socket.h b/tools/testing/vsock/util_socket.h
>new file mode 100644
>index 000000000000..38cf3decb15c
>--- /dev/null
>+++ b/tools/testing/vsock/util_socket.h
>@@ -0,0 +1,19 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * Socket utility functions.
>+ *
>+ * Copyright IBM Corp. 2024
>+ */
>+#ifndef UTIL_SOCKET_H
>+#define UTIL_SOCKET_H
>+
>+#include <stdbool.h>
>+
>+bool setsockopt_ull_check(int fd, int level, int optname,
>+		unsigned long long val, char const *errmsg);
>+bool setsockopt_int_check(int fd, int level, int optname, int val,
>+		char const *errmsg);
>+bool setsockopt_timeval_check(int fd, int level, int optname,
>+		struct timeval val, char const *errmsg);

We call of them in the same way in the tests:

if (!setsockopt...check(...))
     exit(EXIT_FAILURE);

So, what about making them void and calling exit in the functions?

We already do this in other functions.

Thanks for this work!
Stefano

>+
>+#endif /* UTIL_SOCKET_H */
>diff --git a/tools/testing/vsock/vsock_perf.c b/tools/testing/vsock/vsock_perf.c
>index 8e0a6c0770d3..b117e043b87b 100644
>--- a/tools/testing/vsock/vsock_perf.c
>+++ b/tools/testing/vsock/vsock_perf.c
>@@ -21,6 +21,7 @@
> #include <sys/mman.h>
>
> #include "msg_zerocopy_common.h"
>+#include "util_socket.h"
>
> #define DEFAULT_BUF_SIZE_BYTES	(128 * 1024)
> #define DEFAULT_TO_SEND_BYTES	(64 * 1024)
>@@ -88,13 +89,16 @@ static unsigned long memparse(const char *ptr)
>
> static void vsock_increase_buf_size(int fd)
> {
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>-		       &vsock_buf_bytes, sizeof(vsock_buf_bytes)))
>-		error("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+	if (!setsockopt_ull_check(fd, AF_VSOCK,
>+			SO_VM_SOCKETS_BUFFER_MAX_SIZE, vsock_buf_bytes,
>+			"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)"))
>+		exit(EXIT_FAILURE);
>+
>+	if (!setsockopt_ull_check(fd, AF_VSOCK,
>+			SO_VM_SOCKETS_BUFFER_SIZE, vsock_buf_bytes,
>+			"setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)"))
>+		exit(EXIT_FAILURE);
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &vsock_buf_bytes, sizeof(vsock_buf_bytes)))
>-		error("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
> }
>
> static int vsock_connect(unsigned int cid, unsigned int port)
>@@ -183,10 +187,10 @@ static void run_receiver(int rcvlowat_bytes)
>
> 	vsock_increase_buf_size(client_fd);
>
>-	if (setsockopt(client_fd, SOL_SOCKET, SO_RCVLOWAT,
>-		       &rcvlowat_bytes,
>-		       sizeof(rcvlowat_bytes)))
>-		error("setsockopt(SO_RCVLOWAT)");
>+
>+	if (!setsockopt_int_check(client_fd, SOL_SOCKET, SO_RCVLOWAT,
>+			rcvlowat_bytes, "setsockopt(SO_RCVLOWAT)"))
>+		exit(EXIT_FAILURE);
>
> 	data = malloc(buf_size_bytes);
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index c7af23332e57..3764dca1118e 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -27,6 +27,7 @@
> #include "timeout.h"
> #include "control.h"
> #include "util.h"
>+#include "util_socket.h"
>
> static void test_stream_connection_reset(const struct test_opts *opts)
> {
>@@ -444,17 +445,14 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
>
> 	sock_buf_size = SOCK_BUF_SIZE;
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>-		       &sock_buf_size, sizeof(sock_buf_size))) {
>-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+	if (!setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+			sock_buf_size,
>+			"setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)"))
> 		exit(EXIT_FAILURE);
>-	}
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &sock_buf_size, sizeof(sock_buf_size))) {
>-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+	if (!setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       sock_buf_size, "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)"))
> 		exit(EXIT_FAILURE);
>-	}
>
> 	/* Ready to receive data. */
> 	control_writeln("SRVREADY");
>@@ -586,10 +584,9 @@ static void test_seqpacket_timeout_client(const struct test_opts *opts)
> 	tv.tv_sec = RCVTIMEO_TIMEOUT_SEC;
> 	tv.tv_usec = 0;
>
>-	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (void *)&tv, sizeof(tv)) == -1) {
>-		perror("setsockopt(SO_RCVTIMEO)");
>+	if (!setsockopt_timeval_check(fd, SOL_SOCKET, SO_RCVTIMEO, tv,
>+			"setsockopt(SO_RCVTIMEO)"))
> 		exit(EXIT_FAILURE);
>-	}
>
> 	read_enter_ns = current_nsec();
>
>@@ -855,9 +852,8 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>-		       &lowat_val, sizeof(lowat_val))) {
>-		perror("setsockopt(SO_RCVLOWAT)");
>+	if (!setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
>+		       lowat_val, "setsockopt(SO_RCVLOWAT)")) {
> 		exit(EXIT_FAILURE);
> 	}
>
>@@ -1383,11 +1379,9 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	/* size_t can be < unsigned long long */
> 	sock_buf_size = buf_size;
>
>-	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>-		       &sock_buf_size, sizeof(sock_buf_size))) {
>-		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+	if (!setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       sock_buf_size, "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)"))
> 		exit(EXIT_FAILURE);
>-	}
>
> 	if (low_rx_bytes_test) {
> 		/* Set new SO_RCVLOWAT here. This enables sending credit
>@@ -1396,9 +1390,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 		 */
> 		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>
>-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>-			       &recv_buf_size, sizeof(recv_buf_size))) {
>-			perror("setsockopt(SO_RCVLOWAT)");
>+		if (!setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       recv_buf_size, "setsockopt(SO_RCVLOWAT)")) {
> 			exit(EXIT_FAILURE);
> 		}
> 	}
>@@ -1442,9 +1435,8 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 		recv_buf_size++;
>
> 		/* Updating SO_RCVLOWAT will send credit update. */
>-		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>-			       &recv_buf_size, sizeof(recv_buf_size))) {
>-			perror("setsockopt(SO_RCVLOWAT)");
>+		if (!setsockopt_int_check(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       recv_buf_size, "setsockopt(SO_RCVLOWAT)")) {
> 			exit(EXIT_FAILURE);
> 		}
> 	}
>-- 
>2.34.1
>


