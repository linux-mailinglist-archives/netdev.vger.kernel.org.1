Return-Path: <netdev+bounces-249125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC2D14954
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2808630263C8
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2D37E2EE;
	Mon, 12 Jan 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UT+GrsaV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMS+qKWM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BB30F7F0
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240449; cv=none; b=WWNqgrdk4v/66+AvkClSXtV+Qp62JqhuPKeZ2R8Rw6WSLrKnUm641lbV4GakDTPVpKXPQz2nFZchOqmhSPWwyxkszJgg74OGeJqbjfFqhVZz5FseDEqTehXqRdgRAWjqpjIKXT6Cmf9R2UT2J48/vANNR/ZFW9W6ij0QYWaxVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240449; c=relaxed/simple;
	bh=69fqmCRd2Tf1nBFL5gD9s9xWKdbIFwrikt2C7UGqOuQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dr55Bc/ByW8G8rOaSJcngrPJtv64At7xlC4zyRPg79w2MnZttKaC7S0tD8bUTaUpNm9KsxBl+ncgbUwCYjf/Kj/bhaxLJQ/U3L+SxEYeizskFKCeNQ8fUGmtAXyr211DD7yPWRyMYB6/9ANYkPz2eonPxZB1Ip7SecDNDLGPCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UT+GrsaV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZMS+qKWM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768240447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
	b=UT+GrsaVKKGYw2mDPmf6/Q1PFpQKUeE+e+g+3JU8Yi1VbR1tg53QrXHaVoFN4x2jVr2Xy6
	08ITeB4JdRSzOd6af2E1EZBrQNq6jhNQQOpBdBko5jT0GJLPijWPfwbZY5lo3lIBnGMU9K
	/8ClP6bdNLEU6TEa+C9//Qk7wTsbrNI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-gpjjg8eiNZGV6_nuVjRIYg-1; Mon, 12 Jan 2026 12:54:06 -0500
X-MC-Unique: gpjjg8eiNZGV6_nuVjRIYg-1
X-Mimecast-MFC-AGG-ID: gpjjg8eiNZGV6_nuVjRIYg_1768240444
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93f57d3a1acso18339636241.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768240444; x=1768845244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
        b=ZMS+qKWMbzAgtiOZ95b5b8ACdWzxM4x9sBM6AmZ6omRt50avcKiYgnQFchcpczNi0Z
         5wbcfi+GqGL/W+H44x189kjMmOu7+H/AKjM3mNtITG67PLv+TFc01DsJqq9a7X9SM2MO
         CN29O8bEx0OT+bQ4FLWb7gwWLUy2HQvqIf4cZZm+wfPJe5q8mEUU9T0iKe55/50Uj940
         a/9u5REydn/+V679XfJfgbVn1/e4uh3vOCEtUkSs/wcKdHEBMU4XdFN6iBFcddrF5bV2
         zYt3Gc2e31k9oYfQHjWTkgFWX6atHOwgpiDIPcVTI6H8i7s1pGIryuHitaOy0fi0WK30
         bHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240444; x=1768845244;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TjQuHk6AbSuF3wU6pHO95OUHC0x3l8Lsr+qaj6DcQU=;
        b=dhtaWFX0LQGvNEDBSgwNhpnIbkF8aOIXEVhCm+Fxz3XZWqf9lYdZ8g+Za0YbqlZB9v
         6C9zRAC9QHgLHgm+DjWWfhmT3/uEp7VdttPoMslTBMXqbNyMQ2abxnQLLahCs38/EzLF
         4egJX4QCb00zMCaZHoju617b43QULMTBsmisGbGqGF4Ziv5TnIJhhXMubiai7QxEMeVJ
         5MTe/dAOZkjG+P0u8Og3cqjRDWi2/lyjsJC/1EenLQ31w1SlNj8T6knVd0N8w8SB1KXQ
         jPfiqmrze5Bj7WNhvZu71A2oKq86o1FOJpEZqwXxrFRz5ksNPKowXTFElUkDPatt/rtO
         6i0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUWfBK+0QV62CkHzoR5f2bRKCk2gZFC79UJpeAInTz55jbTSHf4l48WpC1KYUkEFLO67S9kEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOY5nWnkWLcfdTIywkzUCus+NrMP5o57vaRDWbdoPGhRK+689m
	Gif10Shrm6ytQZ/IHBVf8p86KmTfmU1yJZCZN7zVLshnpA5VxHdBF+3cTfqfCkF9w/LV+xzqY5C
	tdN0ZS8G+zzoZPjB+Nn/UQGLI3TrpgDQmjak0fCf/WKLubH1en0avsM6jiQ==
