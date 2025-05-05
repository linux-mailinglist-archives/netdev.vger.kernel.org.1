Return-Path: <netdev+bounces-187810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F60AA9B80
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAED17E869
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DAC1F5849;
	Mon,  5 May 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="oXgKrURw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADFD26F473
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469544; cv=none; b=I83ZFVAZsNzikdUXJ4Iem8nHyh3riXRGiGiurtwkN6yPLAhlRGZkyWWU6+7Yr+dDKoyoHN5nyW+f+V+aZB31iV/mZdF1xyM7ll62gN6OLk36mR7GBug3poT5L3H+LWhCq1NtSVweai3miZ0y4Wf8Xdgxfhix52T4MclsBoMA4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469544; c=relaxed/simple;
	bh=PL3tk9SXF+UboYZB1OAYc7v5izuRyE7yzyGHDTvmbUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=If8SI5wMqAeoeNoQHYzUoQltvKTzry75ccyWpJeYPv4TbW/CHWZ7jmp/4VLhPTubxLsTkbGfSVEQvoPi4YEsRHh2UoFKfDKqsQpPwnYM4Ssx1CqZHFfB4pJH/ei19tg14ItVDX+xZQw8PfqNyTRp1BzFdAq993JWHUGQb2PVp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=oXgKrURw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a7e126c7so4286101b3a.3
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746469542; x=1747074342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY1QPXBAxiPqA6SnBidclDpjSSn+hCgvII34RjFoNsM=;
        b=oXgKrURwI6OEwMyLmMWjpoDlPMC/uztkHBJxQxN8pCCpDDpPmpiejbnZTRpGQrmO8/
         Et0Q6tv3ShbQEUNQgbJzTTvFHjGPx4qwQSBKjlo9Zf/6FWe2I6H/SRFQLmS9jM14u6JW
         wHIyEHA7IDE8DPk0w3OBQcspXRzzr4LsDIMknxdceGUMuKN2HGC6pHAHVKyjje0vQz+M
         9PIz4Ecdqk/JrTCSHcsm6tMfJFBilRwgs0Iqvg/xwgEQ1CvhmcgWdlAjHspD36QHUJzR
         9BQxSKSYPD8Lt6Ebwa/8Qn+p0P2mfpSEGlhoBIX7+ryC/H0ZdQrUHihJBI6h7ckpp6MX
         FghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469542; x=1747074342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY1QPXBAxiPqA6SnBidclDpjSSn+hCgvII34RjFoNsM=;
        b=Ml7wcH4L9VYLlJ1+e+sYbEL8/Tkyc5UxqkNyqUlf/vDKzpp0hu2J58vixcZegp0CyL
         CPr+nsWlbbHjr9G5MbjSSCyAQyQ/cZubKL30kPIZ70Orz6YDB+g7sGIyG8lyKl7TFd0T
         Z9Z/w2Z//CjAA6WO9Uv/uFL3Z3m4LS4/u2aq4ibjQ1ILEIPqJG7IWCnd4TTPyxVgh659
         tQCP+Tz4EaVvYPbF7po0NJJejlJO6sru4M3Axf7T/0m8/mJtRFMLeRFgZ2uqfKLZ4YMD
         Wx65hTWvRH0BUKOSRnsGiywx52bjSDp7/4Qxu2MhVBG4zyqidn7fzrTotNkFx5jRUC4d
         /1RA==
X-Forwarded-Encrypted: i=1; AJvYcCWGPzL91bRrWT5HSRaOxAf8qShR5fZM21IkDOaNe6JmAM7s8cLs2Dr1U9T0aR8ZlaDQZIe8MYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNzSBXV3QwraOp0YaDA0b7cdpG0F94HZr/uLdkxD7Ux78Yzvh
	E6fh+YVKbgpHh24s7hwgogG60hEBKAKMq4+C6tWSIFaU0jaRPrQj6wnu3THoyAY=
X-Gm-Gg: ASbGncscD/bd3K5YONU5e0n1VrphTJ+3hCEEMgz+8gd7EK/0cYCgn4jWuuGv+1QH6O6
	jiS7jvnPdsgEzFTuX93oifjjBFZ3yY/QOCDmAHC7UzyaHmAfu6ifsYDDhUxCJipZqZOAR4/NrLQ
	YzoRVqI6puR8WuT4Xb+6yKcWZ5NCoj7zOpmCdPzPevZVWbMNqWtbemK57H/zpmSL6mCpr8+qzkE
	BA0IRhZ1XLbc8PltaF3CtFP1XgIuk3BzBYm4ivrCL9UllanPO5A24hXSJHx7WZtSHyu93Hvdm/G
	1PKjb2AwDVfvAvsTkH7vEBcqmz1GBnxHQx3zyPCirWY8DVz1wzmwUJ9OxTDSwwszBZRKrx71E+J
	Zjb/t7gtjYMKHeg==
X-Google-Smtp-Source: AGHT+IH3yTyd9CoIyRroGXYmPmIhboNx21rq/5kk83cwVyajvIvLqyoxpARKz16cpW7XwQ676c59XA==
X-Received: by 2002:a05:6a00:f0b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-740919adee9mr296339b3a.4.1746469541836;
        Mon, 05 May 2025 11:25:41 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbbaa2sm7385228b3a.57.2025.05.05.11.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 11:25:41 -0700 (PDT)
Message-ID: <88dedab9-369b-48ab-9c3d-87af9c6a828f@davidwei.uk>
Date: Mon, 5 May 2025 11:25:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] selftests: drv: net: add version indicator
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-4-mohsin.bashr@gmail.com>
 <a8c17a58-67fe-4cba-ad4a-a1822554c459@davidwei.uk>
 <20250505104954.39cc63e1@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250505104954.39cc63e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/25 10:49, Jakub Kicinski wrote:
> On Fri, 2 May 2025 22:02:43 -0700 David Wei wrote:
>>> -def test_default(cfg, netnl) -> None:
>>> +def test_default_v4(cfg, netnl) -> None:
>>> +    cfg.require_ipver("4")
>>
>> With this patch, is the previous patch and this hunk still needed? I
>> think you can drop patch 2/3 or both.
> 
> The previous patch makes the more "meaty" tests run when either ipver
> is available. But we still want an indication if both versions are
> supported by env but reporting *a* skip. Historically this is what
> the ping test was for, TBH, pretty much a sanity check for the env.
> But it ended up accumulating random XDP test cases :(
> Perhaps something to address in net-next..

I see, makes sense.

Reviewed-by: David Wei <dw@davidwei.uk>

