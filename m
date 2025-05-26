Return-Path: <netdev+bounces-193443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683A1AC40C2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23456177D0A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D020DD40;
	Mon, 26 May 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QErTu/nE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321D61FE470
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267773; cv=none; b=eupoisj2t4awjodk4qVv9c6Fqo7gPsLrRTKBGoV1expi1zkNhgoREjUk8f6o2uIXePQxAB3qUajGdfGvkkwGmqX/RtpLNHPbYRMSR8XBWSj5w6y0FTYncM02g3mz1l0Fey4OV+uxyNdbTD6WFDPsLlw10Gz2RvQZu8JTPbT01U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267773; c=relaxed/simple;
	bh=8/rgdMR7ZxeHT7lcm2WF5v/murhX9m6bqlwpbwbmYXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9mTsE6hASO9COSvXvAfaFjzTCQwDmvG6irgrbcGn5MEoSMHpBNASxeBnrMh7+qNZQldiSa4uuxiKfNnU392u1gig2jok0Uhon2zXbP7Xml6D1X9YmL9vmBJ2AOXMiBurZDdSKv12f883yMiRMwYoVTgWAf4mtHyPrYS9xNWj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QErTu/nE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748267770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHjg19p96sdYw4xDXVkvX1Jw1LT1R8JNp7/yMvD2jYc=;
	b=QErTu/nErBX7SpbQKWpeXEZSYSzZCck2dHSpWXJS2btkcnRE6NLd9/T+G2sx5KOa1uO4BV
	8njTgu9N+z5/9xJ+sHsKf2+j7u4oeoVtFkWNxqAXSC8H9Hs0w73pLt/vGrW7akmat+EUa/
	dY9g2N2ll/mi3yXnozj7htZWPHYcTRg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ar1eoRVZN3CP54t24oKQ8w-1; Mon, 26 May 2025 09:56:08 -0400
X-MC-Unique: ar1eoRVZN3CP54t24oKQ8w-1
X-Mimecast-MFC-AGG-ID: ar1eoRVZN3CP54t24oKQ8w_1748267768
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e7d971b6398so2143410276.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267768; x=1748872568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHjg19p96sdYw4xDXVkvX1Jw1LT1R8JNp7/yMvD2jYc=;
        b=e04exH8Oq03kq8w+v5+sv0NUGMS664Gu83Bb9/pMIDKp9+C0hbAOUIFaunGlmxpRnJ
         sUF3LFwAyY7it/f7sEIZX4ZrQiS5aKHjLSHP+73rUtz3pvHMQf5XG1QZxa8QNLyJnJYw
         ZDo2ePU5bnf7vUlvNXPeFQzqw5st4NsoQNDza4HP5X3agOdR0mV2SuE2F2/PqvrA9ZPd
         P5UjUybNeDxnVSeHdEZfXMzFAMcyOlDzNDLZuv8FfQ+MNd3yg+1TAOcabGNdddX42fC7
         qPtwPBoMi77pY7aea53RTkZjo+7RIzqZ9qViz8+bsupR/7cMniJ1plwdXWqEiw4MydQA
         Mz8g==
X-Forwarded-Encrypted: i=1; AJvYcCX0s05p13/gcawmazlR+OGVh4nQi5duDi8k56aoL8N91OqM8XAupvFAUg04jJetjFvHqoHh6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5Vt0vFjm0P3idW5JhQBMCHEmAhU6LFf5ADLkq9Qe7x4ma+8C
	+W4SWmnBiI1BSF60OEyHwPpjQSLh8tpNCQ2LhLPjgXYxpMCOR7J2R2mG5Ttz7jSAv9CXWbAdQuU
	Ia3aPtK0XqEPqMhVcVXd1907HQMbU88JeOFatxneNwxrPEx9yAZqu9KdmNIpuRgR4SE6sRFEFHD
	msnIoFNBAyd6TPoU7I5yxZqYO60GhyssX9
X-Gm-Gg: ASbGncs155/VRzjStiYagu+B+p+X4nO2KmAuTDGKvftEK7k+0JEYrDBtCCXNYl1O+Jy
	behUW3auUNMUaPfUHycZwoHDL+kwFjGKeyIdcTO8P+pDtFu0ZvazZa3S5EdvOKA1w3Kw=
X-Received: by 2002:a05:6902:726:b0:e7d:9926:8bfa with SMTP id 3f1490d57ef6-e7d992698bamr7492108276.40.1748267767947;
        Mon, 26 May 2025 06:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6/c9lr+TAbVpG6J4lomzrC+5Fqw+cD9liLOLTj4YHysZUc3zSZfIwwilBGPgcyufFRQ1Bu826/aDBdCJ/pfU=
