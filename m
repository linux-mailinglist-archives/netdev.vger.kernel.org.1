Return-Path: <netdev+bounces-185731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D898A9B905
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842304C5457
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9C215F48;
	Thu, 24 Apr 2025 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TJyWooE7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F131805B
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525986; cv=none; b=cbOZMU8utluAwfHso4LI6yzrBSk/bCTmM2tLcYYZjBQTbhQbRw8zaQUv9efvvOH0kRJtqbbMgdHY8XVy/HXAkZhyMOOF/IdIunJzz4dT2fkwdt7xaPwVDpSqtGEEjfh+1/KoTq4wDZWRsyI1Je1DEnbCpiVvN7Oqj1PlhZEqooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525986; c=relaxed/simple;
	bh=5c+CRoWXV1hlpVPXkhc0eMhRALczGcmSLYdQ5vJMsGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7D8F40gno5Gjw+TVIW9a/KtaDNLjFt0vlpt+zOmtbFpS5Rp6nCPZQGaLgeoazNnDikGrYXAwUiAOJUXFcmsVEqnI0Fe4io0akQ3+udic/4SpymDu6Z2y/R/peYILqFVOGYt0BHR+EcRvl0FxMIbixv0s65dhbMrUEHBDPTDbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TJyWooE7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c14138668so477799a34.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745525984; x=1746130784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmQE33G1NcVGwPi2vgMIL/Hoz7cI0gZ900VhF3qYFtg=;
        b=TJyWooE7oHNdvsffUxvnKUFg9XvRCu5wQtW84CglJVXg4b2vJzBAqu4jMsqq3rd/bH
         +URkdn+MjSdNmhEToUd4ToC3zHfKmue3mL/JR2I/fXOxYqDtQGIA6g4EJs/+EJNp1g4w
         E139cqINO+5Fr+Rl6p2phxGQV84za40qQYJOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525984; x=1746130784;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmQE33G1NcVGwPi2vgMIL/Hoz7cI0gZ900VhF3qYFtg=;
        b=mnDt8+MBZDnfPq78FVT8tH/DFSjpA6zPKP8OW/jwOTZCqDOw3Jsicj4paZ4/TM9FOl
         aBWuziRRYS7vmUdkb/F+btZ+bB8LZUjYEYoDjWVPpiJmkEEcNuZXb6FqQ8xP8amqEftT
         VF2FxQoskP3LnzI9EItLx8iOZToP0NjLObayT2uxx2+6rGbnFTF6AlFt9+Xpe6E+9Dty
         /7Gm43ui7v3OREUEVcqbB6cYuqJLxN1Vbvyv0Z9mQRUk2g9TQt0+2EGUrGK7KvzxyZqk
         ZubmDk4gqH3kfBEp6/Z51HmUR/TSk3jaDMXctax4eKGolY8ezFq3OxBkx/6kWcpPr/8T
         J+/g==
X-Forwarded-Encrypted: i=1; AJvYcCWkJ+KdvAoLt5qal3KTD6baXZ/RYejhwiKkNJpBmTu3ngSzq4sGm+gOTjLhtIODf40Mhh3pZ08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dMWMMSHCx/XlYd012w9QYu3KDl7xrTlb2m9bce2TTLVlMVDQ
	/Z9HaEErdOO3GWnXaWjpL4eSKkNdvigGl/6UOSm5MrQkTSgIrJUg87jGa9BLGw==
X-Gm-Gg: ASbGncvKCjqHvIELI0mauKHJABdvl7DAmH4tMZRFVvrdw9EXptq2P/rkOkloJ7k5kOh
	R2BQ/iRjR4fe6tzIy3kPH+vjIOrn5TKsgBu8K1TbKgm7voeDsF477gpR9AowjL74MKjUO0+G3th
	0gngR+Vso8F3LnVu+utR6ArgEKoX69GLLnSEH91MrxIn5H3fGAJWPSwvvU23QtA7gfNHaIvQi1a
	nXTpLRwjxCK6SMplFVk0mHRLtbEEsJrZJbsAlKeXQ1Fvs6PUcs/AYyootWzS5Cuzo3ILakdpAsP
	VBHjBDFU3mTnl2FwSb2F6HmfMSUPSV98MO/NncnbA9IPgA3CS5cHTQuuhckFh43cYyXQ7+ZRIjK
	SgK4RQ5juXjHkHFURvn3bOEQ=
X-Google-Smtp-Source: AGHT+IH0Gi3+AuBFCNcc9ggD7VxFPFfkZHjdbUoaOZzwd30dnG+D60/dgw/iLZYCd1WrKpuIWx/h+A==
X-Received: by 2002:a05:6830:661b:b0:72b:f8bd:48c4 with SMTP id 46e09a7af769-73059be63bcmr958937a34.3.1745525984158;
        Thu, 24 Apr 2025 13:19:44 -0700 (PDT)
Received: from [192.168.1.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f1888c6sm369872a34.13.2025.04.24.13.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:19:43 -0700 (PDT)
Message-ID: <29c72509-a58f-4309-953e-c1618695d8b9@broadcom.com>
Date: Thu, 24 Apr 2025 22:19:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/8] net: bcmasp: Add support for asp-v3.0
To: Justin Chen <justin.chen@broadcom.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-8-justin.chen@broadcom.com>
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
In-Reply-To: <20250422233645.1931036-8-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 1:36 AM, Justin Chen wrote:
> The asp-v3.0 is a major HW revision that reduced the number of
> channels and filters. The goal was to save cost by reducing the
> feature set.
> 
> Changes for asp-v3.0
> - Number of network filters were reduced.
> - Number of channels were reduced.
> - EDPKT stats were removed.
> - Fix a bug with csum offload.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


