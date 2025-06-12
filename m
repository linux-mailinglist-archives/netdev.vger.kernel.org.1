Return-Path: <netdev+bounces-197206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72076AD7C5C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4920118918DC
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6102D5421;
	Thu, 12 Jun 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h5oNK+We"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3C2D541B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760174; cv=none; b=Rv8Rp0aWON9w8P0Yla0u7R7MW1wS/DDs+IG8VprqdWf337kOHySqs4rbgvHjkLjQCIzhVlf+IE/9yCzKLkMQDJxwEartAOuKaYkpvHTIm/rBIeM6+hFdbzFmELgFJ1pSnH6ksfpW5Wyl0TRMAYT6Wh+TX+r366tuTPFeTZ3XfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760174; c=relaxed/simple;
	bh=FKMoZJECdM0Y1gdOA2xCgCEZ65tmCjn6qGx9caRpRXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b9WmMOpzvltiRwP42IfTt1Axg6rMzgL3RVgFMpgugR95pxPdlZuxHNM/WZm4gAc7UjWcdhjPesSKCIXSz2XP6EGjiSrYHXux2MzJunlOqsK1HK4UpaFmfgvgDfaKiIMPCHjuToUTt8q3pftQMtqJyhCq6Xbrp9zW1AOikvx6bgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h5oNK+We; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74877ac9d42so1027512b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749760172; x=1750364972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3MI2pcC0X8n95TeRsQHH9r4MVxCi1Go30tv8Z8JI5jU=;
        b=h5oNK+WeckVdnKJnAOkwl+WC7RNEuDuP5pEuOcBjUVUYofTYsuhubaXbdZifsjpFBa
         cXcbqvHNzCZ9jK4ss4ox851G4DLEth4X/jaj7tOYdOx5ADRtzjKl+jYqzSD0BOtm+Vl/
         cIap4eNLeTZbZgeXQoqpO1LEgrQszaU+Qjnz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760172; x=1750364972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MI2pcC0X8n95TeRsQHH9r4MVxCi1Go30tv8Z8JI5jU=;
        b=ZglzK8YiHm2ka5xhZW5UOr6a5zOyNoWuuIb0uXo3m3fKYt+JLldQSfgRl6gHjil5rh
         2NtmWAPRKDTH4Z8s4g+21rWQt0rlN4oYQWGlFcZer9hKQLfQpZ6KrQtCSL3kGBfTVfLH
         /JQ0uySBV/1JtgckO8/JJ0OOC9dzbnqRZ4V+rGT6Pl85vF+9tdlUsyaWpLgTPTu9dNU2
         Vr750+/oK3Htr4qtCkZmCTHpoxY0sVDOwdPi5JmdjCtL5fkxLlMYgVEKMie/MVOADAVh
         Wjwnemu0jWcXcJ368sP5RbgjxlAkHaDYHseQIzq5caLjygRbrljknS7S8oFqTeV7Nlq/
         5SHw==
X-Forwarded-Encrypted: i=1; AJvYcCVDwGX9ZWji3BDaogt2ce6nQjA97aGA92XNhMwgW7RbJuBsMYLEaQKM+WAJ7rO1wysMua8qPhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtlgL4TsrIYFlGD9Ut+L+gdWGD+M/3vAG116iJHLf7Rf4kP94
	Tm4xdvF2v3+AomTVyVM4R5WItfA5/VNnl1SxIdLIp+r79jlv4hlBZR2b5BhEgbvNEg==
X-Gm-Gg: ASbGncucb/ULLYOCgUOAde+t4Wf1uf+HTzqzfFXWK5L3Twkph48k+KLtb3MpJVY3eNh
	Rqjp7GWaki13tmanb+kr//usQqv2PlWzZZW86F2bcICguLf8n8401T6JUFHt0HRUNRceUmDUDve
	c3DU6YMsMTMUhCUcrT5D+n3HwAKIvPcW7qiSHBaHYyrXDP/iFp7RorFCfv3ElQu4hhz4CzXT9ax
	IvGiS9IXvi5RWRTVSNLDKryutQwgakOwbcTdYtyqn3No3/gYsexPU2JGD5ACEwTzhONwPAG79Pb
	J5ynC04UzWHHoZx4S9u0V/rA4HHvyefppf9DKIeXP0uOqkWYviazcmD9zxDpORS/HCeX7vVZe1L
	s6q7GuvbKQA+p+yWlmwnu2ORzfWLF/3j1cvit
X-Google-Smtp-Source: AGHT+IF5selXWddL9qk2dRvPSKlCXwJgSPy5ahHww4/tE+LiEmsDigxLYlPWNz+Az+F/jRpPfuKpmQ==
X-Received: by 2002:a05:6a00:92a9:b0:742:a5f2:9c51 with SMTP id d2e1a72fcca58-7488f7dee54mr777278b3a.16.1749760172615;
        Thu, 12 Jun 2025 13:29:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083c0fsm150721b3a.72.2025.06.12.13.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:29:31 -0700 (PDT)
Message-ID: <35ee652e-77c3-442a-afae-c491298bcdae@broadcom.com>
Date: Thu, 12 Jun 2025 13:29:30 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/14] net: dsa: b53: fix IP_MULTICAST_CTRL on
 BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250612083747.26531-1-noltari@gmail.com>
 <20250612083747.26531-9-noltari@gmail.com>
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
In-Reply-To: <20250612083747.26531-9-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/12/25 01:37, Álvaro Fernández Rojas wrote:
> BCM5325 doesn't implement B53_UC_FWD_EN, B53_MC_FWD_EN or B53_IPMC_FWD_EN.
> 
> Fixes: 53568438e381 ("net: dsa: b53: Add support for port_egress_floods callback")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

