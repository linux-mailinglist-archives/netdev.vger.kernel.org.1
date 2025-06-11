Return-Path: <netdev+bounces-196617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A2EAD594B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175DD189B696
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E7283FE1;
	Wed, 11 Jun 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzI5EpY7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22828469D
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653603; cv=none; b=A+XbLtrtl/nm4y7Q6Yy6YaoA60RaPps2EhRi+dfsS9l9iagJi2H2o+4oeYIEYND8LXFenPb+7uTrC2QPcbaIIuy4kjthfZ0cGbbZcS02THtxaPEfBJDSZI3lKfC833e9xSI5352pmX8LIU46VhMUQoElkLRDQoYllFgwhMJGPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653603; c=relaxed/simple;
	bh=z/i4/E5DOr+PEti0Bz8z+s8pDPkNo/Hyhatgsrlrrgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWZnk6+h5/gV1qn2Lju2Z4DLc2ANVglZDgXWkd0lkZ79A4U1Henrc3Z1NbT/cHJjfJr3Iivd++J5A34bzjLuDsR/1fckrYMBWqd/GNhDt+b8G2rAfwNsJOf+ylXNs1cy1NTXIi4i0q2q8htHH2F2HGU+ztzo+SP+B0X7hyZDBPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzI5EpY7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749653599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lf9xzKCZ2Qn0juoDOpkczXBo7DHMysvOR4TsAgqr+cg=;
	b=HzI5EpY7rMT/TvlVa+1WVID32yxFIZO9XXVwYSbu2UmLy4iUjG4tZ2Mm6gCj6k9l+WxXfU
	JAo+FrzUJSjpazQ9nFFEPFLgyv0sJPx8KSTacGLSEvnVgkuBhVTGMkHnhcq7SzUG67jicB
	RI+FBaukZpXrslcPHuFMfz2vVvz1/9c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-ODL50JVyN6GcJY-GQzriew-1; Wed, 11 Jun 2025 10:53:18 -0400
X-MC-Unique: ODL50JVyN6GcJY-GQzriew-1
X-Mimecast-MFC-AGG-ID: ODL50JVyN6GcJY-GQzriew_1749653598
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb32203ca6so7911216d6.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 07:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749653598; x=1750258398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf9xzKCZ2Qn0juoDOpkczXBo7DHMysvOR4TsAgqr+cg=;
        b=UrFQ7YM8jp/eW0ygutKH++vNKFqWR/OrkQGzMzVED+UhHDCMW3YRhlagR1HlfoOzTm
         4MU2FrAUVAcUMf0yHFYpDvjeFUbq+vmA3zXMWsFJ+z/3hSMalq/G9SGExGFsa6/Mj1yP
         uI+LtA935RIkK2G5pdnu5nosrnc3aENEjKmWz4E4qwLw32lRd0oO/3n0ZxKlyDXdsq9j
         yLkZ4NZkySw9nOHqqjBxTaSiYNv/Gi6LXFfYS03GnyS9ph97bLSFEs2L+xtt9An89pVb
         /Lp7tdoVvg9J/Ubc3J0fuwsFUcVWlq+5Pzfc1DKQSYtVE9IZRGHs/UjM0Q5UZp6WV1wa
         ucvA==
X-Forwarded-Encrypted: i=1; AJvYcCW64q0VmPNwDK9tcfLWT044rLSIhvjDiW4A8Zpsg6HaGN6dxLRtFyChWegPgLcn3F4KjI4PsJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXNEhFLOdYQdIZWi0TQSdzJxc6LMvVeeQwdXcX0eSSNLgowKW
	ZstkTpEhGqit70Wpww322b4asXsAIcgph8rCVYFA9UGxnaqrZTfKDCR6XsCyJbnHY+HJgl3IsL0
	K6ELPMl3UUc7AzqydZ0O6/45rhEXT0ZYq17bF2aBXCmzWNgPceQhzumfCMsvaPaA+zg==
