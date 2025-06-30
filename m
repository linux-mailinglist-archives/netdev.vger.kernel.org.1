Return-Path: <netdev+bounces-202594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C341AAEE528
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB9217BA8D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA46E1CBEB9;
	Mon, 30 Jun 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WWX0/vqg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249A28A1C5
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302939; cv=none; b=Hyr9I/MBcTTHkaNgTssSWbo+1nIP/k8a5BLAbHKSMHvnGLVLJktcxUmjuu/wT4Ap6RjvRMJNvuK7/x+JZFT7+6Hl9P0bmef711vDzvYktEdgqEes1JVe21DaXJiLLX6Rj0gRC3ieA1w1GeFNGxaNq8rJjsifcUtHWDVUjhS2qP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302939; c=relaxed/simple;
	bh=YwUyQUX233C0MSZgMJu9g4XZRqJb3WbMkyCsiXVUvAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7c0HWED/cttN+pksbx4FvkKGtyBEJPz7wqHiIQ2vnUP3WAElfziFZxnH8uJEiEhDIqOHo2YiXwqsiDJGLoWakT03O3Dd8n8j4fSgLutWJC3uheV4JTaMXtZh4UYpDQYoWExZvT63LJntB1f/pAvjxlcV87PUJkOOkrk5tglMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WWX0/vqg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1524285b3a.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751302938; x=1751907738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kKECFJl+VHzbkCr8ANm5LnmBY8BtCcv862mIrleW9YA=;
        b=WWX0/vqgtAO00c+cT3iBpaC3QrsjnX8ETsl1ae1FmxhmrmFnkwL7Tap/3F7QRfIMgD
         UiPDzQsvGUHT9ukaFA/6Q/BzXqGaOcvo4fcEmRVWzQsJo9x6p2oD7BZ6YN9oscKbCPcT
         apXnvelkU6uQZRQ9We/GH1JdHxvZknRa79Z1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751302938; x=1751907738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKECFJl+VHzbkCr8ANm5LnmBY8BtCcv862mIrleW9YA=;
        b=L7pmHfUzNTry/JSkkirIpHVQcqXso8SKWVm3wpdeWnJ+lV9YVsaSawlug3d4INHsp9
         W42xmjkuB5IqynTTsMM/6vPjEZYMP2mpU4J+V5ck7/5vqVBpGOS/wveulN+pAbtyVAPg
         gnyGyW5sgWft/w2jwZBJMAU1NuA38JxfitCyFylYSTg6Ul4dtRAE2OlnpJlUoI80RHmT
         1w1kb/H1jBoVz7bxA3CbGQlG1eTYoh1xuXWx8llYoT5XwtN9Tq7N2uq2xKq/viOfv+Qk
         Ad+41nwpAjORxs1J4HwiwIKbzYpRtPe92ByJhis3vq27BgIUBJLizFW5Oai5bhw+rvUG
         iK3Q==
X-Gm-Message-State: AOJu0Yz+vVJQPqA0GloCUXhQ2HPpao15nQ4ukag6R+lV3iiSIyjgn7As
	XBWNV67ZhN5Ly/cpNA+Q+VRhZoeGVApQTHIM9hxDEekReHcz6dWFAwYxVlel2nI5yba2Jpzko9h
	H66wEYg==
X-Gm-Gg: ASbGncvxTZmYV7YqFoFrDKWJ8wf4ciojdXmvIlHZRe/qc3+hhrWflN3amk2An/uH183
	zFvYFFeS+M5MYgtPhN/jNReePBkOlyYBhCOxqNb1Oc0qaC+VQusXaXk5ptzbKz4Rs1OOm0H3L8j
	RQPFS4Vs9pc2qTiGbfUtcfACNKWDxvhc1cjSHxgfr2TWvxMIYekSwJ9Y4KRIzKz+ZfGOsr/cFd3
	1I2WbisHvcJeSGSxN+lk+H497gBwXKgFKk45R/FGpbbBhIulTRmeljF6xMTedVfSW8AfXm4JgTm
	qLdUtTNEGyP8SrXPeMmZqvct7XaI6f/URlE1kP1OgVczyifHysXvdIiH4dazli6ZgP1hIV7+aIj
	ejCbusCY7uSpMHGjUPMIHyvX4Ng==
X-Google-Smtp-Source: AGHT+IEzHv0xdel7++1V4VTijbgsg5oXWHHZtPaGf787RJjgBuHV2XdvPwfXA4Ck8RWScE4XJq2usA==
X-Received: by 2002:aa7:88c7:0:b0:742:ae7e:7da8 with SMTP id d2e1a72fcca58-74af6ee4838mr20264390b3a.8.1751302937490;
        Mon, 30 Jun 2025 10:02:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e301f704sm8457216a12.18.2025.06.30.10.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 10:02:16 -0700 (PDT)
Message-ID: <bdce5d76-2987-4b8a-9177-3e3de8491a56@broadcom.com>
Date: Mon, 30 Jun 2025 10:02:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/4] dt-bindings: ethernet-phy: add MII-Lite phy
 interface type
To: =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?= <kamilh@axis.com>,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, f.fainelli@gmail.com, robh@kernel.org,
 andrew+netdev@lunn.ch
References: <20250630113033.978455-1-kamilh@axis.com>
 <20250630113033.978455-3-kamilh@axis.com>
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
In-Reply-To: <20250630113033.978455-3-kamilh@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/25 04:30, Kamil Horák - 2N wrote:
> Some Broadcom PHYs are capable to operate in simplified MII mode,
> without TXER, RXER, CRS and COL signals as defined for the MII.
> The MII-Lite mode can be used on most Ethernet controllers with full
> MII interface by just leaving the input signals (RXER, CRS, COL)
> inactive. The absence of COL signal makes half-duplex link modes
> impossible but does not interfere with BroadR-Reach link modes on
> Broadcom PHYs, because they are all full-duplex only.
> 
> Add new interface type "mii-lite" to phy-connection-type enum.
> 
> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

