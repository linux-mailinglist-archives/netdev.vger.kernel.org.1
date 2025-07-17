Return-Path: <netdev+bounces-208001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F72FB09450
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F1B16E5BE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DF2FEE0A;
	Thu, 17 Jul 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sw0Jjl9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933442153D3
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777963; cv=none; b=ArtexD31wlzk0p4n32oDsGjxt3xX37myhBo/kVWf39a4c01hBK3Yx3j6f1Rof5GjVcZE1sNe1EXQMYS2+JUo7UcQAEF2f3O1wH1JdIrLnrk5Vp5efux4GH12ZPCxRXQAIeA1uf/kvRygeVJ9YdtL0isv8L/19ADUffQ6Mpg4m9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777963; c=relaxed/simple;
	bh=sJZEN6Dz7NKPi+6R0FCojYkccMA61uspx+DmZv2t+5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G09hbDTpKHurJzngr9ZVCT7dztj6tDuqPukpKJzaM//te2XHJidIrsRDeRtnDpPAVlw6AKUUS/BVZ1mM3QIdyfvRAPPG6FgPwtywvFqOA7/WYgQxn5Lm6pdssIIryeeWC52RvjWx7Dd1YOqro445Y1cW3qV/iAlwLez6fGrNOWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sw0Jjl9m; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313910f392dso1093700a91.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752777962; x=1753382762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6HIRLLwlsbQ3s6yP4+BYQWOZ/+/9Ewj3PHCD6zKkiCg=;
        b=Sw0Jjl9mQ/r1W0FpPZAmFoUre4w9nQaZL50E4LHVsTIC2WZFlBtHbjyo9jChht7eNO
         jr5w9KgQ5NUaCrTD6vpQIKLqsuX1X9rehv31utO93ZwCdQrqMcBFrwrBci7nOxKhWOnT
         3ngqIgnfIl2rlsH8G3AJ8+1pyOajIevuoAuKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777962; x=1753382762;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HIRLLwlsbQ3s6yP4+BYQWOZ/+/9Ewj3PHCD6zKkiCg=;
        b=lyKMAENFXVFsIZmpN/2AV1nnYKL6BfXb1pSkfwERHxnJE0SlmXZjqCiG1bHEYao0+2
         L+INeQf5aYBmRDs+V1z0C/J6MZ4qBS7N2jFgyIG8RjeiBHT2+6Ku0Xe51MAN9KPU8XSN
         FnloIXDbqtPCcYDcWa5R3d0OH2P4ajYe2sBl0TYUikwr6Mtly+c/FLUjY0mFL9+FRWUF
         AtMEweT5ybHTzuZV92zMm4oFjKFqH21ZaAxoRaXUFZoZJmqe36jEWpKM/5/y5AqdYad3
         pynBE8PhVTi/Sy/ay9/Is+f6vcGh+iL664FEJ3uZLaAOMDWUAHkvkADT3vdZ0Ymubghz
         HVSg==
X-Forwarded-Encrypted: i=1; AJvYcCWdL0BXjtcL2kTxHcJf0aqlt2Vyk/qemgKZYKhAzw+PRpKkDQmAVZR5q8fkWbeM8XhPhDr5wTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPPtSYav9hhF+RcFnQRrTCIAXrLe6w8jseS8KNcbRaRZZf56F
	a0fuAwiYNKe1e/UGre+JabULeXDEmqAPGe5eA4d5OE3Umxb9k5E7d1hrkshmYoLP9A==
X-Gm-Gg: ASbGncs9+9huQzFxOMEbTRCbYWaRxd0wXDEplJFnciBre900Dq0cjDGa5PnPJiZct65
	fUVWAiygh8wyprN3xwDauyLVJHopsU9rMARvw5phgC6eJ23CpViBeo7PAwxFH48y1w0sRNsjefo
	b26pTWM9vBW3x5TVw32VI66reoo0NJaERZbiVrUymlUSYxjLNYOeKFndCAspy+RVMVbBHk6vlwS
	yVRaUTuoheK/FeiRpnMybVhs4ORTEqLV4wRVmLTKfWsX81Aa9Gcpwe77KHRfEurp/NaNnDbow4j
	tQcfjgb0FW0XsG5wk3W58ceXMlyHl2OVPuG9VDoQVct614QG3fmvPWqFulGqDwQG+2HNfrxYLyq
	7Yzk+GB3IlL6DmbB6KqBa1kUjEJAyjMnM38856rhhU2xGx/iAlqitYbAj3YDeGg==
X-Google-Smtp-Source: AGHT+IE7PNgNm+lVUrl/sE9LYo9Sksmd8KXpVZ/A556R4wAmTQQZolcT3p/e185U6GSIz8W2MmqdJQ==
X-Received: by 2002:a17:90b:3ece:b0:312:639:a058 with SMTP id 98e67ed59e1d1-31c9f4d006emr10860697a91.27.1752777961698;
        Thu, 17 Jul 2025 11:46:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4346b70sm148103395ad.195.2025.07.17.11.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:45:58 -0700 (PDT)
Message-ID: <78069834-d320-4ff0-ae6c-cdcb1c3824c6@broadcom.com>
Date: Thu, 17 Jul 2025 11:45:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/8] net: dsa: b53: Define chip IDs for more
 bcm63xx SoCs
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-5-kylehendrydev@gmail.com>
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
In-Reply-To: <20250716002922.230807-5-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 17:29, Kyle Hendry wrote:
> Add defines for bcm6318, bcm6328, bcm6362, bcm6368 chip IDs,
> update tables and switch init.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

