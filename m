Return-Path: <netdev+bounces-150743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB419EB5F4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57C6280C07
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5119D06E;
	Tue, 10 Dec 2024 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGA6mP4e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F818A94C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847532; cv=none; b=qcql+9cnKl0dk1WthsnghhJR0+csOnaPT5hYvL7QC9OAb2NWuiKEiFQQiXkb4uE5z0qtN6a7jZuISf7vKffF+qRNdtuk7yOav7TdWWMrUE5TK3IrvApSqKNOkF7HYABT1oQNK71tOcxnLCN22ANC49NLnZ6wuEcFcq1EbB1aLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847532; c=relaxed/simple;
	bh=JIM6KyIdXrfVt/JFP6GpCku2ha2qnINgUsHDGeaNDKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMStkxu6y9cgFShqRQthX9uiHM5oagdqw8A+UYYpKnI0bLSOqVAaqKEZlpunnTqvv110cvXum8LAZ7C98Mc1SEps6TjGnClLtXXYN5EGtzl/osOmUD8aB9o3I/9b33tHg0drVEGGYaFY3DyeEjrdj5BLDdPrNd4KvB+LsvcM9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGA6mP4e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733847529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Obirp+9f7rF4HRzbdz8LF0H1zvey8h3nU8PCjNPfLZY=;
	b=iGA6mP4efkq038fpuyMv8f2NA+Z4jQKZRUrf36FBIKCLb7tt9MeeBawJKYa0q8KSnykUkZ
	MChf+lp703kHe0VSv7y7TNYnu8z7W1lhb3h+d6rezNQzTyUPZxilD/lEtvCLVqiqbLWDm3
	R646WxuGk3rSNKGpwnco2LRmtNTPTO8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-va_9uLUDOam195A9SH5gzA-1; Tue, 10 Dec 2024 11:18:45 -0500
X-MC-Unique: va_9uLUDOam195A9SH5gzA-1
X-Mimecast-MFC-AGG-ID: va_9uLUDOam195A9SH5gzA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46746ca3a24so49798891cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847525; x=1734452325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obirp+9f7rF4HRzbdz8LF0H1zvey8h3nU8PCjNPfLZY=;
        b=Iekts1IG/0NS9nDTYwXlF9tM53BlqO80EEvS38xLcWRcjlr+YDAuYbOaDI0RIN4IBn
         qA+ZzDLOs4yu1SaXAMCzK+mAr2V6ZRweLyMYrWAruznyyOR5HB+3ewrZV6UN9WzbMHv2
         QkEo2pQD8PzK1YE+HyoSq5B4Cu5CXHf2Zs6yIEaTpCqpO+xkCTk+O+pXPrwcs468XW7/
         E2aJAYNscZm3PLUHgtGpNLoF9Lb2krcQ7cgUnPVrf0iYcbqJeCP2KzHsVqJTpxlR+8F+
         6Blck7y1rv4F8/XmbHOL9rSvkjXjLkbK4ITZjdzOYJWWUDcvVH1BgT/qQlfhlMz6Q33m
         IrQQ==
X-Gm-Message-State: AOJu0YxYZBfllFvLbZD2K9I6AiPSYVnlqwrt22pzzBO8JScJCXwrtlJ3
	tFBAKbzu0IP9hQDRcwKifkd6vD4s0JLdLm+b1Gk3YNBD7r41hB11DdT88JtgpF57jw8Gw1GUAUR
	+nie6SwRUwkDcipZvWFF5lXE0rVL6TIkKD68+bss4jJ76PR417/nYOrGGXDI+gg==
