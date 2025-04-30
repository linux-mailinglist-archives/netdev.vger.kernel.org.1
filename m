Return-Path: <netdev+bounces-186959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F576AA44B4
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012AF4E23EC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF6C1EB5CB;
	Wed, 30 Apr 2025 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fJzlNoPA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40561E1A16
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000195; cv=none; b=O9wvwgUyOZv5N9hoYF2Yi0aBBKtbxX45bN2Lszf0z6RM7+pGv+izdDHJQTZdqCvzUMmCdi5EFE2kopWgPYqgYH3U66qKPZ83SPfc7xrZcEh6gSY65kcNBWXT6dbV3KpZmYVx0XeX8C8VSr6DUD6Q/OM5udqw1my1R8hzujgm520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000195; c=relaxed/simple;
	bh=CKPd5d7GgODwWG0Zm42EzGpOWxzR3VJEcym0WmahJUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwEhw0MAl5jRYwlLKVwR/ZEJ9bZJLbN+rFO2HIPp9xeYiryeusbHt6oWx9hw1BeP0kNP0DI+wdse5nSt2sD8hLB92Q9C8qZ3vqhYvE7gAVvBQZrpbzQLSQMfwaSSIhLHhYaAXlNQx+uidEO86wbzxnIjmskzZgmV5+s+VjQ0fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fJzlNoPA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso9289367b3a.2
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746000193; x=1746604993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qCAitoRkJh4jaqQ8EL2eRWDii2BkMjYoCjPZ+VGr3Lc=;
        b=fJzlNoPA/EfHn4gC1hfhxWJcm/0OlIUIMDvgAr/NLlcIeAkE8La8KmFNdasGlV6quJ
         4FMWhN9ZTm6ilHH9S93Bt3iI4+KWrvU/69yLhnzvEiLRnPvxTz0iMoL5/ggwELcudAmi
         WdLDnKenmePYJQF8VYv31lPZ2yB+8rtgPo2TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000193; x=1746604993;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCAitoRkJh4jaqQ8EL2eRWDii2BkMjYoCjPZ+VGr3Lc=;
        b=oYvTc8mqusC3gx3GWVelkDdKHZ7fTNVCHsErp3pyhesm9cWLr77nc+5BZmd2fHBgoc
         VrIFwL467aFPGSjQyFk2OkueZOTgGt603QpUdd3R6aVdRNeihctP4UteRENLGiqQxRce
         OLaTirDyO6GVo4nj7LS+bwY1PwDinJnIdRPX/4MSakNlh47kBfQ+ZxLK6m6gwRKWDD5i
         n/44hYdXUA5r80xY/1j0k0PMzo2hNFOax4/0tWszUXW9AcwwYiNV6mX24n9XYqMa65Er
         GE3SZBPp2lIJ8D3H0wx5g4tzwJro+lUdUgrJFohtxn+a8Ad2SVZf3Z5U8ziuomwUp+hi
         HhnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuFZpoIHzAVsC5JRK2assnhuGpaclTeU3nzFCZbIQydaoV9x2mU7J6USsdGoZnBdJhegFG2hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1azHHPhSSyzxT6cwwDfbowrKZb32M/kd19eh28+zJuCc4cTn1
	Z6U2iwo8nt4pCjsbeNDvA7MHL+OSegpT/ufTfmwk9gILzZSWty1uKQ2WMsn/OQ==
X-Gm-Gg: ASbGncv9eLMSuHtrTEHbcz9WiIorB1j2qlQBgt0JqYtIBzpHSSpCF4lpJjGSsXJEXtn
	zy2d7yjCz9QpgMWCiIs0KeD9p7oTR2inmVozfwG1zJu1rYW3zJv8jLJQkk8TOem6It7zDdTifev
	p9mUZrzWhPK1+mgjIWihMtNbp8DuHG5jK9GfXuEE3L6fL6IGkeCzWjkrpwOfPiLSFWKyKgqms0j
	itofLRWNNcVvln+n21ZOBgssQ/ljaG6ZBgI0fQtwuz4SJ7ZRpOdskopXxpSz/hfAZdLsIcC19XY
	yTauI4GuRxHlB2u8rHOi/vtKDA2VKwihOPpmryVIxBaUW0aKTEFTkTV0m7RJ4qRTqYbEMTwvnNR
	2VEY=
X-Google-Smtp-Source: AGHT+IHkJ0h+qoDFialSR2+zVyxAb0um5MiBW8ZJFF+jqQ44pIx0qJEDXzxACeYYKWZRGIKrusamCw==
X-Received: by 2002:a05:6a00:130e:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-74038a85c28mr3180738b3a.19.1746000193185;
        Wed, 30 Apr 2025 01:03:13 -0700 (PDT)
Received: from [192.168.0.24] (home.mimichou.net. [82.67.5.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7403991fb75sm1019255b3a.42.2025.04.30.01.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 01:03:12 -0700 (PDT)
Message-ID: <33e87dc1-17a4-4938-a099-f277f31898fc@broadcom.com>
Date: Wed, 30 Apr 2025 10:03:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 04/11] net: dsa: b53: fix flushing old pvid VLAN on
 pvid change
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Kurt Kanzenbach <kurt@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <20250429201710.330937-5-jonas.gorski@gmail.com>
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
In-Reply-To: <20250429201710.330937-5-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/29/2025 10:17 PM, Jonas Gorski wrote:
> Presumably the intention here was to flush the VLAN of the old pvid, not
> the added VLAN again, which we already flushed before.
> 
> Fixes: a2482d2ce349 ("net: dsa: b53: Plug in VLAN support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Does not this logically belong to patch #3?
-- 
Florian


