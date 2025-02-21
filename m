Return-Path: <netdev+bounces-168656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2139A4006C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 21:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8B419C216B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680A250BF6;
	Fri, 21 Feb 2025 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aBgdtEA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8120DD63
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168555; cv=none; b=LhHxF2kIqNwHLcPOKNHDYWlMPNehY4CfOT1DNmZpOVn0dzOckaE2Qiet2zPNdv4qKLYy7iq/lhDhbDak1wRrYPIhAdKthAAcC1cBFL1c7xxasVOGfPMrjQKqmWYNAVO7LPtaKIR2AHcYj9x66Ie+Jtpouc12jNwZ4NXIe+HrbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168555; c=relaxed/simple;
	bh=F4ZxpWiPpVGVIIx6Y5UzKKxpUZ2iM962XiXBPB3ONhY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XfjcHjUs2pS8kB19yRCkDpVsDA99ds427mu802QG01w4STAmVmzKezgipu1Ypx9/aJj90Ue6afVYoTwD7tZrIlEomDgnabTYf5YZnOn0E2YS3B9ss9DPMwtPAAQ1GquTxA+PkQNVCfybjVnuzfWU4/HWRGaFR+hGhIg8KVqYy8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aBgdtEA3; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2bcbd92d5dbso1068693fac.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740168553; x=1740773353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W1lUGQu2HwadOSJWdDUBLoMmirB+DmWjdW3wr4b1Cj4=;
        b=aBgdtEA3kLKwwHLbVev9Bo9OMIcz4k//w/DjxQM6fmy5b/nlt9lfEznATVIvhIsePc
         KsQiVF7RBM1h/bbA6+L2g64L/gfIA+EgxosoYDieRZHDXd7fHyv8w+R9wZ7FYTg4lyn4
         YoyXZTQooopJEHdnPolQ1lrrQE+eA8OefNFLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168553; x=1740773353;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1lUGQu2HwadOSJWdDUBLoMmirB+DmWjdW3wr4b1Cj4=;
        b=BowAQ4a5pXNjEyJbLpL4VZhJFPWqluzemtXT68Tt5Dq9FBxnR84vBWBddBEjhZ5gMG
         GjQcdnfczbKuN4Ks8lGhzfXFoOUAMJrl4az5ahb5+ZKpHomrS4EkQLN4eok8x3n5BLYd
         H8uIvWDDOUfu3TkqEAkHKQDepl02kePq7IQqAwNYaDuK9Cx8PW2USa2GnTgUcQE8IWfZ
         C5tMhpqKnf4R6p+bOlh9wIWHklwMMC0Xsqq69DBn1KjOPvzy4L8V3rhnmubRqWwHKKhN
         13DzQ4R7vOwvcjnEaJLQ/tTN6KFSeV+C/eqGG1Db0ETZXKyeUFSalp9xIPMSO+TYggSU
         OjRg==
X-Forwarded-Encrypted: i=1; AJvYcCU91d78DVdS5LmbFmjl+fkIzW4p15Oxn4UnDPHHkEhcET7eTP8BrBwFeM9uaZB0ePaBm8PAwEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7JfGOhAwfdD8GnxQLiaIyeh59UqEw770eYLtm9nahkvIFA0j
	t7WLhtDV/tiwwsGpjMtPbTMvTbTDIbjj0uJrOv4JGNuJ3i7TldtLJE8zj4cwFg==
X-Gm-Gg: ASbGnctL76gp37WEFGwmH04mmEaS6SK+RA+QlYPFOGCgDD0zMaZo6aL///ukJTTmKVP
	yFA4UA342ZE3ppbprI7j2Rt/e6vfUmQUxUoxO06J+nLT9IhHVcTSHI7dN8hGgfjpgJ7nvQNthDc
	Y6Kwyx/yQ1JPhSFpCqX4qP/8IMsF4e024Znk6pxEKt5F56NYGs0/mrQvuXsGekmuYdIaaIJqVMF
	CmH5BWzMVbRY1VSEbatg9Qhzm13GQ2g1W622njqyGcWEiffZj3cyhZvfk8PMPK98CPWyYrUSUTT
	h2oatDh+UmGDebZtjAEfwr8hixx2VfdJsYETnqc2FiGJDP0LzYM1oACRsTfVdIvXKA==
X-Google-Smtp-Source: AGHT+IHSa8f4sqShohgGPtu37G2TvzvQIIJNhmNCM0Znb6JovHA4q8y5Xak/spLsgW1qS4w7BMynGQ==
X-Received: by 2002:a05:6870:4191:b0:2bc:8c86:ea31 with SMTP id 586e51a60fabf-2bd50d808cbmr3370127fac.20.1740168552765;
        Fri, 21 Feb 2025 12:09:12 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72728fba70asm2632841a34.50.2025.02.21.12.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:09:11 -0800 (PST)
Message-ID: <47e20ea6-e5fb-44cf-810c-5fbe8d26abcb@broadcom.com>
Date: Fri, 21 Feb 2025 12:09:09 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v2 0/5] net: phy: bcm63xx: Enable internal GPHY on
 BCM63268
To: Kyle Hendry <kylehendrydev@gmail.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
Content-Language: en-US
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
In-Reply-To: <20250218013653.229234-1-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/2025 5:36 PM, Kyle Hendry wrote:
> Some BCM63268 bootloaders do not enable the internal PHYs by default.
> This patch series adds a phy driver to set the registers required
> for the gigabit PHY to work.
> 
> Currently the PHY can't be detected until the b53 switch is initialized,
> but this should be solvable through the device tree. I'm currently
> investigating whether the the PHY needs the whole switch to be set up
> or just specific clocks, etc.
> 
> v2 changes:
> - Remove changes to b53 dsa code and rework fix as a PHY driver
> - Use a regmap for accessing GPHY control register
> - Add documentaion for device tree changes

I really preferred v1 to v2 which conveyed the special intent better 
than going through layers and layers of abstraction here with limited 
re-usability.

At least with v2, the logic to toggle the IDDQ enable/disable remains 
within the PHY driver which is a better location.
-- 
Florian



