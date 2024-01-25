Return-Path: <netdev+bounces-65810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105CB83BD12
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B600B28D2CA
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23B61BC42;
	Thu, 25 Jan 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sE4IMfbI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B421BC3F
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174391; cv=none; b=E6PZL8VUfz184eBL8OP+NYy4U4qLClHICqGXxPxtfBS/6ohC27V3UKbhVdZ9Rg+VjuojtWEr3kE9T4NgNenVcgaL9pHwPII/iZ+q4JN1b/W5K9vtdcotXKXOfZSjb3pm/Hyt4DThV/AWbj5nBwa+F0rLW6046dXPxpgoh9M4x7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174391; c=relaxed/simple;
	bh=hY4QKISaa+b5z3JLeMajVJ/VnYmdjxa6qn7nKSvIo14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhSRqeJtyXQL0YRtuXoeV4pojGgEbTk95Q7QKxXdHv0+rrVSNSHZte6FOvERIdwM2TcSpdPqkpoiuSpf2r3WMAfzcMxrcY80wO7+lg4dKoQZwySC9yQSzPbLv6H+QSTUBzGBa6jjlKPGFHINcugkxVM6248GijgfW+nOYo0sUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sE4IMfbI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eccf4a91dso10773415e9.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706174388; x=1706779188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X+3bRBtP42tNMXuYBkK8DKxTBN/GwDVxxSGraNwbGQ=;
        b=sE4IMfbIpRo00gYefnbsQR0nPmgkLSLGkh/4XXeZDudhMd41NoKDs7p6OluN86qAGh
         QGpTGPQbi5TYrpNjObhcVhZogtB8Uy3M8MD7Qcu9Tn+MmbQxEEqtte4i3aD9BNvyIcfj
         rv9woXdGxHvr8Md0xlqatKA7nQZRYpkajKFUwHzPgqFQgGzEgvBAbR9xgc0RkIpk4qOr
         Ji2lTv+zIBmuqrgBtH2rs4voN2deop/C4HL+1JjcpJ64IEgaVK0Xbx+bf6oucsUMSFam
         a1F5+GN9p6GhpqPVOEv/FUNOEzF7pA60iqULsznXMW8aOl39qiuIXqF3Yt+SsFMlp+MX
         dSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174388; x=1706779188;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X+3bRBtP42tNMXuYBkK8DKxTBN/GwDVxxSGraNwbGQ=;
        b=HpfsuqNZvwwOaMlm38Vub/jyvR7ImEW5iEy1qpI8QfrQq5NGAOR6G5sGnNTma9JEj2
         NZJnY0KggpNWYXoMgOfWg87l/YaRkB7Wb+oFlphhAGEzRqIFJUpA+9U7cXKK02XTGSBA
         b/bEB2NbjmmdbM4/C5NkaS5aBbX2PAh3MnzocsG+jaTdyo6WqYmsT7pbPcDLx2BFexOH
         5Y/Ig16JjLcPxLiUqSsUQNgu+8hn9lk421pT4OMD+SCEPuySqft9PBxxzbASixYeIdGW
         lG8h8HP20P8J67jr5HZN55s0ssQKCZ/Xd1PUmNNc2KDqiOalzQed/sbwRXHudJxIotmH
         47LQ==
X-Gm-Message-State: AOJu0YyOhHs4H1ZhXNW0SIxvqFeQ/6bydmJoQEg949yGHTLLfTPCTtOj
	4Ej50ugZYlR2437dQr1RPB0zrgD0oeHWlMZmJldVt0uqIM+RHzR3LOJeLXQsQng=
X-Google-Smtp-Source: AGHT+IGSM37j5cCGKBhXBHBBRNisZ/yCBYOSZgstZR6wbZOnSOh1QlrDSppejQ5MaYdkyJoWTcHb+g==
X-Received: by 2002:a05:600c:310f:b0:40e:aed3:e9b5 with SMTP id g15-20020a05600c310f00b0040eaed3e9b5mr284589wmo.103.1706174388180;
        Thu, 25 Jan 2024 01:19:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040ecd258f29sm1914308wmq.0.2024.01.25.01.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:19:47 -0800 (PST)
Message-ID: <3adf7908-be27-4125-ae5b-6f2eb6100304@linaro.org>
Date: Thu, 25 Jan 2024 10:19:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
Content-Language: en-US
To: esben@geanix.com, Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
 <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
 <20240124-reptilian-icing-a95b20f123be@spud> <87bk99hj7q.fsf@geanix.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <87bk99hj7q.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 10:10, esben@geanix.com wrote:
> Conor Dooley <conor@kernel.org> writes:
> 
>> On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
>>> Time Based Scheduling can be enabled per TX queue, if supported by the
>>> controller.
>>
>> If time based scheduling is not supported by the controller, then the
>> property should not be present! The presence of a property like this
>> should mean that the feature is supported, using it is up to the
>> operating system.
>>
>> That said, why is this a property that should be in DT?
> 
> It is added to the tx-queues-config object of snps,dwmac bindings. This
> entire object is about configuration of the ethernet controller, which
> is also what the purpose of the snps,time-based-scheduling.
> So yes, it is not specifically about describing what the hardware is
> capable of, but how the hardware is configured. It is a continuation of
> the current driver design.
> 
>> If support is per controller is it not sufficient to use the
>> compatible to determine if this is supported?
> 
> Are you suggesting to include the mapping from all supported compatible
> controllers to which TX queues supports TBS in the driver code?  What
> would the benefit of that compared to describing it explicitly in the
> binding?

The benefit is complying with DT bindings rules, saying that bindings
describe hardware pieces, not drivers.

> And for the purpose of the above question, I am talking about it as if
> the binding was describing the hardware capability and not the
> configuration.

"if"? You wrote it is for driver design...

Best regards,
Krzysztof


