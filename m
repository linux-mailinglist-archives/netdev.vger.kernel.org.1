Return-Path: <netdev+bounces-204928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B873AFC90A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FDD161C78
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB402D8DA2;
	Tue,  8 Jul 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faXuwySQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC72D8764
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972273; cv=none; b=UVRaI6XOwzPZNlVu2468YQI0DBhHk9Sc6mt03+sIQKSeFT7x0FZpKISDG9tS0h60XBvDc8S+mC3UgCOFlgCZeRF0Gcq1OguRaiBnqbycnO51ZbgvRBCiUZ8HkJqTIbKFJbiuFZ+Yev6DzG38gB+XuOVKqvA1vjPFXcTgyPWCY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972273; c=relaxed/simple;
	bh=0P756gIlMCljTwX29Aq9/86jpCbNsX2kUDsw0YsiQvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzoixphcNicgivhFBE0/Ks3WSkmgi/O7WKdkbSZm5FJGM3i3ksKxCClkygOOvEvWsK8DnyL3NeR7Ql0OgdiiuW3Llf8vQPZkNBYqoOA8zhplxe6PrVhGJk2imi+UST8mlxYM3RS15WyqT6+a2PPJ44dR4Za0kynrKnU/Y3775Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faXuwySQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751972270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DQ/E/9WOO/fmQutLMz6YjEgOHHLMdYMOPe5H/Qd8q0=;
	b=faXuwySQV/mnvw0PVHu2deq/RvOAw9gJkeW2nbFvf/nItEZy1mu8+Il+7t4fX/lCQWLbbr
	ld+0xSUzTAQUeawqu95pQmAWHQMwgCjW18BO8SvxvpxJ65DwZZmOzyCyqxkPYJr80/PfSN
	HNtHIWZpytBZEMSrrZcVPgV2N0SavnQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Xo70FpkOMZqAJA3rViDdGg-1; Tue, 08 Jul 2025 06:57:47 -0400
X-MC-Unique: Xo70FpkOMZqAJA3rViDdGg-1
X-Mimecast-MFC-AGG-ID: Xo70FpkOMZqAJA3rViDdGg_1751972267
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5bb68b386so1181812885a.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972267; x=1752577067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DQ/E/9WOO/fmQutLMz6YjEgOHHLMdYMOPe5H/Qd8q0=;
        b=OqlRI8smKcYJPf7vztq299MEjKK7h2gJjHx5z2bOuMOunVhfRXm9yj1Uq76boc8Y6G
         ib4uJg6ahtveR8H+yjDSXEQKvV3EHCADhHxxVnOTetmU+IjngPiyRBYVBb96XKjJeCx8
         4obuLDeiVZ5lsI/wkY8z2Oq7ngdOdx3QKRLe09SyWmcT46BqXV7gauzcrDndP1AEyEef
         92f7meVXLx/o8apMc9NxfSp47g38wzoA9JO/z5dgvuW45Chl4hafkUt3Ky/a4Qyf1ODe
         lStnmdTj/oBJFBGg/G38bWPzDG60GHMwIhF2QGxklGs3NBB9NWZ4koS3ibgTJuMM1ZR6
         ycsA==
X-Forwarded-Encrypted: i=1; AJvYcCUQGdZuLAiRczpFuM4Je2yvDqm8L9bBALGPk+KUK91GWZ/0hWT88mVR1oyrWYW1NArmWyyVCrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBPfnP0NXMCK4jEvh4HTzD84L9QWUvLrSAxRS/R7B3wTmDPUn
	9C8O30A1rro7IdZWjC9Qt8eLpYOR0qGoLp7m2iZLJZd642rg3sjEPutM4J97jnR0pv5PjY/fN+A
	nw8THedhSGbqN3C27/IAML0gD3JZSROS5Iz/rmS4xfco+m8CQclBlgnWScw==
X-Gm-Gg: ASbGnctB/jclwAkfYMxGljjm52Sd5XCm6jtmr3yZ5VhH4/eYwHKxARcFzFrC1RTTCcV
	kNbqJrd3KmTvsusMKtX6hbGtW5wgTGRhlXt8NS6PZ+uFiHU91epIB1J8f2vI3WonxCm/JxKwIkp
	HYASdvQWZz0fPEWctp708+Nh/6h3mrJOA/bxvdNwLqua/lK0o0/YdDvQe18UM3etvGVO9jYFct9
	ng9I2vma0Cxx7bMx1bBfwqjgLysXSPRZI5ZuvsVTvrE9NiTeDHSwMmnBIVg9s9WZm7pJfMyJmxb
	B+ClIRAf7T4imqcF7lXk8mfK3YXr
X-Received: by 2002:a05:620a:ab04:b0:7d4:5361:bb7e with SMTP id af79cd13be357-7d9e98ce5damr393764085a.8.1751972267012;
        Tue, 08 Jul 2025 03:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjTh5AgM/mq1omdv2dUvDUu+a8oWKonU9fOdeKahIeI71KEtsWGSzhCFti0y7wkoZ1vg/4dA==
X-Received: by 2002:a05:620a:ab04:b0:7d4:5361:bb7e with SMTP id af79cd13be357-7d9e98ce5damr393760385a.8.1751972266509;
        Tue, 08 Jul 2025 03:57:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d5ad73sm73432866d6.92.2025.07.08.03.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:57:46 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:57:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 4/4] test/vsock: Add ioctl SIOCINQ tests
Message-ID: <uvoupm7je52ak5hwtumeyhrpou7xj6hhipktodun2xsq3t5ktb@w5iv4jsacxl6>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-4-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:14PM +0800, Xuewei Niu wrote:
>Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 79 insertions(+)

While testing this, I found an issue with the previous test.
I'll send a patch to fix that, but skipping that test, this run well:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index be6ce764f69480c0f9c3e2288fc19cd2e74be148..a66d2360133dd0e36940a5907679aeacc8af7714 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -24,6 +24,7 @@
> #include <linux/time64.h>
> #include <pthread.h>
> #include <fcntl.h>
>+#include <linux/sockios.h>
>
> #include "vsock_test_zerocopy.h"
> #include "timeout.h"
>@@ -1307,6 +1308,54 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
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
>+
>+	close(client_fd);
>+}
>+
>+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int fd;
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
>+	if (!vsock_ioctl_int(fd, SIOCINQ, MSG_BUF_IOCTL_LEN)) {
>+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	/* All data has been consumed, so the expected is 0. */
>+	vsock_ioctl_int(fd, SIOCINQ, 0);
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1327,6 +1376,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
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
>@@ -2276,6 +2345,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_transport_change_client,
> 		.run_server = test_stream_transport_change_server,
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
> 	{},
> };
>
>
>-- 
>2.34.1
>


