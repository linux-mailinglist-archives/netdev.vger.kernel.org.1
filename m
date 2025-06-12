Return-Path: <netdev+bounces-197208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E5AD7C64
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C7A7B0C90
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3C2D5421;
	Thu, 12 Jun 2025 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FzbpUD2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFD22D9E3
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760251; cv=none; b=ulBQZZKZ3xy+ePc6Zs2KDAGs+lWgdaPsE2jl2ehNhA5zmAIq+7RLJ4LpYy8vsYqxx2UH4ppu6a5T2DZmW6LGcTXZGyZi/aI1PQTcuOXXkiUQV0G9Q8lN0H+6ulBo6aOr1ynxdXd/1RpnmS7ZLcaHqhTT0SsI5v/crWTAonadYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760251; c=relaxed/simple;
	bh=8U/Xvwpqyu2zIqJ+cd/W68aNh2NJo7ghEbSN8TMP4xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bCPkoPqDetYAlYiF643RtXb7dhZrEz1d0L3wt+Xa5aTzrU6gTlH4j7ola8G3WSkGCh0tPqRQ7MJTD2TGGNqQ7Ml44VNP+4wqoF3dUErykc3zPxyFmnPdyb2q5vu8IIv6GZASZThDxqP/5oM4GtJOIH+2ZJAr09RcuB8UfaUs+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FzbpUD2i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1170085b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749760249; x=1750365049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IfZew4MeawBql1hqYTJN9IQ7af5WvBIf0sZQmVb9XHw=;
        b=FzbpUD2iueaf8gcjhxSJprZxMiLgUH2EZldoYNluHpLPuhh9a5SEmt9zOzYv9SEeD1
         QItHrCaUgSt+Wfa8+3YbPFTl1ADy+0fMr3hKc3Bm0DFu9q+tYDfTpl1OfhVIUjAjZPCQ
         17NTeFnzMCKjgkSRXRsNQKpssDXVTKNfRagL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760249; x=1750365049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfZew4MeawBql1hqYTJN9IQ7af5WvBIf0sZQmVb9XHw=;
        b=Q2mTSF6CX8oWfL88Vw75sqzRegoFZGCRKpp4xrX8JFxI1HqVFXUHMwCmG4l2h3XKBf
         MHdGMqYYUsRlRPbUWCJdkQrW1H8SKp/nQQNij2tfUGOxGvyJ6vUcUe7rixqvZTdxMYhz
         CLSCG1LRI8JMp5e/v/60B/B7L93NpHGckyTWp7VnRSnNIYp/vW/pJiBEyUEdhXkB2UR+
         HTj1dMauid+cjYYQn0wLPXJ2YTc4pQmY0yXEsP5MZ8RPQxZYB05g8OD8WhyDKPHGIgtO
         UIcxmZxVb7OZjHqm7EfsDUxxW4AYCnPW6AHebJahdQ++Jb5N5rlgC9eMpTgDzIlVGp8b
         793Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7AlmaM3eheeZ8JNtR6q4W/azTA+uHpyYiyAvVfkCXO0bp1R3QVLcpV2EedV7YCpjBc1UF0w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGjfPqNkdYMbi7gXz6d26EeoaA3y1rntinllC9BmF9TTA+o1Z
	brLIM30IDjOU/PKzfE0kItEKg32uza2f2Aet/X+AQkCg+rkIwfUZt9RwTMcDJgfxJA==
X-Gm-Gg: ASbGncssNQUJ2XhsVLbfzy5bShG4QGuhy3flMnyWoaKrH0LD83hTTsUhG/9ij/qUJhN
	WLlORJvjMQX6KymWOPPkqkfGrApgJRDTcPEgA2gUDb38WcP3Gqnb8n5LqvjTa/Zpi0dWC36esdV
	rgvtZhgUsyFut5fH8Ov9aAVQyMyPDGcw9pZf0rBPg8pC2rtlfMMCCggapTcO1zKvC6b+2MYtVRT
	NEuPoeXfjI3V0leXqjat9Dm72ZLAEIEmIeJXYAsahoUB66UoaFIX2x8SYDLOREk85WvJAuOHbUu
	SPhmankUN1LDLg9cMRpNUpYKvBRqKnzSgRsbZ8iFICHIdUhzVNTKDeVPumpE9xrEvYjWLQud0fO
	9OEZv/sv916TPLhHZQ4xQe3QcCA==
X-Google-Smtp-Source: AGHT+IFcjJiEu2e9q3ebMJIMXfi9C6Xh5hl4cjro+1dnZbewk4L1FhqpOQcD+Rh/HOVC1b1UTLkfXw==
X-Received: by 2002:a05:6a21:a49:b0:1f3:1ba1:266a with SMTP id adf61e73a8af0-21fac105c27mr549999637.0.1749760249598;
        Thu, 12 Jun 2025 13:30:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecfa4sm161704b3a.28.2025.06.12.13.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:30:48 -0700 (PDT)
Message-ID: <c7afbe7c-f753-4330-9298-974e66dc483c@broadcom.com>
Date: Thu, 12 Jun 2025 13:30:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/14] net: dsa: b53: fix b53_imp_vlan_setup
 for BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250612083747.26531-1-noltari@gmail.com>
 <20250612083747.26531-14-noltari@gmail.com>
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
In-Reply-To: <20250612083747.26531-14-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/12/25 01:37, Álvaro Fernández Rojas wrote:
> CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
> B53_PVLAN_PORT_MASK register.
> 
> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

