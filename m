Return-Path: <netdev+bounces-203668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AEAF6BBC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEAA17CAD1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DB029ACD1;
	Thu,  3 Jul 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwKldWKa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DF289E16
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528282; cv=none; b=TDGZamjfNvnFfu+HxDdPeVQHNp5E/iaXYqH0DS6S6Zd37dQrcqx8QKA3uE5eW+4PqwVKbjbXuS4Vo73k16v0D193GBwGMvyJIrZTMmOLbaxhvZh4ma62q8aFqgevAXvHK9Dr2okAco252U/Tb7WQsFqbRHrQtpt0fsbtOj4JBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528282; c=relaxed/simple;
	bh=StvLRgHy/q4MiDD/Ld5bixXQfpbBBkt3bw8PICCm5Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuILrTeOQJwAyUVpYcamyEWuTliXMvvW26VcWITZeOzpUXFopLum3zzfv/ZvbxrTb49j8UrSq57Je7qawJaUwoYlmG7vA3n199R3IpHHTfoZRLBGKM5cTRwfiewn4/3USBU6MJgtrKVYG+soKPc8iNMy/AlOaUJjNOwd/D3XTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwKldWKa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751528278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZTrVaT8ExVLM/STBg1Lk/y2I9eHgVWaLY1rsqDq9sg=;
	b=iwKldWKavkMVdb60bZ837/Xq4zm9htFDd6q8d3jFxHkh9FMO6EOK4fN4TR0dcIUIGZihIW
	Kq3K1DrdR1+bf8407UTVHA0pt+Tqkd2cVnQUdu76FoBDrK2WQO/ojntEtBUUuzp8W4KTkx
	jUcT7aKbj3L2QtufIIgUdcUxvusrpoA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607--W0O8wtFPPCaRD-l6PPocQ-1; Thu, 03 Jul 2025 03:37:55 -0400
X-MC-Unique: -W0O8wtFPPCaRD-l6PPocQ-1
X-Mimecast-MFC-AGG-ID: -W0O8wtFPPCaRD-l6PPocQ_1751528274
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso30056865e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 00:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751528274; x=1752133074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZTrVaT8ExVLM/STBg1Lk/y2I9eHgVWaLY1rsqDq9sg=;
        b=rM1jGliStGHhGyznTfAyVOYyRgTrlS4qELfqy5mnflHvxyIqpsr7s45IiIPePAY2Jl
         0SsKLqZZwnMNW6LBwvd2E1Q36ZtDnIxtDsb79Vfzj2HGzsL/chXvU2zz3BNWvJmi6tJg
         b1OuvmFEk30g8zoOb/YLL1niH7wQDj51K+aiuy0ws9A/hvdh/ya6fjjP2oYhqFNKucwF
         kLpcxKq8qi5V5X3vKT4Pz0JsVWx76IB3A3Sngb/+U70YqT6u5vWxjDj9jteNL7PtNn5k
         REEoodYDJ4YQ5l3zzHj7KLiwcyn1r5XAK0J7HrdL3b373NOcvyAjzcvslcCCt08BYHFV
         AzUg==
X-Forwarded-Encrypted: i=1; AJvYcCV3KoiL3DhiIap8RSAomZ66xBB96eQ7hCsmOt66bNLES0gDAycw2UM9xWBnBxR+1XEWwJ2v6jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxalsRw3y/NzW0HNdOJN28paRIQh+9yzSyIsf5bMhw3r7lBYz8j
	7JXRCAvn9y1vT3QzTmdJ9+rCfM2Ds1gjIZhIRfc3HIYIVwCiDHSfXw7dMrlp4x4qOsPgNAaqGE6
	+v1S+VS/X9bghR5M3PirSEBVK/Bo4smCOecgUW/HIHAEWC7WMeLWtii981w==
X-Gm-Gg: ASbGncs5EiTnlW/tQezSL9lTg8eECTRHWCE5cLK0BpVCu5+HATGhApTrpoT5Y4Yq27s
	JmdjmcvdejqPMz2iBWL8fIuAuo30etspp5yhhoabusvjk2aKswal6TzTEsEwGEStm8PpbwOwtPf
	JNWbMvsbdjgnnkGhvguAOm+ljtgqJxFNNB0q1eAC6TD9HeneYo2loJJI8dbj6jz2U6sabYLY2wc
	osOJU57Ae71AsbYvacC9l/9fw9wiwFqro/9/KEdvNuZ/9fTKekY1hwTVF1MXkU7iv/i94yNWJk2
	SlFzmDnKvHtg/BZJuBHeDwFB2tU=
X-Received: by 2002:a05:600c:4e90:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454a373b017mr56578705e9.33.1751528274005;
        Thu, 03 Jul 2025 00:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsDaSQWiaSZmXwr5L45BCRF7nAnAPxMzvbScBf83o6qhxxyDbo0YcmqHWPrAZw9H/yhOS6hg==
X-Received: by 2002:a05:600c:4e90:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454a373b017mr56578155e9.33.1751528273226;
        Thu, 03 Jul 2025 00:37:53 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99a35f9sm18458115e9.27.2025.07.03.00.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 00:37:52 -0700 (PDT)
Date: Thu, 3 Jul 2025 09:37:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	jasowang@redhat.com, kvm@vger.kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [RESEND PATCH net-next v4 4/4] test/vsock: Add ioctl SIOCINQ
 tests
