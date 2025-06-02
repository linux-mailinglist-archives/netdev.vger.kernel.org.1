Return-Path: <netdev+bounces-194628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8947AACB92E
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E3C173F75
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35193223DDA;
	Mon,  2 Jun 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TxaYb92P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F42221F00
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880047; cv=none; b=P7qqte21PMF5ranrSLVNCuH1swzRfJY+1uVJLTS0ht2VZ4eN5HPAvavX6KyBRDjC+aqP0/Qbin3FK64AvbTt07dRhxRVlx15l8pUOHpxj1TeJkvjEPj7oXWga8llN9CwsdOlPaRB7mA5tJF65HUvdMqo3N3ja4/HVKSGUe+syOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880047; c=relaxed/simple;
	bh=t/FJOHrpCt5cISyU55l+Sr9dZP+jc2bBFIZi/Z4+SG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DsnD27cR1uP8T87erA+yFwDBPjUqB1dRz3VDrRWfUoM0Y1/GIr/mdhCtSk5KaqGEaTXKhE5/CKzSTcMjhzlZAt57xDtRsShA9+t0H9lrWmmf8mUYycmZ5Nglk9ClOZ0rPB8Bxdv6OmlrO2jJQI1rJzcVuTpXTgYR9anzj2GDkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TxaYb92P; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e16234307so37820195ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748880045; x=1749484845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TwkADAmdeRjZshh1FaFvp5LHi77fW7YjVJHvCxoPxkk=;
        b=TxaYb92P8x35vTppJxMiameT3yFVolxD27xvZjU8ysJn9HP2TrFB67lO27xvP3eJja
         gagRd0SNTngqAz9HawCrTMvpTnj6Pf34H28Cl2qPzlSI4877FvhupwnK4S9NHRnOUUVT
         E6rBCcwgmwvC/ve1OAQWcg/aFpx6pTxIxpAmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748880045; x=1749484845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwkADAmdeRjZshh1FaFvp5LHi77fW7YjVJHvCxoPxkk=;
        b=MEdDwandgtCay/IgZE855Iufsb2Nq238gB5r7xXVoLkHE+bcDoshW+BXnaaV6hXcPH
         0Og993gHKayP7jxZLbhv1l6SZpFCIxGtKR9W1YuhohX5yNemr+TcVP8InlNLQpXUXY2f
         lF2bwcfY1xeo1UAgN1y5X4UmDgdAQywIm+GzqSpt4vNcWsoL4V3AGjM2PQLj37mlmZQ2
         nxAosthVW9MENQ/Zr2rb4jNCqMNWNRY78eAxJD0hm7BZvHGTz5AP8gSFb8mwQ0JWrE8z
         /PFLBL2j3BTuwdt3FRMgxXCgKUdi3D5IgVqYGTPmAxumkCEJ7s78aFig//oyKLwn4c2N
         3G3g==
X-Forwarded-Encrypted: i=1; AJvYcCWR7sbQCJ6AEhblh5HpKHfxbqkYSJms91JqR6ny6J1Hz6x5ti9rY15DHgefMHwr9185LmSXlVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvqfjWmeCocF0SNwiAX59Fu9GohezcifgYQNXq5aKnc6/OfM+
	huWrgpz01T/XZ1cHdcj8i2LQj0e74L6EtGBCOyhwUXBuurF1Hssm6U08Ylebsfbzhg==
X-Gm-Gg: ASbGnctpDTGtlOs62Aus2ldHw/jMbZhzfWi0a7Ny4Tfa6QZgJxjh0nqD1BfaZU72ahh
	FBhwMaZqVvHYJhKDMgpHXQyfkPByok7pfNSwdyNVC2eBfjyTz1XZJt7LazZXsjHNEJ390ppeQWl
	W74O/FBRUmuzFduRpA4Pw6JiQYVFYR8rP47G4yTuvtA4BIHwCRD5va9D/Eg5p56I0rrZcupJsua
	/L5HegJk+537TB0GdsmaJZEmydpwC+jAOv2wOETBRugsWFcVRnoFVzHVxIbmNj38vmne4iGkl9P
	V+aedXRlvaFWuNafHn8UUg3ehHjEUs62u+dFlA5GMZ3TOa2Z+x/54czXpSshYEjIpCYpB1t9oet
	3U00I7FdVym7ivMY=
X-Google-Smtp-Source: AGHT+IHh6cT/YAwvfS4kUFuIL2MKI/IRiBEXJUzAJrsGH+bLlBAjmVm5sjfCrSK1mO5PS6muaL98rg==
X-Received: by 2002:a17:903:2f88:b0:234:3eb8:5b52 with SMTP id d9443c01a7336-234f68c5d1dmr269789625ad.12.1748880044946;
        Mon, 02 Jun 2025 09:00:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8657sm72680395ad.30.2025.06.02.09.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:00:44 -0700 (PDT)
Message-ID: <d7dd8b1d-0e36-43e7-abc1-74a477dba06d@broadcom.com>
Date: Mon, 2 Jun 2025 09:00:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/10] net: dsa: b53: ensure BCM5325 PHYs are enabled
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-11-noltari@gmail.com>
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
In-Reply-To: <20250531101308.155757-11-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/25 03:13, Álvaro Fernández Rojas wrote:
> According to the datasheet, BCM5325 uses B53_PD_MODE_CTRL_25 register to
> disable clocking to individual PHYs.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Would this be more natural and power efficient to move to 
b53_port_setup() instead?
-- 
Florian


