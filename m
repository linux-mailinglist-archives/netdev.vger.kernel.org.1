Return-Path: <netdev+bounces-65780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748BC83BB2F
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B1E1C25AF4
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6301759E;
	Thu, 25 Jan 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVJnmgWN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164C1A587
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169671; cv=none; b=DYnkHkeaQn0dUePWTL+xA4ONVk6/kbpkwBSGK3Lq4P9oq2Io75dWZqzZ6O1pKs45psTQUaYVTS+75ET9wuQEI+ZZc63Wlv2wxz4NbDynkbXSRuANRD2ywU0y5rsdjTseZ5fXoK2Gp5eshnHpOwvZ3XQmNJFV3NZdJV5/4KDXHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169671; c=relaxed/simple;
	bh=JlGqtlXmGZ0i7vbAdQZllGOf+Z4BV9SFg89a3Ou+PNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YsyNjmrRxBZQ2vIKwpKeYKEbOa69CMg7k9AbOerEWilrMUspBqQUOTTI5ofKGT7hHOxpjyVkhDKESVPu+GBbJErODAjUn7+B2xn+cl/qOOQiLlokaLU7k8V+rfG6fiCUAf2yTRi2ia3CK7krPNJGLQHiO6lRZ45bXhhi8h5EpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVJnmgWN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33926ccbc80so4052380f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706169668; x=1706774468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9kXOGBqOvW0ff6agZpHOQcSoxxYTM2oeo2GnQTYfso=;
        b=fVJnmgWND1ZzL6Vv6RyBtiZVkFG1V8cctlj7fPW28cFToqyJn+eX7mA15X63PElmIa
         BgYPNudy98lFOP4ProOfVsJw61AHeAGWSyE454urdYKO9SBLFsr7lNFJTZvw/mJrzJ85
         CPLydmt8i9VyyFt5odeTjHFoRuAsEqE8kL/mFrYUZvBR/grORYYS2i8bhGOkbOzg9npB
         zSf7bE2PY7ecUlcq0+JV6WNXZL1FXCxVH0TLg91xFE18ZMW5BvbeNJ+WGFfQ8tmMiQ7h
         rEyMI544O3ywmEpKIVp1dWXpMNxqPGHXAlgXsuIp4pH4Zc2bDlLHdmzTP2+iYG3ZUYo7
         AvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169668; x=1706774468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9kXOGBqOvW0ff6agZpHOQcSoxxYTM2oeo2GnQTYfso=;
        b=Hz59ztZPdqSseh3vtXYgvJKKtPMOMnNa0ohv04cxRx2frxO7LbBib6Da8u7JyafuFS
         /sSh2lGpJIfwgUu5JwrWA5ryR6VCwxhsGX6Qu+RCJ/5UU84VXMQA9OfXQTWF+mtEye8e
         vSa4xQYXnL8Q01M5IZyYbk0Bpp4a0886QK9CvYlY7qndIq/pKG71lmSkKNhs0O9xYYj4
         lV1Hp0nsfI/jCl7M7yWCH3p2slo8XqpVmoLz80/kM7ZAYv98a2P9wA/SQGTcMx0mcrVA
         X6nbsZDNc2BW/y5KN4JtIxiNmyjeKcR5o6BXxaxgMKzwEK7/QbTxgJLKvjtXqGiYucH0
         VcBA==
X-Gm-Message-State: AOJu0YxgmBakRbIfb0mCpoiHOR8PDqwsAK7xfga0FiSOpIjdsOYWpBg/
	2rlAEMQa/4x+ls4qg4RlIhyYKTnmsYUAWFQrsyvCN56CEUXtOncC
X-Google-Smtp-Source: AGHT+IG4I/XsvK3tTvsqQ2pCxl8Ub/ZaSP+qyJC63ILXa0jyT9K04fiRgYDOkFCJfiXiazRWcUGBDQ==
X-Received: by 2002:adf:f8c7:0:b0:337:c0e2:8b15 with SMTP id f7-20020adff8c7000000b00337c0e28b15mr428063wrq.101.1706169667964;
        Thu, 25 Jan 2024 00:01:07 -0800 (PST)
