Return-Path: <netdev+bounces-155636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C635DA03393
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458AA3A1C59
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C731E1C32;
	Mon,  6 Jan 2025 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="doLE/BjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F41E0E14
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207474; cv=none; b=BIFlMH++PDU+4IiNlPiA4kgqfJPbUIVqB+8nTf7E74GtL8AacDg28kli64CIJFjNEjMa7VTxiPFsFDu4nE+tGh0yv4h/3KgX3m3vMcW6gd36wDqGR7RubnRMu4dG6x77iVxqatyQwp5kwTT/2kXfYDHqXNNz3fC0JB1gVF/mHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207474; c=relaxed/simple;
	bh=itLqcfuC6wfSI6Sa3TQXjpCZa15BUOpN4T/tGd9dNac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pi4t7hYgD8v5qVz2W/Onwf9VthEO0hhSZdm6igqfK/U+5I40u3O75rhfQjtwLtIaJQnHw+o8tSzdvc1pgIWDiDcr6Aa3AbL3ZVn0G9OTHkEXoYk7B6wORTBbsiwgZu5D2ntd9FU0pA8qZjt19h/9uiviBQU+uojFNn0cu+LL1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=doLE/BjV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so21738186a91.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736207472; x=1736812272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k+gERyncwuF4MQPZI3knfqd5h6u7DDtfq+iWSAvxfGc=;
        b=doLE/BjVjMsPAUELI+WEsfcG1eEgNOyFJ8+JNJAgtKYi1N4kzl+H6D6aqPmXozN78F
         WLbCgW97zme7NXIJPE1Q1LOtoUaDYti5DeqkwRrbi28OP2X4uiFr5hczTxQilhtp+1gE
         TqwSnUz/UwJblx4hHBkYed0E63d4r8yQj5FMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736207472; x=1736812272;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+gERyncwuF4MQPZI3knfqd5h6u7DDtfq+iWSAvxfGc=;
        b=JYIZJg/qV3Ud/ZZ/SB1X2KxLijqMd1ko3WzBrcS633oBDga3s7n15Yn9TO91TrsXXi
         8kxRswgw3DXmVuNUsxjjyMuq4eRMxWSSOqX+TwuACD4A4qmN8QR2JLBobhM9OjUoYWDP
         ezOO7nyorGQZCoWDAGWFwcbWXR/0/z/YCnEhhRz6guxywhr6Cof2RoKvgucxA8mAe9YO
         TmH221Jt2ZoTih5DR7zTnfI4Nh28FywIX+UuQ9/1dOEg57C0Rd9dm23r74zQ0EEO2wvD
         b39PtMu7608uhLEywvA3Qf2vrGSkI2cynhcLeG+su4Qq0jzlPt4eKxcfS9GyU5r6ia3t
         9fbw==
X-Forwarded-Encrypted: i=1; AJvYcCVrFam/pGZ0SqhgsxnVgmh+96ghY5tiuj2w4jOdB3K4ktAPvkspOLCcYVTufWUwzY4wngNtQAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwcQ9px6/vYdqTQQ6JQnoIzdXDrblnFkJGW8PSqYjMI5EH7Gc
	fDy0sk3C2/74NeRKTLC4EIL/TmYz+q/vt38ATRA1cnMzs+KClXgfTvsTiJBMhw==
X-Gm-Gg: ASbGncvvFo354w0ld8IzZ5JDUwmhZ5WSYwcQtK7C2dhlFOGunwofP/QCWzqh5GjSxhv
	RPUhGXjfoll/tISKEJPlrYYhZTWig4LHsFdGHsdNv9CsnMya6Qu8tbpxkSu6UGttN3NuJ2glZ0Y
	vk/b5JiVCJwjuL6swqnjNuYozdwDvkYgz1v+K2wZlrR9aSzqopGvrTtQuoicSrUr1w8WlQo7sCu
	7/jTRDof4WidZKFcSH5imD3UthoTkazIzlj55iPmvkwBYQG+7AY9bATLvM0gVUkm0TC85Wo5RVN
	Cls5npESSFQ3P1ttDW9V
X-Google-Smtp-Source: AGHT+IFMGuPvjtZVf94bS/6Lwc38wkGYMgKAZaDXBRxmmIdtawuCTSTDjPPUm1UTJH0JVo5Ralo6zQ==
X-Received: by 2002:a17:90a:c2c7:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2f452debe41mr93318719a91.7.1736207472367;
        Mon, 06 Jan 2025 15:51:12 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477c8583sm34398433a91.16.2025.01.06.15.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:51:11 -0800 (PST)
Message-ID: <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com>
Date: Mon, 6 Jan 2025 15:51:10 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
To: Jakub Kicinski <kuba@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>
Cc: ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250105213036.288356-1-atomlin@atomlin.com>
 <20250106154741.23902c1a@kernel.org>
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
In-Reply-To: <20250106154741.23902c1a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 15:47, 'Jakub Kicinski' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> On Sun,  5 Jan 2025 21:30:35 +0000 Aaron Tomlin wrote:
>> I managed to trigger the MAX_PAGE_ORDER warning in the context of function
>> __alloc_pages_noprof() with /usr/sbin/ethtool --set-ring rx 4096 rx-mini
>> 2048 [devname]' using the maximum supported Ring 0 and Rx ring buffer size.
>> Admittedly this was under the stock Linux kernel-4.18.0-477.27.1.el8_8
>> whereby CONFIG_CMA is not enabled. I think it does not make sense to
>> attempt a large memory allocation request for physically contiguous memory,
>> to hold the Rx Data ring that could exceed the maximum page-order supported
>> by the system.
> 
> I think CMA should be a bit orthogonal to the warning.
> 
> Off the top of my head the usual way to solve the warning is to add
> __GFP_NOWARN to the allocations which trigger it. And then handle
> the error gracefully.

That IMHO should really be the default for any driver that calls 
__netdev_alloc_skb() under the hood, we should not really have to 
specify __GFP_NOWARN, rather if people want it, they should specify it.
-- 
Florian

