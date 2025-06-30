Return-Path: <netdev+bounces-202358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F361DAED8A3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0136B3A6871
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33C23BD02;
	Mon, 30 Jun 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcCzKo1I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6321CA14
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275510; cv=none; b=ciIqKp39c5DCqe28JDIKKzWXV3ujI+wPB4xzrnqyVeTG6e6whlu/3pj2o2E5wURj8ryKPJRPWCavvOxmdMix53psMeORnj4GQ+xTw0hm+xn59AeCgCi1wq++xORFuRk7fTWTtS+qTzrU7booJnOw8/ec8eSup7HFzD+FR+tyR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275510; c=relaxed/simple;
	bh=GvgANJCQx99I5ImcvKnusFiA/uFujgRYxNhoS91WG9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiauOx8LxDGgk1uDkUs2ReDH8e0YxEaImYhuZt3DbtEoCSnFB3BVwPF3YH8ZCzIhiZgOLUlPrEQ8YQVdQUspch8WTEYwfNtgJYnRPJLHTfZSDN+/7LEz3NiFNwiCVZLZZQ97D2AFwJAnB7BGn8AsZyCHU8Yl3E2RwpOeiRp32H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcCzKo1I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751275507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZlshIkLpY8cHbunTx6rq3KQMWBrajZZjLRx4Hd8Akw=;
	b=YcCzKo1IfbddfOHwOJkxFuAOAgGb5fb3d6JkBnAR2iBOb0JEn8ip8lvGaWvjHd9Dpppdi4
	hceiy2GdGeYasI5twV2w5igPKki2eLKu56difrhja2iYCmBPegOixLCsVGNHSzwJ/eMvcT
	G5QOvmjIrvOKoJ+APz/kbwE9g5E39OM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-KcI-ydZ-Npy8g2R83KeZeA-1; Mon, 30 Jun 2025 05:24:53 -0400
X-MC-Unique: KcI-ydZ-Npy8g2R83KeZeA-1
X-Mimecast-MFC-AGG-ID: KcI-ydZ-Npy8g2R83KeZeA_1751275492
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so2070174f8f.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751275492; x=1751880292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZlshIkLpY8cHbunTx6rq3KQMWBrajZZjLRx4Hd8Akw=;
        b=GqMYW5opXI7rNq61BWIXcNdWj6uuJxCk46sblpPOWMJFRu+Tj2jOal+QkUS3y5VD7c
         L8AnJq9AkSAPyGDmQ8CWkcy9u+EFVjplg2vL9QLX89vXV2GW9pXGige11jb+Jj9Y+Idn
         bGBXPLUh7JrrNn1wCJfBC7JbstPkit2Z4uy8kPrkQ/E1HRDFyBWGIYZrBpDQtBVOuuLr
         k8vJLzJDQJQ7GvdMiOvAWUNEGoixZiQQynEPrUN67x95GQCAhEn3vzCKs+kcxj/vnHmL
         HSw6iupos+EQRjuZM9yjO0oarQiBkQUWTlb9qyfwPSsJU1meQZU/FogwSNzt3tI4foAS
         Rwsw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+vpuFkgGcFHlj2fBFmV8oUBxyKrwTzLZqoR/GeQN1abzmY+RQkLGDovv2Vms6FT4i/RGnyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvecYP4QlysrZ6BA31tjfd/kwMzQhlwg7bs/PFxvmXBmGcCoj
	fJsb/BN0KlHzmE+VGWycCOxwe4KW4aAvrpkLF3oEMf0SWBhmAyM0CjuPVy7nlvtmdVdgO6LceAJ
	AVwpdoDXg9iGkE6dumWrf9knWNqSipZrm9K5ZGMu0IMB3aQ2qStN3jShJdA==
X-Gm-Gg: ASbGncv9dt/haSkyP0lkyWq+MJjktYtfmdOuKcW9+wN4pvYkEwybS5ax2+QnJ/uN7ZD
	RQzd+8UPs4FoQX5HbclKx7lTxQHu67S4PwjUgsqvAeQ8aFWtaYbdXwj+mQ+dujwOnVahquntfSr
	E3dYhXNu4ttq4BJyLlMMnsUrucpvdINdZuDtVlqqBPAC/C1QMvtOlGXsET6T88mYj/H0zJYE/Yt
	bQtt1BCCQvqGrlyPT1ZgBwyWjcRLegX1KwzYrPwJo7qzyV6jMVftoFEv7GqH/TUPUiBl4AwBySn
	fUo6uvVOOoQ3EwzW3H4IycCULyM=
