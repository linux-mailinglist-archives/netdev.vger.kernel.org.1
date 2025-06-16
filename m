Return-Path: <netdev+bounces-198079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E5ADB2D0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C383B0424
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525692877E6;
	Mon, 16 Jun 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGgPlGqO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A042BF002
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082352; cv=none; b=EB6DOb7XhzSvJ4plvk4ChOmh+kwxgImo0REc9jUAjwuV2DTPuzbvkonVj7G05RxJQLQNERL0HvMK8QLxO0B9eRCC1gmo1IVEBCfbNei6sMfb7y1OEN/VoDIAfaEs3lx56L+eJspbc62GaKkydsfFTs0du4SI3C8wdUDrDqnC8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082352; c=relaxed/simple;
	bh=vqy7nH2TRHhiiSz/OGaQv55N1pBGXt8kziKc5Kqy/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPzZW6UHU/BtU/P3i5dzD6Nw6pLYk35a9K2f7e4nkP7ICNX/Qz0igmBiMIj4xUETUF97j5+zaAJpHBcattDBW1a9UeyErwwpAKxsjGDQEk3G/82pj+b1Fuh70MoeGfQw7x5X8f0VwhnkDDB9d5H60N2PCZj2d/sRW+O4eyviOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGgPlGqO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750082349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MDXOR2+9SFucAcceARHVMU6Tuqx3sff55HmAoDR3SqQ=;
	b=ZGgPlGqOvgMiZ+2GVovrmzeJYEkLWgmpnx7kEWXXMo3qqhDjPf87PaUqbyDn6Y4HJlFho1
	dGCOjkYh2cvg2ekOw8lyY3VgmRZnJNbtfJL0yiY96sYs97wikOEsnfHa9reZv52k4u//Sf
	hkM0R7unUTzzkh617BOV74qAhK0EqO8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-k2foTBQ2P1KxwTg0_TBihg-1; Mon, 16 Jun 2025 09:59:08 -0400
X-MC-Unique: k2foTBQ2P1KxwTg0_TBihg-1
X-Mimecast-MFC-AGG-ID: k2foTBQ2P1KxwTg0_TBihg_1750082347
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so31081615e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 06:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082347; x=1750687147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDXOR2+9SFucAcceARHVMU6Tuqx3sff55HmAoDR3SqQ=;
        b=E80hZMy5fIh62RJg6ryrMBLltYzMnrj0j3vc0u9F9Pohw2NVUrp8N+AEXL9rxS3BEF
         fuEQOoUxwWgJYhN5AFFotUcDGYeAhNWI+mqHyNcef0rWh5LawUw2QHU3NtKhuCqisrOb
         P8mC02jA91slpTmmce0hr/pDJrVJzjJ47Lz+I2j7376FHe5VLIHCwPQLQfAsHT2Ht+u6
         gFc3LhNQWql6BK24088AhlZ8mvAlp0jCdTahp7607fZ6V70Bv7CJLhsWfTNlguZyoCdj
         JBFCQsJ5M5Fgzs8t6yYWLzsJjQTpY/Br5ZFA3bdX3VcVxIGtSacc+T1DwuUM24JH/svv
         RmMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXg8TP62IFzFPXoCW30AQx6Nl03SDPFf7UAFMMCNF6c2e9g3IQavOtnhAhhXIMAIjWIB0+/xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EwNW/S6ypBvB8vnaim2EuUjGFESQ6M8vZugx1eVXsV7IV8NV
	S69QDAIwdZ20sjYBghekpdDUZqgY9uiXboBlAaIy+21a9ruEcgfMYnVKVlc1qsyk1w2C+bhUoL4
	2y7rGNeFOI6ckrH+6Yn/+pl9nXhwEdd7nBEQSIoNU8zoDg4JENEviOzuHGg==
