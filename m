Return-Path: <netdev+bounces-54020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2EF8059F5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9347281D6C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F46675B1;
	Tue,  5 Dec 2023 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wkCR9zua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD9122
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:28:24 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d075392ff6so25181055ad.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701793704; x=1702398504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4XVJ7C72jHCQjhG0OukDWdFA1Gk9Oaij5y1yi9zKns=;
        b=wkCR9zuacvO6QQ651kC/hARNFYMfFpw/VwM8bNPaQuKgQQwpR+sDH1BQY4ZZDk1Uc4
         wUnTR803z+iOIFewU95Or0pywtBZqCktuJN2gdEp6fE16+jxmVyG3GkuyksJR5rvFxki
         KW/YQI3jWGWVZbzKE0ZQ610PIIoHSY12iG93ali+bv9PienhQKJzUV/A1KYynTMObjLv
         L0fKUOQEyfpoJI74wXPxPbMi7aoStVDJMnpJx7l02jZOfA6i5EsGIoO8G6ynKWCLI4/G
         QCt4otiGJVFxnI39w+9RUNwUYtnsnEn74pM+3IPLv9I5vSUfE0Di0iyGlxFTEzvqztlP
         Ekbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793704; x=1702398504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4XVJ7C72jHCQjhG0OukDWdFA1Gk9Oaij5y1yi9zKns=;
        b=MNeKN2YRj2qbhgGhDTrIVJMdR4pFlbTw8J+v2mC82pZRU7SFckuByxyKeHjH+MsWMA
         KEZ0zpvoIVmDlqSE9fUEhjqZUFE2rteb98c5MhTSfA9W5po654jWPshC3jiLqJMWDNiJ
         f4EijoG87lFiWbfmBjy5ShpoFSQcKNqhuzO5ogJfhzp2ERaPfJDF9VavUAOg35HGuwKU
         1UGSY2/5/dnWpt2N8zsEsn9GGV7MMjXbl5JDc6y/ESev3r2r6P+zaAR/szyse8CvqsFA
         0kx0br8Ci/LUobR0GWNZgaYGNQkaljl4HX77QPCz+Ah8g7Ad/XXmP5JMbh5/4qeoG7JW
         BkXw==
X-Gm-Message-State: AOJu0YzCK1Ojdvi6Bb0cHSlP7Xcy4dokcR5a+jjGE/sPh1Tqpzsatbl6
	yEwGQy+1sepu0xiGbTqLgDIbow==
X-Google-Smtp-Source: AGHT+IGjfDAQa/bvoQsZrLUHMM/vrpPFW4bHqxSDsn8N4P6C5Pxs8KrxSKXyND1fgFFBbRt9oRUYBQ==
X-Received: by 2002:a17:902:ee44:b0:1d0:700b:3f6a with SMTP id 4-20020a170902ee4400b001d0700b3f6amr1865194plo.36.1701793704021;
        Tue, 05 Dec 2023 08:28:24 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:638:b3b3:3480:1b98:451d? ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id jk19-20020a170903331300b001cf570b10dasm8745364plb.65.2023.12.05.08.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 08:28:23 -0800 (PST)
Message-ID: <e72df462-3c21-4b57-b7b0-7b71597b97a7@mojatatu.com>
Date: Tue, 5 Dec 2023 13:28:19 -0300
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
To: Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231201230011.2925305-1-victor@mojatatu.com>
 <20231201230011.2925305-2-victor@mojatatu.com>
 <7315d962-0911-81b9-7e60-452ab71e3193@iogearbox.net>
 <f0401a8cf451194733457fcedb5c44c9b0c96731.camel@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <f0401a8cf451194733457fcedb5c44c9b0c96731.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2023 08:32, Paolo Abeni wrote:
> On Tue, 2023-12-05 at 12:06 +0100, Daniel Borkmann wrote:
>> On 12/2/23 12:00 AM, Victor Nogueira wrote:
>>> Move drop_reason from struct tcf_result to skb cb - more specifically to
>>> struct tc_skb_cb. With that, we'll be able to also set the drop reason for
>>> the remaining qdiscs (aside from clsact) that do not have access to
>>> tcf_result when time comes to set the skb drop reason.
>>>
>>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>>> ---
>>>    include/net/pkt_cls.h     | 14 ++++++++++++--
>>>    include/net/pkt_sched.h   |  1 +
>>>    include/net/sch_generic.h |  1 -
>>>    net/core/dev.c            |  5 +++--
>>>    net/sched/act_api.c       |  2 +-
>>>    net/sched/cls_api.c       | 23 ++++++++---------------
>>>    6 files changed, 25 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
>>> index a76c9171db0e..7bd7ea511100 100644
>>> --- a/include/net/pkt_cls.h
>>> +++ b/include/net/pkt_cls.h
>>> @@ -154,10 +154,20 @@ __cls_set_class(unsigned long *clp, unsigned long cl)
>>>    	return xchg(clp, cl);
>>>    }
>>>    
>>> -static inline void tcf_set_drop_reason(struct tcf_result *res,
>>> +struct tc_skb_cb;
>>> +
>>> +static inline struct tc_skb_cb *tc_skb_cb(const struct sk_buff *skb);
>>> +
>>> +static inline enum skb_drop_reason
>>> +tc_skb_cb_drop_reason(const struct sk_buff *skb)
>>> +{
>>> +	return tc_skb_cb(skb)->drop_reason;
>>> +}
>>> +
>>> +static inline void tcf_set_drop_reason(const struct sk_buff *skb,
>>>    				       enum skb_drop_reason reason)
>>>    {
>>> -	res->drop_reason = reason;
>>> +	tc_skb_cb(skb)->drop_reason = reason;
>>>    }
>>>    
>>>    static inline void
>>> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
>>> index 9fa1d0794dfa..f09bfa1efed0 100644
>>> --- a/include/net/pkt_sched.h
>>> +++ b/include/net/pkt_sched.h
>>> @@ -277,6 +277,7 @@ static inline void skb_txtime_consumed(struct sk_buff *skb)
>>>    
>>>    struct tc_skb_cb {
>>>    	struct qdisc_skb_cb qdisc_cb;
>>> +	u32 drop_reason;
>>>    
>>>    	u16 mru;
>>
>> Probably also makes sense to reorder zone below mru.
> 
> Or move 'zone' here. It's very minor but I would prefer the latter ;)
> (and leave the hole at the end of the struct)

Yes, this looks better.
Thank you, I'll proceed this way.


