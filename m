Return-Path: <netdev+bounces-144748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679119C85C1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16BD3B244BD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B01DE883;
	Thu, 14 Nov 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3MUrAEl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FD1DE3B7
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575587; cv=none; b=WQWiV7e3QAbeBo1M+0ae9TKGGtKmCjGHMbyhwnI3wnvEN1Tt7+F89PMrwYERwwEF4JbM8V1BDhDex4WH1CwTyaaHl+O0ltp5vp1CTH1EUIHWmyV2lL8m5/iQNmIyFUjuRJoCv1XgDNUWAvQHxWi5QaAZQ2Zq8LlRZs1aAr8Kpx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575587; c=relaxed/simple;
	bh=ZlochL675vKEl4dprZTa/z7ai2B8pgWEOJ0VD/AVS28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6RZuyfWKIHf8+Ps9Q8UQVMQ3kmOLg244HZAhV0w+S7eU2fM0esN+98C0qC39ms5y7lfHEAhwgGC60271jbWn49bIix3EczUs/KQEFQVOcaSv5HruqdaAFitqvRMJCxg2vALVAuqZxHT562mZb+lrnvu6cvexg5j3yJShHF+EUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3MUrAEl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731575584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUeaOXQiwvSG7xEIr9TGhk8zuNyNZ/eaCIMRElm3z+E=;
	b=S3MUrAElx1+gTpLVNWYUAOm4ZDZ7G9pqVRQy7p1dnj7LHywv1/m/ROkBPVi+BZa8uGTtCw
	B6WJBCpBOQ8pIc4fOu86/GQAOT3r0hap3+0IxYFpM22EO8p2jU5VE4KgZGjCoBejSz3chO
	lUlLx90ZtvQlDJBEhpmU+pdmdWnI5as=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-WB4YnzB7O9mlSA6xIDOcTg-1; Thu, 14 Nov 2024 04:13:03 -0500
X-MC-Unique: WB4YnzB7O9mlSA6xIDOcTg-1
X-Mimecast-MFC-AGG-ID: WB4YnzB7O9mlSA6xIDOcTg
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b16c9a84efso35419785a.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575583; x=1732180383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUeaOXQiwvSG7xEIr9TGhk8zuNyNZ/eaCIMRElm3z+E=;
        b=rqfw3RHIqJF4so7X/ATBX0Ov3W+9R6gq4AYHdnIYukBxdrSg4YK/xtTFe/rnsoHnhB
         C/FUBNYWX5MALvtY/xWzQsFcTmYoIZz0OoRFtwPk2dfnNQgHyNsfXunY7hwW5eRIjZx5
         Un5T3l2mhkSj4CHDtqpxsnR1M84uiazHZjrnhIno3RJa1wP32jzt+03ndaXa7sDuYI8i
         TZH08Jfs7zrXzyUNGHiuC17gcVH4+2K4svanOrMQm3197qe23uL5a9dZq+XwN98piwS+
         wRXwV3gF3zDbk9NoeFyptKNVFDZNfIhs5iqv2M1YeD9udsWQk636LbamWITr8htzDGoG
         +xog==
X-Forwarded-Encrypted: i=1; AJvYcCUK38oZwaXuYvVes8MN1oz0yIJoS6242FnLA60Tuu7yMJjuvn0Ju8DHdabuG6g2kj9Gcar3FVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuZkH9pGveIkD43/EI931xFqmAWU0AyKewsNw0G9AKBgZqxgG
	tcnTz5v4NnETIxoiReoOiwtpUeJlR5j+WiDfj8nbEypJbQi5fl8f3foDRVyUn+sY9tbWGBkuNe0
	OLubB56Rm9VGYDGaeVrLF+pCpuOLJPXKoP6aBdggyeW5EMRpgANcPtA==
X-Received: by 2002:a05:620a:448f:b0:7a9:c406:eeb3 with SMTP id af79cd13be357-7b35c09efc9mr200075985a.1.1731575583013;
        Thu, 14 Nov 2024 01:13:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiS3vUHfH1zuhrwZzd1lLo5Hyvopj7rMtfjzgPmX9vV/xp1+1gGzFFTWpSfzlmkHlXbLU+yQ==
X-Received: by 2002:a05:620a:448f:b0:7a9:c406:eeb3 with SMTP id af79cd13be357-7b35c09efc9mr200074485a.1.1731575582686;
        Thu, 14 Nov 2024 01:13:02 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c99ddbdsm28735085a.47.2024.11.14.01.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 01:13:02 -0800 (PST)
Message-ID: <978cdfc7-f584-4ab5-a062-db19ed363691@redhat.com>
Date: Thu, 14 Nov 2024 10:12:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, horms@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241108054836.123484-1-lulie@linux.alibaba.com>
 <20241108054836.123484-4-lulie@linux.alibaba.com>
 <a1db0c11-38ee-4932-86bc-a397a0ecf963@redhat.com>
 <14a1a4a1-7281-4715-bf6e-73d3dd5417ef@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <14a1a4a1-7281-4715-bf6e-73d3dd5417ef@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 02:50, Philo Lu wrote:
> On 2024/11/12 22:58, Paolo Abeni wrote:
>> On 11/8/24 06:48, Philo Lu wrote:
>> [...]
>>> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
>>> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
>>> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
>>> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
>>
>> [...]
>>> @@ -2937,7 +3128,7 @@ struct proto udp_prot = {
>>>   	.owner			= THIS_MODULE,
>>>   	.close			= udp_lib_close,
>>>   	.pre_connect		= udp_pre_connect,
>>> -	.connect		= ip4_datagram_connect,
>>> +	.connect		= udp_connect,
>>>   	.disconnect		= udp_disconnect,
>>>   	.ioctl			= udp_ioctl,
>>>   	.init			= udp_init_sock,
>>
>> 2 minor notes, possibly not needing a repost:
>>
>> - The SoB chain looks strange, do you mean co-developed-by actually?
> 
> Yes, we're all involved in the development. I think it could be 
> indicated by SoBs (and all of us agree with this). Please let me know if 
> I'm wrong :)
> 
> Or strictly as [1], it should be:
> 
> Co-developed-by: Cambda Zhu <cambda@linux.alibaba.com>
> Signed-off-by: Cambda Zhu <cambda@linux.alibaba.com>
> Co-developed-by: Fred Chen <fred.cc@alibaba-inc.com>
> Signed-off-by: Fred Chen <fred.cc@alibaba-inc.com>
> Co-developed-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> Signed-off-by: Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> 
> [1]
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

The latter (with co-dev-by tags) I think would be better, it will give
full attribution to all of you. Since the scope of this work is relevant
I think it would be better a complete recognition.

>> - udplite is not touched. AFAICS should not be a problem - just the
>> feature will not be available for udplite. 
> 
> Agreed. Theoretically, the feature relies on udp4_hash4/udp6_hash4 when 
> connecting, and all other functions including lookup/unhash/rehash 
> always check "hashed4" firstly, and do nothing if it's false (which is 
> the case for udplite).
> 
> AFAICT, the effects to udplite include:
> - Additional memory consumption in udp_sock and udptable
> - Control path: udp_hashed4 checking when unhash/rehash
> - Data path: udp_has_hash4 checking when lookup
>               (like unconnected sks in udp)

Looks good. Please note explicitly in the cover letter that udplite is
intentionally excluded here, the reason why such choice is safe
(basically a synopsis of the above) and repost with the update tags
chain including my Acked-by tag
(you should retain Willem acked-by tag, too.)

Thanks!

Paolo


