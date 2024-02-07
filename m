Return-Path: <netdev+bounces-69884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6517284CE7E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D406BB23554
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517B7FBDE;
	Wed,  7 Feb 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp/uDyqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A180048
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321634; cv=none; b=X27PsUo44qgm9OgjY4RFNh+tEfjGmcPsrdYxEf6rjVqmQnZblb/68ffUfMJSxo86fyikJMymjDb100PbKlB9BroEQx1BLk+m0r+C2orEkI2esxe68EVxIGiIRLFP00VX1VdpW6wEIBxuq/vCCi+CboKKPpOFM7Wub9bPJmr04x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321634; c=relaxed/simple;
	bh=LOCrWcIcjD7iSv8SQUD8bYTnno685ZPCjdTVoZ7UScc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vel37QVZPNCZ8/Swlyb75uUyzdAJu9EU398zE9ReZMVzZ0xu6WxLJRwnFOodIcGSU4m5gRRZ1EeTPOIz4n8jtF1yWZbjE9IEqjsT++NKWEn/4hwby3tEQGvwCGzHEL3iSCS90kvPAHo5s1+/K19C5sLNiWz9aGZUm/mHPvetehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp/uDyqV; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso849444276.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707321632; x=1707926432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtVha+iH38Jt8sd7+/PJBc3stdafEVcCMaqR1ouTJaw=;
        b=Vp/uDyqVIKOhD0JtG06l9ND6cTYgJxWurKpfiH8cXvhEtil1UpiU/ItjqVh9XFnYlN
         KxkUCTvM52lcdO1VsYeC2FbUwMxUAmM0arMJaS+AFC6MZXyMJBM4pJkNLdBi6yoWW4oe
         TpfPqHg/lSwosEufK+xNo9jH8mGOWuNEI/4622yRTjyhqP5Dnqi4YnYpLFs70M89HbxL
         0Th6/yS9sf91NGnCYDhvHAILWPOcHBGrSZoj3/a05lqKTXjZnKoaNmi4g/+Hiy3OZP/q
         mj1J056Wx7BqzhbbwkXHweyAqGZaPBEbxX2rNVpFj4Z0rUVWwTVHw6rkn6uYaREUHOju
         O9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321632; x=1707926432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtVha+iH38Jt8sd7+/PJBc3stdafEVcCMaqR1ouTJaw=;
        b=jGqD6HNiu6OXPbi9PyIEf2DZwLgZm/ZIaRLQmrxUFaYV7l91YMs0QLJkwGZXkBQCg2
         L3kdQ+E/70CvLb9Q9gcfKGJkQ4w3IUbc12Rz7zZQnT0JW8EK4MbRuFFgKAYX6HE5qndm
         peV80bhhT1Uak60EsZFLcL0EKiGLMFpcwTHFKapQWugaf/xYwZnySi/uWFDsCq5zKHNw
         2nqoamV4O59ntODZYLpWuXUPg5RV7fBe1qzpWraC2NIhyZMYQEqaZX2FxrVGBBXeAQ+z
         7UOap+4h+cEHM64K6VcP7XAcY2cWhGie6qOKnSEfGHTvJLZye3cmm+3t7YUZwhrTLXoM
         SSKQ==
X-Gm-Message-State: AOJu0YxQbu10uzjLIUqTyAuTvAHno0Sl47XnI7NG9kwU2KWkXYZ08v66
	w3+XvXfl765PTGP3I59IsD2Fg1X0L/4BYAHr32YJODR4rXROH1/f
X-Google-Smtp-Source: AGHT+IHcq5QS1l88K2/Tm5X3eFl9jXDIim5lgGCo/Ox/F75dtvKoq3gaqwwyFibbq9DXwad/xPaY5g==
X-Received: by 2002:a25:ef45:0:b0:dc7:f91:fcd with SMTP id w5-20020a25ef45000000b00dc70f910fcdmr5456326ybm.34.1707321631864;
        Wed, 07 Feb 2024 08:00:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpVu6+T9AyzqFHaSiuJk5NmJpgB5WHekKIwTTNqKqwNlYghcih/KJBpl5gZa/pHI5PRnlJxlnf3QnTx8A3FDoCzXHKjwHehBarNQk1Nk15m+/xgoJR75F2JZQG7Oy1XheHK8+n2hgLSkHY7dN11w5MkmmlShHhqvyu8b0K/7zFwAABNXRBUT81owoUOjDh5Zd6wZyfIVvzJ/rVszpO4p7zPJzPvilinB22pD6WwWDI6EcBunmJU0+3PVVaiLbY18lJ878aFMkJcO/2w8TxgMBDArcXO1SpZGX1twfVBmzsmg3w7tOiA7k+ikoZOvD8jtR/+DLF3QvqYlvdYjw=
Received: from ?IPV6:2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24? ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id d202-20020a2568d3000000b00dbd570a5d71sm263621ybc.23.2024.02.07.08.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:00:31 -0800 (PST)
Message-ID: <74bfcc06-3fcf-49df-bd61-1439806380af@gmail.com>
Date: Wed, 7 Feb 2024 08:00:29 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/5] net/ipv6: Remove expired routes with a
 separated list of routes.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, liuhangbin@gmail.com
Cc: kuifeng@meta.com
References: <20240205214033.937814-1-thinker.li@gmail.com>
 <20240205214033.937814-4-thinker.li@gmail.com>
 <d58cb247-b0ac-4cbd-9eb2-34cc5fc2670f@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <d58cb247-b0ac-4cbd-9eb2-34cc5fc2670f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/7/24 07:58, David Ahern wrote:
> On 2/5/24 2:40 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
>> can be expensive if the number of routes in a table is big, even if most of
>> them are permanent. Checking routes in a separated list of routes having
>> expiration will avoid this potential issue.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/net/ip6_fib.h | 47 ++++++++++++++++++++++++++++++++-
>>   net/ipv6/addrconf.c   | 41 ++++++++++++++++++++++++-----
>>   net/ipv6/ip6_fib.c    | 60 +++++++++++++++++++++++++++++++++++++++----
>>   net/ipv6/ndisc.c      | 10 +++++++-
>>   net/ipv6/route.c      | 13 ++++++++--
>>   5 files changed, 155 insertions(+), 16 deletions(-)
>>
> 
> one nit below, but otherwise
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 
> 
>> @@ -498,6 +510,39 @@ void fib6_gc_cleanup(void);
>>   
>>   int fib6_init(void);
>>   
>> +/* Add the route to the gc list if it is not already there
>> + *
>> + * The callers should hold f6i->fib6_table->tb6_lock and make sure the
>> + * route is on a table.
> 
> The last comment is not correct given the fib6_node check below.
> 


Right! I will correct it.

>> + */
>> +static inline void fib6_add_gc_list(struct fib6_info *f6i)
>> +{
>> +	/* If fib6_node is null, the f6i is not in (or removed from) the
>> +	 * table.
>> +	 *
>> +	 * There is a gap between finding the f6i from the table and
>> +	 * calling this function without the protection of the tb6_lock.
>> +	 * This check makes sure the f6i is not added to the gc list when
>> +	 * it is not on the table.
>> +	 */
>> +	if (!rcu_dereference_protected(f6i->fib6_node,
>> +				       lockdep_is_held(&f6i->fib6_table->tb6_lock)))
>> +		return;
>> +
>> +	if (hlist_unhashed(&f6i->gc_link))
>> +		hlist_add_head(&f6i->gc_link, &f6i->fib6_table->tb6_gc_hlist);
>> +}
>> +
> 

