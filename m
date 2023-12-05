Return-Path: <netdev+bounces-54019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A08059F2
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017A91F2159F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDCD675B1;
	Tue,  5 Dec 2023 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="azyA7A7R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD28C3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:28:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d06d4d685aso19966125ad.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701793682; x=1702398482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sE5yWCGwWzGkKU3Lzed5KPrdiD+mjsaQqvyJhkisET4=;
        b=azyA7A7RFaVeg3M1+/H+wS7frL6/9cxyp6hT9QcF8131cW9tdvjJat/+mQmMyeqliW
         oGa3nLwDjLQG47Bf/SEFSjjxI/d25+JtyCBBQuhK6LKbl18hroGotL5B/1J714SsCeXi
         LpffZ5CyD6nxu0dUefsy4jGX3dDfyWYJQocV9MVklhnOMTyhJrDLukYDS9gqepbwLCqH
         L29sXfIvi380fCKRJAAq6izlSv3TlrhZryVgOfIjFxmPLXOJnEPYxVlQpYkQMzv2B2EA
         YHpq5HaGy5EE9VL3lL4Fgen4bPDLETVmfGsNkWru8TvT7jnDSnZpEKMcwk5yitQ6ugHk
         mEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793682; x=1702398482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sE5yWCGwWzGkKU3Lzed5KPrdiD+mjsaQqvyJhkisET4=;
        b=myHNs69jneZ/zv/FR5xCxFi6lrn291H73JO6XGCv7ZjBafxKWu9nppJEJKXBIwmTE4
         Y6YK6TYTjl4GjVio8Vm4oBvee+g6abuXs/PvgMHrWn1EQGqcK0O4/Ok3mB4sI8e2BjS0
         B8HMAyHIN4+w+zHqiLq9CoECrQLDNwsAoolkE7M0Qev0dv7Mb8iVXr5Yh7mE1eGzO/fu
         GvUfyZMTPVqtXt7CqrAjCEPgcdiS13zo8UkjwA+g1ASZI6LtmPP29qaSWwCyleNEPj0M
         O0poYyi0gJmAzMfxYY1Sy8CdR+0sFY6AKykcC4Qzhky6YbvyWLK44E5dzKhxyxetIniB
         dHLA==
X-Gm-Message-State: AOJu0YysjJCR/I+papov9snyqat+syOKhQn+Bjs36IkPKFKjfCkzLzqq
	z3BHC9YoxtVPMdsMF4hHc6rd2g==
X-Google-Smtp-Source: AGHT+IHQkcZI61BYx5Isxo8pZcdqVL5JAPvc5QiqMnPD34Np4jMtAj4vHHAAJ16WibMU6QX0xlBtmw==
X-Received: by 2002:a17:902:6a82:b0:1d0:6ffd:f231 with SMTP id n2-20020a1709026a8200b001d06ffdf231mr3663192plk.135.1701793682278;
        Tue, 05 Dec 2023 08:28:02 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:638:b3b3:3480:1b98:451d? ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id jk19-20020a170903331300b001cf570b10dasm8745364plb.65.2023.12.05.08.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:28:01 -0800 (PST)
Message-ID: <30bc72f5-b21b-4846-b97b-1251b3dc3d4c@mojatatu.com>
Date: Tue, 5 Dec 2023 13:27:56 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: sched: Move drop_reason to struct
 tc_skb_cb
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>,
 Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231201230011.2925305-1-victor@mojatatu.com>
 <20231201230011.2925305-2-victor@mojatatu.com>
 <7315d962-0911-81b9-7e60-452ab71e3193@iogearbox.net>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <7315d962-0911-81b9-7e60-452ab71e3193@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2023 08:06, Daniel Borkmann wrote:
>> [...]
>> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
>> index dcb9160e6467..c499b56bb215 100644
>> --- a/include/net/sch_generic.h
>> +++ b/include/net/sch_generic.h
>> @@ -332,7 +332,6 @@ struct tcf_result {
>>           };
>>           const struct tcf_proto *goto_tp;
>>       };
>> -    enum skb_drop_reason        drop_reason;
>>   };
>>   struct tcf_chain;
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 3950ced396b5..323496ca0dc3 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3924,14 +3924,15 @@ static int tc_run(struct tcx_entry *entry, 
>> struct sk_buff *skb,
>>       tc_skb_cb(skb)->mru = 0;
>>       tc_skb_cb(skb)->post_ct = false;
>> -    res.drop_reason = *drop_reason;
>> +    tc_skb_cb(skb)->post_ct = false;
> 
> Why the double assignment ?

Sigh, sorry will change that in v3.

> 
>> +    tcf_set_drop_reason(skb, *drop_reason);
>>       mini_qdisc_bstats_cpu_update(miniq, skb);
>>       ret = tcf_classify(skb, miniq->block, miniq->filter_list, &res, 
>> false);
>>       /* Only tcf related quirks below. */
>>       switch (ret) {
>>       case TC_ACT_SHOT:
>> -        *drop_reason = res.drop_reason;
>> +        *drop_reason = tc_skb_cb_drop_reason(skb);
> 
> nit: I'd rename into tcf_get_drop_reason() so it aligns with the 
> tcf_set_drop_reason().
> It's weird to name the getter tc_skb_cb_drop_reason() instead.

Seems more consistent, will do.

>> [...]