X-Gm-Gg: ASbGncuTQDk0BWfCUhYvm1ktUsiAqtfKTU2qKXHXAC5nnCyS24z01RAzl5zefpJ7Wdm
	Ts6nSyfcyg54JgttOVSH9YNlomOkT7j1ETlwqhhfYEE7lHT86dsHmINlSh3rjijeemi7f/yadBG
	YJ2lutb5vjYS3qNdKzJYb6aAxj1C/pQG9gBCBjZOjjIzWYXI/VOpoPge6Y7SKR00FkhvWm40xAc
	hHQJWKQee7jw7xiT/leI2vxPR0iO0rZzW2M0QhgdOjG007MbNXuT+8+bzsd8VQCb/dRJE7qfPCM
	IVkRxTs92rlvf3bpSiIf8En5RA7JZw==
X-Received: by 2002:a05:6214:23c6:b0:6d8:8466:d205 with SMTP id 6a1803df08f44-6d91e300ba4mr82823426d6.6.1733847525040;
        Tue, 10 Dec 2024 08:18:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFII1uvxwFDcKnuZZq4bxZBfQIVkpuJtFI1EVeGto4Gy48nxp1yfYlcY1erDnNFWCUOlFH85w==
X-Received: by 2002:a05:6214:3016:b0:6d8:7db7:6d88 with SMTP id 6a1803df08f44-6d91e38cc48mr97795676d6.28.1733847513248;
        Tue, 10 Dec 2024 08:18:33 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da699417sm61383266d6.44.2024.12.10.08.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:18:32 -0800 (PST)
Date: Tue, 10 Dec 2024 17:18:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] vsock/test: Add test for accept_queue
 memory leak
Message-ID: <uyzzicjukysdqzf5ls5s5qp26hfqgrwjz4ahbnb6jp36lzazck@67p3eejksk56>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241206-test-vsock-leaks-v1-2-c31e8c875797@rbox.co>

On Fri, Dec 06, 2024 at 07:34:52PM +0100, Michal Luczaj wrote:
>Attempt to enqueue a child after the queue was flushed, but before
>SOCK_DONE flag has been set.
>
>Fixed by commit d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory
>leak").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 44 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 38fd8d96eb83ef1bd45728cfaac6adb3c1e07cfe..48b6d970bcfa95f957facb7ba2e729a32d256b4a 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1474,6 +1474,45 @@ static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
> 	test_stream_credit_update_test(opts, false);
> }
>
>+#define ACCEPTQ_LEAK_RACE_TIMEOUT 2 /* seconds */
>+
>+static void test_stream_leak_acceptq_client(const struct test_opts *opts)
>+{
>+	struct sockaddr_vm addr = {
>+		.svm_family = AF_VSOCK,
>+		.svm_port = opts->peer_port,
>+		.svm_cid = opts->peer_cid
>+	};
>+	time_t tout;
>+	int fd;
>+
>+	tout = current_nsec() + ACCEPTQ_LEAK_RACE_TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		control_writeulong(1);

Can we use control_writeln() and control_expectln()?

>+
>+		fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+		if (fd < 0) {
>+			perror("socket");
>+			exit(EXIT_FAILURE);
>+		}
>+

Do we need another control messages (server -> client) here to be sure
the server is listening?

>+		connect(fd, (struct sockaddr *)&addr, sizeof(addr));

What about using `vsock_stream_connect` so you can remove a lot of
code from this function (e.g. sockaddr_vm, socket(), etc.)

We only need to add `control_expectln("LISTENING")` in the server which
should also fix my previous comment.

>+		close(fd);
>+	} while (current_nsec() < tout);
>+
>+	control_writeulong(0);
>+}
>+
>+static void test_stream_leak_acceptq_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	while (control_readulong()) {

Ah I see, the loop is easier by sending a number.
I would just add some comments when we send 1 and 0 to explain it.

Thanks,
Stefano

>+		fd = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>+		close(fd);
>+	}
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1604,6 +1643,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_unsent_bytes_client,
> 		.run_server = test_seqpacket_unsent_bytes_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM leak accept queue",
>+		.run_client = test_stream_leak_acceptq_client,
>+		.run_server = test_stream_leak_acceptq_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.47.1
>


