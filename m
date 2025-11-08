Return-Path: <netdev+bounces-236916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF92FC4224A
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 01:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4952918986A3
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 00:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717C2848A2;
	Sat,  8 Nov 2025 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vp717TLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AA28369D
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562586; cv=none; b=lHzuvrnBC5pokG4Uo4UBEuIWKINW6lhPQSM/WskxhkOzhHipLHQV4IK/7DjR1LgyD6qPKH96HCm/ffhnHRjOvfUZiZUbWEnrw1wxdhY/R+ZU3O2pvIK7PxzuSzCCJuuokr37q9bvnUt7z0rcqM+7FlFSNqXygYiUAF8jVX4WtAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562586; c=relaxed/simple;
	bh=fO/ifcZ8YnY/H6x+bJGY0rfhBdRRNGrC70M25TOOFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uP0K+h36kDNrXOwKKYuYwORCdwwyOxDYVs7N/naQlXz8k9NlIgmnNJsC1c0YMH4ch/piw5kC9XRpHsdqc5RPifhPvfH1zA6T7DvV00zJgB6+vrjetYYfSKAxIh0bzPOkbINbZAfS8bDG5c7psyTtS+LjoZh2NlfFqLazNeyqzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Vp717TLJ; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-93e2c9821fcso119028039f.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562584; x=1763167384;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wfc9eBIdG6EpBk2naWqUKw0abfgjnbqn4nQuM7NwcuI=;
        b=A6kOLhxcg+6eWCg5odNgtBOwU8w9LSfSNgL1qqfhdyJJU2XPzS7gAsIAK/ApvONG5y
         ujPqtgY+gUEG/Ni2tDUlIkC3tUd3p4bIXLbUHQ6Kjx+Fvku9DSdJCfZ2NsOQHAkWvtYD
         9K4osP5zWW8SjVfVGgJ56Pn7GjCdmSgrfhzFlCjZPxgweO8gkZ/Y3lFGmb3iN3b1qiQ+
         FvksQIEINyowdLOE/Abg4coy+uR4H2sVAbIvjMdIuSUMbyd9IZBMwt3TV8rASWNpRFQn
         9OCF3yj6P3+0ydfiFkjoi3CPpuggBAAAHTZY3MadJ735MYQqE4VNsT9MkTAswlBjXdol
         ZVKQ==
X-Gm-Message-State: AOJu0Yz0hhqs+ISTzJUcrl2orLa1QGZKGdTtTBGOAmMCwQfnB+C8AtDt
	lvm8s9kEEnaDRFu8dLQ3QfX/Gn3uMpn5TEcKqTfsS2QNZUWHaPzQUodY2eUrHY19+VwvQZS7lzs
	5fwqxUtCGbaBqt0ai4RluBLMItziX8aOnW0E8QNY46RVIEafjkK0INQ/7SIDrnvLP3S4MgW4Z/x
	paBz7tA+xXmvsFt3NClDfk6UvLUAk7FjPT0ybkAQVhuNwiH2xJ7Y+i73GPj72QD0C37EvkY+n6m
	wRwejmNlzEZzVqi
X-Gm-Gg: ASbGncvH1hbBQdBiYjlj56LmGfD1gXZLly8k/ujbCZGXgWcHaaVGmnkGc4T3nbL2fwi
	QdgU9bDDR2LSdAzk7PZzU1TIAYSelkckoaVPIgdHcTQznc66HU+LPbIq5IpDnFxN/51+6WSPJLm
	F826cOyEwspNGqslgCKcVXCwuXTim5q9Uqc9EDLxrMdbEUFQ8WYyNMsrTiIGa2TGGNKdoYwDITz
	/6X7Cjg0mvOUH1O68NQ/j+ixXMEMYntGyfWa1IUjzFqF2rAnOIxmfIMoFc7NPLx4N73SVGBVjfR
	aelftL9DxGYncgFLus2k5yI7uryJIqn5Q38aGkXMpYPIzJ6wl5JgpFPCd7mqosnpaE/K0gTGYPD
	a6PnfuwK/vwPJ76JIq35O3/xLJXFt3B5F4a2s6wBoCUX+BuOsQ2hy11P1b76mQThRFhwPVeFPyr
	hJ7C3R6K7HH11ZqL3O17CIsWWhnsWVjX/HGEcsmTQ=
X-Google-Smtp-Source: AGHT+IEOIAGfJhdEsXTAHdhCnUGat2O+OxF7k+KPEMSxFzGAkBPq26tISbqcdobmzf0HJF8Ic2CxOj42NDmU
X-Received: by 2002:a05:6602:600f:b0:943:89ae:4200 with SMTP id ca18e2360f4ac-94895fdb064mr161687039f.11.1762562584199;
        Fri, 07 Nov 2025 16:43:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b746739a70sm674667173.2.2025.11.07.16.43.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:43:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c673f5f4b6so2895803a34.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562583; x=1763167383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfc9eBIdG6EpBk2naWqUKw0abfgjnbqn4nQuM7NwcuI=;
        b=Vp717TLJeEn7HYyNwlBTuL+rxzLd4KIOWp+/OabrxVGkK/sc3bnRV++c9kDcgkPceh
         /m/3SLwRn42E3v/wE+te8WjXWEK//QKRevtgtRFFfjGOAYGyHfTisdh4kFzeyPt3pUJV
         eZz0Ndf5xBKD9X3xNRDd3lmQRjAsTg/QKDcXI=
X-Received: by 2002:a05:6830:6e97:b0:758:6251:2e5c with SMTP id 46e09a7af769-7c6fd7e229emr865288a34.31.1762562583334;
        Fri, 07 Nov 2025 16:43:03 -0800 (PST)
X-Received: by 2002:a05:6830:6e97:b0:758:6251:2e5c with SMTP id 46e09a7af769-7c6fd7e229emr865274a34.31.1762562583018;
        Fri, 07 Nov 2025 16:43:03 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f11323a0sm2285377a34.27.2025.11.07.16.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:43:02 -0800 (PST)
Message-ID: <0b3eaaae-31e6-4b18-82d6-2637997fd793@broadcom.com>
Date: Fri, 7 Nov 2025 16:43:00 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: dsa: b53: split reading search entry
 into their own functions
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
 <20251107080749.26936-6-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-6-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Split reading search entries into a function for each format.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