Message-ID: <7cnmlbupia4urmb2ikyomhaayppqgfddmb7u3umgz62jnzcy2p@x6dsvkhfnqze>
References: <qe45fgoj32f4lyfpqvor2iyse6rdzhhkji7g5snnyqw4wuxa7s@mu4eghcet6sn>
 <20250703025156.844532-1-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250703025156.844532-1-niuxuewei.nxw@antgroup.com>

On Thu, Jul 03, 2025 at 10:51:56AM +0800, Xuewei Niu wrote:
>Resend: forgot to reply all...
>
>> On Mon, Jun 30, 2025 at 03:57:27PM +0800, Xuewei Niu wrote:
>> >Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>> >
>> >The client waits for the server to send data, and checks if the SIOCINQ
>> >ioctl value matches the data size. After consuming the data, the client
>> >checks if the SIOCINQ value is 0.
>> >
>> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>> >---
>> > tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
>> > 1 file changed, 80 insertions(+)
>> >
>> >diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> >index f669baaa0dca..1f525a7e0098 100644
>> >--- a/tools/testing/vsock/vsock_test.c
>> >+++ b/tools/testing/vsock/vsock_test.c
>> >@@ -1305,6 +1305,56 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>> > 	close(fd);
>> > }
>> >
>> >+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>> >+{
>> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>> >+	int client_fd;
>> >+
>> >+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>> >+	if (client_fd < 0) {
>> >+		perror("accept");
>> >+		exit(EXIT_FAILURE);
>> >+	}
>> >+
>> >+	for (int i = 0; i < sizeof(buf); i++)
>> >+		buf[i] = rand() & 0xFF;
>> >+
>> >+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>> >+	control_writeln("SENT");
>> >+
>> >+	close(client_fd);
>> >+}
>> >+
>> >+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>> >+{
>> >+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>> >+	int fd;
>> >+	int sock_bytes_unread;
>> >+
>> >+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>> >+	if (fd < 0) {
>> >+		perror("connect");
>> >+		exit(EXIT_FAILURE);
>> >+	}
>> >+
>> >+	control_expectln("SENT");
>> >+	/* The data has arrived but has not been read. The expected is
>> >+	 * MSG_BUF_IOCTL_LEN.
>> >+	 */
>> >+	if (!vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread,
>>
>> I know that TIOCINQ is the same of SIOCINQ, but IMO is confusing, why
>> not using SIOCINQ ?
>
>I tried to use `SIOCINQ` but got:
>
>```
>vsock_test.c: In function 'test_unread_bytes_client':
>vsock_test.c:1344:34: error: 'SIOCINQ' undeclared (first use in this function); did you mean 'TIOCINQ'?
> 1344 |         if (!vsock_ioctl_int(fd, SIOCINQ, &sock_bytes_unread,
>      |                                  ^~~~~~~
>      |                                  TIOCINQ
>vsock_test.c:1344:34: note: each undeclared identifier is reported only once for each function it appears in
>```
>
>I just followed the compiler suggestion, and replaced it with `TIOCINQ`.
>Following your comments, I found that `SIOCINQ` is defined in `linux/sockios.h`, as documented in [1].
>The documentation suggests that we can use `FIONREAD` alternatively.
>In order to avoid confusion, I'd like to choose `SIOCINQ`.

Yep, I'd also use SIOCINQ.

Thanks,
Stefano

>
>1: https://man7.org/linux/man-pages/man7/unix.7.html
>
>Thanks,
>Xuewei
>
>> The rest LGTM.
>>
>> Thanks,
>> Stefano
>>
>> >+			     MSG_BUF_IOCTL_LEN)) {
>> >+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
>> >+		goto out;
>> >+	}
>> >+
>> >+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>> >+	/* All data has been consumed, so the expected is 0. */
>> >+	vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
>> >+
>> >+out:
>> >+	close(fd);
>> >+}
>> >+
>> > static void test_stream_unsent_bytes_client(const struct test_opts *opts)
>> > {
>> > 	test_unsent_bytes_client(opts, SOCK_STREAM);
>> >@@ -1325,6 +1375,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
>> > 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
>> > }
>> >
>> >+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_client(opts, SOCK_STREAM);
>> >+}
>> >+
>> >+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_server(opts, SOCK_STREAM);
>> >+}
>> >+
>> >+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>> >+}
>> >+
>> >+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>> >+{
>> >+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>> >+}
>> >+
>> > #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
>> > /* This define is the same as in 'include/linux/virtio_vsock.h':
>> >  * it is used to decide when to send credit update message during
>> >@@ -2051,6 +2121,16 @@ static struct test_case test_cases[] = {
>> > 		.run_client = test_stream_nolinger_client,
>> > 		.run_server = test_stream_nolinger_server,
>> > 	},
>> >+	{
>> >+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>> >+		.run_client = test_stream_unread_bytes_client,
>> >+		.run_server = test_stream_unread_bytes_server,
>> >+	},
>> >+	{
>> >+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>> >+		.run_client = test_seqpacket_unread_bytes_client,
>> >+		.run_server = test_seqpacket_unread_bytes_server,
>> >+	},
>> > 	{},
>> > };
>> >
>> >--
>> >2.34.1
>> >
>


