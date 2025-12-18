Return-Path: <netdev+bounces-245309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEAECCB425
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6664D3046FA4
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE522F290B;
	Thu, 18 Dec 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRtXRlt1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM/8Vibf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BF28CF50
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051270; cv=none; b=Psf9E1vSTAdCupJUoxxZN/vU+k83ukJkElUeb+e7e7+bA3Ryxn0NQhDmvcYtYBYRJBm7PfsYhYHWB8fghn+VNV8HmV4lHUj9z5NFwn1HNx5yEIriCQ0lk/cRCeWQDMzk+weBite2KH4fpAbwme3AiTFmhhj19XCdYU5ibUl4XxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051270; c=relaxed/simple;
	bh=to2eeWM8ngJq0ie1W1Pn6uqxr8LR35+DjQk3tPBicMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKz31yiP/EPCtfdXewDmV8/E5DudpTECjdn7I+Q8xe9SXEgR5OShkktoSzTOinNyG70FaAoAGz/JT3EzYGllSLsu1aGXmWBiGsU/l9D9DwuOJxzrW/QWVw2VOf5Q5d+uSW7+C8X5AFfFe/xxvQ9YHiPMVod0zAVuuO0frdck1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRtXRlt1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TM/8Vibf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766051267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ha5qM5XeJSqkOafL9yYIppX28PYIQ3jEighrNXdvbo=;
	b=GRtXRlt1DxCfo6XQxqsSKXWPdOtAOhjS4Ex2UPSEC63Pu7ah+v+6FWyFJOB0UivqOkfNHy
	qcq7MlnMe6SE23XhdxBxgQV84ijsMNAjAQkOJlnrupwFrWr2tg29xE0YJNE7NMb+oVIW5e
	jyJ7w+S+TQDMzwSOfE3Of815/Cm4Wts=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-45xkbs0jMH-uhN8N8BHIBw-1; Thu, 18 Dec 2025 04:47:45 -0500
X-MC-Unique: 45xkbs0jMH-uhN8N8BHIBw-1
X-Mimecast-MFC-AGG-ID: 45xkbs0jMH-uhN8N8BHIBw_1766051265
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7a7049e202so50186266b.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766051264; x=1766656064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ha5qM5XeJSqkOafL9yYIppX28PYIQ3jEighrNXdvbo=;
        b=TM/8VibfEruI/cz6yMxr+jRwEcauz4dz9iXlJC5YvFHMV6XGukuhPQwaai7iPOZfdC
         OfVxKVfJngGYmyahjdkyLFGjF5J0EEBux9KVsj9sR3X0W8ZEw4WxrxOZ1P7y7APv+b74
         HgKebAb7dtdYh5e1/FDLOTWR1zUkpbbRgCRiGpyuwIdhMc8eTVyDVPnKe049ksYVVRk3
         YUBxr7qvJuwZGq9W3P4ge43IEZAlJv7hSBlG1CnuLf6yXQD+TXzsBhgrRl5SPYQd4aqD
         hgAseHrUxQN2s1PK1Lnrv8fHSKN2DiRCeMRjYRCGb/cWV9zabUFEqIwSjJybDrMOeuqT
         +q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766051264; x=1766656064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ha5qM5XeJSqkOafL9yYIppX28PYIQ3jEighrNXdvbo=;
        b=p7v3WVVCIyqebaeQbjcfbLR3yftPpZOkxbldmDPRExeMOO9l16YOoFA/P6Y8+tKg/E
         W5Muhi3HqZfmDUUOUgxDc9/wsU8DVUhdJxEbDJsZLlhUD7Q6HEpgjI+qaeO4wO2izx5S
         49hUsubK7DMWHFFjjy7y1xY2Q/4nEQB+S1IHdl2SdDEtIqOpfwaK0Y+tIUISpAIO8yhw
         e3u24mEKjEAhZ41jlXzi8w+kj3n8qXHRDba7pIfAyMboXN8+gfsfEvamOj6FkXpVALxC
         5563YTwg/FIQrUyrAcXWhgMk7n3I/XjLE2YlM1t/KQ91XVZuNFM5bcSGOITUaM5QnCFZ
         Ar6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzyEd+IwYQP9tw45cx5LaARUiDIc9C95lROO9ZdPPhIfAl+a8IrE4eXgPcPsbedBcf120XpUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SUGHX0Y5PWxtLkuSVkf1rtX1YJmGHmyRCMaH8XYX5RR8bWOO
	f6ceXBNf4p/Wyocbw6Qit/TqPSmBZTu89uWt+E7/ySAw4xDl9km38ieZhw7tuBFZAuKVoTwCCB3
	Rk0uAvdJ2IfNvr6cq1kXw5V6l+jfPF4II99VsVtoGi+V5rFz8wEVZvbEu6g==
