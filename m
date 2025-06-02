Return-Path: <netdev+bounces-194643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73330ACBAD9
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111A9400322
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6F2227EAF;
	Mon,  2 Jun 2025 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R30Ml5Vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50047221DB3
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887873; cv=none; b=KVCkN4dEpNZ4eUOG5k9EwpVzpnq8ggUT/aLVkA0Klxjf5A7UKvYOrqFf6t0BLByV/BRxLle+37Pggia652/b/6sM43aG1QaTlvk8UeB/3iV/xuA9HzCK03+f4BpbAtfw9PKeKyo0a5HSLeflfMWQjF/C33vz9zsr8Mwlc6/IcUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887873; c=relaxed/simple;
	bh=IQOXj2mWKxG4LnCPYqu20JJu5cF3ESUvUmGZOG1GktI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hkn/n1YB21dKoapQPjo21GdoJP6lycCyGaBY+hGgoRpHXojo8T/KWuU0hshK5b3K60DwC1y897u6iXX5mA6PEwgGfuniHhpKZRrBgax/FqMhEbVyza/vJSzA/vRfImb5Jw8IK3FQcio2zvpEjCFqFf+FC/WrdYEGmGzxnVMUs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R30Ml5Vx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2353a2bc210so29520755ad.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748887871; x=1749492671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBSPm4lDSqUwft73VRA8JaXXCTN7tMlvEeCqjJoyCc=;
        b=R30Ml5Vxf6rhGxrCDDbedqC9xKzO/VxhfAKDyjqwKdGaIXxzPUaaOsl0p/GxtN4gGS
         kjR4ZO6xi3T2k6wV4gTzye06wq/cE4pjB5bQYVO41OXH/ode5TupmHj4Zw8JysgMObY0
         JFvaG2VgjgHrAzVbK/SKLz4GPiZPFWlLy6WHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748887871; x=1749492671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdBSPm4lDSqUwft73VRA8JaXXCTN7tMlvEeCqjJoyCc=;
        b=Ec3bjkSep8DQ9ebeKY3MjEetZVeuuh3W0RSP3i4Y+MKGRxJLPBsVdZ8Z8BOFz7rH1K
         ExNgep1YKSaJzkBTgybp06xCx6Yln9iqy3kixhf+Fj3dkvheLgrN4NLdzDW6OqpPS7RF
         tgIq4qbU5bPkLvxOVbITxWl3Wy7U4jJdwMCovxmr8bZD+vo8uWiN6G/HVn6Wkh6V7DSn
         tf+aADKPKxcuVEbfM4aoO+fgyUJkPBdqa+QcqMOzJNsh1Uz+tnyTyDdL5XwKUWSn57wB
         cFuUFu9ZyJtAu7FVCTJN54zbLhaaY+qulIeajH6RQ6uzE+UbUOTTau69l9uzEHfzABhc
         Ij4A==
X-Forwarded-Encrypted: i=1; AJvYcCUf1O91rHkv6rvoiVP4BS0icIYSt0uzNWYxa4KdihFOOrqlWLUfoHW7U6f5EU0qHKKz3p8xif4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3LeyxYb4BRgrDno/jkTmQ598OF4as16QwrpHKohUlfCr3kPAe
	9QZ0uacw11zM2yuD+6b/TpXzHNk4oiJtV625zpPTq7RIBq5FnlJxC7MdCnxTqaiFAA==
X-Gm-Gg: ASbGncvjYmt6W9xmfAFV+bYnDSWzZ5uyUW4sueLVc+Lia0dGUgrIyaTwT8fOI95cI8v
	w9s5pF/+RJvZu9UgGLiAq8FgOkrZ6u5t/BBdTu5AMXyGoRHv8xuB1z42uVGaU0aoIlKix7hi5FB
	AP0Z6J8Yvi2MS0sJO1sp54Yz6TbG/eGQL5fIBGxCg79XOn2dd8KoZ3fT6KSN8MDmUi0i+0ZtLAN
	grjuGjFMZuB0/iwyZPgi0qJ3574zLClimA5QZXUj1hjLIAIx4OMhel04c6RkVS8O7rDejH0Ib8a
	vUax2T1F9A1ULZr32jnrG3/CRu7npkRFWESnqo0JKfkelGrYfHmMt4tlmnjTUSV0eWpbMADWS58
	PkXaHKpm42/4cv3w=
X-Google-Smtp-Source: AGHT+IEVGZpn/uowa+A9bLOJ5UPLni0Ixvp7UMIIwF6/riHxJPgzKmIY82bGmKK9D5Cn48v+Sho0jQ==
X-Received: by 2002:a17:903:1787:b0:234:d7b2:2ac5 with SMTP id d9443c01a7336-235395bfa8bmr204925465ad.21.1748887871182;
        Mon, 02 Jun 2025 11:11:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14ddasm73795265ad.251.2025.06.02.11.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:11:10 -0700 (PDT)
Message-ID: <455d5122-7716-4323-b712-9a7d84063c0c@broadcom.com>
Date: Mon, 2 Jun 2025 11:11:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/10] net: dsa: b53: fix b53_imp_vlan_setup for
 BCM5325
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250531101308.155757-1-noltari@gmail.com>
 <20250531101308.155757-10-noltari@gmail.com>
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
In-Reply-To: <20250531101308.155757-10-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/31/25 03:13, Álvaro Fernández Rojas wrote:
> CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
> B53_PVLAN_PORT_MASK register.
> 
> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>   drivers/net/dsa/b53/b53_common.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index d5216ea2c984..802020eaea44 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -543,6 +543,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
>   	unsigned int i;
>   	u16 pvlan;
>   
> +	/* BCM5325 CPU port is at 8 */
> +	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
> +		cpu_port = B53_CPU_PORT;

Don't we get to that point only if we have invalid Device Tree settings? 
In which case wouldn't a WARN_ON() be more adequate?
-- 
Florian

