Return-Path: <netdev+bounces-153895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352209F9F51
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C9F189468A
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3641EC4DF;
	Sat, 21 Dec 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="VSAjfr5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846D1EC4D9
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734769151; cv=none; b=AbaAVGr5O+I5qAgNtJiF8Gc/UbaZqeHfJMV280bupg2a3v3448NjjpoYOYHVcxxn2mzMcBXGDd5T3Rh7Ey90jJSyvKk4LNnWXcMziztxmF5UlGo0e3vXkYxJWoIlOEDJrBQuTK6v8MSid1z6gawqpkJ76JS75xR9Q/JMbc8q7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734769151; c=relaxed/simple;
	bh=kux5ZLcPHHXM/aL+fmbGsKY/9C/5t3kCIZRamKk3JUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbKym+Vejd6qDgHEuXfd7esHgc4VBZLiMP5ChkCe1b8Dgw7g8WrcT4K9spZXmriH5qlcctmr11B5Btt8lW4XOCW9vQ0U3fKwibNIj4dSTmcevEFDUFgID7j8b4g2ijjjE2k5gvYURwhHC9mKtNMELIIk/QNwxFW0QRzu5Odud8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=VSAjfr5r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f441904a42so2519333a91.1
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734769149; x=1735373949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzOSF3r5Q79uOz1ZiBdyUdRqFPs3HIeDVmQxK7bZmu8=;
        b=VSAjfr5rFlE/pZ2z085i8dx7uloRUYB0xuMsJnje1KSEzH0F5aaOUY4ejz8sE9IhLn
         5pzfWb9mhRur7kGQPBrLla4dTrMce8ZLP37+VLmmoAUHcX7s9ylATCW4ZgVH7Qd8REm/
         l10Yt9b33VZUkCmLYUpAowOmjW/aFzRZHJV/zEGx98UlmSPObymj8fGCdD8zZkZAggvb
         HQLjZx2Rq2lygmhUGbdNRR00y0x+udV9Ev4XyxYLvaYPCKxMHgDZnF0vo6oukawtd5On
         UqGRIC4Kvl1K9C8LwKSPTq47CzuJHaDdrVaQazFopoFazyke4a4Zy6OqNT2ugtupaYVj
         jthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734769149; x=1735373949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzOSF3r5Q79uOz1ZiBdyUdRqFPs3HIeDVmQxK7bZmu8=;
        b=jzAByofQ6nQgdzKckLa0LNbDlg9A0VAiXcWm5SreVCgAnftYK/PBvZX6fEEee8sPxP
         Li0IM0yvAUaSeks6pxwQQFClploj6jMmq3rOG+TdrDoZqR/t7v70j86X8aUlqSdnw6+Q
         TWW1pCiki8CUeIu1uk0kR4nNZO0akndnkIRxljXLJTr37IifHoPoCj4OTqI9yPGZx0eN
         gg+8JxWmO5sw1HJq9J3thnED0pEGhukf4WmWay0POM7ueMIJ5/kFI+5vvVV0XJxoWWvu
         hKAD2oE6dRX5HL1w+t7xprg5YSR5A5T8Kmf3sTK4eWFtPioFac/CFdKchGyQCAomp2VI
         uqYg==
X-Gm-Message-State: AOJu0Yy/hBvPUH+n0LHiuyQfA2dLShMGL7GMzYAnN6IMzZeZ+hUbOXPc
	CDXXLeY12WPGitj9zYLH2vPkMMhMbN6pOAXX86nrfcm04y80uwA4yrgZjGCRlBYR8loPcIPbi4R
	jX80=
X-Gm-Gg: ASbGnctPs8Hqvvd8wGVb7pfIKg2NVZ8ofSFgT8BJcZOL79Ed1yPSjUVH09JAnLDDC3w
	2hEh0vIqIitU1R39CgN80AE9HKVSC5gMDGZekpgxNOdQlXC4JQxKJijM9u6AVeEUk8v3Xhx1Mpe
	VMhLDx9oO7nTYq3wUiPcP0yrRx+pXKndWqEvjH59JnxD+6rKVh8en8abzwQOvMPHl0K7QqRCSAZ
	pQEaVjQRVkqrilkUmZFLyAlC8UBZTfkIQirP8RWwRgqEM5hlZ8ppsZVq3yBOGVn4nM/zgIC+JVS
	a2kbX1ppIJ4B91w+ZQ+nR/nefYEb2QJcJg==
X-Google-Smtp-Source: AGHT+IGBcsza61rxfHIcEfbUDNKf17WVBWKfvbAzc0p98eMM792xLSV07JHTIfPC9bq0JXSbrJhJvA==
X-Received: by 2002:a17:90b:6c6:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f452ee08f0mr7980017a91.32.1734769148669;
        Sat, 21 Dec 2024 00:19:08 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f363dd7013sm6771188a91.47.2024.12.21.00.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 00:19:08 -0800 (PST)
Message-ID: <27f4d606-8fcb-4bdd-9b1e-970c9a166ae9@pf.is.s.u-tokyo.ac.jp>
Date: Sat, 21 Dec 2024 17:19:04 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
To: Paolo Abeni <pabeni@redhat.com>, sebastian.hesselbarth@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org
References: <20241218012849.3214468-1-joe@pf.is.s.u-tokyo.ac.jp>
 <13a68f91-b691-4024-8ae8-5f108b4e4587@redhat.com>
 <5f878cd5-3166-4ddd-9c26-ed913439408c@redhat.com>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <5f878cd5-3166-4ddd-9c26-ed913439408c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for your review.

On 12/19/24 19:23, Paolo Abeni wrote:
> On 12/19/24 11:21, Paolo Abeni wrote:
>> On 12/18/24 02:28, Joe Hattori wrote:
>>> Current implementation of mv643xx_eth_shared_of_add_port() calls
>>> of_parse_phandle(), but does not release the refcount on error. Call
>>> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
>>>
>>> This bug was found by an experimental verification tool that I am
>>> developing.
>>>
>>> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
>>> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
>>> ---
>>> Changes in v3:
>>> - Insert a NULL check for port_platdev[n].
>>> Changes in v2:
>>> - Insert a NULL check before accessing the platform data.
>>
>> I'm sorry for nit-picking, but many little things are adding-up and
>> should be noticed.
>>
>> The subj prefix must include the correct revision number (v3 in this case).
> 
> Oops, I almost forgot... the patch subj prefix must additionally include
> the target tree - 'net' in this case - see:
> 
> https://elixir.bootlin.com/linux/v6.12.5/source/Documentation/process/maintainer-netdev.rst#L332

Thank you for pointing out. All the points you raised have been fixed in 
the v4 patch.

> 
> Thanks,
> 
> Paolo
> 

Best,
Joe

