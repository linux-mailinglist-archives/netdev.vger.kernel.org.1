Return-Path: <netdev+bounces-138512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E359ADF62
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60370B228C0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198201B0F26;
	Thu, 24 Oct 2024 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qvorgh1P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E41ABEC7
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759437; cv=none; b=JUkxuAS9JCMoYmos3SC+c1G91k7etC2HcIRZ4BYjN6eo/0BCTvCK+yfBN/0s0R8+pq23WfW5OydTJWLKifdRlptYM6QCfyYUZTqi8h3UaB5qqg88JRwQZNkVjKfwRPriP+aZ9m3QHb8yNHYksjGv+X01UmRCrspmSWowXct/3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759437; c=relaxed/simple;
	bh=UCi5ELepQZZwWFe9oCjZrBvOZ/qfebT40DeKQbBbNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOWGPS4sXtaJ/xxfbw4lvMcU9RDiR9gBWp2H2fZqcNhSNgJmgvEMDTUI6ceroEYGeP6j3lh5E1lHp9+J4J06ur6QCPqfKXCVbr5SEb+xgy4dLgjOAf7pC8uS7+9cltpbTZBnYWS1yird+fEl7yhJ+Gdwn2RqwI380h4Txk5UOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qvorgh1P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729759433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iR9AjakJn4hoJuTZIbyhybHiqFDkYJYpjuoN4hxDG2w=;
	b=Qvorgh1Pq+uLYH7Aq/4BCgZCV2o+R7LppxPnn6Tek4Ko5TmWFhipVRmBPo4qYdSnjBdAXT
	E9olfwFtKb4LsgnTBlOBEqFSpkmg6BZKqEPWzM/seou/pwzZ/ifGuLtHUGXybTNWflA0af
	/04dPWZSmM9oimolyYlsKMBbtreV5O8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-KvrORL5vNEGPRK6az6wSgg-1; Thu, 24 Oct 2024 04:43:52 -0400
X-MC-Unique: KvrORL5vNEGPRK6az6wSgg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-84ff4a09958so299273241.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 01:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729759431; x=1730364231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR9AjakJn4hoJuTZIbyhybHiqFDkYJYpjuoN4hxDG2w=;
        b=DY4BQlbqMNhcrZydBoekumfyAzFeotgj8zDS+x5vJpGJ/rZaod2wmk0Ponxsx2y+lH
         BTbnfbcPCrq/xvXFbAw2WxLKzL7yjU7tAzdZivTM0D1kavWNkhMp118GMTanidfS4EuU
         6bBueTGmBQ3ouY0LcYmee0B7xLr2RQXqXVCDYC4lWEBE3z6W5eTQg7234i1HacWzzimO
         xfmxQOnQdS2bkdBrFnaMBmT5CEkjgQ2e1yIqZkyKi8mD85J/ZZmXzbO/2nrM+T6Qbs4D
         O7BqMSVcJiCIZJZWE7VZEPcX4pl2Xp/OtlXNHa0CVgHjuJu1KXC2JhJZE+waC5vkPj+W
         D+1A==
X-Forwarded-Encrypted: i=1; AJvYcCWSsH63436gGV/7eDKdUc8sQjn6tETFu+QXm4+91npjDnrkWWboknwoiowF3lNH2zxK7lpueG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5LHRbqpkc7KUrogDpwHDVpYI1TYMk9BTA1OKFn0EcAtHlwBR
	27Knqwsn2tfzssbYffeKP6hHBFpdKQqNX9TsLx2YCarekIy8J9l7LM3ku7FZVIOP1qLTUymOvgG
	9FrhgV8RLSHsa+4UyDNUtHVrBwhiNJKe/C+Fm0/+lQ0JEQ4OB1aMpyBduWmqL/g==
X-Received: by 2002:a05:6102:3f4e:b0:4a5:ba70:1c6e with SMTP id ada2fe7eead31-4a751cf131amr7794004137.29.1729759431422;
        Thu, 24 Oct 2024 01:43:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHiPWrknWvL/ANNpfbc0GJfbqV2BdD/Y2S5/yeKMxfEgmbao0nwYIWy04QhKvvoS4AizptAw==
X-Received: by 2002:a05:6102:3f4e:b0:4a5:ba70:1c6e with SMTP id ada2fe7eead31-4a751cf131amr7793972137.29.1729759430966;
        Thu, 24 Oct 2024 01:43:50 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb043sm49052421cf.50.2024.10.24.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:43:50 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:43:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
References: <20241023210031.274017-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241023210031.274017-1-kshk@linux.ibm.com>

On Wed, Oct 23, 2024 at 04:00:31PM -0500, Konstantin Shkolnyy wrote:
>This happens on 64-bit big-endian machines.
>SO_RCVLOWAT requires an int parameter. However, instead of int, the test
>uses unsigned long in one place and size_t in another. Both are 8 bytes
>long on 64-bit machines. The kernel, having received the 8 bytes, doesn't
>test for the exact size of the parameter, it only cares that it's >=
>sizeof(int), and casts the 4 lower-addressed bytes to an int, which, on
>a big-endian machine, contains 0. 0 doesn't trigger an error, SO_RCVLOWAT
>returns with success and the socket stays with the default SO_RCVLOWAT = 1,
>which results in test failures.
>
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
>
>Notes:
>    The problem was found on s390 (big endian), while x86-64 didn't show it. After this fix, all tests pass on s390.

Thanks for the fix!

Other setsockopt() in the tests where we use unsigned long are
SO_VM_SOCKETS_* but they are expected to be unsigned, so we should be
fine.

Not for this patch, but do you think adding a getsockopt() for each
setsockopt in the test to check that kind of issue can help?

BTW, this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Not sure if we want this with net tree since are just tests,
in that case I think you should add:

Fixes: b1346338fbae ("vsock_test: POLLIN + SO_RCVLOWAT test")
Fixes: 542e893fbadc ("vsock/test: two tests to check credit update logic")

>
> tools/testing/vsock/vsock_test.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 8d38dbf8f41f..7fd25b814b4b 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -835,7 +835,7 @@ static void test_stream_poll_rcvlowat_server(const struct test_opts *opts)
>
> static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
> {
>-	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>+	int lowat_val = RCVLOWAT_BUF_SIZE;
> 	char buf[RCVLOWAT_BUF_SIZE];
> 	struct pollfd fds;
> 	short poll_flags;
>@@ -1357,7 +1357,7 @@ static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opt
> static void test_stream_credit_update_test(const struct test_opts *opts,
> 					   bool low_rx_bytes_test)
> {
>-	size_t recv_buf_size;
>+	int recv_buf_size;
> 	struct pollfd fds;
> 	size_t buf_size;
> 	void *buf;
>-- 
>2.34.1
>


