Return-Path: <netdev+bounces-241058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568B7C7E47A
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 17:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123213A8E91
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D91E25F9;
	Sun, 23 Nov 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqkNZXRo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2E19F40A
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 16:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763917174; cv=none; b=KM/YkANxCGohSXNStDBEO0DJ0/Xnlq4yWBwCmeT9znZJosubdz8D6NzDhjRk1bWlEQ7P2+w9PUpBNuu6ACxXmTmqkuzEF4mM3zcBRYpSfj5gvakgw+FQJZPybRNp2ElifIj/0GwyUaeVeLbW3XFrNL4RQSgveak/Y8BakQtEXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763917174; c=relaxed/simple;
	bh=gK55IaifKDN3ZrobdpVRFErmsNsHjkXbdgOYMV5Z/Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdiaCQoaa3tb7rejxPnswzbDa0ejJgRcO4aU9kh9t/NDV/LYEuDsY0a8Zpp7RmX9QQZkkFzN62oEYN96tpmHDnuODYS2bRJb5NPUQrwekdx+OkQJXW1MASftuK2Vvmzst3FUzUJplF2MdWj/0wbIO1hRj81AuRhH8G7sjWgY5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqkNZXRo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso2192763f8f.1
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763917171; x=1764521971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPfV6chxQYs/pIoSdBBNjrnmPnwcnA8KYYwwlseA8DM=;
        b=QqkNZXRoDB/6VhBq1Pl817eBLyMqWFtb+mE+7AHtPrWV3TmSONmgL6cmyFekO4ebzH
         c+el2bSWw9YHO0nfa/LJFTuCu+F2gVr01o1ym5iC2uq4fmnL5txAGh6DNdbDqCIVT35r
         aa9pVICLDpOBPi0aH2tkZIWymCwdyFQo24MJBncHNtP119GS4Mu2nCMuscn15FAZLG/2
         N/RUhaRlWmDd06sCP0O+mUaNyb12TqPff40cAQhkJHl5tq26+QjTdJfr7SEWnjdvMZa7
         krAOqQyYb61X5tmGu4tHCaR0z8o5CmximX38CenKG2xith79pSrtUqd036HKGRLnSTuE
         Gcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763917171; x=1764521971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPfV6chxQYs/pIoSdBBNjrnmPnwcnA8KYYwwlseA8DM=;
        b=d0CGtqkiCq8YYmHQn/GMwJnjM7LdtU2HlWwk2PPFpWx4L5vm/X6/aEjsjduqpt2Xy2
         eQp5MZrPWOxHTx5gZX/YsuhU8OvJJ5gKUjw1LGKFWFCYNzm9tMvIE20VSHwM87AQMFGF
         cwdEmvEnorzUX+Q+BdSRVARDK8WH1isovRZjF3TuO5Q708DpqwpHiE5VmqDNpUhkKB/D
         E2gVnmCrCNIobiDNert1zjp1xs37a6AqBXrHY9ETA4+3Ij7TqNvNVyL4M+lF8UvSpLZ8
         Mfo0talyhGS/toRQm6ncUgnKEpfsLIO4xwv7KJtV1o6uq5ohn688B7gUs/qY57oVqvuy
         HFKg==
X-Forwarded-Encrypted: i=1; AJvYcCWSV3anSh8KqtlOO3uZZLfOVvI3bR9RzE2JLr1tg9cN7EBhkhUTfTOkluyoHG//5a3fPQ8Kz/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZ6xZoZbJAIFRfCzq1VF+4wjcljpQaYxKqsttzUQMFZzxqQxO
	YTA5/lQN5hVZXEJdC5z3Luq3Dx1XnGPEu/FAZML1lVDq2KWmAt/FZrnW
