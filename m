Return-Path: <netdev+bounces-150772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D89EB841
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40E81883D12
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AC86347;
	Tue, 10 Dec 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VeVL3l1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4658634C
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851815; cv=none; b=cMsYK+YUDwzDx+4b7DdcZvU08KJo60SabKG9Uw0KtmMLSTSvy9308LTcd9LJ2oRAi0Efs5a9CZu5HY3KGV/QbNNkLnGRMQaCMAWfm4qoXNklYQIpxssg6jRjR5MMDF0Sf2nfXWMsNdG5D9ybCSzy4HRUAr0hU/SDfsSjBi7dLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851815; c=relaxed/simple;
	bh=BrqQWfU08EOCQ9oPzdhQ+EjNwFysPwfI6ho12lGetd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pM0tcUV4KPaMCcj1sA2ZIb0/PZ5db/gYe62ernxmYtqdwyZaxQcugY2P+BRYiq6XSpPtJJcT7r42/+AVyhtCPBn3QvBPrrWzP5y/948Z9bSGvHJMBSLWpwk6cPTnKxM2GUDWSj3ROUuEHTEesYMUT4FZUMTNejmEBebbmQQ0tiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VeVL3l1m; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d884e8341bso41901286d6.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733851813; x=1734456613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlM0jpfN/0EIPKkVdkd7aPBaB5Buy5JIg07+r6DSxgQ=;
        b=VeVL3l1m2Y4Ln3BuC44aKK1UnC94kae0maJTJc9B+2DmbFXmofoSwIdYOVfYJjUxkG
         AaRqZWm1nmO2yn1cwvn22W0iVPffAhXHDm4owluicXlGfH6aUQpKcqrl75KdVoC6gWkT
         e+FOzuPVcKki1+d4KIqcJWvUZev41kfIK5+Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851813; x=1734456613;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlM0jpfN/0EIPKkVdkd7aPBaB5Buy5JIg07+r6DSxgQ=;
        b=MEWMFH5WBYefYuYrMklphS7kTfHL70dzEb3h++YGiEKPnqm2pMN/gxD49pRHm5SGkC
         Ee+WhLJ0lhX6keY8cqGNAEPsCHEJbxi5f/P8SsN6ce/l9MhGce366GE5zM/JW0mtwZbj
         wFMG/AwgUVAbvTq6jP8TcOPsK/AQA8NDj64Azx8Uxa99fIz7+x3xXPuaNaZCCbQCw0u2
         QfKwxFcheB+kd9VDoXtaZ9D+W/vGUQnOsBRxlRWNNGI69AyV28kkmTdU7RAjlbTlqDmz
         pi8Irg04qSJVTvpV0O6K2nrOSKQZfMrso78E/uSDGQikwGRsTwY9gTtRI/YYlR5WUDll
         eu7g==
X-Forwarded-Encrypted: i=1; AJvYcCUsMCbENqwYjRiXbLDlEKr3qdG9dVprKWdrP4w+aXLHsGN+gpKjNW3+ORDMorPTu4AvuTHP8FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUvneO++tvcjXc82pxNRjmeEzvKEEl0TLuZVWOaYq9372u+Ab
	1BvJZRsQ4MDAiHudUSZ8m/R9pWV3s6JkA1Xfn4yagt8SUzS+qY4qHhnl7CNe2w==
X-Gm-Gg: ASbGnctQgmr46rYUtZqKLe3J20a7FWPQTL9seFGeCWAJO9aGn0FkEKLQY9XvsbBfD4U
	RIqL0wUuPQfKC9C7RfDUpcW3a8UMDdDff8mj6Lm6t3nV/ihRHYFVuG5SpqspOU7k5ep0OIF+LSL
	SBKm7SpYHXX5wO9c+wPLhH1qLaf99VCg5Ca3iCP0UsgRR0nAQEX7bJ84+AVhPWby/tn3FUY4rYw
	vQhEzakLJiuO+3Tkdg9xHEotFZgrJrWDGXKCMMVCe1S+WA6F/38siuEhmOvYEx/ON9GY1Phf7QN
	DGumydR2GGhv36/PPg==
X-Google-Smtp-Source: AGHT+IG1rCPaESNmGeL/pCfwE2PjnYtyp8mw3vbAdlrC5Z0UBjbzp0yHi4eT1rDWVtRv0ChBsv/7Ag==
X-Received: by 2002:ad4:5ced:0:b0:6d8:d79c:1cb2 with SMTP id 6a1803df08f44-6d8e712254amr258600446d6.21.1733851813313;
        Tue, 10 Dec 2024 09:30:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90299bccesm33827546d6.60.2024.12.10.09.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:30:10 -0800 (PST)
Message-ID: <bc03a1e5-b67c-42da-9856-7c77d6858138@broadcom.com>
Date: Tue, 10 Dec 2024 09:30:00 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] net: dsa: b53/bcm_sf2: implement
 .support_eee() method
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
 <E1tL14E-006cZU-Nc@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tL14E-006cZU-Nc@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 06:18, Russell King (Oracle) wrote:
> Implement the .support_eee() method to indicate that EEE is not
> supported by two switch variants, rather than making these checks in
> the .set_mac_eee() and .get_mac_eee() methods.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

