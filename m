Return-Path: <netdev+bounces-221144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703CAB4A808
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C10188B611
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1A283C87;
	Tue,  9 Sep 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="M9QY/y/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A872848BE
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409599; cv=none; b=dhOQcvytXUaI1axuHaTm8iGpm7/Cjm6fqVlmBG1+AFP040xY4ZlsJheMKysoZvM/xcGbAH0X4IqtWTDSRvhSS8C7anLyXNsGezxbKuqjp8K8ZTiq53u1BP9cpa7CtFw8/J84ZQ5YxIWMUTU1GgNww/2ZccfgMdJc1ipCfFf94Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409599; c=relaxed/simple;
	bh=PZ0Fgxr1V6+9ghg4MKas+B5ujQdsZmxWeDfhsHJYHds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YLKAYzGOxwZ4wfZXGQwYcBfVGJb2iuXYPYrVlU1rQG8sQ5X/BsT7Vbkfrg9QD1y69+rodAwy5iR1r6uxsoOOMyWujLirWANwveIvFn6/ecmcfKF4lYOnpMKJz7hSmReW/ypvCM/taJkE1TlYEv5dvYEmHwDiDOhOWVMjR/QSbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=M9QY/y/0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-56088927dcbso6655787e87.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757409596; x=1758014396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=brw5dOQ5UUDO/Fh89VIdK0n0tzjKtkES6VDBwZFpE38=;
        b=M9QY/y/08JMYcDDXJfpv6sVkW1VTXJFTr9g4HmV5aZdQvUSGnINxKDslAJcQiriKN9
         GjXUcoNwuZ9b8SYSgGrQH/CBAvWgtnZXhjNPQNB0ehrW2EWBt4ak7oUToNN+WV3N4zfS
         LDOEkyYpNgjQw92wgsC0v8FiL0293K3EOSPvy8erFgNbfgTiAiJL8tHZKDocYqnFCPtQ
         M8GTc7ijfZRP/rhlQQU5sDbyUCVo+6Mb8OBZwiECx9GzCgbWa5ht9Xuj+Ywjosy3CkLE
         9ikmRhfiZ5njaLAxbd97T7uftSOHQSNHcrxxgwl32qBW7Ok6MvatNb9Rctib2fvsilyi
         XJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409596; x=1758014396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brw5dOQ5UUDO/Fh89VIdK0n0tzjKtkES6VDBwZFpE38=;
        b=O1ZkEpVzWtB/nzvnIG9VtH/QC5Kk0UHe/XVp5ms70zqbGPaJm/G8ODnbaM+G5rsPnH
         6r/dqryHGq7itYyQ69q/jY92eeBWA4ok2Pqoy1WP0kc8LEk0RzPHs25n27YnN94usBCj
         +MENGEqhURyeF3rN/gueNC+OJboeIsG7U+I7sSyk9WN30ajfObb+pD4Vil0PbFVy43Xv
         5FvcEGKyCktexEEFUkA0H+7IYGOlNsOI4/dsk/38e4zQq+Vn8jCYtXAdVnRLsYOI5LT1
         IvExat5X8NKdrn+G5sXhkbsbKr8LIIkt9rVDzAxot6p538eQJeybKLQ49dBJWGPz87Ih
         QGJA==
X-Forwarded-Encrypted: i=1; AJvYcCUnqUFRrPxOc8j8Xr5JzA1Px+CN3cjypGG0JH/xXDmeScae/Ph764BSIKpu5u8CksIiiASTU28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmqRX58O3llPB/Rpkzeirs2/a204yoBya1O/SSg5IjamIfy1c
	Dp2cQb07tfJEd1o52OPlcqRMcaxLFGCvu+kUDJ1qullCeJsSaelXlouaLhcU1NcLL28=
