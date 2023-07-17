Return-Path: <netdev+bounces-18225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA11C755E53
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3160228146B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF819472;
	Mon, 17 Jul 2023 08:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07C4414
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:20:06 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5312D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:20:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fbaef9871cso6513395e87.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 01:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689582003; x=1692174003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRb3R4HhWlnnZ5Vbw44opAtuTE0tiaN9iHoMLE+HdJQ=;
        b=T5EInwOpV9/qioku+l5ZjxE9G1VGEgVMKFfDBEazeLlB4HEQlByQgoW7byvwcxXJvq
         fOZo+8zdHNSW+NBpfkSUg7TKQLM8FqTBIpqctiYLzimBZmoReN/xGfHxTuSviAs1MiJu
         9S4F+q31gk888rYz0b7OX2KcCnLpFel9wQyF4X1nC+dFrmkhCK0Ff8r1G6iCeWZnrkre
         N14HsWO+8wkUOk2ORakkPNXpSwPoPk3A+vjdfwblNf0RKF0elN7NRjMsXR1uZC0PC3nP
         U9gcYYns9qOhj4j+KbSzPyj0vB7DW1nlG/9uHeBCkibbW/gcCeMqdu7N1hAe7qkKzKia
         BVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689582003; x=1692174003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRb3R4HhWlnnZ5Vbw44opAtuTE0tiaN9iHoMLE+HdJQ=;
        b=TyJR6gtnFSTqSQGGFKpylssI4rehzChydsffKzT8ZVxGgGPgemklQBWF+eHHR4riVI
         6OylaYVlMKZwrq10hfwpsUROksrKLv0najg4WpIoPgbrpRzEliLDYnxV/XsKd4yr8viK
         zKzjTCaVRvK1xReDbL0eGlyguHa3bq7KL/49G4R4tFcxOwtalhQ68hd7v2rAtwM65AFk
         y6ngsZNlxPrPlMUbe+o16bjyivEmMI9Bnnkzgq71A9XaMBQtWdD7k8l/U4kuRPVSKZMH
         UpRnzZKI3qM2c+F54VENZ1M6tYJBftkA8UcJQG3inl6BL/QV3ZlT6ekwYsv/FZWWHEb7
         mYKA==
X-Gm-Message-State: ABy/qLaqn2CubDQ/99cw04juqvCsG2QVGCOwfqZ3fOIUstnPg/ezE7Rj
	H0/e3BbzYeopQ+MFfifs1Tvm3A==
X-Google-Smtp-Source: APBJJlFElTkpqsfru0ZEuQACH1Yg9XPhKMAvzdKhjI8Ik7jEMprhhCAhOIg9Riu3Okf15yieclfTcA==
X-Received: by 2002:a05:6512:4018:b0:4fd:ba81:9d43 with SMTP id br24-20020a056512401800b004fdba819d43mr1711468lfb.56.1689582002575;
        Mon, 17 Jul 2023 01:20:02 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s8-20020a7bc388000000b003fb41491670sm7320992wmj.24.2023.07.17.01.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 01:20:02 -0700 (PDT)
Message-ID: <8fa6e3fc-56db-b19d-19c5-250fc5ba92e2@tessares.net>
Date: Mon, 17 Jul 2023 10:19:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: TC: selftests: current timeout (45s) is too low
To: David Laight <David.Laight@ACULAB.COM>,
 Pedro Tammela <pctammela@mojatatu.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev <netdev@vger.kernel.org>, Anders Roxell
 <anders.roxell@linaro.org>, Davide Caratti <dcaratti@redhat.com>
References: <0e061d4a-9a23-9f58-3b35-d8919de332d7@tessares.net>
 <2cf3499b-03dc-4680-91f6-507ba7047b96@mojatatu.com>
 <3acc88b6-a42d-c054-9dae-8aae22348a3e@tessares.net>
 <ca8565fbbd614c8489c38761db2959de@AcuMS.aculab.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ca8565fbbd614c8489c38761db2959de@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David,

On 14/07/2023 17:15, David Laight wrote:
> From: Matthieu Baerts
>> Sent: 12 July 2023 15:43
>>
>> Hi Pedro,
>>
>> On 12/07/2023 15:43, Pedro Tammela wrote:
>>> I have been involved in tdc for a while now, here are my comments.
>>
>> Thank you for your reply!
>>
>>> On 12/07/2023 06:47, Matthieu Baerts wrote:
>>>> Hi Jamal, Cong, Jiri,
>>>>
>>>> When looking for something else [1] in LKFT reports [2], I noticed that
>>>> the TC selftest ended with a timeout error:
>>>>
>>>>    not ok 1 selftests: tc-testing: tdc.sh # TIMEOUT 45 seconds
> ...
>>>> I'm sending this email instead of a patch because I don't know which
>>>> value makes sense. I guess you know how long the tests can take in a
>>>> (very) slow environment and you might want to avoid this timeout error.
>>>
>>> I believe a timeout between 5-10 to minutes should cover the entire suite
>>
>> Thank you for your feedback.
>> If we want to be on the safe side, I guess it is better to put 10
>> minutes or even 15, no?
> 
> Is it possible to use the time taken for an initial test
> to scale the timeout for all the tests?
> 
> Then you could have a 45second timeout on a fast system and
> a much longer timeout on a slow one.

For the selftests global timeout, that would be great but with the
current architecture, it is not possible to do that because the value of
this global timeout is used when starting the different selftests, e.g.

  /usr/bin/timeout --foreground 45 ./tdc.sh

For the per-test timeout used in TC test environment -- currently at 24
seconds -- I guess it could be adapted like that but that's a different
topic.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

