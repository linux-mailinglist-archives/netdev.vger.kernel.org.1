Return-Path: <netdev+bounces-86898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAE8A0B84
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9191F23E5D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9F140E4D;
	Thu, 11 Apr 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDO/3ydW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF7146580
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824847; cv=none; b=HJg2FKGvWAtRxnvU5Bs+WIi6CHU7jy7fr3QO5KvBphxEq2b+qiTUmWFU5Gtmi+KRMLBZLSSPhLYJflJaDpDURMdulxOZj8ubZs4JeGi4Oo+HSs/qAuVfZ5fxadGW5ywPdh5CgTwsLZLcgaefJOACgvnqLM+c2QOQm/jKtAoqd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824847; c=relaxed/simple;
	bh=B+VF28LElyVXjSF9s9JC3CN1oNv+pqtMajGePgG8g+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1AyrSvDxVIG04dfTCp02sZHnLZ7MjRcyHwCY/ZA84n1MiYTheiQz1af0hnkGISKHWzVXavkzS5HhIu0Y1b38yAYkllta5IseyIbSpMoFXaubjVwKleHQXu6VQ4a9qQ1hBF1dksJoOeDyEcidtR/8xInefjvvB2B5StVMk9WPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDO/3ydW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712824844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dv5Ohywvy1I2nmhgw8EY13mWxNghz3ewc49BSL3eRN4=;
	b=KDO/3ydWbA+DtTQAFSYD1NjUlxE4Xl713n5yD9TjFaePcmZGK8VL9KrZSc//SL03TycrC1
	gqoe88JpKLN8bLPhRKqVU8KGDTEBulYjPYQetCBefNbLcs7sV0f9yzph1LgSB6KHU4TXQs
	jWY1IqzhmxmoLPU6XHcDDtFpYMGpM1o=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-PVtBI2o8NNmnLCqATJ5YVw-1; Thu, 11 Apr 2024 04:40:43 -0400
X-MC-Unique: PVtBI2o8NNmnLCqATJ5YVw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dbf618042daso11592961276.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 01:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712824843; x=1713429643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv5Ohywvy1I2nmhgw8EY13mWxNghz3ewc49BSL3eRN4=;
        b=hhNntWYejdsFYqLVmrOPaZqwChVlug3wdsz5t8vQIlS76qwsH7pIJ3c9/gNfB2irM8
         2oktKwYV3KD7xE0pjT3QDdVBW4PuSl4WpX72WIQOKdRKu3G22Q6j4fBTSynxRC3Fw9Rq
         mgPpA3oHktCvXrrmP0vB57izIHrxywBy4RpZd7A4vir24Huj1CnptQ9+d13OwG4/igAa
         PUm1X5Jww1MBCU/vBaqE77kjLD1yvW9E/IKaXfMSxNp7HT2rVvTu4e530iN06Lroh7Fo
         mm1SLMVTydkTZLxMySldODLnjBu6a3Y08u7PKzgtzq4TOzwYUJjO1rNGntNFpi1lag8n
         2eyA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ydyIaDczFaeqg878rP16tGp5JDxST6Fmo6BA8Dtd2LTF3ewKtTR51l7QPNkFlZq15nGbazXwNPr7AjTQcVsR4Ecm2AGn
X-Gm-Message-State: AOJu0YwThsT/hVwPVlEepUFBzZMLACDHEIm4FGqabGabbmk4pZOE7gqx
	QOTJKTLOqq95zZFjsqMJGQYvXyoLuDkElDQ5f+X0780UHcN3kc/AzsUEJfrBJ1wAp1ASmyIBYig
	ikgylw/uRQXA7QjmGaptUoPWpSROaIpze+sJ56YV26nBPzVRsrbr6xw==
X-Received: by 2002:a5b:64c:0:b0:de0:f737:95f with SMTP id o12-20020a5b064c000000b00de0f737095fmr5212470ybq.7.1712824842767;
        Thu, 11 Apr 2024 01:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEJ8azt0ZUSyt7QN4xSouIH9VAnCCenu7rftY+z7pS9/P86L+1g4I766ebZ0entVbi5NAtBA==
X-Received: by 2002:a5b:64c:0:b0:de0:f737:95f with SMTP id o12-20020a5b064c000000b00de0f737095fmr5212460ybq.7.1712824842458;
        Thu, 11 Apr 2024 01:40:42 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.208.51])
        by smtp.gmail.com with ESMTPSA id df10-20020a056214080a00b0069b1e63a79esm663822qvb.61.2024.04.11.01.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 01:40:42 -0700 (PDT)
Message-ID: <8588456f-29ac-49ae-9507-a5523a080b09@redhat.com>
Date: Thu, 11 Apr 2024 10:40:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v2 4/5] net:sched:act_sample: add action cookie to
 sample
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, cmi@nvidia.com,
 yotam.gi@gmail.com, aconole@redhat.com, echaudro@redhat.com, horms@kernel.org
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-5-amorenoz@redhat.com>
 <56e764b2-1f0b-4785-aba7-d1dbb34e65e8@ovn.org>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <56e764b2-1f0b-4785-aba7-d1dbb34e65e8@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/24 15:20, Ilya Maximets wrote:
> [copying my previous reply since this version actually has netdev@ in Cc]
> 
> On 4/8/24 14:57, Adrian Moreno wrote:
>> If the action has a user_cookie, pass it along to the sample so it can
>> be easily identified.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>   net/sched/act_sample.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
> 
> Nit: some spaces in the subject would be nice.
> 
>>
>> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
>> index a69b53d54039..5c3f86ec964a 100644
>> --- a/net/sched/act_sample.c
>> +++ b/net/sched/act_sample.c
>> @@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
>>   				     const struct tc_action *a,
>>   				     struct tcf_result *res)
>>   {
>> +	u8 cookie_data[TC_COOKIE_MAX_SIZE] = {};
>>   	struct tcf_sample *s = to_sample(a);
>>   	struct psample_group *psample_group;
>>   	struct psample_metadata md = {};
>> +	struct tc_cookie *user_cookie;
>>   	int retval;
>>   
>>   	tcf_lastuse_update(&s->tcf_tm);
>> @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
>>   		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
>>   			skb_push(skb, skb->mac_len);
>>   
>> +		rcu_read_lock();
>> +		user_cookie = rcu_dereference(a->user_cookie);
>> +		if (user_cookie) {
>> +			memcpy(cookie_data, user_cookie->data,
>> +			       user_cookie->len);
>> +			md.user_cookie = cookie_data;
>> +			md.user_cookie_len = user_cookie->len;
>> +		}
>> +		rcu_read_unlock();
> 
> Not sure what is better - extending rcu critical section
> beyond psample_sample_packet() or copying the cookie...
> What do you think?

Ha! I also scratched my head on this one.

I tried to follow all the possible paths and, as far as I could tell, there is 
no explicit sleeping involved. However, there is a call to yield() towards the 
end of netlink_broadcast_filtered() that made me think it's safer to copy the 
cookie which, in this particular case, is fairly limited in size.

Have I missed something?

> 
>> +
>>   		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
>>   		psample_sample_packet(psample_group, skb, s->rate, &md);
>>   
> 


