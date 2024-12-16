Return-Path: <netdev+bounces-152246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E1F9F3358
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9097A1441
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5C205AA5;
	Mon, 16 Dec 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPnlUmjZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F58204588
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359884; cv=none; b=IfiXwgDaDMVb6RW6SbkrDNAfWz1n/1q8cdyUWckyrUbhONB4eIZ/+Ry4LnvDl0CUk4GR9OaEc6K8O+sfKxcWhPHgZ/CbNp2X1njzDe5+uPZ4w6099Vg3cYG8daPFeT0Z1Fc95xW/yTPddOUgyFlLw+JRSiF61Z664ZiAK0+Ynl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359884; c=relaxed/simple;
	bh=ElHjmMmD9tdz0lOPrVUiDy2/YVFp2J7+vDHCHoskCY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxHhdilfZ8eb/660UwLE4kAJWJYNlmHy2Vj5KWQ++Itnwu0lCULFnH/UFmHmZ/ZodFEpgfjDrJV0Y5zcaE0TrCWeTL/Hcros+BYG2JdUU32HCZka7IrUleh7xDhA42bN+VBTZjQmXlOc/5pmZu7NjoUKfUwJzZmWyR1NdcqcSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPnlUmjZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734359881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBhi7nRN4fiBOZammIZcwLkfnItRrVQeEOJ8jkMvm+o=;
	b=MPnlUmjZlc/71DDwAGL8R7gBpwiWRnOoW4aspWuO5D8TuCD91q2KKQl4wjfdMe+gHjk9YA
	UWbPuW7btrYP+L0Y3BHkbkZNIEsfuVRVe60WkfdYQbzLjPAr2XkXe7QNbqUa3kOygu1xtZ
	OsfLNEggBMsjlN5leWVZ2sc0vbGWnGs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-DF-ffAdrOESqRhe5PXhErQ-1; Mon, 16 Dec 2024 09:37:59 -0500
X-MC-Unique: DF-ffAdrOESqRhe5PXhErQ-1
X-Mimecast-MFC-AGG-ID: DF-ffAdrOESqRhe5PXhErQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e1b036e9so409139485a.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359879; x=1734964679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBhi7nRN4fiBOZammIZcwLkfnItRrVQeEOJ8jkMvm+o=;
        b=lgcC+c5BEUtUN+dt9EqRBJxANKZf8IQBBsBfB5rzfYdV/F1Fx2htYBov7l8MIZSgDJ
         NoIhJQOUZLiiqK4Xr5pteKuwTiU2WjlCpDrKx01nmcRq5ebBjZUgpcnJwiH16x4nSmVs
         6MtQGpMzoUmiOesLwNI9FAG1R/jEMM9a5vgWie5/4dVDDniDDzs2kEqCOT+EPwwLOMaS
         GRlzO2qkHEKxvQtG4s6vWruNc2Gl7H5BYcoEYkNi+noCikEe8/K8D0u/2P2E6B7+fbSS
         HZuExHR1qQ0PffpB3OTaRQgbdcavIaQmIQSuc/7B+uQN0bwrjksC5yY5PQCrk7wcU+KX
         CjnA==
X-Gm-Message-State: AOJu0YwSgWoRuSwotD8syzzDOgxcOQ4mFGpP6QmLwqLLLMAfutm4zHwP
	mPjUmztzSmHzd7w3PKr1j7s+PwwxmG8si5yHTc6ZzrA8PM3acRuWM97eLVI4lA36KKplzYHxwRa
	lv7s/D5HI9SZ6Dget4Mmq/f2Y8HtZAG0LybIqUsusEoSsvf/0MWzw9k8EsyPzp/IK
X-Gm-Gg: ASbGncuHiyLnFEaLsM+jVHrFPW2+L+pnKjJ6IYXVCKNPlmdBcmTSwoyu2IrfKxbTgxg
	J28YInvuqGAe3KSHiP9Sg+hLbceOB9PCJojQZoMy5U7MxPqGBaTxMbzzpVZOq9q1gX/NRRTN8v2
	e/f2vGlkb0MQN5m1emS2/EXPTFi2hmI1BRv0ymC05nlWYIqB9oioSn9ljfQXXfzZ5DEm/bEREDi
	Sy1HfiBb0ksUuct2nZFnxG2QQICs73CwPUwgVH4tZ6M3uqN1pPtyHihvdh6uzMewoD9OdAelqe0
	Kt2XPGniC8iRvAAsRHmbUzhzI3a1lgTr
X-Received: by 2002:a05:620a:1922:b0:7b1:4f5c:a3a3 with SMTP id af79cd13be357-7b6fbf45970mr2018406985a.56.1734359879084;
        Mon, 16 Dec 2024 06:37:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHng/OTxtRTsSWzpoJOn3Wox2TEJ6binxw9A/nLJ/MMMEYcJG3y4bKW6JnWgm4O8TSO2ULfzQ==
X-Received: by 2002:a05:620a:1922:b0:7b1:4f5c:a3a3 with SMTP id af79cd13be357-7b6fbf45970mr2018402685a.56.1734359878566;
        Mon, 16 Dec 2024 06:37:58 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047aa633sm229110085a.10.2024.12.16.06.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:37:58 -0800 (PST)
