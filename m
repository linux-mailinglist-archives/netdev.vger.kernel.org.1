Return-Path: <netdev+bounces-177168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF942A6E23E
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BFD188D7E5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8126462C;
	Mon, 24 Mar 2025 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="VDTMYuGd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31854210FB
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840729; cv=none; b=Fi8AlKgCumm0tOq5dbCkJ+p5tiCY2TqMcH3Yuru9w3Fv0vQOOhoA87H9TXuYIewkvNAFCC0zGdzFJr6HhYr3duT03PujKnzkebB1T/fdrQIuyZ2MdHGlsKo2Qs4ZBvlw4BEEUCUqTo1a9qQBaGK1/NlIR7S96qA1uaq4MkGCKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840729; c=relaxed/simple;
	bh=5U/I/KBZ6BFN6/AEtwlrLyDtxRpuKQP9p+JItDJqm28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkQup0gvEURGkRGzaUj3nao0LmcqfiLaj2N8Q7YFfGh37M25EFsD5Unpfm/WBm/OJo+IVvKhjFVXbYTB0uh5n2M7v+nnLW//XB6Nonj5z7zNgPPblmkDkGNblnTdW5cmzVkY7qkR9sShWn58BrLNUUbau+Sn77htjt8mAEq314k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=VDTMYuGd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264aefc45dso78594385ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1742840727; x=1743445527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dti23/BRzO4sMSE1QyRrcc2O7LFCO9s38xoCuIG/pFo=;
        b=VDTMYuGdZALZxNlSUgSUIszXcTXej51+gK9tvjUrlF0qd9AuYRIWnmwNimgXJp4sQ2
         oZXfczFBey9RLNqu9Er45mvbfeKCQbp6cZVFoTeWKG7Pb9BIdtsvPoAAAi8st7mQKPIZ
         d8GmaYnfz4iQ4+keet9KvjRENSykDkCab+8YJbwEFGml6lmuQmAHCz2oaROzwzgux3Wb
         zgzX2e+Fu3RAcHFJQKt7mpKbEtitWMNu6x8Q5MRKZxW5kC3ETLckNrVtXZel/hA7ZxaU
         t28DrSehbXMwjmrpK3ZMh1zEJoDIzFV+dj4tlohR5ckKB9P4IX88SxWbR8yVPAZ2W63V
         aVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742840727; x=1743445527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dti23/BRzO4sMSE1QyRrcc2O7LFCO9s38xoCuIG/pFo=;
        b=WSgFW+ZMz28KD+zg/vv286bvrDe7pjS/400j8aUNZQ0b1DJTs3lbj8koHHDv/hSgq1
         ThSZFCa5g47quqgELP6R4sIla1cppoppDALMC4mfi/fLLDM1H51MvM96HJL4Z2tgdSdY
         oy/m/oF0CMNYIJ/niEDcc92xdvA+BVjjEwFl683uszmi8lDDS6ZShRecF0E3AIxExzZ+
         BUm566AHdmwbCB3he8B5tUcbChS0jhPLMa3RZuN/R2/VqyX30E24020nPLG8VaCti/DL
         rt7vgSJ3yPFcQH5KYtpMSECAYfLM36kaOrvarFmYyJu48DGcsKYPOqcd8pwJbHpnSsSB
         /q+Q==
X-Gm-Message-State: AOJu0YwHLjWBuIqxjLXlmtn5WZUeBDNEW/myXNPmLNvPQfA/Q5n6h6aA
	eTAwTJrT0C9DMSp6LjLpfqASla+SroY6z214mzdwgEOD2ni1eDtznUeD8JC4fYo=
X-Gm-Gg: ASbGncvtWR7k/j68YYdGnq+dQeA/i4CDy0vUl+hXo+7Ud/n+G2lxrBu5lhpUzpdQfma
	Uo7pArSKacIlJh6TEdCvSv2jQL9HNN+23SmzMiCDrQGAW2QwBxqHO5CIXdGZXt55cXzrSxpymR7
	g8zCqmvrc7+JBA5nrPS3xHdDMuS9sei/TpTtmzf+ezbSzQ20ANLIiyJl1nJ9xSoldzNsOsLHjze
	oq1bxtwo+iY6R4nw41M5chYrkqP/l5hBWwmcbIvqYVognSzjQJRVCR3JdB61wtcD3ClwHXwRA51
	L3oznxRG8B2xa1BvW9wwAwmASz+RqEq6JFaWQ0ar0HjNQ++ZIShQPUKVMS/MgRjLDNw5OLfqMps
	2J4Jc2fs=
X-Google-Smtp-Source: AGHT+IGGMPe7XC77XlupSn7/YvdG4D2mOcRm+JPSPO3uvSW3aTHHYfmqPH4OFTMuxGZbDGNvmo5InA==
X-Received: by 2002:a17:902:fc45:b0:21d:dfae:300c with SMTP id d9443c01a7336-22780c546a8mr220163435ad.3.1742840727426;
        Mon, 24 Mar 2025 11:25:27 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cf1:8569:9916:d71f? ([2620:10d:c090:500::7:f781])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f6f88sm73996335ad.237.2025.03.24.11.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:25:27 -0700 (PDT)
Message-ID: <d4d89a4b-acd2-4bf1-8652-5f180df7d742@davidwei.uk>
Date: Mon, 24 Mar 2025 11:25:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: page_pool: replace ASSERT_RTNL() in
 page_pool_init()
Content-Language: en-GB
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>
References: <20250324014639.4105332-1-dw@davidwei.uk>
 <85f2a226-4dd3-4ad0-afb4-351ce2487961@lunn.ch>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <85f2a226-4dd3-4ad0-afb4-351ce2487961@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-24 07:18, Andrew Lunn wrote:
> On Sun, Mar 23, 2025 at 06:46:39PM -0700, David Wei wrote:
>> Replace a stray ASSERT_RTNL() in page_pool_init() with
>> netdev_assert_locked().
>>
>> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  net/core/page_pool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index f5e908c9e7ad..2f469b02ea31 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -281,7 +281,7 @@ static int page_pool_init(struct page_pool *pool,
>>  		 * configuration doesn't change while we're initializing
>>  		 * the page_pool.
>>  		 */
>> -		ASSERT_RTNL();
>> +		netdev_assert_locked(params->netdev);
> 
> Adding a bit more context:
> 
>         if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>                 /* We rely on rtnl_lock()ing to make sure netdev_rx_queue
>                  * configuration doesn't change while we're initializing
>                  * the page_pool.
>                  */
>                 ASSERT_RTNL();
> 
> If ASSERT_RTNL() is now wrong, you also need to update the comment.

Thanks, I'll update the docs too after switching to
netdev_ops_assert_locked().

> 
> 	Andrew

