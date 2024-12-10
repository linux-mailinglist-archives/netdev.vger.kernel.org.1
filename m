Return-Path: <netdev+bounces-150770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B2B9EB83F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC52284D98
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76BA23ED4C;
	Tue, 10 Dec 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hQXMCNqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12223ED42
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851756; cv=none; b=W/78g+TTy1uaZow6b4EqxN6WCjkFaWBt8gz6L3RKG+hVQX1Tq1Xz5jL+GWb76Vk88+F7nCjIud6/VYBDbZLyQPxlx42WYffIpMFxJn+/Se4pc3+GaEk/GqYGunbbuz8q/INPImEE041ZqYzF59OcKF3UcBbZwtMRnTcoQdO6hFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851756; c=relaxed/simple;
	bh=g0NVoYi0Sw1UDuwMlRR/K2s6aFav4mqjbzP7+//rUJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSBXlVCEEFctrF1otwoQQD6So+ZyoOHLQF0ZWKIibz3xa6mDW6x8BE3i/Pn3TJmD5wco0amVJSBN/hh+eexgvNTStjtv8RiNXvItkg8SUKvouoT1ES7bB73/HYqxxJ0kO/seduMoulikSP35U9JF5DSxOgcEdK7s/krPu8nQRGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hQXMCNqv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ec1fa493so1961455b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733851754; x=1734456554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=thZ6HBScxy6hjzTPhBEM1jXA6AkJmhpnW61fmrZJx8k=;
        b=hQXMCNqv7SRhuqs2ofvZTdbiIP5e6WN5Mwvwgbqj3T4DZ+bx3TaZPVcDUBMh8JSvRM
         Edf8KbNGMHWF1QDoPIAVZtXxpjSzFndCM6eVR6FcoJODZsWQyMJbV8SVIDCYKv5FTmTK
         rXkVp8t0M9Ipd0A7v2pfBKJAmbJU46rzdVBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851754; x=1734456554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thZ6HBScxy6hjzTPhBEM1jXA6AkJmhpnW61fmrZJx8k=;
        b=YWWnGCfAfF7GJutRbitEWMbT3p/MOtSriMnd2vnxFvDdf4V6EIykQx6UJEB1EMgCKB
         Fq40DXtxJN5KY3p/8ilh9Q+UJBe4g886TL2BS/KDyeclpvk1qFOKiWlRUJ29X7cmXQiV
         jA+wwvw//ihot+hu9TlkziehCNKFowfIJyRGAHTNMvTeMZ7tmMs8Ozv850akwaVQITIh
         9yCj8uD/g/UN1bmDgGn1qILU6uLH0Jvwg0S6DpjZa7PvQynfKO/90p48w9OtQRkzv0PW
         0E/tEraTCmxkdkTppen2nhEZ0Ti0/CilVMAwJk992pn4K8M7oaxcHHZegEhqGiurOrBC
         Tp8A==
X-Forwarded-Encrypted: i=1; AJvYcCUEuHZ53YSR5sFQRUA/qIvmqJV1FFVSY2cG5uK4YxoO2UMXfsGSu6HGTOBmrP4FiMVR23VVs5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsAGciMP+smeQkyiyBdSrdM+VPyBMXadpaD7Fv0iu5AZHKKwm
	5+7hvEmPRgNylrrpT+mNHA2e6bNSXWQrDdfBxKtzPbFT6ZhFUXhArAkbNnzokg==
X-Gm-Gg: ASbGnctpBaQ7jV0iMJf+EfdzUS9xzrHaOT/a4oDPlXke0Gn81FPfs4INqamuAkOMBKn
	keoyTB4HLbvOXDVWU0UYO2gjgpYlxkyRPKivqOl+1mbgQ9bfD9mxV/NEnKDAZmMwbKHmNwYUIZu
	oeoOrrL/Em/8Slx7SPwrD8ggcif/KUF2W7SnmIEajc0dYr83clFbwsFXOmBGpL7e4mX2fMFz4EV
	CuBDgvr/KyGdAGcOWc2z4sgqDzgrL52UwZRjxuu4ocLBL3TmYoobbjSm6H+vDToBNw4LnR8HojT
	pVLOg63Iae83hpWszw==
X-Google-Smtp-Source: AGHT+IGswyqLLELjtBCArvNLOpVscRIPHwqHRgt711FovFWA1BmClq8upJlUYZEQIZa8zi/YjLEFzg==
X-Received: by 2002:a05:6a00:1acc:b0:725:ae5f:7f06 with SMTP id d2e1a72fcca58-7273cb9e915mr9683950b3a.23.1733851754514;
        Tue, 10 Dec 2024 09:29:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725dc0b3ed5sm5585584b3a.87.2024.12.10.09.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:29:13 -0800 (PST)
Message-ID: <26fb01e6-a735-4bdc-a074-5dd141d9db48@broadcom.com>
Date: Tue, 10 Dec 2024 09:29:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/9] net: dsa: remove check for dp->pl in EEE
 methods
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ar__n__ __NAL <arinc.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>,
 "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
 Simon Horman <horms@kernel.org>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>
References: <Z1hNkEb13FMuDQiY@shell.armlinux.org.uk>
 <E1tL13z-006cZ7-BZ@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tL13z-006cZ7-BZ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 06:18, Russell King (Oracle) wrote:
> When user ports are initialised, a phylink instance is always created,
> and so dp->pl will always be non-NULL. The EEE methods are only used
> for user ports, so checking for dp->pl to be NULL makes no sense. No
> other phylink-calling method implements similar checks in DSA. Remove
> this unnecessary check.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

