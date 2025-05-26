Return-Path: <netdev+bounces-193375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6CAC3AF7
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B212172B00
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE51E00A0;
	Mon, 26 May 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwnWzcb0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9E1876
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748246115; cv=none; b=cU0BvlccMA5y0c8yJ505q5Gl/gXmXQn6b+eZrLdkoWS/bBV9AsclvWGzl1RPHXBc+473R5a/DZhmEqJt0wNCtDgiwnOpzUjagC6cl3P9d2uKsxIRsZawK5WvJKu+zkicqL8jPdVWHZGn4fwfhLCW3UaGTlZj/IFDADdZLS+sXo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748246115; c=relaxed/simple;
	bh=ICHW/uN1OvSvaGQ7jIZodYWZnLa0EL03cumMRfWphYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0Psf2uirLpXR0UgMP0wio7TsGfibreKs6k/OkrkW64tgypOtnLC5lvhpV/nLTo86Xh9Ewk4UL0fyrj8vO1Are1QnqU4pv305QPZG0/5pNKXCO22mnFR2Xe3KgZB5+4VpweCNZzGTWa78tRRECAECwxh2njzsRzKJCb7xMxQaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SwnWzcb0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748246112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr52sKmwroB97DOF/8SzXO2IZSVBxqAkPJsvVxhDFw0=;
	b=SwnWzcb0fGk+azcfRqHwfJROK2gVziSh4Yc+6tY4qSMTizWWE1kXOkt9XGPzFFiEbxJXsm
	mWyHq7nRTqrf1jAsCrzLqZMCpkAoOzmdzppcj0OrJzw20PUbu4UiShofeZ5MEoa1WTGYRX
	ptL6odz/oZOMbBq0f1hcZNnpUNohxX4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-TZRfCm08MvShes6o4XT8qA-1; Mon, 26 May 2025 03:54:09 -0400
X-MC-Unique: TZRfCm08MvShes6o4XT8qA-1
X-Mimecast-MFC-AGG-ID: TZRfCm08MvShes6o4XT8qA_1748246048
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acf16746a74so139249566b.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 00:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748246048; x=1748850848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr52sKmwroB97DOF/8SzXO2IZSVBxqAkPJsvVxhDFw0=;
        b=HHQiPY/UwiDcW6PU1mvdOjM2+VW+Tb5gkQ77OpAozCWej9EQ/gcyJb/fW0VaGnZKHU
         GZxIS35PPybIndgjAIQPFmFxcO0tV9aJSTCtrhvc855yxpibRcxTDx/wv7LUiKm8cP2s
         LCHCTBE7B4zzOxYgAoC9z9jaMqNYwFcnRY/+h0b3P02VaGS1vb+JQJjOkFm9eCqbFwZ0
         IybMIyjjyL6xIWg0SbOu2O/vgLoBcvaWtH4+1Z3h2tU+54SkHQEf9n/cug071IHJ4QrO
         R88ExplT/Jcp1tZkuH6/QkJjO7YBPAxnF906LXed+cUpUcAE0YJT0aDJNE1KozaITLEU
         ey+A==
X-Forwarded-Encrypted: i=1; AJvYcCV9Q8kZtssEHOOmaRO1QBmJ0xYPSivL55MXt/UshPoItyptV/5hp2gx4t4FTlZS0fGL0IyXk2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bHBVOYFrszeCnRQ3T7Z+9Ukvf3HIQkApHzDVGN/sq0xwpgPN
	PiCPpAyx5XOWKRzaAiuiOPyBgjLGUeexBeB7cnXeSg2331EdVVD7hzU3xkAMJ21IvYgGgGPlJvW
	dbMPAmUydm7rK/yOxqDELSTDVSX1bSyOFGIbYqTovKN9yqMFtqh6Kgzw+uVoG9wOrgQ==
X-Gm-Gg: ASbGncshSxKFnG3AADlI48H0vFrQf7IkxcW0pGpgEys5LtovjQiQ2u3WjqOZUTTRhja
	RklMg6S/VPTLtJkhO3OxE7p3xeMHyJoA4boU7tiJ7caHONo6prt3ZSj1gnGjF0nBZrza+z1kHrj
	pIbZhnBNkKz6BPLWJZz22XY+L8QAaMl/Wo5AA6TrTfpH3gVXJ+n2V6bOXt1mx7WLDbPYBZmyof/
	0HXeUsWztJqYKbLPHqfcuAr/XLVCBxwrMzKCSQYcVs/yzoTQMiF6tRyNXzvOo8wefvJ00z8QV5T
	HNJBRTack54LQpMGylY92IvNzn8ctzBMVURhgXcjIHR/FagBOEmEk0yrDynq
