Return-Path: <netdev+bounces-172588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B3A55759
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F314D174F49
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F29276D33;
	Thu,  6 Mar 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J9l/Uijz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8581A276056
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292232; cv=none; b=CB+1lkA9Y92iaf6dJIYFd2451WWrYEGkdDSvdeWThuwZYfwMlcWLKVtEIvsMW4QtX4vLMjwbZdrwThl8X6CElMbJDow496BGEIY2WhqLqgM+quYV2ItxGV4TD8gwnKMlgQzQOlRaB3GV0Hr9bBR7oH0OOQvwjEL46kbNp8srKXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292232; c=relaxed/simple;
	bh=06FhvAeuepcYq1hoim3lqG9x2jYnr6RjXEq4/G7992I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoCtrzzplEsUaZY2BFmJgpLQtgrFoLAIcAlgLm9U544CXnbH5vpIao3TntyBIc3WPgQBWFhu0zVj2nnsJ7vItN2doLsX0J/nPtWFpjnio1N02V0oI3wEolVgjsneuHLuvA6VMhVbh03YdNzTYubrewE8EeN6f3Rr51t/VT8wVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J9l/Uijz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2235908a30aso28370115ad.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292231; x=1741897031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LYtabAXpFlLUqMsLfTp5Od2Wh8N47LfPWDsj5ld6WxE=;
        b=J9l/UijzdJwS87x/8qdI1NuioD908cVKoTilSGcHjR4SUMM0Ka5M2U6Jk6vOEC9SXx
         fr3PNO3IyttIZdfJQ1fcsAV6/nujOPko+mHPX8UXogrCJ3o5mkyDA5+KT2GZRbbBewCd
         BxuKDtLliYqFwNdjQALljZ5lc769MdNENmok4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292231; x=1741897031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYtabAXpFlLUqMsLfTp5Od2Wh8N47LfPWDsj5ld6WxE=;
        b=r9XDErBVndQJ4TpwQ2r6alIrTTwpeuo8joLXnHbWLRUOGG0Pp27MP9fKgiKEeKjN2w
         fRW0Bx6IAYAOn6OkpoOKCzHLWMqhWPkRkOanFMEA8+N/izM8jZLMnxUWdjU9VGihbLoI
         tL3qc4PvC5uuRgcafhioKhs5rsXLgtZibA+3mo9oJMGYOrAd29SW+UElNuaUEgvCWVeH
         By6Q5RYGB9eD6wAIjU2aqt6KWzBzt6I/IEmZHJw/i6+YzaDkgqISxb/betOn63nM27dN
         aaYHozATEt6ShJobiEGkVHPCZc3Onh+or548KVNlG1vbaxTCPlHd5N0iZS7OqJvWmkvw
         uWVw==
X-Forwarded-Encrypted: i=1; AJvYcCXvleIv4MDhgRm+YRqwTPCN3pkfNcbcE1hzQYeyrP/VyPtT6K7EdLbeEIqICELmBJw/GvnhuME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkUo/mcPOUpIvZkiYoBNJz1kBfbF404lxd1iyIdvlsOeYQa1S
	02ibwEJEb+GhB+3tqMbm8Eri6bL0j84gEB04GehseCIfSJm5Ii/2NDndfAtBug==
X-Gm-Gg: ASbGncuc+eshASTmI+EtHH5UiwyyyonHurSJ3b0biSMD83gTZkY/y9aegQFVdwrXksN
	8Ua6nqUZ8mXbsM4dmCN+Nv6WTFgNLVJvwQ8riOSeTMWgTI3m8bEZ76wCnayrJm6R36cC5xfSn17
	DoLq4VLpkOEE9ZczShZnPiBJRjqFk4hic6bhV2GpzucPGHGNtKvgoh50/VlelICl0GUx+epyBqb
	ctkPbn+NqPJ44q7atFyyir8cJ8M34ZT12zXVF39ox6Bud9nJtuCsSMJc1Lw2JmpfMC8ySamlBka
	hbho69Gt2riygeSl3Ngo0kMkzPJOFrCBmBsHdgkPMJIIBRPJV0qadmGTzLkroHSSmY1AKFCqBzb
	maR2TMrVR
X-Google-Smtp-Source: AGHT+IGDru6yfTnBaUZ9w6bQW0setOAoqCdfMrFuD5V3RlxiVqbQwEFaTnDGXAke9NQrVT8csqDPpQ==
X-Received: by 2002:a17:902:cf07:b0:223:5ace:eccf with SMTP id d9443c01a7336-22428a8cdbcmr10624285ad.25.1741292230779;
        Thu, 06 Mar 2025 12:17:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e974fsm16714255ad.78.2025.03.06.12.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:17:09 -0800 (PST)
Message-ID: <0adebd9f-5e92-4446-a4fa-36959e7c35c8@broadcom.com>
Date: Thu, 6 Mar 2025 12:17:07 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] net: bcmgenet: add support for
 RX_CLS_FLOW_DISC
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-8-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-8-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> Now that the DESC_INDEX ring descriptor is no longer used we can
> enable hardware discarding of flows by routing them to a queue
> that is not enabled.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

