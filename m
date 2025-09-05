Return-Path: <netdev+bounces-220470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B5BB46404
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 21:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6A6A48514
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468672848B4;
	Fri,  5 Sep 2025 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHZiWDbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728B280CC8;
	Fri,  5 Sep 2025 19:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102231; cv=none; b=fDM43GAtGU4ih9BzNpdaGufs8yYqXUoxtdl9MXMjc6BkZaHjeE1aZTj1Q5kpWwvoYOybOxfeUAB+rCUysva85Y1NlsfpPo4ZOGufcGSnQ82Ewfx7pj8Vzj42AdJ/XB+PY6WrW5DnsmRWrGi5tK5dWz/mHo47U9hQU3M9m/jPm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102231; c=relaxed/simple;
	bh=YY/5CoMF1t4lzWuc7OOFCaQJ6ShCt5KrBdaLw93ATyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQq/5iJ4TR0BQ8JsKg3u7h3iNEBgVserb6WJard+dTaQ74zEHWz4nuxBgn7y4fkgc9BsLqGvFBr61wXEkPgz1f2Qin42kj6DEdy3/yABFu1qNMioCIX6ds8m3UbevK1S05RP0wSUF9cBPiHqST+X2TDlFGejZyahlwUZyJ0ORlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHZiWDbK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so12770745e9.3;
        Fri, 05 Sep 2025 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757102228; x=1757707028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=97k2qA98jR5CSzR1K1U3ieT2BcMpMfF7MCCoGIdAZuQ=;
        b=VHZiWDbK00osNDIKD4RITUZpCo/mlIFSoi1+6pBqUOMnkPBvQSTmfF33J03xTQgifR
         Mxu05ObMArCUJZy2u50zxUREP695Z7G5O1Om9M+sus0XxFOJKeaxXTDG+kEl/rkoMKn7
         gBrD7oqn+XAn1laVBAHZFesUscD7EpmXX7l8JsYCTS3FhctWAiMPj5a7eBj3IRit+h94
         8bymmcneZNc8CaPbVV8kXoD/z1AhNwvM3eiUfHXVJ5mExH+9aQvQOitVWLFI3PsSZU5S
         mJndpD55kYiNPwyN8bU3sGKjdZAH82s7b7dvSO8CwhEygAmfkvdMludJ6k9K5Aa9amO1
         xjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102228; x=1757707028;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97k2qA98jR5CSzR1K1U3ieT2BcMpMfF7MCCoGIdAZuQ=;
        b=HFkTy/Rz2BxB/faSY0Dk0P89UHIdbz5Qc8BXHehc2soU6kWfVfR9pKfFNTcG3r5yys
         xLZbGc2gzRjUCMJncbzwXE2lxdj2SaorOnrnqnpqZVpJHhTRp9wDm1bDKgHYxcercQBe
         ZQvDVzV1myouihc2xXD65omtRV4TdC+cXux8Xem4lCmqGHJuuUAPS5gr+ppr7BnWoOXe
         jI0rJ/aks+PmBsSGCcbFYEcutYWXNMf2Ox9ZrpJRrXue0LngZ9juyKbjNw051PDOGDGU
         YgFsDys399eb0GHoQDess+sxWNfaA5+hljmrryKpzXClKObIukZNlPGkbc8p3gve70FX
         0TQg==
X-Forwarded-Encrypted: i=1; AJvYcCWgPVqlzFyCvFixwL6eLTftU3M++wW6FrZWYtGWackQ6rVswxc9V+IL2xDspsKXLNJkTyVL+SYrqnZdBNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/Kz1pSRTNdGEKFNP2a+BsU7hoJMt8WqwlWbu6ddjUjdLKLhc
	pMBFCuV2py8vOouVK4ZoTzx7MPJ8cY8Uh3Pyypo8s5KUmJTClqFgnH1L2pXWX4qs
