Return-Path: <netdev+bounces-185732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E218A9B902
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240009A7313
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36517218AAB;
	Thu, 24 Apr 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PiYCNyBC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB496219312
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525997; cv=none; b=QzafSzA6B4ZwHdk4hhHQ1EJH/1MDGTVxfVB0e7akRDkEkz1+tECqnCVpXSbZ2D0HDyGZDzvoonfBASPFPyfPYdLWVysqnLvcP8tYfKIlozM19Zzv7ax+53L25etUEZjb/pYW3BAt26ZOQRiQZqIwoDaqGg1FOQTaTi2zWH5PdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525997; c=relaxed/simple;
	bh=5iPa72UAkXIvDyL1PQa82f4egjwBa+QCOD0WtQLU8FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXPADV5UbZ3SjjIpvyRDIK+5TWPNKx2CbcZwOaHLa0Mtn2n0XEN8p+OKeqQNSYRQMi3XoJTMCrD6Jv0jPhM6C4k/3ZuKzkVZFF6qLTePJ58PuNaZz6vJpcAxGN+a3Ql4Fqy7XOUg2bwFfZCvORb3EsnzUTu0AjBVrqpXvT8chWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PiYCNyBC; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c27166ab3so1112796a34.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745525995; x=1746130795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0yq5lMgXDiFaesG4LKzCcD2v7012h33cfXQDmHxtuG4=;
        b=PiYCNyBCn2nlan9eXCVPYTznQKxdDzygWkoASpTPKIVPaxLyDpUIpRpH+Y7EiUox+r
         wXwmuZBWRh0JOai0jF9xs3bAVPAj9pDGtiBHYypt2Gvue317CEBFUoSDM0iP78jWAs5v
         Wi1t1vNJd1khpknAEzOPtjzg3fr5/I7OBCFqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525995; x=1746130795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yq5lMgXDiFaesG4LKzCcD2v7012h33cfXQDmHxtuG4=;
        b=PZy2dThMslOEB4ObNe4WiCCvWJfS/UBKvJGLRQiOo/uVv8kfhUISIvEYEX3e0VcZ38
         c14J/8YZ59Ujnfa2FMvXzOYUMoTBPKIUdzLd6aO1TKbHoHiEZk28CDOHFD+OJ68NNuuG
         K6KxdSMcEXonopE5o/GEskOwGE8qs4h/RMPSduxVy73TnvEHBX/gy37fLkal0WC1MZvK
         MS5nAJNAek4dot06X/3ROyttcXL1ScqVuXSr1G1/uGAFMPxwtMbcXEp0DR56djMZ+kfp
         5Ub+u3QyD+0H2LVJgXRMlcC2ro+HXFlIT6pFrbSmBB9LLF3cUFhlPA79/eRr4u2EnB7P
         X6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDpomDlytVCviAGXRAf7HogLotTmdHWXcamwxr6iJQeHD/2DnwDS0yiJ7czXsajGUeodrPjk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+y6FxJuouS5YVOzeUW/K7Zcz+u5g2r0CgTIZgTwKv98IA7r+Q
	CeahgecuBVqldnkUKbHbRaNiAGwkC74+FhF5+vWvZSmhCoWkK2VIYklSODWYGg==
X-Gm-Gg: ASbGncuoJwg/T5nUxReCrhakLlnbEQoI+oVzDkyI7kvNAK5FWWou/Nz3ZSesMVJ1xIR
	4VvTtnBgELcEbSH0VlKIH4DOgxK5XJ+UhRLnBoFHg6G92UdnKjBuDW42X1Xa5gn0vwRtjyN+cOT
	8i1fe7xD/aOQMPfb2BhwMgnLIe4VwrrMoEXOrlpZ5LpbQaj4GCGTOBy5uXWqb5J3G/OHJtDNycb
	oitZRmk94R2Ey0hlF+NSMSgdhJXUJZbNAJ8EQXSwz7s/SEoVITlL67JWy0UNUwCMDCtmIdBeclH
	Zie9I+URHRaZOvXEsLYgNNH3oFaDvC7SmN1S0ihfTashTyjgS2s5gak+o3gIroRhhtIzIyQ5ydI
	9U/4iBWEUv2vK9/qI1tl6dPM=
X-Google-Smtp-Source: AGHT+IEnBbgcUyTGJuZWPWLP+5vY5kA8H1s8Et7DMQOpu1uHyLf1BvUkAEuVQqmE9vJeNV3C6e/Y+w==
X-Received: by 2002:a05:6830:61ce:b0:72b:7e3c:7284 with SMTP id 46e09a7af769-73059dbc502mr821806a34.18.1745525994718;
        Thu, 24 Apr 2025 13:19:54 -0700 (PDT)
Received: from [192.168.1.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f1888c6sm369872a34.13.2025.04.24.13.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:19:53 -0700 (PDT)
Message-ID: <622058ed-6706-4550-b23b-97104af3e0fd@broadcom.com>
Date: Thu, 24 Apr 2025 22:19:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 8/8] net: phy: mdio-bcm-unimac: Add asp-v3.0
To: Justin Chen <justin.chen@broadcom.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-9-justin.chen@broadcom.com>
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
In-Reply-To: <20250422233645.1931036-9-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 1:36 AM, Justin Chen wrote:
> Add mdio compat string for asp-v3.0 ethernet driver.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


