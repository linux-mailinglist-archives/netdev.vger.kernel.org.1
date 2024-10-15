Return-Path: <netdev+bounces-135827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9999F4CF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5311C21A1D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0555F1FAF0D;
	Tue, 15 Oct 2024 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B6u/r6Lc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62291173347
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015653; cv=none; b=cd7OWHehDGLB13rJ7IduT2Vb/+nXi75B3BChYyxZeqNU5GmkHlxrvXYozDHvFvWDCxNEuvs9wGL8A7Z2NtZHwnGTtDltTwjjEBFltHGJ6u4i5OWEcz3lY5kTKno0mn/XodnBfEK/TdfuAg0He3sOhsqprLjHi0GscVQQtPNEeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015653; c=relaxed/simple;
	bh=mp2svKcmNny1JZ8mUVCe1St4WuevGVB4bca4Z482AGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnEgKGYnxz0pg93Mp/g9JvF/jDNcCYiFUSqAz73XSPgW3aY2brSQlZ296GuDlyO47yNDun3gakmtYoPlzuBI1eErZyOwHGASyfoK3AKfPA+UH9QYF0RUtbMJD+pQcuA2QNZE8yHjSwTUbPYlae2Nsz9+OTdKrM3U1gzYvr7qSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B6u/r6Lc; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e74900866so910722b3a.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729015652; x=1729620452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uyplW89FHBeoQEYicibHANYldii1FOFczTEx2pQXNVc=;
        b=B6u/r6Lc8t2noN5Xd7C8kLdrJgNksClxutdcKxkz2mimW2OcbbIbDsPDbsW7NRpSj/
         yHwIT316lwgZVuioIQoBHW26lb+7gXKyL6kk21O5dl9BYSlYb7cYXmvqefHNGXU3MARQ
         meu8PFf84YwvvrwTHBDHMaT+73zbU6mMHQ4JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015652; x=1729620452;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyplW89FHBeoQEYicibHANYldii1FOFczTEx2pQXNVc=;
        b=eCn3nIobPzvkanl+lSUQMSoTpQW8k77c3inejnRn4qVrmWOGp3OxPDsDTpzBm0w0yh
         BgxQDLbXjY6rAM4HxeUwSbgVYU40wEce4IFt4esGB5ekXiv3QwIy17btV/WFHRBAMVRT
         VM+vC4TRORNtMGSwGTMhUnv+QVVCRpGkD4H89mANKtZJPSFnDuQcStYSOkGX0jtvQMoA
         J6+Ebyprdx9oivbSp0JPSp0SmWXNyb4wAyicBDRkN7ewkP0k8ZXOOaMYkhfd2XVkjdyL
         vl66XZxvGEenFvllUoQ8/oxJRlxbIVNt51YsAmWucO1wWkYrvE8DOVyOAFt0l9slAVy+
         YPHw==
X-Forwarded-Encrypted: i=1; AJvYcCXqFT4MR09db+DWS//vo5Pb1JeT9bZFLxvvd72j17REV4H9XGN4kZr3ZTukHjJiIuTlXlrWb8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsoi51gP4Y4Oh4kousvArvt+ebkeeHEl4gpdBGT7/Og3cCeVLD
	Jki0kTs+rwXfd0ClMm2pMgIexaDJ8JfYbRwKr5MY/r5nNOjheh47hTYubqxSaDCIPFWl+We5KgQ
	CZw==
X-Google-Smtp-Source: AGHT+IGkgFxmWu3ONSnK7BzmVrFic2xtXKYm0lvFrM56CsdAhB3PKvklnkPE6VXQrWi3toc6W5vxhA==
X-Received: by 2002:a05:6a00:178b:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-71e7daef79amr1507687b3a.22.1729015651593;
        Tue, 15 Oct 2024 11:07:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77507db4sm1571983b3a.188.2024.10.15.11.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 11:07:30 -0700 (PDT)
Message-ID: <ed541d60-46dd-4b23-b810-548166b7a826@broadcom.com>
Date: Tue, 15 Oct 2024 11:07:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wang Hai <wanghai38@huawei.com>, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241014145115.44977-1-wanghai38@huawei.com>
 <0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
 <20241015110154.55c7442f@kernel.org>
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
In-Reply-To: <20241015110154.55c7442f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 11:01, Jakub Kicinski wrote:
> On Mon, 14 Oct 2024 09:59:27 -0700 Florian Fainelli wrote:
>>> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
>>> index c9faa8540859..0a68b526e4a8 100644
>>> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
>>> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
>>> @@ -1359,6 +1359,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buff *skb,
>>>    		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=%d)\n",
>>>    			  skb->data, skb_len);
>>>    		ret = NETDEV_TX_OK;
>>> +		dev_kfree_skb_any(skb);
>>
>> Since we already have a private counter tracking DMA mapping errors, I
>> would follow what the driver does elsewhere in the transmit path,
>> especially what bcm_sysport_insert_tsb() does, and just use
>> dev_consume_skb_any() here.
> 
> Are you saying that if the packet drop is accounted is some statistics
> we should not inform drop monitor about it? 🤔️
> That wasn't my understanding of kfree_skb vs consume_skb..

Yes that's my reasoning here, now given that we have had packet drops on 
transmit that took forever to track down, maybe I better retract that 
statement and go with v1.
-- 
Florian

