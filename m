Return-Path: <netdev+bounces-229329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240E9BDAB94
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D45BF420204
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427830499B;
	Tue, 14 Oct 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QpKy8WV3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC52877E3
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461151; cv=none; b=ky3Ul04XoikI8VSuyuwMcotJbLLZfnOTPLzzOWDOpw1mSU3EWAvzxGO/W/Xl/t8wyHwGkj+YEDk33A8HQ1JKYjLttVWGSA5d1rf1ScVVrPaKokLYyCGeHSEC3ejDi5IItpA+bHDyKjcxAhzXYmTRf2IyHyZey1fNA+YQwcO4zu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461151; c=relaxed/simple;
	bh=To36L68Q0mUcwL8pOkN58X9S9RZywNsL3f8N83RmpuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhJm0IN4dl3cIMY7zQhCd/yUEG8JYauZ3XK2wIethkfPagDY3AVBKM/1hz0+2kGXozw1yy+lAdLZJNC1QMLMlDvjcH4IeZY6/9QWoioNz5DuRClGGyIUAHv3tF+c/GU9ZfwKwSH7rePHkSFxyylrgTZhJad5S0AsHVSjxNJTqx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QpKy8WV3; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-43090377002so11531015ab.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760461149; x=1761065949;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWtozxGU539f4y/pKveHBCk5w7jMKl7bA4+WO0yn6z4=;
        b=XoW777Fu+0MYnUUshBNRMtT26M8+7lMxkcLrK6F+dAw2097ZHLfmDSD2MIa8f3+w+q
         1ux5x8LFoQi2rc35jpP7cIKU4A8oym7RkpJCOr43+tpGi0j2NKL891n7F4fdTQ/W4hjy
         dZ77UZbIB9vz9sLYMXJHEAD5eViocIjvKcHvCe1txkZXi3IrILTEsbRcICrNufYQPYn+
         9gRYUK8TJVoKest4JreFkN/LLMwLCU7YoPXTwL5oyAAdmPofst75U4wZrpBRedaKvpni
         GhSeSWAZn4WFf5PfTEteim5lUGtJ1SeEIakllYnEBHZa+yQ7gVWng3KEOHYTdbFreck5
         WKLg==
X-Gm-Message-State: AOJu0YwcwoIBcc6tQz+6CEGiUHv9quN3J0GskfCI6rUSP/+xPQUCUJ2O
	+8yMHE5EWa4IMCJMd8Igo2bSFbqaOIOwC3uvjt4+7FX7lIoDXtbqhlyVxgehzOOE7gbL6rn631N
	nhW1dqFAw6ImLuq99LNXC95+4QySA7By4o7VjaEQW03SGag9zigpFRyn8+jYwKnSqIWYnLbNg4j
	9L25nIKei6/7UHvS7sYjIUqiCKmGW2raLHOpgGrBEFwThSq/J2aWllsUE9GEnPxV+/7R4SGI+3k
	iusHWEPOiRBzJWL
X-Gm-Gg: ASbGnctqm+/pEEq4XHldblj2Lvxx7Vo0D+B96qwpO/ozA2DTfiZ8SFuYYneOdxVluUP
	3lAngJOnLdRwybLOE4s942ZY6p3Ym7Y7rLo1tYO7qVSF2D53+oi8GZh1wr7OeppQGaTdWSKNtCM
	OB/Vk7b5LgGVctMderhpuDTvj/Hv+rkmwJKldtKQQkFjv8zU4+7qDlHEw23EWt1WH3R8/qNpkpx
	G7edgtrR8z6nVC7MyQjNw5bFzLCl/q+LLQBJV+NpFR8HHvtUW1+bLaiVw7TKV4zuJRMM1ioMgsx
	L4RSB9HN78lyLsgp4n3iIKlifYTj/XgUR8U6UlQt0q63VgwAxMDzdf+0g7hxvtOea4EBFzvi1el
	DhuGHX7q1k5qkgGRfNFo13dNiXynJMH6g+fMu2YHWdgByRg9+SWVYA9S/i5+QzRmaT92a/VcqjK
	2JeQao
X-Google-Smtp-Source: AGHT+IEWWqXz4j871fVeeYEA45Nke4bB5vH+aHE+ED2d7GjvTml2LGGP+0a45UGFTJEiRSBE1VT2JbgBBWsg
X-Received: by 2002:a92:cda2:0:b0:430:a550:3003 with SMTP id e9e14a558f8ab-430a550306dmr29194905ab.14.1760461148773;
        Tue, 14 Oct 2025 09:59:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-42f902438d4sm10267365ab.4.2025.10.14.09.59.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:59:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8645d397860so1205614985a.2
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760461148; x=1761065948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GWtozxGU539f4y/pKveHBCk5w7jMKl7bA4+WO0yn6z4=;
        b=QpKy8WV31to6mVAQUhVFXefk3iPkB/KPJxmYxhzogi2Mlr5PRPnY7omwomd792S1pD
         AYEzyzmyNRPtDrZePNOOP/K3AvygdynRE/jO38p9Z7bzLQhjgFdIzNt9AebVuKs1GD49
         +ncTNdGGfJ8yelSfbbXfqld4iSykxfr5bA+DE=
X-Received: by 2002:a05:620a:a1c2:b0:88b:72c0:b348 with SMTP id af79cd13be357-88b72c0b61fmr310047985a.87.1760461147888;
        Tue, 14 Oct 2025 09:59:07 -0700 (PDT)
X-Received: by 2002:a05:620a:a1c2:b0:88b:72c0:b348 with SMTP id af79cd13be357-88b72c0b61fmr310046185a.87.1760461147527;
        Tue, 14 Oct 2025 09:59:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f2e1db1sm1245622685a.4.2025.10.14.09.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:59:06 -0700 (PDT)
Message-ID: <2a6b84ab-f482-4b0e-b696-f20be82e7b03@broadcom.com>
Date: Tue, 14 Oct 2025 09:59:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmgenet: remove unused platform code
To: Heiner Kallweit <hkallweit1@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
Content-Language: en-US, fr-FR
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
In-Reply-To: <108b4e64-55d4-4b4e-9a11-3c810c319d66@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 23:02, Heiner Kallweit wrote:
> This effectively reverts b0ba512e25d7 ("net: bcmgenet: enable driver to
> work without a device tree"). There has never been an in-tree user of
> struct bcmgenet_platform_data, all devices use OF or ACPI.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

