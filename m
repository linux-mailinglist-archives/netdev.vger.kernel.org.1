Return-Path: <netdev+bounces-207234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D5B064FE
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 19:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CC11AA3097
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5F277C96;
	Tue, 15 Jul 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AxHPxLm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F682594B7
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599649; cv=none; b=IBugOHfI5DHaSI2spMEo0s/FYAR5dbD5leN/uF0rwPJRjWO3s0CZ/Ju0fUi1rgm0Vw27AtshfWLCrZchqbq74qZn8GPfkFSlyhGNAJCCUXzQcMeiAXw/elG0ROvvMBFV/ZdG0r63Cu5Agipw9WP6r8T3rMZuiX3pdh6d6Q3FEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599649; c=relaxed/simple;
	bh=DsiIaBKefEcMu+mmSqmam8zWWRIa3+yMTHpscmLzKyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukA4Vo/3oKL/7B2imIUXhdjGso3UUud0KbTBjUmXe1BtcLkosVwxDO8stuqOQLVpKpAGUrZBqOMg/evzled3pnM9FHKbpFSJFTavhvwpgObpCId/zeKuNsqrg2Ennp6+wRJIwyKVl3F5g8JY37lfzdoN+FMo0r7Ouj4jjJtawcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AxHPxLm5; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e28058c18cso2717105ab.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752599645; x=1753204445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TMxrmpuCdkav7rNWEg+tHXjOAWkKzAEY7T2CQQo0GbM=;
        b=AxHPxLm5VQ7rDlUUz+zz5DeUDnPaFIWPvlWL0juqolncS9aROHK91tsbUEr3Pw/YRh
         Xe/cO4v4kiiDBpTGyC0VWfiHhrC6wYj90OW/0rcdNkGDMvEokZit3WF8sQKyHy1P74MY
         gObVAmukSn3l3u7qfvIJ3ZQ4Wx3PVfaWVQJ0raiZbhnAckVojkNrsCOvMESk5ArEN3Nt
         zTqsdwhwgwpzdThQBlA0VB+8MvW+hlw73QoBtXJDqEoKGHBqokxgzZYWHHJBKaikCAP9
         0mD/GvZgLs+Psj5GQJ18HJl7qR8Ha9n411nlpq20ZFDOPlPNtOkIuLtp15eY/AXKrjYU
         LnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752599645; x=1753204445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMxrmpuCdkav7rNWEg+tHXjOAWkKzAEY7T2CQQo0GbM=;
        b=AuZyPEK86SvnJlWpSTHcgeaEFAoVKBHCOmK7w/eyVzpM6SoNg+BqIrFMfYs0p8vw9B
         WTWnuvx166Kx+oa/VhPkt1eFRzb/fLk0Ci5A+KsRPLmf94OTfl3qkkJI7xkeWu4TqcuN
         DxuO3My0tHsKa9J7cX5fS1+4+Rb8XqC8oieBWKoFlh5sq+mt4YGHliigUTrW0gycV6Vs
         bWjtRQ2gRCwGYydHN5MWZcAU49yfnYGkxU+bK8M1G4CiJfMPcHAY3lpsmg2CLzRbTII4
         POpG9Vznxkbt8uOG1omo4Y25tam/W43DHnbqHAyFZCGe08XEdvCbk0Ee8Fe25Faor4QM
         oa2w==
X-Forwarded-Encrypted: i=1; AJvYcCVEi2sSCZfwotI/EHrICAlC8J+9YE+ypAm88bnQWoIHUIRvrl0te6PaadF/ohhl/tWwVKaCUOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgUECSYe6aBJuQn07S5bfoLHfHVKjMfGbF/e6ycNZzwOi81CP
	BxXxIXmwmCosmLF8c2sTYuy2Jv15mt6InwT4og//WRCYTDoJPZ2Mu5rj2wn0k+xO7h4tZJTFl1B
	qll6I
