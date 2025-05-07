Return-Path: <netdev+bounces-188714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FAAAE51E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4BC9886B9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9828B40B;
	Wed,  7 May 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCbUFM7B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CF28B3FE
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632530; cv=none; b=nG0np9v76b1gWm7AOiq6aLaJ9q37TYK35kCCI4uamDCKgZd6GjO0ulL8IrbLnavylMkQXu/HbkZdWsnh7pK9gAMWq/d1uJmEZwgCiTsuEmzSBaeZUj9nVaEhHTSZWFIfCLMgoGLKl5rUw4HLJbKzqN8IbUJGJ52lvrRzzv6u6CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632530; c=relaxed/simple;
	bh=kNco2fCmuCqlZLOuCofYzSrVlJqJQWrGuA4zIfOv1wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFhhXckp/DGUyVqNfPnfk0YmTRnKqZk4KTX+pZEuVpW+yMmKgHLpvyM1UN6OLTrG6HUVFkEyFtf4x/AXJw/2XFiXU5QE14b+r3sTQtdNctQqg3WG9D/K9ROGM4U/MJOksbeL0/1KH3xign4JcgOygSnWv5bkKfhe3L9h8JgFVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCbUFM7B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746632527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lio/+Ao1S9W+X9/4Leo17kpbIzqZzZSZhwzb8sw/wo=;
	b=ZCbUFM7BUiI9dAfcbh+RK/Le+9z3iXKXtSxHSgZImUuX7XoYPwkCSfOhUSHP1zuExq6th+
	CaynI8NOA3wxaaFHohhiPJI0tHWPLpibFqjYBk849lzAtK/IbXOVNcLFWSp5oNyFoN7YCd
	Y4A9KlLSNYEwTu4V0fcRK6zpgfFavLQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-1eK-9TwLPSKAVwjeB1L8SQ-1; Wed, 07 May 2025 11:42:06 -0400
X-MC-Unique: 1eK-9TwLPSKAVwjeB1L8SQ-1
X-Mimecast-MFC-AGG-ID: 1eK-9TwLPSKAVwjeB1L8SQ_1746632526
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-708aca58513so92637867b3.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632526; x=1747237326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lio/+Ao1S9W+X9/4Leo17kpbIzqZzZSZhwzb8sw/wo=;
        b=hjHnEvK1pfnxP9wWOYjVoh0SMvvtczOMjCWGnR62WU999VM/5iSaMrmMWRVYSpTMdb
         uEe5JiNhpzxEGwJtso5CLM3MUJYU8llFvqkJgCQnMeLQMaoMqI93oCZRToVvncfl+xEq
         xr2tpU8u50OfvJ0OBKWQfW6pJnEtvsFgYmOBul0mWUo698T84Pe+wh8F3FNk4bXajocr
         Bm6kEUIKw3d/oHEbLVtdbVa/VVMjYm+L5aQuIWKFzykOlXU/bF4eI1PQ6rKM+rVDaNOT
         XBBMd3afwkaCqxSiML6QfUWMPmt2YTV7rWr79mytAgcnE88v0w9f9wngZWbHtXAwn0+f
         hUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWXZ0WmSbnOQP2GYQFOUWD1zmm+LRhMGvI1JNPTZmUvc57Oe/xcbGrRyzTlqAZ0gX+qaJr7/0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Jk24tjG6C21ZGZrQSQTgVZ/ZUrC3ZTRenukdPWpW2cdzn6KR
	wIosMtJ/uKIZaheOzg75w39oFgaToH8KKec9nNwUwx0nl8S1N3kWdzJQJNuZHj5Y+zZX+K1PAWG
	fdn0PWZJocmDTzvvvC+5Y0Opu+PAhnzFi1JUe84BPKMnLAHIjuI8Q43XR3lxrX70Npbz5vExkU0
	9DmOHqf5upF95K9PO54SMEy8iJcqG/KXXongWE
X-Gm-Gg: ASbGnctDgYu16XzGtrOxiBNiNqw7fqLsciMLQIiKK+782m2dGPRdE8o6Uf/mcoWCDzM
	mBYPsDtcD8j+wTSveYLY58AqcV7f5Aem3LY3uVQPv0SFvwZb3K1wx5FfFn+C6SMUx90KesQ==
X-Received: by 2002:a05:690c:7204:b0:703:d0b5:7abc with SMTP id 00721157ae682-70a1d9f796amr52747627b3.9.1746632525932;
        Wed, 07 May 2025 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8lPZotZaA5SL3FWz6OPzfNFbWEJ+cXzbhHRMG1e8KklFqxYBqaKjznxq7FTFilMNXTgNWtfPjnZtzwsZAvl4=
X-Received: by 2002:a05:690c:7204:b0:703:d0b5:7abc with SMTP id
 00721157ae682-70a1d9f796amr52747237b3.9.1746632525562; Wed, 07 May 2025
 08:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
In-Reply-To: <20250507151456.2577061-1-kshk@linux.ibm.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 7 May 2025 17:41:54 +0200
X-Gm-Features: ATxdqUEJ8STQu0YGygVRKeGWq1W_9YLNgZZxTRzXDHhASTqBwvXiIOk6Dpf4Fis
Message-ID: <CAGxU2F6ssoadHjCH9qi6HdaproC3rH=d-CdYh2mvK+_X4-C4nw@mail.gmail.com>
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ tests
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 17:15, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>
> These tests:
>     "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>     "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>
> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
> have been received by the other side. However, sometimes there is a delay
> in updating this "unsent bytes" counter, and the test fails even though
> the counter properly goes to 0 several milliseconds later.
>
> The delay occurs in the kernel because the used buffer notification
> callback virtio_vsock_tx_done(), called upon receipt of the data by the
> other side, doesn't update the counter itself. It delegates that to
> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
> more than the test expects.
>
> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
> Changes in v2:
>  - Use timeout_check() to end polling, instead of counting iterations.

Why removing the sleep?

Thanks,
Stefano

>
>  tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index d0f6d253ac72..613551132a96 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1264,21 +1264,25 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
>         send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>         control_expectln("RECEIVED");
>
> -       ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> -       if (ret < 0) {
> -               if (errno == EOPNOTSUPP) {
> -                       fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
> -               } else {
> +       /* SIOCOUTQ isn't guaranteed to instantly track sent data. Even though
> +        * the "RECEIVED" message means that the other side has received the
> +        * data, there can be a delay in our kernel before updating the "unsent
> +        * bytes" counter. Repeat SIOCOUTQ until it returns 0.
> +        */
> +       timeout_begin(TIMEOUT);
> +       do {
> +               ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
> +               if (ret < 0) {
> +                       if (errno == EOPNOTSUPP) {
> +                               fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
> +                               break;
> +                       }
>                         perror("ioctl");
>                         exit(EXIT_FAILURE);
>                 }
> -       } else if (ret == 0 && sock_bytes_unsent != 0) {
> -               fprintf(stderr,
> -                       "Unexpected 'SIOCOUTQ' value, expected 0, got %i\n",
> -                       sock_bytes_unsent);
> -               exit(EXIT_FAILURE);
> -       }
> -
> +               timeout_check("SIOCOUTQ");
> +       } while (sock_bytes_unsent != 0);
> +       timeout_end();
>         close(fd);
>  }
>
> --
> 2.34.1
>


