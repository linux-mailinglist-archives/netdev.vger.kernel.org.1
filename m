Return-Path: <netdev+bounces-203569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52855AF6663
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E487A3832
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2224728D;
	Wed,  2 Jul 2025 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LplORr8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277C2F42
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499978; cv=none; b=JHEyl9gIk+E22jJQSqHIN1CBUCHP+Ff6GYWEDDJMz+Lr8n3cLn+4tcIMznedfC9X40+0o59hc2z8WxdDwHwI6cv+l1x+p3OHMTNAOg0E8YME6UZ1ysHP2mvn4vLGMJzx2fIBo1p9wHa1XAn+oTFOE4NLtZy3cbL+gphAuWThJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499978; c=relaxed/simple;
	bh=lFZnER1Vm9wautJa0uy43bzsbxJsHX1JsZvXcSTRQek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPRQWlJUE8LXZIUsvT0DRXr6+WAOOorUAi/K/VDvZSDSn1a8bQTU8/h2gQVsFiTP72i6wYTfZr6C1y6aWmNLPpS8U5MzAU/sx6kZCeLtjpnQAAAod1cu18n1vrju5K1SohPL+wlGPP03XbgkDpF68cJIVOoQrmERgyb79SEI/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LplORr8l; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b56b1d301so751719b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751499976; x=1752104776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ViVAtpVE4VcSDimsjTVY9mf2hp2g98u/R7DQs9HH3k8=;
        b=LplORr8lDwrGj1sTZUYtwEd/VXxfAe5D9DMBI6/bF4SlIuom/w4wB1v5Xi8UXQhBNH
         GOxTe53v4gALsi0QMp3ga4QR5lMVz8Ss/BJF2tIQyA+3cqWZkVAZK1gxxw2S+z97Gp7C
         S31Pg1WIMXpPNKayEBCmzXxRYnpDVV3UjhF7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751499976; x=1752104776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViVAtpVE4VcSDimsjTVY9mf2hp2g98u/R7DQs9HH3k8=;
        b=K7DObrrwMHQnvdNZrj/C/DUveaaAwQSjsGjXr9R2uddsmUem/YmjhiFb9f30RJ5Et/
         yfPQtDgmaMSvRkmpQOui3cyr6dwlqGjP910ud8UBUpvXPjiyAb1022H1LIbeiI1ZzcvA
         cXRJ1vNuR7UqfKDzMwAvsA9NgXbgn6IocYct8e5x6PNqAeYHD5i/A6WO1ZlVdjOSLc5m
         M8p3XHQRrTaWKMVM7/oZB6bXGGsRSWuXYXcRZdFXXJwTd2ax7RFmd3ym5aZIiBjxRbX7
         nGb4ScKmNTZBzPuTJvyMrMbedRsPdHjhdRLm6L6IE4ILFrBzb204lJZThv9fylTRn4sp
         Tmqg==
X-Forwarded-Encrypted: i=1; AJvYcCXtNmHpi6unr9+ufj/d/2MW1dGHoJSCHFt7O5tShv43f0BFVi14SK6tX/yeQuAO7WkLDwTaIRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTGGZ5fEbwHi34P1f3zRoLrMN4oyzqd/3Y8s1Jhe58gHinooIU
	tNeVkmdj/bB0zlhwazfaIyCUEWuI0EwoJbWrxtwdf+NMG9iReKvjeW0FAT0BvpH7cA==
X-Gm-Gg: ASbGncuUR8xrtSzr4j+eS4vZcuN6ixPKpA++9ObyIqKdHKFCWMb8sLuk3hpb0NfCvg4
	WkxBsPQta8woj2BKWEpLCQ4THAcs+L+rlSKR/DExarfT3MVtnKgE6aaAs4zQu9pwmvzswNKpDXt
	6O8o6qUx6I7hoY6ljGWaC9yKftiRj7q+KqUyM3XKEdJu/LDbO0ZU7BoD0mxv6Roy4undcgYdZeY
	YA89jmp0mYA3Szla+IfvkOiZT1FlMA8d99kaTMXoKNrDlCThlbvrIyJWhOxZsbqI1umUrHOcM5R
	c4lIifUlK/gGD/w/vc4QLl4g7linc4B0Dc4BUbK0zbAzqT/h0yZbWz78CJncAOGMhpfKWMSXCb5
	vnwwxjX3B9YDdtvm+9+PI9a9ROA==
X-Google-Smtp-Source: AGHT+IFkUvmMZIS6AbfTX8UKjfSYNxAO54bpehBn2hbDwdGBFpbaUT9Igp1/olZCeelBx57rXIfgTQ==
X-Received: by 2002:a05:6a00:1488:b0:748:f854:b765 with SMTP id d2e1a72fcca58-74b50db5d76mr7542014b3a.4.1751499976000;
        Wed, 02 Jul 2025 16:46:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ee760sm14609644b3a.155.2025.07.02.16.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 16:46:15 -0700 (PDT)
Message-ID: <da323894-7256-493d-a601-fe0b0e623b00@broadcom.com>
Date: Wed, 2 Jul 2025 16:46:12 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/4] net: phy: bcm54811: Fix the PHY initialization
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?=
 <kamilh@axis.com>, florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20250701075015.2601518-1-kamilh@axis.com>
 <20250702150216.2a5410b3@kernel.org>
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
In-Reply-To: <20250702150216.2a5410b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/25 15:02, Jakub Kicinski wrote:
> On Tue, 1 Jul 2025 09:50:11 +0200 Kamil Horák - 2N wrote:
>> PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
>>     their two-wire PHYs. It can be used with most Ethernet controllers
>>     under certain limitations (no half-duplex link modes etc.).
>>
>> PATCH 2 - Add MII-Lite PHY interface type
>>
>> PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
>>     PHYs
>>
>> PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
>>     to the datasheet regarding a reserved bit in the LRE Control
>>     register, which must be written to zero after every device reset.
>>     Also fix the LRE Status register reading, there is another bit to
>>     be ignored on bcm54811.
> 
> I'm a bit lost why the first 3 patches are included in a series for net.
> My naive reading is we didn't support this extra mode, now we do,
> which sounds like a new feature.. Patch 4, sure, but the dependency
> is not obvious.

I don't see the dependency either, at least not in an explicit way. 
Kamil, could patch #4 stand on its own and routed through "net" while 
patches 1-3 are routed through "net-next"?

Thanks
-- 
Florian


