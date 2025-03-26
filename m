Return-Path: <netdev+bounces-177825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B5A71EC1
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 20:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A652B3BDABD
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDAF2417F2;
	Wed, 26 Mar 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="CjZG8yQp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AD1F5408
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015885; cv=none; b=eSglyRNmkVhM0zm4i1FJyDT4KuM270GRUOmGyXbEl/GiscoYhPH9kHW84Dpi7c6abIF0nTb7jrWNjqNpBTAodd0vUxl03j1ZWtU9el17Fc4hDnHnuZCnry8846SK5gKVifLh2GP23KxmtrjU/g6KKuga2yMU+vSQSx5loh/Rwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015885; c=relaxed/simple;
	bh=rfHhoIVbZ3BoBx02AddJ4AzgsJFbqeECIQSSaM4Z3aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQqvoCRe4vETJU6TAKsUowZTs3lyfMWFCDXAU9/tCguQqfkpYIBVPCUf051tKcYgeH32mdx9KjqirxeHoR3rHy3Z+hz8vZthfj7lnisX/W5KmmefrR52LYXbMqlCK9SOLHR0hBYfjjqapX1HddoQejapJ9zUh6OjqPLymESm6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=CjZG8yQp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227cf12df27so3397655ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743015882; x=1743620682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmcnY2kwOPdE6xPRpclrTNuqdaqCULq7gIKa3GJ0IRM=;
        b=CjZG8yQpZJecojClJvqQM1lCqVEYi9p7HkhUjZys0eeEJabl60iW+KX31i9MjpvKW/
         1PbsDBIyHUFfyQ7w8oTdF6ZGihcVHUzJPnookhiJ6qzxwgk71LQgrIyoJAYDPv/B/ulS
         DVSy6F+rKzslo+7FwoS3mmVENmFa0qmN7SrMr7/ZlNixxisxQ7Ysoanru90N4j2/pdN4
         DC9ZfwgTSBCgisDqW57LEUkZJUuHiCkfHPeTkDENECLTfWPJhWnlqAURUO3g3V3zMf2H
         QfUT/FfRFsUUwJ8tI0RUjRewRrOs4IbaG2m3qOn4A1CpO4H6xug4P5BHlNIXuzgy0ZWZ
         k/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743015882; x=1743620682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmcnY2kwOPdE6xPRpclrTNuqdaqCULq7gIKa3GJ0IRM=;
        b=gN3s1AhJrt2GeTY6kgeyAK4GYHyc9LoClkSgVp3E2RLu0tHoJK4egLcFH8UYSmowC5
         LzDCU0yC1qdv8pDoZGJZ+ctZnnMS7RlNG3wNn860vltYPdFeYLQQrBmP9tIK4uc4ty2t
         vrrM60a16bF6Hunm17FL6byugaLOAHU3psTjYNaJqsHBpLalx/joI9bQsrWoTCrKGM7e
         A0eqYugQyQKniQ8s6DW0QVUNxAeS+N40u+yECTPxxkOknaUhtD38WizTdO6PP5WbxSaO
         ZGk11tq3h+Ww9MPkJfNjNLrgyd2VqIqMwT/m9JG7BjKbaYmJyYYcfpfnnSA0zone2wWD
         3c0w==
X-Forwarded-Encrypted: i=1; AJvYcCVCZSre42/+Z7jRE8FQnQ+U9ZpOWUPoVSVoVWmB4N6g2JRG332Gp7HaHU9NM10LRxk0Un1eZao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cThSDu9GOmQpCB+BHnAGTYlHPmHA4ewjQvdANUkTBnHNG7cb
	0DnTVfd8vgU12+/BnEaNRafkmofu+qgo7Q4gNS77zULqRvCcojtFtwvn0Wx+JQ==
X-Gm-Gg: ASbGncv7YUxjtUV3UMpp689R+qirzM6eel60NrmeCLYggfY8cmns7AYMWz5CO8h9lra
	Ta+zzTk57+XYsmxv/BrRS2okOqFtSfhPohRkYgwI+5e1AA69T8lBiqf1sNpTVho9iEfbxAsDDDC
	h2iwj5Ki/LOXRt4lc3WtdeAbMi3hwMdx7/bAmRemVlAYo/tubPUCUusnhnrs/5G08que3/Txmz5
	BaBDeOkfdZnrdAbidtxTosbYJLmWAGc9/GRvPf6R7kTwF40l9vqUAI/O7FzKfPRkn7usp1foU/8
	hrJS0aFW5sd3LW97i2dT63sYtLnaQp09j5lV5F5/zBiCEp+sS50PQZu/3Tv/r+r1
X-Google-Smtp-Source: AGHT+IHyUhKr4Xzl050V+YJQc3GIgp1u41+Q9Deq2+BbI+VW4HEXdhr/18dw89ZNIQck1Dk7SrYlYg==
X-Received: by 2002:a17:903:2309:b0:220:fe36:650c with SMTP id d9443c01a7336-22803b41a90mr12639625ad.23.1743015882418;
        Wed, 26 Mar 2025 12:04:42 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bafabsm113370495ad.139.2025.03.26.12.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:04:41 -0700 (PDT)
Message-ID: <d6231806-8666-4b07-982c-7061ca352b59@mojatatu.com>
Date: Wed, 26 Mar 2025 16:04:36 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
To: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Torben Nielsen <t8927095@gmail.com>
Cc: Jonathan Lennox <jonathan.lennox42@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Lennox <jonathan.lennox@8x8.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
 <20250304193813.3225343-1-jonathan.lennox@8x8.com>
 <952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
 <20250311104948.7481a995@kernel.org>
 <CAM0EoMnmWXRWWEwanzTOZ_dLBoeCr7UM4DYwFkDmLfS93ijM2g@mail.gmail.com>
 <20250326043906.2ab47b20@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250326043906.2ab47b20@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2025 08:39, Jakub Kicinski wrote:
> On Tue, 11 Mar 2025 07:15:26 -0400 Jamal Hadi Salim wrote:
>>> On Tue, 11 Mar 2025 10:16:14 +0100 Paolo Abeni wrote:
>>>> AFAICS this fix will break the tests when running all version of
>>>> iproute2 except the upcoming one. I think this is not good enough; you
>>>> should detect the tc tool version and update expected output accordingly.
>>>>
>>>> If that is not possible, I think it would be better to simply revert the
>>>> TC commit.
>>>
>>> Alternatively since it's a regex match, maybe we could accept both?
>>>
>>> -        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action reclassify",
>>> +        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1Mb|1024Kb) mtu 2Kb action reclassify",
>>>
>>> ? Not sure which option is most "correct" from TDC's perspective..
>>
>> It should work. Paolo's suggestion is also reasonable.
> 
> Sorry for the ping but where are we with this? TDC has been "red" for
> the last 3 weeks, would be really neat to get a clear run before we
> ship the net-next tree to Linus :(

Jonathan's issue is solved.
A new one popped in iproute-2:
https://web.git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=afbfd2f2b0a633d068990775f8e1b73b8ee83733

Changed the nat's "default" ip address from 0.0.0.0/32 to 0.0.0.0/0,
which makes tdc fail :)

https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/50205/1-tdc-sh/stdout#L2213


