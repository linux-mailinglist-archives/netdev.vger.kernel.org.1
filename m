Return-Path: <netdev+bounces-172525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2CBA55238
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71927A8D4A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF732571DD;
	Thu,  6 Mar 2025 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrWgTr0W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99F13635B
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280719; cv=none; b=qEMx3M9R88l5TOw9qLbLH135Tw6JUWIZPjNSAXxGm7cIseRP+7xOz6nlvjyA8sxLzNsvb9gBenb1RFEoq57kJMXCq+lxj18sQdFuthRSJ9/BUEkkEPrtUVSxgmwyizWwVPhkWH6R5ok86QY01YTiqBcmTNAdpB0dlBLa93zDIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280719; c=relaxed/simple;
	bh=juBDRNImR2QnHw+IxkfJS8lxpFiWsVRDf+BVRf9RC/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+k+AcW0RpOu3/ZiMWincgZq47Tfc2MvX4iPlkYDP+gUSnoS+U+l45yPu0D5ZNaR5Bqui8JOdzSVaIv/dPgFKbVF39EU9UAjW285moSqA+CXpBIcWZSU1l/rCXbJ7jg56DGLbHZlnn4/DeDXXZ/nTOH8aDPEgIxFU1oaXP7jsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrWgTr0W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741280715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rts5eSskbnJp/CQFVaAat8eJ+DA7k4QIn4k1VQ/bSLY=;
	b=RrWgTr0We4FFMFWz1JYjqO2qqcQNmJz7EfePMnNKAKc/0ThATIgi4RDb9urGkfED3NjpDu
	oRYAJNgzJkBxLOdR8v7nV8PwSjzr5dxoVdT5Tk29eTRgWN5c71xcHArCDuLIsEDE5GbkWN
	/4NEivCHRQoURiFHe5bgiAQ4FKQUVvA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-T2w2ROy8P-iI8LRYgNgvSQ-1; Thu, 06 Mar 2025 12:05:14 -0500
X-MC-Unique: T2w2ROy8P-iI8LRYgNgvSQ-1
X-Mimecast-MFC-AGG-ID: T2w2ROy8P-iI8LRYgNgvSQ_1741280713
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bd0257945so4321165e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 09:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280713; x=1741885513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rts5eSskbnJp/CQFVaAat8eJ+DA7k4QIn4k1VQ/bSLY=;
        b=JHhJTn1/gsHHEkijDm/e+/CncLMitKwV1sztMvDzK33tqVbpMWOGGy+jTcEKS78fpq
         dzAS5ZGYNGsFK3uOzSrGusgS0QnC87FA4L2OzsTJwSTKTcJPOWE4Q+NWRWA2dmqMHL+6
         qjiJHui3+d5V9dCtn5dKbbS8oUQBBtTW0q4nSco0sU4ucpcoTuG5NYJnLG1u2Yxdw4hy
         PJrc6pYDZkr/1nKNjYse1I7oyRwDZG65CF/l0tId1xGpbXM6PqEhLpbBePAW6WSTCfDE
         M1x/2kZR4UV6wEZbmTvxeKKc5NJ8T480TkXWxJX88+s2H9TnNNGP+dxBeQbJH/U91nKj
         AQGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxLg/91viQkfdygZHKWmO6BsR9WrXqX0k9YqWBnwtL1xzQkUZVLtCnq0aQ53tnsuZKdZqIyZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDl/6F4sKvvCZ8qtltr2/51r9HhTmA8oBONU8R97WvB6R0JcP
	mrf9ECGJjUQ7CC979HHqKabQ897mmc9NvJvv4QrQRGuM/xIDnOK2PLtwzkEEiusXMyvz29AS10C
	2HGoSprfTf8bhxSrOaiCpHbuEQdeojRXl4wObQhhixcr4s98xqsX3ZA==
X-Gm-Gg: ASbGnctvxdVkEu57G1WWaXAnTa2/DFnN2VdUmLvFNFwIWyamWLSMtclm+j/fAutAtV/
	JykBI14P18DSQqkiloNKOWz84jhtRvsGP/WP2Pq1ky9RX4Y0H1vBM+u2iVB2tojAl2T7g+c0FIo
	mIH+65bRQNWAqKCvVsZ0dY2dwUvfayBSrvI4iSu+UcjHYG6eKMLVGA5HL+Y14/DypmGcaKQBQp1
	/Sr1G3W4KnSWjQj0mFUTn44K73qXQUR2kwKdQxCcBC3tOPPYVZUKqR4aOwrU/o1cLZN8rK36QIY
	jA3OlFsAgfe5yZH3Q57GolaYTpvlRFyzTDl86N6hNiK15Cv7PG55pSBo87enqZ+i
X-Received: by 2002:a05:6000:1449:b0:390:f971:4ecd with SMTP id ffacd0b85a97d-3911f764cb9mr7120581f8f.26.1741280712188;
        Thu, 06 Mar 2025 09:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkaWSlL+r0y99UcBiSFo86iDccFc9BimFwiW02LQK5dm6lsqELUu1YfKEo2PEg2KrOfTUthA==
