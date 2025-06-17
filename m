Return-Path: <netdev+bounces-198743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B81ADD67F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753D2406A2E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5565C2ECD23;
	Tue, 17 Jun 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C9OyXwPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F32EA171
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177101; cv=none; b=E2NKSRDtvbexbWvFbOQ1ZP4QU0yZ89L/dc+Q/Qk/lmvk7o4k3+xhOMLw6HXANT2/fjuZ3kcnlCnWtEEhm64+a8ofQDdbDfDiFClm7/po0f8gZiBGbMHBTNrPNXt3qiS3LUW4tKTZavgVN5OFt+wKniEnqQnKkzcb1ygCugctKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177101; c=relaxed/simple;
	bh=BDk9NerncGTKWnCMkEh4NcxNRABqig9U0sMgwlclsFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EmTsKgKQKrxbspSGcq8XgGoaUF7DDPdLf39UPaSu/FmgoUbRH4BLsleypw8iS7rNpsawwOW6g0+Nazg8DeHoTI5w7YWFAN3N8uYwqxSWubxfTUEwjPSq4hnKzKuKywwWVd6dDFyltYfl4/ngnvNvDtbnz4B0Aerfvp4vLRTBYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C9OyXwPm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138d31e40aso5908387a91.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750177098; x=1750781898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBTZgEr/jdYE4IOPEYCC1EEPCPcizM+4dIMiF/rIsPI=;
        b=C9OyXwPmTycTftesLyFM4ly2lENSGSS5j8YmPrgrLWuC8bGyhY2toGQK466ReVZ+DT
         AkOIMub1KxkcuA2koa8oh2atWq96cl9RVmirA3t30tGTXOwWwiDcy+BaCuPBr0YuX2FJ
         5KCvygLYOF5e4wPcJUOXz3rUFdJunYF1EHnJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750177098; x=1750781898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBTZgEr/jdYE4IOPEYCC1EEPCPcizM+4dIMiF/rIsPI=;
        b=FBz4HDyJolq5dXf44HOZMhkkZpO8ywjojNUX/tSeXaqWhcL3lmwA2nGKQX5kPfcNz2
         /fDaQshBGRJGtc90jSm4aUgFtKcE80q+hXGKyC61vjWLIk1QWwzm+Dq0c++AN6QjwiQv
         B7N4nxAoFn6HzWqadNMlSJ494HyQsHp2hCiOUa5olT4p9Kd4Nbb/OidJX8tQmk7qH8xl
         bsjxAIXLv1J8FMtO+gNzDMK2B0zNU3dasCd1BQEfCGoMvRE9/+E8l8BeOFUPYnGNOx9q
         e+zpma4p985UFfNrut379MY/syd8SS6Twrsd1fZ5/sv8VAgkZe+6OKnz92eU/Ox9wXXX
         32IA==
X-Forwarded-Encrypted: i=1; AJvYcCWki6Bal6XSG5GFFAaD0pYXciQb7UmvWj5+4857qW/l+A1THJBxqL5UV2KB4HG0+13ljOkIPcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNzk9OdLhwdMWMm6otvHFusyJQzzgiKVDZBL96x3+1aJCE5v9
	/e8OIwT91VZ9PwQI8fq8TqlI4E1ItEqcwbvTTrhAwQ7hds5YmDQcS4TDQ9dlQcLCpQ==
X-Gm-Gg: ASbGncvwDLYooCe4uOQMhyVo6Cs7nXY9JvXLpzFHe/wHvTIkGvr7+6uf+jsA2dAXlQu
	YQlmFJXYqmJhRzF+v7v805kEbvYKd353+GMWbxTMYBOdm4/Ag9xIw4YHkodMcG50R7c3EIADVCt
	iBBOHbeONgt+7oe2F++9YoDG4cV08B8TTYzWLjbarB5e3/2wQ8+uq9qHaRZbN9ncEj5ilHiqzMU
	PxcvV9aEzWdeG2/B/EjuhQNshMjImso0ruD3Sc5He7y57y+ksgMnxrKLQ12e88PwajaSa6FK4N5
	pICklv3kaEX3QV6+3iQYdZOLao45EbShNuPVnvv+izAyM2WUb+rDzydPKEOlGpW4LHIiFd1ihEg
	8kNz51we8nNeMfRgIItuqzQzrjA==
X-Google-Smtp-Source: AGHT+IFOgj9cKNRmusfNs/8i1W+vPbt1qmsmD7dSd8TjsTe+5kY3DJx4i4oWbfmwAaPvyr3fdv5lRw==
X-Received: by 2002:a17:90b:3ec5:b0:311:e8cc:4248 with SMTP id 98e67ed59e1d1-313f1e51737mr24178526a91.33.1750177097908;
        Tue, 17 Jun 2025 09:18:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b6d4c8sm10841327a91.48.2025.06.17.09.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 09:18:16 -0700 (PDT)
Message-ID: <de8cd4e8-144d-468c-9267-51d642800cdf@broadcom.com>
Date: Tue, 17 Jun 2025 09:18:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 12/14] net: dsa: b53: fix unicast/multicast
 flooding on BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250614080000.1884236-1-noltari@gmail.com>
 <20250614080000.1884236-13-noltari@gmail.com>
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
In-Reply-To: <20250614080000.1884236-13-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/14/25 00:59, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement UC_FLOOD_MASK, MC_FLOOD_MASK and IPMC_FLOOD_MASK
> registers.
> This has to be handled differently with other pages and registers.
> 
> Fixes: a8b659e7ff75 ("net: dsa: act as passthrough for bridge port flags")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

