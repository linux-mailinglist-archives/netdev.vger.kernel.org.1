Return-Path: <netdev+bounces-48658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE97EF246
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 13:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F786B20A00
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AC30345;
	Fri, 17 Nov 2023 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="vYIYjoYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77414C4
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:06:49 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c115026985so1952410b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 04:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700222809; x=1700827609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mh9tUJDuns9YEWMfiG7SwEu1WyJUjncM3Z8yl4XlzMU=;
        b=vYIYjoYMBhkJV3wlMbdcXeamqepKwo6Rf/GK2d5aqa16B7/q9ILMimYjUcyepU0nO7
         gjWkhgPY/n9JCI8bTqpAs/grCDmWAFECmW+c9uq3gKZrdz/8jEZJk253kQzx3WFrySrF
         HiFKH7NGCFdm1JMO50iiyjz7tUfe0zcn/NpB5Ot/ATJ9LmxI5pUN8R/2Qmv2fgSNRTiE
         dkzotkf/TG1NamP34jBizrrANtL339RKQ69/TC5Lx0OJ7qPFvf0YOe099RwIYL+AQ8hm
         HmdeHZBEL5yJhxubT+D8sQRuGBJBv6OZIeziQatCL1mgAU0GsA67FYoYKwIjXfhfve+u
         KBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700222809; x=1700827609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh9tUJDuns9YEWMfiG7SwEu1WyJUjncM3Z8yl4XlzMU=;
        b=Dk53GRZgPRS+8Iv5d7+ViBSMUZUMHYJP6YkdQE3ikkWNK7ihinS67KmhjRd19RbsA7
         rVFJIOmw78hAQ5ZmybjMXRVAjomH+9MyEBhL4PtADm/UgovBwya49wbEca+QWzlWiGih
         YwTzS6FXAJwofBDG/48Cgc6wzmUGF2zY78SkO3zJA9TtrIkM0gTHinx0H7fdsThqF2sy
         OMTA77MAhDbBOntXLoiW+SBSujpz/0vDfKZG8eCkr2HQeqCxpAM1mpC7RYT8qUIZOX//
         b0FX2mM02KXsCEhfmuAkmfPRKRHD0/JcPY1YKlJd5RiofQfFRolVuyL5qaDFuwDpwTF2
         XRYw==
X-Gm-Message-State: AOJu0YxvXCPB71V35maybWbuuGOotB2uRe5ZLgCr2vJfuy36k0bownGT
	eB8ZWEyZO9wekE8EJK/Wa8LhvQ==
X-Google-Smtp-Source: AGHT+IGcMjqeBju84wf/mocfA5heReBZ9MgmJcllLMQhA4u/59/yWwb9vhYUxUWorIcfGN41BYbcRw==
X-Received: by 2002:a05:6a20:c901:b0:186:603b:6b6e with SMTP id gx1-20020a056a20c90100b00186603b6b6emr16909248pzb.17.1700222808950;
        Fri, 17 Nov 2023 04:06:48 -0800 (PST)
Received: from ?IPV6:2804:14d:5c5e:44fb:7741:c354:44be:5c3f? ([2804:14d:5c5e:44fb:7741:c354:44be:5c3f])
        by smtp.gmail.com with ESMTPSA id g31-20020a63565f000000b005891f3af36asm1262704pgm.87.2023.11.17.04.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 04:06:48 -0800 (PST)
Message-ID: <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>
Date: Fri, 17 Nov 2023 09:06:45 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Content-Language: en-US
To: Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: kunwu.chan@hotmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231117093110.1842011-1-chentao@kylinos.cn>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20231117093110.1842011-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2023 06:31, Kunwu Chan wrote:
> net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
> net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
> net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol
> 
> Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>   net/sched/cls_api.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 1976bd163986..f73f39f61f66 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
>   		goto errout;
>   	}
>   	tp->classify = tp->ops->classify;
> -	tp->protocol = protocol;
> +	tp->protocol = cpu_to_be16(protocol);
>   	tp->prio = prio;
>   	tp->chain = chain;
>   	spin_lock_init(&tp->lock);
I don't believe there's something to fix here either