X-Gm-Gg: ASbGncudxiN35UtU3gfAkX6GAoL10XG3VVRU90IE8PkYEJbkKX5ttOwfjXJON0V63Am
	2xgKWwOEqj+jKQjUO70gQNo5VP1zlHK7/kpcr4AER8UmNqfnFLbwElQXJ7MYM3WFdmN9GHEro1E
	CvrRES02qUOU7vn+G10jWQBIbJYmSFVvwT6g9HtkET9BihDHQIy8Sra0pIo59ShGOrbtliAGaHC
	qmkBZwMQ5X/dVTLY8NnIRx8RTLb0YyuAu+ZtAkSFXibBJ0fQNAi+WKJHqYCB0jH0i+wQgLF+DLP
	CmhAvh5zrFuO3LbMQWHy14bRChk=
X-Received: by 2002:a05:6000:2913:b0:3a4:c2e4:11b with SMTP id ffacd0b85a97d-3a572e5889amr7854239f8f.51.1750082346881;
        Mon, 16 Jun 2025 06:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRgV7a2zE81Cn4q+8HsPH4Efg/1Yo3ECeuGZsn/U6pXmXm9DovaRfGerUSfCxyx2uouMUMag==
X-Received: by 2002:a05:6000:2913:b0:3a4:c2e4:11b with SMTP id ffacd0b85a97d-3a572e5889amr7854209f8f.51.1750082346294;
        Mon, 16 Jun 2025 06:59:06 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.202.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2354fbsm143617795e9.15.2025.06.16.06.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:59:05 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:59:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v2 3/3] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <2oxz7toygswngn7kfmsrbmpikk5qggwbvk3oxb5ucrbq3pcfff@azc54m4hwlfb>
References: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
 <20250613031152.1076725-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250613031152.1076725-4-niuxuewei.nxw@antgroup.com>

On Fri, Jun 13, 2025 at 11:11:52AM +0800, Xuewei Niu wrote:
>This patch adds SIOCINQ ioctl tests for both SOCK_STREAM and
>SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c       | 36 ++++++++++----
> tools/testing/vsock/util.h       |  2 +
> tools/testing/vsock/vsock_test.c | 83 +++++++++++++++++++++++++++++++-
> 3 files changed, 111 insertions(+), 10 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85..472246198966 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -97,28 +97,46 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return a negative value if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int ret;
>+	char name[32];
>+
>+	if (!actual) {
>+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (*actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	int sock_bytes_unsent;
>+
>+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> }

Please split this patch in 2, one where you do the refactoring in 
util.c/h and one for the new test.

>
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5..945c85ff8d22 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -3,6 +3,7 @@
> #define UTIL_H
>
> #include <sys/socket.h>
>+#include <sys/ioctl.h>

Why we need this in util.h?

> #include <linux/vm_sockets.h>
>
> /* Tests can either run as the client or the server */
>@@ -54,6 +55,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca..43996447f9a2 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -20,7 +20,6 @@
> #include <sys/mman.h>
> #include <poll.h>
> #include <signal.h>
>-#include <sys/ioctl.h>
> #include <linux/time64.h>
>
> #include "vsock_test_zerocopy.h"
>@@ -1305,6 +1304,58 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	close(fd);
> }
>
>+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("SENT");
>+	control_expectln("RECEIVED");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int ret, fd;
>+	int sock_bytes_unread;
>+
>+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENT");
>+	/* The data has arrived but has not been read. The expected is
>+	 * MSG_BUF_IOCTL_LEN.
>+	 */
>+	ret = ioctl_int(fd, TIOCINQ, &sock_bytes_unread, MSG_BUF_IOCTL_LEN);
>+	if (ret) {
>+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	// All date has been consumed, so the expected is 0.
>+	ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
>+	control_writeln("RECEIVED");
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1325,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> }
>
>+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -2016,6 +2087,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unsent_bytes_client,
> 		.run_server = test_seqpacket_unsent_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>+		.run_client = test_stream_unread_bytes_client,
>+		.run_server = test_stream_unread_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>+		.run_client = test_seqpacket_unread_bytes_client,
>+		.run_server = test_seqpacket_unread_bytes_server,
>+	},

I think I already mentioned in the previous version: please add new 
tests at the end of the array, so we can preserve test IDs.

Thanks,
Stefano

> 	{
> 		.name = "SOCK_STREAM leak accept queue",
> 		.run_client = test_stream_leak_acceptq_client,
>-- 
>2.34.1
>


