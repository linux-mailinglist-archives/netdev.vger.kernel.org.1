Return-Path: <netdev+bounces-190167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B502AB5671
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF9C7AFF8B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7012BCF7B;
	Tue, 13 May 2025 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1hdgbi4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9B2BCF71
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143990; cv=none; b=ovtPWV+ZQyeVv4C8n4WoPVlqNhjMBKa/ePlgz6ouwW6NwPCHJruN/gCNZ+bJjGss6NQiVhNPijMmVOHCvRqkFbiVZpAlnNIQ3VWv0Ah8IWBIRoHuonm80laWC/B9iQCsx1nn1U2rXIaUZiFFEDsS37hsq9aiiGvphBsvqQ7zhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143990; c=relaxed/simple;
	bh=0sH/Zz5U3ejyb7A/1UoukQjUMw+jDmh2HmotW9IgiF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk+43tU7b+0bUXEqKuxA+NeB7K9Ka0ETuU8FJ7sM6AmBpVGaN1n4zHJ9V+mtQkEahrdg2nwseRoovTDQb9qFYhIzwrkySU+Y10yvLmH/3t9XZS79QbBnRvAm5T3MAGppxuNrL+sdM9++afbRkY2p8fal3OOyBIUkZGD+3Y52qU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1hdgbi4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747143988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/70FQOGYyD+dIqipphYHr/s8Vpxiqi+lh5GlyAwZuY=;
	b=O1hdgbi4ME15sVRmbXx8j+7t8uexcFXQ0+RqIg7JYlz5vnVK6vgDg4j13lCbkfESI+fJ8E
	aikh5eXaY7XT4dFHT+iccKBuJ8iZu7afgv8uACLx1yryER2ILrIGLW2Qu/sinmZo/gacX2
	o4lUlfRby0X7o0bXqy/jFl2Njnpli9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-l6BKg5Q5PuOKCiZwgqPN4A-1; Tue, 13 May 2025 09:46:21 -0400
X-MC-Unique: l6BKg5Q5PuOKCiZwgqPN4A-1
X-Mimecast-MFC-AGG-ID: l6BKg5Q5PuOKCiZwgqPN4A_1747143981
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442d472cf84so26213035e9.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 06:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747143981; x=1747748781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/70FQOGYyD+dIqipphYHr/s8Vpxiqi+lh5GlyAwZuY=;
        b=Yov7EsIixjA5KtZ9a+vQhsSaXy2Uq88bgcNM1Zr2nYziLxVfIbzHIgs9hSljk8HKI5
         PSyCMaeopmsuZQZGcUZc/Quh5D81NJevsnNXoNm3SOF/Ls1XsTIhB1EG3+I6JKY9iePl
         26alPzp2JJ8dF2F45i+I1YqZy8vLg7lf562u+gi5+wcWi1LdkpapPtCa3M6/CafNE9xJ
         ndqo/czYcbVSGbPxNUuZGB5W9j4let95BLn47893uVeU50i+yratiELm/FgmOipy4cTg
         LJOIRndrjV0kBeFYoe2kOS6iUxTsff6lwyKhDrz3esi8OqdfjHSpNHH1G8p3ZbISG2K4
         faNg==
X-Gm-Message-State: AOJu0YzhIpwoB2AMtHewa1IUiYwU4oOYAMHjeJS1hKxb8J2e1lGthSI4
	9SEhgi7Cyprqe9YKX9pYY/kRV8+ghRNzYbvTVhyv/+IVtM2a9TZBGk35PIqE2DIZyfNarKf5xGP
	Wlfhbp4GaIS2gxXaNBIcwRiggXAsTMu1M7rpyp2B1MArHZYSs8W9LyQ==
X-Gm-Gg: ASbGncv+7xGAakDD4h6bpU5HZBpsHFCyuoFPZeRatZf+GOFRKqKxSGn0j/BmPQxDSfD
	FzchT35XQ+hVDLKvjX+B2AvocKByUb5NAU4meJKM1e/qI522kgwUrXKhJdwLAj8k/Iom2I0Hp0/
	LuyXkCe7j6IAVLMDZiXQiNSkP4aIQxMt3cHYUABRX9qrmmuIksWsRd5bumAGIj9ZDaxUuHGq4LV
	5DpNdBbRMBE+VBwJANzb0uwPDwllcPtWo7DIms++Sjusb0JGwARC2CADBwj1WgNFLgFmZl5ruFK
	jjZi3Qd/c7bi9sA=
X-Received: by 2002:a05:6000:2410:b0:3a0:b294:cce9 with SMTP id ffacd0b85a97d-3a1f643a796mr12918278f8f.23.1747143980614;
        Tue, 13 May 2025 06:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWY7T39rW0AdmPAPBxdBlGBZlPcJ8Npi8waB/6mxTKr0KbpuEtniEFJdEonFVvK7Xgsw8DFg==
X-Received: by 2002:a05:6000:2410:b0:3a0:b294:cce9 with SMTP id ffacd0b85a97d-3a1f643a796mr12918246f8f.23.1747143980005;
        Tue, 13 May 2025 06:46:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2af7sm16485601f8f.52.2025.05.13.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:46:19 -0700 (PDT)
Date: Tue, 13 May 2025 15:46:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] vsock/test: retry send() to avoid
 occasional failure in sigpipe test
Message-ID: <vheia3vqebshkzajzb6qhxppjvj7onvtjezw5pddfl6qqrnrma@h3dpvkla2pco>
References: <20250508142005.135857-1-sgarzare@redhat.com>
 <20250508142005.135857-2-sgarzare@redhat.com>
 <2c5581b9-c0a4-4620-ac82-0a98abfd4d0d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2c5581b9-c0a4-4620-ac82-0a98abfd4d0d@redhat.com>

On Tue, May 13, 2025 at 12:37:36PM +0200, Paolo Abeni wrote:
>On 5/8/25 4:20 PM, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When the other peer calls shutdown(SHUT_RD), there is a chance that
>> the send() call could occur before the message carrying the close
>> information arrives over the transport. In such cases, the send()
>> might still succeed. To avoid this race, let's retry the send() call
>> a few times, ensuring the test is more reliable.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index d0f6d253ac72..7de870dee1cf 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -1064,11 +1064,18 @@ static void test_stream_check_sigpipe(int fd)
>>
>>  	have_sigpipe = 0;
>>
>> -	res = send(fd, "A", 1, 0);
>> -	if (res != -1) {
>> -		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>> -		exit(EXIT_FAILURE);
>> -	}
>> +	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
>> +	 * the send() call could occur before the message carrying the close
>> +	 * information arrives over the transport. In such cases, the send()
>> +	 * might still succeed. To avoid this race, let's retry the send() call
>> +	 * a few times, ensuring the test is more reliable.
>> +	 */
>> +	timeout_begin(TIMEOUT);
>> +	do {
>> +		res = send(fd, "A", 1, 0);
>> +		timeout_check("send");
>> +	} while (res != -1);
>
>AFAICS the above could spin on send() for up to 10s, I would say
>considerably more than 'a few times' ;)
>
>In practice that could cause side effect on the timing of other
>concurrent tests (due to one CPU being 100% used for a while).
>
>What if the peer rcvbuf fills-up: will the send fail? That could cause
>false-negative.

Good point!

>
>I *think* it should be better to insert a short sleep in the loop.

Agree, I'll add.

Thanks,
Stefano