X-Received: by 2002:a17:906:dc89:b0:ad2:4e96:ee11 with SMTP id a640c23a62f3a-ad85b03b73dmr652294566b.8.1748246048092;
        Mon, 26 May 2025 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXDorcGibcC8mJCNU0lHQiUbuXJHSvC/4551ubBzHRPqBuymTAUbX8ir3OqGUx+Fn5tp1GUA==
X-Received: by 2002:a17:906:dc89:b0:ad2:4e96:ee11 with SMTP id a640c23a62f3a-ad85b03b73dmr652292866b.8.1748246047597;
        Mon, 26 May 2025 00:54:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4e8afdsm1652640066b.176.2025.05.26.00.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 00:54:07 -0700 (PDT)
Date: Mon, 26 May 2025 09:54:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH net] vsock/test: Fix occasional failure in SOCK_STREAM
 SHUT_RD test
Message-ID: <2y6v7vog4dylnnu7j625gkijth7lnznvgcjl4kg2q3xy5ht6fe@uikdt45mmocp>
References: <20250526043220.897565-1-kshk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250526043220.897565-1-kshk@linux.ibm.com>

On Sun, May 25, 2025 at 11:32:20PM -0500, Konstantin Shkolnyy wrote:
>The test outputs:
>"SOCK_STREAM SHUT_RD...expected send(2) failure, got 1".
>
>It tests that shutdown(fd, SHUT_RD) on one side causes send() to fail on
>the other side. However, sometimes there is a delay in delivery of the
>SHUT_RD command, send() succeeds and the test fails, even though the
>command is properly delivered and send() starts failing several
>milliseconds later.
>
>The delay occurs in the kernel because the used buffer notification
>callback virtio_vsock_rx_done(), called upon receipt of the SHUT_RD
>command, doesn't immediately disable send(). It delegates that to
>a kernel thread (via vsock->rx_work). Sometimes that thread is delayed
>more than the test expects.
>
>Change the test to keep calling send() until it fails or a timeout occurs.
>
>Fixes: b698bd97c5711 ("test/vsock: shutdowned socket test")
>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>---
> tools/testing/vsock/vsock_test.c | 25 +++++++++++++------------
> 1 file changed, 13 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 613551132a96..c3b90a94a281 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1058,17 +1058,22 @@ static void sigpipe(int signo)
> 	have_sigpipe = 1;
> }
>
>-static void test_stream_check_sigpipe(int fd)
>+static void test_for_send_failure(int fd, int send_flags)
> {
>-	ssize_t res;
>+	timeout_begin(TIMEOUT);
>+	while (true) {
>+		if (send(fd, "A", 1, send_flags) == -1)
>+			return;
>+		timeout_check("expected send(2) failure");
>+	}
>+	timeout_end();
>+}

I'd move this in util.c like we did in 
https://lore.kernel.org/virtualization/20250522-vsock-linger-v6-3-2ad00b0e447e@rbox.co/

And I'd rename following the other functions we have there.

Thanks,
Stefano

>
>+static void test_stream_check_sigpipe(int fd)
>+{
> 	have_sigpipe = 0;
>
>-	res = send(fd, "A", 1, 0);
>-	if (res != -1) {
>-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>-		exit(EXIT_FAILURE);
>-	}
>+	test_for_send_failure(fd, 0);
>
> 	if (!have_sigpipe) {
> 		fprintf(stderr, "SIGPIPE expected\n");
>@@ -1077,11 +1082,7 @@ static void test_stream_check_sigpipe(int fd)
>
> 	have_sigpipe = 0;
>
>-	res = send(fd, "A", 1, MSG_NOSIGNAL);
>-	if (res != -1) {
>-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>-		exit(EXIT_FAILURE);
>-	}
>+	test_for_send_failure(fd, MSG_NOSIGNAL);
>
> 	if (have_sigpipe) {
> 		fprintf(stderr, "SIGPIPE not expected\n");
>-- 
>2.34.1
>


