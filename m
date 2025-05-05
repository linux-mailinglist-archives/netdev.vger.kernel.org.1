Return-Path: <netdev+bounces-187809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D8AA9B73
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336AF7ACAD1
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0257B264A63;
	Mon,  5 May 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="wcQdYPMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D026F463
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469198; cv=none; b=nQdyzdmaL1O97k5FMqlyQk0BPaznsLWrtnWCfamggKSy46SAKeFkEgqly6GqW+79F58MoF0OLGlxpUmsNvxlcYW0lXrhQuT4pC48taX7gVaaC7w654CMDdrMgc++rNDlrQ5U7QMowqKlRiCj5HTuhIZDhS167KvjSkuRmRAwd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469198; c=relaxed/simple;
	bh=8pRu+3AHVgzwTzcQCeJYJhr4rld9Ynb0/Nk9xfx6dNA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F7B7NHwzWIg0t65SSFf4Kci3mJF/A9jlLFheTlRwc49wbRD1dVrZH0FyuFLcToLbmaNieOgzG47SwATY7GbDN0g+hJ2uFq8QPHedfuCaeJ4+lCR5Sk5zbqLUb37TK79Ch9vi5nMNg3P1PY8pmfBzPeTZmEkwIPJA/X4IDMSE4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=wcQdYPMU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-739be717eddso3877067b3a.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746469197; x=1747073997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJ22LSlzWo9zjR0Ke3Tjb1iwiGFv2JDlljbA0HY39X0=;
        b=wcQdYPMUSy9mfti3ASoBGVl7oxj4aBZLFqOgch7glG9hEHQTzYL2kzqcmi/Oo79yoW
         r6M6c+zuv/N7CJoebgEC2MbKLyFw1QXgYQ21CvJD/HRLjXfExms+OS9Xnp53TUtrfwIX
         KHCqWPXxbPaaSUKVkGNp08uErqDQwdQb+wEbKhWnjiHjSAGCEy7BK29dY2HbgWLpIw3D
         zOE+QEDmSNjXbZ4xEJ1a07SNtGHOjCP5NtTt05nXg26/iWFggYfpM9qkzuPe4dcxpSGs
         Hpc1H2/nxUSj0T7C/BflffrnUIEpYChdMUUiNQ/iItdoezwOxXhLbshkV6rUWP3W5GmH
         Lqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469197; x=1747073997;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ22LSlzWo9zjR0Ke3Tjb1iwiGFv2JDlljbA0HY39X0=;
        b=DcZPz0erf28iZR6+Sjil1WBobpNBdo8z+XO3jGKxZFc9dnW21pxW51GsEbuvH1XCHp
         mLLKjJcqSFau1ShS2+atghjahMIgpS/y+j4KSgKs4XVoZltKA6WcMRv+pW+M1ozvpvLb
         b1JhDEX1ZZK0qT76RiCsj6S5B2yPuUqhVnLt+Cb3QYUTb8BO60WSya5H0HfOH0l7NyLe
         PQHN+XoDKEO74GBc7S4ckT1Ga44mhNPY/YMI7a6AefRwF8x8aEs95cMxYxly4t7dLEtb
         SCqJ3OzstW8cEE/LbUelwcp1sbjo56DjrvqEFj3CNEtwkw1xokMz6G9vf50QmJsMsPay
         2A+A==
X-Forwarded-Encrypted: i=1; AJvYcCU3FpckK/bo0e22kYfWCA2kJ+CEsAlsX8gshZ94a2do8iZ8gIfIT6NJa/1lJ2v7FtR/hnb6CkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56OItUm4MBFFC/Wc/PR1gHgzj5WmC3zd14Ah0F0sQ83zs2QVj
	L+Az88fqKmEa3P/X0TZEvJoVHzOaEUH/6lnivVIh1gAgvfm5anm5wlRI0g4OsJA=
X-Gm-Gg: ASbGnctuwPPYZJVnSIWOhqVXwSt44DljZhkTfUMqfRFPVyh7DuHPe+rFBGG7/reXIRW
	I7eWvWaWl7vD3sGTX4TW+nq2F42lTGkk8N7DEmO0PsPk+AgRU7EidtE/JGSxsJI2BJGJ2bhDdVK
	0pUGfyN4d6+aM0pzOEZlKxTupirao8pD9iFa2Xbqr/+X9qapWJ4vCFrEJZECgozOekjPa03roaJ
	oDVdJwEoYtbW30vlex5noPGAbH5VY9En3/4wvtzMLIPuXBJzGte7tkpKpNXtqOW0P5nPZeiRDLt
	019GCUBTbVwFac1r8inYdjVIhXGdwU9yeeaRpKeBGvZkKffynDbRJHC/ACxJaqxFByPzEJGYFs2
	WNj3hQEXb
X-Google-Smtp-Source: AGHT+IEapW8WA3wa6nPG3XSgLZVM4TOM6EuOUKg6vkSoyhhO2JGUwnM6WkjNKzhz0AtpNzZ15SyWug==
X-Received: by 2002:a05:6a00:395:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-74091b01fecmr136804b3a.23.1746469196925;
        Mon, 05 May 2025 11:19:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905fce9sm7164497b3a.128.2025.05.05.11.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 11:19:56 -0700 (PDT)
Message-ID: <0007aabd-629d-44cc-9398-902cd86d7eb3@davidwei.uk>
Date: Mon, 5 May 2025 11:19:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-3-mohsin.bashr@gmail.com>
 <0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
 <20250505104701.10d3eb14@kernel.org>
 <39a3d71e-2463-494d-9530-80fcaad0b208@davidwei.uk>
Content-Language: en-US
In-Reply-To: <39a3d71e-2463-494d-9530-80fcaad0b208@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/5/25 11:12, David Wei wrote:
> On 5/5/25 10:47, Jakub Kicinski wrote:
>> On Fri, 2 May 2025 21:54:11 -0700 David Wei wrote:
>>>>    def _test_v4(cfg) -> None:
>>>> -    cfg.require_ipver("4")
>>>> +    if not cfg.addr_v["4"]:
>>>> +        return
>>>
>>> What if cfg.remote_addr_v['4'] doesn't exist?
>>
>> Not sure if its super pythonic but it's set to None in the lib
>> if user doesn't provide the config.
> 
> Ah okay. I'm concerned about the next line:
> 
>>         cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"]) 
> 
> If cfg.remote_addr_v["4"] is None by default then Python will complain:
> 
>    >>> a = "foo test bar" + None
>    Traceback (most recent call last):
>      File "<stdin>", line 1, in <module>
>    TypeError: can only concatenate str (not "NoneType") to str

NVM, it's obviously checked for.

