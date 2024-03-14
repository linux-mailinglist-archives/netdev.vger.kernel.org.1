Return-Path: <netdev+bounces-79896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC887BF44
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBEE1C2104C
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124C70CDC;
	Thu, 14 Mar 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fO78BxL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E370CC5
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427643; cv=none; b=OjVlkCIWWw2g1wuT/NC3EbnC2YyEEJo2J9wISRKg9XU6QujnQD0lZTMgIgxhm30So6+oicgAqh12UICrKxZDCPKsbwSLb1grozCvpcqE8ocheRSzHrk6HlZl3vjPxrhcXF5rAWW3cFu6N+L4mStelZaOy+qOYmIPbiL6jCiWvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427643; c=relaxed/simple;
	bh=lQz5Wi2CNI7mutEpsleqj+UaSfRjHL4NIvHI1DHFPnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9Ec2/ep/gCSyEpG4J+N/Idf63HF75ERfcKKSgjEubdomG+FQTVb4mZA9vCybWcnjPmdNCFL71yzGWein7/J1qpXnaL8JxP5zb9t61YMyK4QmE+PT/6kqw9HSvgx6K9XbDjRWaNj3QPPUTKwJSHKs/6Ver3oM1QcgIqHf5vs388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=fO78BxL1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e622b46f45so875229b3a.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 07:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1710427641; x=1711032441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLAyFzYwKoQSCER8lGxmEQW44ebFW2QrRZ71aBXPTY0=;
        b=fO78BxL19WY36+aGucLwA7XCmINtS7YybY+ur7z1DcVesWgrb9/j549Ri67KtZpZ00
         d4QYjv75qGFIJUbVnGOmykfRzhwET1nHXOzYyfvHREyvQYOmz4lJd/3g7J9mB94gb3HN
         6xsyF/0HrYyRgdkf0K1K4JVbC2CkBA+TtgLxTKNMpL7E0G0uF5j8S7GzUtHjVKMbchWu
         +De7fNE3k1CVmLFJab445lg/Tlc64fgq5eemIKcIIbVac0IBFoybMYSSnbaeVN6mXim/
         PBxcp6yr+Hpxc3VJ42PhOFG7jgAuSERyi4ZTRWulVwqtpehEoqrKXYatCWXb1ysWTI9O
         NMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427641; x=1711032441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLAyFzYwKoQSCER8lGxmEQW44ebFW2QrRZ71aBXPTY0=;
        b=l8Mhm1EVfPKIbPC2/BniYO5dyXEF5uFT3zZnhVXBdfUlVVq6miOTXIDM6eJOXYntFX
         KGyZ8v3cJg1zUg6nKYEgi6GWRCn6w/CgtGhpqXoJNocxjDAc+BNjvV90bnpAenvu+sZF
         zcNdqLzzL34yZU/oyk5wuO0auOPZ86BF0/4gRILFwTEqbyGGZWCJPXN3FGYRUJipq2ql
         89EX8IoVzUc8B6qyZeLOQW/8hq8+txDrAn9VkOmnxvucawT87ikS+dDohf03WnaNEcfp
         aN0ErL28I8Vw1xexdUs4xWGBaAsg089aP1gcRLZBN/JY2BFGg1G1huhQStJ4OXXFcdqU
         Q6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUjCoxDoBXWLEO5wEi1NvjRQC5pVR9t0tACgvyC8nkvSRVMXoLJ9tsPMMB3d2Jrq9+IQ1qBPYjrSHo0vrsCHXhxaqXP0Y54
X-Gm-Message-State: AOJu0Yxifv9rPpVcEUEaIDmpsTd6P4c5ApwItwbzMTdBcpLU4bY/RShS
	22cloSinc8SVEeS4pjjhBv5CNv9m5gVjh6CDMDPyCOs3FgGO4rNgGEEEn9PGVA==
X-Google-Smtp-Source: AGHT+IECoo5ZWrowZUyhuI5rqcvTkeyY+WJigpkGzww9EfsDwNC//M/YezqUuq3iZXOORJXX/WISeQ==
X-Received: by 2002:a17:903:2446:b0:1dd:9cb3:8f96 with SMTP id l6-20020a170903244600b001dd9cb38f96mr220893pls.42.1710427640808;
        Thu, 14 Mar 2024 07:47:20 -0700 (PDT)
Received: from ?IPV6:2804:14d:5c5e:44fb:52c2:1319:f04d:938b? ([2804:14d:5c5e:44fb:52c2:1319:f04d:938b])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902dcd400b001dc9893b03bsm1766281pll.272.2024.03.14.07.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:47:20 -0700 (PDT)
Message-ID: <af05ea48-75c3-444c-86cb-ebf5c7bee2ec@mojatatu.com>
Date: Thu, 14 Mar 2024 11:47:15 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/sched: Forbid assigning mirred action to a filter
 attached to the egress
To: renmingshuai <renmingshuai@huawei.com>, jiri@resnulli.us
Cc: caowangbao@huawei.com, davem@davemloft.net, jhs@mojatatu.com,
 liaichun@huawei.com, netdev@vger.kernel.org, vladbu@nvidia.com,
 xiyou.wangcong@gmail.com, yanan@huawei.com
References: <ZfLi17TuJpcd6KFb@nanopsycho>
 <20240314140430.3682-1-renmingshuai@huawei.com>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20240314140430.3682-1-renmingshuai@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2024 11:04, renmingshuai wrote:
>>> ---
>>> net/sched/act_mirred.c                        |  4 +++
>>> .../tc-testing/tc-tests/actions/mirred.json   | 32 +++++++++++++++++++
>>> 2 files changed, 36 insertions(+)
>>>
>>> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>>> index 5b3814365924..fc96705285fb 100644
>>> --- a/net/sched/act_mirred.c
>>> +++ b/net/sched/act_mirred.c
>>> @@ -120,6 +120,10 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>>> 		NL_SET_ERR_MSG_MOD(extack, "Mirred requires attributes to be passed");
>>> 		return -EINVAL;
>>> 	}
>>> +	if (tp->chain->block->q->parent != TC_H_INGRESS) {
>>> +		NL_SET_ERR_MSG_MOD(extack, "Mirred can only be assigned to the filter attached to ingress");
>>
>> Hmm, that is quite restrictive. I'm pretty sure you would break some
>> valid usecases.
> Hmm, that is really quite restrictive. It might be better to Forbid mirred attached to egress filter
> to mirror or redirect packets to the egress.
> 
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index fc96705285fb..ab3841470992 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -152,6 +152,11 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
>                  return -EINVAL;
>          }
> 
> +       if ((tp->chain->block->q->parent != TC_H_INGRESS) && (parm->eaction == TCA_EGRESS_MIRROR || parm->eaction == TCA_EGRESS_REDIR)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Mirred assigned to egress filter can only mirror or redirect to ingress");
> +               return -EINVAL;
> +       }
> +
>          switch (parm->eaction) {
>          case TCA_EGRESS_MIRROR:
>          case TCA_EGRESS_REDIR:


Are you sure this happens to egress mirred to netdevs other than the one 
used to attach the filter?
It seems like in your example you are forcing mirred egress to the same 
netdev as the filter

