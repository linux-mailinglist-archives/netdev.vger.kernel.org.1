Return-Path: <netdev+bounces-150727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E79EB524
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068FF2830F2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637E61B0433;
	Tue, 10 Dec 2024 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlzobWxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6231AAE30
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844997; cv=none; b=ghAOhGb6Y1cZN1W0ZwxY47OmlW/jj6kv51LWtOHfTDjn0mOZVZTJ9ltL+9jKapyzmW6qSDfdULl0T6yt+fVGnsQzoBulRlKwQWLc5f9P7AvRewLKKSwpzlinwch8J9LbkxPwaPvB6McQARAXpAGqbfPVjGmjg6ASksxx60qYtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844997; c=relaxed/simple;
	bh=SwOAAPuu7/dVwWLxTmAG5aAZ1CditX8krZwjJJ/NlD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWG+fDEmOef06Ius6rjc5fhf6QjTaNGAai2WhOOyZnppFwibPkwVZAqh89a4DJiWYbDafUtHaN1L6ZVyBCK8Tc0KUXTBTqiagb5WTn3pTBmJzkGH6jxHPsIKPUp1w1TSy5tanD1vdLzxDp4uxh0RFPB9Xsbl3WoAkszdUUMp3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlzobWxV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733844994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p4JHVIupJYhcnCPgn0RJ5p+5L5Q4CoL+DBFWHZcfu8=;
	b=PlzobWxVBXjNqBke3ccm+d9YvjTgBxQiUV0sX0whY2Pzj1WQGZmOcw4uyNpfblTOpywUz2
	MI7hOcVFd0IRS5sugrik/BMnQ1Ac5ZVKNUn2Oc2z9GyfEnT1ZhEk0lmyXEHHBm0oYs3k9v
	QEOKTMjmfGb2apNfGaH/ObBPOdCnybA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-ArUZ0XlEOeuDQYjb4gIypQ-1; Tue, 10 Dec 2024 10:36:32 -0500
X-MC-Unique: ArUZ0XlEOeuDQYjb4gIypQ-1
X-Mimecast-MFC-AGG-ID: ArUZ0XlEOeuDQYjb4gIypQ
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6e1b037d5so96238385a.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844991; x=1734449791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p4JHVIupJYhcnCPgn0RJ5p+5L5Q4CoL+DBFWHZcfu8=;
        b=Yk69Z7+w5oH4F9bbR8gtFJwpno/uU0OaeQl6qw6x8GvhXlgDZVlcOX1sMNjZB2SHmr
         150nyWLWE9AMQ0R6kvIUrxAvMszaX5fAoiOzMztcGeye3TbzQ308VpFecBqukX5P/HsG
         OiHIz1LuPken85yve6Kg55sNdHKqbGZPnsLdnWhBhs4WaOeZlOdfI5s4LyXidonyfFZB
         o7lGcRG1J5muSmLACMlOdBMg4f2CkvqormhcK3dTi4sg71Jc0BXGgEZO8xosYKhfhmUJ
         r+GSgcWCYtvAdgE1BJme4bru3UXxBQa2TVkg6ZG4FbUNE7o89DRufgBXFjtSOPR5rdSO
         XjFA==
X-Gm-Message-State: AOJu0YwTt+2XCpx9IN6ioaSSyiaakm3MdhYxRbFpjp0TpekRzR3fY3hU
	wSPd9yYsTDlLmkzhV1xo9xc1biKqELDhyBXppvMPNUYgLY9NgbeKAzb8LZjuhyjvJdQ/x6n1BUG
	L2Ngvv7mq7tVgI9WTGJ9Z2HYF+veNteERqR6v3Oxx4erGaO5X8I8OUtQSpM5VqQ==
X-Gm-Gg: ASbGncs8cgIx5sLHQvlqGRM7KX/uQhfKLg/yp7WjbWdgB7+NBlketXfJZYU6Fuiu711
	Y790FlBH6WkaAxGHNiY9u+C95p2XgphDGnT3iDPW6kY7FWbclqAfeaa/dgSgdW5LJMjSTwah8Ug
	qHRSfIGYMJiDoTl8PdhaacA8VLsdnA+gfAvCXC5YCSAmF79eDTGTb0DFapVLPlLsdAkZqJ5kX/W
	wmoFYAVeYPvJ766Rr5ijWQo/XmkEDhiASP4KnBdaC1iOqqPH1+6Rn3gusRd4ggFuvl3Io0O5SRS
	qWwcDJAhGd73nV2ZVgLcN8WF6LUz9g==
