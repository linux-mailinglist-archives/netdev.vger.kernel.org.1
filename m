Return-Path: <netdev+bounces-158216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 453DAA11192
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56336166612
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9220899B;
	Tue, 14 Jan 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gh6mp6sf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6E20897A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884672; cv=none; b=juHYlcXYhr9JYf0XQobrgZI3n5BUbdo0hBGeNmcfDMysdKNCr1X7WThHH3JG0njw/X5X7HKonBBnBz0QnKIOF5xBQHX/Ie+xFQrQeWqPRoHTsAPPI+SwysSCqzpqfMXP1As1CA3RyM/vYLws4GMcPl4/f0ZeiqLL4H3PzVIAJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884672; c=relaxed/simple;
	bh=ckG18ySj3hryyY+tpoFJYcibO3ihiw4ysb6aMaPlLdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVzlf3Fx2OgmO5tMVLqGd4wiJdJB2LX+FJ00AaTWncnnjDM/t66UZ/SfpqF6toE6vQTsH0WXxfMW2ZczuZthoB1kU49/jy8jjjfpzfOVKi8I/6LYMcB81s43pCE1QHbN5rDAUPFB0qKBpDNxX9l5+qnRPvhxzuaKYv0NLYkyWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gh6mp6sf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f441904a42so10215186a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736884671; x=1737489471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tuBIwJ102kMotTRTNfCQQmuW78ZKXMy4QGzv+lxb0iE=;
        b=gh6mp6sfFp7EhjhlvA0x98ImRtPcAteNj4LnWxH/1U097KS7OyCKQz6r8djTFaPjHe
         jVMsCs07M1oxPjArxli2wwAciHoKXL0rQ3L0zdztnqXFZVn+fyJ3C+x5uUmJVsAktFBM
         Md8g1fPcQ2sreVBWrcIiMlnujQ0avbKlY6dsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884671; x=1737489471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuBIwJ102kMotTRTNfCQQmuW78ZKXMy4QGzv+lxb0iE=;
        b=wpG2l1rYSqzGAIcaaxm/MS2tT13ng6ea1khtAljT2AxTunDe2i0wPVrOhFQX3119cH
         XFxKYaJmtHguGdMpTZBd/OGVKxu6jxmv07x+o7OPMdJymOrxUuGrvbPyyRaCMljc7+8i
         RmhrLnPs+/rurdYBWL7xQ+Er/6hlWqi5x5QsOffd/EYIVWs59JKjKBsY47QiUBfMY0CE
         RnrHAhtH0P0tlTIhwUoXb0/Axl/DOx03/baGilzZYTJzOc7SGoI4bmO0joxImS1dJgOo
         xflogtcT9gxybvC/esNV4fSxSKzmMnPiWCTZs+Y6DTfpGKOt6yYRhFWUi59V7SJEFUJ6
         qSIg==
X-Forwarded-Encrypted: i=1; AJvYcCWmjAfnS6JY+QDR9tZdkWLdgGe/LO6tFDp4qkwagjRXjEoPKJXWZtJKCiKwOzcjNZC6UyXQCz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeCkNQ9WAMK/4G/7f0jR2pHL4XuJ0xhpxri0ZAupYW+rfsfrMQ
	ti0jwhQGifVxqA87SyfF6UE16Vm+zGo0b/rgRAfurr9EHMOVkQPt4cMPdddq0Q==
X-Gm-Gg: ASbGncu1FKnFs2z7gCQvM5WheB2TrSSIJGP3DZs1l9J5E2a+FT98VBsxgniR4/EAPX/
	ICQXFjWR3d7HHgFTJ5bxvKpJbMuhcR+k3Ylqv2xPnKhtUPXfC/XMh4kObD9+87ZC2O33E3ipxAV
	BhLrGvgmpkGuy4pFzxk7ettflYQaiDALG8OtG+beiBjq8FEJaTNyeq6JhflJ71z/g8vSLuIhW3k
	UDS7IMU/F4Jj4wtFnd7t+c6/UMwmBOlX3BsAuutDY6nnohYnvlc9rhd8+UjtJv0b0GysHzTp6YY
	Twcig6OICqpGR4DbfSmH
X-Google-Smtp-Source: AGHT+IGjxYEai86R1Q7hYav4Mn1k/aCLw/WHUyByEVI4bLqKJ7YGUbgEppfuVGSAEC6oG0tVJGT6sw==
X-Received: by 2002:a17:90a:c2c8:b0:2ee:c059:7de3 with SMTP id 98e67ed59e1d1-2f548f5fc37mr41708507a91.18.1736884670824;
        Tue, 14 Jan 2025 11:57:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5594697d1sm9855771a91.42.2025.01.14.11.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 11:57:50 -0800 (PST)
Message-ID: <25f9668e-d417-4723-b4d5-621e3a55c1b1@broadcom.com>
Date: Tue, 14 Jan 2025 11:57:48 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: bcm: asp2: convert to phylib managed
 EEE
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 bcm-kernel-feedback-list@broadcom.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
 <E1tXk81-000r4x-TS@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tXk81-000r4x-TS@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 08:50, Russell King (Oracle) wrote:
> Convert the Broadcom ASP2 driver to use phylib managed EEE support.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