X-Gm-Gg: AY/fxX6sJQYmbomKGI42VQ+3MgTIdCnMDEH0qHIJjsT9oUGM80SeiTJA7NyObAXqal3
	I1l31mWa1iLMV00veeTPTmLgzZGbGoakfYG+fxJgCVKuSIKp11q1SZkCIcVvoRhtsMtQ3XfNxaI
	LrU4sT1ruD25KKjdPRd1gS2NvUptkF4kqQUQ+YHfd1+nnuC9dB4QFtjV/aSIzBrVUfcw5t8XZAm
	m4yJ5+zhIfRQ6UmBGxN+YkOk/RJExWD8wqFv/Id0nKXkZA09GZG31DwqA62QVXPDWuOowfb3jcT
	5rh3i8CmJS3LyKhAn0+61fndhIb6jq/dJEPL6xv0n5OmDMDWmFW5uMkN1HusVnJuwXu/JhNNq9H
	C5PR/qDltKpd/WgjO18rbnv6leI094ckVyPuldlhfbr19KEtE+Bl+Ne9h
X-Received: by 2002:a05:6122:4f88:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5638335b3d9mr1837527e0c.19.1768240444534;
        Mon, 12 Jan 2026 09:54:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxwLoMJ4ylgMx4yokJUFTrQvglGoUK2cQ8cuwE9wOBcOJlyALmmG0hMGzOjgHwYtiz9Ob2mA==
X-Received: by 2002:a05:6122:4f88:b0:563:8335:9ab7 with SMTP id 71dfb90a1353d-5638335b3d9mr1837491e0c.19.1768240444039;
        Mon, 12 Jan 2026 09:54:04 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5634ca16da7sm15469803e0c.17.2026.01.12.09.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 09:54:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f8ca375e-9051-4c7c-880d-e56e07206788@redhat.com>
Date: Mon, 12 Jan 2026 12:53:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/33] cpuset: Provide lockdep check for cpuset lock held
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-13-frederic@kernel.org>
 <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Content-Language: en-US
In-Reply-To: <e97d96fc-cbdf-4c03-aa1a-b0cde5419681@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/11/26 8:43 PM, Waiman Long wrote:
> On 1/1/26 5:13 PM, Frederic Weisbecker wrote:
>> cpuset modifies partitions, including isolated, while holding the cpuset
>> mutex.
>>
>> This means that holding the cpuset mutex is safe to synchronize against
>> housekeeping cpumask changes.
>>
>> Provide a lockdep check to validate that.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   include/linux/cpuset.h | 2 ++
>>   kernel/cgroup/cpuset.c | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>> index a98d3330385c..1c49ffd2ca9b 100644
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -18,6 +18,8 @@
>>   #include <linux/mmu_context.h>
>>   #include <linux/jump_label.h>
>>   +extern bool lockdep_is_cpuset_held(void);
>> +
>>   #ifdef CONFIG_CPUSETS
>>     /*
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 3afa72f8d579..5e2e3514c22e 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -283,6 +283,13 @@ void cpuset_full_unlock(void)
>>       cpus_read_unlock();
>>   }
>>   +#ifdef CONFIG_LOCKDEP
>> +bool lockdep_is_cpuset_held(void)
>> +{
>> +    return lockdep_is_held(&cpuset_mutex);
>> +}
>> +#endif
>> +
>>   static DEFINE_SPINLOCK(callback_lock);
>>     void cpuset_callback_lock_irq(void)
>
> The cgroup/for-next tree already have a similar 
> lockdep_assert_cpuset_lock_held() defined. So you can drop this patch 
> if this series won't land in the next merge window. 

Sorry, the other new lockdep API isn't exactly the same as what you 
propose here. So it is not a replacement for your use case. Sorry for 
the noise.

Cheers,
Longman