X-Gm-Gg: ASbGncsxXXO3U4Nds3am1ATF6TvVH1AhDeVdb7a9HwzN907K+Oa4uNNZzNjZfbwmSZn
	n7xiX4BcAKrJv/now6fGwLgAK+szgbxlSw5RO/Q9D+t5JawO3sOrPp2tFPNlPtFek9oaYl6z6ar
	r6VeOQJ9oxSdEYN5YBDX9O7yoZKAGL0uesGUo/0pJS2FnKiTAHxuvp7AZj76dq2hSdzKsPmPgjC
	Q6WJSf9ynhtbHLpVOHHsCB96c4ekmY2pMim88qYaUyLeeNl+5qMgHlMiY90g3HeElshgf0N9qnz
	jegLoaKcE7dydSQ5RndAAGaA4qd3
X-Received: by 2002:a05:620a:2984:b0:7ce:f3fd:cc69 with SMTP id af79cd13be357-7d3a9576ab1mr425909485a.19.1749653597746;
        Wed, 11 Jun 2025 07:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVvQXdBxvFGgQ4UAlmckh17KS2srASaNg+jQYfvx4Ww+gN7/Vyvgw8J9f72/KtbRIhgog87Q==
X-Received: by 2002:a05:620a:2984:b0:7ce:f3fd:cc69 with SMTP id af79cd13be357-7d3a9576ab1mr425903885a.19.1749653597022;
        Wed, 11 Jun 2025 07:53:17 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.235])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61d725sm863276885a.88.2025.06.11.07.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:53:16 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:53:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v3] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <zpc6pbabs5m5snrsfubtl3wp4eb64w4qwqosywp7tsmrfnba3j@ybkgg2cnhqec>
References: <20250611-test_vsock-v3-1-8414a2d4df62@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250611-test_vsock-v3-1-8414a2d4df62@redhat.com>

