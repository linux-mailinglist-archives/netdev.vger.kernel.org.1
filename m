Return-Path: <netdev+bounces-154155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C899FBB51
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553BB18828AF
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7018E03A;
	Tue, 24 Dec 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du2AYfNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB86191F7E;
	Tue, 24 Dec 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033059; cv=none; b=Ycgh8q0q3avOGnVVe46GzGEfJOZd2dK3U8e5vq8MThedfpBAxsez6v0WSaxjsss1y+EZYubU4ZC4YnMdr4Szi/z9FQ3qAbFZpsZJAcmIrnwwvWTy/UU1wXvbAL1aT5gk+6XbhD1EWHR8VouLMaF5nI0UD7ZVhbMp+7EclFlO9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033059; c=relaxed/simple;
	bh=jLmFWbWd3SQkC6J4LYdTAks5WNvEgPSVXIlgEkT9qUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5j3X0EKGsFSVblBLm6BeOnlF925E7JRTJZMxRo8HdRqZIA43ZG5DDpQ8fsI4fGYfQ3HjL+hU9ZkdB7eAUzpvLR04pzcTDlD87weQF1G0m9kx/MhelEND/txFDGPw32OIS78sg9tMv/WoJ25ZAGnvDzDotRq8EsdYev3AFMwAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du2AYfNn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21683192bf9so55173145ad.3;
        Tue, 24 Dec 2024 01:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735033057; x=1735637857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLmFWbWd3SQkC6J4LYdTAks5WNvEgPSVXIlgEkT9qUk=;
        b=Du2AYfNn4o32QLe67BtlAn0MhUUzhOSi4LSX0o/I9DucaM3jvvjovIpPer6PsmnQfH
         J7GqAqdb49aQyapcD2rZxd4kmfjZ0U77JjCfwxj9erplxiG+VztQR48g9D8AIinv1ENP
         MPAb9wkqdtbPVxdW28Z6RPq6QqNrX6u90pbRreqthAMFiFCcazxyPw4nKphuQ2mAmOAg
         lcQZRWz7415MoqVeKvS+VULyuGZ4RpLwp35QfTGrj2S3SSSww4U2TAN4lFdrCUNLmki8
         TkT6JMCHwbd6JIAzjyQZJZ3NvtIiHVRGqkSGc5LjRbvuMu9p5QJXSZDOYQRs1Zep2m3a
         oh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735033057; x=1735637857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLmFWbWd3SQkC6J4LYdTAks5WNvEgPSVXIlgEkT9qUk=;
        b=kpNY1pfBEM+0vgmpiewJe36xmQfiy/yGl49kFBOpL7XnjjBH0iWPs3ZfEzHCkJrSQa
         GRhLLYW7mlH1SbAabw4WaBH/PLTAxI5Tfeaje7lp5tXmzIyom9Js1Ar3RPOSjTD1n9Wt
         zuJDwOeUjmVCO5fBB21P+AfLfddBFtfUsrKy8O0TB6DBy03DDAnrS2THFTtUPbekbFZ9
         Hq8iGh/ZokRr39w4AXszQJp6/mXaCCRbWfHoaJxmnRILqBosu/Qk0DzDDRWAMOeROvCD
         FSaDoH/F31mEwpk9+P6SKwFZjK2iP1GJbyye6ismT807SJe6ibL999t+tcsXKZF4NqjW
         3bIA==
X-Forwarded-Encrypted: i=1; AJvYcCUw925mVz92vdng/2FqZGHec2rlEpg2vMrEsgq80k3sLCQPS+Rjv8RPMJf83T/UVeMYJBdUWxz09EPE@vger.kernel.org, AJvYcCVJeyYlQnafOKnuc3su9b2ny4LyFnvty6FA6Lv7d9ZuJO3VrRBvYpW1fPLb5dsc0foCaaFQd0B1tUzo3uN+@vger.kernel.org, AJvYcCXC/eih8D9+HJ8i71dgrEW6eBXNTiet6ld6OauNIQ0Wp3RVKPLHNABHyMqyCgxDqsX5GG5cqnwm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhzb4p3uLECAEWem1VRfRreLsbrm6GVr53bBJicgzLmPo6p4wr
	/dfTJxcRFFFQD4e1La16jswWJ81vCWM3mzrVKeQheUlF6Tavg722
X-Gm-Gg: ASbGncuMj2Boj5k1DuFT6wBoVXbhltK+JnudiB/PKpA170UtW3fI+tE1CAGrX/iAQvA
	cCO6Z7/S5fyUO9lek3gp3PqmTGJ5zRY8eRRK3B6XogjFwkOuXz3J8qvjwT92XTftjoUJEN2a186
	ydIBdMoQerESdQpqiKR9C75ylqcwWinsqPdv/zhQK0fyQ2hQIOlPXubynvFA5deiDOkl7Bz3C8h
	fi53qFgyytx6WNuww91njuRzFhafwoOLac0d1BZ83uxHGfGxwP3grUdiH693Im2X6IrITqoJykc
	WQuhbDGZMvXEXlx2v0OTF+oSa+BIDcFChDg=
X-Google-Smtp-Source: AGHT+IHeB/WWKd6mmgZbT26UjUM4RGWZKImwzEuCo8jzyGFGDy66eiSE5XasK5+ZN6cxtxmkvDMOCA==
X-Received: by 2002:a05:6a00:8085:b0:725:ae5f:7f06 with SMTP id d2e1a72fcca58-72abe096383mr24761611b3a.23.1735033057380;
        Tue, 24 Dec 2024 01:37:37 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1bcsm9590252b3a.187.2024.12.24.01.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 01:37:36 -0800 (PST)
Message-ID: <5ae923d7-3b4f-430c-bb43-edee7f549e56@gmail.com>
Date: Tue, 24 Dec 2024 17:37:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com
References: <20241218114442.137884-1-a0987203069@gmail.com>
 <20241218114442.137884-4-a0987203069@gmail.com>
 <7a4f5769-0010-40fd-8bb7-a20f2725114f@intel.com>
 <216e7c97-e0b1-4833-b344-a71834020b15@gmail.com>
 <c800e544-82af-43d3-b07a-e7b1a4028330@intel.com>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <c800e544-82af-43d3-b07a-e7b1a4028330@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Przemek Kitszel 於 12/20/2024 6:59 PM 寫道:
> On 12/20/24 08:07, Joey Lu wrote:
>> Dear Przemek,
>>
>> Thank you for your reply.
>
> sure :)
> please also configure your email to write replies as plain-text, instead
> of HTML
Thank you for the reminder🙂
>
> I also forgot to say, that you should have target this series for the
> net-next (--subject-prefix for git-send-email)
>
May I confirm if you are referring to netdev/net-next?
>
> Please also note that your v2 should wait to be send in the new year,
> as we will begin the Winter Break for netdev ML in a moment.
>
Got it! Happy holidays! 🎉
>
>>>> +/* 2000ps is mapped to 0 ~ 0xF */
>>>> +#define PATH_DELAY_DEC      134
>>>
>>> would be great to previx your macros by NVT_
>> Got it.
>>>
>>> why 134 and not 125?
>>
>> The interval is confirmed to be 134. The mapping is as follows:
>>
>> |0000| = 0.00 ns
>> |0001| = 0.13 ns
>> |0010| = 0.27 ns
>> ...
>> |1111| = 2.00 ns
>
> thanks, that's correct, sorry for confusion
>
>

