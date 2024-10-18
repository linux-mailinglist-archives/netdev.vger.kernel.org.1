Return-Path: <netdev+bounces-137092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA209A459B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413FE1C215E5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC717C7CC;
	Fri, 18 Oct 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LLPjOxf2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7020E32D
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275536; cv=none; b=g91Vqu9f88ISvur5n4YHN7Jo2ic9/biTJr3UJfXlBJffhDqNtgXlKvuno1N2A6AXgmySZwszkKWIru2f4riFyE9i+T3mF9sMmbZyP3+0mRRZNEEJyz+YwzcndZQdHnYX5BmZ7GXSVYILzlVEkt2SOeJ/vjMrmshCLiC32rKytlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275536; c=relaxed/simple;
	bh=azJh0/gfUoZGgbtHRhofSjp/pV5J9dd/nw6HccZC9VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huB+x7n8XmPX9Xs4UAsPC7ukWGnJc4RXSJ/HR/CHyLIGHcchCtMAXXtjrZPaIjmmyn9pZlWR8E4dndBmboJ09oliyiQ7E2iL1L8hSpxV8URr878ZQKtM/xltCWGu36uVcR0fvWcD9qFXxDF1/1wu7eFyE5DBguqffd2GSyrUC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LLPjOxf2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb7139d9dso22899875ad.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729275534; x=1729880334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wZFB4hoa79A69eFFAPzHtgH4L4E+q019dYinMHOsNZw=;
        b=LLPjOxf2KTT8TF1BWR9LCd3HI1IUawMMzk5P4CzWkz1kIUBkaKN23cV1yAkBRgus7X
         BptHKl15Ds/M0BCzGjVE+ng6rL6eWMNnoaBgL5lchF15zH9MCseR+okpQCkp5/a7P2P8
         IskEEjdvDnwrJcwPke+feMaTyIXU4vTCmgDNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275534; x=1729880334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZFB4hoa79A69eFFAPzHtgH4L4E+q019dYinMHOsNZw=;
        b=OyoLICPb/2j5QkMT+Tyn5cnnGCk0m448CVBgsmX8yi2PAiiWw8bfNX2w/fv4jBpmHo
         OHLnqFKQYOrMmv1PbgtoBNlFpyKjRKJTumCXyUYh/TFFagZjJmRdTCsBNjJNuVYpRRC6
         VyV0AjULQDvf2unFe4EaBtZAVMcdZ0rN36tWtxeU4TlE+iNA47VzHCeR3bQYVQvAgdVx
         McNSyHf68tqPsScNFM9WnF2+oDLgUqbRCBFyGXPxnfGMNU2/9iT9mv+jWRuWizzUkzMS
         S1v48L7iItb9OHRxoT2JJJp4pXd8X7bltx4GBx54U2OWV5L63D4h+d66kqEFgfKN0Rm1
         khQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/LGbo3CdNwZyqaEl0iGSkODJWZltRzYDZAzDE5jUsQ7CJCH4oJtPBYvxQD6sJLtpInE04/uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEay7r/wl10Ssl4sFJDcnQcE5eKcxGih/nqZVkX6DdSDhRv3lZ
	qRbXFnGjry4TdC0nKaqX9Q/JZrpztSe/8jL81rlcpF/1tAz3rgGEYH40NkWf9g==
X-Google-Smtp-Source: AGHT+IGPsDsWsTYm9lPfu34FwPva+YLBOEUlwEl9wd8OWtUCPgEzHFDxLsBMptbPvWwkZplXfvUmMw==
X-Received: by 2002:a17:902:f542:b0:20c:ca42:e231 with SMTP id d9443c01a7336-20e5a71ecbbmr39091155ad.6.1729275533540;
        Fri, 18 Oct 2024 11:18:53 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a90dea8sm15469195ad.248.2024.10.18.11.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 11:18:52 -0700 (PDT)
Message-ID: <d496a4dd-14be-428d-853f-785cf6200360@broadcom.com>
Date: Fri, 18 Oct 2024 11:18:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: bcmasp: fix potential memory leak in
 bcmasp_xmit()
To: Simon Horman <horms@kernel.org>, Wang Hai <wanghai38@huawei.com>
Cc: justin.chen@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, zhangxiaoxu5@huawei.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015143424.71543-1-wanghai38@huawei.com>
 <20241017135417.GM1697@kernel.org>
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
In-Reply-To: <20241017135417.GM1697@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/2024 6:54 AM, Simon Horman wrote:
> On Tue, Oct 15, 2024 at 10:34:24PM +0800, Wang Hai wrote:
>> The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
>> in case of mapping fails, add dev_consume_skb_any() to fix it.
>>
>> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> 
> There seems to be some confusion over in the thread for v1 of this patchset.
> Perhaps relating to several similar patches being in-flight at the same
> time.
> 
> 1. Changes were requested by Florian
> 2. Jakub confirmed this concern
> 3. Florian Acked v1 patch
> 4. The bot sent a notificaiton that v1 had been applied
> 
> But v1 is not in net-next.
> And I assume that 3 was intended for v2.
> 
>  From my point of view v2 addresses the concerns raised by Florian wrt v1.
> And, moreover, I agree this fix is correct.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> v2 is marked as Changes Requested in patchwork.
> But I suspect that is due to confusion around v1 as summarised above.
> So I am (hopefully) moving it back to Under Review.
> 

v1 was applied already, which, per the discussion on the systemport 
driver appears to be the correct way to go about:

https://git.kernel.org/netdev/net/c/fed07d3eb8a8
-- 
Florian


