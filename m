Return-Path: <netdev+bounces-175794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D30A677AC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3616F70B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C720F09F;
	Tue, 18 Mar 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aey0y2P2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BC20F066
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311484; cv=none; b=Tg6orBGDgh5Yj+xgMYUmW6StiLbHXFAhYnJui43x/y2vjN83zQP5z0dU5ytaZPwTyhGX/B7seln09ZvU3GnStXl4rDdTrejXJn05LoLEMkOUYSs5A6+z5/9R+lr4S0kWYKMQYqOJhiXOfcobuozl4AYY2Mu7BGD4H6on/HJfhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311484; c=relaxed/simple;
	bh=nwUVJN4gAnpHbpMJTe6ZpZkbPRBWjH0WP7Gslu1wwWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5+CCzh76uNr+ybHhFIAKZiAVKVCrj+PcUzBkJcQ/zgyn0jOdflcFE4xjAKXjT57H1/B7HRpG5VowEl2es7QgdtlmeofXnAKjHQSnXwmr6c+WWkDm9n8/8mXAwonHdHdN5uU0gjyTR7sq8z5xm6rcKXE5CVpLKphU/FpCidg5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aey0y2P2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hqTTkSk1AS0bS0c1yGdSEW4YtI0XIvKuEUyQjEJj824=;
	b=Aey0y2P23eIFJLDaRiNaUclg7iHGoofSSedsy83d54GUdsNwVGRi50d5ksr3f0r3hR39M3
	VtkCZU2enlQ2xMZld/ZPTPGKgrCF4qbY4zIE7S1vaTkNz/+r2hCCqJ06U17jls7mvOSVuK
	5uyqTMeTx1s+hiSEj/CCpnHy3aRWyI4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-bLfBJ5soOO266TfCN80n-w-1; Tue, 18 Mar 2025 11:24:35 -0400
X-MC-Unique: bLfBJ5soOO266TfCN80n-w-1
X-Mimecast-MFC-AGG-ID: bLfBJ5soOO266TfCN80n-w_1742311474
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac297c79dabso571443866b.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311474; x=1742916274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqTTkSk1AS0bS0c1yGdSEW4YtI0XIvKuEUyQjEJj824=;
        b=ka5PiJ69lkChdVJH/f/Eg1iiR5eOy60BSWqP2Ff+jDVvHsBYiSC/muh7h+Uq0MyNU9
         ix1M5f5z1d8guGnpHrXbCY2Q89LoL8hQqLCKQsytn1bnyNR1l/VnoJq9xbqFumtcXxsi
         SH4bBZpPNS6XlPhf8WzQR4q3tHl7B82OwTp2g+ypBKsJlkUGKObYO78hQ8cHWwvxi2vr
         Z8eKt2HNiqCyBJsflkEM76eKUiNSGlJP/fcEAHzzsF1vsxwibYgG86nZTMWRJIAW+6r1
         X/eZ9Vho8LFXf49pbtzCnl9hPIcb2fXxXbr26LrI1e6CbpVNiqY3+1389oSfe22iGofF
         jAow==
X-Forwarded-Encrypted: i=1; AJvYcCXy/vVh/tyTr2k2xMVmHmxg9pPyye3owmF4DDRPtXNoxaZ18TPEv0kWGE0nFcukifBISZkLqO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWFbLBx7EgxwVQqWoqPG7JYpKiNbQp2qHAr2qz9HgsjZsICud
	ToDwkaRkpp5SZCgKbbfgVj74+SsbSc3amux212SeDq2Af2RTq0cmeS0AQFBkJPLIbde1gkgsPC0
	JScFbrzJlIYLJgyHDAz5hgpKR7hB9NSwDWr5aohY5JCcq/KbaBgANAg==
X-Gm-Gg: ASbGncuX1uxeUiojuc/MhzoFJOEkKKcosfhlr6A31ql3tHQ6vt8s2hqHBs9KMHRvgOz
	97qjWcpoJNiwugQklMwrlZaGopZz559egTniAccyGq5DAdZB0LnF5NhJKIGEDWHbiq1jVD7fOL5
	xqif4MAZAyyeQDzVuVS7lOO+LshdJk4Mh6Il5ElHHzx4WBvj0t+J66U9lQh+uvMLmYwtMuP9FhU
	jRuVHltB34B9SQI/AMSz4uP0rQ+/lonujl2VUpQkMPJB3SsYV75XTfRIP18UlqgkKRICGJQTZgi
	q+qN6B8tewE+xkOorgohcy3ba2k0gJ5KkJycqKecrDCALQEHTxWQdNIlFYmSCE1P
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr1889901866b.10.1742311473956;
        Tue, 18 Mar 2025 08:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKgdyBOe4N9SqzNdQv0/ja/tFgBWXAA/B9X5QxvZp4bZLbnQYU/EpiDkc3dvPqkEg8rOP6g==