Date: Mon, 16 Dec 2024 15:37:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/6] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
Message-ID: <ppjcnfwpedahsx4id3r2ctnj2hfi2alh4ctvsptk23ujzoz5xc@elm6l5hpu55d>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-6-55e1405742fc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241216-test-vsock-leaks-v2-6-55e1405742fc@rbox.co>

On Mon, Dec 16, 2024 at 01:01:02PM +0100, Michal Luczaj wrote:
>Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
>limit on send().
>
>Test aims to create a memory leak, kmemleak should be employed.
>
>Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
>handling").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 152 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 152 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index d2970198967e3a2d02ac461921b946e3b0498837..8f145b6db77d904f3f888ec8fbe76298e7dd91de 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1560,6 +1560,153 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+/* Test msgzcopy_leak_zcskb is meant to exercise sendmsg() error handling path,
>+ * that might leak an skb. The idea is to fail virtio_transport_init_zcopy_skb()
>+ * by hitting net.core.optmem_max limit in sock_omalloc(), specifically
>+ *
>+ *   vsock_connectible_sendmsg
>+ *     virtio_transport_stream_enqueue
>+ *       virtio_transport_send_pkt_info
>+ *         virtio_transport_init_zcopy_skb
>+ *         . msg_zerocopy_realloc
>+ *         .   msg_zerocopy_alloc
>+ *         .     sock_omalloc
>+ *         .       sk_omem_alloc + size > sysctl_optmem_max
>+ *         return -ENOMEM
>+ *
>+ * We abuse the implementation detail of net/socket.c:____sys_sendmsg().
>+ * sk_omem_alloc can be precisely bumped by sock_kmalloc(), as it is used to
>+ * fetch user-provided control data.
>+ *
>+ * While this approach works for now, it relies on assumptions regarding the
>+ * implementation and configuration (for example, order of net.core.optmem_max
>+ * can not exceed MAX_PAGE_ORDER), which may not hold in the future. A more
>+ * resilient testing could be implemented by leveraging the Fault injection
>+ * framework (CONFIG_FAULT_INJECTION), e.g.
>+ *
>+ *   client# echo N > /sys/kernel/debug/failslab/ignore-gfp-wait
>+ *   client# echo 0 > /sys/kernel/debug/failslab/verbose
>+ *
>+ *   void client(const struct test_opts *opts)
>+ *   {
>+ *       char buf[16];
>+ *       int f, s, i;
>+ *
>+ *       f = open("/proc/self/fail-nth", O_WRONLY);
>+ *
>+ *       for (i = 1; i < 32; i++) {
>+ *           control_writeulong(CONTINUE);
>+ *
>+ *           s = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+ *           enable_so_zerocopy_check(s);
>+ *
>+ *           sprintf(buf, "%d", i);
>+ *           write(f, buf, strlen(buf));
>+ *
>+ *           send(s, &(char){ 0 }, 1, MSG_ZEROCOPY);
>+ *
>+ *           write(f, "0", 1);
>+ *           close(s);
>+ *       }
>+ *
>+ *       control_writeulong(DONE);
>+ *       close(f);
>+ *   }
>+ *
>+ *   void server(const struct test_opts *opts)
>+ *   {
>+ *       int fd;
>+ *
>+ *       while (control_readulong() == CONTINUE) {
>+ *           fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+ *           vsock_wait_remote_close(fd);
>+ *           close(fd);
>+ *       }
>+ *   }
>+ *
>+ * Refer to Documentation/fault-injection/fault-injection.rst.
>+ */
>+#define MAX_PAGE_ORDER	10	/* usually */
>+#define PAGE_SIZE	4096
>+
>+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
>+static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
>+{
>+	size_t optmem_max, ctl_len, chunk_size;
>+	struct msghdr msg = { 0 };
>+	struct iovec iov;
>+	char *chunk;
>+	int fd, res;
>+	FILE *f;
>+
>+	f = fopen("/proc/sys/net/core/optmem_max", "r");
>+	if (!f) {
>+		perror("fopen(optmem_max)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fscanf(f, "%zu", &optmem_max) != 1) {
>+		fprintf(stderr, "fscanf(optmem_max) failed\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	fclose(f);
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+
>+	ctl_len = optmem_max - 1;
>+	if (ctl_len > PAGE_SIZE << MAX_PAGE_ORDER) {
>+		fprintf(stderr, "Try with net.core.optmem_max = 100000\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	chunk_size = CMSG_SPACE(ctl_len);
>+	chunk = malloc(chunk_size);
>+	if (!chunk) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+	memset(chunk, 0, chunk_size);
>+
>+	iov.iov_base = &(char){ 0 };
>+	iov.iov_len = 1;
>+
>+	msg.msg_iov = &iov;
>+	msg.msg_iovlen = 1;
>+	msg.msg_control = chunk;
>+	msg.msg_controllen = ctl_len;
>+
>+	errno = 0;
>+	res = sendmsg(fd, &msg, MSG_ZEROCOPY);
>+	if (res >= 0 || errno != ENOMEM) {
>+		fprintf(stderr, "Expected ENOMEM, got errno=%d res=%d\n",
>+			errno, res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1700,6 +1847,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_msgzcopy_leak_errq_client,
> 		.run_server = test_stream_msgzcopy_leak_errq_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_ZEROCOPY leak completion skb",
>+		.run_client = test_stream_msgzcopy_leak_zcskb_client,
>+		.run_server = test_stream_msgzcopy_leak_zcskb_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.47.1
>


