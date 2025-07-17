Return-Path: <netdev+bounces-207998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C6B09439
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748465A112A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2220F062;
	Thu, 17 Jul 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZgvUNF2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95311EEBB
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777879; cv=none; b=CKAQRmVycFJC/jcZwOvXS1n+/MH9JtOP661uebZK4MBlc2EAZa+jsfaDsVweUcnK/nKw18T2ynL7dMrntEtZAaf141Mg+9ZlkdlVYjzF3PrBYBjEuy0L8QY+LO1U1y/6WKyBWdsXAViPATkQgoEVbX3KiEZLu0PHy8gtU0m2B5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777879; c=relaxed/simple;
	bh=xGlI3e6pYE1mMv4bY32T8HCjhpVmnuuxq0VaZqhvhHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkGdJcU/7NbpoofutKIJJ1rrpIfsmWCpfHIs3gslJXlmh7Ji/MQLL3zf+6Lz+OgAL119A8NhREasojR+q2H6S34muvrwACl8z8R5ak2SOontSjuNIPj1piapS6dDA1StAr+Fz9YPslzQAt/xdSKka2hgdH2F2713vNQBTPFtVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZgvUNF2i; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390d09e957so1416583a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 11:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752777878; x=1753382678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dz0RcE6tj1fnhqir0JS8lXH0arU4ZBm5l2MKTUgD1rw=;
        b=ZgvUNF2i72jJtsnwm62fLLIc44g0qSU0ZgkrjGTf1PDXfTp2ZDuAsTaOLnkF01eATE
         9szy28U+PPPIBcOwvkDABwufMaKB0SX2mUbsMCwtNPwMQU3NBmhtteQ74ejJ+wf1n4zN
         s5FGK/pOpbztXPYMHuwxLEvC6LPFgLKgq4Hk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777878; x=1753382678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz0RcE6tj1fnhqir0JS8lXH0arU4ZBm5l2MKTUgD1rw=;
        b=aTsmPP9ZDPGXCx+++YMOtJdrpfZoy4sBVF0KQ2KgKnCJlIIQENmQSwbu4m0RAjl/US
         O8LcsMrJTZmzANmval4xTJ20/PVHgTrgvR668a2g2KVYAJWuk9ERs+Rd4JeZsQA5jEjG
         qu7DnZnyN2bP8tv+nfX11NyvK3OfHOgT52ZsTWhuv4RDsvFbzRjo0DsySE0+LjkJlhX7
         Tzaaij6iTsm/Nks6jjDG559wqHbgF0hDPokoHXbJMMPLEedPCtj2wazHHShzbC7RMBNw
         oWZZGi+7zd4C93sk9qcXCk4rdYTc5CbvfvnQLQowcIWM8xhKS/PsWDJKJd5x7vRi7wq3
         lplg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOPFIeIC39BDe64GoKEBofq4nObCSFkswUN97fa1XzAXeKFIE9bnZkxGAYFY4y2Kloyr7D7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc2R/R2ZhLhRgdLNZRSNiAaHr59FwozNlFTs4w2iR+z8w4XQbY
	vS030lwlP87kUHMecnwPEVq09nyi5mQH0v7BdVsygDfaOQpLDP34GkstujpVwTeXsQ==
X-Gm-Gg: ASbGnctD/WfKXy/GV0p2ly08/YemAyrseCUEqpCTRqEGzS9qyYZMQ3rHLeZFDlFWFv+
	xVq5DXuzd4L4+iNZ1abM0kiInI5Zoc6fXSam6WpE2r7q8C5FdBGfT23sgD6MLxVpm8Bm7up0508
	yeWEJcigoKw3r6iASg3CIEjmQIafdQ1/0j/IVysr3HSQMHRlOJe8xap1wKPpJAZ9CpMFi/7Pq1m
	8I1zdN+R/W1KHs0aaSwtdW9Ct1EdDEXu4jgCcP7x/Wh37VJ2lkli78xfwlSm9rq5JGkaC1K4cSl
	yVHq2unK7Rklr2ayj/ync7yZcuWPR25NxbFkxtj8EiKYUt+c4Pp4mMlEXyuctAiplC6ByBn8o0B
	yVsK/aYYyDzRfOvRqRBMDghsIZJRFR7vGQ8VTTHS4lI7fmlj2hKCRDFKWbh6Heg==
X-Google-Smtp-Source: AGHT+IEBhQt2uujaZwROZPPGQbP5DBLdcsR9yUQ45ddDaqZHkBe+5MHAvMIZHW+xy3ygWi5X9KnRcg==
X-Received: by 2002:a17:90b:1b06:b0:311:f2f6:44ff with SMTP id 98e67ed59e1d1-31c9f42400cmr12159870a91.17.1752777877881;
        Thu, 17 Jul 2025 11:44:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf82be98sm1934461a91.40.2025.07.17.11.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:44:37 -0700 (PDT)
Message-ID: <c1622302-4fde-4e4e-a77d-2c912edde3a6@broadcom.com>
Date: Thu, 17 Jul 2025 11:44:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] net: dsa: b53: Add phy_enable(),
 phy_disable() methods
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com,
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
 <20250716002922.230807-2-kylehendrydev@gmail.com>
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
In-Reply-To: <20250716002922.230807-2-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 17:29, Kyle Hendry wrote:
> Add phy enable/disable to b53 ops to be called when
> enabling/disabling ports.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