Received: from [172.27.57.151] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0040d5ae2906esm1599782wmq.30.2024.01.25.00.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 00:01:07 -0800 (PST)
Message-ID: <4bb155ee-f727-449f-bd88-ba117107a88f@gmail.com>
Date: Thu, 25 Jan 2024 10:01:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 10/15] net/mlx5e: Let channels be SD-aware
Content-Language: en-US
To: Gal Pressman <gal@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-11-saeed@kernel.org>
 <20240104145041.67475695@kernel.org>
 <effce034-6bc5-4e98-9b21-c80e8d56f705@nvidia.com>
 <20240108190811.3ad5d259@kernel.org>
 <d0ce07a6-2ca7-4604-84a8-550b1c87f602@nvidia.com>
 <20240109080036.65634705@kernel.org>
 <9d29e624-fc02-44cd-9a92-01f813e66eed@nvidia.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <9d29e624-fc02-44cd-9a92-01f813e66eed@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2024 16:09, Gal Pressman wrote:
> On 09/01/2024 18:00, Jakub Kicinski wrote:
>> On Tue, 9 Jan 2024 16:15:50 +0200 Gal Pressman wrote:
>>>>> I'm confused, how are RX queues related to XPS?
>>>>
>>>> Separate sentence, perhaps I should be more verbose..
>>>
>>> Sorry, yes, your understanding is correct.
>>> If a packet is received on RQ 0 then it is from PF 0, RQ 1 came from PF
>>> 1, etc. Though this is all from the same wire/port.
>>>
>>> You can enable arfs for example, which will make sure that packets that
>>> are destined to a certain CPU will be received by the PF that is closer
>>> to it.
>>
>> Got it.
>>
>>>>> XPS shouldn't be affected, we just make sure that whatever queue XPS
>>>>> chose will go out through the "right" PF.
>>>>
>>>> But you said "correct" to queue 0 going to PF 0 and queue 1 to PF 1.
>>>> The queue IDs in my question refer to the queue mapping form the stacks
>>>> perspective. If user wants to send everything to queue 0 will it use
>>>> both PFs?
>>>
>>> If all traffic is transmitted through queue 0, it will go out from PF 0
>>> (the PF that is closer to CPU 0 numa).
>>

Hi,
I'm back from a long vacation. Catching up on emails...

>> Okay, but earlier you said: "whatever queue XPS chose will go out
>> through the "right" PF." - which I read as PF will be chosen based
>> on CPU locality regardless of XPS logic.
>>
>> If queue 0 => PF 0, then user has to set up XPS to make CPUs from NUMA
>> node which has PF 0 use even number queues, and PF 1 to use odd number
>> queues. Correct?

Exactly. That's the desired configuration.
Our driver has the logic to set it in default.

Here's the default XPS on my setup:

NUMA:
   NUMA node(s):          2
   NUMA node0 CPU(s):     0-11
   NUMA node1 CPU(s):     12-23

PF0 on node0, PF1 on node1.

/sys/class/net/eth2/queues/tx-0/xps_cpus:000001
/sys/class/net/eth2/queues/tx-1/xps_cpus:001000
/sys/class/net/eth2/queues/tx-2/xps_cpus:000002
/sys/class/net/eth2/queues/tx-3/xps_cpus:002000
/sys/class/net/eth2/queues/tx-4/xps_cpus:000004
/sys/class/net/eth2/queues/tx-5/xps_cpus:004000
/sys/class/net/eth2/queues/tx-6/xps_cpus:000008
/sys/class/net/eth2/queues/tx-7/xps_cpus:008000
/sys/class/net/eth2/queues/tx-8/xps_cpus:000010
/sys/class/net/eth2/queues/tx-9/xps_cpus:010000
/sys/class/net/eth2/queues/tx-10/xps_cpus:000020
/sys/class/net/eth2/queues/tx-11/xps_cpus:020000
/sys/class/net/eth2/queues/tx-12/xps_cpus:000040
/sys/class/net/eth2/queues/tx-13/xps_cpus:040000
/sys/class/net/eth2/queues/tx-14/xps_cpus:000080
/sys/class/net/eth2/queues/tx-15/xps_cpus:080000
/sys/class/net/eth2/queues/tx-16/xps_cpus:000100
/sys/class/net/eth2/queues/tx-17/xps_cpus:100000
/sys/class/net/eth2/queues/tx-18/xps_cpus:000200
/sys/class/net/eth2/queues/tx-19/xps_cpus:200000
/sys/class/net/eth2/queues/tx-20/xps_cpus:000400
/sys/class/net/eth2/queues/tx-21/xps_cpus:400000
/sys/class/net/eth2/queues/tx-22/xps_cpus:000800
/sys/class/net/eth2/queues/tx-23/xps_cpus:800000

> 
> I think it is based on the default xps configuration, but I don't want
> to get the details wrong, checking with Tariq and will reply (he's OOO).
> 

