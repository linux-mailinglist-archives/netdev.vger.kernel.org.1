Return-Path: <netdev+bounces-194642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD02ACBAD2
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0067A5B3C
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C255226D19;
	Mon,  2 Jun 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fDtIcoHa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32132253AE
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887799; cv=none; b=i5AqKQC59NvQPtCxcu5m8791NFKpMowd1LawXy+dzhyblo/d9bMs2SCxHh7o1UKG8vNI0HUqw67XMujGDEjWO1cYXPnLtmVUETT/bPeh8QNhNJqT20YJMBx5kn9fTWXRrzp8XWHOl1bBmj6SfsQrykusoqJVur1yA6tGBN6UUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887799; c=relaxed/simple;
	bh=483Kz1Pe5d06U35us0ZD+VD/Ax1H+YADbQbFYxMcVYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dw+HWwaTPYV5+PvPT1cpmb4vwUzN6De5aivpi1NEaMRULX0TjqvIbzw4/JudwuD1WAFK0AKalFZ0DG+qWFkcxPlWozQTjl5p5uxRaQdefU5gdP8ik7jmoEGbfg8gbvDJP/Vg2EjEGYJsywD3Wo/tEy/lYpfzBaR/OGdL3CDJnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fDtIcoHa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-745fe311741so5277391b3a.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748887797; x=1749492597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U832ppy3h3HBolNEEPnJkCyJYq0liaMhoPALy+NkAlA=;
        b=fDtIcoHacdIfRCwEI7rgbCwMs6k2+g4H7wrFgvlIxODBYQ2f/lbgOA6vruSXeFehqC
         mz0lrbZ85WGyOoxEoiYkkQqs4tNKTxhVErg+kBvN8FFdib9/1DCVqdL2gsfXhtW6cGlv
         FhBKN/71KY+3z9uCRYs7fp/eDoE22H+aQtYx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887797; x=1749492597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U832ppy3h3HBolNEEPnJkCyJYq0liaMhoPALy+NkAlA=;
        b=tT3Ah6AdjlllF5TTx3HUInbrW4YVsE9AHZPHmIpxQgenHQGE350+I3tIDsQ9aQht6m
         MkTT0MBcyrGYyp7/NOlloAAOZCkRuNGL8c2GW/vAcqCc75ChIhyeTxszWIm6I/3Tm6Q1
         K0W1QSmsnQjns6mn2DlABWFuwQ1jRCs6j1lm1YNwkNkD5Fmx6pRb2xUi3HtqQ9np8IOn
         N+VGI189Sk1F7edXJrDlx8dRdOf+nAC+BBLsDn9nezXxa5p8Hg1Z0rnBqFNeSjUrIrr4
         t6TOUtl1hALcmiFK8LteWthPrslWfVSQNbEgem3YVQowkSaoCzR2oNkaKP8dMHUuL71k
         MtNg==
X-Forwarded-Encrypted: i=1; AJvYcCVtfVSDhP/YbNB5i0Ljq7yaRo7MzQ9O1ixeBIfOw2XbB4BLj7dnUI+/+A/NzD44nRH/yg9lpNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkZNqgj/XZgpT7auQ/+VA4ajjixapY0nKBpOSiq1eLXrDCAy8
	IitefgJjq9vvTsAL6DFKCECaE01sAXN4ze5yQQjbLdDg7i5gS8PffhEylFd2CRG/QQ==
X-Gm-Gg: ASbGncutXcDjPjl0g5rYbaw+HVPgFW7AsUJnacPAXsaspSbgCaeWLDH2PVgsdh3aglP
	Bwl4/O+EZSv6DvrBlmhisSNWBU/nDFQbLXCLq2B6uxEBlRrUF+b/NJeJ/NSWQfxJ/19+Rr4RYGR
	46abTFbeAdz5czvYW1KzYcaPGi4FKFRY57hhwPu5S1l8a6E5UZz29UHvyPBreOAj4WgvmX2v1Id
	rOB7ryRwYa+6B/3lANaCx/7537Sr/JAmbomECtwZv/wfyhSODeVwj0NahIdeuhf/Td+fd1NTJft
	vvGEBrKsy82no85J00AOxKPruOAGnFJCJd7htD3ks9y6b+fWYOEaY+jbI+AvA71eLbmrhcAYaOc
	MrFUe0GIxCnqyQcg=
X-Google-Smtp-Source: AGHT+IGyu2CEZkt766SCiV2UT6kK9jHDxSDLK/ogCd9oHQRldtmPTLR+ibuJPxzdUvfTd5HmebL2SQ==
X-Received: by 2002:a05:6a00:99c:b0:73c:c11:b42e with SMTP id d2e1a72fcca58-747bda093bfmr18501772b3a.20.1748887797058;
        Mon, 02 Jun 2025 11:09:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affb01bbsm7896831b3a.118.2025.06.02.11.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:09:56 -0700 (PDT)
Message-ID: <a8332eba-70c3-482a-a644-c86c13792f8b@broadcom.com>
Date: Mon, 2 Jun 2025 11:09:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/10] net: dsa: b53: fix unicast/multicast flooding
 on BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-9-noltari@gmail.com>
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
In-Reply-To: <20250531101308.155757-9-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/25 03:13, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLOOD_MASK
> registers.
> This has to be handled differently with other pages and registers.
> 
> Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port flags")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---

[snip]

> +/*************************************************************************
> + * IEEE 802.1X Registers
> + *************************************************************************/
> +
> +/* Multicast DLF Drop Control register (16 bit) */
> +#define B53_IEEE_MCAST_DLF		0x94
> +#define B53_IEEE_MCAST_DROP_EN		BIT(11)
> +
> +/* Unicast DLF Drop Control register (16 bit) */
> +#define B53_IEEE_UCAST_DLF		0x96
> +#define B53_IEEE_UCAST_DROP_EN		BIT(11)

Are you positive the 5325 implements all of those registers? They are 
not documented in my databook.
-- 
Florian