X-Gm-Gg: ASbGncvYz9nrxlIehdlASO1hkA2CkT2hhEMSPIOuy2fuNntYf5qDq6fv7gnXpKBRJcA
	HomnLVB8dXpKvyUrY1YzSDLc6OazhAptpMZPs7yH18PCdxWlR7PlI5PfgLDB5xwYB6MUgXnK8gX
	bL/oxfHLTqMM6QRbgEOWmpOncwQk/1yuhgoX6wY6dqzmLTgBmYnxC8kheMfZAi8jOccoSi3zcXM
	/Uv27M6Oe9W7WlUUgqpgGysNUCCwVCkkV54IyoGNHnsxqb1DE6djKWdgyIC5J7pjc+x3f6R+0lL
	jE6StZsCL0/pgd6QLoTWNS6FlMtuFZhep318XHnjKoyXkxsB07Ql2fwpyzH+UdIlAx8ata+AH51
	Ab8tuisVFSWylmYDpsj50TFLrbGcTbqQmXH/Dlw6OAEEKazul6lON5ARc3LnRgZ0OYwcTfTMH2X
	Iehw==
X-Google-Smtp-Source: AGHT+IGyXyEnXPt/zd9SI74zODDrmgjcXDOuyeeX4wNZw6PtAsT0SI11XMnWl3GBdKlBp+qsLE74cg==
X-Received: by 2002:a05:6512:3da2:b0:568:8ac2:f18f with SMTP id 2adb3069b0e04-5688ac2f457mr565954e87.30.1757409595617;
        Tue, 09 Sep 2025 02:19:55 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d633sm389344e87.68.2025.09.09.02.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:19:55 -0700 (PDT)
Message-ID: <382bb1dd-47ba-445c-a13d-0d96312a756b@blackwall.org>
Date: Tue, 9 Sep 2025 12:19:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jakub Kicinski <kuba@kernel.org>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev, mlxsw@nvidia.com,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>
References: <cover.1757004393.git.petrm@nvidia.com>
 <20250908192753.7bdb8d21@kernel.org>
 <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Content-Language: en-US
In-Reply-To: <3213449c-57bd-4243-ac8f-5c72071dfee5@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 12:07, Nikolay Aleksandrov wrote:
> On 9/9/25 05:27, Jakub Kicinski wrote:
>> On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
>>> Yet another option might be to use in-kernel FDB filtering, and to filter
>>> the local entries when dumping. Unfortunately, this does not help all that
>>> much either, because the linked-list walk still needs to happen. Also, with
>>> the obvious filtering interface built around ndm_flags / ndm_state
>>> filtering, one can't just exclude pure local entries in one query. One
>>> needs to dump all non-local entries first, and then to get permanent
>>> entries in another run filter local & added_by_user. I.e. one needs to pay
>>> the iteration overhead twice, and then integrate the result in userspace.
>>> To get significant savings, one would need a very specific knob like "dump,
>>> but skip/only include local entries". But if we are adding a local-specific
>>> knobs, maybe let's have an option to just not duplicate them in the first
>>> place.
>>
>> Local-specific knob for dump seems like the most direct way to address
>> your concern, if I'm reading the cover letter right. Also, is it normal
>> to special case vlan 0 the way this series does? Wouldn't it be cleaner
>> to store local entries in a separate hash table? Perhaps if they lived
>> in a separate hash table it'd be odd to dump them for VLAN 0 (so the
>> series also conflates the kernel internals and control path/dump output)
>>
>> Given that Nik has authored the previous version a third opinion would> be great... adding a handful of people to CC.
> 
> My 2c, it is ok to special case vlan 0 as it is illegal to use, so it can be used
> to match on "special" entries like this. I'd like to avoid the complexity of maintaining
> multiple hash tables or lists just because of this issue, it is not a common problem
> and I think the optional vlan 0 trick is a nice minimal way to deal with it. We already
> have fdb filtering for dumps, but that requires us to go over all fdbs and with
> fdb duplication the local ones alone can be a pretty high number.
> 

And just to make sure it is clear - usually we are talking about a low number of fdb entries
(w/o duplicates), IIRC up to 100 in most cases.

> The pros are that we don't have fdb duplication (much smaller number of fdbs),
> we use standard bridge infra available to store and find them (the fdb rhashtable,
> with local entries tagged as vlan 0) and code-wise it is pretty simple to maintain.
> This solution has worked for over 10 years at Cumulus, it is well tested.
> 
> It needs to be optional though as it changes user-visible behaviour for local fdbs.
> Any other solution would probably have to be optional as well.
> 
> And obviously I am biased, so good alternatives are welcome too. :-)
> 
> Cheers,
>   Nik
> 
> 
> 
> 


