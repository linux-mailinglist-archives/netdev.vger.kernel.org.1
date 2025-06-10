Return-Path: <netdev+bounces-196231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4489AD3F33
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54071887518
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 16:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFB2417F8;
	Tue, 10 Jun 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RoXAi53M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0D2356A2
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573640; cv=none; b=KZ3Js73BvNOuIMBERrmZrOboJ9rmS0cxADWTr6gzECmQ6Sl8VPxo8SaB0231dArYuS774OrWGJ5h4dKHfQSZSvjcCI+/01pQ+PVIhuhtn3C6m+i11d9kVgl5kLHgzHmlgvHqTwKU4chkDWQVDMc/wPNS8lEkAl6x3NyqqIljSFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573640; c=relaxed/simple;
	bh=sQtNrbN5nwhTTrb2S/j73belib4zJ/u7Qg5dcblcb24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=teTyu7ZEMYAYJp0FrJ1sdvcE0k1ty6NaoSXKtyDtzEv+XGIWzVHlkbUfN7eJ/+2JMj9un5yCdiuqtKQK7r/UiSVIctMh6WtO9+s0eFVTbljUTuGHV0e1LiLq3luLdRlFZeyOi0yz7uSQXleMNDhUd6eXgJBR99xcoMkD5/o8YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RoXAi53M; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4441441a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749573638; x=1750178438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vaFgOvgVlB3HEqOAwPD8g6YbNrDNAicK2+XimO5TWqM=;
        b=RoXAi53McAuwLUa6T5cxGdsYCuV5zOpupT2ZcpExKKP4SV9j8v0dqkf6zRfAVxgZCY
         tynS4AdsJAEf05uRhygyRCUEzMIaL7q4x7Uf8cZ5Q70xoHi5IrgdwBM6bU1h2BIVg3Ay
         nstd3P7/blNxtuQTt1c271877SRjbZeY91oII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573638; x=1750178438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaFgOvgVlB3HEqOAwPD8g6YbNrDNAicK2+XimO5TWqM=;
        b=G2VhJI+bFDz48HKCE6jVrZVt5UDh5hWsCcTrY1Ks+5wLC4HpD1PmO8bB0k7ZvbvB12
         xG4KZIakTYRqu6aSSmbkm9U3qj+WatA7LDKbKabzwZGZBLpwT7FsStWuz4OeK9qvuG+q
         sFqONqmBnWXGOhG5x6/DNVdqRXIEbjnjyESLHSrQI3X4SiWF/zAY7k386vv7rLHNDgd4
         XeYwDBScyY27vTEYiSw5JIrvBI3bSGhp5wKFjC0bIeUXfki1mbUpIa3riydm6Y+VjD7a
         MC8ScMEU8YwAf4aZ0Np8UknY2SoejaRIzVy5Zh1YeOF0CEql5GmeLH3M59IKPfAdzlIo
         FuwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKr7kTaH9Xr2xkkPZZc4PSl2OODg6JRBZU6eJgaZPl0MD/4bGqqlUGLEjqY2ZclB7YbIIe9Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHsOe1KRp6fBkR4ahVUAdfBmJ0stkB9Gz9R/vl3Rr+7OGrCaB
	nVlfJ5f27tE30HiSuKtFaRpBDYJDJApNVZkcPUOg08NpuCvwkkBlqLIyzrFTGe8xBw==
X-Gm-Gg: ASbGnctLCFCLxCkXhQdbm6GB1RJIPtOoQo23LpUArv8hfUnjXlwTZ28NV17JwC88V7Y
	i1LrcQEpncjP1x/Fb0JJ2PQZCEV2xdXMMyeexid91TqiDLeV9qw+37zRGdtfzzGxf5ylfhHbmI0
	VkgepEf3FJ2fCIwPw2kn7oNXXzoSRnsLkwdY4r8hBMS/YZo4XlW9hAu216iHRaFEDqxpSAtGNmb
	Yr6Zk5t2omkkKHP3OZYer74i7dO5dadfgcylVQJbE066SupYEUmeVHqtXqm0xl8iXYGJtvuSkzB
	hXM9IXn2moyGCT4ZiSfdatXiup668BRxSu7bcPIDcm9FGh548Ui4zZ1PrVHdxhfq89lOFTW2jWX
	WD3hJF3pgvKjsjjXwZVrj2ljDAA==
X-Google-Smtp-Source: AGHT+IHglj2OvUWxUQUKDzP5dW8W76zWY8oIji4S5rf6Fr2b0APQMW8Jcnq64Qr1kM0cZgPhUwhg8Q==
X-Received: by 2002:a17:90b:4d07:b0:311:c970:c9bc with SMTP id 98e67ed59e1d1-313af21d9bfmr335830a91.30.1749573638301;
        Tue, 10 Jun 2025 09:40:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b058d84sm7418120a91.13.2025.06.10.09.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 09:40:37 -0700 (PDT)
Message-ID: <a94c50ea-1658-48e3-8f6c-f0b6657b1d79@broadcom.com>
Date: Tue, 10 Jun 2025 09:40:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: dsa: b53: support legacy FCS tags
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250610163154.281454-1-noltari@gmail.com>
 <20250610163154.281454-4-noltari@gmail.com>
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
In-Reply-To: <20250610163154.281454-4-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/25 09:31, Álvaro Fernández Rojas wrote:
> Commit 46c5176c586c ("net: dsa: b53: support legacy tags") introduced
> support for legacy tags, but it turns out that BCM5325 and BCM5365
> switches require the original FCS value and length, so they have to be
> treated differently.
> 
> Fixes: 46c5176c586c ("net: dsa: b53: support legacy tags")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