X-Gm-Gg: AY/fxX48snBTIl16R5YyAYh5iY9oqlkISReEGg9IwWah+lHPA9P1if03/1vrbQz+yaD
	LJEySQzcUo/TT3pERGhXRASU22V3ZlQeLfhaH8vETEMIAWbQORIOGXRDL43bv0VgGUF1HsL0qSw
	I2lift/1anFx17EqygD3a3AUjJpfoExzBueMT+5cymz4kRj477N86kwlJI/AkP2x8cbxUrIgIva
	Z+eAOcCPLMORwJRW4ascgUPjmN/0N/7CEHiolnSrcZXTNBcP3AKqQBe5ajC+d2sOLZyA+tvl8Ui
	wT7vTzXwpqPD4N7lbj0zR+IUQ3lt/pqUWoP9TCr4tcxDhcC56KhnIPym7z6ejrANLhxD+Q3CPwJ
	ltmWIuAO80AwBDHo=
X-Received: by 2002:a17:907:7213:b0:b73:7c3e:e17c with SMTP id a640c23a62f3a-b7d23a1c75dmr2253183666b.44.1766051264491;
        Thu, 18 Dec 2025 01:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeRtf141WERtGc9q8wsZHSiDYrGGvPHvPunOfHx7fqtpGGAw2i6oJ8jd6f+UF+jIGp/dMRcw==
X-Received: by 2002:a17:907:7213:b0:b73:7c3e:e17c with SMTP id a640c23a62f3a-b7d23a1c75dmr2253181266b.44.1766051263854;
        Thu, 18 Dec 2025 01:47:43 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80234a2fa2sm173611566b.55.2025.12.18.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:47:43 -0800 (PST)
Date: Thu, 18 Dec 2025 10:45:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 4/4] vsock/test: add stream TX credit bounds test
Message-ID: <fyuxxdc4rgop73kkevef5gfujgac3f3we5mii4bpoznonlr3nn@6mjpi5df3dlg>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-5-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251217181206.3681159-5-mlbnkm1@gmail.com>

On Wed, Dec 17, 2025 at 07:12:06PM +0100, Melbin K Mathew wrote:
>Add a regression test for the TX credit bounds fix. The test verifies
>that a sender with a small local buffer size cannot queue excessive
>data even when the peer advertises a large receive buffer.
>
>The client:
>  - Sets a small buffer size (64 KiB)
>  - Connects to server (which advertises 2 MiB buffer)
>  - Sends in non-blocking mode until EAGAIN
>  - Verifies total queued data is bounded
>
>This guards against the original vulnerability where a remote peer
>could cause unbounded kernel memory allocation by advertising a large
>buffer and reading slowly.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> tools/testing/vsock/vsock_test.c | 103 +++++++++++++++++++++++++++++++
> 1 file changed, 103 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 0e8e173dfbdc..9f4598ee45f9 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -347,6 +347,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> }
>
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>+#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
> #define MAX_MSG_PAGES 4
>
> static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>@@ -2203,6 +2204,103 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_tx_credit_bounds_client(const struct test_opts *opts)
>+{
>+	unsigned long long sock_buf_size;
>+	char buf[4096];
>+	size_t total = 0;
>+	ssize_t sent;
>+	int fd;
>+	int flags;
>+
>+	memset(buf, 'A', sizeof(buf));
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	sock_buf_size = SMALL_SOCK_BUF_SIZE;
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
>+	flags = fcntl(fd, F_GETFL);
>+	if (flags < 0) {
>+		perror("fcntl(F_GETFL)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0) {
>+		perror("fcntl(F_SETFL)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SRVREADY");
>+
>+	for (;;) {
>+		sent = send(fd, buf, sizeof(buf), 0);
>+		if (sent > 0) {
>+			total += sent;
>+			continue;
>+		}

This is confusing IMO, also perror() when `sent == 0` is not right.
What about this:

		sent = send(fd, buf, sizeof(buf), 0);
		if (sent == 0) {
			fprintf(stderr, "unexpected EOF while sending bytes\n");
			exit(EXIT_FAILURE);
		}

		if (sent < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK)
				break

			perror("send");
			exit(EXIT_FAILURE);
		}

		total += sent;

>+		if (sent < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
>+			break;
>+
>+		perror("send");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/*
>+	 * With TX credit bounded by local buffer size, sending should
>+	 * stall quickly. Allow some overhead but fail if we queued an
>+	 * unreasonable amount.
>+	 */
>+	if (total > (size_t)(SMALL_SOCK_BUF_SIZE * 4)) {

Why "* 4" ?

>+		fprintf(stderr,
>+			"TX credit too large: queued %zu bytes (expected <= %llu)\n",
>+			total, (unsigned long long)(SMALL_SOCK_BUF_SIZE * 4));
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("CLIDONE");

This can be moved after the for loop.

>+	close(fd);
>+}
>+
>+static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>+{
>+	unsigned long long sock_buf_size;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Server advertises large buffer; client should still be bounded */
>+	sock_buf_size = SOCK_BUF_SIZE;
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>+
>+	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+			     sock_buf_size,
>+			     "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+
>+	control_writeln("SRVREADY");
>+	control_expectln("CLIDONE");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -2382,6 +2480,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unread_bytes_client,
> 		.run_server = test_seqpacket_unread_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM TX credit bounds",
>+		.run_client = test_stream_tx_credit_bounds_client,
>+		.run_server = test_stream_tx_credit_bounds_server,
>+	},
> 	{},
> };
>
>-- 
>2.34.1
>


