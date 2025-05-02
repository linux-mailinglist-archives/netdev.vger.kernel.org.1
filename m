Return-Path: <netdev+bounces-187404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB0AA6E91
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34184461FA3
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2606422CBD9;
	Fri,  2 May 2025 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw3yJzdt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74872205AB9
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179969; cv=none; b=bPKEJzI3ko+2hY2t3tI/Xf8wCFLkvYTC49plz/sstz556VHExH+tWvzLhd9g1nTNrd/k9y0olhLrtpYxjH+lkfqAQ74q4PhWhDpiO1m83m1QA/+7nvVKduCoFTeL6RJtH0pMS/jhynUfsMVLuRn3DNwqhCCNoTjqof3UlDMPzcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179969; c=relaxed/simple;
	bh=LvQyjB3fpls2Rt70+aAx4jeREntiaIW4mWRWlZPfdrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAWNY+DmNp1mkB4D0aI1dez5grAFxpTAax+9AuCKeo6S+FesGJtLpjVWcQiIL+c8hjtb7FRXaE5OQWdrQYjqBeKuq32lzv4Mjg1XwP6XEIkThT628i2Rf/mg9mPQCMKecndqP+dlVLvpIH9OYyu2B3KPZZKMOhFec4neXo9hHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bw3yJzdt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746179966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXOh559gmhCR9OxgfPi+DVVVLlUWdAIWl82Cvhx7pCU=;
	b=bw3yJzdtefVZ8NKUP7TWkm+CLWh5h1M0QwihCAlBwLhvN304bTso+UgT788o2ioLwb//ck
	Z/fZV8IV2VU5SbEPacPfP+vnKSZOWa1P23V03VF1CFWQ23Y+1WdXAC+H+zBZGLLz3HbA9h
	C5yLEbw5kqrj2MKQBm3aTgLRSWKR6DA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-3gRzzNxyNFenuwuQeA4z5w-1; Fri, 02 May 2025 05:59:25 -0400
X-MC-Unique: 3gRzzNxyNFenuwuQeA4z5w-1
X-Mimecast-MFC-AGG-ID: 3gRzzNxyNFenuwuQeA4z5w_1746179964
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-44059976a1fso8374145e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746179964; x=1746784764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXOh559gmhCR9OxgfPi+DVVVLlUWdAIWl82Cvhx7pCU=;
        b=KVBrWZUUgDWyU7e2tBIhqm5lJB1o/K/9LK57lnvrMg2IhG3FJFBIZZEHz2U/KUCduS
         XQQ4DJri1NMuVIDrxtQiO/Htx5NpXKqT8IwAFn4tqjZfogkxY++6zRLhpKbrE91LbeOx
         m54B6Jm8xZxnjYl+COKHaQmdUw6qY9Lbql5bh+ND8mqU/+EiX/YUP/5xpzslRazN/q/h
         xUdKPkmKbQWidZ8odz9+LlWsqm7KFxKV6Coo53ab7OEAu4khGRfZu93F1Adz/rA6zW8U
         4BwM460JK0xCqwcXOePRmR4S3UGBc0D53o69hIdFhHixYdLz3lL30HVhCCoUX3aGEj+j
         yzww==
X-Forwarded-Encrypted: i=1; AJvYcCWlAm7DIRGbfMcNKKp5WCd4VZJS3Gv95nE5vlmn4S+6AHicoRxh0iGM9+6CBSZo1z2bGYn8cBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLuXsLoOb6laqQc+BZtqJgQ9U2Z8sY9DpCvKlLeO20W37NAu7
	/iQuYYsV6apz0F0+bdM21D6LffaTM+mGm+TX9j+IyHYNYNHUcReetubIUHP5fNywGQ3YxmhzHs5
	mlJRp0TwE7XCXp22OxLwWMtfzXuShgidsTcv8QGgaWREsoBnGVtouww==
X-Gm-Gg: ASbGnctgGMW5LYcBW4QmfE/fLBJXa6xJ3lhuGoTJF48LaLaVtIZSgfhY9piVCm/oysx
	2cddzW1mfWY10hP53iCoFjCt8wInNgGt0tvD8IRPYrSaYFcCazPp4xj9GgoxMGqu33jxPQd6cQ6
	8G4SZ/TZWHT2bqo/DB0XXX24baU5mpAfOZa+7ojaLZNqPmiOlWm0kgDZs+/kvRnv42iqvZTJDbE
	kT9z28neF1sbDc3Ig+DxKvkR9H1Blcz6p0pBJv+i7fdAtnmVikeus3Th2OdJ6WQFlhEqavTkL0Q
	4Yhd0sCBRNjlHU6Zad4=
X-Received: by 2002:a05:600c:1c91:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-441bbea0cdamr13440605e9.7.1746179963956;
        Fri, 02 May 2025 02:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhhV2PfRCQUij4kfrb24Pgo9Ok5qcyqC/aHwvJcH6nqXz26wo+x83AXcU3EcuFU1TxFKSjng==
X-Received: by 2002:a05:600c:1c91:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-441bbea0cdamr13440445e9.7.1746179963616;
        Fri, 02 May 2025 02:59:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:246d:aa10::f39? ([2a0d:3344:246d:aa10::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a9dsm85925535e9.19.2025.05.02.02.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 02:59:23 -0700 (PDT)
Message-ID: <74017437-48d2-4518-9888-e74c14e01a5d@redhat.com>
Date: Fri, 2 May 2025 11:59:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 1/2] sch_htb: make htb_deactivate() idempotent
To: Victor Nogueira <victor@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, alan@wylie.me.uk
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
 <20250428232955.1740419-2-xiyou.wangcong@gmail.com>
 <eecd9a29-14f9-432d-a3cf-5215313df9f0@mojatatu.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <eecd9a29-14f9-432d-a3cf-5215313df9f0@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 5:19 PM, Victor Nogueira wrote:
> If that's so, couldn't we instead of doing:
> 
>> @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
>>    */
>>   static inline void htb_next_rb_node(struct rb_node **n)
>>   {
>> -	*n = rb_next(*n);
>> +	if (*n)
>> +		*n = rb_next(*n);
>>   }
> 
> do something like:
> 
> @@ -921,7 +921,9 @@ static struct sk_buff *htb_dequeue_tree(struct 
> htb_sched *q, const int prio,
>                  cl->leaf.deficit[level] -= qdisc_pkt_len(skb);
>                  if (cl->leaf.deficit[level] < 0) {
>                          cl->leaf.deficit[level] += cl->quantum;
> -                       htb_next_rb_node(level ? 
> &cl->parent->inner.clprio[prio].ptr :
> +                       /* Account for (fq_)codel child deactivating 
> after dequeue */
> +                       if (likely(cl->prio_activity))
> +                               htb_next_rb_node(level ? 
> &cl->parent->inner.clprio[prio].ptr :
>   
> &q->hlevel[0].hprio[prio].ptr);
>                  }
>                  /* this used to be after charge_class but this constelation
> 
> That way it's clear that the issue is a corner case where the
> child qdisc deactivates the parent. Otherwise it seems like
> we need to check for (*n) being NULL for every call to
> htb_next_rb_node.

@Victor, I think that the Cong's suggested patch is simpler to very/tie
to code change to the actually addressed issue. I started at your
suggest code for a bit, and out of sheer htb ignorance I'm less
confident about it fixing the thing.

Do you have strong feeling vs Cong's suggested approach?

Thanks,

Paolo



