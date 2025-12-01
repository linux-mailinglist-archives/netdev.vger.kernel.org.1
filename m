Return-Path: <netdev+bounces-242862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A495C957F7
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 02:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33F684E02C7
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 01:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838C26AC3;
	Mon,  1 Dec 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8M4cs8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199CE36D506
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764552650; cv=none; b=ul+ZKv9ME5tzF60W1eAE09lQJXRDy7dul2fd0+dNyp1c0Bkf7lqfr9w/f4St2gxZbJhrGCk7wkxDUNQRYRNcDVMFHhAPgQF0aSLfxnl+p3fDQrIzaGNplnkl5a6KdTFT8/B3+twt8EUQXuQQQGwmK9W+Puabgz6IpLR5VCWjtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764552650; c=relaxed/simple;
	bh=piQOEK0cDM1LBHLtjgs+teU/vmM2O3U7Bvgz2QoDAnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuLYaUJeRR5J3lKB8rm71XRVLk4z3IXrAUIMuzYF3CJnSeJWLohUM+Yow/6B7OPAoIQalgQRi1KsLWlY/SNdAjHoEO6hNQIF25ATHA7Lo87becWIVC5n1ZrTD8DJMFwwW/XBd/Zxjy/SA4r39PuBigO9j1/Y2YFVGJ/C6TqAaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e8M4cs8T; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8b2dcdde65bso528936285a.0
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 17:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764552648; x=1765157448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xbJ0l+S1i01Zhel5owcePrGVpD6V+nYds8aoAxAmik8=;
        b=GrEB5USs9iuxKr8Bv0Xxn9ISy3RpuuHaaazbrxG3KO6RBHKtTvH0PMvpOYO8K6GVbh
         ubYKl3bQTIwex7hXM8NL+rKwsYWyXxJu3WWVX94ZnxCe00JDIj89rrw4MNvk/t5Bl4sD
         H7BFgzlrwRM78NXt81Krs0XikyDf425RDehiGqIpKoHRdvhYTyR8qHl/YtyqOYCGJ9Fw
         d8bHIMRVRH0XHx+leVCVyLhtT4aNYerES2u/oZOeMdJmGnuDRr/Of314PSu1B/ovp8k8
         u0v+s3pp4oBOQkEc6caHANNLxlO742ixr8EtLYsmdOl2YRaGd7gb7vxXzxTt8MedzVoG
         +nSg==
X-Forwarded-Encrypted: i=1; AJvYcCVukJnmhszUlzt6j6KJUZu8Kv8gqc5N6V3qCheUBfZnj0eZk6h/94cn2hivpNhyIYB11CwHvFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkFktdhDrACjLaVdK7aGwZKqTsA0X89X0KqQZS3hCKaLPNMv0
	JpDaxbfL7u4BQHB0qMTfE3OL5F4q4dj6pIMbIjm6iM2nFAjW7BtWK6MFS2YKyyik6KgLJMM4192
	VWiVXaPAlQdAd1oc9zuOnERLLMENajvzVkeI7wl1xKGpHyLLWsofWEJ2YepJfSdXMpoHLYCvNHd
	JuFTf3cR7FgWm46uqwMhbQYerihO4+8DSB57YSuK7X90r3Vt9tuuf3mtErn7yQygAE/oaXGtUwG
	ubv6Oe74NWaKaGR
X-Gm-Gg: ASbGncu/iGiaqaLzYkpHaGEl8IubbiRnRvFKohfpEerygADZfByY+TR/T97VEtmRhkO
	Usw148LdO4IlrlcZ0BW6qszrhlwWUH5SdRGInwjyENdH+46VKCrfpbOWSeQ6Fmij5Z5z6/SaUQ1
	Idnn4U8V02gxiPWQbQC2SN6RSosWP+3JEQ8QidWeo2aHZjLvkdGqhhu+gfnpnZbP6EWN475U+pR
	gz/FDqCI52kBln/6liNlMPM+/uoZaVqwRVOn13AOzrtmw+nzW2JVLXVTWpT5GmXxveKU9oRF33t
	1Zc/rE+qdIQFJV98s/b8qxYXmCCeI6lfSi6NkEaljEQKcAS0vtb94lG8t9N18dk5E2C0RFEWmCp
	NrmeZn4/KL49ErpesjlZeeSpdEr6B81ceF5IPpBZCmH/gekm2pZJZJSEM4NS8PhtzO8zlJ8oOLL
	MW952CgAGTMdnUL0IWlqd2POHC5FeQpQEcW80pi0YS00cTbtCjtecf
X-Google-Smtp-Source: AGHT+IGVtf5VnW1/F2yIrcsEX+bXUIiDhla+FvNB16YsAdBawngscOTGJ0JaZh3XrRTvr4qiNePENmWd146I
X-Received: by 2002:a05:620a:1aa6:b0:8a2:fbb9:9b71 with SMTP id af79cd13be357-8b4ebdbebc3mr3024634585a.69.1764552647888;
        Sun, 30 Nov 2025 17:30:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8b52a1aa4easm106376885a.7.2025.11.30.17.30.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2025 17:30:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bc240cdb249so3173360a12.3
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 17:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764552647; x=1765157447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xbJ0l+S1i01Zhel5owcePrGVpD6V+nYds8aoAxAmik8=;
        b=e8M4cs8TZ2L9jVfFYjDRQb4QcCnRwgjzGln2VxP+18jabwhjJAA5OzxspcZtQujd//
         4haKU1z2Byucm9u90GbXCRaePhoEwe3PZXOeUgnQqjIE2Pu5tqYWY+XeqRgpGKbKLUje
         rbKxEAxd+o/3ajoMRHj3zGkSnN9kDdKzNgb70=
X-Forwarded-Encrypted: i=1; AJvYcCVRRORKM9/xrxuRvJOKsBOdQqwcupGDr+MOoG/hnka3mMtuqbiZueAKOkhByCoJ4XqdZdQe1EI=@vger.kernel.org
X-Received: by 2002:a05:7300:230b:b0:2a4:3593:4678 with SMTP id 5a478bee46e88-2a94175510cmr17605370eec.20.1764552646485;
        Sun, 30 Nov 2025 17:30:46 -0800 (PST)
X-Received: by 2002:a05:7300:230b:b0:2a4:3593:4678 with SMTP id 5a478bee46e88-2a94175510cmr17605355eec.20.1764552645976;
        Sun, 30 Nov 2025 17:30:45 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b47caasm41647049eec.6.2025.11.30.17.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 17:30:45 -0800 (PST)
Message-ID: <0f716fcb-7447-45ee-bb0b-c61f5b23d53b@broadcom.com>
Date: Sun, 30 Nov 2025 17:30:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/7] net: dsa: b53: fix BCM5325/65 ARL entry
 VIDs
To: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251128080625.27181-1-jonas.gorski@gmail.com>
 <20251128080625.27181-7-jonas.gorski@gmail.com>
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
In-Reply-To: <20251128080625.27181-7-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/28/2025 12:06 AM, Jonas Gorski wrote:
> BCM5325/65's ARL entry registers do not contain the VID, only the search
> result register does. ARL entries have a separate VID entry register for
> the index into the VLAN table.
> 
> So make ARL entry accessors use the VID entry registers instead, and
> move the VLAN ID field definition to the search register definition.
> 
> Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


