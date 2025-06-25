Return-Path: <netdev+bounces-201219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD7AE883A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B40217FCD6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79018DB37;
	Wed, 25 Jun 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hukUymb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8071E1C3F
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865600; cv=none; b=SXII0D9XRc18AfO1RKwxrFBpdpol58bYWXaygGmYV3VbmHubOnpH9CKp4uz4G36QRyOb7GQHE2MTyGon4k/quinIGjrWAkoWtjI8AEHul/tZkMSxfEc+HGD5SQCd4D6JPpp/FRBFF5SVJBekn+Whst+LWOGrJ0S9BPe7VvoAvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865600; c=relaxed/simple;
	bh=c8FSfguKABksIcExAHgtfoLmBGZaZ1ts3uapmjwMvAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSSd6l8xSism9Fp6nA/F9WxTcRBCoIh8HQaOfh8ARb25uJkvUm+JmFPFVv3h6FwWFPZL4pDbC72naha9Jg7RNOatqw7FmIHk2hy4jG22KcAAmSxxLUWyCxoLwGbl2y6sbveKlvqA/guI82GjFpEP8/HHX7OFrkOIG75QHVDGeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hukUymb6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23636167afeso143785ad.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750865598; x=1751470398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B3s1/vNdKwqKk8VSN6xQBK6wRzwuNkbzzDSegXDItxY=;
        b=hukUymb6okcLnK+7L4pHtp9GfI0+G8gntIyxa2hTReo2REGPEmAVZIajSd/VcdZMA8
         q41+B8J5EGLjHpVmsDcGdVKb/bvS5gZsRMT9PCDjYJJ3AgIiBU0DXJDvRrAaTQWHL34d
         64gws/YDFMXjSv7q4zp0FlyGt8215F6WBaBx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865598; x=1751470398;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3s1/vNdKwqKk8VSN6xQBK6wRzwuNkbzzDSegXDItxY=;
        b=DQFkvSoVvYSL8o7vHhyNlXjfJ3OBRVXDclHzDPYwPKZWD3NUel2MAzZHgSjObjarsq
         Dv6lVwsGfs7g4446xkSlYWjzLaKZR/Ezb1Bx5CTyHJAePUUAeVnQ1pNhom3XzcdCnC8p
         0NWod9p2ZrcoRr48Z8f0jX7+UVSiMcy2Bg0AmHTZi3KJkpoV/IgWUrfPslxEItABDD20
         rYWX5lmd59DVsiQCFfJif32BC5ZSLqT+LTVclYfwF/iKbBS67u3ydLYoQUeMehq00thM
         eUVqCnTMEdwMSUqAn7FsRJWkn3NpWMBi144Cvw9ZRURRR0RpWq9d8Ey0X4IpRquMPlTl
         bbUw==
X-Gm-Message-State: AOJu0YzZYHYxmYUtMCxDrhgacbD9aFJHJyaD/hergIZdk9sXzOvAu9IU
	rHvc6b8RPLtqGh7sjYDDr2dfGQME5lqJ3yGZhprnNdvwmoQ9MG9WO0VGIDlCCQP8DVLpl60Qa43
	/wP47dw==
X-Gm-Gg: ASbGncvlEuCkY4IcjIfN54bZ0VStKFdvKeg8NWfOvn/dHXwJQCGCQsueg8s3nQ8Pdow
	Ld4Ruy9VrVJusTEfI5PCoRlW5e5lnfppuRT6OE+Uk6MxD6JIkUakoKENrk74LNqyb0p9f3CU6b+
	EWuL1kBhE+kwyVNVxhDN69yuUD4hVLifmN3YPGllMNTZkofeMdQgloGsqhna8FN6rjTc+VkUutM
	Jio1cUbjzXbfIW/M7ArPiSdNELcf9M170xQnCueYjijmlBNGS1aV+8dOkoWwfp2X8wuJiuGTYJx
	zxL6DxdSu8ANhTPH3WJaw7qRe/boPBgX4qVF0BkOedbRcOMzg5Atd3jkJcioeSGbOHdxoANCiQ/
	fEl2iHm/Eee4/EiC317EVywApE3EtGkrFjLzM
X-Google-Smtp-Source: AGHT+IE6utduW+535yEDioFqrmKeyfIowaXtoHnhSNqF69KT4DRMAW5+oa67HG2s7FBAglWod2kbzg==
X-Received: by 2002:a17:903:2a8e:b0:234:dd3f:80fd with SMTP id d9443c01a7336-23823f88a80mr69721385ad.2.1750865598550;
        Wed, 25 Jun 2025 08:33:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86103c1sm134739815ad.105.2025.06.25.08.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 08:33:17 -0700 (PDT)
Message-ID: <e29788cb-1817-4168-b058-5d02332f03a8@broadcom.com>
Date: Wed, 25 Jun 2025 08:33:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Supporting SGMII to 100BaseFX SFP modules, with broadcom PHYs
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Robert Hancock <robert.hancock@calian.com>,
 Tao Ren <rentao.bupt@gmail.com>
References: <20250624233922.45089b95@fedora.home>
 <24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com>
 <20250625091506.051a8723@fedora.home>
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
In-Reply-To: <20250625091506.051a8723@fedora.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/25/25 00:15, Maxime Chevallier wrote:
> Hi again Florian,
> 
> On Tue, 24 Jun 2025 15:29:25 -0700
> Florian Fainelli <florian.fainelli@broadcom.com> wrote:
> 
>> For 100BaseFX, the signal detection is configured in bit 5 of the shadow
>> 0b01100 in the 0x1C register. You can use bcm_{read,write}_shadow() for
>> that:
>>
>> 0 to use EN_10B/SD as CMOS/TTL signal detect (default)
>> 1 to use SD_100FX± as PECL signal detect
>>
>> You can use either copper or SGMII interface for 100BaseFX and that will
>> be configured this way:
>>
>> - in register 0x1C, shadow 0b10 (1000Base-T/100Base-TX/10Base-T Spare
>> Control 1), set bit 4 to 1 to enable 100BaseFX
>>
>> - disable auto-negotiation with register 0x00 = 0x2100
>>
>> - set register 0x18 to 0x430 (bit 10 -> normal mode, bits 5:4 control
>> the edge rate. 0b00 -> 4ns, 0b01 -> 5ns, 0b10 -> 3ns, 0b11 -> 0ns. This
>> is the auxiliary control register (MII_BCM54XX_AUXCTL_SHDWSEL_AUXCTL).
> 
> And I have my first ping going through :) Thank you so much, if I get a
> chance to meet you in person one day, drinks are on me :)

OK, that's great news, looking forward to seeing patches, and I will 
remember your offer :)
-- 
Florian