X-Gm-Gg: ASbGncuTkjRVinkZaoKts8iuppa3seV48o5NAZO7E3qQ29ObTBPSknwg48ddS3EMoLn
	czQXK8vMkpJPv/9QUQezE6b4ZoaMD7Yy02Lmlud6f9Xy1OlR2laWyhWSTK0aHT9kAjoAUmjlPrg
	MC3Oyp6OFIXm8CpyeAmfCuaGQF7KuhVRcyEssRSYVTFTk0OlGxyMZfTkXx10BPU533wWIbjzN6e
	F2s1UwcD0j7Ty4QOqkBRNs2tZCqjeJiTruppTsu1cKdaaRGEuibltDtloAXqu8LrXZ+5Yhcn9O0
	3+hGmHabYWjioKGaRcgGElMoNurj9q/NIVwQr4dOCnSyu/fsn4n4N/4mvs0FNZQeRjK5YMv/XwA
	3weyX/WGq72raK+JKznnla7G3L/qd13lMSSb7SoTCIGORIdJ5SJv9PNsRDTRiVmJ2VGICP5aNsn
	uG8wcQ75fQcYE5EgLe+A9ueNuuQt9g+XcZgFQY2EctmjS/ps4Om3QPVmUgzU8IvE1O83b+HdFq6
	8kTBUnN4eX9EiiEyaxZIanRzexUO8N5CIi3vb6OkLRXDgsu2TsXmg==
X-Google-Smtp-Source: AGHT+IGndWDGT5HBliHvvDFv4NQx9Bbzbq0XpndoX+T3gaMba8GuY5uinGj6dd13eZ/B4GK6wFih8A==
X-Received: by 2002:a05:6000:220e:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42cc1cbd338mr8843589f8f.17.1763917170693;
        Sun, 23 Nov 2025 08:59:30 -0800 (PST)
Received: from ?IPV6:2003:ea:8f07:a200:c9b4:617e:3ddf:6f40? (p200300ea8f07a200c9b4617e3ddf6f40.dip0.t-ipconnect.de. [2003:ea:8f07:a200:c9b4:617e:3ddf:6f40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm22441405f8f.21.2025.11.23.08.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 08:59:29 -0800 (PST)
Message-ID: <107ae398-4351-4be3-83ec-d03fa91e2a81@gmail.com>
Date: Sun, 23 Nov 2025 17:59:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] r8169: add support for RTL8127ATF
To: Michael Zimmermann <sigmaepsilon92@gmail.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251120195055.3127-1-fabio.baltieri@gmail.com>
 <f263daf0-70c2-46c2-af25-653ff3179cb0@gmail.com>
 <aSDLYiBftMR9ArUI@google.com>
 <b012587a-2c38-4597-9af9-3ba723ba6cba@gmail.com>
 <CAN9vWDLGSDQQMPBVesOwAR3vvPko+ZG-eyxrL96OUM=1J05Ojg@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAN9vWDLGSDQQMPBVesOwAR3vvPko+ZG-eyxrL96OUM=1J05Ojg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/2025 5:26 PM, Michael Zimmermann wrote:
>> +       }, {
>> +               PHY_ID_MATCH_EXACT(0x001ccbff),
>> +               .name           = "Realtek SFP PHY Mode",
>> +               .flags          = PHY_IS_INTERNAL,
>> +               .probe          = rtl822x_probe,
>> +               .get_features   = rtlgen_sfp_get_features,
>> +               .config_aneg    = rtlgen_sfp_config_aneg,
>> +               .read_status    = rtl822x_read_status,
>> +               .suspend        = genphy_suspend,
>> +               .resume         = rtlgen_resume,
>> +               .read_page      = rtl821x_read_page,
>> +               .write_page     = rtl821x_write_page,
>> +               .read_mmd       = rtl822x_read_mmd,
>> +               .write_mmd      = rtl822x_write_mmd,
> 
> I didn't get a chance to test your patch, yet, but is this intended to
> match RTL8127AF? Because that's not it's phy id. It's the same as
> RTL_8261C and currently matches "Realtek Internal NBASE-T PHY":
> 
See earlier in the patch:

+	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
+	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+		return 0xcbff;

The PHY_ID read is intercepted.

> # cat /proc/self/net/r8127/enp8s0/debug/eth_phy
> 
> Dump Ethernet PHY
> 
> Offset  Value
> ------  -----
> 
> ####################page 0##################
> 
> 0x00:   0040 798d 001c c890 1c01 0000 0064 2001
> 0x08:   0000 0000 0000 0000 0000 0000 0000 2000
> ####################extra reg##################
> 
> 0xa400: 0040 798d 001c c890 1c01 0000 0064 2001
> 0xa410: 0000 0000 0000
> 0xa434: 0a0c
> 0xa5d0: 0000 0000 0001 4000
> 0xa61a: 0400
> 0xa6d0: 0000 0000 0000


