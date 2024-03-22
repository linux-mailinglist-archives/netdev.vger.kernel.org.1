Return-Path: <netdev+bounces-81216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDBF886A0B
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094D61F22535
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F22C689;
	Fri, 22 Mar 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGuhItoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD58374CF
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102612; cv=none; b=b2F8BN3CkCPjq25b9CT+C6K4ynhrJj6bUnVuaGsTVgXI1hmZziMk4PoY1I/RKsnSgc7ox9AvE6ByL8oAG+yaVkeVHubmTzI/ZnwpS7pXxyHxjo65dgemZkm6lC8vBhiY+rXeIYuW4GZ9iVyeFEFBiMu0S67Uf1q3w1yrRD538gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102612; c=relaxed/simple;
	bh=LwCoZKf3jbpJ5rZT1SDtb8RsBCDGys81ba46VZ48G8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvKIBTXsSs1p6gN1xCRrTChq4ma6TWT0Rrfx4zdMpFABMeBhHCwHp7L9gEinGt7uTV27xlhNDqmRW+nQZFuMbFb+dIoioHqcuM/3tSVlhCPWm8yE00cVRteJjj3htuYz0rKUGUd7wC/18uDQ7/XW6u5w3c+g3T23aPuOUgNqs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGuhItoS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4707502aafso335973666b.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711102609; x=1711707409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h9F40IAxeQkX+KSNjo4dXkZUF4u60YPSpgxjbQowPfE=;
        b=ZGuhItoSvj82y6jtmabd9P9ovhZekPyk5NmBxnPfsxyVXJjKeCCzSHCv/PjJvrv9IF
         Dj1dsWyfXVhQsPsfXzTOT7gQPSnkfsgNbANjO2ACAaNgREVVmxqgVFiFasc/6juNm0As
         xL5MxXrrnwTdHc00Evq2dIJ0cCPMtMuhkvnt3xihihJLFUrtlJEafMf4C0BqIRdaRE9d
         7+wSNNxr4ZOEulN0ilWpguctG8NM07jpfixhgJKbzYThMLb3zen8tz2z+gI87DCH33f8
         wJGqn9lbnz5FMFBG/poKxY1n3Zm2hfHApuumMAhk9iy90xMziJPGVPLtTa8EHQzxAMuD
         WRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711102609; x=1711707409;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9F40IAxeQkX+KSNjo4dXkZUF4u60YPSpgxjbQowPfE=;
        b=RG0VB1CGNqHoXbahvIWAzkZMRkgA87CB//XJKoLb+XjMmu1LdYYJPvCJCg4vnrfDL0
         zUZQhi9joOGgGcXG0kcIRexSSJ8sTXFT+Py5KfOXZHDUhOpIR1tSMez+Rezbt7DWk9SI
         ptR0rdXHO9DOwWQlkrGBuzoMTy809FwiVxpvb23OAtHyhjHjHHzr94FrJUEdf/lgis+O
         es4cYly+HLLpXG8QJ2EZW5ITekHD5jzNRsfk69M6KKI/4GdJZ6vwRXWVtTqiGI1FRts3
         8A0aDMLUI/CLl3WZFo+z/9SgduG0DJzL9EbWR8VNfIXf5bWPHCKg+oixvdG4E8HqB3oV
         SjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKOt1UNki/o541OfCKoUtM7KsxB385aO2+zUsEC7ID0QXSQFVHShay/R507GFsetqhZs5fyDE5gFSKcEubwlIR6pgm5wDV
X-Gm-Message-State: AOJu0Yy4qHvMdkzU/hS3m0f4tHkPAlkRQ1Xip93uuaRvTvoDZrtIRgYx
	wliGw+w8i9EC6MWh2Kekq66kj5bDL6sR3G09YEQDH9TujCuGj6rF
X-Google-Smtp-Source: AGHT+IH9Ah+PEZ9qJysaszCR6x/tpY+LtmplWicvuL8AflaL/Q1/St+JSHCsHwPHMqMKIGBezxcBXg==
X-Received: by 2002:a17:907:548:b0:a47:acc:6ebb with SMTP id wk8-20020a170907054800b00a470acc6ebbmr1231257ejb.32.1711102608953;
        Fri, 22 Mar 2024 03:16:48 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9ee:2200:f561:5083:802a:9d7f? (dynamic-2a01-0c23-b9ee-2200-f561-5083-802a-9d7f.c23.pool.telefonica.de. [2a01:c23:b9ee:2200:f561:5083:802a:9d7f])
        by smtp.googlemail.com with ESMTPSA id u18-20020a170906125200b00a465a012cf1sm873584eja.18.2024.03.22.03.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:16:48 -0700 (PDT)
Message-ID: <0dee563a-08ea-4e50-b285-5d0527458057@gmail.com>
Date: Fri, 22 Mar 2024 11:16:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: skip DASH fw status checks when DASH is disabled
To: pseudoc <atlas.yu@canonical.com>, hau@realtek.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, nic_swsd@realtek.com, pabeni@redhat.com
References: <50974cc4-ca03-465c-8c3d-a9d78ee448ed@gmail.com>
 <20240322083315.47477-1-atlas.yu@canonical.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240322083315.47477-1-atlas.yu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22.03.2024 09:33, pseudoc wrote:
> On Fri, Mar 22, 2024 at 3:01 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> To me this seems to be somewhat in conflict with the commit message of the
>> original change. There's a statement that DASH firmware may influence driver
>> behavior even if DASH is disabled.
>> I think we have to consider three cases in the driver:
>> 1. DASH enabled (implies firmware is present)
>> 2. DASH disabled (firmware present)
>> 3. DASH disabled (no firmware)
> 
>> I assume your change is for case 3.
> I checked the r8168 driver[1], for both DP and EP DASH types,
> "rtl8168_wait_dash_fw_ready" will immediately return if DASH is disabled.
> So I think the firmware presence doesn't really matter.
> 
>> Is there a way to detect firmware presence on driver load?
> By comparing r8168_n.c and r8169_main.c, I think "rtl_ep_ocp_read_cond" and
> "rtl_dp_ocp_read_cond" is checking that, which is redundant when DASH is disabled.
> 
No, this only checks whether DASH is enabled.
I don't think is redundant, because the original change explicitly mentions that
DASH fw may impact behavior even if DASH is disabled.

I understand that on your test system DASH is disabled. But does your system have
a DASH fw or not?

My assumption is that the poll loop is relevant on systems with DASH fw, even if
DASH is disabled. I'd appreciate if somebody from Realtek could comment on this. Hau?
Including the question whether DASH fw presence can be detected, even if DASH is disabled.

> [1] r8168 driver: https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software



