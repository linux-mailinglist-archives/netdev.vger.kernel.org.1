Return-Path: <netdev+bounces-144238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 420FB9C64C4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE511B80E2A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC30219E5F;
	Tue, 12 Nov 2024 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cykd86NL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA221A4C7
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447730; cv=none; b=dEuhVhU7SbDl+E85zMaVH4QP8bT4FfoFSAKOqZqgaa1yuh2UVQBRlfaQHVVk9CzVujV21TTWBAZe+VbFqEUdep9D2hjauIPzYyxqVV9uahe8gkPVzRrW8AWUgYNK2TkhLQVbGeDQRAZH3/FbbqJ7tp0l/XZp+T6n3X48DOXmyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447730; c=relaxed/simple;
	bh=gJchVZ0aipmPi6N3tyZJvlVK6yAXfrk0qcAZdAjQQAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jU3mIJ1bz7u0iKV9VKnrk/Obk3PU7Tx/Bdhg9car4yj8xbQCndk+BKwNpKIoIkDGXcPrV3b19A6uM/s6hRYExflTlE6mPD+RjReZDblXbLKptfz60UcYwjrmR2fiUotZneiJXgWHPm5uM22DxNnxX3zIeXs21RKevPp20L3lmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cykd86NL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-210e5369b7dso64275235ad.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 13:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731447728; x=1732052528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1JyuzlEmjIKs0OEzFDs2Ei5r4rj+a+WGwyUfTtd/WDY=;
        b=Cykd86NL5DGBIShkmvNri2OGGtyqC1gR4YBJD9qe2P7PJMqgi/1CqDsEEFNN3ZRMCs
         sWu5UN9ZEcKaphPufageAYkQZegs5fW+Jfoe2hoSvFz/SOcmZrJdN9zmNh2ATO9Ot2wN
         qnKJ0UM3bv/9xDfg8V9LOPVbcZW7f70jgLKuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731447728; x=1732052528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JyuzlEmjIKs0OEzFDs2Ei5r4rj+a+WGwyUfTtd/WDY=;
        b=iSHFAuvSy1Jvq7zssSJ6vaXm2ugLkgb++6eA/uXUce2TI0IavIKfj/4/qQM5pnsAs/
         A/59m+Q1Vcm1AyTAlmk63ttiCStSC2CEhUu05U3cfiQXh6UYEYSVOOWrzQ0tMdCN9lSt
         fCNPcQYR3xbExyfqh3414aw1n/EnuvuVXcUy3/nl2MAT0UEIyvMpG/B843eT27bU3Cgi
         CAUzB+Yazq2tdwu6C3Av7kfhBpdQyx/y57b75HrMlgSmdtu5osSQPp5r1hk3IasZa9aR
         wIgnTkUhsCe/Ax5luH+T7dPhXUm3BC8fmoMZg1ve47ymALOU5yFYOaZCBgxqfcglEE4V
         j90Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/yHXGUvRs93wIQ6L/dTXvgOB0sJMtQ27Y+2+tgT+4EU3lnSQgW8TJMJP78Gs0xmEN9NJuyXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64fe3QTKbeUNhe3g3zT+OoB1X8UkVSbJFIJnqLh0FDXlNpBZs
	mKKzO9u2yW4At0TKEAqYaDQwj9rSltEkSR245ql3TA/x51kLHP8b/HJrmx8nWA==
X-Google-Smtp-Source: AGHT+IFDh6oyLu1szZNtbuwF2rTREJskobicbVjVT9besKSihoc9sQcmwBwA22LNfYSTp8e423c8ow==
X-Received: by 2002:a17:90a:e7cb:b0:2e2:a8dd:9bb5 with SMTP id 98e67ed59e1d1-2e9b170d9f4mr23022270a91.12.1731447727580;
        Tue, 12 Nov 2024 13:42:07 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f4fe0bsm9897a91.53.2024.11.12.13.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 13:42:06 -0800 (PST)
Message-ID: <4b50e109-da52-4616-8f68-75174ffac8a5@broadcom.com>
Date: Tue, 12 Nov 2024 13:42:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] net: modernize IRQ resource acquisition
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, Byungho An <bh74.an@samsung.com>,
 Kevin Brace <kevinbrace@bracecomputerlab.com>,
 Francois Romieu <romieu@fr.zoreil.com>, Michal Simek <michal.simek@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Zhao Qiang <qiang.zhao@nxp.com>,
 "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 "open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>
References: <20241112211442.7205-1-rosenp@gmail.com>
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
In-Reply-To: <20241112211442.7205-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/24 13:14, Rosen Penev wrote:
> In probe, np == pdev->dev.of_node. It's easier to pass pdev directly.
> 
> Replace irq_of_parse_and_map() by platform_get_irq() to do so. Requires
> removing the error message as well as fixing the return type.
> 
> Replace of_address_to_resource() with platform_get_resource() for the
> same reason.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> (for CAN)
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

For bcm_sf2.c:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

-- 
Florian

