Return-Path: <netdev+bounces-211143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1C8B16E1F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3515630A7
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B418628E5F3;
	Thu, 31 Jul 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WedJKqHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E626E71A
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952853; cv=none; b=Dp8Vdv3RZ6QaQR/9bIrlpQ8sB90l59gL23BOqAYVx04Di2RcKb7C5bjffPALMYeHVJZpXmZoJDOLmb/kTXx4dpMWJhHoglVBs16QJQxYjgspdZFVXrkCSDsPKgqw6sDY9YKpZNQElToWQWy8oMtIanuD9TivBvTanNTEFnbBWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952853; c=relaxed/simple;
	bh=X1kwN4TxmRWzdYqOdxnTc9uBDdqiUjDYqZ/TFo9+BH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxA7SmY/fhDAPFFAQIpHI8yapA8Me/7AWC6CI/Qe+XwHhoCnKOQbVQ972lLlDPn9TsM7vr+XnDY2mpijkFi+3M32/KvaLxTV7/N67gor3MosibDDzdNQ3UTRTFuB+UAyKZnh965jbaexYsU4KoGDenkV6tsvCB5E2KXcaT7bX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WedJKqHi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so965845a12.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 02:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753952850; x=1754557650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzwTiolPuRjB0X7WycrdISjM7D8xvIgiqtSrCy1xiYo=;
        b=WedJKqHiPIL79Mad3WXB7FaDL4PQ+UBv6fKEkw4J0zftsWYJO053xKv02QiP3/wSai
         xJCMMtoXVONNjjoN06eXlCxuruv/roIfBgMwTU4l9etuLMkKMLOC0fxxurOBL1qg/6iK
         DMhL2ly81gSJPGcfp1pBfzt7XAjsqhE4Hao7WJZC/kJD7bXRe4r15ARt6wNPUnws3Hro
         EtCSa/rjeHm3VvCSdDmbrsjaVVT5zlS4rh9nCWfVEkQeAbv7gtYpTOqbGjcR+p/KA2gg
         CFj62EZ0z8FiISx5Lg1fHMeoKUEWLsaUAA0cX2nfvdr/kP0nmfBh2xdu2xSQbX13JOVs
         x9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952850; x=1754557650;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzwTiolPuRjB0X7WycrdISjM7D8xvIgiqtSrCy1xiYo=;
        b=RzRxaR6DuEGy03aR7yZPuqaMePbV5kvDvRqY9srkAuy8Mfgn/lnCEIN6QdcrmZ85gv
         43aDfigy396Mz86Unmt6KEtLZ82xJKuA6ATXz5qqwW+Vp1R6FUmhKfPTgBF+I9nDzrF1
         veQMP9SaawGGhDTVbjjTGz3/GhQ/injTRszCoqRftnM7A4RB5wUv28a6Ld1Qqw/WIXR/
         5nfrgtHIB9TJz08ChUl417Hd/vu9TOz5oLXCOESc9dIYguZ3w/hnCqjcIhGNjlOssxD9
         Bnv1YDJkfFyvFRYd4zsjk1rjITj9RcTBd2hGbtLFfl3+RY6pOA3tXUHQ8tlioJaM9+5d
         L2ug==
X-Forwarded-Encrypted: i=1; AJvYcCV9I//oazxftPqoUUC4PrnUHOL0EzgnvCvUOCnVjNUTIn/oakg7LGglIDyJgW5ayxJlt+5oxEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbEMpuNtjXBlwLeKgMEZZJm4q649BBchuRBamU5FNk5lRrrXAW
	31lAe3MhMTUY6GeR09kDZODs7itfS/5XpfzXZaf3PGlaKka7SaUqDiiFYSIgCsmTwo4=
X-Gm-Gg: ASbGncu3CnhfSexOZbOmCtD2zElOe+PT62r8jPPftH0CBGDyDBfVFAVpVM9c0AqaTyj
	qV79MxROFPzQQpeW2Pq8OE9ZL8UqNb6pAYhFXioAKH65/T/Wh3WfTKMBoNZ1pZBp8rl6PQFUJql
	SLPUMAqGPSkgdCn+ykMR3+8/rlEUDwlEwFLgaAXTqaKyd1Yj0pbNfuyG6cuRnKwnOX/Ugi8xQo9
	nCPHfFGaPewCpFzljt+UjRtaV0jeu8MYK4h/zCgBxxmLsCDVIfY1uYgqitsM97geX0ySmp6QUFg
	pr4Et62+/SZaqKJDa6fNSK/rVlQJBN3n7IXhjXV8zBYqDJnFkjGOc0pDaB8S9BUTKDXk2OoX4nU
	K/AeSVSl/Cdp9Rlb9k4xXjZlEAidtEw==