X-Received: by 2002:a05:620a:2a06:b0:7b6:d3b3:575e with SMTP id af79cd13be357-7b6dce8e024mr803317785a.47.1733844991431;
        Tue, 10 Dec 2024 07:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbBJsJhmFAft+bVx4jXuSjSqYu0mf0/m3n3EkBk1M9RjemuMFWHyE9ZQ7GjCDbu/zaUbNKzQ==
X-Received: by 2002:a05:620a:2a06:b0:7b6:d3b3:575e with SMTP id af79cd13be357-7b6dce8e024mr803314585a.47.1733844991056;
        Tue, 10 Dec 2024 07:36:31 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cdecc0b8sm292911685a.80.2024.12.10.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:36:30 -0800 (PST)
Date: Tue, 10 Dec 2024 16:36:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
Message-ID: <oipmjpvmvbksopq6ugfmad2bd6k6mkj34q3jef5fvz72f3xfow@ve7lrp5gx37c>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-4-c31e8c875797@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241206-test-vsock-leaks-v1-4-c31e8c875797@rbox.co>

On Fri, Dec 06, 2024 at 07:34:54PM +0100, Michal Luczaj wrote:
>Exercise the ENOMEM error path by attempting to hit net.core.optmem_max
>limit on send().
>
>Fixed by commit 60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error
>handling").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 66 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 66 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f92c62b25a25d35ae63a77a0122a194051719169..6973e681490b363e3b9cedcf195844ba56da6f1d 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1552,6 +1552,67 @@ static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_stream_msgzcopy_leak_zcskb_client(const struct test_opts *opts)
>+{
>+	char buf[1024] = { 0 };
>+	ssize_t optmem_max;
>+	int fd, res;
>+	FILE *f;
>+
>+	f = fopen("/proc/sys/net/core/optmem_max", "r");
>+	if (!f) {
>+		perror("fopen(optmem_max)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fscanf(f, "%zd", &optmem_max) != 1 || optmem_max > ~0U / 2) {
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
>+	/* The idea is to fail virtio_transport_init_zcopy_skb() by hitting
>+	 * core.sysctl_optmem_max (sysctl net.core.optmem_max) limit check in
>+	 * sock_omalloc().
>+	 */
>+	optmem_max *= 2;
>+	errno = 0;
>+	do {
>+		res = send(fd, buf, sizeof(buf), MSG_ZEROCOPY);
>+		optmem_max -= res;
>+	} while (res > 0 && optmem_max > 0);
>+
>+	if (errno != ENOMEM) {
>+		fprintf(stderr, "expected ENOMEM on send()\n");

This test is failing in my suite with this message (I added errno
in the message that maybe we can add to understand better what we
expect, and what we saw):

28 - SOCK_STREAM MSG_ZEROCOPY leak completion skb...expected ENOMEM on send() - errno 0

my env:

host (L0) -> vsockvm0 (L1) -> vsockvm1 (L2)

L2 is a nested guest run by L1.
L1 and L2 runs v6.13-rc2 plus some commits
(7cb1b466315004af98f6ba6c2546bb713ca3c237)

vsockvm0$ cat /proc/sys/net/core/optmem_max
81920

vsockvm1$ cat /proc/sys/net/core/optmem_max
81920

If the server is running on vsockvm0 (host for the test POV, using
vhost-vsock transport), the test passes, but if the server is running on
vsockvm1 (guest, virtio-vsock transport) the test fails:

vsockvm1$ vsock_test --mode=server --control-port=12345 --peer-cid=2

vsockvm0$ vsock_test --mode=client --control-host=192.168.133.3 \
     --control-port=12345 --peer-cid=4
...
26 - SOCK_STREAM leak accept queue...ok
27 - SOCK_STREAM MSG_ZEROCOPY leak MSG_ERRQUEUE...ok
28 - SOCK_STREAM MSG_ZEROCOPY leak completion skb...expected ENOMEM on send() - errno 0

Maybe because virtio_transport_init_zcopy_skb() in the vhost-vsock case
is called in the context of vhost kernel task created by
vhost_task_create()?

Thanks,
Stefano

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
>@@ -1692,6 +1753,11 @@ static struct test_case test_cases[] = {
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


