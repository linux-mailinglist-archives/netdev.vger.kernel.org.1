Return-Path: <netdev+bounces-64934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A18381B8
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 03:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C97B25DA5
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 02:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483AEBE71;
	Tue, 23 Jan 2024 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CvEZrocE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C020E4
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972571; cv=none; b=BmTy6sAk47JQNUI/gdFLhqPN5XLA9DLWgX7Huyhs/dO9RWmSoX6k79K6Y5O4ckTabEBpIxtwTDJC0bgZzQ4m/eewsdJM5LW1tqH3mm1+QdhYS+v+2fvFr6ohap7VMIGHJjwOgh2+pQ5ddsVKONPqbpW+I8uj0H9oyc29xoWXoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972571; c=relaxed/simple;
	bh=0gaJNYNtvJur/J5lxvsxKSl1C0Lm8rbo2zddGiAeMfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW2VXyPS++s9jS7JwLe+hZGUiX8o7pLBo2niV5UzGe498hujbssLKCgQj2n+7ppWBSwZcIf/TsCVNuA+1Kx08U/7anM5fiuJIr/WOCZwDTShEeNJdVly5d5iTNJDsHtRGlAX1PvYZdLlPeOcRGnTMKcbl0BY/2c2PYGnDJXJFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CvEZrocE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d74dce86f7so13214155ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705972566; x=1706577366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRktP3nfYOibrH5JpoRKqwlX9uu9YWIvE2OvGhdJacI=;
        b=CvEZrocEiLFKYrRfoHre4yXSgzfJLmslAqye0gp40Xnd96STqyU/BmmxN22BPr4Ai7
         t4TUbiRl9Rik5k81+HC9uchoZ2GVU2q8qserr1CYjo3Ix883O95FJYr1Twlw+x3joOs6
         +lE1dKF9qYRIJG5RWdLHGnt5wf7JAMoIuk7C4qhpbG0fI37+zFDy9WpkjPULuGNKg6/H
         KtfySoXyB9SbsHPOAs3MDsGpMi9TFm1XIDDN6lxlb0lX+Xk2UBsO8rYIewnOtMotPrbv
         itOAcJt5HxM1ocybqn2sSYLRakhRG5Gz38oLJ0eI+KH0G6aXEmpIFkkEOI1xZMvkhyk/
         pLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705972566; x=1706577366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRktP3nfYOibrH5JpoRKqwlX9uu9YWIvE2OvGhdJacI=;
        b=FY/llXYdvfvqDF5aC8Rvs04Q+boLdfcZEsPT1QypdRy2b133+5YC3JWvFzGG2vpO0b
         SdtcQ5ym1Kezt2/6++6d2+YEDNVbviOr1PApE0pZtLqJcZqYG3KhtU1uRwWgjG7hQdGc
         0i95qus6gD5R58SBqLoCO3FhHeHl5YWgNPbT5CPyOLT+YmUgKUoCGylOygYt7CHd4B2t
         vmVrmHxMd9L/GbWpyNtdiMIwXkBC56Rf8sc/FZwTfMlEN0fRr9xohiduRwLs4zXOrNvY
         9aekgpGoJAxY4YsjEZ/61Fm6Tk0NAbR6HZ8tDd+s/3Z4sAslxeDVONqB5SGQi5LXpruk
         zimQ==
X-Gm-Message-State: AOJu0YyATy9We0zIzh99fYKEwzM1Lq0ai8oFX2oaipRBaQva7uCM/H5S
	ZRLQf4X7o3cd09f6zbys5OAS13Nbwib44ajNeOjogsDWKpLX+AiBwBM6spAH/RY2RN0CqCSd7ox
	xhw==
X-Google-Smtp-Source: AGHT+IGrLlRe1uH9BFdQ+qtAv2hpUg1WN+TSqITXQy3ftP3KeJ+QSV0BI3lYG4hq3CgcK1P7OJbd7Q==
X-Received: by 2002:a17:903:32ce:b0:1d4:5268:27ed with SMTP id i14-20020a17090332ce00b001d4526827edmr5863139plr.21.1705972566023;
        Mon, 22 Jan 2024 17:16:06 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902c78200b001d71f10aa42sm5971784pla.11.2024.01.22.17.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 17:16:05 -0800 (PST)
Message-ID: <5185d9b2-c203-4fdd-b7f1-4d8f35c25906@mojatatu.com>
Date: Mon, 22 Jan 2024 22:16:02 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 1/2] color: use empty format string instead of
 NULL in vfprintf
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20240122210546.3423784-1-pctammela@mojatatu.com>
 <20240122210546.3423784-2-pctammela@mojatatu.com>
 <20240122164336.12119994@hermes.local>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20240122164336.12119994@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/01/2024 21:43, Stephen Hemminger wrote:
> On Mon, 22 Jan 2024 18:05:45 -0300
> Pedro Tammela <pctammela@mojatatu.com> wrote:
> 
>> NULL is passed in the format string when nothing is to be printed.
>> This is commonly done in the print_bool function when a flag is false.
>> Glibc seems to handle this case nicely but for musl it will cause a
>> segmentation fault.
>>
>> The following is an example of one crash in musl based systems/containers:
>>     tc qdisc add dev dummy0 handle 1: root choke limit 1000 bandwidth 10000
>>     tc qdisc replace dev dummy0 handle 1: root choke limit 1000 bandwidth 10000 min 100
>>     tc qdisc show dev dummy0
>>
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
>> ---
>>   lib/color.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Wouldn't it be simpler to just add a short circuit check.

Agreed

> This would fix the color case as well.
I missed that one, thanks for catching it!


