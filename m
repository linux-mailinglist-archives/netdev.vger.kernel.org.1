Return-Path: <netdev+bounces-135917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F299FCA1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B4B23384
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EA41DBB24;
	Tue, 15 Oct 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZyKWIbuc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2921E3D9
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036566; cv=none; b=IMDk8D6BDcdAG6t32fwPZGVd7mMFaBwsTWBPLnOLeQ5TQHXhl8i0iWErXbhQLnoUOhk9Js/VM/sm4sJl9TRIvsHDIq7SNIslr2pl/efaCSPa++nv9g4NsaWv6OUBOL89RWKuL8XGGeyQQGqRTc0KwwkkRuosvKR74UL7OZ3DLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036566; c=relaxed/simple;
	bh=R/JU7WWK4nH9sjVY5CGheYv12+wBHyOelkg+CwSXKG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpHEbmZaTB0tBIN6hPOZrqE6NHNViH/wBXABvQflpA7AGCBmFROS+85qR5DL1kSq/Nn3Sq6J1bg+dLAJbYPbWzTrufFFfJkA3fImz9V58OFHllwf/aKBMO23Jw8UUUusb4AmM7aT0na6ZJfLDD/KdNbClZLoaFruLE4b2Vy3FYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZyKWIbuc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1205e0e03so323717385a.3
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729036563; x=1729641363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Faj3gXWvchlvCwalbAFXavfgfdm6k2lCm93N+mX1N28=;
        b=ZyKWIbuc9dq090mSQp4pH6vQ64DJb/+F5xvFrtdyt2wyISzRY139SlTJyz/v8CSe7v
         y57B0lr2F7/gLNoLwPA7xfFCq5hc9qUfWszmyC3n54/9U0WNPTZbP+0OQGQJNfFUHgZ5
         124SJ7h/P5SL9OxRNiRBGaCOKSP/ayVqqs7Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729036563; x=1729641363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Faj3gXWvchlvCwalbAFXavfgfdm6k2lCm93N+mX1N28=;
        b=X7YjVvk9x00Cb0ohHInQiA8yfozQug0g6seqnXHgrLEoU8PUJigACE3N1RZ7o5yv8w
         5DS8otEtnIwVotxlE/DspdhJUWmePwA19CQbbqEcthyS2KnEmWVJcKUd9fEVqy+ejS7r
         YW5RAEr/D0BUUNTP73t+MUbW8ZxD6re3fQxi3E2oHw0XgHAdapBRxJ8b5Q9DxagGWQDy
         shsbaNlEBat1OBrHD8jBHBnExMLwSNGP2Fm9/2GRwTN186+3Y+QBvpiOqyOJM1VDaxyx
         42Gwm4ziyK2DVcahTQYjvO0KZQ78qDC39MeZpTV+qcGCJxLgAXW2YYgyDo9KChvrswI1
         jK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvNzRfj7HdcG8haV58CjNj3B7sGPI9/ARnmacTZM8cFEJbjNkI41lmMKoINpbjetbzy9+90m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYb/CKmyHJAcVfnMVhzixnXGBKndtC2fovEl9PZ72opH9BUALy
	/7kRbKMHZ6vJ+FMEHAiTo98J+UOphbiKNqwBpsig9EGMbDF6kq5cPARCShgcoQ==
X-Google-Smtp-Source: AGHT+IFZua85gX9gwebbB6yQ3hldssx/0GepO83ztgnfFWjhClWK60xdFYL+sKiGOQ9xZi3RbSFRow==
X-Received: by 2002:a05:620a:2909:b0:7b1:1cb8:198c with SMTP id af79cd13be357-7b1417abd25mr245389185a.4.1729036563568;
        Tue, 15 Oct 2024 16:56:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1361726cfsm122192785a.47.2024.10.15.16.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 16:56:02 -0700 (PDT)
Message-ID: <d5a7d26c-982b-49cd-8bc9-2f2c535af2e2@broadcom.com>
Date: Tue, 15 Oct 2024 16:55:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
To: Jakub Kicinski <kuba@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Wang Hai <wanghai38@huawei.com>, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241014145115.44977-1-wanghai38@huawei.com>
 <0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
 <20241015110154.55c7442f@kernel.org>
 <ed541d60-46dd-4b23-b810-548166b7a826@broadcom.com>
 <20241015125434.7e9dfb04@kernel.org>
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
In-Reply-To: <20241015125434.7e9dfb04@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 12:54, Jakub Kicinski wrote:
> On Tue, 15 Oct 2024 11:07:29 -0700 Florian Fainelli wrote:
>>>> Since we already have a private counter tracking DMA mapping errors, I
>>>> would follow what the driver does elsewhere in the transmit path,
>>>> especially what bcm_sysport_insert_tsb() does, and just use
>>>> dev_consume_skb_any() here.
>>>
>>> Are you saying that if the packet drop is accounted is some statistics
>>> we should not inform drop monitor about it? 🤔️
>>> That wasn't my understanding of kfree_skb vs consume_skb..
>>
>> Yes that's my reasoning here, now given that we have had packet drops on
>> transmit that took forever to track down, maybe I better retract that
>> statement and go with v1.
> 
> Sounds good, we can apply v1. Would you like to ack/review here?
> 

Yes, now done, thanks!
-- 
Florian