X-Gm-Gg: ASbGncvSqvnAM1wo9g+MPABfX1APGOMC/bO8w8BDdv8I9ic87UgHQOjQrmbJD8Vo41D
	42ImKAExdluQTB5fePgdZhNEw/EPMinWydffLzIIjDMBM6ZSUQ1TuzMo5Hgyi0Dr2f37l2Q/cQ9
	xBMcm63z7rgnnaXIMr7YHe4d29w1jsgL+zfsEmM0Sls/eTh+kW/xJaX48j4/CwsrXpey1tfSPvr
	rrkytTIAmaSNRA/IuPEfWI5Yh9Gpv1BWYPN38oQP8bZRd8+WrPU8m9oW84pSueSGNsCbIvimgGk
	qs3wPT4vucPQ0SQu8tNer6fdWUjvNKKblf+/uDpVJmmCuVQHpZKd+enZqp4gaWn7PPDfeItsczc
	CgOezU1fJkhQ5Q+KKCakDYjxkfSMXPGqQ9l/B+vxh3jn34JQq9nqj3OQh7Erpt2bPJIYADuYnWL
	xkGtR8n2vCoSXE6NOgCwDFifvYW1ueVBqVyDkawKD2tjV724/CLdn2VqxJbCKLe0o+0eXG+y6t
X-Google-Smtp-Source: AGHT+IFmp9eyFJM/WIfxOLAkwIlUy2+gN6Q8SrbxMNp8k6hf3bAmHC4KW/kbTf2gUIXv+DYfP8AbMA==
X-Received: by 2002:a05:600c:474b:b0:45d:d3b3:fd5d with SMTP id 5b1f17b1804b1-45dddeeedfemr773135e9.17.1757102227647;
        Fri, 05 Sep 2025 12:57:07 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:5a00:7553:5929:6a83:2f05? (p200300ea8f1a5a00755359296a832f05.dip0.t-ipconnect.de. [2003:ea:8f1a:5a00:7553:5929:6a83:2f05])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm60421705e9.1.2025.09.05.12.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:57:07 -0700 (PDT)
Message-ID: <f2cb249e-0e73-4c4f-b2ca-d3b3c71ece2d@gmail.com>
Date: Fri, 5 Sep 2025 21:57:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: set EEE speed down ratio to 1
To: Hau <hau@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250904021123.5734-1-hau@realtek.com>
 <d78dd279-54ed-46c3-b0b1-09c0be04557a@gmail.com>
 <9d8e60df8e4b464cb28c7e421b9df45a@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <9d8e60df8e4b464cb28c7e421b9df45a@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/2025 3:43 PM, Hau wrote:
>>
>> On 9/4/2025 4:11 AM, ChunHao Lin wrote:
>>> EEE speed down ratio (mac ocp 0xe056[7:4]) is used to control EEE
>>> speed down rate. The larger this value is, the more power can save.
>>> But it actually save less power then expected, but will impact
>>> compatibility. So set it to 1 (mac ocp 0xe056[7:4] = 0) to improve
>> compatibility.
>>>
>> Hi Hau,
>>
>> what kind of speed is this referring to? Some clock, or link speed, or ..?
>> Is EEE speed down a Realtek-specific feature?
>>
>> Are there known issues with the values used currently? Depending on the
>> answer we might consider this a fix.
>>
> It means clock (MAC MCU) speed down. It is not from spec, so it is kind of Realtek specific feature.
> It may cause packet drop or interrupt loss (different hardware may have different issue).
> 
Thanks, Hau!

>>
>>> Signed-off-by: ChunHao Lin <hau@realtek.com>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 9c601f271c02..e5427dfce268 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -3409,7 +3409,7 @@ static void rtl_hw_start_8168h_1(struct
>> rtl8169_private *tp)
>>>               r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>>>       }
>>>
>>> -     r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
>>> +     r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
>>>       r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
>>>       r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
>>>       r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f); @@ -3514,7
>>> +3514,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>>>               r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>>>       }
>>>
>>> -     r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
>>> +     r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
>>>       r8168_mac_ocp_write(tp, 0xea80, 0x0003);
>>>       r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
>>>       r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f); @@ -3715,7
>>> +3715,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private
>> *tp)
>>>       r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
>>>       r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
>>>       r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
>>> -     r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
>>> +     r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
>>>       r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
>>>       r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
>>>       if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
> 


