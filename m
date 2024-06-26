Return-Path: <netdev+bounces-106704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F6291752B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA2B21E50
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BFECF;
	Wed, 26 Jun 2024 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="egBk8h7K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52F28E8
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360637; cv=none; b=dJTYr0oxdxbtgzIdQmgjgpFjkqfCmxW+cjjH5zsLWtfKSDP59Ar0SougJFwPxxgiRZjbsbWEkQYnIy8KJTw0X8AlPRQY8QcO1AaTV1xMv2gpbiz+NjDIk5SmvPTQFyQ2m0OVpiFTL7Iv26hPbljDX4bxdWBFsyJ84rls+h42YaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360637; c=relaxed/simple;
	bh=SGvGabmaveZ3MHw011qISpuUIQ+ktDzSSdb8j/fdVaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElaWMER+uPPuyO6tFsEKZLBjlMJBP/L2SmIoN80zOfZGpOPEzJw0UkgK+YEHkIifXqfpK1KqFXBPDGMzirsIMxYNX/nXy1x26dyWpeqfaVvXVdZRdq9+Mx/hdA9GAn3HOXM737AR6y7P4nbmicq9eTCwb4lLHcqcPadL8rg4d/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=egBk8h7K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f44b45d6abso48107185ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1719360635; x=1719965435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6v2rHiFvGy14ZL/8r42yhYSWDCIeSm3ffBnLu7Yj4e0=;
        b=egBk8h7KbbPFUJSJIEADc4gFiNzthUF/Zksrt9dnHkCn19+N4iFo+fPwMFf3Y03GKm
         HsbFza/PPxUlS0g3xlQ2zwTnVRYs8g5EklbFFNm6zHOOLbT9Qy/HhBIzknaWMGubtH6x
         3H7A9QfnufL0Iyecdmv9Ey/e1jU69Wiisu/rAJrCwzCIqLnhIqC6I7XV+cCuXxtZnsq4
         dewWX45LOZQQ1GTS0udKrIPYQl7KyvqgiWKhC3j6/UQ54zG+BMqJ5jrLuh8Tem2CrcpL
         dqfbbkulVoFnP7Tq+ZWHms9SZnhrLlonA2jYy8liWjTNDqHW8gLbl6KI+mMTMg3JRXPz
         0HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719360635; x=1719965435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6v2rHiFvGy14ZL/8r42yhYSWDCIeSm3ffBnLu7Yj4e0=;
        b=dLgSHw94dVDXiHfEE/HKb9YBZ4nMD+hS5N/21Wz+iHPm8D1NhUabzu7gs9D/9+rMWP
         q6vTAnMzdioCHfbzf+L0d+XWowB7DDgs4qJZslwSZgSWTh4WIe5eu67nuC1XfckpGDN/
         wXWztdH5SxsTlMDVyw1hR0U6c17m4lEbi1fVV6uiWWDMHf+DFAP8wXN9m5mUtUiBVA4y
         kna1fx4VzMeD1KYHSAJutxr2uYKt9oz6+dczFGKn+9t032Ena7YmAr8ngBGwEGmtWHa/
         MMEN8lq9oeBEqZNvxpQtIHf5Z8/djDoaEE0r26SIYzdHHIFSYNn92YPWhmJ1kmSfDAjL
         nAjA==
X-Forwarded-Encrypted: i=1; AJvYcCVJRVa90nBByTXSxOqPJfHbbHTfRLkJ65D247gjyo+4MpIqZXie1PerYz64hkCYATMZ2xET9Rt6xZjBd5gqLaUk8oj1SZTv
X-Gm-Message-State: AOJu0YzwYYgXEwK29tRlFpNgVKyaeyXuaEiaIEKYKjLU3+vaYxNQF9Br
	2XIiOHrP55VWROhHeWi6aDjLRdxGoDOc+KYrNoc3E3xwTSXF6q8LpibJkPyKznY=
X-Google-Smtp-Source: AGHT+IEHczyJc84tcM5lVpCaiSo4EctwQ46a4ytfzGGVjrESjC4sPW/dJFxEntoEm7xBdAyeEGDpww==
X-Received: by 2002:a17:902:c944:b0:1f4:867e:1486 with SMTP id d9443c01a7336-1fa1d62bc48mr111085765ad.40.1719360635320;
        Tue, 25 Jun 2024 17:10:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::7:37c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7edcsm86750755ad.297.2024.06.25.17.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 17:10:34 -0700 (PDT)
Message-ID: <aff42d94-729d-460e-af18-b91130b5a3b6@davidwei.uk>
Date: Tue, 25 Jun 2024 17:10:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/2] page_pool: reintroduce
 page_pool_unlink_napi()
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240625195522.2974466-1-dw@davidwei.uk>
 <20240625195522.2974466-2-dw@davidwei.uk>
 <20240625163936.2bf9197b@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240625163936.2bf9197b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-25 16:39, Jakub Kicinski wrote:
> On Tue, 25 Jun 2024 12:55:21 -0700 David Wei wrote:
>>  #ifdef CONFIG_PAGE_POOL
>> +void page_pool_unlink_napi(struct page_pool *pool);
>>  void page_pool_destroy(struct page_pool *pool);
>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
>>  			   const struct xdp_mem_info *mem);
>>  void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>>  			     int count);
>>  #else
>> +static inline void page_pool_unlink_napi(struct page_pool *pool)
>> +{
>> +}
> 
> All callers must select PAGE_POOL, I don't think we need the empty
> static inline in this particular case.

Got it, I'll remove this.

> 
>>  static inline void page_pool_destroy(struct page_pool *pool)
>>  {
>>  }
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 3927a0a7fa9a..ec274dde0e32 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -1021,6 +1021,11 @@ static void page_pool_disable_direct_recycling(struct page_pool *pool)
>>  	 */
>>  	WRITE_ONCE(pool->cpuid, -1);
>>  
>> +	page_pool_unlink_napi(pool);
> 
> No need to split page_pool_disable_direct_recycling()
> into two, we can write cpuid, it won't hurt.

Ah, I see.

> 
> The purpose of the function didn't really change when Olek
> renamed it. Unlinking NAPI is also precisely to prevent recycling.
> So you can either export page_pool_disable_direct_recycling()
> add a wrapper called page_pool_unlink_napi(), or come up with
> another name... But there's no need to split it.

Thanks for the suggestions. I'll export
page_pool_disable_direct_recycling().

> 
>> +}
>> +
>> +void page_pool_unlink_napi(struct page_pool *pool)
>> +{
>>  	if (!pool->p.napi)
>>  		return;
>>  
>> @@ -1032,6 +1037,7 @@ static void p

