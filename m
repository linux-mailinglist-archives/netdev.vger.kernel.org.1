Return-Path: <netdev+bounces-165866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B091DA33918
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F24116483F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636920ADCF;
	Thu, 13 Feb 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGcomxdF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8092AD21;
	Thu, 13 Feb 2025 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432650; cv=none; b=jsWdfNyle7ZccVTQ1PZH5Cesj4m26+52XSQJKWCBebc/P1bIyduBsWZeZ/U3MioSvj3YsQ8EMBEzLlGUjYHnqwsS2zE5jpv0wZLIeSTuucX0zp1kDUGXrXLP8Eg3mxzXMee6blWc4mqsJR16vC7/YC+rNgpQdcZxH+N/6/pMF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432650; c=relaxed/simple;
	bh=wyNWTZqyT14mqBhlFNkvE0qmeYGciMyAfZIa1EJBy1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+86gNosbbJVGm0rGr/HxoTk1ppLOZeeshX4avHlpTcmBR4sFjnO+CL1hRPv2cS5YQ652tbcw6Qb/f7o+r6+mmX9jR/Yh9fyi9ZtKH7w0/TDlWEJty/c0/+yj315iWP+66IVxxbCoKeww9lAVSFVgXXwZhQumw/QJuFxZB2zHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGcomxdF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c2a87378so7479315ad.1;
        Wed, 12 Feb 2025 23:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739432648; x=1740037448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mqh7zZ0I7zeSAxr8UviTFxyLQBRowHjzSl1AKJt5Ww=;
        b=NGcomxdFBmu2I4SjUkUalM5aL0FP7SLnhG5Yv+VGbWRev6CidcK9oK9uGs3gvuzDTO
         D+uknhXuOtOOZLOQeMtOxP5qsXj/MWwtkJ9XTHWuHVzWyb5VSko3JdNZMy0jZfGpBmu2
         E7pdlKfXhrteNScUpK+Gq8kKFkyfOxCiccig2xLcimXCPv9qdD1QOBzy2cy/GWxRzs/R
         WHwb2pKD7E1+gE+ukvYDJ+gbqY/pa7M+ZG/4ED3ySJ2Qk8w9wfm0f/7mqoORPIupeSvM
         91m3oJdhTGuSRPA4pYRQd9oUVgMymYtkIHOK/hE7fPFGv+EOcMQFbEXlmVolajPJAYTo
         K4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739432648; x=1740037448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mqh7zZ0I7zeSAxr8UviTFxyLQBRowHjzSl1AKJt5Ww=;
        b=qJnDsuV1Evfc8MQIH72eoTvTlSrID1imJmgr+pmVCm+kAlzu+IWDBXX5NYQtRMBFjA
         tMXrbYJDZTTv1JfKMvwqqSTovshLnzNwuS9yetW2F+Jw6BXUlfjuvs1O0umkN+NCbex1
         fdB5oURmMGZVORMmfH4BwClYQ58KgSCi/X0Xnl4PWXMdm2EdyTLprXl+v19JL+O4HEiD
         hg4xNih/MMDQmw6Za9y/urLTo5nRJ1LU4DzSn0WZwEObHTsbcPILkJvlRkSVXKpRcFEJ
         M8BUdM29qMXqSnkTlWByvJNjgdahov+2nm/N4BwV6aVaXjdUpwCzPoiyBMgYmW0VjUgV
         VkPg==
X-Forwarded-Encrypted: i=1; AJvYcCWBNZE0zWtrZqsAOUTjO0+ZcVKjZ5FB9wJzhJSTTmsufehOfWGANz2d/asiVN9VesBkRu6Bk9tR@vger.kernel.org, AJvYcCXG4eWVKZG85BEOIwasQTurWXzVEiaec4D4OiPl//HrlNTTx2MTI2dr+EeZh/Y2H6WhcuHJEdzn21Vf76c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzUCuGTMu2Enu066K6MlxzcZS1MfewfGcNYVntq0PjnMikPSE
	2tAeTi7LMTDqJknO4FAxs+bLbpT4eihNyjXEZO7sRIj4S/XjAsjSECYmbg==
X-Gm-Gg: ASbGncu5AG9wqrOgjQnnVtgEitB8o0swZ7atxv3+VXaW3rFa4VV1ldFzLpVFO2/VO5C
	fANiCxb4fMhE2CpvJ22ncdmR6A9Z1aSZgNEYoYe9S7EbnaiQ1XHZ9+IHoO/RGPFgqGZA7ogh9fM
	EL47d+Sh8cRFhUsKPR0IWGd/OxgIZ7r1pIt00R/FkpQUiNI0wqtUg6dlGPLuY/mLMljkgz0bEUL
	WxEhAnu3MAKhWGEIOHtSfSy0rOBvGZXnspB1ltdnKjtLOv4kAVN8hhObUywNViQy7T2YFzn7nOT
	GZs2h+4bbAtnjZW2CY7pJcBJFWbozkGbo9y2CRN4cW5CZRbDg5U+fHmrmizQkA==
X-Google-Smtp-Source: AGHT+IFHQS6eEilAMEI1v2dpXp+IU6XYG73J/JaujKHloofn3UWJh/KpiJBv+PIkFgtREXUb4rjfCA==
X-Received: by 2002:a17:902:d4c7:b0:21f:522b:690f with SMTP id d9443c01a7336-220bbc7f716mr104718035ad.46.1739432647807;
        Wed, 12 Feb 2025 23:44:07 -0800 (PST)
Received: from ?IPV6:2409:40c0:2e:ea4:2a47:1135:5e3e:7a9a? ([2409:40c0:2e:ea4:2a47:1135:5e3e:7a9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5367f38sm6685205ad.92.2025.02.12.23.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:44:07 -0800 (PST)
Message-ID: <13c2e9c2-7faa-47f7-9e17-2bd21c34b0c5@gmail.com>
Date: Thu, 13 Feb 2025 13:14:00 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
 <20250211003203.81463-1-kuniyu@amazon.com>
 <dbdcff01-3c46-47f2-b2db-54f16facc7db@gmail.com>
 <20250212104845.2396abcf@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250212104845.2396abcf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/25 00:18, Jakub Kicinski wrote:
> On Wed, 12 Feb 2025 19:54:16 +0530 Purva Yeshi wrote:
>>> The 5 lines of the 3 sentences above have trailing double spaces.
>>> You may want to configure your editor to highlight them.
>>>
>>> e.g. for emacs
>>>
>>> (setq-default show-trailing-whitespace t)
>>
>> Thank you for pointing that out. I will ensure to check for such
>> issues before submitting future patches.
> 
> To be clear - please fix this and repost this patch

Thanks for the clarification. I'll fix the trailing spaces and repost 
the patch shortly.

Best Regards,
Purva Yeshi

