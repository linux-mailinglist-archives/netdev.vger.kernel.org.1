Return-Path: <netdev+bounces-169429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63404A43D87
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A13189774C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4019526772C;
	Tue, 25 Feb 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPSnMekU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B592676F6
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482846; cv=none; b=vEOCQCsGNKbcGc4Ywd81gRWOmXALEp4VRInkcJJW8f37pKSWxZKojhLjXQXKNk6thKUzi/O7s7VIIDdlCguD4QHfu9ZJNHV9OrnN3vcaZx+sgV8VNs2DkWVV1TADN+t1NLYByW0sO34Y7jBVrLqtnVU+knzpGIMfBIAS+pAy4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482846; c=relaxed/simple;
	bh=ZvKEr+Aw1O2CbH02aH/ycXTvVAHfA9G/U7K7FEuLTx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLKA7N2pnyd37/Z/vMZ6SrngFnQJYF/wRrIR3Sa6eZdTZY2KOMUNwKNhII/1uIsN2h0eQndXiUU+Kf/p71M5Kr3uhCrK7VT4e9VR5PgUDxXDdmy1EtFozUhvpboO+HmW3dZ5SmnEb1Bcuu3c5mdKyZMb2UNq52wNk8kw3uo/vDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPSnMekU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740482843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAaucFBe+ebr/B+zt928Rm3uzKsRzpw3qm5/ycLEbwI=;
	b=IPSnMekUmuEq9uz6+y/C31qHM0FxiFTBWhoFKVlXu5y8lR+deDUS/Gc6fWjpJ28rkhrCUK
	w1r2wxTZK94bbIzQO2YEBFQyLzSm40Qv0Guh1OWktG7VORUPv5jmYlB/GcWl0jDsON3/Ac
	kEc2lbKZfpJ2WAXYynIuqQ3SBL2VR6w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-nGzcNjRQN4uVW1dbtVYdkw-1; Tue, 25 Feb 2025 06:27:20 -0500
X-MC-Unique: nGzcNjRQN4uVW1dbtVYdkw-1
X-Mimecast-MFC-AGG-ID: nGzcNjRQN4uVW1dbtVYdkw_1740482839
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f28a4647eso2309267f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482839; x=1741087639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAaucFBe+ebr/B+zt928Rm3uzKsRzpw3qm5/ycLEbwI=;
        b=mTgZSiTfajsf4fxSkLb5h6LP4T7MLgUN7BZHESDddy4PS5fmJGGk7uHJCDVEODMWI6
         xPjMU1Ymm8ZofVU4P8fYd1RTowsPjkFUcmqNLxzBLP2LA1CHmzYZQzy2Qm+jKM6PWu7M
         EurdLlA7pOC9Wcf6uy4KFF9bRnZ1brMBhUJdtfMLu/WqwZfPZzXbVjewSCqEgC+S+q/R
         qsRCgfCU+o5zc0P5wTPvn7w11Lv1Er4JEctSf67NcceCbG8xYrAEfOFYHNOIFIIfd8Qr
         wpyNp8tVarfw5j7VFWos8htCzKQnIUr2NIgFYnQOD922MnQpf5wbtQ53kzX+kzrnEw1+
         jERw==
X-Forwarded-Encrypted: i=1; AJvYcCUuXIION9RGY8zbF5Khaju+T3LqTA76f/PeVe3jES7N1ZVB+spY2ECrJQsZyjaswOS6AGhoZLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4iyrdZXXkQuzFQN3/x83X52EMt9PqJMDgxrEPg1YxUSzYS3ky
	L1FJrh3rKMjG5zfKbuvH+6FcDOJJwqsVcYQWRzxwRGZYI1zPsNAKeXzDR8Ct4AtUMJiYh4A1N06
	85Cm/i3U+scbXueDM8N0dp/MAvJzRk/0TobZNx+XjmKZajdqhD61iZA==
