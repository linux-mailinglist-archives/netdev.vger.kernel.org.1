Return-Path: <netdev+bounces-236911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31FC42223
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 01:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D9104E11E2
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 00:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5327A927;
	Sat,  8 Nov 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HRB7D0Ub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A762727FC
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562339; cv=none; b=oW7we4xsX816Yca2JXAvBD+LZAhlw+kG+TXNMXg4mSI8PpLNmpdPEWYNOKDGt+dKKx5WkWYiYXdF+f1CyPI6umJgfSm9Q73p1gRqkbEMjV866uzOjoB2V6ID+u+c3D+fA7Rpr5UyZr6yT98odDiLkrWX0LeT4Dqwvg8PXwGw/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562339; c=relaxed/simple;
	bh=YrpLL7os0zfubETkyUUJJ6jGZrJcICmSHwXo+0a03Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twAFzqEzbKcA24UFJUxqKQSapI1omRzXRLiOZTaHJx++Gav2owEazD5gt+R6/O03RXAaUosqh0P1sb/2qyN3lpNySy60VJKl7t6LmAnEC+T2b7/nSCVpYGmLzEjKnLCKEtTqZl2D4z+im0Tvql/mssn2692eI/uVGmeF5rlS4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HRB7D0Ub; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so15927485ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762562336; x=1763167136;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWGeea713G9U0pEv1nyCaRDYj15IgFZ+zJHuxzQWr9s=;
        b=nq9zoMm7bV1bi7tR7Vjr0A119HYcV/c6mfCeI77DA56oZ9pzx+34+2weKO2MLMKwak
         vCTl8akr9zdmAO2ZS6Br1dEv39Nljo6vAA6zAjhvdWWiDveJXSN8JmBsPNNFyi6YQUUt
         7DhliqnIYyUecNTvx/lhKVRNJM++l3y4B6aX+VyZ8U2dQQJk6zq5a1Vy/Nyn4B4tr5KO
         vUXOlqWfW26WG278w5HZNyvpiSOPdPCUpQ6ek99UJAplhpwldR8rXxZ7Ciox7P17zP/j
         zMdHFpXyTXTElg215ZhKusrthHYXHqkvy3WvxmNrjnEk4X/ggao9IJEdV6pbTMSoJ64c
         2NNw==
X-Forwarded-Encrypted: i=1; AJvYcCVgGRWIM9qzQ0+JY+Nrs/sQhHIQ9nDTH0NjLe7vA2UuXA23jsjEL3m8R675k5YZs8Gjwjhbde0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSHA3YfdIBbFzi8eMwTGqhIBN/WnOU/CQ7/5rV3qjZwJgGEOSA
	piAJ7kq7s51qbBzV/kUyQF0jiEcjufNlFV+ZhbUttkfXCwn118E8znJJSiqaQww2YqGHACeACDs
	hMrbcnXEJFsjnpyqjXyHFzndygh7PFMCGyc06sSbcW/IeqZC1gQtyxyybRQZq6OjlC9IKIecE/x
	BMRAJxA2gF78fOjvr6t7d/icbK/2c4PUw2Pdowup5w5GG0WWIixi9kL6GTyfPVS/2455rXLZpWh
	3YOhe5wlO4VRLRZ
X-Gm-Gg: ASbGncvjrab5TqHXBGaEXCggktF/4t2RSYKKBLetkETrUwvZ7ftv7kL2nQTgVhCQGyR
	pTVwaRybsF73La4v/s9zQusBqRzH0xRsacI8R/kWmKbnkBII4GpZUWthm7g8ivPb3d5TwZ91+Dt
	xFBOLcQDTCtgmxL44MTtQGCxuLXG65Do89pztHCIQtBInm8gVYxo7rJhtFHoAlE3KzYUgUu+Vht
	2kzLCeMRrPSjYdo2krqIt8q2NdwFKw7erd+OFCCCpoOFbD942O+e8GZVeLKMJij2RO+7YWVBupN
	8T+9GmOh9S4dwuVHXGwNF55FwZrEk8s5nMezGp64Wq2CTmnVCjFtlrUidYQy7ynBUXJm1rnhwE/
	TrPl6y+OeK5/onoL5+3xB80ni5NbErAITZ/+HVS7RlRKYXpVWwB7g2BrxI3hv1P7lmz9swgAvQP
	SjwiqrzT8ygxFh4eLWoNa6p6CY7O9G/7Kkc+qKz5Q=
X-Google-Smtp-Source: AGHT+IFlydtHQSUH9+6mvLsn0AijIV5I8XmRfjZGUbQAX3qwFVh/Wu2BIKGpTaqwofax7NgNDtEno2fRNECj
X-Received: by 2002:a17:903:2281:b0:295:9cb5:ae2a with SMTP id d9443c01a7336-297e53e79damr9700325ad.9.1762562335895;
        Fri, 07 Nov 2025 16:38:55 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29651c8d5dcsm6390175ad.45.2025.11.07.16.38.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:38:55 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-44d9dc1e0f7so2100254b6e.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 16:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762562334; x=1763167134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PWGeea713G9U0pEv1nyCaRDYj15IgFZ+zJHuxzQWr9s=;
        b=HRB7D0UbzNtWHHuB0th6IQ2OQokMUpU0KPh2n+HDji+xCyUKu1fHUb+/Qgzme2QLau
         sjRijTwT8L3Srw0Sn6m9RghOvNad/bSSmkmmSWEVMgxnJ1bRdmVYPCifim4zVnPRO7kx
         KvyHhxjQYnHrz2cBLCbQ5FLWFOOeDSfdSLPmA=
X-Forwarded-Encrypted: i=1; AJvYcCV84hiotAQ7WaH1/J57e9vD1O+8ePxEBGp+gT3X6XkB1tVo+is5/+0AtX9b4G9eEBFZcAUgFhY=@vger.kernel.org
X-Received: by 2002:a05:6808:4f4f:b0:44f:773c:33cc with SMTP id 5614622812f47-4502a48ca29mr713977b6e.35.1762562334371;
        Fri, 07 Nov 2025 16:38:54 -0800 (PST)
X-Received: by 2002:a05:6808:4f4f:b0:44f:773c:33cc with SMTP id 5614622812f47-4502a48ca29mr713961b6e.35.1762562333975;
        Fri, 07 Nov 2025 16:38:53 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57d6767sm2981861eaf.15.2025.11.07.16.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 16:38:52 -0800 (PST)
Message-ID: <044303c3-03fa-4eea-8b63-f804171a4f93@broadcom.com>
Date: Fri, 7 Nov 2025 16:38:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: b53: bcm531x5: fix cpu rgmii mode
 interpretation
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>
References: <20251107083006.44604-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107083006.44604-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:30 AM, Jonas Gorski wrote:
> b53_adjust_531x5_rgmii() incorrectly enable delays in rgmii mode, but
> disables them in rgmii-id mode. Only rgmii-txid is correctly handled.
> 
> Fix this by correctly enabling rx delay in rgmii-rxid and rgmii-id
> modes, and tx delay in rgmii-txid and rgmii-id modes.
> 
> Since b53_adjust_531x5_rgmii() is only called for fixed-link ports,
> these are usually used as the CPU port, connected to a MAC. This means
> the chip is assuming the role of the PHY and enabling delays is
> expected.
> 
> Since this has the potential to break existing setups, treat rgmii
> as rgmii-id to keep the old broken behavior.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Reported-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


