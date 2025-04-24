Return-Path: <netdev+bounces-185725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACFA9B8F4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9380A1BA86FC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD81217733;
	Thu, 24 Apr 2025 20:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pgv/Ug1x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5F1FF5F3
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525823; cv=none; b=SQI+ssH+jA3X4PjvQZ1v+EgSg+Ex1tFLlRZ29EmZ45HKyhfx+PzrMJR/Onu/c8EGCAfmo3W+aJ48tLmN9tEBgT+fqncx1dFxmaFVC9sCXFTBCF2RYr9Ea4cprRR33RMUM0BUcsXZBgD4gXzrZbJbVD07ogXTG2Yug244Ex023/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525823; c=relaxed/simple;
	bh=q7+AggGY2P8x6d61VyBgTJBxqn89Btlr+wPSFtNEJlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVaaM8p1Iduimz57bR0uEUDvLIykSKWqhp0KQlCivuAmtCRMz4wDg+++fCABU5jOOTIH9ZEDlM/zvpRDEmjAj5m10w+R3QARJtzWcw3q/P+Yq37Wa3KQm6okqFgnPGOJcKD1E6AJs/e/24cf47uWmS2aHkQpYPsTAquZMO1vQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pgv/Ug1x; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72b7a53ceb6so936797a34.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745525820; x=1746130620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z/L+CJR5eqDHbla1VgY3g/G5fHe3MIqzD/ToDfzZ6c=;
        b=Pgv/Ug1xRTXG5cD06t4mqS/fTtFx1CmdqmDtTtInYaS4CcEAQDdtfR3Q+Q39EBnx5H
         c+oUF+cSr1sHdOVUgMjfInewQH6FJuDLdT0wCNTM5IIPv0dkYuARnrHQ76QgG0QJd6zs
         uNR4807AnZxBOyiOefe/hcl9SKSRNmXnqPjQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525820; x=1746130620;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z/L+CJR5eqDHbla1VgY3g/G5fHe3MIqzD/ToDfzZ6c=;
        b=LgFBkFcHIWpN8RgMKn2sh6DJV8yx5KQKTIb2toaXEySd/NLOViDKsSbZ/Y/+GyHgtN
         qb+xw9RB4EiHswwiL6vp/ImSVZ7/6rXqhxshevpmGER5/k59/zGzXFcVwZ9b60gAtT2E
         JORl7lnsPr8G77V2zXJtaAQqvFGeC1OwDKra6kJvs2g2XC2f8dZh1TL98o4W2865StGj
         BpLYh2PMMS7cKn9SsPzIdsqx9Ki8KG940riDCXEpSTolHQuSA74AOANrLbNSGonX4/17
         bHHGT5bGFKZXoYm4BtyXa3TlF+Mx2STmeLYqYw4BIlHJJB6iqtOKt1EBZjw1YwgGZjMF
         Ib7A==
X-Forwarded-Encrypted: i=1; AJvYcCUwERahnhspkgrotiDM4odF+hjg8LWimIZSrf+HPTH7sItKpC2lkWXs/t5BJN06+Xpu8Q+Ctoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDY8hl4vVx5ldVNvdl85n+iTvuqkFHIzXtt6iEzuPA+0Yn/r7n
	Ril9wgm9uVhfV8VCyu7y5+KtD0stgPddFI5+BFBdHh7aefPchPWVevbOqGJBbw==
X-Gm-Gg: ASbGncuvR+dWkfYlLKzk4Y/CPNd0fcRiSFFDuc0nnNqVU4D/aUEZqt2GGKZv9zbnodt
	4VpgDhzEnQ9qUgc0UlkHGsdEbY6lkYsgH5bgOd8yv3PM0G/BNV4oaIrOlzZURt1+DrvkZAfOmQM
	dhbUxMO5GxehtgR1IOxuZRYx+7ozgO/njzAMCfbZwc/dVjm5qyOk84jF0ePYaOz4ftNufMXqvUT
	QzK58bLcU5b6m1c2GdKpgk7OLTvl9xcJbTRE292UjUaifkPL02N3LEtGN055RyX3HZNg3Z2VxRC
	TU6Gd8Qn3UVmsYXp0DDiZN0qRHa4M5tAovfrfiBJ4xAeI82vOzxurDoVgtEbNEPXh80wzc/l4//
	hxFNH08WBexhV9STrIBaWw4j0vn0misHF4Q==
X-Google-Smtp-Source: AGHT+IHZMjAwrsNEjpm7nL05Jbbd6lnVZP+y10KBvmSKSVE/LtD5DIqqjB2QcCK/bT6x8RZHKOCVKg==
X-Received: by 2002:a05:6830:90f:b0:72a:2b8f:b111 with SMTP id 46e09a7af769-7304fa68718mr2007515a34.1.1745525820350;
        Thu, 24 Apr 2025 13:17:00 -0700 (PDT)
Received: from [192.168.1.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f187fa9sm361427a34.11.2025.04.24.13.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:16:55 -0700 (PDT)
Message-ID: <35f16f28-5682-4097-b459-4960f404eba0@broadcom.com>
Date: Thu, 24 Apr 2025 22:16:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] dt-bindings: net: brcm,asp-v2.0: Remove
 asp-v2.0
To: Justin Chen <justin.chen@broadcom.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-2-justin.chen@broadcom.com>
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
In-Reply-To: <20250422233645.1931036-2-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 1:36 AM, Justin Chen wrote:
> Remove asp-v2.0 which was only supported on one SoC that never
> saw the light of day.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