X-Received: by 2002:a05:6000:23c4:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a8fdb2a70emr7499031f8f.7.1751275492143;
        Mon, 30 Jun 2025 02:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq3qfWEeEhiapGNV1dURU0vs31i3XdG3+vTN9oPSXszmZH68aC+ikvECv+Q7lYh92osxv0rA==
X-Received: by 2002:a05:6000:23c4:b0:3a5:25e0:1851 with SMTP id ffacd0b85a97d-3a8fdb2a70emr7499008f8f.7.1751275491622;
        Mon, 30 Jun 2025 02:24:51 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe592sm126375955e9.21.2025.06.30.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:24:51 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:24:48 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v4] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <c2ln3v2anshvy64xflck7agirk55wkelnfznvkf6wq4bvezzdi@kod4yt5b6qhl>
References: <20250624-test_vsock-v4-1-087c9c8e25a2@redhat.com>
 <u2cvx4da63jzrtbqikbqaud5zjdpduoyrxzxgctvjkznt66k4h@gxr623ahkxxy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <u2cvx4da63jzrtbqikbqaud5zjdpduoyrxzxgctvjkznt66k4h@gxr623ahkxxy>

Hi Stefano,

On Wed, Jun 25, 2025 at 10:26:26AM +0200, Stefano Garzarella wrote:
>On Tue, Jun 24, 2025 at 05:40:15PM +0200, Luigi Leonardi wrote:
>>Add a new test to ensure that when the transport changes a null pointer
>>dereference does not occur. The bug was reported upstream [1] and fixed
>>with commit 2cb7c756f605 ("vsock/virtio: discard packets if the
>>transport changes").
>>
>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>Workqueue: vsock-loopback vsock_loopback_work
>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>Call Trace:
>>virtio_transport_do_close+0x68/0x1a0
>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>vsock_loopback_work+0x27d/0x3f0
>>process_one_work+0x846/0x1420
>>worker_thread+0x5b3/0xf80
>>kthread+0x35a/0x700
>>ret_from_fork+0x2d/0x70
>>ret_from_fork_asm+0x1a/0x30
>>
>>Note that this test may not fail in a kernel without the fix, but it may
>>hang on the client side if it triggers a kernel oops.
>>
>>This works by creating a socket, trying to connect to a server, and then
>>executing a second connect operation on the same socket but to a
>>different CID (0). This triggers a transport change. If the connect
>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>
>>Since this bug is non-deterministic, we need to try several times. It
>>is reasonable to assume that the bug will show up within the timeout
>>period.
>>
>>If there is a G2H transport loaded in the system, the bug is not
>>triggered and this test will always pass.
>
>Can you add the reason?
Will do.
>
>>
>>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>>
>>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>>Suggested-by: Michal Luczaj <mhal@rbox.co>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>This series introduces a new test that checks for a null pointer
>>dereference that may happen when there is a transport change[1]. This
>>bug was fixed in [2].
>>
>>Note that this test *cannot* fail, it hangs if it triggers a kernel
>>oops. The intended use-case is to run it and then check if there is any
>>oops in the dmesg.
>>
>>This test is based on Hyunwoo Kim's[3] and Michal's python
>>reproducers[4].
>>
>>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>>[2]https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/
>>[3]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/#t
>>[4]https://lore.kernel.org/netdev/2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co/
>>---
>>Changes in v4:
>>- Addressed Stefano's comments:
>>   - Minor style changes
>>   - Use `get_transports()` to print a warning when a G2H transport is
>>   loaded
>>   - Removed check on second connect: Because the first connect is
>>   interrupted, the socket is in an unspecified state (see man connect)
>>   . This can cause strange and unexpected behaviors (connect returning
>>   success on a non-existing CID).
>>
>>- Link to v3:
>>https://lore.kernel.org/r/20250611-test_vsock-v3-1-8414a2d4df62@redhat.com
>>
>>Sorry, this took waaay longer than expected.
>>
>>Changes in v3:
>>Addressed Stefano's and Michal's comments:
>>   - Added the splat text to the commit commessage.
>>   - Introduced commit hash that fixes the bug.
>>   - Not using perror anymore on pthread_* functions.
>>   - Listener is just created once.
>>
>>- Link to v2:
>>https://lore.kernel.org/r/20250314-test_vsock-v2-1-3c0a1d878a6d@redhat.com
>>
>>Changes in v2:
>>- Addressed Stefano's comments:
>>   - Timeout is now using current_nsec()
>>   - Check for return values
>>   - Style issues
>>- Added Hyunwoo Kim to Suggested-by
>>- Link to v1:
>>https://lore.kernel.org/r/20250306-test_vsock-v1-0-0320b5accf92@redhat.com
>>---
>>tools/testing/vsock/Makefile     |   1 +
>>tools/testing/vsock/vsock_test.c | 178 +++++++++++++++++++++++++++++++++++++++
>>2 files changed, 179 insertions(+)
>>
>>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>>index 6e0b4e95e230500f99bb9c74350701a037ecd198..88211fd132d23ecdfd56ab0815580a237889e7f2 100644
>>--- a/tools/testing/vsock/Makefile
>>+++ b/tools/testing/vsock/Makefile
>>@@ -5,6 +5,7 @@ vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_ze
>>vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>vsock_perf: vsock_perf.o msg_zerocopy_common.o
>>
>>+vsock_test: LDLIBS = -lpthread
>>vsock_uring_test: LDLIBS = -luring
>>vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>>
>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>index eb6f54378667ac7ed324f4823e988ec9846e41a3..095705c7b53b7ad38ab3b8bc3cbe54a9eeb76d5c 100644
>>--- a/tools/testing/vsock/vsock_test.c
>>+++ b/tools/testing/vsock/vsock_test.c
>>@@ -22,6 +22,8 @@
>>#include <signal.h>
>>#include <sys/ioctl.h>
>>#include <linux/time64.h>
>>+#include <pthread.h>
>>+#include <fcntl.h>
>>
>>#include "vsock_test_zerocopy.h"
>>#include "timeout.h"
>>@@ -1867,6 +1869,177 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>>	close(fd);
>>}
>>
>>+#define TRANSPORT_CHANGE_TIMEOUT 2 /* seconds */
>>+
>>+static void *test_stream_transport_change_thread(void *vargp)
>>+{
>>+	pid_t *pid = (pid_t *)vargp;
>>+	int ret;
>>+
>>+	/* We want this thread to terminate as soon as possible */
>>+	ret = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_setcanceltype: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	while (true) {
>>+		if (kill(*pid, SIGUSR1) < 0) {
>>+			perror("kill");
>>+			exit(EXIT_FAILURE);
>>+		}
>>+	}
>>+	return NULL;
>>+}
>>+
>>+static void test_transport_change_signal_handler(int signal)
>>+{
>>+	/* We need a custom handler for SIGUSR1 as the default one terminates the process. */
>>+}
>>+
>>+static void test_stream_transport_change_client(const struct test_opts *opts)
>>+{
>>+	__sighandler_t old_handler;
>>+	pid_t pid = getpid();
>>+	pthread_t thread_id;
>>+	time_t tout;
>>+	int ret, tr;
>>+
>>+	tr = get_transports();
>
>nit: add a blank line here
>
>>+	/* Print a warning if there is a G2H transport loaded.
>>+	 * This is on a best effort basis because VMCI can be either G2H and H2G, and there is
>>+	 * no easy way to understand it.
>>+	 * The bug is present in the loopback transport. However, it does not interfere
>
>nit: s/is/was
>
>>+	 * if it is loaded.
>
>I don't understand this, if the bug was present in the loopback transport, our goal is to stress it, so have it loaded is great, why it should interfere?
What I meant to say is that, when testing the H2G path to trigger the
issue, and the loopback transport is there, it does not prevent the bug, 
like a G2H transport would do.

>
>>+	 * The bug we are testing only appears when G2H transports are not loaded.
>
>Please add the reason also here.
>
>>+	 */
>>+
>
>nit: remove the blank line here
>
>>+	tr &= ~TRANSPORT_LOOPBACK;
>>+	if (tr != 0 && tr != TRANSPORT_VHOST)
>
>Sorry, this is really hard to understand IMO, let's do a step back.
>Your goal is to check if there is a G2H transport loaded, right?
correct
>
>I think we have 2 options:
>1. similar to your, just masking the other 2 transports
>
>	if (tr & ~(TRANSPORT_LOOPBACK | TRANSPORT_VHOST))
>
>   IMO this is much clear to understand, and should have the same 
>   effect.
>
>2. (my preference) define in util.h some macros that we can reuse:
>	#define TRANSPORTS_G2H   (TRANSPORT_VIRTIO | TRANSPORT_VMCI | 
>	TRANSPORT_HYPERV)
>	#define TRANSPORTS_H2G   (TRANSPORT_VHOST | TRANSPORT_VMCI)
>	#define TRANSPORTS_LOCAL (TRANSPORT_LOOPBACK)
>
>    and here you can just do:
>	if (tr & TRANSPORTS_G2H)
>

