Return-Path: <netdev+bounces-111547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4093180C
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D5CB226FF
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3033134DE;
	Mon, 15 Jul 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zgq/i6MO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB941BF2B
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059417; cv=none; b=a1m6DJLjoohNgVSIzxsTvlNoO8gzOfggbjcvUUmRWhBM+fbGeUqCuI6cp6JWK9gR2pZNAOnra/mxwYh/axnIk04oh2yU/bKYCjDUtqJtyyYFWUEzVX3Uc/7FpnQUoW0rQf93zz+9LAq+jTxK67kB04c1r1Jp7WXwZ14GnctONh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059417; c=relaxed/simple;
	bh=WwiRujX6MAUUmyIavp+bDMga5jpJYalx8NnaDKPs2nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClAB2HGErTi5k+cJH2H4qSFCRvoGKXmr+ojBi5ihcREisdGt0vbqxCN2PYLjnUvI5LsNqaShXoBX+fU027q3/97avFOY1PeQrENoHzmYG/ItssRGkbNsTMKApF9J7vUklGkzFPontkKl8aIRDQFNUvLBIR4JVcY6TeTD/VqioOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zgq/i6MO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721059415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQzTHcvy7rIISWd9N5iznAkcIpExB4iFhwW9JO+9a68=;
	b=Zgq/i6MO1O0gecPUvaiNYUHCXez95KEcVXwAxd0NuedK1KJ2B/79dipCyA9VDsT86ik3C5
	5qctf0z6SpLRDxpi/UNSmUWMp5v3X/K7ru5TbVyC5R8WcuM+aMWmSgcLMSNDNyrLOL3t76
	WxJgP8xGE9FdPwUc8D8Z+jXob5eSubY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-jsMJbQCCNwW9wr8vKv3iVQ-1; Mon, 15 Jul 2024 12:03:33 -0400
X-MC-Unique: jsMJbQCCNwW9wr8vKv3iVQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4279418eb2bso29548285e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059412; x=1721664212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQzTHcvy7rIISWd9N5iznAkcIpExB4iFhwW9JO+9a68=;
        b=vckte113Met63luaHcHkXtHRzVlIHtRd8uxMLmQarBn0RHxSKeZK76XPUvWR5Wa1bn
         uZpKYopk9r+EWKvmRYGUkuw3u4D+1t3JRbYHkmssjAiDJq5EdWbTP231pb8Rhrlh0OA4
         2WoWxnL2lzTbrXheJQnBEZp59bt0LNnEJcVVITOdC+xc+f7PKp9O5QQME0FTu1/WGf5S
         f62c+/HuwjqH2SFSDGVpI6jWMn1OFC0BZ0/WbvaQcQ6/bbipKIo4sy8TuvAHyr33TuRR
         pCWh9m0hK3dChChrGnPYgR87B+5/hu/JLLZSph7lnwtJlsmJ56F+7avBckJq4LkvOQM1
         eipQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfWMr37f4FtQDe46gq24htIyD1i7GnC83+7qpVcdrgukHV2i0ldP7MqUEsh5Iwy/tbPYdRp90n8HCjgER5T78a1bkXgEbO
X-Gm-Message-State: AOJu0Yw/6UBGxL6thB+lvPEgNkNES2m8tvExqBxOUOoUfD8XfordNEUl
	MT9yXNzm9EOJ6WFLo11wK8sfmDpzjH0buWSs7qArDizBWZgoinGG8HuqYkvM66PGECCFbu9XmVm
	WUaAtapmpQ/LX4togssAhkC5doyq7P+DjAlBeDf4XJJOP51wti7KzYg==
X-Received: by 2002:a05:600c:310d:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427b88c2e8amr511415e9.31.1721059412651;
        Mon, 15 Jul 2024 09:03:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESdfYLQweNPfY1VGrdhD01jrKdhhF0qNRqfcsooulYbUS6vFKHA5l4BVKwugm9LlCeEvW1uA==
X-Received: by 2002:a05:600c:310d:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-427b88c2e8amr511205e9.31.1721059412069;
        Mon, 15 Jul 2024 09:03:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276c52sm127451465e9.22.2024.07.15.09.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 09:03:31 -0700 (PDT)