X-Received: by 2002:a17:907:d92:b0:abe:fa18:1fc6 with SMTP id a640c23a62f3a-ac33010b594mr1889895666b.10.1742311473178;
        Tue, 18 Mar 2025 08:24:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac37dc4e0afsm292211266b.21.2025.03.18.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:24:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:24:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v2] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <tjuxwbbkwyi2ggjv6744h27rkk3kjhdbkv6mnzflg22brhakzq@dvcduolqwhl6>
References: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com>

On Fri, Mar 14, 2025 at 10:27:33AM +0100, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur[1].

I'd add something like this:

"... does not occur. The bug was reported upstream [1] and fixed with
commit 2cb7c756f605 ("vsock/virtio: discard packets if the transport
changes")."

>
>Note that this test does not fail, but it may hang on the client side if
>it triggers a kernel oops.

In my case the test failed (I guess the other side that was still
working), so I'd say: "Note that this test may not fail in a kernel
without the fix, ..."

>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is safe to assume that the bug will show up within the timeout period.

s/safe/reasonable

>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass.

The rest LGTM.

Thanks,
Stefano

>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>This series introduces a new test that checks for a null pointer
>dereference that may happen when there is a transport change[1]. This
>bug was fixed in [2].
>
>Note that this test *cannot* fail, it hangs if it triggers a kernel
>oops. The intended use-case is to run it and then check if there is any
>oops in the dmesg.
>
>This test is based on Hyunwoo Kim's[3] and Michal's python
>reproducers[4].
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
>[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
>[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/
>---
>Changes in v2:
>- Addressed Stefano's comments:
>    - Timeout is now using current_nsec()
>    - Check for return values
>    - Style issues
>- Added Hyunwoo Kim to Suggested-by
>- Link to v1: https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/vsock_test.c | 101 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 102 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 6e0b4e95e230500f99bb9c74350701a037ecd198..88211fd132d23ecdfd56ab0815580a237889e7f2 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -5,6 +5,7 @@ vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_ze
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> vsock_perf: vsock_perf.o msg_zerocopy_common.o
>
>+vsock_test: LDLIBS = -lpthread
> vsock_uring_test: LDLIBS = -luring
> vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..d2820a67403c95bc4a7e7a16113ae2f6137b4c73 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -23,6 +23,7 @@
> #include <sys/ioctl.h>
> #include <linux/sockios.h>
> #include <linux/time64.h>
>+#include <pthread.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1788,6 +1789,101 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void *test_stream_transport_change_thread(void *vargp)
>+{
>+	pid_t *pid = (pid_t *)vargp;
>+
>+	/* We want this thread to terminate as soon as possible */
>+	if (pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL)) {
>+		perror("pthread_setcanceltype");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	while (true) {
>+		if (kill(*pid, SIGUSR1) < 0) {
>+			perror("kill");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+	return NULL;
>+}
>+
>+static void test_transport_change_signal_handler(int signal)
>+{
>+	/* We need a custom handler for SIGUSR1 as the default one terminates the process. */
>+}
>+
>+static void test_stream_transport_change_client(const struct test_opts *opts)
>+{
>+	__sighandler_t old_handler;
>+	pid_t pid = getpid();
>+	pthread_t thread_id;
>+	time_t tout;
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+	if (old_handler == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid)) {
>+		perror("pthread_create");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		struct sockaddr_vm sa = {
>+			.svm_family = AF_VSOCK,
>+			.svm_cid = opts->peer_cid,
>+			.svm_port = opts->peer_port,
>+		};
>+		int s;
>+
>+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>+		if (s < 0) {
>+			perror("socket");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		/* Set CID to 0 cause a transport change. */
>+		sa.svm_cid = 0;
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		close(s);
>+	} while (current_nsec() < tout);
>+
>+	if (pthread_cancel(thread_id)) {
>+		perror("pthread_cancel");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait for the thread to terminate */
>+	if (pthread_join(thread_id, NULL)) {
>+		perror("pthread_join");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Restore the old handler */
>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_transport_change_server(const struct test_opts *opts)
>+{
>+	time_t tout = current_nsec() + TIMEOUT * NSEC_PER_SEC;
>+
>+	do {
>+		int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+
>+		close(s);
>+	} while (current_nsec() < tout);
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
>@@ -1984,6 +2080,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.run_client = test_stream_transport_change_client,
>+		.run_server = test_stream_transport_change_server,
>+	},
> 	{},
> };
>
>
>---
>base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
>change-id: 20250306-test_vsock-3e77a9c7a245
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


