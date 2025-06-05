Return-Path: <netdev+bounces-195220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C45BACEDF2
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 12:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE56F3AC3FD
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A73420C023;
	Thu,  5 Jun 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdy+9ROg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1F4A1A
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120382; cv=none; b=hhdQyB7sxIyeEap3rnx29PhXeKWv7v5TX/aFk4lM7MceN9Di3Xoe5pmftgNrjGJBlEWz7Yn3kOObKV8mCA1r+ZhD4ktNZpX3smTDi5i7IMo3BVxkqlyWqb29NLxtshOrkWtV9ZTPlYoq0Yagn3gyxqXLSTbjof/yS27g1IV9mV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120382; c=relaxed/simple;
	bh=dI6qpz2KIHyN65XCCBmaV4te4lobXPKhgB8Vm+iOVio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PL9oQVW1R+8Pf3FJAntSryAKBPS5iYTwaZOI30diX2nd8QRmRo944wg6YVs2aSsJCbkrMOCQd0OFoN+bX0iGOOZxixV1mInryj1FSxf8+7fNSYs5MK/+uHAmM+tGpVY8rqrWe5Go3G50HYYIyh5jW7Z+rxcQjw2wQXyXSsgH+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdy+9ROg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749120378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7H6zcBjzLakny0tH2Rd3mdTARviwtcKxD112Kp1NxU=;
	b=gdy+9ROg5xWRxVSU4HpEucYCPHgV6W9+w3pop+P27Ex+AaKm7sQnDG9KuqzDamzhnDuaNJ
	ao0z+kk/jqJU/xWhocilkcHmF4yyua9UdFERa0p4e5x2p4AzRzcEngj3wpzJEFszPnAG0J
	fn/dEHWuyzq2t6bQs5e68rx7PwU1VDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Q06Aul4eNjC9BFCoW0QUsw-1; Thu, 05 Jun 2025 06:46:17 -0400
X-MC-Unique: Q06Aul4eNjC9BFCoW0QUsw-1
X-Mimecast-MFC-AGG-ID: Q06Aul4eNjC9BFCoW0QUsw_1749120376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450787c8626so4496125e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 03:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120376; x=1749725176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7H6zcBjzLakny0tH2Rd3mdTARviwtcKxD112Kp1NxU=;
        b=Mb8LGqrQK82iaeD5Uz3gaOKzCb0PU7Emetu+PMBF9Xe4sc25xSxeAUvXxNXAQbgnyC
         fHNyJ7FRd0qRmhddsBRL3XhVJ5ZWZsyEHcc1GKr7vXyQlkHHuH8gHT9S/4GNZekeSEw/
         YkCKqYY1uEMywNnNNlailUnNHAdorZ/SDSp8rS4D8YcIL2ZgR1JdveIor1RS2tfz4A+l
         HsWSTalgIOkZ8KF4C4KoOZWfKR25cOUo1r1KfWWcAwgcvw2g0/Ez0cHTH3jpdO9ULfU3
         tDAfT0TOxm8TqwnK5aB9gzppE0FRBVCVETs2uEoI8C0yHMR2Vz5zO1Bl/Ap/y3UgYXly
         BaVA==
X-Forwarded-Encrypted: i=1; AJvYcCUSOlyDt12NeM7xtqJj3j467KMcKsUbh9HoIJXX9amK3ngD9Zcfrmk84fbXJq/y6+HIzOuG7vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWBmSVJHBZDdyCUXdFEKWqvKNOePu9f7bKnBNer+ur7E1e9Ie
	VLIoYcn0OwRfKzwfGtwEPWOehHKe3OVLIBZ0BB92XF0ZD+nh5ntoNOExwwVIkUFe5qnySgUmpHN
	nyh1b9u5UIaxsxWLUN27ATlfD2wME6xHLqPqSa1wxuWZcc7jdTieWuQLX8w==
