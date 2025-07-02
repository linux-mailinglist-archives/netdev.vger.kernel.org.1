Return-Path: <netdev+bounces-203299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E70AF1382
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82560164A63
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661D0264606;
	Wed,  2 Jul 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5/icBea"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04E255F26
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455074; cv=none; b=pFZpPIC5LRQbcNYCp1GKE1y24nJYmW0tUOcmRlgVafIzKCnedbJN22kM6ytE8wNgz1OlNKhIr2ROq2mEhJTgr/YDWeQB4dznfogSDOKT2u3jsiBUWhxYfocQl6+XFJINI4fDl+U33wCfBo/7dIptP7rqT+UwGgVQjFrNEVFhjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455074; c=relaxed/simple;
	bh=sx6ZXPAv0DNYijJIpFX2qRRFSX+O86QuQitiC9rw1ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIZduvP7PwMI0K7MdH6l/KpDSiT3uP/G+MgJ8nlxs1zBfKpsKSQPBm/zZablZSV2b0Y1dI9gyaRdL6gtDXEJLOlWl0e3J2/bXhiJIPzmFu8BT3O5f25lCd6St4Qy3Rd9EetrjX/0vEQqJv3X+I0uRJAQOkRIV0OhtXu/lkzX184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5/icBea; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751455071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+6hlIeCKXcjgCGE6QPvE3NZnk0CNW/XPA78sK/38pY=;
	b=E5/icBea5K9d1Q1cRwzMRL9KcI4Fblw+pVnXVKvQffMN/eb6nnXWBLJ4xxt+hB+rGVfNwQ
	gbykiGPggRC+4Sx5j+XVN4DanCfKmutCT7o22D/9bc2+pFyd2s8DfGLgS8j8mDujIDNmy3
	maFxwDNBa6ajemKmq3Z1NkoFLUVGW/c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-vs7MiqYAMrai4NBzc4YhzA-1; Wed, 02 Jul 2025 07:17:50 -0400
X-MC-Unique: vs7MiqYAMrai4NBzc4YhzA-1
X-Mimecast-MFC-AGG-ID: vs7MiqYAMrai4NBzc4YhzA_1751455070
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a43c1e1e6bso141303521cf.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 04:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455070; x=1752059870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+6hlIeCKXcjgCGE6QPvE3NZnk0CNW/XPA78sK/38pY=;
        b=arJjXYK8+5yf/NhOl8NLyG8UjjW8Foq3IKC7mTdExBid2dEIoDBsVwLZV5sYGM/gNo
         3sYN4fDenTiVzLMatyFaEVcs5OkPWDUXRpElrBkVTrmTwzam5gceGfdMjGETiQRmpE2z
         x9ggh5RyOyPFZwbUMBRG1BIq9lXuJoUL7zgMuOK4QSGJV3+8rVSSmiqnLe92v3KgvFEP
         KSfwK0ErM3KWCS6gyV4a9FWpE/awN9ojINGxZb7Ob8IwmkvkXReeKI6zAF1VrU69I6xr
         Fd8S126HDjoKv1TOu2nYxOMe0E82RHtUNrOsccgUugyjCoNSAuR7Nv/6AH2Kc/XPxu9X
         bsDg==
X-Forwarded-Encrypted: i=1; AJvYcCW35wzmb0NKCSj7GlVallkaBDuYLUrE+f4s5LTbE55POeZbUhrlYGVj1u4HMdqdwJrstr3CMLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRfFJEdfDpfq27QBR/RLyCR4zkaVxwGp6QoI+j+af3Ca3GSGr
	M8ATeB4xjKUVvDJ9FrcMMVjMofopdPY4kl4eeT+62us0GrtYiz9NKBbJlU46H4VBQlHDxJenrrC
	n4YD+UlLjXVy9gu0S14UaQaqLYObdTMnFbFCi/nkLuJ6RYK4eB0h1t7dhSA==
X-Gm-Gg: ASbGncvHkcXlqZ2pCBMHxYQuy4U2+DEQaJAQ4FK7W+AiKmkfkuxdKzdVzQg1VeRRzeV
	NSuNB4/EAGM7oqJ8dmAgI19ovLQT5iMdl6chqkJJz+ID3FImndVsnN8SLTh5xRITRpqNGAARVGH
	1z0WWr3dUbIQzotMIc1ClH++DQsEASx+jTNsObBw6Zoz+B7N3mNSuia+wJ7gGpqIDHFWuOtfsh7
	b1Lfd2x05Q2M5mOUD7aSm5JUd2lV5PZSLuLmCIxYWEfnbWVX1VGn5ZLb8M8GzTyO33QVwHSxC8W
	YbiJBtxiCFZyb8ZZx2gDriTmy5Y9
