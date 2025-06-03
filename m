Return-Path: <netdev+bounces-194851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B1EACCF9F
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 00:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46627A96E5
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0075D25229E;
	Tue,  3 Jun 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jc0zGUHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914824DCF9
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988609; cv=none; b=hflLKFo6v8V9jzMCW47fbp+mp3CvpXTVUK34UuQZI9EnXv80C46jRDIWLD+bNjA36OcmOosx3JZ65QkNF+JrSFU45sLr9jHH6DnrZECu2d87PMQjKsCXwlNickPozOserMMgCQlQNj8YYFcFBz2M9h7JPRi66W9HgvNZpQ7ZppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988609; c=relaxed/simple;
	bh=D4BNPFyXw8YmMxTGf0cIhoo97jch6QwsAvNNNQZDsQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NXRJPS6vclM10UQg8Ojima/X4CQGhr8cj4Cl3hO7prg3vC4aW4AkScmooNQPDuWSPjtHC9fh5Rk9hqtiAgdn21ciOp97sAlOgXICwYbAZwAWzS6DGTdXmptiUb5J3Arii/FaJsExEjhXApKyo9FLm1R4zWbzq/gtcYvRjkiCxbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jc0zGUHO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3127cc662e2so373891a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748988607; x=1749593407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oCZ69tNf5F/nH9gg/JK+KCJHpj+nRd8zzomueksqFYs=;
        b=Jc0zGUHOBWmKBiZM0ui/g1Sdqh/YVt9g17mUCgnPTOe1GpknzfIq3KZDPNh2vn2ebM
         IxxrhsEf6BjzTNKtdVSP9Fx/9XgID9/ci9F6yN/VNAxHGB31qzImfEGl0XP7onidbnuD
         ayaEqtDOsvLClgRtendsOH9BNmjYqiXB3gAwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988607; x=1749593407;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCZ69tNf5F/nH9gg/JK+KCJHpj+nRd8zzomueksqFYs=;
        b=aQIXOis8cM28Q0DrUpU29/i1V2DO7jJqqVC9OekYZXqio+Uw/ZRLd/oBJG2mXiJ47q
         jkpfaiOZ0aTVI1Qn75AmgkSsZV2IhwnbzaVOC437xrXZ4LAFzBukwDqyQBZsPkeT+7hl
         rNsM41Y6qPiUjbRxCrbj/8ArBIAIjXyHDTEzNIm+AY87cX1YWj4SQNGeQfkKLD5zNoeL
         f+ODUVodhvCXae2RzQuVBbLWg5lo//ijOB++eYF7DZdyY+sHMLyQKQTVPwPJPRoIIat0
         fUWs7sAAnf+2JxQZhxP0mOr1cWMhSqFKC3AjIaO5UYVCog2XhgjHLR1Jt3hL8Cc4XgJF
         s6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVekP/jx4BLD6gRGeu3yNjX17nMVzs/gMtcODfVLRx5Uc9ZTEFEMVFfugrMC1Tb5uFR98+qv9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCRaHgMW4F6xeDieAlN/vUVz8pjtUPDPkIqozHmaTioZg4Eab
	9/ittp95HRipsc4+e1KHaq5fsTF4qfeLshOPIyVfQmmfoJjcDt+A/tJgE7rm6gHkRw==
X-Gm-Gg: ASbGncvVgzEDgXXIsre3vuqW8CbU4QqRfhxa9VdUNyxfO8XeVGlr1LBtgEs7L1IO293
	NHQEtGKiGAXtRtjumtHSXkdDPQWWaTs6pFSffbjB4EK4syiMXuoXK5W8314wPyxa3IuzBCbDYTH
	2hFxhPQoGbt5B1Xak9OAbi6PtC17SmzTE1ehX1agxXbm/tKE6X46maNaG+WiI1pZzQSrTlBEcHU
	2QbtrgGMNCIaSnV9nslrum6ffnTY7tdk1uSb7Qk9KHwkijbmJUPlXHr48sZ031ZWbdbwSSfQzGN
	yWSZImLoM6nDkx2GhRG6nBOUPZzX8EBnXCUS1lxoOzKkm6xM4IIU3NQ4tnW75sItBig9CR1RaNt
	s3/83nO/D8+X5hrPnlk/dmEbE1g==
X-Google-Smtp-Source: AGHT+IFUc2/MB2me6Q0F4p+ojx6fjolGHIbVISR6ynDA5066KSNqwO5Jisc9OWXMc0F8jOKyYsadJQ==
X-Received: by 2002:a17:90b:5112:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-3130db414dcmr805466a91.5.1748988606871;
        Tue, 03 Jun 2025 15:10:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd945esm92372945ad.94.2025.06.03.15.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 15:10:05 -0700 (PDT)
Message-ID: <507a09f6-8b6e-4800-8c90-f2b1662cafa2@broadcom.com>
Date: Tue, 3 Jun 2025 15:10:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 01/10] net: dsa: b53: add support for FDB
 operations on 5325/5365
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com
References: <20250603204858.72402-1-noltari@gmail.com>
 <20250603204858.72402-2-noltari@gmail.com>
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
In-Reply-To: <20250603204858.72402-2-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/25 13:48, Álvaro Fernández Rojas wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> BCM5325 and BCM5365 are part of a much older generation of switches which,
> due to their limited number of ports and VLAN entries (up to 256) allowed
> a single 64-bit register to hold a full ARL entry.
> This requires a little bit of massaging when reading, writing and
> converting ARL entries in both directions.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---

[snip]

>   static int b53_arl_op(struct b53_device *dev, int op, int port,
>   		      const unsigned char *addr, u16 vid, bool is_valid)
>   {
> @@ -1795,14 +1834,18 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
>   
>   	/* Perform a read for the given MAC and VID */
>   	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
> -	b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
> +	if (!is5325(dev))
> +		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);

I used the 5325M-DS113-RDS datasheet for this code initially but the 
5325E-DS14-R datasheet shows that this register is defined. It's not 
clear to me how to differentiate the two kinds of switches. The 5325M 
would report itself as:

0x00406330

in the integrated PHY PHYSID1/2 registers, whereas a 5325E would report 
itself as 0x0143bc30. Maybe we can use that to key off the very first 
generation 5325 switches?
-- 
Florian