X-Gm-Gg: ASbGncsAyTMtiSXvACEnAf8AKvrxFI0PJ7UUrym0y9AW5qUAHcgtQY506drYJJ86pA+
	C7bp9y8mAQcIToJmAF/BM/eeyamGNNEssJ00UdUKgWi8SyGPEyEHGWqW7ZtaaXycJ4NafdJQ8fY
	TAN5s+G8E1yuY6yQU3EGN5I26M4C5VUC8NBIhvK9iJWJp9YEIOb5PsishLbLCtAnZktv6xijog3
	OZLxdpcXR7xaJr+WIFotqYCitsFO11PK5HfgEecNXkjsPJ2lzKEelry1zDzNwXi/f7/XRWKSMe6
	GKYRO9ivCKuoTd4Tnz/Gs0FB6aTJ+G6LsITQEQhaxl8wfdd0iWw=
X-Received: by 2002:a05:600c:1c0b:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-451f0a5fe1amr55551695e9.1.1749120376059;
        Thu, 05 Jun 2025 03:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeoslgFEZ3R+4NzXqejnaWsWrMqOsjz76qooQAktoxBM6xArUOr3h1Npds2aEkO46Z515I4A==
X-Received: by 2002:a05:600c:1c0b:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-451f0a5fe1amr55551375e9.1.1749120375423;
        Thu, 05 Jun 2025 03:46:15 -0700 (PDT)
Received: from sgarzare-redhat (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178895sm14743285e9.14.2025.06.05.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:46:14 -0700 (PDT)
Date: Thu, 5 Jun 2025 12:46:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/3] vsock/test: Introduce
 get_transports()
Message-ID: <hxnugz3xrrn3ze2arcvjumvjqekvjfsrvd32wi7e3zgdagdaqb@cm3y6fipqdf3>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
 <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
 <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b4f3bc0d-9ff5-4271-be28-bbace27927bd@rbox.co>

On Wed, Jun 04, 2025 at 09:10:19PM +0200, Michal Luczaj wrote:
>On 6/4/25 11:07, Stefano Garzarella wrote:
>> On Wed, May 28, 2025 at 10:44:42PM +0200, Michal Luczaj wrote:
>>> +static int __get_transports(void)
>>> +{
>>> +	/* Order must match transports defined in util.h.
>>> +	 * man nm: "d" The symbol is in the initialized data section.
>>> +	 */
>>> +	const char * const syms[] = {
>>> +		"d loopback_transport",
>>> +		"d virtio_transport",
>>> +		"d vhost_transport",
>>> +		"d vmci_transport",
>>> +		"d hvs_transport",
>>> +	};
>>
>> I would move this array (or a macro that define it), near the transport
>> defined in util.h, so they are near and we can easily update/review
>> changes.
>>
>> BTW what about adding static asserts to check we are aligned?
>
>Something like
>
>#define KNOWN_TRANSPORTS	\

What about KNOWN_TRANSPORTS(_) ?

>	_(LOOPBACK, "loopback")	\
>	_(VIRTIO, "virtio")	\
>	_(VHOST, "vhost")	\
>	_(VMCI, "vmci")		\
>	_(HYPERV, "hvs")
>
>enum transport {
>	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
>	#define _(name, symbol)	\
>		TRANSPORT_##name = _BITUL(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>	KNOWN_TRANSPORTS
>	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
>	#undef _
>};
>
>static char * const transport_ksyms[] = {
>	#define _(name, symbol) "d " symbol "_transport",
>	KNOWN_TRANSPORTS
>	#undef _
>};
>
>static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
>
>?

Yep, this is even better, thanks :-)

>
>Note that I keep pushing for naming HVS a TRANSPORT_HYPERV. Perhaps it's
>better to stick to TRANSPORT_HVS after all?

I would have used HYPERV too, but honestly I don't have a strong 
opinion, so take your choice.

Thanks,
Stefano

>
>>> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>>> index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..63953e32c3e18e1aa5c2addcf6f09f433660fa84 100644
>>> --- a/tools/testing/vsock/util.h
>>> +++ b/tools/testing/vsock/util.h
>>> @@ -3,8 +3,19 @@
>>> #define UTIL_H
>>>
>>> #include <sys/socket.h>
>>> +#include <linux/bitops.h>
>>> #include <linux/vm_sockets.h>
>>>
>>> +#define KALLSYMS_PATH		"/proc/kallsyms"
>>> +#define KALLSYMS_LINE_LEN	512
>>
>> We don't need to expose them in util.h IMO, we can keep in util.c
>
>OK, sure.
>
>Thanks,
>Michal
>