On Wed, Jun 11, 2025 at 04:07:25PM +0200, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur. The bug was reported upstream [1] and fixed
>with commit 2cb7c756f605 ("vsock/virtio: discard packets if the
>transport changes").
>
>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>Workqueue: vsock-loopback vsock_loopback_work
>RIP: 0010:vsock_stream_has_data+0x44/0x70
>Call Trace:
> virtio_transport_do_close+0x68/0x1a0
> virtio_transport_recv_pkt+0x1045/0x2ae4
> vsock_loopback_work+0x27d/0x3f0
> process_one_work+0x846/0x1420
> worker_thread+0x5b3/0xf80
> kthread+0x35a/0x700
> ret_from_fork+0x2d/0x70
> ret_from_fork_asm+0x1a/0x30
>
>Note that this test may not fail in a kernel without the fix, but it may
>hang on the client side if it triggers a kernel oops.
>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is reasonable to assume that the bug will show up within the timeout
>period.
>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass.

Should we re-use what Michal is doing in 
https://lore.kernel.org/virtualization/20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co/
to print a warning?

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
>Sorry, this took waaay longer than expected.
>
>Changes in v3:
>Addressed Stefano's and Michal's comments:
>    - Added the splat text to the commit commessage.
>    - Introduced commit hash that fixes the bug.
>    - Not using perror anymore on pthread_* functions.
>    - Listener is just created once.
>
>- Link to v2:
>https://lore.kernel.org/r/20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com
>
>Changes in v2:
>- Addressed Stefano's comments:
>    - Timeout is now using current_nsec()
>    - Check for return values
>    - Style issues
>- Added Hyunwoo Kim to Suggested-by
>- Link to v1: https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/vsock_test.c | 169 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 170 insertions(+)
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
>index f669baaa0dca3bebc678d00eafa80857d1f0fdd6..1aed483e7e622d3623be07fcd7fe4295fcfce230 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -22,6 +22,8 @@
> #include <signal.h>
> #include <sys/ioctl.h>
> #include <linux/time64.h>
>+#include <pthread.h>
>+#include <fcntl.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1811,6 +1813,168 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define TRANSPORT_CHANGE_TIMEOUT 2 /* seconds */
>+
>+static void *test_stream_transport_change_thread(void *vargp)
>+{
>+	pid_t *pid = (pid_t *)vargp;
>+	int ret;
>+
>+	/* We want this thread to terminate as soon as possible */
>+	ret = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>+	if (ret) {
>+		fprintf(stderr, "pthread_setcanceltype: %d\n", ret);
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
>+	int ret;
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+	if (old_handler == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	ret = pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid);
>+	if (ret) {
>+		fprintf(stderr, "pthread_create: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("LISTENING");
>+
>+	tout = current_nsec() + TRANSPORT_CHANGE_TIMEOUT * NSEC_PER_SEC;
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
>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		/* The connect can fail due to signals coming from the thread.
>+		 * or because the receiver connection queue is full.
>+		 * Ignoring also the latter case because there is no way
>+		 * of synchronizing client's connect and server's accept when
>+		 * connect(s) are constantly being interrupted by signals.
>+		 */
>+		if (ret == -1 && (errno != EINTR && errno != ECONNRESET)) {
>+			perror("connect");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		/* Set CID to 0 cause a transport change. */
>+		sa.svm_cid = 0;
>+		/* This connect must fail. No-one listening on CID 0
>+		 * This connect can also be interrupted, ignore this error.
>+		 */
>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+		if (ret != -1 && errno != EINTR) {

Should this condition be `ret != -1 || errno != EINTR` ?


>+			fprintf(stderr,
>+				"connect: expected a failure because of unused CID: %d\n", errno);
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		close(s);
>+
>+		control_writeulong(CONTROL_CONTINUE);
>+
>+	} while (current_nsec() < tout);
>+
>+	control_writeulong(CONTROL_DONE);
>+
>+	ret = pthread_cancel(thread_id);
>+	if (ret) {
>+		fprintf(stderr, "pthread_cancel: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait for the thread to terminate */
>+	ret = pthread_join(thread_id, NULL);
>+	if (ret) {
>+		fprintf(stderr, "pthread_join: %d\n", ret);
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
>+	int ret, s;
>+
>+	s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+
>+	/* Set the socket to be nonblocking because connects that have been interrupted
>+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
>+	 * As of today (6.15) in such situation there is no way to understand, from the
>+	 * client side, if the connection has been queued in the server or not.
>+	 */
>+	ret = fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK);
>+	if (ret < 0) {

nit: If you need to resend, I'd remove `ret` and check fcntl directly:
	if (fcntl(...) < 0) {

>+		perror("fcntl");
>+		exit(EXIT_FAILURE);
>+	}
>+	control_writeln("LISTENING");
>+
>+	while (control_readulong() == CONTROL_CONTINUE) {
>+		struct sockaddr_vm sa_client;
>+		socklen_t socklen_client = sizeof(sa_client);
>+
>+		/* Must accept the connection, otherwise the `listen`
>+		 * queue will fill up and new connections will fail.
>+		 * There can be more than one queued connection,
>+		 * clear them all.
>+		 */
>+		while (true) {
>+			int client = accept(s, (struct sockaddr *)&sa_client, &socklen_client);
>+
>+			if (client < 0 && errno != EAGAIN) {
>+				perror("accept");
>+				exit(EXIT_FAILURE);
>+			} else if (client > 0) {

0 in theory is a valid fd, so here we should check `client >= 0`.

>+				close(client);
>+			}
>+
>+			if (errno == EAGAIN)
>+				break;

I think you can refactor in this way:
			if (client < 0) {
				if (errno == EAGAIN)
					break;

				perror("accept");
				exit(EXIT_FAILURE);
			}

			close(client);

Thanks,
Stefano

>+		}
>+	}
>+
>+	close(s);
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	int fd;
>@@ -2051,6 +2215,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_nolinger_client,
> 		.run_server = test_stream_nolinger_server,
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
>base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
>change-id: 20250306-test_vsock-3e77a9c7a245
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


