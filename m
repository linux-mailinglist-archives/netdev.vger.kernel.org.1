Return-Path: <netdev+bounces-228962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F12BBD69CD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 00:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF024E4066
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A32DCF65;
	Mon, 13 Oct 2025 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eh/t8x0D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826911A9F9B
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394487; cv=none; b=Hv9UwWu/wR8fIIX+90rrBxSqxbZicFPNcuSHaya6QBBJvQYMtSHnxBj8/5uFH+hzfgX0zSCaf8b215S7i1s9FCKuKc5IEvEVmN/K2Kiln7lK6gnDzo1AAesjI/Sd2KwGFkfQTATwxXa3glvKq7LBKf21+4C4DKK3Q/mZorLqAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394487; c=relaxed/simple;
	bh=UaalCMBxFl8+25LwmSZVh2mcjyKmi61E6LztFgjdKnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU5PU5deOAfKpTt+LCncBMWHVPipmA6v7pT3IVtiK+xtRhzDeakV1KLX42mqYbOcH1jt5+vZaG0rBDRMMFKiar6l36zC/FhkmrBqbxYS3eWXf/RFKYil1oGyrCDYUQYFM6XwfHrXeJOfp9KXVpRGMyQ+EXPcEis2St5cF51TN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Eh/t8x0D; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-7f7835f4478so45176096d6.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394484; x=1760999284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsKnu9jmmnuAKtnSp4XlV2Npvnjjxs4eD78fzaxO7Uo=;
        b=FJcF1x+l4n8Agnnl++ScvSFGjQ9vJhmRCxJFUcDl3h8Uw9671LhLKnc6X45vcJ88lD
         fgQDgpersKaQVajyHPmLRmpPowNl4UQVuLHjt44hu/vfoIMeaVcyGZFAsBNR9osI0hL1
         c4v7WHyiXnUr87oxC0ig/MR55cVMom0oxnzvCdZEk/VbfrnF6hR+BcPGtjP+O4aiq0lV
         KrDNEcbr0wIgKUxMh92nR14/mMwXbZ5DsUvPsKSfurqMpw5/0NlzSz+EDfLE8tEVxcaX
         8V/wgNK6hPyaZrF+QF+zDDizqbPXJ803sX8Xr1oPj7kpo/6M+79f4H0oYBctZaEfwHVQ
         tysA==
X-Gm-Message-State: AOJu0Yx8KGP/4hFzUMeFTrAkdKZf2vnhTZ2tFoHcH8w9hzqJESuONByX
	2UPmnPx9Hn1bY1/MfDmhgwEG7eB9jfkjufpSvyDM6T/KHTyIGXs4NgvJ/h4P6ysDUOi5WJu2UE3
	O+Tr9raUYEZv3bhd9phyxnnfxwNAp2/qr59AE/6FlqqQ6ebaVOvMBj2ROEphXOpNseDmCpiB9gZ
	aVed+nBeb8Ix7oFgfne/BSaOUui5k1qUhE1IFJMZzK5/7wpQoTZA1YRzLK6YOZ8g9tvx5sh8mC2
	PCLonTzqvZ29ao1
X-Gm-Gg: ASbGncvZbGIOBXtKgCN2r9xmhUAc95T+0oCsISYuSXXwKw7e78QK49jx73PIsZwyzyi
	/NgAp01RFeeXxgSqFue0O2wxHOFOTmiTOJRHC2c41kj2pqO4H/eomeIhTta5AYWbW/Rox//SXQA
	gyOjUQ4zYGQJ3mdSpjalYjHGEmGrendbVx9PT9f3nW40eNf6tmQL6zRuedB9CQj3huuUs3XpAM7
	h0BsqWRYXvEftx7KkljstUJQfBhLJ9UAFrl6HjROoXOJJeYoyXfu1Ff0nCVLox2U+8mtYnJR0Xp
	cvwVjvHr1DyDr2OOgbuHmb+v9amJb53rINzvln8xWWe/l9fPfTFAsPDWp9d6XqHkklr6U3LGSqk
	PagRoxaQciAlzMBVS5SM0Q3sFHW5oPbuL8fajzZO+8CyNacun2dnvN865QBDnjehmwrV4fT3/wk
	R8461418o=
X-Google-Smtp-Source: AGHT+IGdSTDnhhxHiCiGZEialXuGot0OnW/2hZBFkkdQdYM+kMlfUGZ0JlG/6pnZEB3gfsyFRuFuPJbuJkv9
X-Received: by 2002:a05:6214:dc1:b0:78d:8414:e4c1 with SMTP id 6a1803df08f44-87b2ef43ddamr304224656d6.48.1760394484327;
        Mon, 13 Oct 2025 15:28:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-87bc34652cdsm9604976d6.14.2025.10.13.15.28.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:28:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8574e8993cbso1023753985a.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760394483; x=1760999283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YsKnu9jmmnuAKtnSp4XlV2Npvnjjxs4eD78fzaxO7Uo=;
        b=Eh/t8x0D+sIDOcJey2HZzDQGtqiN34dRQZGuHZxoQar+HswwV4X2I/Y3zvNSujlVzR
         8mrZoteCG7VW0AzsUm6BvltI1Bpd/flkHKKev8K8KnzfUvIBN+qalgk3uBukZpi/dh/6
         Yili7cMRelLyAo5rnN6c7+Q6VPCaum2e+5aaQ=
X-Received: by 2002:a05:620a:444f:b0:83b:9629:8c69 with SMTP id af79cd13be357-88356becd81mr2865162185a.62.1760394483372;
        Mon, 13 Oct 2025 15:28:03 -0700 (PDT)
X-Received: by 2002:a05:620a:444f:b0:83b:9629:8c69 with SMTP id af79cd13be357-88356becd81mr2865160085a.62.1760394483002;
        Mon, 13 Oct 2025 15:28:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ae48fsm1073805385a.24.2025.10.13.15.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:28:01 -0700 (PDT)
Message-ID: <b37aac96-d42c-488f-860a-d91162cface4@broadcom.com>
Date: Mon, 13 Oct 2025 15:27:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: phy: bcm54811: Fix GMII/MII/MII-Lite
 selection
To: =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?= <kamilh@axis.com>,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20251009130656.1308237-1-kamilh@axis.com>
 <20251009130656.1308237-2-kamilh@axis.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <20251009130656.1308237-2-kamilh@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/9/25 06:06, Kamil Horák - 2N wrote:
> The Broadcom bcm54811 is hardware-strapped to select among RGMII and
> GMII/MII/MII-Lite modes. However, the corresponding bit, RGMII Enable
> in Miscellaneous Control Register must be also set to select desired
> RGMII or MII(-lite)/GMII mode.
> 
> Fixes: 3117a11fff5af9e7 ("net: phy: bcm54811: PHY initialization")
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

