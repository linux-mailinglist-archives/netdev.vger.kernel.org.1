Return-Path: <netdev+bounces-55453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26580AE95
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB27B209DD
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 21:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C857304;
	Fri,  8 Dec 2023 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="c3aNGGHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93512171E
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 13:07:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2866af9d73bso2147796a91.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 13:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702069669; x=1702674469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkww7Rb4By/r0gHmDvfwdRw28Shse632C6kaDJ7nwkc=;
        b=c3aNGGHQ1WpS6IGRH/2xeGQm0apdEfSe4mcg4J77buR8TrIAo8Igu+xEEyefIj5dNN
         HNPbudgyNwHirog/Z1FF36hfqIYbtUnw17GD65nUaKE9HCrmueINoAgkjd+fC2qGH7Ki
         8BlzWPXlIM9K1GFNDYBUvGwTApi/QjhE5xlIH9ZPvGoQZyjBqO3VlDG7rfpspPxjNIZ8
         yJcxlAkEP6U+weNxnO/QnfEfKG6yfQ0k3OSaOwTDpkvoAOBFRa+/fMndb3WXr5+q5G6D
         O8yHziU9WVlq6mCwhZ/ICBmVdUseWiM+0gLzEmqDuSM6HFEGaXGeSlji2ExQl8BwnzD3
         N7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069669; x=1702674469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkww7Rb4By/r0gHmDvfwdRw28Shse632C6kaDJ7nwkc=;
        b=J+ibllC/op6507j/1cWNWnm73PAqSfcB9rrugzi36NPs4uD+IItRvF4IGv/xVffhYl
         uk8CvBvAtJ3+/Oec6nZD19i1sH0GjLtWNO5789JbORsJQUQQ4BH3PMHxoEfXbyh9yhES
         dsACllBNMQXTAAjUBk9ajSG2bZnxm0Ywp3q1EC9PJ+KS8rwwpCz/pOQyskieN9KwIIlt
         IfcMF0yaNegwefK90SFXPjZpZas7FA5zbpuDDHIuVDqI2m2xzPweJ26xSpbvzUuKQj1c
         hD2I/rHzW7Wfmsyv1teST8Wn32A4lCM/+t+mj52Bi1/VyKgITBc0HluEq++94PJ76KEJ
         UNZg==
X-Gm-Message-State: AOJu0Yypj+eNtublgBfud93XbS70GFGkn9Ek4Vaii3NWJ8mlDwsOL+1C
	bcUb+gL64tFeMadgH5hhPg/ktA==
X-Google-Smtp-Source: AGHT+IENOucjxXbUsinVAE0/qAj5nUmvcYq2J7wYk7AkZM9ubL8h/3QLHpgdHwOog2J918vS8VNhsw==
X-Received: by 2002:a17:90a:b395:b0:286:6cc1:8677 with SMTP id e21-20020a17090ab39500b002866cc18677mr640901pjr.92.1702069669022;
        Fri, 08 Dec 2023 13:07:49 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b00286e0c91d73sm2289167pjb.55.2023.12.08.13.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 13:07:48 -0800 (PST)
Message-ID: <540b2a79-d10e-49a5-8567-2b1b5616ecb8@mojatatu.com>
Date: Fri, 8 Dec 2023 18:07:43 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/sched: act_api: rely on rcu in
 tcf_idr_check_alloc
Content-Language: en-US
To: Vlad Buslov <vladbu@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, marcelo.leitner@gmail.com
References: <20231205153012.484687-1-pctammela@mojatatu.com>
 <20231205153012.484687-2-pctammela@mojatatu.com> <87jzpso53a.fsf@nvidia.com>
 <77b8d1d8-4ad9-49c7-9c42-612e9de29881@mojatatu.com>
 <87fs0fodmu.fsf@nvidia.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <87fs0fodmu.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2023 06:52, Vlad Buslov wrote:
>> Ok, so if I'm binding and it's observed a free index, which means "try to
>> allocate" and I get a ENOSPC after jumping to new, try again but this time
>> binding into the allocated action.
>>
>> In this scenario when we come back to 'again' we will wait until -EBUSY is
>> replaced with the real pointer. Seems like a big enough window that any race for
>> allocating from binding would most probably end up in this contention loop.
>>
>> However I think when we have these two retry mechanisms there's a extremely
>> small window for an infinite loop if an action delete is timed just right, in
>> between the action pointer is found and when we grab the tcfa_refcnt.
>>
>> 	idr_find (pointer)
>> 	tcfa_refcnt (0)  <-------|
>> 	again:                   |
>> 	idr_find (free index!)   |
>> 	new:                     |
>> 	idr_alloc_u32 (ENOSPC)   |
>> 	again:                   |
>> 	idr_find (EBUSY)         |
>> 	again:                   |
>> 	idr_find (pointer)       |
>> 	<evil delete happens>    |
>> 	------->>>>--------------|
> 
> I'm not sure I'm following. Why would this sequence cause infinite loop?
> 

Perhaps I was being overly paranoid. Taking a look again it seems that 
not only an evil delete but also EBUSY must be in the action idr for a 
long time. I see it now, it looks like it converges.

I was wondering if instead of looping in 'again:' in either scenarios 
you presented, what if we return -EAGAIN and let the filter 
infrastructure retry it under rtnl_lock()? At least will give enough 
breathing room for a call to schedule() to kick in if needed.

