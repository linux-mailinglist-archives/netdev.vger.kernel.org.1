Return-Path: <netdev+bounces-217738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFAB39A76
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74193A3FE1
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7D30BF6C;
	Thu, 28 Aug 2025 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcY6C1ng"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD45301030
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377645; cv=none; b=PT+li7zCKuX1vPdKScGjA202tP5Noy9EafeQvYjfPiSUjzANF00mzDTg60/PZuwCW1Td0ZsJXQbY7pIZiKz0Id0fKXLtHotJu9weH+rN0pc43jZhsEEN9kJKZvmZ4l27IPOEWl5xt7pagXBqRR1865JjGvtRa6q2wWN5RzDFhxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377645; c=relaxed/simple;
	bh=vh7fMEWd0Jq1p7Y+60fhxSr9ILPF78euaHc5OtTjgQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOI6+CR3g7KBWx449xgz6EY7SJFhp//mwRhI8/JPUxPJyNoZKrB4X19g+mAM8I2lLkpjqgvby2P81dTECzmi6eokaFmb7NriQ3yRTEXH13+PesKBHYuIjbHHuFwyX7ZozPkMzPL3a7LWLlwrqjR/wO4RzQPc1ggAIdaozlIdrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcY6C1ng; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756377642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cu7avEmKr1UKr5IvTbnHZf4VMpiPVvy6lyYGguLMfRg=;
	b=LcY6C1ngg/fYhn8wdPuFF0GuN+xNi6WAsaZZRgia4u9HmNYunZejOwmLvyok6Jq1kuqHwc
	Zsgy41oRWIoL1ASHqgg6/oodCTmAhXwZMPrYxefUvB3lMsePH+w2uqogZ0JNeZ/wC1T0XO
	lCJ/6EUJCVj07Qo/Zr7ZCanoq54Y2N0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-fWQEavqmNbC-AppYAhEEVA-1; Thu, 28 Aug 2025 06:40:41 -0400
X-MC-Unique: fWQEavqmNbC-AppYAhEEVA-1
X-Mimecast-MFC-AGG-ID: fWQEavqmNbC-AppYAhEEVA_1756377641
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7fae3dffdd5so59126185a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377641; x=1756982441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu7avEmKr1UKr5IvTbnHZf4VMpiPVvy6lyYGguLMfRg=;
        b=u3pm/Eiow0En/2GGgcYkbOI2ptuz4MOtawcVQAw27kcm80bC1oF9jTuMY0jsIcwGKE
         V1jPTyNaGJcUAj2oES77yG85SZMNyb06M71rDKiKJFVMdCEvz3QuKLuTifUYSMUxCERI
         y35pkrNUThNBicZDMjHQM0v6CBOtrd1Y9tUcK4wC4F4EFGQhwAJI7ezaekn6gJztF1y3
         /8v4jZZ4zf+jUNmfKlo0VuC1RdCF9y7pgsEB78lXuxR1gIwWTF+/iS+JACzS+fFezbiT
         29QuntBvbiwPoZKPe7uc7U9TAXVTotAeDWl9FfK1+lbqgBqKyM+uV2/1I84elMe2alWq
         mJOg==
X-Gm-Message-State: AOJu0Yx/H7IfzBhZio8dHpuuJqrBxR5/kJmMV5JcEkp60b+p7VIvG5HC
	ToDdRPfkrmAlAJ8iDjCoFwfvrtr2pPr8UUqnwi+YUUFJDpxMesgYTa+9YysKB25pu8RzDzlGEJF
	xdIHUbjZ+/Q+5jEJOBm/kyMKIQqvTrfzQ3ViEez1SRYravTABgsf140xDdg==
X-Gm-Gg: ASbGncu7lJldfd7P2KAFMPE174h+UcMygacSsWGSzvfEyZMU1VHBlyWAW/y62OaMrNo
	z8oUE7fXNtK2rptwi+nyD8JHwxR9t3RbNOpGeZsE5kUI/UVdko+u/wDuGSZs/fOAfEhUphycNgu
	9OWb1cWuP2Ia8Ux5UUSmZwb4dHRhtTjwYkf21fd5palcv73WQPLeJNBT8Iph2uoUNqTAB49XNy9
	9I1HSj0OJ/LkGB3HslzEsAkoowJK8kCvSasbnGEAXomrlMbx7rzADuZ2hmzf3KyHfKHtbTprm6t
	5kWxMD/EBv4nlHVRCsLWOsO/p1FUJ7UrORZENG9YsxPd/M4KxiEZybnfTbD9jwslpe7+svKMLFx
	0oxrfx3YDNZs=