X-Gm-Gg: ASbGncsqGP5xX0IUJ87DzDcOvQjQIteirr0lXK3oMrJB3nT4l17e3UJfvBRILxxbXI/
	3HCEQiR81NJ53j9RwbbTZO6ygVVON28oY8I1pAx1mA+fLf1F4ssHqx0N89R6A54vgKYA+MdCSC2
	pUVN9aFu/lLhCYET5w7dXOvrTXpIp3JENsJTkeoAqrn3tbAMEQZVAUgwPSKxHg30n2dBMVq1lDF
	94ZUz2hAwkmsdj/Wi7iVf3/KmG1HqYZ58OcI2/l4ftYd9niz6/5GzX7sNYL+lgVne2P7srJC8rH
	o6KFYxgmmgT1bacvHR6E8fi8fFSP7EIX9ukdIs5VPdQ=
X-Received: by 2002:a5d:51cb:0:b0:38d:b448:65c4 with SMTP id ffacd0b85a97d-390cc638cd4mr1875726f8f.55.1740482838805;
        Tue, 25 Feb 2025 03:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPzqy54v/RMp3QrDoyBvRf98A5tIuWSfb0O0Warb75DMVJ/awMvqU2rf0J0ObFwzsjOs/7cA==
X-Received: by 2002:a5d:51cb:0:b0:38d:b448:65c4 with SMTP id ffacd0b85a97d-390cc638cd4mr1875683f8f.55.1740482837727;
        Tue, 25 Feb 2025 03:27:17 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155eb77sm22675765e9.32.2025.02.25.03.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:27:17 -0800 (PST)
Message-ID: <50019760-440b-4b0c-816f-d262f747a555@redhat.com>
Date: Tue, 25 Feb 2025 12:27:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] page_pool: Convert page_pool_recycle_stats
 to u64_stats_t.
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250221115221.291006-1-bigeasy@linutronix.de>
 <20250221115221.291006-2-bigeasy@linutronix.de>
 <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <307939b7-8f51-437a-b5b2-ac5342630504@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 9:13 AM, Yunsheng Lin wrote:
> On 2025/2/21 19:52, Sebastian Andrzej Siewior wrote:
>> @@ -99,11 +106,19 @@ bool page_pool_get_stats(const struct page_pool *pool,
>>  		const struct page_pool_recycle_stats *pcpu =
>>  			per_cpu_ptr(pool->recycle_stats, cpu);
>>  
>> -		stats->recycle_stats.cached += pcpu->cached;
>> -		stats->recycle_stats.cache_full += pcpu->cache_full;
>> -		stats->recycle_stats.ring += pcpu->ring;
>> -		stats->recycle_stats.ring_full += pcpu->ring_full;
>> -		stats->recycle_stats.released_refcnt += pcpu->released_refcnt;
>> +		do {
>> +			start = u64_stats_fetch_begin(&pcpu->syncp);
>> +			u64_stats_add(&stats->recycle_stats.cached,
>> +				      u64_stats_read(&pcpu->cached));
>> +			u64_stats_add(&stats->recycle_stats.cache_full,
>> +				      u64_stats_read(&pcpu->cache_full));
>> +			u64_stats_add(&stats->recycle_stats.ring,
>> +				      u64_stats_read(&pcpu->ring));
>> +			u64_stats_add(&stats->recycle_stats.ring_full,
>> +				      u64_stats_read(&pcpu->ring_full));
>> +			u64_stats_add(&stats->recycle_stats.released_refcnt,
>> +				      u64_stats_read(&pcpu->released_refcnt));
> 
> It seems the above u64_stats_add() may be called more than one time
> if the below u64_stats_fetch_retry() returns true, which might mean
> the stats is added more than it is needed.
> 
> It seems more correct to me that pool->alloc_stats is read into a
> local varible in the while loop and then do the addition outside
> the while loop?

I also think the above code is incorrect, and local variables to store
the read stats are needed.

/P


