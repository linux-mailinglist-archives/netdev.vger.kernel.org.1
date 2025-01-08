Return-Path: <netdev+bounces-156368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACBA062AC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147233A6138
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02D1FF608;
	Wed,  8 Jan 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JojYbeQX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19A19AD90
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355200; cv=none; b=BkCW7AqtFLykUH2xUaeS8iRBETDM5w2g0mwIpjnZsPMihq22l3fyRUnZlnW3DlM4GogzgEk0C/p6GEq/n8PhFXLmQtiIGJJhKAzaCsNoEhW3fb2exoB3KVlST4FAyo+HOnSD6Ck5/sCMJQbQQe0mxLU1mldVlDAjRyexgbVd22c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355200; c=relaxed/simple;
	bh=FhUGOusxWjfKCfdzL0fNtn26lbs1GM0d0bT6iYlv+vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ot42u2oPScCwKPOzdQO3yfABN2g8sc1QjsSFRPh4y90EK7tyXMHHScfmcMSVt3pYFYtR+ZyFuNWuO3WaRgGKjGNjEuGyxY1p+x0KlO/R+axmRWj+vi9niyAXXVZeERKvryE/k4/n3ewE6iB8vfj6LhCR3Els78wsT7ekjM/skcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JojYbeQX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2165448243fso57895315ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736355198; x=1736959998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gaB+29whKD9tF6NdRjAt8cwfbffpIlou0M2p2EY/0AM=;
        b=JojYbeQXbZYvLiElGqK4iw4n659GGHB+s5BaILVR7op2Q+gKPwtFxS41u2XVW2aCyJ
         m7XmQJCjDseSRapK0RdaIssGs0qr54F7eAc1NIWIDfcUpMti9qfR2GgJss20YThyUA4/
         40T/DpM7i6OF7AZPV8IOyVWrDp5uo06JFCbAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736355198; x=1736959998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaB+29whKD9tF6NdRjAt8cwfbffpIlou0M2p2EY/0AM=;
        b=Kq6T8M4KN4y9kd2reCfI0+2ow6DmlHW+lHO0zbePSBFL5A2Bj8pBy9vMoCH7YJmvXj
         byFTfyh+THXcg/JlAT9d16E67YL1zSsvw5hcFRzrcXRBMV1+nkC5BYS+cpSaxk1mub9J
         lN4W84Vo4faBzBWlSV+v0eFSZ2IpD8W3TMND9pp339wZJGzpDidR381cOVBzR2w349Ue
         nkUZ738OtQ0kVjEf8f1qErw+uflXQD6se/cteNCG8fYERdhXo5KuQzz8/h/CLcAg2roP
         Zq3RFEQYZ68rfy4ltBd1deSGUoBaKUZL58V/I4MlTS2oYM+v108N6f8uW8j3MB5cxCfx
         SHxA==
X-Forwarded-Encrypted: i=1; AJvYcCXRAXQyVHrhRZRQTWxFW4XUWqqynLX+H2XOXW/YfmZrbfz4BAclDoSZKcSUYGaAKZ7s7DcXpJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlhW7WrAWyJ0jd7kz6SxUWkT6PYixqYiNXUGZHRoOZO2hcQYJ
	HNprdI83o5r0hmxhXU5KrnRmiDn132zLXfd8z1pz1TU/AvoaKbBGTde19jNWjw==
X-Gm-Gg: ASbGncuWOf33zZXgO96F/a7qVUAJ6iFrTQYvCq5hUaxaAOSwxJ0NiUkukyMHdueF4zn
	9mDlhENAmPBBlF4p7BpjxLia+FgidD8mhjnfh1m8XWE+sxZDYOvrT73TEADKwn8AkRcoygNOQJu
	ljc1C3nf8ZoZSDt6xsjjVD0hVy0RcND5Ww+uNSkQ37ed/WjJaeianhBd9QmBc9yCQ/9CWmYLIDt
	UxYHqQO+zDlZTmBR3JypyCglzIeYJOVqmY6eLCb/vjFmDeRC6CmG/PJtK2zIcmfRxbPHt8T6Qa4
	XrngtsguN+vgpJws5435
X-Google-Smtp-Source: AGHT+IF+IBId4vqdaKN3CVtCTfPYH93J7zs6SP0NYTjmkBCo78OU4vPMoKyHYD+lpaUfmXpO/83Z0g==
X-Received: by 2002:a05:6a20:3d86:b0:1e0:c5d2:f215 with SMTP id adf61e73a8af0-1e88d18b423mr5852868637.12.1736355197755;
        Wed, 08 Jan 2025 08:53:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb88asm35415132b3a.135.2025.01.08.08.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:53:16 -0800 (PST)
Message-ID: <0a633091-4ae0-4a89-9fe7-99336656009c@broadcom.com>
Date: Wed, 8 Jan 2025 08:53:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
To: Jakub Kicinski <kuba@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, ronak.doshi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250105213036.288356-1-atomlin@atomlin.com>
 <20250106154741.23902c1a@kernel.org>
 <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com>
 <20250106165732.3310033e@kernel.org>
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
In-Reply-To: <20250106165732.3310033e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 16:57, Jakub Kicinski wrote:
> On Mon, 6 Jan 2025 15:51:10 -0800 Florian Fainelli wrote:
>> On 1/6/25 15:47, 'Jakub Kicinski' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
>>> On Sun,  5 Jan 2025 21:30:35 +0000 Aaron Tomlin wrote:
>>>> I managed to trigger the MAX_PAGE_ORDER warning in the context of function
>>>> __alloc_pages_noprof() with /usr/sbin/ethtool --set-ring rx 4096 rx-mini
>>>> 2048 [devname]' using the maximum supported Ring 0 and Rx ring buffer size.
>>>> Admittedly this was under the stock Linux kernel-4.18.0-477.27.1.el8_8
>>>> whereby CONFIG_CMA is not enabled. I think it does not make sense to
>>>> attempt a large memory allocation request for physically contiguous memory,
>>>> to hold the Rx Data ring that could exceed the maximum page-order supported
>>>> by the system.
>>>
>>> I think CMA should be a bit orthogonal to the warning.
>>>
>>> Off the top of my head the usual way to solve the warning is to add
>>> __GFP_NOWARN to the allocations which trigger it. And then handle
>>> the error gracefully.
>>
>> That IMHO should really be the default for any driver that calls
>> __netdev_alloc_skb() under the hood, we should not really have to
>> specify __GFP_NOWARN, rather if people want it, they should specify it.
> 
> True, although TBH I don't fully understand why this flag exists
> in the first place. Is it just supposed to be catching programming
> errors, or is it due to potential DoS implications of users triggering
> large allocations?
> 

There is some value IMHO in printing when allocations fail, where they 
came from, their gfp_t flags and page order so you can track high order 
offenders in hot paths (one of our Wi-Fi driver was notorious for doing 
that and having verbose out of memory dumps by default definitively 
helped). Once you fix those however, hogging the system while dumping 
lines and lines of information onto a slow console tends to be worse 
than the recovery from out of memory itself. One could argue that 
triggering an OOM plus dumping information can result in a DoS, so that 
should be frowned upon...
-- 
Florian


