Return-Path: <netdev+bounces-141348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B29BA855
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192AD281791
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B6189914;
	Sun,  3 Nov 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+Ujlmbf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEC7494;
	Sun,  3 Nov 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669522; cv=none; b=KeyyCIAJAIC0CbblYRq72Y3xdDaz4m5G5Qv7LmZ+74wKlsR/m9vqX3SjgXT423lHKjtYSYyRGyqrYdLcarB0EqK+JMqSwRAw38v14SbUYo6yp4WLcHtYC+o1dDVJOSK5D7UtJr5OIMJpugVoEEWoHtL0+HdSIPPYqZFw/FSz7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669522; c=relaxed/simple;
	bh=4FZCoaqmr/smDKVy7p76ecNHTW8zXB5Dwmx5Uj611+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcGGvZnDxQGWxFh5b5mIZZjoP4UzFYrFhP6L5EDm2H/qv1krGBL/oplCgafvecM5Kwg2j2DKXD8b+e3i/S6toItNe4rmoqybaPQVecguMC4J5NLTe1hLm4XJ0bowmQ3YegDoA289n0VS8tO8CQqdlKglAyPUY8urFROdZTE0gZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+Ujlmbf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e6981ca77so37095145ad.2;
        Sun, 03 Nov 2024 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669519; x=1731274319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uEGmCtHMt1tQKl9GUV8ny173xaCw10Wp6THMKkRdLKI=;
        b=k+UjlmbfJXuvrbfevgUjuSngDy4bPIeA4e5+h1LExia4zYkADJtF6kKEWOzPNd7w3A
         HP+W5r/i4OHmOe1BBPh30HFfdCgQ5K7npFB3XACflRwxCXUkEM0H5yAcAWpPwuM+e4R6
         m2+udK3wTP7Accpjp1xrkoBhdlHclGHPcf8yL4lID5fygtLJw6AXclre2yx6N/nU9oLx
         cA7NWGi+b+FM1DX2CWpaLq3Rtu2sj9aEaeQqDPp3ug+U8NwWrjM4b0AFLbsijmymGCCA
         k/cI1F3YNdCaOZkBaByGxRVU7EFBGnc0HMs8zWv17KKxdFvOJKrT8cj+7/KK4JtbaAM5
         sPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669519; x=1731274319;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEGmCtHMt1tQKl9GUV8ny173xaCw10Wp6THMKkRdLKI=;
        b=w6Je3+4YB1426cLrs0c6tos5NUXVDNUD/HqtyVbGO5tmPCWjnt5vAuc0+bJm/18NRA
         gSbXxUoDXwNUjV6EguiPnma+8ZULfZaFd0NNVI29hNx6/T+iI+h7Eig2BXCteWh7+luP
         leaRLVK9DdH1feWzbnYwNK7s7vjilgCNuniuDHdvB2DhK3WJPsKNfxXdXLXLor1SL+kk
         mmpl8NtVks3cZWaxkJ8mGtntS9FQEvyhr9gp9dgZ+FKMz0iPda6s+DNLxhvkuHdYy6Wm
         sgBuDDj02CHBBHUhaBolGrFT2auyz2lZ+flUQhGs8Fuva2oUK5uVb7rYplB4aRW45ENN
         QkPA==
X-Forwarded-Encrypted: i=1; AJvYcCVk4N1EQSPEp2LuGt2KEK4t+dA0FCSta+X5D+raSa7hsO8pPcX9VGE6AjI+HJK7CJYe8sSdznvFOGocKNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJU0H+74MCXijGe1ztPFX9IZsxurbLBU9ItUM+0jR4KTJ9Ce8
	mMn8Q+t8+yXE0vASS0OnCTcOaIpFWXZSM6c16n1uXULOwwFWZDml
X-Google-Smtp-Source: AGHT+IGUEvMIAgYWtOEnHYT6AaWFpSUs/YaUo/z7IgIqU35zlEzUo/HrtuIQYUfKqraKexYiKVOgLA==
X-Received: by 2002:a17:902:e801:b0:20c:d428:adf4 with SMTP id d9443c01a7336-21103c5a12fmr202208995ad.38.1730669518997;
        Sun, 03 Nov 2024 13:31:58 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c6ba6sm49243325ad.233.2024.11.03.13.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 13:31:57 -0800 (PST)
Message-ID: <12a09104-4c60-4590-b00e-fc313384c5b6@gmail.com>
Date: Sun, 3 Nov 2024 13:31:55 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] MAINTAINERS: Remove self from DSA entry
To: Andrew Lunn <andrew@lunn.ch>, patchwork-bot+netdevbpf@kernel.org
Cc: netdev@vger.kernel.org, olteanv@gmail.com, akpm@linux-foundation.org,
 kuba@kernel.org, krzysztof.kozlowski@linaro.org, arnd@arndb.de,
 bhelgaas@google.com, bagasdotme@gmail.com, mpe@ellerman.id.au,
 yosryahmed@google.com, vbabka@suse.cz, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org
References: <20241031173332.3858162-1-f.fainelli@gmail.com>
 <173066763074.3253460.18226765088399170074.git-patchwork-notify@kernel.org>
 <769445b8-e9e3-4e18-93dd-983240ba0bf9@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <769445b8-e9e3-4e18-93dd-983240ba0bf9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/2024 1:12 PM, Andrew Lunn wrote:
> On Sun, Nov 03, 2024 at 09:00:30PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This patch was applied to netdev/net.git (main)
>> by Jakub Kicinski <kuba@kernel.org>:
>>
>> On Thu, 31 Oct 2024 10:33:29 -0700 you wrote:
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>> Changes in v2:
>>>
>>> - add self to CREDITS
>>>
>>>   CREDITS     | 4 ++++
>>>   MAINTAINERS | 1 -
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> Hi Jakub
> 
> I could be wrong, but i thought Andrew Morten already applied this?

He has yes.
-- 
Florian


