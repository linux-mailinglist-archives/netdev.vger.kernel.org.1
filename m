Return-Path: <netdev+bounces-246072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B96CDE212
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 118F43004F12
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2529DB6C;
	Thu, 25 Dec 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTzyyZTK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q7aHiHAh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E122868A9
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766701684; cv=none; b=QcrfKiTihOZ6xT9mWFTJoAwhNIfRuzIGqGq9i5Q5dlUTkyCc1dj8rpDD73nsQtal9TLOEmMmDHr+olUA+t1deJ+rFhCuyANBnHgSI0yYZITM7qzqdx7agW/jbRSpSGuR2ERZKVoS5ML7TX3OTy09PEVNUrp/0vJWeTn9z8MwCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766701684; c=relaxed/simple;
	bh=ly8xlAcwEq5AylEYJRI18D+dCgZKx0t1PbpMqP7W2Io=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=un4DC9Xi1Abgx+RbzZXEsCcaKnJAecWD/ENqy6Vryk7s5oTXqTktMzGmRF+zP/mrD/QuaxIHRfnHm9w2SgMqtonY4GIXK6BKr06w749KiaGsX8DGEpKR4oL5wieKLsZNW0CvHiHm3d9cxh6ARyxWQ1IUaE6qNe/RW1KmJCNXVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTzyyZTK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q7aHiHAh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766701682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
	b=NTzyyZTKAi+1p0EJ9DGkep+IfGVWOPiYNgfLeIF8l9mtC7emjX2vS66Id0WH9bm7MDt67Z
	vkb3oMtcB4qu4346L097XKLPpdbX2G7G+q6UPHdqnI4dKPm34V9eJ+eHxVyUZek2S/PuBN
	pRIt3j3Q+hZ5QFOZTXcEtStnDf1HQfw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-H6r0EmoSOsyxJd5EOpuyvA-1; Thu, 25 Dec 2025 17:28:00 -0500
X-MC-Unique: H6r0EmoSOsyxJd5EOpuyvA-1
X-Mimecast-MFC-AGG-ID: H6r0EmoSOsyxJd5EOpuyvA_1766701680
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b22ab98226so2376231085a.2
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766701680; x=1767306480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=q7aHiHAhKiDFctYhmJS8WvOtJaLGJJEUm41lj1/1YVBLxmzbbIDbpp1MWcUFgJGuEw
         2/EMTXdVNHQYo0PqfBqjIPv9eBwmHTUegV+Y98OtcB8cdlCbGOSQzFdIQ3HZ2/aCWKGB
         iCTtxpM2oQThBS5VplpTT0UkLMGVYf0pSZpZkPkCVHg9CEcEUjt+AZ01K8hMCwY09ZIY
         bhe3xukhHvsQ/06yaEwMhpILaP4JSKuwPo5iu7iRW+kUzuUQxkJlwVo0cfQT/loVNRe9
         IcbgVKJN9brswEY9XFv4jEV95MdxoPFneV5GYiiRKRPDJioBQCBE++lCpNVRhQGmXz3X
         RAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766701680; x=1767306480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeNHvsN1ZBvb8Hdsv//kNjFTWoycJwfijVViJF41qv8=;
        b=Uv+fQslFirZLmeaneuotIct4qq49hS/YChgB8JZcG6JshYlVM/C1Fb5Mxk3MJOKUXu
         WPHriT+w8V/trShj4sSGT8dHN5Pc73n7QCf1I3j6q57P7D7wcUsK0PW5Ivxub6ZmgLTZ
         lLO6/Rfm8edxP/POtwVtr/1Px2z47JeXBsTLynWgN5TE986tB/pw3Uvhya9pdIe1Pqbp
         ylENjA/WhXCxoL7CPHBSYhU+ZJbNEnq8VdcLiA9ke5g2p2lONxOpZEEiRjua9dx100eW
         naBu1b5fomGN+4tqF83A6aIIv4IOhYCfUSZ3oLWlFVXyeNgMWf7jenWxZqPaoiDUWHdR
         L5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV7Yg6pzjFY6pLzUmXvMtaE5VVbRis47GDT4VuZc4xfLsoQChAtvGN7colMLbkZVmDmABKuyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8jG/PXwv5RoLcyRMJD2ojVyMCSXWYf+7dCga5xdptTY8uv/d
	0lXZNhgBc+nipHBe8X8tAmGygiiqR58Hsi5wpmHsRmTJl6IGA3YDknRaDfVNlI5IFqrNZZQ1mm0
	gfqO8X3DYwHSsmUB+sTMHf9FbElNey28FLzPy+J4ab+smqSclQnwflPL+8w==
X-Gm-Gg: AY/fxX4tO2LPB6eTtRTeveaJHD6CcljSQmlzklikQBmG5KXr1rqkbEsNrLLB3DZJjmz
	46LO6BHaxziedxtm+WPycseBfET1Y0vNwjvH9LDQwk0dHiZBknK/dxc4ejJAKfd8V/5I6C5Se7K
	FwCsQtAJX+jZ3bL4bm9Tjl2saGy1iRiKDWsFTpo4DsO+DjO2k6Wjvj0IKVqh82sCt7bKJsr7WYg
	LoBbcK7Xznpa9haVRnK1giwzJgHXdFnXOSF1+9T4rZKKv3JPesz/pfqshbUzInh1V/fLzHmcd7P
	k7HuasImK9Sltp6qbELPtu+chEfYDoidbzlkD/onoOAHQzhuqEeRIT5Uonxf8VS37LARCvLa6ef
	aQ2lJQVHeZvUI9vH0RAKOoKZP3SM0whhUdZsYGUAphNQoVTxXFDC1ZpAF
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197586785a.30.1766701679931;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkk34PfoZDZVXHOsdvaSoOtEJlSomrI6NhnO1ciZ/uaqISBnHAQBKZ+i37TxyEDRNXrTUZhA==
X-Received: by 2002:a05:620a:414c:b0:8bb:26db:e22f with SMTP id af79cd13be357-8c08fbb5432mr3197585085a.30.1766701679541;
        Thu, 25 Dec 2025 14:27:59 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fdasm1605628285a.35.2025.12.25.14.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 14:27:58 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <04708b57-7ffe-4a97-925f-926d577061a6@redhat.com>
Date: Thu, 25 Dec 2025 17:27:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
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
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-6-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251224134520.33231-6-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/24/25 8:44 AM, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>   include/linux/sched/isolation.h | 4 ++++
>   kernel/sched/isolation.c        | 5 +++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..109a2149e21a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,8 +7,12 @@
>   #include <linux/tick.h>
>   
>   enum hk_type {
> +	/* Revert of boot-time isolcpus= argument */
> +	HK_TYPE_DOMAIN_BOOT,
>   	HK_TYPE_DOMAIN,
> +	/* Revert of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
> +	/* Revert of boot-time nohz_full= or isolcpus=nohz arguments */
>   	HK_TYPE_KERNEL_NOISE,
>   	HK_TYPE_MAX,
>   

"Revert" is a verb. The term "Revert of" sound strange to me. I think 
using "Inverse of" will sound better.

Cheers,
Longman


