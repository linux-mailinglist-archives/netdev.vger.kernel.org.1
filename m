Return-Path: <netdev+bounces-49277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D094D7F1761
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A125282731
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52A81D6BD;
	Mon, 20 Nov 2023 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="aZdT4nG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7F7BE
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 07:33:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso3591092b3a.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700494410; x=1701099210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/vkPNph5u5OOrRSn6FR5rf84/Y5x7U2iw601QDwn1w=;
        b=aZdT4nG3nvtH4hK5HbpH/8dFyeH4vzz7mKT3IuUwrCXWFtDxiZq25X/8UNdVxq2ZM1
         aDTsbkN4J3U00zRJwKv4akimkV6+37zdwvANSSGDyNsjUupOdT9FZyJqqk9C/DNAuC/W
         7UODD+2NpIS3ifS1e0Qh+tlPENT28R0QXknGwMAx3BbC60M1fBoGKLt5WAOgTK3jPRDx
         d2Qcpz2zg8EVd/tQR0CO93BtJrqO1laIzOEuxlIs775FzSQ0afBB9hWAEbTyR1p8x8K0
         nhIaqyybEMNJ+YnF5/kqtJlXxTArpSR7Xaeq4WRyS+jOR05e7+/TL+AlvKIzs8l8vTsC
         +qLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700494410; x=1701099210;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/vkPNph5u5OOrRSn6FR5rf84/Y5x7U2iw601QDwn1w=;
        b=pYW1+UbT5LEUtUxLGKUHn44Yx6t04/TC/c6D060gZ7edlIsBN3rHt5TJ6mDFyE+O0B
         Rw5A68AIj+RBDpZqhTIved5K0W5IH0BKCcHqm/m/aKMnQuQqmIxww6RbMnLoOK/ZzXe3
         P1ham63XgP/9jzYjGCmmTcs01lSEl5J39fXMj+Dt4Ed8ifildDIaZ/Q+w0Fs8gu6RQQ4
         ozVbKlY1QRYlYr8ooEg8leSEeoLXm/vEiuSgA0RJ77G4rve4hLTiLfgtYSh3IpBBhv5L
         SFoX+ai+kuDFLsAj0lFNUqJq2SqdyCAsS1ZbNjaGaoHPqKPPHyGnkgn1eS7beeCFrFD+
         zVBQ==
X-Gm-Message-State: AOJu0Yw1TV63A22X/HmsVlMBoVhHmNiVr0CuTNsRUXVMNdop3ZxV2s8b
	ss54EArz7xYQ1+TJfdIL1SGwbA==
X-Google-Smtp-Source: AGHT+IEaOg3mR+ohRZuseHeSMp/v9lZVJmrM5ClJ/D9paZFo3jQd/TqgotiBGO5yQ4v6OMwgefFCIA==
X-Received: by 2002:a05:6a20:8e10:b0:187:f6b3:3ca5 with SMTP id y16-20020a056a208e1000b00187f6b33ca5mr6106464pzj.52.1700494407205;
        Mon, 20 Nov 2023 07:33:27 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b006cbb3512266sm1195791pfo.1.2023.11.20.07.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 07:33:26 -0800 (PST)
Message-ID: <5e9c5ecb-c3c7-4e5f-ae9e-ff688f4c2e2f@mojatatu.com>
Date: Mon, 20 Nov 2023 12:33:21 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
To: Simon Horman <horms@kernel.org>
Cc: Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kunwu.chan@hotmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231117093110.1842011-1-chentao@kylinos.cn>
 <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>
 <20231120100417.GM186930@vergenet.net>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231120100417.GM186930@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2023 07:04, Simon Horman wrote:
> On Fri, Nov 17, 2023 at 09:06:45AM -0300, Pedro Tammela wrote:
>> On 17/11/2023 06:31, Kunwu Chan wrote:
>>> net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
>>> net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
>>> net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol
>>>
>>> Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> ---
>>>    net/sched/cls_api.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
>>> index 1976bd163986..f73f39f61f66 100644
>>> --- a/net/sched/cls_api.c
>>> +++ b/net/sched/cls_api.c
>>> @@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
>>>    		goto errout;
>>>    	}
>>>    	tp->classify = tp->ops->classify;
>>> -	tp->protocol = protocol;
>>> +	tp->protocol = cpu_to_be16(protocol);
>>>    	tp->prio = prio;
>>>    	tp->chain = chain;
>>>    	spin_lock_init(&tp->lock);
>> I don't believe there's something to fix here either
> 
> Hi Pedro and Kunwu,
> 
> I suspect that updating the byte order of protocol isn't correct
> here - else I'd assume we would have seen a user-visible bug on
> little-endian systems buy now.
> 
> But nonetheless I think there is a problem, which is that the appropriate
> types aren't being used, which means the tooling isn't helping us wrt any
> bugs that might subsequently be added or already lurking. So I think an
> appropriate question is, what is the endien and width of protocol, and how
> can we use an appropriate type throughout the call-path?

Agreed and I'm all in for improving any tooling integration.
I believe a better patch would be to have protocol as a be16 since it's 
creation everywhere. I looked quickly and it will be a "viral" change, 
meaning a couple of places will require a one line change.

