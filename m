Return-Path: <netdev+bounces-191991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2028ABE234
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2899B8C36A5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF9278E47;
	Tue, 20 May 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T61sqpL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED925B695
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763862; cv=none; b=ewOkpeRZXqWN73uEuJX69QYgFFqaP4snRSeIdTK8UYK+jwCJzqANf/2G9c8meHdOmsrt8CYUxAxr8r6Bjb7tfgczX0RdwRhW4TtdTlknEeZtgzKkjCEBbcGfgoL0KQje+7YSmY8C/2HvFmomiTZBDMe5XexUIIS0nBZgSo74/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763862; c=relaxed/simple;
	bh=1M9X6QHw8QpmM9UT7xnHYungjw7J2YeWavwZ8Jbo5wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE5dHroybkbCg2cxOZeYKGUD0ZGkCiEOKefCKDJRJq6MhfNQ8IfD1hsZ7P+HqNsYT1B3qS9ilZwWNV0mfa0bmlaYbmqT2ljwTPMwBHDEVSmpHjLnMfllPmYkimaRadSLMfypWYAqfb6R0o8eSdREc8KCHZntcywz/I+JpuPbigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T61sqpL/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c9563fafso2620633b3a.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747763859; x=1748368659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lkQx5a2rXQrbUi0huGR//kMdqarRCpuGjmWJng00MH0=;
        b=T61sqpL/7PkArTAQVIDSw++5sdrXLZHbC94raz1/qOPF+s6TX4XHQOktM5DTgJwB9i
         4DFUTRiAHD7GzxNZRDMyEPtK9ZxwxYYCP9V4v74yHHY6mcG+LZARTQnWdrs+TaqcR3zt
         RTwXiKKpmzK34Mvj1rRoVmxCciPaCeibIQw1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763859; x=1748368659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkQx5a2rXQrbUi0huGR//kMdqarRCpuGjmWJng00MH0=;
        b=rEE/SLxajUGq+V2/9vPYwHdvk2vb7aS2+e30SCzvuhb20JWiPh7fRAaJHQEpWQzAif
         NBvtAEIINIO51wydShjXfFrVuycSVyWCtmYN3TE2HKcX9O12ai/WqoNiINJFl3npgyPw
         sQqim35ULii7WnWNpJWWuPMKApopxFYij7Ck0DPDLlOy6ioso27mpbgYoBG9Hr/OdlUU
         4MGJ9z6VzJboKUX5tDXicmiwS7iJl+kluEJ92OYLTXqJC2P8JpgLMLFs2SAYClBQmNbp
         fx91kYO39JTBo0dxWeRFk48KYCaLMletGmxEqYORXZJ8RM9ebxo7gb6RLC5ZNTaDw76d
         B0cA==
X-Forwarded-Encrypted: i=1; AJvYcCUSTl7GDyhcYMYOBErJtJ5WCknBKWUQ0A2ec/Gw2gIKcKLkrrrNvieoSkp4KL1aSIAokQaws5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwE4tbJG3icmIKto5WZ72aReYRMiJdYGBA7o5Daj661JpK/R6O
	xPS8k8lOR9Sqv+8+jdHcq6Ml4rIS5gUGnBfYRotGwsUa1OYX2YSZLeV4QnauHo7Wkg==
X-Gm-Gg: ASbGncvB5b+8hKT4hKmcqOf8qb3PsFOAt+36MKhINZZZTGCGhSgeI5B5OhjBMlP1s1+
	tum6WfGgyXmMX3ay0JiLntRJ9p0qAr71h4jlYQtawHek/RWnhG+st+wLZ3WUd7MiRfCZlAE/9Sl
	f151SWhe4j81fTt2S7K9mtCFemBBpO6vmcr9NlhYNUL9kRKAD6iutV6/hIVFqxayYp2f7mBC88j
	GS6woqzlFgBxfirIwye6MAerPk6Vp1cjsRLDfO5vMQxZtb+fXp7gRt4B8G8FHyQAv6kbcxYxGyt
	ywy9meBh2AJ625pqxh+lX7dtY7Ewm+2aRlkqFck5H8Z0QFyUSUgHeHKAJ3iFIJmErlRXV656D65
	j9HX7McWcuDNpixfGXs6cc3QINQ==
X-Google-Smtp-Source: AGHT+IGSYLANxnLLAnM0uR33FTX21jqDSKnmTyPRmRqzlfjjZkaFjTCDN44LrfmyPnhRWOP6pDsJKg==
X-Received: by 2002:a05:6a00:9186:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-742a98a323bmr23868341b3a.18.1747763859603;
        Tue, 20 May 2025 10:57:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982b7ffsm8484079b3a.104.2025.05.20.10.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 10:57:38 -0700 (PDT)
Message-ID: <45057903-7eab-451b-94c6-23c3d552f144@broadcom.com>
Date: Tue, 20 May 2025 10:57:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: phy: fixed_phy: remove irq argument
 from fixed_phy_add
To: Heiner Kallweit <hkallweit1@gmail.com>, Greg Ungerer
 <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Oltean <olteanv@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org,
 Linux USB Mailing List <linux-usb@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4d4c468e-300d-42c7-92a1-eabbdb6be748@gmail.com>
 <b3b9b3bc-c310-4a54-b376-c909c83575de@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <b3b9b3bc-c310-4a54-b376-c909c83575de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/25 13:34, Heiner Kallweit wrote:
> All callers pass PHY_POLL, therefore remove irq argument from
> fixed_phy_add().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

