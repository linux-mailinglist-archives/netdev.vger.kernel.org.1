Return-Path: <netdev+bounces-114416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D605B942817
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249B9B23612
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916A1A7F68;
	Wed, 31 Jul 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhAibwwu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9D11A7204
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411275; cv=none; b=dgutfwOm9050vIJnTACMMtHKzWmA+GR2SDNBsqg2YGPqrRSPNI2AKCIc18XXpNdALYerjiLsJL4nDkxLgWfdTEcN1Q8PeQvd5yytVNbjpz/es1wqR6UKBTZ4/kk1i9CyyXJIzKkA71+4LoJTnQGquOjQJecogAUa83g4juDks9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411275; c=relaxed/simple;
	bh=Gak5yeR8VRusOvp0/kzW3IG8z/6DzJNwbVnUeTzihXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/H0twEs3bDuzM5JaMQobWHHwruqg65wYMZoPL589O60OeXAnSXnc9cSMzUggDdKuZkCEiaygCE3McLgXpmlSK9UNai7yYyW4/7kYnwCl6QJmweX0CeNDWyxU+xvd/WVjrS76ae9tEdeM+cEn70YET5YYVUXgZ4vEZdKQaaJtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhAibwwu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722411272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liSpAiDTUbHgZ59xdpyFaqIUNTbkyxGemEwWb3TJjD4=;
	b=FhAibwwuhMpiz2ioqKewv4moR0tjuKUhDFAeWXyFc6zJZP1lHwB5OJMSWBgc7GzRmfC/bT
	rrxA8VMgJXftgjizKLlNXrt7LcHl04F1+3dlC5eawdxXTyP8A/+S0E5zth1fnlK6NVJGaJ
	dZUQC3AQ1Mmm5Nj1IZZzgjUa57PD6Gk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-cRzzfb-7MN2EOkwOIT72yg-1; Wed, 31 Jul 2024 03:34:28 -0400
X-MC-Unique: cRzzfb-7MN2EOkwOIT72yg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42820af1106so18656165e9.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 00:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411267; x=1723016067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liSpAiDTUbHgZ59xdpyFaqIUNTbkyxGemEwWb3TJjD4=;
        b=JMtcRRj1FTixCyxjXEGXYrksha3fn9/ddOqwUH+la2QOg9V7LuQrS3PBnSGVjDTz8J
         ZqB7Vdqm4Hj5qGXNHHBwkBGlemUgaoGMlLoiQfs4i8FyFR9mMoG1qnxlqnJlpDZ79PjD
         VSRiyVFzzR5Gp+5QNAVUqOwgHYMZO7E5XyxXe9QBlsormxEXyTGJhn/vHwH23PgUGtnX
         ljG8icaEkEF0iIp8lB/3RmHWukDaBGUWWl/hh4SY4EzKq89PvKnekDUTF3IAUeC29BZ4
         aZ1u7944tib5cKNwSGDKOxy1aUEO18mcQe7+hwtpxbNJHM0LnnBokteUvQpVhHDIyoJi
         4vsw==
X-Forwarded-Encrypted: i=1; AJvYcCVzmbGgVqrF39jtQsFPh/CD5dOCU7X/mVLVpZ5BeEicBnl1gKIL+PlZXuY307GbY2HuBZSQ+PLr23xbCaKP6z6Sw3ZxwCrN
X-Gm-Message-State: AOJu0YycZCwV1Cbmu8It9ecLrRtuefNA+qgq2dyVNEVwtBs6s1TxuHQd
	29HrbLdlus9qcLksE5p+hQHvFXqCPeD/Ncpyd6u1n6P8vBM/dr5zzDYyDylMXIszm6Eb2KMJ29e
	OHbFiDrHKF5+8p/TOIQbYT0m9kWiucdumdGkdwb1fFvIeqNSnfVhHKQ==
X-Received: by 2002:a5d:6d81:0:b0:368:4c38:a669 with SMTP id ffacd0b85a97d-36b5cee2e5fmr11883045f8f.10.1722411267568;
        Wed, 31 Jul 2024 00:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBTCBZeZ3OL31V50HfMNb3GwmezjEGP4L2hvmbUqCooevsDrGH2P1wuK7Cpsd3AvFPc55jIg==
X-Received: by 2002:a5d:6d81:0:b0:368:4c38:a669 with SMTP id ffacd0b85a97d-36b5cee2e5fmr11883008f8f.10.1722411266756;
        Wed, 31 Jul 2024 00:34:26 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc445sm16258370f8f.48.2024.07.31.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:34:26 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:34:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] test/vsock: add ioctl unsent bytes test
Message-ID: <noiyd3nshreikxafr6xavtwpqsb66m5sxsuqz7uh5ys4c36gyr@ewavohrfjr4n>
References: <20240730-ioctl-v4-0-16d89286a8f0@outlook.com>
 <20240730-ioctl-v4-3-16d89286a8f0@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240730-ioctl-v4-3-16d89286a8f0@outlook.com>

On Tue, Jul 30, 2024 at 09:43:08PM GMT, Luigi Leonardi via B4 Relay wrote:
>From: Luigi Leonardi <luigi.leonardi@outlook.com>
>
>Introduce two tests, one for SOCK_STREAM and one for SOCK_SEQPACKET,
>which use SIOCOUTQ ioctl to check that the number of unsent bytes is
>zero after delivering a packet.
>
>vsock_connect and vsock_accept are no longer static: this is to
>create more generic tests, allowing code to be reused for SEQPACKET
>and STREAM.

Yeah, good idea. We should use them for other tests as well.
(for the future)

>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>---
> tools/testing/vsock/util.c       |  6 +--
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 85 ++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 91 insertions(+), 3 deletions(-)

LGTM and I ran them. All good :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
> int vsock_stream_connect(unsigned int cid, unsigned int port);
> int vsock_bind_connect(unsigned int cid, unsigned int port,
> 		       unsigned int bind_port, int type);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f851f8961247..8d38dbf8f41f 100644
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
>+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
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
>+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
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
>+			fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
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


