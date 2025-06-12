Return-Path: <netdev+bounces-197207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DD5AD7C5E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255183B5A25
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F0B2D6616;
	Thu, 12 Jun 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VDo6Re8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03E2BE7C6
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760210; cv=none; b=YW1z6/yQyUmEIZ+ImQ1YC7Osnp+BTT+c2Al9PcWg0U1Azz3J0ygyixczEqlQR05V5Ps/IUheTHHONNlwI/Efu1NpKsYNWwRvfRQTzvaqDv+choBoaA2MxZpZJ76ixWqlWbjxLGXwlFHP/lDIKyotrxpQ6/Oi03XQGGJoU+C5sa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760210; c=relaxed/simple;
	bh=mo/h3BR3Cs60aBjeS9k9Gmp1IK/Sysb9C4bG4crXeFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eEui/HCuVO9uBvPnTT8A2UcvGTM82shio8Vy3QA1HmzHz8khr+2nEsJ5PDmZWjVLcLRjmkUbrs6Lda+s8Wj0HksV9TS/cTaEDzk+TwpLEi6HNgk8R9pFcIhfzvOwfxOfEPQhbdK+9MauXu4qOZ9Lz3QW6aWU/KwqwB0SwjGY6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VDo6Re8x; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313a001d781so1320457a91.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749760208; x=1750365008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fbkv418C828lnGbq4qpla832myvG5KCEe9Vz4qFp2ko=;
        b=VDo6Re8xLWyJ3RYE4/S8wngHbcUEEUNIfffHd2SsllxeWoFXQqNfVGz8qF3D+MDj8H
         tLMi6maii/8NifODX3IojESJOICp2xey0znCcDU4btfdMzrHAnEExO3WSfZmsfV9Dv5O
         2tByckebB3YS31dbIuEwkuQ05fSP69OT1RuJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760208; x=1750365008;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbkv418C828lnGbq4qpla832myvG5KCEe9Vz4qFp2ko=;
        b=QzBrhbFGLEgZEFQc5K5huZMyW32js+jLdNek623MsLEkK797oT/VyF4Dg71noHXGT9
         6uR3dfE26VlW6J9mbNeA9RnZRIKFKk6v/BKCNDYYs/8D2ZfZFr9iDvbP6OOeydRBoa1k
         dEQUOVIKPdBAr4h8A81rAoaejzbIFNXNWrAU4gZNcGaohmXNt6569JSJfWiu0bnC36Kf
         sBcZ++Fn8HNiBh7FUmApJ8QD2eVkJYoqodYc2OEz65R5B1bCrQhHor77KqPgWV/Ijx24
         h7ryOrtUK8P1ohjPRVf3I1MifAe/9B7iuRht9WwtzZOM/sblejZm8ZfyIjENvZCNL3jv
         AGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6YPq4xKawlTr7Gno+Y2x/PYKlobHleGtBw75KU19ocHlnsA95KKIf2eYD7+NLwpLvxMfGU7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXoZ8h9WH0rbp0x3uF7sGdDuTYHE4wPdxddToqBVgXc07YLup
	EYKmRBOvdDv/YqaZBvoNm8eblD64sMtFX6irlWxFZkXTeQhm8wUmI8zWWbsoNSKn6g==
X-Gm-Gg: ASbGnct/+82V8b+bI2+btyzWw/l1FzZktESltspSoqYH5W4s8yFVE1gkceAOlOkIzzl
	u1wSbCJ7hvQ8cKM2IhOHtUgqeQUOpYwxAvXjKKTMdbusalAIWk6OLw7xIuyXzDbame8bKoisEpr
	tqUm0H6suak2r6D5roKG/SGRm93yl1QuMgK5m/9OBjllBTBBv4+TmR8dns4EyP8/0ltYh9O8k0c
	LTT/0bSakvNFj0s8dgDoPW0Qi9SH0buQSTpqxD7uaq5eKNGFtBVMenqsXSp4Te1ZwZOWDWcBAyN
	GH5HJDjMZZ1W3aTx4iNDbiqcrlIDpE7sjQ5KmJKMTzebnv8gcFd96CJYu5H3tty8/yxmAFyMQP2
	OPgb/I4MQ2C8ogY8zV/VeXTjUKNBbaLTudyTC
X-Google-Smtp-Source: AGHT+IFqK1zlJ8PVZeWc6MfypTmTCZgE2MeQkQ0O9vxNiDBSq26pu9yyGqMmEVJDCPnCaUDyysR5kA==
X-Received: by 2002:a17:90a:d606:b0:313:27b2:f729 with SMTP id 98e67ed59e1d1-313d9edd273mr634460a91.23.1749760208364;
        Thu, 12 Jun 2025 13:30:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c4e3b9sm2150639a91.29.2025.06.12.13.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:30:07 -0700 (PDT)
Message-ID: <d34c9530-2eb1-4c2a-8fe2-9fd7cfb02c42@broadcom.com>
Date: Thu, 12 Jun 2025 13:30:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 09/14] net: dsa: b53: prevent DIS_LEARNING
 access on BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250612083747.26531-1-noltari@gmail.com>
 <20250612083747.26531-10-noltari@gmail.com>
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
In-Reply-To: <20250612083747.26531-10-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/12/25 01:37, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement DIS_LEARNING register so we should avoid reading
> or writing it.
> 
> Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

