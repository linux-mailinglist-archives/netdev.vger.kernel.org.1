Return-Path: <netdev+bounces-138694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD39AE8F5
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA01F2372B
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B361F5851;
	Thu, 24 Oct 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0mVq7YV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76DE1E378F
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780321; cv=none; b=SPrW1AdBFi8y15HnGyiKp6M4HH1vHF8GTq1YWQtqwGCNX/wbKfQRF3ZPkOiT59PcPn4pCcpK+j2focdeCsQLfhJohj6tMBHQwLxyEgh7KgSh7X8lhugU/uOeyLE4kbPkSu/QnyWHeRiYy7q2HXd+j/Dt/x5I5/DjEX8y0hN2V7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780321; c=relaxed/simple;
	bh=xad9qDTJ77uXZmffW6CAN7OyU5XpNOihDHJ7RvRFEZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoeQU0VdLkE9VsCcRDJ3yAjR449sStIXbWXCZnyDXqC0lLAU1y7NPrrBBZeNG7J3Vfn1GDpzdv3TARRjTzmL9xrtBoV/K0zVmNmJ6aaENNKs3YEMsn4eVmS156bsnSiCSwwCLZ+F2Giq1oGggRXv09wSTlDDxQod6wkG4rp1GlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0mVq7YV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729780315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR+VwXj6YZP0qk74Xd3gIPDpX5LBmmYd7HXdnCBtZXQ=;
	b=Q0mVq7YVF/DnB3tGt0mWq1vCkZjGOszjfiuL0dNzDgLVRelTtHTJ/ipbL+Q8Dsz5SKuMW0
	1KKp5j5JIUsh3cx28jCcIWEc8xwGHBe+7aTnKR1NuRkIbsjjXhYoFL3ZNLR6d5vf6k2J2p
	PNrOfQpUMkJ6AJX8yK+eR4mGn4r8a3U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Pme7EacZMjS1iSu8wZakDg-1; Thu, 24 Oct 2024 10:31:54 -0400
X-MC-Unique: Pme7EacZMjS1iSu8wZakDg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c945ce3264so317733a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 07:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780312; x=1730385112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR+VwXj6YZP0qk74Xd3gIPDpX5LBmmYd7HXdnCBtZXQ=;
        b=wBGKOuOrtJfe23J5Wmy5XXmF5lr5UoZLlInx5WgOyPX4N0ZHXzTAGWDEkuKaEjcP2E
         Bw4jdxGY2zrEzx5Yd8FLeggnBh17xzZYn3hIkSi6kcKy3MNdAfCJIQeWg56YtGvyxwQ9
         dLQJFDG+APAnTOVyTh+iojPwJbqynavcaCMrY+oQKGiKzVp7XA16a7gcOFz6akmJ+0JN
         8mF5mWN4cZNsWRDky6FgtF/6uY+OJGzO0BMeEC+XEXiG7vctydVj93tibLrV8EAV6tFa
         EU7K2uYuTR6i6sEUnpCsIqAH9YQFwylQ+3ydwjQXSMy7D8pUq8QULZlz3Kha063yuObP
         g98A==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZzDRnI3Zc/Zkjhptu4CVcFOhzCdLjmgTxxANRs9F27eMPxLvko+N8pWLumDB6EMcdsRALhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEDxg8dpOiH9RigqMkC1EngIP+X0T2HO0dQ2FKCRjuAyu3svM
	jqRvdeL/NDyRKHz6XjkQ/+wu71ohJdZln/wutuq1rXKU64gJQZnEYwd8uUcGHJTmLjq2KasLs6S
	a3LpunqfccP4egLnlMXPB9uoLcmKBq08gO262oKPEYbKiTvIOmesO2Q==
X-Received: by 2002:a05:6402:2685:b0:5cb:6841:ede5 with SMTP id 4fb4d7f45d1cf-5cb8b267f63mr7961947a12.28.1729780312408;
        Thu, 24 Oct 2024 07:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWL5QkywW9E3UW9axkod4Rwc4fsE2dLlLJp7ky3B58bsU0/9/2KoD9McnXVsWHisgySoyMQ==
X-Received: by 2002:a05:6402:2685:b0:5cb:6841:ede5 with SMTP id 4fb4d7f45d1cf-5cb8b267f63mr7961911a12.28.1729780311940;
        Thu, 24 Oct 2024 07:31:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b556sm5714708a12.63.2024.10.24.07.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:31:51 -0700 (PDT)
Message-ID: <0f2b58a6-7454-4579-9d20-be62de62573e@redhat.com>
Date: Thu, 24 Oct 2024 16:31:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/3] net/udp: Add a new struct for hash2 slot
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-2-lulie@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241018114535.35712-2-lulie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 13:45, Philo Lu wrote:
> @@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
>  					      UDP_HTABLE_SIZE_MIN,
>  					      UDP_HTABLE_SIZE_MAX);
>  
> -	table->hash2 = table->hash + (table->mask + 1);
> +	table->hash2 = (void *)(table->hash + (table->mask + 1));
>  	for (i = 0; i <= table->mask; i++) {
>  		INIT_HLIST_HEAD(&table->hash[i].head);
>  		table->hash[i].count = 0;
>  		spin_lock_init(&table->hash[i].lock);
>  	}
>  	for (i = 0; i <= table->mask; i++) {
> -		INIT_HLIST_HEAD(&table->hash2[i].head);
> -		table->hash2[i].count = 0;
> -		spin_lock_init(&table->hash2[i].lock);
> +		INIT_HLIST_HEAD(&table->hash2[i].hslot.head);
> +		table->hash2[i].hslot.count = 0;
> +		spin_lock_init(&table->hash2[i].hslot.lock);
> +		table->hash2[i].hash4_cnt = 0;

Does not build for CONFIG_BASE_SMALL=y kernels. You need to put all the
hash4_cnt access under compiler guards.

Cheers,

Paolo


