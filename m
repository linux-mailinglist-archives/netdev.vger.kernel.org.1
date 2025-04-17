Return-Path: <netdev+bounces-183875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39075A9267E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36C21887541
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC9B255E23;
	Thu, 17 Apr 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YN5gTegz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D3223710
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913632; cv=none; b=ZzRbOaxf7uYFHwX/HG+7ou8UWX2GUp9eow0Xt17epmifSWs3iPlU3lcnBsJLkCtH4Ap1sGQT7nEGFuOm+9Cv6OenWo8HluG1NeCH+OOxiOsix/m9OOz/KoEhcPUPlLAhMaf5lEzuzBoC6Ns46MAYeXZ4Tcc1PNqXevL2znAIpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913632; c=relaxed/simple;
	bh=mpX+CmBVaCVWcFZGuCrXiu41jZW4H6Ayv+1Rt/1mmGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtNT3n3OOO26gJ8FuzV4BcvW00FHoq99vS8JD0YIPZyrMdiyIVpTwBzhiLQA3401tTxHXsjqU6H32viBTG7/yrLuo0C2N07e0VB0Mgd4D4pnjHdC70RmknVcfeBH4E4It0ZbxebthUVMiGHImSLzgrOi/PJzMc5ewontryfupAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YN5gTegz; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6044db4b55cso593577eaf.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744913628; x=1745518428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zC8ZJE9fPc4qyAJqoLyq653txnvRnlRjFpjJ7hjJ1Vg=;
        b=YN5gTegzJFexXkxeC61p2ZanfYjMgNKymx0Hj9+dyJ4R8FG4NFgB17VXQGN8ijLckX
         3yySnglMu+/nSVYmr14ABbrdGzZn1mvP7ciPEoqSPQX0bieGK4hgh3jS1TAzAQU5SVTB
         ABMuBUZjKTgqY4H6217uJinUM2qwgkz3Puz88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744913628; x=1745518428;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC8ZJE9fPc4qyAJqoLyq653txnvRnlRjFpjJ7hjJ1Vg=;
        b=eRJZh12sb11+vW/s57EbfeKIBF9LyYAxpJ1aVW0BQyrM3qTpJ4/fWycbW8yV+iWGxM
         1Iqn5eS4TCuQP+e7HQBXbKMQwg+Sk8Grb2SILXm79N6606kYEboeySkLJ+fST5Kapzsj
         odPvRzIDilys+jasjToamR8qXstu4Nk5xCrF4nF2RsJ4bxoAZsn8YHQvkNXZPg5fcwfz
         cgAUOsJJ349pnB0gAZQPCQz53Fm21J0gB4Nx/8YgdzuILoxrKVOh5tVgUuwRGwP5J428
         LhUhCHPltcNZg9smk7AybX/M+hkUBfKJkb9IaJagzvsr2sg/B8Si0LNr96szbc8HIOQ5
         dpdg==
X-Forwarded-Encrypted: i=1; AJvYcCUwwDqlX44escryaQSc+C3Za8H2dHFL3Zfs7A0rbyuPT5Rxe/JYykAk0G/qpWWxj0N+1tHTu7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpl5LBzlf/j4G/cPBdrAGV1BVhZzq4AB4ttqMfv+jubIwZKbVC
	6ECf6oafGdbWz1IQ6DunjedZ5NHqzT2ivtXknDMjWvb6RjGS0spomDdubTktUw==
X-Gm-Gg: ASbGncvAbDqAYnyZY4lo49Uph4Pwg4IDyX52oRsCmE9CUEVDCjGlkhYLhzyFzVqwSIf
	/JBCn7QUKZV65jOQkVDgKt6mqJpb6h6RulG75w/u3t5OwE7vL4YlQagaM0/PfRH6+XfuDsV3Hxr
	HT+34X94fOmNLfcITtJRa+MwHADp8h3M1u7TZoQ3KHrNMLrHh0OFou1PPPLCLBlLtBbF2yyHi5L
	4FZXuueDqZvIeVJpsO0R8NJi8k0JdC2PLwQHV3zww0I0ALxB0TanaHtR7v+MAByAHz7g+JLzfHt
	irxIzJ8wLRcjb642vguBWGzpE2Vk5fZwLT5MAkc5C3Dz9hITC1tfw+tf1dOlPkxL4srf8Fz+ki7
	E1Njn
X-Google-Smtp-Source: AGHT+IHAUz1TIcKTp0qZyVxkurzKipSvBgixZXnaA6wvbeHjZDdrv/X/UeMAeehjDTtmr9wcvRUS2w==
X-Received: by 2002:a05:6820:1b8d:b0:602:15e6:4559 with SMTP id 006d021491bc7-6060055bb21mr34942eaf.6.1744913628457;
        Thu, 17 Apr 2025 11:13:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5f7a1dsm51220eaf.20.2025.04.17.11.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 11:13:46 -0700 (PDT)
Message-ID: <84187c48-43bf-41a9-9151-05de335a172a@broadcom.com>
Date: Thu, 17 Apr 2025 11:13:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: bcmasp: Add support for asp-v3.0
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
 <20250416224815.2863862-5-justin.chen@broadcom.com>
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
In-Reply-To: <20250416224815.2863862-5-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/25 15:48, Justin Chen wrote:
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
> ---

[snip]

>   MODULE_DEVICE_TABLE(of, bcmasp_mdio_of_match);
> @@ -1285,6 +1310,17 @@ static int bcmasp_probe(struct platform_device *pdev)
>   	 * how many interfaces come up.
>   	 */
>   	bcmasp_core_init(priv);
> +
> +	priv->mda_filters = devm_kzalloc(dev, sizeof(*priv->mda_filters)
> +					 * priv->num_mda_filters, GFP_KERNEL);

Nit: those are candidates for devm_kcalloc().

> +	if (!priv->mda_filters)
> +		return -ENOMEM;
> +
> +	priv->net_filters = devm_kzalloc(dev, sizeof(*priv->net_filters)
> +					 * priv->num_net_filters, GFP_KERNEL);

Likewise.

-- 
Florian

