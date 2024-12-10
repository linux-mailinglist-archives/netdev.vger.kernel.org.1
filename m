Return-Path: <netdev+bounces-150777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5A39EB84A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F385C2857BC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F486359;
	Tue, 10 Dec 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zg993xGx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3823ED55
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851884; cv=none; b=SWVtkzSZ/RCZP7VkwAjoPjJL26jQXieTaKg6NYFJin2EWmS+GFUA97CLx9smI51gaRLlpNuRi7zsntyqDj2dTqFa9c6cd9Uq+zneIz5z4iFXdS2VMGvM3IIWkSPqtu3uGnuhQwtSRrQbyNQlD5OcAu8wdMmQZwWewVMwR+1y+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851884; c=relaxed/simple;
	bh=LDX4Put7YHTJvk3YIbAK5hIEb95SqCXeHJFsZ/q45ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ok2R+Uxrb7lWI2OtFbprfMFmjWY68+9EWhi7y/iecBG9SHXq9xGWQU9WCoHrRbqQ58sJ4F/4oxHKmbLz/xgth1+PMo8sRLgZtk2iht48byl3CD+0qSROiZqD40pct7BVbO3s+0rrJ9YM5h2J8ZtKOSfNsmNaF2m9HsK48KXYapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zg993xGx; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d92cd1e811so5523966d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733851881; x=1734456681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I8V1VSfxpMmVyfzg0oxisyMPMVlUfT9H28XgviyXUxg=;
        b=Zg993xGxlmOt2NbV0De72r+JHNA9IpIjAIk6nrtG9Ep61FuTVV1nz3KcBM6wSSyipz
         uUgM7mCxpE0uttrjqaAeksY3h1WJ4j3qdR7uT9G8GfBuGPI+jCHpaeRcIpKpLKuf1iuq
         Cz/xgXuRv1Sn/Ld+Dz+GDpP380AddgY93z1r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851881; x=1734456681;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8V1VSfxpMmVyfzg0oxisyMPMVlUfT9H28XgviyXUxg=;
        b=sG/LLeH91c42nq6atVCal0cqBM3EGhY7D9LhyfDtYhazFvA+BCo5txIjst00ARZw0n
         LdL9ZRj2hfHeHWI1RAmN+eoDLUKw0cVBoB8N5q0APx9NM8labx1Yf4qm/Wp8CxCdeSlm
         e9m71HcBtdyyu/DVM/7pVVACLCDvKe/Tn5JCD0PhcJSn/MQtjv/4gX7DeUX7PXpcHK5l
         fUgjucv8yofbHWsO74ZY2Hqc9PtjaapHbrSyQCl2m/i0bsQCT7lwXJUBZXGwUwmhMzfD
         M86bFFFJw587igHYecqsGYUT+K+akPKvXQlA9LSCjBilSFDWeBy9w2wlqKNyM5hJK5xN
         SYaw==
X-Forwarded-Encrypted: i=1; AJvYcCWDLh2Pu2wah5Jk9JT1+ksYXBjSx7RU6MopWISTop+j3N69eN6jqKZnu2vLsd7u07rbNg05BnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwgwtUNKo3phMDLI7CQRevtnoZvtPS4jxFNk0PZdjmX+i+HVa
	HsPOgox+EN8bunGiVjUwhZ0qTgFwlQhHH/EM9k/Wzw4FCjBvqJ13wNYrPogoRA==
X-Gm-Gg: ASbGncv21tB/b27p6y95nLk/gtw+lFfblbx27PzohGC9iGHCjGixSBmKPziwq6a97g7
	jLXQ/1FWgX718tUlWWePGqPxncHh/E44Qv3iw+jU/SJpHwlogBADZPH1ov46pfvOJNC26TLW18G
	aJUBVdi6ZN/1XMFPv2Riejs3hp3bxdeN9nGC9l5fWEw47Ir+9fSZjVQC4buUz+NogG9AkzsiPQY
	I2vXFEGxAMdyIVpoz1LKjb4yGuIuW66Bm49DT+AKoXyV62X2ZQOOFPP0lEjS/K3sbsbnvYR74fx
	KR8yxRrBNNkUR+BQCA==
X-Google-Smtp-Source: AGHT+IEkXsMZtQi0SxzurdtQ2yYOsZORuFYzdKVntvRnhQDZ7kWPDMJ8dLi2pIgoKy3kpllxDZ6/fA==
X-Received: by 2002:a0c:f988:0:b0:6d4:1d7e:bc72 with SMTP id 6a1803df08f44-6d9212d6859mr53621046d6.12.1733851880717;
        Tue, 10 Dec 2024 09:31:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f429a79csm44010436d6.72.2024.12.10.09.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:31:18 -0800 (PST)
Message-ID: <5531df46-8997-4d1f-8ddd-7ae9d5e56689@broadcom.com>
Date: Tue, 10 Dec 2024 09:31:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 9/9] net: dsa: require .support_eee() method to
 be implemented
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
 <E1tL14e-006cZy-AT@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tL14e-006cZy-AT@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 06:18, Russell King (Oracle) wrote:
> Now that we have updated all drivers, switch DSA to require an
> implementation of the .support_eee() method for EEE to be usable,
> rather than defaulting to being permissive when not implemented.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

