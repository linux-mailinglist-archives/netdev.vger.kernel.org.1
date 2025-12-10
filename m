Return-Path: <netdev+bounces-244285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C01CB3D3D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 20:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB76A300501D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF803271F1;
	Wed, 10 Dec 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdseGsrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4F155C97
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393746; cv=none; b=CIIjPUeeDVJQMTAgO79XC16lv36mnPFadp0stOq1fkSQVwJwRlrlOJvb5nWElMuCVSEk/L80Fr9FYu7EPn47+YvwuUjYiauGMVVj73hzQHle+DyoliRgwUipvsjkYyEqjMHCEkaz15/YZaEGrc6BFA6zLtDWpo5MuQbKeBM2Cxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393746; c=relaxed/simple;
	bh=calyCJn7HCzDIZJYHFyyjL6bDhg5HBlqUnJKtZ4SEy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMojTomUcxCSNFP1tWSpH31VLtdgefFN5lto25EobtAAB0HumU6dTJ7o5L8PL/Cog7xWCXWCkSACRs+lHnIi/bqKGTV3iXDzh+Ha3QFmNGSxMtukUVkWkUjVV0xVsDdDCnDNlEKE24wfpdiAHGO+PsW5sR3gNw5hTlyStsi0Tfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdseGsrC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso139227b3a.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 11:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765393743; x=1765998543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ALnH7xZXyoaaX5d2lzICEZFSc7BpSTyBsbMHtfdCwVg=;
        b=OdseGsrCSDM17b91kRYpWg7MASTMjNySzWplWVxy8WXB3GCDlgd4rQ/LuFxo0i+xH4
         ySZXvvGhSgL4ndMO+kzoWwT3DuYz/e3Gdlr5wAn2PhHdA0fkKO6uTH3toxOH8+ZFK5Bj
         SP+I0NaqGoBIHmwixgLgrzwL8DVlBFxq0IXThbONLUOGvdDelPgA5Tl19P6UIvMV32YS
         +hv0cbteRuuZ4WslZLi7iq8u54GooPSuGXktig7kGMrO7pVZmp7LWqzs9gJhUBHZjcAt
         GS3uckjv8FSjnJAStA/3Bmeco8HPMw1f5I7+HsTus34SfmQ1vCmAZsk1g5OjFtApTdoB
         npTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765393743; x=1765998543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALnH7xZXyoaaX5d2lzICEZFSc7BpSTyBsbMHtfdCwVg=;
        b=IO68HwrVKp3fJpjwYOgryIwvnzINsYnZoiat7MVIA781hvswqWDI/btdjUaSTZloKH
         phGqCjEHw+fr0uM5yfaCnE9PfvjKu9pdxmb/oem/0hDmABondZX8YnuvoFBCBhjEUel/
         kMX6XJuvbTubcstEaQ7Ca5bBkStqIQIWc50NxuYL7D6+L3IQd8QqHszoWH6rpVfhlY2n
         EMO9n4fZhREmLP45uxSPt5uxBc26dCWM+555X9Z7hUKT2roEQeinz5pusJvmMaqG/PGT
         Gk2xRe6ccQg2t9lz84rrPsW0XARFe9+rygZwip7kFpzaz+BHqO9PAzwQJkhJdyOdypJE
         ugfA==
X-Forwarded-Encrypted: i=1; AJvYcCXiUZ5H40zmv6lZY0ltW0q2RwOBylksGizrJ/Jx9D9pO3WyU2PeOrgVHRaMo78B+IF90jrqYew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtzqvdr0+OQ1rqb8kKA2mTcVoPzZJcDd8CsfbqF4LHRdOAm0/t
	L4SPBui6KxKERG6ZYZb170P48nBSPuA5aUX5BJWAg0E9E/jQk0FCw4MP
X-Gm-Gg: ASbGncvh6CuoQ7KOVKEsZf50oio401QFmV55dRUfX1Wbce6itYwvq/0BFT+goGvqqWy
	m3Slm02gXixCFYQEEsZ2+W+8ypEQETUsPHcDEmHr+R/+0vZrO7d6w3u8G4iOZBGo7Sd0Q+eOyao
	tWhqRoDrIp42FZg+G3jfKcyb8T3+3TM1Ng5Zd5a2bj8N2/TjH9+fF4k50ryp683xJP4Jdmjpaue
	h8FfzlRtvjtVV+HIO3qU5YxhmSWR9mur/fdeAa9y2kbroY7SHm6wTZT9vEIfHI/725lVXoiwha1
	dEnNOsNHv6wOdMZkNFPG6aijnzlqVgmjH0chc4SgpV29bfeSo2Ugvk+BZF1lQQAOOOhoZ3wCOAd
	cXU7VynG0a+IkQAUx415HQtbyXBcUQ1kZy6k9/ADbBESpQNEBn/xixU6do9oolWnmStsMUmKo2r
	ujCI2NZSztroaFJFvnPOPEgGfQ8Jnuo0xZU0BfK1+CFGCkB3WYt604HEeIwcw=
X-Google-Smtp-Source: AGHT+IFkBdc4L7W2yURiGuumsGT4dEWPci/s+wZEabce7HtaPIrwKqnYk/48B/cwUZ1Bk5R/h+PAYg==
X-Received: by 2002:a05:6a20:3d82:b0:304:313a:4bcd with SMTP id adf61e73a8af0-366e120ef6fmr3658096637.30.1765393743391;
        Wed, 10 Dec 2025 11:09:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c25b7d59dsm248321a12.6.2025.12.10.11.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 11:09:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3682159f-05ff-417c-95e9-976f0a504c09@roeck-us.net>
Date: Wed, 10 Dec 2025 11:09:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] selftests: net: netlink-dumps: Avoid
 uninitialized variable warning
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 wine-devel@winehq.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20251205171010.515236-1-linux@roeck-us.net>
 <20251205171010.515236-9-linux@roeck-us.net>
 <20251210181318.73075886@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251210181318.73075886@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 01:13, Jakub Kicinski wrote:
> On Fri,  5 Dec 2025 09:10:02 -0800 Guenter Roeck wrote:
>> The following warning is seen when building netlink-dumps.
>>
>> netlink-dumps.c: In function ‘dump_extack’:
>> ../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized
>>
>> Problem is that the loop which initializes 'ret' may exit early without
>> initializing the variable if recv() returns an error. Always initialize
>> 'ret' to solve the problem.
> 
> Are you sure you're working off the latest tree? I think this should
> already be fixed by 13cb6ac5b50
> 

Sorry for missing the fix. I was working off v6.18, which was the tip of
the tree when I wrote the patch.

> I applied the other 3 networking changes.

Thanks a lot!

Guenter


