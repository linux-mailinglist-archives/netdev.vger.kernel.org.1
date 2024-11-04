Return-Path: <netdev+bounces-141702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117229BC0FA
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DCC282C9F
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE531F584E;
	Mon,  4 Nov 2024 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCCZuN+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68883CD3
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759588; cv=none; b=LKZKWKCmHoyR+GQlRGqEDjplZh5muKFVVBJoYRPpSWBWC1oUMVWzI84yXOA2dngtkfey8gSLWki3oFN7uoW/n7YzYy75NalaQ5XmGnDN0IXFVW7F2eeNdQSF1cxjo1Pko34vMznajxl5JUSSk+1DeUNQCrsxVY5vL50yRsJveeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759588; c=relaxed/simple;
	bh=H8YtkDH4F/c1ql5UC1SMin02/yNzsUKDkDJLk9QvOUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wmvcm/tdYnbxQxGyRaUdCLvc8R5abQdCpN/vuUY8uDrD4FYpl5oKIDNxSamjvN0AwJIlP11QoFO1qHUmxQHcMqNVMbXxi/w7vrM/j5oeWvBwyGb6DdfuxnMy7FRUwR+p2GeJjb/LhJnb9qE4+6aCeo6ECoYAgMB5Wc+E5SVsmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCCZuN+Z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720be2b27acso3892780b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 14:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730759586; x=1731364386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9GdW7AiR0FEox6HNj6z+U6I0iKnZfRoCTHuxaE0yh9s=;
        b=HCCZuN+Z2ubruP9xTrCvJybAPzQ/jAL02CeLNt4dpTlRmpWa9atS8MfS2TEe2za7NF
         0cdDG4d21jsSrhWbl/dXENBTprHIc3v5gVw2MYA6POmXJEDDjKDViacPe+xK3pZwlQbL
         pSI3THHK/ffU4RVcVd9jqPnjGb7E/rwHVjjKxufDxAsazA1bEgy71rSKMWUR3FykSgDd
         L0ojVLI6mqPw1O8po4O2bSD25Yh0NxuKKdSnWGX6nRiFjHlX7jTObe7L+315aa5OrIOB
         qd+Y5LLAAlzqtFUA3Ra6BhXXjsw928FWHs7mgtkDVpHKmTRBYxv25ptcGh8Fb4A4JeKi
         V0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759586; x=1731364386;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GdW7AiR0FEox6HNj6z+U6I0iKnZfRoCTHuxaE0yh9s=;
        b=f0xgIfb6NVp2S2RJXq7dYkof6xNZYHvd0R1rAwzA7AUaJXmcBwQ2IPCEu5s4SNZYPL
         nQER9TF8slWbxa6jpJWI22+gMxbb+JMvUG5IeU+1AXHxFvdhOr1k6a5gDJxAn2UFaiIy
         KzdQxAolbKoHT4z2e7UeDym2BUcyZOrRxfRFXKqKuKI4y4pIZzjzosteko8DVHiFsbHS
         wBX7PCP2kX9pPFOybz29YGZyg/R3eOdeMqockYunsuPja/FnKmsZFOXmYbjrUjzs/TuG
         Sk3AOjaSP09DwYtjuPh+LDrCzalejwFUoew4Iehc8kKEhEHFn5j9H0if42OOSXS6TgdZ
         adyA==
X-Forwarded-Encrypted: i=1; AJvYcCXKm6HG5O1//ANae4uBpAN2r/lFke+DRbaedW6BjXuN0jI1vy0i6h1F0VZ0tlLsghzZ8j7PxiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu26N+UPNCVQZMJro3GT+GkKrL4bGDVzjDVaDwK60jMrO7meDl
	yjzdR3KiXQLJHnFEK+rnARWWbZe/Cg8Bni1QKUNFy66fGjeFtAau
X-Google-Smtp-Source: AGHT+IFnB1qGrKjn2oYW+u9R1dk80hQD+4Un83eoS2liYaBxDxB8RqU1aBq4JwvtAOLtYQI69hdvlQ==
X-Received: by 2002:a05:6a00:17a8:b0:71e:7d52:fa8c with SMTP id d2e1a72fcca58-720b9d9496bmr23447651b3a.22.1730759585896;
        Mon, 04 Nov 2024 14:33:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c4bdfsm8034842b3a.130.2024.11.04.14.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 14:33:05 -0800 (PST)
Message-ID: <c565465d-ef03-401f-bfd1-166e7688cbb9@gmail.com>
Date: Mon, 4 Nov 2024 14:33:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 13:51, Alexandre Ferrieux wrote:
> On 04/11/2024 22:33, Vadim Fedorenko wrote:
>> On 04/11/2024 20:26, Alexandre Ferrieux wrote:
>>> On 04/11/2024 18:00, Pedro Tammela wrote:
>>>>>
>>>>> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
>>>>
>>>> SoB does not match sender, probably missing 'From:' tag
>>>
>>> Due to dumb administrativia at my organization, I am compelled to post from my
>>> personal gmail accout in order for my posts to be acceptable on this mailing
>>> list; while I'd like to keep my official address in commit logs. Is it possible ?
>>
>> Yes, it's possible, the author of commit in your local git should use
>> email account of company, then git format-patch will generate proper header.
> 
> That's exactly what I did, and the file generated by format-patch does have the
> proper From:, but it gets overridden by Gmail when sending. That's why, as a
> last resort, I tried Signed-off-by... Any hope ?

You might try b4 send and see if that helps: 
https://b4.docs.kernel.org/en/latest/contributor/send.html
-- 
Florian

