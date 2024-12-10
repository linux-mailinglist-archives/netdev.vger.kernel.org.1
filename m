Return-Path: <netdev+bounces-150773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBC9EB845
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A9228553F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A01AA7A3;
	Tue, 10 Dec 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CRkpwbX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D571A0B13
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851823; cv=none; b=mE/weaDp5dVHH0muTKKzMDRTwAxIOkl8b5tWuCmd/2MZR4CQ112mnIfIkJlFEmRoEiFFJNOz8njUGuhlT9s8i3BDz6hK+05+mG6iu21O1nTaV1cDsOAkmjM9u9nLnPLQjauHSYB8HTq5fTAZHbJnY1BTaAuh10zFcQzAU6maoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851823; c=relaxed/simple;
	bh=hXGF/ZJ6xHQZlI1RktNb/b5Yq1vJZPQmdK1XXtpzN1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIbJVfxZ3M20VFh0FkVfV9vjuVgl4UqNuyxHq8f211OVoKLUiqqTbgh3/UtXFoZXQaU3xcWbArCtrySL20SwWQzM32uvgsPBxWW11nw4FMLUc7di9hkqybGP6jK6gqKEFm2IF5Cxa+vg7KX7WrG504zJTzuVLNzU0WBI25LOjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CRkpwbX6; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8f916b40bso44888736d6.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733851821; x=1734456621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EJuaBgZKrdv+RWQeMRVkYJY5tTLwVPt/ydvjKnt3MWk=;
        b=CRkpwbX6oLXmSnkj29R4N4LhSo6CO8L+eaoPclpAztLa0rXOfD3dCpOCA0iNEQ6N/X
         NnQW2rL6SoUWBbjL7XW8IIH7k0BgjqL0p99bzEdXYpQ1c7IspXmeBOHkgGOM3MMQbWda
         zexBBSVLZ4Q+wDrn21Ly1lqx86ULyoWx5SO80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851821; x=1734456621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJuaBgZKrdv+RWQeMRVkYJY5tTLwVPt/ydvjKnt3MWk=;
        b=d3dSp8NS91xS0ana/1zI+8YENE0DUJHahsTTcOu92+7vKYKBuD4d7keMeIT1ZzdtZ3
         DQUmG9gT2lY+KGwKB/DwMpaQV20bU7zwRNQRGa5C3olutGFQXRD87rmDwpeEbNTCaMco
         aEOnu4LlFKt0pm3lc3PA4589rIq0lNTEd5ixpQh+Mg1eZJW27eti4lYSsLPeLfn1BbTd
         rIzOmHmrfwJyhqAfEpqQhj/TV2043RsTKslwrkN9y281lInLz7hPtSAcKYNZ2ThU3EOu
         YPlTJLdP4hyyvSOVfuRy9kUzgotzLljLREYoNnf2KXj6/n1Ybnl63qdYuaz98+vHBRQn
         b2XA==
X-Forwarded-Encrypted: i=1; AJvYcCXURBahLPtPNhY8g1DW7QC8yhlB5wR3U0rUX/ib8fki2E6M5fKSftKjtrjgudHbLKsB/XqSOZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++XMh6+wZtlI7/I566FG9o7dIwLYbisoLS0xalcm5ivHHiAZL
	KCc+CTouQffMN/IERL/IJ/lOO+NkgTmqIddVJhKuznLPHesYPycWN5OlSYBCJw==
X-Gm-Gg: ASbGncuWyI+AHbj7xnqQKDcY88v/hGGD9fJ6hjIGhNqPF5sbCqjvoqFe86i+X07i/vP
	g5AihyWgXbehLmr7s9VshlAZoCwVZHbbJLCxbkVbbHfnQ5RGULWaBtB07GWTBMl1xC8t5krvrfq
	8e81e40LDg3z0REikdwauZGrAr7EebaDruaidijRaM236ZNjvkMQh5PmDD5ZNYxwkpC9cjdcXCW
	8HoL4K82lRdQLi8wnCjhjCyj+zStLVpA9ynXnIofzfpk1OQ+xMORWDDvvFLpM5KF7Qu3Zy//n1R
	v0PXC8IBaw25vv8eSw==
X-Google-Smtp-Source: AGHT+IGSlwLnkhDmztl6nVFIaXK4bCm/Nqbb2pVJVrqEqNuu1yaCRevEfXGCfMJUDd+wIPCUwOQAZQ==
X-Received: by 2002:a05:6214:2a4f:b0:6d8:981d:529 with SMTP id 6a1803df08f44-6d91e43ea4fmr82139946d6.48.1733851821154;
        Tue, 10 Dec 2024 09:30:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d90299bccesm33827546d6.60.2024.12.10.09.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:30:19 -0800 (PST)
Message-ID: <ad11506a-3b11-4584-8efb-8075158527b2@broadcom.com>
Date: Tue, 10 Dec 2024 09:30:11 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/9] net: dsa: mt753x: implement .support_eee()
 method
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
 <E1tL14J-006cZa-Rh@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tL14J-006cZa-Rh@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 06:18, Russell King (Oracle) wrote:
> Implement the .support_eee() method by using the generic helper as all
> user ports support EEE.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