Date: Mon, 15 Jul 2024 18:03:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] test/vsock: add ioctl unsent bytes test
Message-ID: <5wa2u2eolzxqz2gxeoccazimd4ixpycgkv27cfdmjcpsn3ew2e@drkemucyuvda>
References: <20240626-ioctl_next-v3-0-63be5bf19a40@outlook.com>
 <20240626-ioctl_next-v3-3-63be5bf19a40@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240626-ioctl_next-v3-3-63be5bf19a40@outlook.com>

On Wed, Jun 26, 2024 at 02:08:37PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>Introduce two tests, one for SOCK_STREAM and one for SOCK_SEQPACKET, which checks
>after a packet is delivered, that the number of unsent bytes is zero,
>using ioctl SIOCOUTQ.
>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> tools/testing/vsock/util.c       |  6 +--
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 85 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 91 insertions(+), 3 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 554b290fefdc..a3d448a075e3 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -139,7 +139,7 @@ int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_po
> }
>
> /* Connect to <cid, port> and return the file descriptor. */
>-static int vsock_connect(unsigned int cid, unsigned int port, int type)
>+int vsock_connect(unsigned int cid, unsigned int port, int type)
> {
> 	union {
> 		struct sockaddr sa;
>@@ -226,8 +226,8 @@ static int vsock_listen(unsigned int cid, unsigned int port, int type)
> /* Listen on <cid, port> and return the first incoming connection.  The remote
>  * address is stored to clientaddrp.  clientaddrp may be NULL.
>  */
>-static int vsock_accept(unsigned int cid, unsigned int port,
>-			struct sockaddr_vm *clientaddrp, int type)
>+int vsock_accept(unsigned int cid, unsigned int port,
>+		 struct sockaddr_vm *clientaddrp, int type)
> {
> 	union {
> 		struct sockaddr sa;
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index e95e62485959..fff22d4a14c0 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -39,6 +39,9 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> unsigned int parse_port(const char *str);
>+int vsock_connect(unsigned int cid, unsigned int port, int type);
>+int vsock_accept(unsigned int cid, unsigned int port,
>+		 struct sockaddr_vm *clientaddrp, int type);

I'd mention in the commit description that you need these functions to 
be more generic. Maybe in the future we can re-use them where we share 
the same test for both SEQPACKET and STREAM.

The rest LGTM.

Thanks,
Stefano

> int vsock_stream_connect(unsigned int cid, unsigned int port);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..76bd17b4b291 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -20,6 +20,8 @@
> #include <sys/mman.h>
> #include <poll.h>
> #include <signal.h>
>+#include <sys/ioctl.h>
>+#include <linux/sockios.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1238,6 +1240,79 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
> 	}
> }
>
>+#define MSG_BUF_IOCTL_LEN 64
>+static void test_unsent_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, 1234, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	recv_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("RECEIVED");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int ret, fd, sock_bytes_unsent;
>+
>+	fd = vsock_connect(opts->peer_cid, 1234, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_expectln("RECEIVED");
>+
>+	ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+	if (ret < 0) {
>+		if (errno == EOPNOTSUPP) {
>+			fprintf(stderr, "Test skipped\n");
>+		} else {
>+			perror("ioctl");
>+			exit(EXIT_FAILURE);
>+		}
>+	} else if (ret == 0 && sock_bytes_unsent != 0) {
>+		fprintf(stderr,
>+			"Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
>+			sock_bytes_unsent);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_unsent_bytes_client(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unsent_bytes_server(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unsent_bytes_client(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
>+{
>+	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -1523,6 +1598,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_rcvlowat_def_cred_upd_client,
> 		.run_server = test_stream_cred_upd_on_low_rx_bytes,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes",
>+		.run_client = test_stream_unsent_bytes_client,
>+		.run_server = test_stream_unsent_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes",
>+		.run_client = test_seqpacket_unsent_bytes_client,
>+		.run_server = test_seqpacket_unsent_bytes_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.45.2
>
>
>