X-Received: by 2002:a05:620a:1a16:b0:7e6:5f0b:3264 with SMTP id af79cd13be357-7ea1108dfedmr2469697185a.64.1756377641147;
        Thu, 28 Aug 2025 03:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUFwMuno0DqsbvQgSM9tyaDqePXxP1jHq7h7GG+mM0Y/SoQ6Sp7Nz/JepfglKGzNWSm99vFg==
X-Received: by 2002:a05:620a:1a16:b0:7e6:5f0b:3264 with SMTP id af79cd13be357-7ea1108dfedmr2469694885a.64.1756377640692;
        Thu, 28 Aug 2025 03:40:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf35f00a1sm1054472185a.53.2025.08.28.03.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:40:40 -0700 (PDT)
Message-ID: <9be8e52c-cb92-4969-b324-febaffeab563@redhat.com>
Date: Thu, 28 Aug 2025 12:40:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] hsr: use proper locking when iterating over ports
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>,
 Murali Karicheri <m-karicheri2@ti.com>, WingMan Kwok <w-kwok2@ti.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Johannes Berg <johannes.berg@intel.com>
References: <20250827093323.432414-1-liuhangbin@gmail.com>
 <147f016f-bf5e-4cb6-80a7-192db0ff62c4@redhat.com> <aLAm8Fka8E19JOay@fedora>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aLAm8Fka8E19JOay@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 11:52 AM, Hangbin Liu wrote:
> On Thu, Aug 28, 2025 at 11:19:11AM +0200, Paolo Abeni wrote:
>> On 8/27/25 11:33 AM, Hangbin Liu wrote:
>>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
>>> index 192893c3f2ec..eec6e20a8494 100644
>>> --- a/net/hsr/hsr_main.c
>>> +++ b/net/hsr/hsr_main.c
>>> @@ -22,9 +22,13 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
>>>  {
>>>  	struct hsr_port *port;
>>>  
>>> +	rcu_read_lock();
>>>  	hsr_for_each_port(hsr, port)
>>> -		if (port->type != HSR_PT_MASTER)
>>> +		if (port->type != HSR_PT_MASTER) {
>>> +			rcu_read_unlock();
>>>  			return false;
>>> +		}
>>> +	rcu_read_unlock();
>>>  	return true;
>>>  }
>>
>> AFAICS the only caller of this helper is under the RTNL lock
> 
> Thanks, sometimes I not very sure if the caller is under RTNL lock or not.
> Is there a good way to check this?

I'm not aware of any formal way to do this check. I relay on code
inspection.

>>> @@ -134,9 +138,13 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
>>>  {
>>>  	struct hsr_port *port;
>>>  
>>> +	rcu_read_lock();
>>>  	hsr_for_each_port(hsr, port)
>>> -		if (port->type == pt)
>>> +		if (port->type == pt) {
>>> +			rcu_read_unlock();
>>>  			return port;
>>
>> The above is not enough.
>>
>> AFAICS some/most caller are already either under the RTNL lock or the
>> rcu lock.
>>
>> I think it would be better rename the hsr_for_each_port_rtnl() helper to
>> hsr_for_each_port_rcu(), retaining the current semantic, use it here,
>> and fix the caller as needed.
> 
> Do you mean to modify like
> 
>  #define hsr_for_each_port(hsr, port) \
>         list_for_each_entry_rcu((port), &(hsr)->ports, port_list)
> 
> +#define hsr_for_each_port_rcu(hsr, port) \
> +       list_for_each_entry_rcu((port), &(hsr)->ports, port_list, lockdep_rtnl_is_held())
> 
> 
> I'm not sure if the naming is clear. e.g. rcu_dereference_rtnl() also use rtnl
> suffix to check if rtnl is held.

My naming suggestions are usually not that good, feel free to opt for a
better name. The more substantial feedback here is to properly address
the relevant callers.

Thanks,

Paolo