X-Received: by 2002:a05:6902:726:b0:e7d:9926:8bfa with SMTP id
 3f1490d57ef6-e7d992698bamr7492081276.40.1748267767587; Mon, 26 May 2025
 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526134949.907948-1-kshk@linux.ibm.com>
In-Reply-To: <20250526134949.907948-1-kshk@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 26 May 2025 15:55:55 +0200
X-Gm-Features: AX0GCFu9lGy_XLKzXTOFqdveWLMPIwPqhG0BIVwB-1v6mcjATpC-MDj6A7atdG4
Message-ID: <CAGxU2F40O3xDSwA4m6r+O5bWoTJgRXqGfyMiLH_sMij+YmE5aw@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SOCK_STREAM
 SHUT_RD test
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 15:50, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> The test outputs:
> "SOCK_STREAM SHUT_RD...expected send(2) failure, got 1".
>
> It tests that shutdown(fd, SHUT_RD) on one side causes send() to fail on
> the other side. However, sometimes there is a delay in delivery of the
> SHUT_RD command, send() succeeds and the test fails, even though the
> command is properly delivered and send() starts failing several
> milliseconds later.
>
> The delay occurs in the kernel because the used buffer notification
> callback virtio_vsock_rx_done(), called upon receipt of the SHUT_RD
> command, doesn't immediately disable send(). It delegates that to
> a kernel thread (via vsock->rx_work). Sometimes that thread is delayed
> more than the test expects.
>
> Change the test to keep calling send() until it fails or a timeout occurs.
>
> Fixes: b698bd97c5711 ("test/vsock: shutdowned socket test")
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in v2:
>  - Move the new function to utils.c.

BTW I think I already fixed the same issue in this series:
https://lore.kernel.org/netdev/20250514141927.159456-1-sgarzare@redhat.com/

Can you check it?

Thanks,
Stefano

>
>  tools/testing/vsock/util.c       | 11 +++++++++++
>  tools/testing/vsock/util.h       |  1 +
>  tools/testing/vsock/vsock_test.c | 14 ++------------
>  3 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index de25892f865f..04ac88dc4d3a 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -798,3 +798,14 @@ void enable_so_zerocopy_check(int fd)
>         setsockopt_int_check(fd, SOL_SOCKET, SO_ZEROCOPY, 1,
>                              "setsockopt SO_ZEROCOPY");
>  }
> +
> +void vsock_test_for_send_failure(int fd, int send_flags)
> +{
> +       timeout_begin(TIMEOUT);
> +       while (true) {
> +               if (send(fd, "A", 1, send_flags) == -1)
> +                       return;
> +               timeout_check("expected send(2) failure");
> +       }
> +       timeout_end();
> +}
> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> index d1f765ce3eee..58c17cfb63d4 100644
> --- a/tools/testing/vsock/util.h
> +++ b/tools/testing/vsock/util.h
> @@ -79,4 +79,5 @@ void setsockopt_int_check(int fd, int level, int optname, int val,
>  void setsockopt_timeval_check(int fd, int level, int optname,
>                               struct timeval val, char const *errmsg);
>  void enable_so_zerocopy_check(int fd);
> +void vsock_test_for_send_failure(int fd, int send_flags);
>  #endif /* UTIL_H */
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 613551132a96..b68a85a6d929 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1060,15 +1060,9 @@ static void sigpipe(int signo)
>
>  static void test_stream_check_sigpipe(int fd)
>  {
> -       ssize_t res;
> -
>         have_sigpipe = 0;
>
> -       res = send(fd, "A", 1, 0);
> -       if (res != -1) {
> -               fprintf(stderr, "expected send(2) failure, got %zi\n", res);
> -               exit(EXIT_FAILURE);
> -       }
> +       vsock_test_for_send_failure(fd, 0);
>
>         if (!have_sigpipe) {
>                 fprintf(stderr, "SIGPIPE expected\n");
> @@ -1077,11 +1071,7 @@ static void test_stream_check_sigpipe(int fd)
>
>         have_sigpipe = 0;
>
> -       res = send(fd, "A", 1, MSG_NOSIGNAL);
> -       if (res != -1) {
> -               fprintf(stderr, "expected send(2) failure, got %zi\n", res);
> -               exit(EXIT_FAILURE);
> -       }
> +       vsock_test_for_send_failure(fd, MSG_NOSIGNAL);
>
>         if (have_sigpipe) {
>                 fprintf(stderr, "SIGPIPE not expected\n");
> --
> 2.34.1
>


