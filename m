Return-Path: <netdev+bounces-54172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70C8062D8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 00:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65676282133
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF055405FF;
	Tue,  5 Dec 2023 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="DU7BD5ua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A7B122
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 15:19:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cb749044a2so6584013b3a.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 15:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701818357; x=1702423157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PiiCZDL3T3NJUQFGM2BFRFn7osZL9WwIGkFqGwYXOY=;
        b=DU7BD5ua4pCnKBc7AAfh0i6QtZok1Wk6MotacKmYFdbJ/XHo4bM26tfEZdOjb8NZH6
         znySvXUAdZpy8DLQ9Ea7+TClVAhTVWvnfg776SdBiMNSZ0i8sQbiHjJNkHcGbsA1NqWv
         TGV2kR6R8nGF1mggSELYyIT+mcYv2P15vozkrYkwBBpAY1+24/tUKUoyC+afcGAzBd3z
         PFYn/8vUTdHTAgT4kxQP+5ToNzSTXKOdA5qDIImqVTEb7E9TWt+RGZkoiezAJvoilAQ6
         c2Cmih2GvcUxpGaH5j8umTV+NGF0ZsDdDi/KAmBUh5SHU0747Fkf4+7KvOofxxHl9gEV
         tmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701818357; x=1702423157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PiiCZDL3T3NJUQFGM2BFRFn7osZL9WwIGkFqGwYXOY=;
        b=YsIZHXDDwHISwZBeEDnql6BbE0SnYZ17M8GaplM7fWnj843FA/ikjHI0BOYTsPj11V
         3fRot3GbAskLRz4aDF+A44qkP7pnsNNmQ28I9CX8oHamNq8cNbHjuO9ztA1NrRl56dqM
         hWqd+iX4kzpwO1iyRs0DD4EtHz3iRcRAOloEzTXf3IyPafaWwehIkxwN2EIaPS3PAdVs
         WVu6tH+bnljcJXibGGls9yvuxy8l4Ed44eMoGF7pjpT0VulMkG0vr1dWlaeiqVu06bHf
         KetZMZplcQd6ThzyLoxtfsWDTpXbCLxWoSq0fcZTxKouyr9bzVQesi6EwEq78DxLYD/a
         lEHA==
X-Gm-Message-State: AOJu0YzHiniDngFWtDguJL9PVUWovRyyD+bdKdBDdeJFF5gj5yVlDShF
	OrEmoHPb2PLFK56zQKsLCqKQpw==
X-Google-Smtp-Source: AGHT+IEo8/BvNNq/jTPN2E3w98m5NEfIdtK2I1CwU4UYFZ49lPcvwGHCYPkb39u85f1xlHKJvU3qVA==
X-Received: by 2002:a05:6a20:4407:b0:18f:97c:8a33 with SMTP id ce7-20020a056a20440700b0018f097c8a33mr10161402pzb.94.1701818356952;
        Tue, 05 Dec 2023 15:19:16 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:638:b3b3:3480:1b98:451d? ([2804:7f1:e2c0:638:b3b3:3480:1b98:451d])
        by smtp.gmail.com with ESMTPSA id y31-20020a056a00181f00b0068ff267f094sm9812258pfa.158.2023.12.05.15.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 15:19:15 -0800 (PST)
Message-ID: <69d540ad-c855-49bc-a904-824e57e33adc@mojatatu.com>
Date: Tue, 5 Dec 2023 20:19:11 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: sched: Add initial TC error skb drop
 reasons
Content-Language: en-US
To: Dave Taht <dave.taht@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231201230011.2925305-1-victor@mojatatu.com>
 <20231201230011.2925305-4-victor@mojatatu.com>
 <CAA93jw520FBOfmhpOBNyfFPy1UKbjOdc52=0L8uzADUKQyeLHQ@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAA93jw520FBOfmhpOBNyfFPy1UKbjOdc52=0L8uzADUKQyeLHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2023 19:28, Dave Taht wrote:
> On Fri, Dec 1, 2023 at 6:00 PM Victor Nogueira <victor@mojatatu.com> wrote:
>>
>> Continue expanding Daniel's patch by adding new skb drop reasons that
>> are idiosyncratic to TC.
>>
>> More specifically:
>>
>> - SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up using
>>    ext, but was not found.
>>
>> - SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was looked up using cookie
>>    and either was not found or different from expected.
>>
>> - SKB_DROP_REASON_TC_CHAIN_NOTFOUND: tc chain lookup failed.
>>
>> - SKB_DROP_REASON_TC_RECLASSIFY_LOOP: tc exceeded max reclassify loop
>>    iterations
>>
>> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>> ---
>>
>> [...]
> 
> I have been meaning to get around to adding
> QDISC_DROP_REASON_{CONGEST,OVERFLOW,FLOOD,SPIKE} to
> cake/fq_codel/red/etc for some time now. Would this be the right
> facility to leverage (or something more direct?) I discussed the why
> at netdevconf:

> 
> https://docs.google.com/document/d/1tTYBPeaRdCO9AGTGQCpoiuLORQzN_bG3TAkEolJPh28/edit

Yes, I think here will be the place to add these new drop reasons.
After this patch lands, we will add more, but feel free to also
propose others.

cheers,
Victor