X-Received: by 2002:a05:6000:1449:b0:390:f971:4ecd with SMTP id ffacd0b85a97d-3911f764cb9mr7120511f8f.26.1741280711456;
        Thu, 06 Mar 2025 09:05:11 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdfdsm2679033f8f.34.2025.03.06.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:05:09 -0800 (PST)
Date: Thu, 6 Mar 2025 18:05:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] vsock/test: Add test for null ptr deref
 when transport changes
Message-ID: <7ea5ikhvo2iupdlwuolemqrtswmogogpofso7u5pir3eggnjab@iacdjg4r64ss>
References: <20250306-test_vsock-v1-0-0320b5accf92@redhat.com>
 <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250306-test_vsock-v1-2-0320b5accf92@redhat.com>

On Thu, Mar 06, 2025 at 05:09:33PM +0100, Luigi Leonardi wrote:
>Add a new test to ensure that when the transport changes a null pointer
>dereference does not occur[1].
>
>Note that this test does not fail, but it may hang on the client side if
>it triggers a kernel oops.
>
>This works by creating a socket, trying to connect to a server, and then
>executing a second connect operation on the same socket but to a
>different CID (0). This triggers a transport change. If the connect
>operation is interrupted by a signal, this could cause a null-ptr-deref.
>
>Since this bug is non-deterministic, we need to try several times. It
>is safe to assume that the bug will show up within the timeout period.
>
>If there is a G2H transport loaded in the system, the bug is not
>triggered and this test will always pass.
>
>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/Makefile     |  1 +
> tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 81 insertions(+)
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
>index d0f6d253ac72d08a957cb81a3c38fcc72bec5a53..1e00cb6e117859d5c18fb3e52a574444b5489173 100644
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
>@@ -1788,6 +1789,80 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void *test_transport_change_thread(void *vargp)
>+{
>+	pid_t *t = (pid_t *)vargp;
>+
>+	//We want this thread to terminate as soon as possible

Please follow the stile in this file, we use /* Something ... */ for
comments.

>+	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>+
>+	while (true)
>+		kill(*t, SIGUSR1);

Should we check the return value of kill()?

>+	return NULL;
>+}
>+
>+static void test_transport_change_signal_handler(int signal)
>+{

Can you put comment here to explain why it's empty?

>+}
>+
>+static void test_transport_change_client(const struct test_opts *opts)
>+{
>+	__sighandler_t old_handler;
>+	pid_t pid = getpid();
>+	pthread_t thread_id;
>+
>+	old_handler = signal(SIGUSR1, test_transport_change_signal_handler);
>+
>+	pthread_create(&thread_id, NULL, test_transport_change_thread, &pid);
>+
>+	timeout_begin(TIMEOUT);
>+
>+	while (true) {

What about `while (timeout_check_expired()) {` here?

>+		struct sockaddr_vm sa = {
>+			.svm_family = AF_VSOCK,
>+			.svm_cid = opts->peer_cid,
>+			.svm_port = opts->peer_port,
>+		};
>+
>+		int s = socket(AF_VSOCK, SOCK_STREAM, 0);

Please check that `s` is a valid file descriptor.

>+
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+

Maybe I'd add a comment here to explain why we are setting
`svm_cid = 0`.

>+		sa.svm_cid = 0;
>+		connect(s, (struct sockaddr *)&sa, sizeof(sa));
>+
>+		close(s);
>+
>+		if (timeout_check_expired())
>+			break;
>+	}
>+
>+	timeout_end();
>+
>+	pthread_cancel(thread_id);
>+	//Wait for the thread to terminate
>+	pthread_join(thread_id, NULL);

Please check return values and fix the comment style.

>+	//Restore the old handler
>+	signal(SIGUSR1, old_handler);
>+}
>+
>+static void test_transport_change_server(const struct test_opts *opts)
>+{
>+	timeout_begin(TIMEOUT);

Instead of using timeout_begin(), etc. on both sides, can we do 
something similar to what we did in test_stream_leak_acceptq_client() 
and test_stream_leak_acceptq_server() ?

>+
>+	while (true) {
>+		int s;
>+
>+		s = vsock_stream_listen(opts->peer_cid, opts->peer_port);
>+		close(s);
>+
>+		if (timeout_check_expired())
>+			break;
>+	}
>+
>+	timeout_end();
>+}
>+
> static void test_stream_linger_client(const struct test_opts *opts)
> {
> 	struct linger optval = {
>@@ -1984,6 +2059,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_linger_client,
> 		.run_server = test_stream_linger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM transport change null-ptr-deref",
>+		.run_client = test_transport_change_client,
>+		.run_server = test_transport_change_server,

Following the other test, I'd call `test_stream_transport_change...`.

Thanks,
Stefano

>+	},
> 	{},
> };
>
>
>-- 
>2.48.1
>


