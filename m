Return-Path: <netdev+bounces-134114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1599980F4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B5F281407
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113651C9B65;
	Thu, 10 Oct 2024 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ER3kuKxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45C1BD018
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549881; cv=none; b=RwaZddkg+GBAoZYML/zt6uGtA9zTJxy5up3Eww8RcuLaNPH2fLrBPrrw5eBiVMj56/VHQRVswYlZpf7761zeETG8qrJDuWoYtwwf6BX9zxm1SuT2s+MYFQWRNG/W6QXlL/mCdMwpOj3yAHhfzabb6sJK9JQHq2oKmVfwI9Bp6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549881; c=relaxed/simple;
	bh=tiNKt4uEnzIIQUhGxjv1AJIIxBHCpHqZ7kY8G1BxA78=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b6qqqVQa9f8GrM6J3fEPa5ZlHkoqK8S9CqCzL6D1RO2+08mnmAryRM3vO3j8hIUNCnaJ43uk6EMsKTRQJG5jcsNARD5F8GyGeafz71qYxv4ABeJSWwVDb44Uk/muFgaG2n46XTz5bDTJBgcTiqOPjSpDxiw65TEPwf4V2lx5eH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ER3kuKxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728549878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwjJ3rOfKTeE9Owm5oZtqgnJumv4mefikcU3iXTP41o=;
	b=ER3kuKxV8WOFZMZyqu/8j5PYmoFaKJue5Z+PLrYT6c8dzuaSmGzVK6/G0dQRc4AIlFeOFg
	sb+UVdPp3krDqr5UWMJ+xQuSSNTDszm2aDSBXBOZyoN3VBf3F8PQBjSZpS6bAf9WS88Rjb
	kMDWmTw8NHYp84Tr+b2ev6eXSRLG5zU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-ctOa5m6tNIq1pcHYjeIRPg-1; Thu, 10 Oct 2024 04:44:36 -0400
X-MC-Unique: ctOa5m6tNIq1pcHYjeIRPg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2fac931e7c6so4887741fa.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 01:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549875; x=1729154675;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwjJ3rOfKTeE9Owm5oZtqgnJumv4mefikcU3iXTP41o=;
        b=mWQUOF3nigr6/C7NYUturOqycsiGJNc9bpw/k6PlGlxWVdQ5WuCoRy/+Z60PJHDabW
         HtWpXJd8f2yyXZuCezXh+sB9WQsILB3Sw+v7t7Uq3QSjZVGaleA054HSBjg4jUGOHETZ
         XDMTlECFQIx5XBWo+AzF8NeiI2c5y3iGmGpVAzzx6JFzm8rh9s3MCvlOI5fohgTVICRS
         PoApslag2rR2xyokCWrojROW6B00kNhxwf6X1oDG7Xu2NMp5F71fNZaqOyJK2Ngw3cdu
         AOmJ+2M8QqNy8LdSrWlxiub52wvZLPAYqQdqZj6yNNYvEmiYYI6puAhCBHTFZziVe9Lx
         ZFMg==
X-Forwarded-Encrypted: i=1; AJvYcCUZVMVhBOWNu8/exVwvVuQQEBpsgWW/TfM7+KyK1OmCJhORP/36IK3NCb/w/mr6JOOCxfqj010=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNnyPc3J76XSs+XoRDDR84O3Y0EnG7EYMldcwJ4eEVhgqKPcgb
	nGJF6taQpcKoyafeZ4nXhpfa+zHTKnrUuqS3ABlRFU31Ks//MY7/H2R4XTVdjfftpZrqt0DFg41
	o1Lgmonc7HGv8DQbrcwJ+Cdvx9vfZxBRC/uIMJxbdgD7w+1rSJFO8vg==
X-Received: by 2002:a05:651c:154a:b0:2fa:cf82:a1b2 with SMTP id 38308e7fff4ca-2fb187ac586mr36261501fa.31.1728549875182;
        Thu, 10 Oct 2024 01:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuSNyfEREq01qHawidf0JzClj+W8bfm0PNlrHJXvmvs1NiA3EWt9EKpLMmwpk59pMFiMlCvA==
X-Received: by 2002:a05:651c:154a:b0:2fa:cf82:a1b2 with SMTP id 38308e7fff4ca-2fb187ac586mr36261251fa.31.1728549874733;
        Thu, 10 Oct 2024 01:44:34 -0700 (PDT)
Received: from [192.168.88.248] (146-241-27-157.dyn.eolo.it. [146.241.27.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fd43sm855544f8f.89.2024.10.10.01.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:44:34 -0700 (PDT)
Message-ID: <9b36bb45-a31c-4cf7-a6af-cd77cc55e011@redhat.com>
Date: Thu, 10 Oct 2024 10:44:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] mlx4: update mlx4_clock_read() to provide
 pre/post tstamps
From: Paolo Abeni <pabeni@redhat.com>
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Mahesh Bandewar <mahesh@bandewar.net>
References: <20241008104646.3276302-1-maheshb@google.com>
 <749706b1-f44a-4548-9573-5f7b3823be67@redhat.com>
Content-Language: en-US
In-Reply-To: <749706b1-f44a-4548-9573-5f7b3823be67@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/24 10:36, Paolo Abeni wrote:
> On 10/8/24 12:46, Mahesh Bandewar wrote:
>> The mlx4_clock_read() function, when called by cycle_counter->read(),
>> previously only returned the raw cycle count. However, for PTP helpers
>> like gettimex64(), which require pre- and post-timestamps, simply
>> returning raw cycles is insufficient. It also needs to provide the
>> necessary timestamps.
>>
>> This update modifies mlx4_clock_read() to return both the cycles and
>> the required timestamps. Additionally, mlx4_en_read_clock() is now
>> responsible for reading and updating the clock_cache. This allows
>> another function, mlx4_en_read_clock_cache(), to act as the cycle
>> reader for cycle_counter->read(), preserving the same interface.
> 
> It looks like this patch should be split in two, the first one could be
> possibly 'net' material and just fix gettimex64()/mlx4_read_clock() and
> the other one introduces the cache.

My bad, I was too hasty and actually missed that the gettimex64() 
callback is implemented in the next patch.

The main point still remains: the cache infra should be in a separate 
patch: it can introduce side effects and we want to be able to bisect.

Thanks,

Paolo