X-Received: by 2002:ac8:7f0f:0:b0:4a4:3fb2:113c with SMTP id d75a77b69052e-4a976a28ce1mr33172951cf.45.1751455069569;
        Wed, 02 Jul 2025 04:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5cBcz69WvcBm+o8cUuKL9tkLTgDyjUl7ykW1r2X7ywl3Jjzt418LNl2PWk5uGV4HOxkqbIg==
X-Received: by 2002:ac8:7f0f:0:b0:4a4:3fb2:113c with SMTP id d75a77b69052e-4a976a28ce1mr33172511cf.45.1751455068861;
        Wed, 02 Jul 2025 04:17:48 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a97c5826b7sm5693821cf.81.2025.07.02.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:17:48 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:17:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v5 2/2] vsock/test: Add test for null ptr deref
 when transport changes
Message-ID: <bmldzyieflxolpa3gttr6txbolva5wqgkqshar2t2l34i2e6it@hspfuah5b6vl>
References: <20250630-test_vsock-v5-0-2492e141e80b@redhat.com>
 <20250630-test_vsock-v5-2-2492e141e80b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250630-test_vsock-v5-2-2492e141e80b@redhat.com>

On Mon, Jun 30, 2025 at 06:33:04PM +0200, Luigi Leonardi wrote:
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
>triggered and this test will always pass. This is because
>`vsock_assign_transport`, when using CID 0, like in this case, sets
>vsk->transport to `transport_g2h` that is not NULL if a G2H transport is
>available.
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/Makefile     |   1 +
> tools/testing/vsock/vsock_test.c | 170 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 171 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

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
>index eb6f54378667ac7ed324f4823e988ec9846e41a3..be6ce764f69480c0f9c3e2288fc19cd2e74be148 100644
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
>@@ -1867,6 +1869,169 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
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
>+	int ret, tr;
>+
>+	tr = get_transports();
>+
>+	/* Print a warning if there is a G2H transport loaded.
>+	 * This is on a best effort basis because VMCI can be either G2H and H2G, and there is
>+	 * no easy way to understand it.
>+	 * The bug we are testing only appears when G2H transports are not loaded.
>+	 * This is because `vsock_assign_transport`, when using CID 0, assigns a G2H transport
>+	 * to vsk->transport. If none is available it is set to NULL, causing the null-ptr-deref.
>+	 */
>+	if (tr & TRANSPORTS_G2H)
>+		fprintf(stderr, "G2H Transport detected. This test will not fail.\n");
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
>+		/* The connect can fail due to signals coming from the thread,
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
>+
>+		/* Ignore return value since it can fail or not.
>+		 * If the previous connect is interrupted while the
>+		 * connection request is already sent, the second
>+		 * connect() will wait for the response.
>+		 */
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
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
>+	ret = pthread_join(thread_id, NULL);
>+	if (ret) {
>+		fprintf(stderr, "pthread_join: %d\n", ret);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>+		perror("signal");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_transport_change_server(const struct test_opts *opts)
>+{
>+	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+
>+	/* Set the socket to be nonblocking because connects that have been interrupted
>+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
>+	 * As of today (6.15) in such situation there is no way to understand, from the
>+	 * client side, if the connection has been queued in the server or not.
>+	 */
>+	if (fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK) < 0) {
>+		perror("fcntl");
>+		exit(EXIT_FAILURE);
>+	}
>+	control_writeln("LISTENING");
>+
>+	while (control_readulong() == CONTROL_CONTINUE) {
>+		/* Must accept the connection, otherwise the `listen`
>+		 * queue will fill up and new connections will fail.
>+		 * There can be more than one queued connection,
>+		 * clear them all.
>+		 */
>+		while (true) {
>+			int client = accept(s, NULL, NULL);
>+
>+			if (client < 0) {
>+				if (errno == EAGAIN)
>+					break;
>+
>+				perror("accept");
>+				exit(EXIT_FAILURE);
>+			}
>+
>+			close(client);
>+		}
>+	}
>+
>+	close(s);
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	int fd;
>@@ -2106,6 +2271,11 @@ static struct test_case test_cases[] = {
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
>-- 
>2.50.0
>


