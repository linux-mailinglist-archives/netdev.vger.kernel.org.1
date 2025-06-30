Return-Path: <netdev+bounces-202602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C93FAEE558
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A29DB17EEB8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EC1292B5A;
	Mon, 30 Jun 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eo+foPCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E0292B54
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303255; cv=none; b=CTUtUHDFt+OXmYixEg8dPPFoQ2Nme1mh5N9us3uoNnvAPNqEyEWAcJxsWG91QszkN9FHj53yiUamEWRnlhq/ttSNQh7Q4u79poWfS/B4FUhZM65RJTmvDRTQMI01og0C7bHsChu6ar4GpHOZCBWhV/UtmDqzF+f8vaG6FTK5+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303255; c=relaxed/simple;
	bh=EQzHi69b2lLh0u+AI0JI2+wnlxj880khaj9fC3dZq5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiKQpXzdX3AW3gF3cRmvxRaIoP0cQUmJDsBBkvHj1ejmuwYhS4GPtZYfH/SmWkwx6s3PAW9aED3xOKoDOCHrGkIFIXxHNyK8BS2seenD5iSM7iOzeTrVLP5R+iAxvD3lvU+hWveKElAVGg2TyttSddoSMsIYwZ7RCXlApBgT4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eo+foPCy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23508d30142so29434185ad.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751303253; x=1751908053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wAcmLnC+SlYmzdJniGYMoDtk6+CNb2vXkfTlA9nOHX4=;
        b=eo+foPCyzX1HpEiK6imPFAFypAzTtVLG5PXOt0dSdb+y6Kq/AKm9E+w9OESE1fdrgP
         wDY6yOdm3+cvcOY/G3k8xReyKLWM/Z4GYSqlCdU+TEM3Xf4li4e7ni5rhLYQsBpZLSRv
         HZ1HtXYwJLVvIIuzVcZjGQoRg4gXKCTjSxt7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303253; x=1751908053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAcmLnC+SlYmzdJniGYMoDtk6+CNb2vXkfTlA9nOHX4=;
        b=pdjeB8pfNH7lyFH6KcsdkZVehhrfB4AMz4gYh+ivuaneQTx8YmQ7gMY8RXtGg0TXPD
         0wz+znnsTKVXrRAbQhy/RW0cfDGsVnW1XGT7yjZhzT512M+Ebeh8OhEsEyQ/C9nGpw08
         GHR/XScZ9XUnep9Zcq5/XIgwJRLkiQsem0FjnRTCfEkyJ3/SN2Un87GrRiS/DmgB3w5K
         5S7ep6QZiJD2nsR/T09VIsxXjfQV5yFVauCX0IY7+jcTtLMEjgpXxev0xaYARAbVNMeM
         K+tetGu0jmEDA4DKG0FLsZL9mwJcIvc5R8j+ERUJsO2IwTDhxhvl+8dUBWusI8Qn6TOC
         2AKw==
X-Gm-Message-State: AOJu0YxqKMvqrcfqZFee6XKle0XEHM4A8Dle0gqYP9K2fcx6LprAotj4
	x4trMYYfIbXeMqyxfvt6JHU02b/5cIc6+NrPzoOaVky+vw219j6TQmnpokwIG9+JzQ==
X-Gm-Gg: ASbGnctrg+imnSCfy4lKEPpKyWUq8Vz2Ch0KoOM5WU8cetNHRAChQ2zuPCJyOEsmmh4
	9Xr0oB1jrTbhanw/OVltDtydSaTWxBe3xMUeKqpOgvsibQCfG8BO6V65U0szIWMRl8nVb1+5Nxv
	EQZMligt7CIvDsrAR1r/BvQY4S86O+Upxcu5Fp1s770YGlOq6mU4NgfQP7wfT7JeoW1x+LfqSEr
	E/ZLi1XAvZtczHF+rNTTLpgFiJSXwDW5N1nK5RjU67LEX+CAO6LqRd8umsDZwLHZMXVXzJSH9Ln
	SfTnVzBLdWQYbWX5lDD8G1sSSkUe+5tapgggUSwU9JHkRnG5vEP4DWEq39MlkjFdB910JNSivxq
	+eg3FzVrt7wBmAl7id+B1vBAn7g==
X-Google-Smtp-Source: AGHT+IEHQIvFV33hIpotqGHngoBjhpfcFYLCx7TeQ6MRrDfAH7zV0wB6VIjgP1iEFc9BJNFGUEMBzg==
X-Received: by 2002:a17:903:3a88:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23ac4606776mr167927585ad.30.1751303252999;
        Mon, 30 Jun 2025 10:07:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e3c27sm90068935ad.51.2025.06.30.10.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 10:07:32 -0700 (PDT)
Message-ID: <5c011ec0-67e1-4c9b-8ea6-e098b16f0f45@broadcom.com>
Date: Mon, 30 Jun 2025 10:07:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 4/4] net: phy: bcm54811: Fix the PHY initialization
To: =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?= <kamilh@axis.com>,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, f.fainelli@gmail.com, robh@kernel.org,
 andrew+netdev@lunn.ch
References: <20250630135837.1173063-1-kamilh@axis.com>
 <20250630135837.1173063-5-kamilh@axis.com>
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
In-Reply-To: <20250630135837.1173063-5-kamilh@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/25 06:58, Kamil Horák - 2N wrote:
> Reset the bit 12 in PHY's LRE Control register upon initialization.
> According to the datasheet, this bit must be written to zero after
> every device reset.
> 
> Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
> ---

[snip]

> diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
> index 15c35655f482..115a964f3006 100644
> --- a/include/linux/brcmphy.h
> +++ b/include/linux/brcmphy.h
> @@ -137,6 +137,7 @@
>   
>   #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
>   #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
> +#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060
>   #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN	0x0080
>   #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN	0x0100
>   #define MII_BCM54XX_AUXCTL_MISC_FORCE_AMDIX		0x0200

This register is not used in this patch or previous ones, please drop 
it, with that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

