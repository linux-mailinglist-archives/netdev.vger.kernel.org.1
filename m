Return-Path: <netdev+bounces-178039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0DA7412E
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E98C1895EFF
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC74D1E1E03;
	Thu, 27 Mar 2025 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AQQFg9Nu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F471DF257
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743115985; cv=none; b=NIHFfxxQMe1A6M4wc8mPFZAnSMhI7f+uEbPg87xeTcvpyy7aWI3l+cdg+wvxwHZGi9YoY+dCZkyUmW1q6h7v2UbwyNNlrZdxCIvJUb5xMAK79kngieK/DINjUjrf30wakc0DYfYsMvcflNt6tBO/3n8JCjV9L+ZC34KCnhOeidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743115985; c=relaxed/simple;
	bh=pKpgtM4kB/4K64gSh6vdxNp84Cah8MzlKXkdIhPEZ84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQBvOBGA2yx/7U9k57fQXT69z9Py07jqTz31B4LYjAVNexgdRE7Nwm+IdlGeF89cJq/+sXMdfKixbIRYFLGZLiit+mCjyIRrbmZuC5+1uaJ2pL9QoKqpRucydWQznCVA6krc6g4ioFEL3tvjUMSytTFm665P18NLcTfB+y4/gFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AQQFg9Nu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so233546666b.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743115982; x=1743720782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k12Y8dWe84nCJDuQsvD5DEjenxTgzdu2WJ45ZyGKWY8=;
        b=AQQFg9Nu4aN8lHCdb/84wZfBMNSyJu14daXnGHBjd4gsAbCAUobS40yhZ9gf4bMv8Q
         gXYCn/ESPMF41TNcb8vruTcV617corHL9H5WkmOp75DXUGUFgaWGjGSkh36PDewGAhlx
         OjCqDEMLyPoMEJV1XX8WKNv4Qgtd+iZ7X3SraHETASDbyFLY1uHQ6ZZI0f18GULgEKRb
         LlGyb5fiDbekP2fEvumsVCRwu6uZQvycZ+8eVTIoyl4PEJw5EE5xw5vcu0a6ifTaWXZj
         YuOJe2dCz4WHLFxz35mFp98Q5Z1dCwr3WfQRPz+/I1aMcPDItJUj96i0AWYyrMXkGQRO
         Mq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743115982; x=1743720782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k12Y8dWe84nCJDuQsvD5DEjenxTgzdu2WJ45ZyGKWY8=;
        b=EXzh3PdGSTCc7AoxQOjFC/ga2aqN78NEw6gxv006TTpwBZ6WhVPyAhQFiZP09uR2dE
         6u+OLRRhg+vNkHBLZ6WJvcXeetydK/hRO8c2DcEay837BexCOI38mAcep85OR5vqMixB
         BXhVaomNMioz5kmsTStSQbm2w2CqlV8agm1TWlFdM0MzlfA2xk8/rO63p6u/kic1nsBQ
         RC8po+7FxQizLtpmIpA6cD5ugHT1iP7g2ixBHgNHhe7hfCqru2UcvLNVbZ+MzSPzX4oL
         iH6IA2ZFBsTUOd/Pix1XJBz7NE4/0K37vsQ8/pBXox+cPsfovbRdBY3jWyT1mdwK52kk
         8DHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb+rzxvel2Qmi0qbN0AC33ddQr8JqSrchGAR+idU6yOzKungDxg9rcI7ZPLLL/ZaPYzROaeXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4R6SFPtvmEz1PpC3HjflkhiTx0jIS/g0ygsGRDfrmnkY88RL
	G0UlLKxHV9geoBu3zKFsAEmi+AjGVnFN9q6J4qYENsD5jYXhilQd7a1hCYHIOW4=
X-Gm-Gg: ASbGnctebZN20b29nTkzW8wbXldDMLlcxjc5zCCE3WFkKtLd+YT0vtRp7mI8JtTjHvP
	4N6CDqiRvG2qrLVaI1d2ci9/7NSzjWFP8ny5POF3B/E0p7oPC0d+vlS2rbQ7g0gGe2QsG1h7It5
	PBJ8K5wDxfPH3izOXyUUjPCV+1iyIrBr3UYuuoD0+mrHshFKb0g28rok6U5ZT0bBj5yBJrELhHP
	LXVOFO5ifLGDlK3M1Ndjk1mUKuwOFcgoRm9x8l2SpKa61Kbae9UuKvJd2FAjMsyBFAO1bxuy8zT
	Rip/Ej4/5hI3AksOf3+mF9SJ43cAHjRg16LkgQ5Of4Yk9f98prM=
X-Google-Smtp-Source: AGHT+IEQKYdXU4YRdq7AjkHureyIrp+bm+P0LupbshznRTrIcsjVjBe9WN63ZaIpC1RkUq+pZC7I3g==
X-Received: by 2002:a17:906:c153:b0:ac3:bd68:24eb with SMTP id a640c23a62f3a-ac6fae46de8mr605017166b.1.1743115982075;
        Thu, 27 Mar 2025 15:53:02 -0700 (PDT)
Received: from [100.115.92.205] ([109.160.74.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922b965sm63206566b.20.2025.03.27.15.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 15:53:01 -0700 (PDT)
Message-ID: <ffe6f6cc-7157-48ad-9cde-dc38d8427849@blackwall.org>
Date: Fri, 28 Mar 2025 00:52:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next 1/3] net: bridge: mcast: Add offload failed mdb
 flag
To: Joseph Huang <joseph.huang.2024@gmail.com>,
 Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250318224255.143683-1-Joseph.Huang@garmin.com>
 <20250318224255.143683-2-Joseph.Huang@garmin.com>
 <c90151bc-a529-4f4e-a0b9-5831a6b803f7@blackwall.org>
 <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <85a52bd9-8107-4cb8-b967-2646d0e74ab4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/25 00:38, Joseph Huang wrote:
> On 3/21/2025 4:19 AM, Nikolay Aleksandrov wrote:
>>> @@ -516,11 +513,14 @@ static void br_switchdev_mdb_complete(struct 
>>> net_device *dev, int err, void *pri
>>>            pp = &p->next) {
>>>           if (p->key.port != port)
>>>               continue;
>>> -        p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>> +
>>> +        if (err)
>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD_FAILED;
>>> +        else
>>> +            p->flags |= MDB_PG_FLAGS_OFFLOAD;
>>
>> These two should be mutually exclusive, either it's offloaded or it 
>> failed an offload,
>> shouldn't be possible to have both set. I'd recommend adding some 
>> helper that takes
>> care of that.
> 
> It is true that these two are mutually exclusive, but strictly speaking 
> there are four types of entries:
> 
> 1. Entries which are not offload-able (i.e., the ports are not backed by 
> switchdev)
> 2. Entries which are being offloaded, but results yet unknown
> 3. Entries which are successfully offloaded, and
> 4. Entries which failed to be offloaded
> 
> Even if we ignore the ones which are being offloaded (type 2 is 
> transient), we still need two flags, otherwise we won't be able to tell 
> type 1 from type 4 entries.
> 
> If we need two flags anyway, having separate flags for type 3 and type 4 
> simplifies the logic.
> 
> Or did I misunderstood your comments?
> 
> Thanks,
> Joseph

I think you misunderstood me, I don't mind having the two flags. :)
My point is that they must be managed correctly and shouldn't be allowed
to be set simultaneously.

Cheers,
  Nik