I'll add these defines in a separate commit, thanks for the hint.

>>+		fprintf(stderr, "G2H Transport detected. This test will not fail.\n");
>>+
>>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>>+	if (old_handler == SIG_ERR) {
>>+		perror("signal");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	ret = pthread_create(&thread_id, NULL, test_stream_transport_change_thread, &pid);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_create: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	control_expectln("LISTENING");
>>+
>>+	tout = current_nsec() + TRANSPORT_CHANGE_TIMEOUT * NSEC_PER_SEC;
>>+	do {
>>+		struct sockaddr_vm sa = {
>>+			.svm_family = AF_VSOCK,
>>+			.svm_cid = opts->peer_cid,
>>+			.svm_port = opts->peer_port,
>>+		};
>>+		int s;
>>+
>>+		s = socket(AF_VSOCK, SOCK_STREAM, 0);
>>+		if (s < 0) {
>>+			perror("socket");
>>+			exit(EXIT_FAILURE);
>>+		}
>>+
>>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>+		/* The connect can fail due to signals coming from the thread.
>
>. should be ,
>
>>+		 * or because the receiver connection queue is full.
>>+		 * Ignoring also the latter case because there is no way
>>+		 * of synchronizing client's connect and server's accept when
>>+		 * connect(s) are constantly being interrupted by signals.
>>+		 */
>>+		if (ret == -1 && (errno != EINTR && errno != ECONNRESET)) {
>>+			perror("connect");
>>+			exit(EXIT_FAILURE);
>>+		}
>>+
>>+		/* Set CID to 0 cause a transport change. */
>>+		sa.svm_cid = 0;
>
>nit: add a blank line
>
>>+		/* Here we ignore the connect return value because we cannot
>>+		 * safely assume that it will *always* fail.
>>+		 * This is because the previous connect was interrupted
>>+		 * during the connection process. The socket state, as stated
>>+		 * in `man connect`, is unspecified and can result in strange
>>+		 * behaviors.
>
>Let's focus on the behaviour and try to be more concise. Something like
>this:
>
>		/* Ignore return value since it can fail or not.
>		 * If the previous connect is interrupted while the
>		 * connection request is already sent, the second
>		 * connect() will wait for the response.
>
>>+		 */
>>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>+
>>+		close(s);
>>+
>>+		control_writeulong(CONTROL_CONTINUE);
>>+
>>+	} while (current_nsec() < tout);
>>+
>>+	control_writeulong(CONTROL_DONE);
>>+
>>+	ret = pthread_cancel(thread_id);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_cancel: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	/* Wait for the thread to terminate */
>
>useless comment
>
>>+	ret = pthread_join(thread_id, NULL);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_join: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	/* Restore the old handler */
>
>ditto
>
>>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>>+		perror("signal");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+}
>>+
>>+static void test_stream_transport_change_server(const struct test_opts *opts)
>>+{
>>+	int s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>+
>>+	/* Set the socket to be nonblocking because connects that have been interrupted
>>+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
>>+	 * As of today (6.15) in such situation there is no way to understand, from the
>>+	 * client side, if the connection has been queued in the server or not.
>>+	 */
>>+	if (fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK) < 0) {
>>+		perror("fcntl");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+	control_writeln("LISTENING");
>>+
>>+	while (control_readulong() == CONTROL_CONTINUE) {
>>+		struct sockaddr_vm sa_client;
>>+		socklen_t socklen_client = sizeof(sa_client);
>>+
>>+		/* Must accept the connection, otherwise the `listen`
>>+		 * queue will fill up and new connections will fail.
>>+		 * There can be more than one queued connection,
>>+		 * clear them all.
>>+		 */
>>+		while (true) {
>>+			int client = accept(s, (struct sockaddr *)&sa_client, &socklen_client);
>
>We don't use the client address, so IMO we can just pass NULL.
>
>Thanks,
>Stefano
>
>>+
>>+			if (client < 0) {
>>+				if (errno == EAGAIN)
>>+					break;
>>+
>>+				perror("accept");
>>+				exit(EXIT_FAILURE);
>>+			}
>>+
>>+			close(client);
>>+		}
>>+	}
>>+
>>+	close(s);
>>+}
>>+
>>static void test_stream_linger_client(const struct test_opts *opts)
>>{
>>	int fd;
>>@@ -2106,6 +2279,11 @@ static struct test_case test_cases[] = {
>>		.run_client = test_stream_nolinger_client,
>>		.run_server = test_stream_nolinger_server,
>>	},
>>+	{
>>+		.name = "SOCK_STREAM transport change null-ptr-deref",
>>+		.run_client = test_stream_transport_change_client,
>>+		.run_server = test_stream_transport_change_server,
>>+	},
>>	{},
>>};
>>
>>
>>---
>>base-commit: 68d019aa14d97f8d57b0f8d203fd3b44db2ba0c7
>>change-id: 20250306-test_vsock-3e77a9c7a245
>>
>>Best regards,
>>-- 
>>Luigi Leonardi <leonardi@redhat.com>
>>
>

Thanks for the review all the comments!
Luigi