X-Gm-Gg: ASbGncuIQimYacVfqnKoebfwcD2+hKxqdZdOzR20Z7Ne0hn3AvnHKPC0EIzemPHHa+4
	hlsPwUIEFNgfPV1WH+p+4mnXIUoKYQA0GPrWrItA4AtZTaGrbDV2+9PGz+Ly6urmtk4qt+/BQPM
	Efdqv2HuYO/0hT/gSOy5vd/3px13JUPpg3XoecrruC2JnP8kxpIqCONVyVY6Or1A/3IjyPiRzaO
	qqjj8GqE3uY7YG2UlgGYpJ9TP70YWnCMjP7Q/np1h5K+MBYZA+sVfZDseCPRdM1xBq/xwJFzfZf
	x0f7DselM3zFCUWlr63+axrxNKJHOVQ9zBKTxAv+OxV80C7ZGXxIN2PMVOqeCFe7tbOOVXLEwFs
	eYyftp52zVEF9tkIZ6tjHo8kwKjUe
X-Google-Smtp-Source: AGHT+IH2n5ItpiLtReE/tNyR8VfN63Qhgl9pICyUl/KKZBnIF8owSdnXaa2nun7yIRDOkb1ctoi+hA==
X-Received: by 2002:a05:6e02:1a21:b0:3df:49b0:9331 with SMTP id e9e14a558f8ab-3e2532781a2mr181059345ab.4.1752599644954;
        Tue, 15 Jul 2025 10:14:04 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569d3d60sm2579258173.103.2025.07.15.10.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 10:14:04 -0700 (PDT)
Message-ID: <7d1b2ab7-0cd8-44b4-bcb5-9bd31ce650e5@kernel.dk>
Date: Tue, 15 Jul 2025 11:14:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "axboe@fb.com" <axboe@fb.com>
Cc: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 Shai Malin <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Gal Shalom <galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "gus@collabora.com" <gus@collabora.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Aurelien Aptel <aaptel@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "kuba@kernel.org" <kuba@kernel.org>
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
 <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
 <2e2d61fa-affd-486a-b724-b458d722304c@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2e2d61fa-affd-486a-b724-b458d722304c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 11:08 AM, Chaitanya Kulkarni wrote:
> Jens,
> 
> On 7/15/25 08:06, Jens Axboe wrote:
>> On 7/15/25 7:27 AM, Aurelien Aptel wrote:
>>> From: Ben Ben-Ishay <benishay@nvidia.com>
>>>
>>> When using direct data placement (DDP) the NIC could write the payload
>>> directly into the destination buffer and constructs SKBs such that
>>> they point to this data. To skip copies when SKB data already resides
>>> in the destination buffer we check if (src == dst), and skip the copy
>>> when it's true.
>>>
>>> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
>>> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
>>> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
>>> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
>>> Signed-off-by: Shai Malin <smalin@nvidia.com>
>>> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> ---
>>>   lib/iov_iter.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>> index f9193f952f49..47fdb32653a2 100644
>>> --- a/lib/iov_iter.c
>>> +++ b/lib/iov_iter.c
>>> @@ -62,7 +62,14 @@ static __always_inline
>>>   size_t memcpy_to_iter(void *iter_to, size_t progress,
>>>   		      size_t len, void *from, void *priv2)
>>>   {
>>> -	memcpy(iter_to, from + progress, len);
>>> +	/*
>>> +	 * When using direct data placement (DDP) the hardware writes
>>> +	 * data directly to the destination buffer, and constructs
>>> +	 * IOVs such that they point to this data.
>>> +	 * Thus, when the src == dst we skip the memcpy.
>>> +	 */
>>> +	if (!(IS_ENABLED(CONFIG_ULP_DDP) && iter_to == from + progress))
>>> +		memcpy(iter_to, from + progress, len);
>>>   	return 0;
>>>   }
>> This seems like entirely the wrong place to apply this logic...
>>
> 
> do you have any specific preference where it needs to be moved ?
> or any other way you would prefer ?

In the caller? First of all, having any kind of odd kconfig check in the
iov iter code makes zero sense. Why would a copy helper need to care at
all about what kind of drivers are enabled in the kernel? It's a gross
hack and layering violation.

-- 
Jens Axboe

