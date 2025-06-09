Return-Path: <netdev+bounces-195866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A656AD2875
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A7C3AF194
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181311E8338;
	Mon,  9 Jun 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eSig81+4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D8818BBB9
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503454; cv=none; b=Y7pGhIM/Q+86MggxoeqtSi2K60NjpKSFOfofHKIwsXVVd0DlJrf2pDhwWu2DgUl9/Lq37uc1/whNbav79hA70kM4MOHaRVhK0ZcZMO5uS7n2FxiSzbIckSg1Q0lzzMiDhQYuoDuVOeWyVC8qtMnWuty1doyBdQujoTPV62P0Jtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503454; c=relaxed/simple;
	bh=8MiYf0fVBSt7v5QiOXBU5fbu+MriS4GJoZV0bHh3P6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VYqzI0opGiWDbsmCp0x9VpyDMG+MyNFN3uI2egLB42HaFqClSXki+3E39rEOBaI1qKnF05eABzPWHDErELOT0z63ISaaziZEUKYd8TujY1psVnbJ6r5y1DE/HdX4RueKQiO6JkcUrJ9GItiHAhXETIYtvB/4d0BCA/OpqZRGjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eSig81+4; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-234b9dfb842so42078565ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749503452; x=1750108252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1nYGaht6dS0vYZHBTmb2vsF8c9JNcaLIkHqaOyAMabk=;
        b=eSig81+4VQ09Ezs3NW1MLu13dwXIGUWKI9XGz7b/kT+I1z5FgDJMed/RvV4PVOkyrk
         RDewV4yJYKDLF3PCQ93RDJlNtKXUlRHA63HCCN+D/rzI+QEdGrrvrhOgfKViudfRzOYO
         4S9GXONoflH9x6yogkIj4Xwt+N0Lnpq/oXFhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749503452; x=1750108252;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nYGaht6dS0vYZHBTmb2vsF8c9JNcaLIkHqaOyAMabk=;
        b=AY0SOQXhp7l4coMBHy5Tu6hXG75JXME17A17+bYveElptsytfwHncjqnAlFEh/GuwG
         CyrfG9KVns1w3o81CEw/ihGKIjXswgfvU6m+RH5oXAE11Akv3WzTn/BxXXo+ndxEz6+x
         9ETqyyAucX217AWcY8WXlbxBXqDrmdeaBZdQ1Z37cLBDWCWmv/HqvWYFMREnMC3YpGBs
         bHnrmwO3SB/eiYZakBTT2cjD+9O6Jj0QFimmesPxOjZ08YS0/BCnRsTLLSv+tg+Icnyw
         F0nAjgOIqfG0UntvpqCXqehWTuXgayVo1T6Yn4gT7JESkQgRS8fhpMdyU0ayua3v/oi+
         lf4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTFLlfGVwJIZ+n4Q9ZITPWnR2cQoTMXZzj0klzyK3djiB2hXMEuhqZn26X7EejlXA4xZthw7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BQ9eYwSN4BX0cWN+k7mD6nwx9bY+eS38wMiH/nPiZrnebet6
	iuOeX2+600uCIXnOqxIHjAbLn1reiO2bfu99fKa6ncS7qgT5NDat661A6yLjuzJWmw==
X-Gm-Gg: ASbGncuR5WX4ySMeSooVsXBsDBIH/mg/zyGrxSuEEPsNKKGZDaWPksS/7itVN0YVczb
	wYGz83LTI81uO2VjGCXJCm1/7paEac/EGIPrquYjirtVK8SL4ZDVvGIcB7jsVCa6Sw3IAb1ERKl
	et7bDPSpWMecVkL5L5GY0ulAoFNPIlIda4SE03TGh+qRhUuS2QpTPpDUc3NQ315c0oHMZ36KqxR
	BqXUKsxlgINhhU1iBQspJakL6Y0gUkP0ZHXJrWg6a/AMhTIcRRFQxdzR5Kek2LBkkREZteseoXt
	hi8/X2qRzPV25VXqysA+KwyzZeosZTz/NJ8qqD8kl26/q8qJVcYaFnHnin7yiw8G2wU0FdedDxT
	lzoLjNBl3c0DMfw+Ducs3a63qog==
X-Google-Smtp-Source: AGHT+IGiCPsVdyGTyWI34ddBsOCk9hp0VOSRaw6ynb7kd7JPoAxHCSqsVA3yOsiny33fqqDH8b+icQ==
X-Received: by 2002:a17:902:db0b:b0:234:c5c1:9b63 with SMTP id d9443c01a7336-23601cfec14mr171282935ad.18.1749503452029;
        Mon, 09 Jun 2025 14:10:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034061f3sm59433135ad.179.2025.06.09.14.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 14:10:51 -0700 (PDT)
Message-ID: <44cec5e4-2eaa-498f-9852-401a4a97fab1@broadcom.com>
Date: Mon, 9 Jun 2025 14:10:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] net: bcmgenet: add support for GRO software
 interrupt coalescing
To: Zak Kemble <zakkemble@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250609210809.1006-1-zakkemble@gmail.com>
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
In-Reply-To: <20250609210809.1006-1-zakkemble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zak,

On 6/9/25 14:08, Zak Kemble wrote:
> Reposting as requested here https://lore.kernel.org/all/20250531224853.1339-1-zakkemble@gmail.com
> 
> Hey, these patches enable support for software IRQ coalescing and GRO
> aggregation and applies conservative defaults which can help improve
> system and network performance by reducing the number of hardware
> interrupts and improving GRO aggregation ratio.

Since I gave you Tested-by and Reviewed-by tags, you should have been 
amending your commits with such tags, also you should be specifying the 
tree you are targeting, in that case it is "net-next", so the patches 
should be:

[PATCH net-next 0/2]
   [PATCH net-next 1/2] ...
   [PATCH net-next 2/2] ...

etc.

Please wait 24hrs before reposting an updated version with the tags and 
proper prefixing, thanks!
-- 
Florian


