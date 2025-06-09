Return-Path: <netdev+bounces-195844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40364AD279B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86D118938AA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7C221F15;
	Mon,  9 Jun 2025 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZrCA+e9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5222171F
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501327; cv=none; b=W9vamBxfNPKnjazplLy+Ap06psaSVaYHhjEsfuGhCgvQLtCAwPkIoXVQS/CDqRhGqzxPQBUTk6+NDWjylg6NM0exj/FBUt8QFBetHQrhQ0vWuRdAp8ZuIUv/GFSbavyN/bVf7BTRhSn5NJ6m5qJ4ipi35w0gJlUa0xqBGliHQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501327; c=relaxed/simple;
	bh=Rkoj1tzjocN93T/dtPVw2smN8pxaTjoAN0rusY5Io78=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=gBAIFV8arL1RiVs/oWtWrk8waoid6GHHtpIxDzNeVngtmShH97lAaWWzvZR1kHu4B7YFIGYQ4yzGtJthB8bVezj2XiWlmmrk67HKi3Mdx8Xiop3r7Q0vjinCk6UmBZUKbi7DUmTJzTrf3ySvqzn13D5m0PPmvs+8LYHDfNNxCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZrCA+e9F; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2350fc2591dso38016265ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749501325; x=1750106125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQs8s0rTx6hu1b5mD6EqiDWb5Vq1HWcQ19tnFr+D4PI=;
        b=ZrCA+e9F3xqJrqg218CujtHl0EhdEtNX1EWiCjqcJiIHq6FNR2K3PHG5Jtg9DNqUcZ
         poMn6ANs295fbOnvYkHGUpMILppefXrErV8yQV+x8MzRTx0HNauFfDLZ3J7CI6zrr19m
         bS5W2HI0VFmwdFp0EI/hGZKuOVvXSmVkBK9mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749501325; x=1750106125;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQs8s0rTx6hu1b5mD6EqiDWb5Vq1HWcQ19tnFr+D4PI=;
        b=YrU2BPS3rWkcUQLFwFBihSkqLj2i57goXe4wqWuw5YuceTbb+rAZ8Bfu0Hwe14XKzS
         rDEzPo/iKpbYJ+05fZIVMwkGRO3vG/9N/RcDGg/N0RNg68zvhv3pJ0dees2EaIybHXRK
         w/MMfF8U9GMmbqf2sTkeTKZJ+KYFoUzwrJGcaVOZ65sBOZVkfOIyhB3+8mjWHLiJwrHA
         SCedFwve6ZH6Xg0ePAk5XNtlyWbgSM8CXFWG2Kg7gCl8q+LwBnwoU4o7G2JtKvzBrpjE
         3nvGfa0r/x+mbvX+QFuw3qj63uCzeU5vP4B1RkbxB9/L+kI6gIBIVb+Pej45zlVP/Ff3
         tomg==
X-Forwarded-Encrypted: i=1; AJvYcCX7+UWvzY9JpllXZhkDZ9FPkz/B2JsKWEhMHpjDI2buM3Kfn9KuqhV3je+rD7pDqSaCVhxUrso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5NccwwQscGOeyhyBC60NCUGooYeqWG98KJWTRj0umRTfjJx+
	MW/6fONYU+uMk2/R2b0tHpEwMkhHbsrKDnDduzz2R19m5n1m0m84MYcqi7A1AE3nuQ==
X-Gm-Gg: ASbGncs/gsL1/mGt4j/wBayS+I/0+djO1Q33rz6yIQnwPm2Wnkn3gdruXeHu+m7GHYm
	+XMzmzyEiprPK3J4SbTUl8zv4AQUgfAIf6uPXaivrpU1tuLlYtbb7H29qYYXvyCJNPrARXPDg8p
	4MMhDKEQwOcEhyVHEi2iGM4SKsnlBRqyy5+hxS/E+1fWv666B3hE8wfOja3O5wNONuMSClme0/o
	zMbM4TZ73LSr7JX/iRj+chbp+OBWWuEhVGFYdbGDjoYQ6Ze0GKMyeE2Z4CdM/yNzbBqtC77gxiz
	77lAfI9IhloH9zOc1rOH33W7+gI0VOsk3+HeDF7xFf/7OrAIrSndHov5rclb0JY6kLWVT+cbM2E
	h2Nw9LXWTMxvepzylKWJmkyl6ZC32YZcia+b4
X-Google-Smtp-Source: AGHT+IGR/6BpT4mG1XRiAFkbp8SPoNLV4Iniq2TffcMgWrAg3r5EcI4t1x7SK3kQj/h/OivhCPg7CA==
X-Received: by 2002:a17:903:288:b0:234:11e2:f41 with SMTP id d9443c01a7336-23635b9f9e5mr11107625ad.6.1749501324996;
        Mon, 09 Jun 2025 13:35:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236035f3defsm57896125ad.100.2025.06.09.13.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 13:35:24 -0700 (PDT)
Message-ID: <7c49c4f0-2baf-4f90-af65-eab5e62fab6a@broadcom.com>
Date: Mon, 9 Jun 2025 13:35:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] net: bcmgenet: add support for GRO software
 interrupt coalescing
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: Zak Kemble <zakkemble@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250531224853.1339-1-zakkemble@gmail.com>
 <53748db9-2efb-4e8b-9583-5fe21fc4b993@broadcom.com>
Content-Language: en-US
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
In-Reply-To: <53748db9-2efb-4e8b-9583-5fe21fc4b993@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 12:00, Florian Fainelli wrote:
> Hi Zak,
> 
> On 5/31/25 15:48, Zak Kemble wrote:
>> Hey, these patches enable support for software IRQ coalescing and GRO
>> aggregation and applies conservative defaults which can help improve
>> system and network performance by reducing the number of hardware
>> interrupts and improving GRO aggregation ratio.
> 
> Without this patch, seeing the following with an iperf3 server running 
> at a gigabit link:
> 
> 00:18:19     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal 
>   %guest   %idle
> 00:18:20     all    0.53    0.00    9.36    0.00    8.56   18.98    0.00 
>     0.00   62.57
> 
> and with your patches applied:
> 
> 00:00:56     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal 
>   %guest   %idle
> 00:00:57     all    0.00    0.00    3.29    0.00    1.01    7.34    0.00 
>     0.00   88.35
> 
> so definitively helping, thanks!
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> You will have to repost once net-next opens though:
> 
> https://patchwork.hopto.org/net-next.html
> 
> Thanks!

Zak, do you mind re-posting now that net-next is open? Thanks!
-- 
Florian

