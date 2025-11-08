Return-Path: <netdev+bounces-236920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B047AC42338
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 02:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3163A1883A38
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F682D5924;
	Sat,  8 Nov 2025 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JOueGdU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122E2D2382
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563966; cv=none; b=NMeOKLouXIvKbpyUdYOliEPQT4S+sIBsJcuNLTy2PJ1vLCZEM75IB1W2NE0q6axxKt42EpbXD2hCUj2DfHexp4U5KTVGZwLOTbRVrWUqP2WbEePVPbBeQuyolA300jNFP+rhFmwuROd4fLYvyjpZQPENnZSEyr9eVVrFK/IpRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563966; c=relaxed/simple;
	bh=KWpNQi/bHHa6DffH2BEbO/AqVofAjoVXDyGXXyiGsJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv2fZcXQblj4jv+gzi+f5glXNXkjiw5GmySIhUj2Ap27kdGx7WNnjdA81VxCosuiafX/maaTKT678k+IBh8XrmJlf3aAlDqMKiqlXN0wQB3WVd6F52pHh4xWM7xDzFTW8mFZhY3fappbor1I5C7+/UsgjjKD56EYrOpN0YBgM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JOueGdU+; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-292fd52d527so11773825ad.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 17:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762563963; x=1763168763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lhMCLmx715s5gpkIWtPdjgc5yLnvCm4NO5ZRwIFijA=;
        b=oYKIcgofpUICLPVd/olSoprfXnm7Oa9kAR/6glwbNVl1Jw6TNVz7UY9neBAn8s20n6
         Oav4jF7GX9vFm9OGcdntExjSuGfSBT8LXY7RPuTXisqT5op0+os6x7QexZzGA3/w/zoK
         USRZti0/QOAzB1gkjHUVuNJEeTgj+IHIjX3kvJscwMUun17yDUyA5qdoYrteK2Ut0RAC
         5YuXm6JIxPM3fpDKncfBWJJqDSa/021+SADj4EPpiUJGrqneuaoLBHn9SZyGyOJZFO1P
         0984qneIcIBY6Lv7WayirzH0pHw5UkkZdH1myt0o5UtxiHiGcPjpy/sy8DGh81Y7lxE6
         Sa/Q==
X-Gm-Message-State: AOJu0YxRxTVLRVLo4IlUgQFU4agtqVWgR1+Hu03tYynW/WFJ1lz4O9Jn
	6c+57XI1rSasQvZSrr6x8qX6BduGrj2qP4Xe5lm4C7UiUQ9TN4QEs3F51ceK8QFqBkM3O7qyyKH
	gs2MYS/v0vYipHnSBhzLgn1HvxHBOxqXx+hoKYWSb++qAsx2+/FobiC3hj0XEcvlMnecaa+HVlT
	/ZAqY1cR6xh1ltrPgYHKHN2FjwWrA6dHV8wglPI6237rWqX2w91Uverow9Q/XxqU/SUrkCb7sJA
	tTYGgZ4m+yKjWEN
X-Gm-Gg: ASbGncsd9gaKyr8n5Mo1mE5aFvQSmeWI4f8+DzlBG4BmRVhPekgIna11SUd17LYsjNE
	dX5p7UiLl9EzjX9Sl7Gyr7ovnCj3j6eK3Q3/5fvj0YrnDHbFU36WnVGg2dk334m3FHrV++hLy8u
	PCFwKtadcf3WHzdos4dzWXxaMm3mjNLdj9kw0MshprICLOyypHBV/HAKRbjvi8YnGURhTJtkoGn
	9gxsUL9T9QRnbPnKkIxENVT40jYW55yEQ/2OvfyykOOneGiqCzyNd1q6f/4mbgh4VMtiG+clU3i
	xHZpfsJItyYWlnzpEGO6KTxT1m1tefs1DFx1S7h5zcJNeLNNY8kmF0VItV2Lj8JYLLrgLFwSoFM
	AgkJ+7KrfTlk4rZ8BHtB8j+zRqK69K39+8JCBG3tvhrRMf1qirpeZN26kxOdESMW59HHKjTT1ab
	JfVZvUkG3rDRBUaSSBi5ACC8MDoZH7UQ74T02jieU=
X-Google-Smtp-Source: AGHT+IFCW+DqGZ1fPXgmP99rKrc8z7MZ8l7TAOyP1nwDvZN7ikPoIKkCLrfn5img64dneED9zgFKKW3Efspt
X-Received: by 2002:a17:902:ecca:b0:294:f310:5224 with SMTP id d9443c01a7336-297e56be16emr12429045ad.29.1762563963441;
        Fri, 07 Nov 2025 17:06:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-297e1da7310sm999095ad.38.2025.11.07.17.06.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:06:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c6d917f184so891244a34.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 17:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762563962; x=1763168762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3lhMCLmx715s5gpkIWtPdjgc5yLnvCm4NO5ZRwIFijA=;
        b=JOueGdU+ofpzceW3ZQuGeZ0LAEDoMl9hubK62+hd0tjCgW81rsQWZ59l/UTcLvZwjf
         yDgyq83ES8ldM4mg+VpC+vnI24vgxWFUAMGDHj/4jcM0oJBKKAhaakBtJBqMlspCQJfI
         d1eSVR+3BmlAyJkJ4N16p3OuQHm/osaK7Mfgk=
X-Received: by 2002:a05:6808:1801:b0:44f:e850:18ac with SMTP id 5614622812f47-4502a3db3abmr719190b6e.57.1762563962089;
        Fri, 07 Nov 2025 17:06:02 -0800 (PST)
X-Received: by 2002:a05:6808:1801:b0:44f:e850:18ac with SMTP id 5614622812f47-4502a3db3abmr719178b6e.57.1762563961737;
        Fri, 07 Nov 2025 17:06:01 -0800 (PST)
Received: from [172.16.2.19] (syn-076-080-012-046.biz.spectrum.com. [76.80.12.46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57ef2e7sm3137695eaf.18.2025.11.07.17.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 17:06:00 -0800 (PST)
Message-ID: <f0fbb7fc-d776-4507-b686-4cfe280099d9@broadcom.com>
Date: Fri, 7 Nov 2025 17:05:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net: dsa: b53: add support for BCM5389/97/98
 and BCM63XX ARL formats
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/7/2025 12:07 AM, Jonas Gorski wrote:
> Currently b53 assumes that all switches apart from BCM5325/5365 use the
> same ARL formats, but there are actually multiple formats in use.
> 
> Older switches use a format apparently introduced with BCM5387/BCM5389,
> while newer chips use a format apparently introduced with BCM5395.
> 
> Note that these numbers are not linear, BCM5397/BCM5398 use the older
> format.
> 
> In addition to that the switches integrated into BCM63XX SoCs use their
> own format. While accessing these normal read/write ARL entries are the
> same format as BCM5389 one, the search format is different.
> 
> So in order to support all these different format, split all code
> accessing these entries into chip-family specific functions, and collect
> them in appropriate arl ops structs to keep the code cleaner.
> 
> Sent as net-next since the ARL accesses have never worked before, and
> the extensive refactoring might be too much to warrant a fix.

That seems entirely appropriate, thanks, I checked the 54389 and 63XX 
datasheets and your patches match, thank you!
-- 
Florian


