Return-Path: <netdev+bounces-51809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF267FC444
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6208B21456
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397B46BB9;
	Tue, 28 Nov 2023 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="nZ1e3hWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF5D5D
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:29:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso43870345ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701199788; x=1701804588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZSZu9vqBKTyMgpPK9F5e90iSaq9ITcU4aeHCz/CE9I=;
        b=nZ1e3hWR1G3/eRmWZK7A71wPTaAHB0NgLeAlwvrQN2XWEjya7/8NdTwARtRl2OBCCD
         M5n4lHcC3sDuAwnDL+mCpBJsxIGkA+HTAsXWecBB/gyDhjUVEnhPgv2dtJnXS1XXyocS
         ZhniTJR/yzVmfy32KHdJXbO7KDd9jco2onE8YYM/oEtKTnTB+ap9Eu0iyTrW5+iPOcqu
         4yuW+/IQmEQiGI0pI0M6I9JpbZsYmyfdFEJ5Jykq34fWefDn4SEtOodlMicsRHJElv/H
         uVICg9+8dRPH18GI5VBquvZkAGtTJIJnI3u9YLxgsQU4UfYk+NQkYjGjHk++bK8BT58y
         uG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701199788; x=1701804588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZSZu9vqBKTyMgpPK9F5e90iSaq9ITcU4aeHCz/CE9I=;
        b=Ch5T80gx3KDKEeB4RtLEnr+7lwwr7Y7V4yDybouk0aWvLj+52/TvXJe6NigEdGmyF4
         ghzTnGTbXnMtR/ugr8a/QLZElNNBG97AR4wlm9Tq5gReRJSY837FtJI6WPraIphRze4T
         VLHMC49EzcgSaQm49sj/xomUH7XlQjrvpOGKKpAzMIj1+Pxu/gyrQIuUVj6Y65xLiCEK
         TyMhKhQ9EETa3nK6lFUwfipyqRqZLqRFR+1OswpDhz/NDudd5DZzcxS9TXrKLzk4vTbx
         vkCvOFuUoWaFZNONJbRIbQJI8j1EI1ukPGUsq3E80D2Okza3D7dq3TCbAKOrvU/j8X/C
         ft0Q==
X-Gm-Message-State: AOJu0YweTh9+eQ/IChSALh6SYOStprlpmAFU4lHix9qvPCOcDcECwOR7
	/Az25j4hhgVBZgyJWHkGL2xgfQ==
X-Google-Smtp-Source: AGHT+IFTu4pj2114gavAvtVZdG3ViMDTwwQmS5ZBLvqvV2H6GMR66pFqlbbvPsB+TvpqlmiNBEcCJg==
X-Received: by 2002:a17:903:643:b0:1cc:4ff3:c837 with SMTP id kh3-20020a170903064300b001cc4ff3c837mr14070867plb.68.1701199787902;
        Tue, 28 Nov 2023 11:29:47 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b001cf5d1c85cdsm10879997plb.218.2023.11.28.11.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 11:29:47 -0800 (PST)
Message-ID: <8abf0098-b318-4ce9-88eb-c745ea5090fb@mojatatu.com>
Date: Tue, 28 Nov 2023 16:29:43 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 3/4] net/sched: act_api: stop loop over ops
 array on NULL in tcf_action_init
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, vladbu@nvidia.com
References: <20231128160631.663351-1-pctammela@mojatatu.com>
 <20231128160631.663351-4-pctammela@mojatatu.com>
 <CALnP8Zbh1Jep5daNKZhBAKBZ3Y1R2MZgzapa1r=9ZmKhei1Qcg@mail.gmail.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CALnP8Zbh1Jep5daNKZhBAKBZ3Y1R2MZgzapa1r=9ZmKhei1Qcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2023 16:11, Marcelo Ricardo Leitner wrote:
> On Tue, Nov 28, 2023 at 01:06:30PM -0300, Pedro Tammela wrote:
>> @@ -1510,10 +1510,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
>>   err:
>>   	tcf_action_destroy(actions, flags & TCA_ACT_FLAGS_BIND);
>>   err_mod:
>> -	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
>> -		if (ops[i])
>> -			module_put(ops[i]->owner);
>> -	}
>> +	for (i = 0; i < TCA_ACT_MAX_PRIO && ops[i]; i++)
>> +		module_put(ops[i]->owner);
>>   	return err;
> 
> I was going to say:
> Maybe it's time for a helper macro for this.
> 
> $ git grep TCA_ACT_MAX_PRIO
> include/net/pkt_cls.h:  for (i = 0; i < TCA_ACT_MAX_PRIO && ((a) =
> (exts)->actions[i]); i++)
> include/net/pkt_cls.h:  for (i = 0; i < TCA_ACT_MAX_PRIO && ((a) =
> actions[i]); i++)
> ...
> net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
> net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
> net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
> net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
> ...
> net/sched/act_api.c:    for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
> net/sched/act_api.c:    for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
> net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
> net/sched/act_api.c:    for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
> ...
> 
> But then, that's exactly what the first 2 hits are :)
> So AFAICT this loop can be written as:
> 
> struct struct tc_action_ops *op;
> tcf_act_for_each_action(i, op, ops)
> 	module_put(op->owner);
> 
> Thoughts? It would be iterating over struct tc_action_ops and not
> tc_action, as in tcf_act_for_each_action() (which is the only user of
> this macro today), but that seems okay.
> 
>    Marcelo
> 

Interesting, I didn't even notice those macros.
I believe it helps with code maintainability.

Do note, I saw a place that the action array is expected to be not 
contiguous. So any sed-like replacement must be done with care.

When we know for sure it's contiguous, I'm all in for macros!



