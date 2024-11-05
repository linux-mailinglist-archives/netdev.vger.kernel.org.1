Return-Path: <netdev+bounces-142106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03B9BD844
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62307284254
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAC216203;
	Tue,  5 Nov 2024 22:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRNbjxlj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0411F667B
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844889; cv=none; b=I7jM/qi3a3zG0F2OArgWNRsPfscbVz0xGvuF28EyX1hw9f+nKnrsPSIRr2PzSo8F8Dm4KXcui2dYHkYQMe88hUH2sMFkJI/jAkuDZizvLlETxcxNf84Xkza9c3Bw27wFjJeIx9f9RexHHZOS8zbskCrc9UCk9aYu1pTrqwZobtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844889; c=relaxed/simple;
	bh=iVLiin7t/ID16hMPgadOm45gWlEB47bsKBmtS+GckTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMMRN2OxpJC1a+yfuuDmzfCRuhJhfiVt/HMVWp/iPw3cxhEM1NvidACS9HerEcGY9KFVym3tlHbAx6xkK8GRzMKFaehsioBbc5ynq3FTDkWiX6Z77iWpj7MB+msYoHyKz+B0kpripw3OmF1ckhZKSZxfKCy4y7M9g8SnzPVYMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRNbjxlj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso1027812166b.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 14:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730844886; x=1731449686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cSoCOoqOZlGQoSlM7ngrK0v2Fxm7Up32XEp4pNZbCQ=;
        b=CRNbjxljsh1WMQlFXeJZhGIDuDdWWjR2wDKfta6gv/1DU19CTm5/Di7Q9uiiNMO2F9
         URmb/DBbSJlvY+zljM/rCekmaSW8Z0skYEVzbLSBuf9iUrFbvwppFayUK9iwoeqJkfJE
         p90S8Ms8DVuwkfb9BYlTIfrYmdL6rPjQEt8uglvO0a7Ubj00EnOJ7sxZveSDECJvwX81
         38mBbT04Mtf6TiCo/+9ASXJeasbMF2OhMM0B4xm6OUb7JE2Dm71/6xhwunFLOlmxY0jJ
         lBIAZt+v595Ml43NvHeGqOfxVHT8c9/2xqvEXIEuXc3vDELFdkQQeYv0mhRrm1Z442eh
         PB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844886; x=1731449686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cSoCOoqOZlGQoSlM7ngrK0v2Fxm7Up32XEp4pNZbCQ=;
        b=dbypKkWcc61FM+Gfnbdrqkkp2cSEVnGi3/fJin0T/RjVgzGT1B2WID63G1GC/D5gBZ
         4mfPiJKnTauA9koFTeoqr45fqLT/uOZpJCYQrN6aTX7+LPUNhnZdH9BETHdrgOe3MRp+
         01hmnIajvk01p36rjKa0ZyPlBLuDVq/ZwZ5bbGSuL8r2YZAvC2yhb86hbiWDyAlGGc2D
         DNnIfUoGCgdwzqdVDBy0EG9CfMLFeTlS+gXOnSmkLpxM9ZdeyfVALDlvA/ceZImPa5ij
         aCvZ1ZAtGsddmOQqFJVZSgn/rOTDWFVYFIu3hR2IFq2OikIn4EbKEbNF7YbKtQNUOqRD
         a4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYiOGPMiP39RHDW20IZSrvlNZXo8s/u6gtQIl46zVlBLpd9YZvTV/EvZqHpOAW3tOjy2VlZog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmxStOpQ6V05GSaallczxsHY6eiO81EPEJm0i/1h8rj8Oco/r
	h0ZZGMbZGQCKmvd0JS7jNji26VGZBaP6XMTC4zw7XrLIFLDWbRfM
X-Google-Smtp-Source: AGHT+IEieWooFaWdks6jsrUAEZUhz3uirji7fp5Ky3o/a+PxwXNiYrZvpbx0Gdp5pqgek90es8Ubqw==
X-Received: by 2002:a17:907:728e:b0:a9a:6284:91ef with SMTP id a640c23a62f3a-a9e3a57390dmr2445325866b.2.1730844885574;
        Tue, 05 Nov 2024 14:14:45 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a30e8sm189389966b.3.2024.11.05.14.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 14:14:44 -0800 (PST)
Message-ID: <9dbb815a-0137-4565-ad91-8ed92d53bced@gmail.com>
Date: Tue, 5 Nov 2024 23:14:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
Content-Language: en-US
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
In-Reply-To: <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> On 04/11/2024 22:33, Vadim Fedorenko wrote:
>>> On 04/11/2024 18:00, Pedro Tammela wrote:
>>>> 'static inline' is discouraged in .c files
>>> 
>>> Why ?
>>> 
>>> It could have been a local macro, but an inline has (a bit) better type
>>> checking. And I didn't want to add it to a .h that is included by many other
>>> unrelated components, as it makes no sense to them. So, what is the recommendation ?
>> 
>> Either move it to some local header file, or use 'static u32 
>> handle2id(u32 h)'
>> and let compiler decide whether to include it or not.
> 
> I believe you mean "let the compiler decide whether to _inline_ it or not".
> Sure, with a sufficiently modern Gcc this will do. However, what about more
> exotic environments ? Wouldn't it risk a perf regression for style reasons ?
> 
> And speaking of style, what about the dozens of instances of "static inline" in
> net/sched/*.c alone ? Why is it a concern suddenly ?

Can you please explain *why* in the first place you're saying "'static inline'
is discouraged in .c files" ? I see no trace if this in coding-style.rst, and
the kernel contains hundreds of counter-examples.