X-Google-Smtp-Source: AGHT+IF5S+yNfX8PIBxcKUES4hdUNnQZdC3WoBiygEE9/2AzPO8Uz+wNH44HGfFrLs0jY6f3kUBr+w==
X-Received: by 2002:a05:6402:7cc:b0:615:4fdb:2163 with SMTP id 4fb4d7f45d1cf-615871efbd4mr5310229a12.29.1753952850302;
        Thu, 31 Jul 2025 02:07:30 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2b892sm764095a12.25.2025.07.31.02.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:07:29 -0700 (PDT)
Message-ID: <7b4d7b89-a69f-453a-bf9c-d0ccdd12d76e@tuxon.dev>
Date: Thu, 31 Jul 2025 12:07:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] net: macb: Implement TAPRIO TC offload
 command interface
To: "Karumanchi, Vineeth" <vineeth@amd.com>, vineeth.karumanchi@amd.com,
 nicolas.ferre@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: git@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-6-vineeth.karumanchi@amd.com>
 <8c34af6e-9cd0-4a2a-b49a-823be099df55@tuxon.dev>
 <c810ec30-51fc-427b-b6f5-15c3284c0ef7@amd.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <c810ec30-51fc-427b-b6f5-15c3284c0ef7@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.07.2025 12:38, Karumanchi, Vineeth wrote:
> Hi Claudiu,
> 
> 
> On 7/26/2025 5:59 PM, claudiu beznea (tuxon) wrote:
> <...>
>>> +    int err = 0;
>>> +
>>> +    switch (taprio->cmd) {
>>> +    case TAPRIO_CMD_REPLACE:
>>> +        err = macb_taprio_setup_replace(ndev, taprio);
>>> +        break;
>>> +    case TAPRIO_CMD_DESTROY:
>>> +        macb_taprio_destroy(ndev);
>>
>> macb_taprio_setup_replace() along with macb_taprio_destroy() touch HW
>> registers. Could macb_setup_taprio() be called when the interface is
>> runtime suspended?
>>
>>
> 
> Nice catch!
> 
> I will leverage pm_runtime_suspended(&pdev->dev) check before configuring.
> 
>>> +        break;
>>> +    default:
>>> +        err = -EOPNOTSUPP;
>>> +    }
>>> +
>>> +    return err;
>>> +}
>>> +
>>> +static int macb_setup_tc(struct net_device *dev, enum tc_setup_type
>>> type, void *type_data)
>>> +{
>>> +    if (!dev || !type_data)
>>> +        return -EINVAL;
>>> +
>>> +    switch (type) {
>>> +    case TC_SETUP_QDISC_TAPRIO:
>>> +        return macb_setup_taprio(dev, type_data);
>>
>> Same here.
>>
>>> +    default:
>>> +        return -EOPNOTSUPP;
>>> +    }
>>> +}
>>> +
>>>   static const struct net_device_ops macb_netdev_ops = {
>>>       .ndo_open        = macb_open,
>>>       .ndo_stop        = macb_close,
>>> @@ -4284,6 +4316,7 @@ static const struct net_device_ops macb_netdev_ops
>>> = {
>>>       .ndo_features_check    = macb_features_check,
>>>       .ndo_hwtstamp_set    = macb_hwtstamp_set,
>>>       .ndo_hwtstamp_get    = macb_hwtstamp_get,
>>> +    .ndo_setup_tc        = macb_setup_tc,
>>
>> This patch (or parts of it) should be merged with the previous ones.
>> Otherwise you introduce patches with code that is unused.
>>
> 
> Clubbing all comments on patch organization:
> I see that patch series gets merged into 2 set only.
> 
> 1/6 + 2/6 + 3/6 + 4/6 + 5/6 ==> 1/2
> 6/6 ==> 2/2

That should be good.

Thank you,
Claudiu

> 
> Please let me know your thoughts or suggestions.
> 
> 
> Thanks


