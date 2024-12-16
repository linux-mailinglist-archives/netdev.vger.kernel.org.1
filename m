Return-Path: <netdev+bounces-152245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898209F3351
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B74C18823E3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16EC204569;
	Mon, 16 Dec 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmCxX7dy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CC17BA2
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359774; cv=none; b=d+Mw5lCpyAAEUmCirska7vxJ/imJ/xRmHjIhUeEhL/ftHR8pCjZPu58/AEk8exYl9OYsFYnJiAG255Z/HNyF+Cey2XrajzIV0DjRdORWAOC3y0rJTxcCO1rTPrqVoaS7Bzz5e7sJTujhuHFTVXEay6xhAphpbqkJD8DmuAYYJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359774; c=relaxed/simple;
	bh=YWafFRrIiuIv/13kGAdk9qoAwg5JW+2GL9SBGfci65Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfV+5OURCCQsqtBIr0nRtZhs5YOp+YHVcWSS2cUcgziNDCaJRcHfWMFU+P9IHExjWsM0M/TR6/OB3qByzUkZUWdic741Kk5SlHyZTeDqA31nhJ/zB8kUQnVQNIb4+7JtmKdmHRe8wsVcS/9L8TN/ElUBZn9Q6wCHRXh6M1HOgQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmCxX7dy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734359770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVfBt1frIhyZaWZVk2G02dPgNBrekUG+deF9/AgpVjY=;
	b=CmCxX7dyrQaNYd/rnYYycAGOGhp24MDhIRKXBbC8qTuS9rgKa1mmM3jx1B3sjXyDIbRsxQ
	Jrw5hzQDeSy9UqxOcKt9bwzwyIiGyEQtJ7Dl2kZ3Fa3Sih3RKfDsC9i6GngqXonUJCpshx
	my5QYvJ/owKdQ/ii/LxaUQJtjdGZfss=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-_KeUsynlNZSOn10riPjcLA-1; Mon, 16 Dec 2024 09:36:08 -0500
X-MC-Unique: _KeUsynlNZSOn10riPjcLA-1
X-Mimecast-MFC-AGG-ID: _KeUsynlNZSOn10riPjcLA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87d6c09baso61432296d6.3
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 06:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359768; x=1734964568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVfBt1frIhyZaWZVk2G02dPgNBrekUG+deF9/AgpVjY=;
        b=fcYLpA0AO0ENVvA5FNso12BQz4LHmyH/XwhVIUC4RBUGxgUmUsMvUsb0EJsl7eTG3Z
         7cVr0JzcdvsJaG4Y4gU3NixD+zhDH4NKUKgBXSXCn76O9UZ5H0NiX5TopCEcFj8GghHc
         GKe3VRBCFHTQ+j6x+5fgiUchtCYs0HhEhSbNl6eVENcnBFAocyOHGl3HUtbdE+7MWDlC
         gMYzHXTQlI4vjn1YCG6UnHXf7W+6AaL3VWrDngqW2FgwwuyZD9w701pASQM7Zr/25RZC
         ml/NMms1qf+x+XuIMqBCwL9hu7ORE5rOMAkliImpJRDXJybj6fKeIg7T55phlywvPsrN
         dlKA==
X-Gm-Message-State: AOJu0YwuxkQnGzprLgH2abc7bCGE/GhqAOTuqCXRWn/V3fPHQiMQM6vo
	3ySu6SywOkrtgbddW+gVhgz+FKN+hfplcRVVJW8Z1NumddRmNix8NLKlq7EySy8SHmm8RqVYAtW
	FEW/L9buTcOe3L6dDorGJ3iCnp6XhT2TPy876k2+xMRdIIgPXD3b3uYb1Kq5x6RI9
X-Gm-Gg: ASbGnctFr1qZkkX8ZP/AV68DF7uzQDTVfaUgH3hP+YrN3zdjfnZKpzfYwYqaGqeNiV4
	8/PU1gN/c//bKZW4wXXnGMZSOqoySqWVBf3q0tlh9uIf3k+o0GejMhjE46EKMgItx/y13T+Amn2
	jUB7T+VDzk9kEJMT5o80WiGJK+ueegg02ZJqbvkLsYVNYnCDYJiDkdAyLIqgqNb2ymM76iZFw0f
	3Lctg0014W5PYKeIAOFLwQ1SscqLWQtAlUTKYml/l8eCWTUTSo3fMEjAhzY7xanTnK3PPgAjlxs
	j8zkxrIYfs9S6UA8IaUkBIB/gv2d6gFO
X-Received: by 2002:a05:6214:403:b0:6d8:9bbe:393d with SMTP id 6a1803df08f44-6dc8ca3ed46mr243977206d6.1.1734359767946;
        Mon, 16 Dec 2024 06:36:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpAGds01UPupwI5igOmJS2KcppPYZvDM0uE4LHsR3EDKAnB93zKrZx3g1JemZfziS8/fUsAA==
X-Received: by 2002:a05:6214:403:b0:6d8:9bbe:393d with SMTP id 6a1803df08f44-6dc8ca3ed46mr243976836d6.1.1734359767510;
        Mon, 16 Dec 2024 06:36:07 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd3805d2sm27798436d6.112.2024.12.16.06.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:36:06 -0800 (PST)
Date: Mon, 16 Dec 2024 15:36:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] vsock/test: Add test for sk_error_queue
 memory leak
Message-ID: <cv63klbs5nfos2gzputgnrdjardisniccpgsd4dc7n7ouhxjzq@7t6mgdinopi6>
References: <20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co>
 <20241216-test-vsock-leaks-v2-5-55e1405742fc@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241216-test-vsock-leaks-v2-5-55e1405742fc@rbox.co>

On Mon, Dec 16, 2024 at 01:01:01PM +0100, Michal Luczaj wrote:
>Ask for MSG_ZEROCOPY completion notification, but do not recv() it.
>Test attempts to create a memory leak, kmemleak should be employed.
>
>Fixed by commit fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 45 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 1a9bd81758675a0f2b9b6b0ad9271c45f89a4860..d2970198967e3a2d02ac461921b946e3b0498837 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1520,6 +1520,46 @@ static void test_stream_leak_acceptq_server(const struct test_opts *opts)
> 	}
> }
>
>+/* Test for a memory leak. User is expected to run kmemleak scan, see README. */
>+static void test_stream_msgzcopy_leak_errq_client(const struct test_opts *opts)
>+{
>+	struct pollfd fds = { 0 };
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+	send_byte(fd, 1, MSG_ZEROCOPY);
>+
>+	fds.fd = fd;
>+	fds.events = 0;
>+	if (poll(&fds, 1, -1) < 0) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+static void test_stream_msgzcopy_leak_errq_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	recv_byte(fd, 1, 0);
>+	vsock_wait_remote_close(fd);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1655,6 +1695,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_leak_acceptq_client,
> 		.run_server = test_stream_leak_acceptq_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_ZEROCOPY leak MSG_ERRQUEUE",
>+		.run_client = test_stream_msgzcopy_leak_errq_client,
>+		.run_server = test_stream_msgzcopy_leak_errq_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.47.1
>


