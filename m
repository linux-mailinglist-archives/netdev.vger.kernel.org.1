Return-Path: <netdev+bounces-210199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8797B125E6
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DD05829E4
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4425BF00;
	Fri, 25 Jul 2025 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U7EZOvUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF2257422
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477063; cv=none; b=uJNm51uK7uY3tWS1h9GEr09vaNHUBEfsf/AHqlFZ75yClFdecjlwvJ5WSpR5lOF/5svAdhZfPq2gf5BlzoKNlx7kKrGBf6tDUgDYw51GKU5CNHnwyzZYuwXEry5tD7EEbDhKXGoCoc0oz6VHlobyvMd6riD+3ImaykKEMZR8TuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477063; c=relaxed/simple;
	bh=i1SInZSZ3Aij1TOax4En7Zb70JBvQcgJ2i1sAnCTRQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ioc4xuMNXAA2TC/BhhqHtuESRSx/5wGL4SvC/egdFC2y+TPio5QQEMyeVH2KVUyozxdyaYRUBIx+g7ZzMUNXU3Cd5ADaF+JTD6sbJj0VtCcACFTDW8juJEfvLUIoywP0ueEwGT1+lCjMAYqPlb2U8x0zQXgo9hKuelvA159Bkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U7EZOvUu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7dfc604107eso227175285a.2
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753477060; x=1754081860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BhcAKc/lFnecwQoRDpNFK+j24zTiKcV1kJ67oFCXCNQ=;
        b=U7EZOvUunmqchs4Bih1J4IqnGimYDuWuJKz9gcMxsKKvme4EGK+zmejM2AS/DuIts6
         niJCU4imrIjJ//yGgrQ1hcXHYXG4jQ9mQESoWImxP308yRYmOO6rDiG1o2jEHLVNoibe
         hOvVzb1eusQkWU4Wxj+wiad/DWN5FZ/soU1/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753477060; x=1754081860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhcAKc/lFnecwQoRDpNFK+j24zTiKcV1kJ67oFCXCNQ=;
        b=vqrlfVUiJCmNRR42Vr44jJx6h9/btY4ovFM4Sufgkmgp3jrZmbe9MQ40oxrugIpZD4
         B6edhZiBbUmsndpXISd8eZy3owT7Ieb/1nuCNao4hx0UkCQbZ7t9+OdDsxbWvahuGAcj
         hByGDPLiu3tmVp2uNWOyXvf1w+h6q3pSCBT6FrvbGbWjysOJ31tBnyU9q+BHZsf2UcXL
         g07Rz1Dz3pTLHk2161KZjvqhgFHDrcxMrdUGYDEF3VuvmfTch+Fs50pkFglFE7vwQb5s
         citiPQJHVBuON+NeyvKvgdqTcU3Cdt5nzjdrnfMqsZuPwJtetJTmVU3Etaweuw296hgZ
         Z7xg==
X-Forwarded-Encrypted: i=1; AJvYcCVVnaNCab2QVDSH6ByQpeRm6q5qjzjB795ZTIaqmHlPGn7piqFm4TcgDyxyMWsShGSN8fHWNv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+DmO26Srjftp5495KN+EAEn+HD/mcU6h/rLiR1QHdAD0jmvSV
	qqmcUaEa5UAyfAnbFVreodKQBgfRD08HC/9kwXa5XUf3HZBSabq7jdx/2xn3Uqcc4w==
X-Gm-Gg: ASbGnct+z8kyRdfjoRKg9LW7S17HvQ0ZZivVhLtDnPfPI53wdMOSRuN844802wra7uO
	TzWyb83Xj/TEb9Tz1YzaLlqPRqrseMLQqwUJMXoL0l8gRr5VbnaT7LLmim072QUiuJex0Cr1Myu
	Du4q3yXS49r+fJEi4DS7V34pGCvZ4fhI1mP8YvcOuZK6/KNykc04LMxVNCecySn99FiZZxD1xMS
	5OvmbMw4H1OGmrXE07feDLFO5k22XoOQ7e35WDD3qnKfqb44rOPJg04YN2o3Z9Ygnwggw+9RwfG
	cLeKDqZPdZkvAX4l1AkY3xW+Woxod3h4aMDwcp9WzDPAYdpX8Ky3jYLxO0iorOhvlTdJE+7o+kd
	OziAy4Ap/QFDkVegs9NZvdXuaU9k/MKIHkFE/4Z9ud9GYPaORVx5HvnI6XafKiw==
X-Google-Smtp-Source: AGHT+IGSk+fQagwNXlIgc5cyTCUAgxARHoH3svbzqgtp+j3+Fj5S/N0766hheU5jCRWrCy0v6lE8iA==
X-Received: by 2002:a05:620a:4115:b0:7e0:cb93:6fb1 with SMTP id af79cd13be357-7e63be38459mr458299085a.9.1753477060154;
        Fri, 25 Jul 2025 13:57:40 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e643879396sm39834785a.64.2025.07.25.13.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 13:57:39 -0700 (PDT)
Message-ID: <18831882-80cf-4414-ade4-cf02a943155b@broadcom.com>
Date: Fri, 25 Jul 2025 13:57:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/7] net: dsa: b53: mmap: Add register layout
 for bcm6318
To: Kyle Hendry <kylehendrydev@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
 <20250724035300.20497-6-kylehendrydev@gmail.com>
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
In-Reply-To: <20250724035300.20497-6-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 20:52, Kyle Hendry wrote:
> Add ephy register info for bcm6318, which also applies to
> bcm6328 and bcm6362.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


