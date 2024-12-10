Return-Path: <netdev+bounces-150746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4DA9EB647
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F23D165866
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBB207DE4;
	Tue, 10 Dec 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRSQy/EM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5D1F2385
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847959; cv=none; b=APcCp24V4ZSn9AUYVLzY2AvRdcbe/yRSoSw4OTIvTT7Jw7W58EPjmwB+COP2kFTc0hriPbBfKZXlGkI13HhZCHINJKoyPM1QUu8DRZxEwXZMI83xP7DI9CaVfGadlC/Fvw7J4VHShShLa7UX+feKWJDCcDOy6tcOhe7v+HlQ8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847959; c=relaxed/simple;
	bh=rsGi+233XdfkbvdLRb982obVXZtqHqHcvkwQlMBGCog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0IupC9BYf+vUdQ3cqIxJiQa9YTd0e7lvlvDbtDzhNdrq56hz6vpt0WqhOGftSlAAi5iSn7ZKRn0JnSD2mIlk+yJL3YvbOzTlJdmd8k5+kxu0xSrc37mLE4oDju3mhuHzKzC0l6LLOFpnW86eUHEcRW/9hIScHzKBiHPWc95LeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRSQy/EM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733847956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNgpTci+3ySJROriztVOC/ztCjjdpwqE655ZgwtCI0c=;
	b=iRSQy/EM4eL7D8ruFWH4q7ATbRx7EETIhqpPxyrzGK7GqqGcbjW3juchEnZbbZ+e9FMj00
	B3d9QuZL5f72Cn8yQk0QtA8Y9nZ4IUz3o349+EJRLYgUYKUHt9UCdihKMLl90zrfdu/+oz
	7gR5jmZXAZWlDZXr2eL/BSLlxseUiE0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-vk6ujlkjMdGzlxCGe1mKXA-1; Tue, 10 Dec 2024 11:25:55 -0500
X-MC-Unique: vk6ujlkjMdGzlxCGe1mKXA-1
X-Mimecast-MFC-AGG-ID: vk6ujlkjMdGzlxCGe1mKXA
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e6cf6742so129754185a.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:25:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733847954; x=1734452754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNgpTci+3ySJROriztVOC/ztCjjdpwqE655ZgwtCI0c=;
        b=ioS5R0WTF44FwkPErGrNfwVDe68KU4k58Jir7kJ32XGUedd9IJkLB2LNubJGAY0r7c
         SOvy7ItwTAWctpEjNqnzsjbwgQh1/chsyQ6DsimxSumOzxJwX44sXpA79R8dYStxjpmM
         kCkTIQsIJFAaw+/BjCj0Gczfp4nRmFVelYINIy4c6oMtMiu9zf2GfMSE6+X5n1DEmSt8
         UXkD3WUaV6S2ekTRNB1Ki7pek6izupEfHe5CszO+3sPJY8E6GccJrCbLB+SqhLXQzGro
         zYCs8or1g49G1d3ihhrxfSIj0kBtkmC6HMgltepq5H5th4oOW6HDAzeNqgtNxf9lbiVS
         cRQA==
X-Gm-Message-State: AOJu0YyprgPcWjfKbqNv5sVvTSUFPX9LudRVc7noXcLnbRhni9o/bY4k
	8aVH1hlNf+KwzWby6i8Z+/3ZPAk0eomJa/seenJ/BcggoHIqHrDeiYrjAOXUHqDT2NyaYxq/7BC
	+bYCLaRmkerkxnJTpeVlE14W66AY702Wiad4DxjPccV8yGTiXDZjRuFw0j/CENg==
X-Gm-Gg: ASbGncu5lPx+kwq5H2NT0mj7rtqYB+y2tx1Eg7/xjvzQxBCzFxlh6ilk7Aqby84lgCr
	iUKJhcTCx3e/qOnSCNaKHge5VFc1YGWDhr1M++17S9OA4/EDFqHClrHorVRRdIjRltZJscSEXKc
	Iu7m01e4BjV2a7EgQ6AdkxYPPS7cV2qzc71JOfQc8a3z21SqIniPHnBgSTw3Vpc7M0RcIB7FKq2
	UhVH+zaPIajxBURFd0pVTmgiSSkkqrfQTxpeTRCI6/wz7rdaYhitqt8mcC7D8VgRjt64zQtkHlu
	97CJQ+hcZEc2Rw0yljR7/lo6qS9QHg==
X-Received: by 2002:a05:620a:8904:b0:7b1:4e01:547c with SMTP id af79cd13be357-7b6dce5d359mr782492285a.27.1733847954237;
        Tue, 10 Dec 2024 08:25:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8CnWvwfI+O1UBFZtL6u75uiM4VJh/vchjZqPfz9mgw6se83Ieke20R1DwxVI5HeTn8M4qpQ==
X-Received: by 2002:a05:620a:8904:b0:7b1:4e01:547c with SMTP id af79cd13be357-7b6dce5d359mr782488885a.27.1733847953903;
        Tue, 10 Dec 2024 08:25:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6deb2eb18sm91692085a.39.2024.12.10.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:25:53 -0800 (PST)
Date: Tue, 10 Dec 2024 17:25:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] vsock/test: Tests for memory leaks
Message-ID: <gm7qmwewqroqjyengpluw5xdr2mkv5u4fgjrwvly24pc5k2fl7@qelrw3hzq33h>
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>

Hi Michal,

On Fri, Dec 06, 2024 at 07:34:50PM +0100, Michal Luczaj wrote:
>Series adds tests for recently fixed memory leaks[1]:
>
>d7b0ff5a8667 ("virtio/vsock: Fix accept_queue memory leak")
>fbf7085b3ad1 ("vsock: Fix sk_error_queue memory leak")
>60cf6206a1f5 ("virtio/vsock: Improve MSG_ZEROCOPY error handling")

Great! Thanks for these new tests!

>
>First patch is a non-functional preparatory cleanup.
>
>I initially considered triggering (and parsing) a kmemleak scan after each
>test, but ultimately concluded that the slowdown and the required
>privileges would be too much.

Yeah, what about adding something in the README to suggest using
kmemleak and how to check that everything is okay after a run?

I'd suggest also to add something about that in each patch that
introduce tests where we expects the user to check kmemleak,
at least with a comment on top of the test functions, and maybe
also in the commit description.

WDYT?

I left some comments and reported an issue with the last tests.

Thanks,
Stefano

>
>[1]: https://lore.kernel.org/netdev/20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co/
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Michal Luczaj (4):
>      vsock/test: Use NSEC_PER_SEC
>      vsock/test: Add test for accept_queue memory leak
>      vsock/test: Add test for sk_error_queue memory leak
>      vsock/test: Add test for MSG_ZEROCOPY completion memory leak
>
> tools/testing/vsock/vsock_test.c | 159 ++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 157 insertions(+), 2 deletions(-)
>---
>base-commit: 51db5c8943001186be0b5b02456e7d03b3be1f12
>change-id: 20241203-test-vsock-leaks-38f9559f5636
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


