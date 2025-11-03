Return-Path: <netdev+bounces-235269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E3EC2E688
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013973BA372
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B12FDC4E;
	Mon,  3 Nov 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IfFmt32l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385ED26B0BE
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212864; cv=none; b=SAputEogGbcK5aWOZlLsYND+NHI3UXNp+lPDzJJShVFLe997OBRa723bFlbnbl9ED6ttvVWxWc2Ohux+klSxwZxIaBm2CshFpqsQyr+swuA0zITxejJoXVLGXEDZaDlNZIZhj6TgDqo1lNvqHn4JlI5iSgSVm3sNDogBhQY6t08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212864; c=relaxed/simple;
	bh=Hot0o9tYfiyQ3AUGU/S1GcdeBP5xB4rS/PNdZqyYWH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8uquD4ACiaY52RLubqoS6RO+s7XBJQLY6QPGqo9t1yYf5HGBGBXyOqXb7fl+E5xtDUM8SXP0ZkbQOk0Rz9zFlkIVN0iKqqDgEmQrhmq7saBbJMZvaitsAcJUpsi0dKenW11tlfX2MjyTe8TVgLO6PTHzeW3dRKQdkbfbD4bb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IfFmt32l; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1778243b3a.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762212862; x=1762817662;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+P0KIIygy/NSL1zmH+oUDan0k+tOj8G3m0CQiMdVHAU=;
        b=LTNnSlEwCPLB7pWLaBalGPG9OmbtaSW0FsVM0q0iOgIFxO0bKbdZobB2c8qHbmYv1X
         7TsDj5ONtqCfSfj3SK+muy6JYSWJkBuTU6LDnTc7AxPAufk3OvECPY8uILBwW7FsAene
         eRBDMQolH+b+4rpDF//3aqz14MsCi81IKKyAZfHQ4XWeLOPNQYI7x3HsRjKzCYL/S6bk
         +y6Nn3bZMe1I43GuSSNr9n7xPCw51tdfVHPusFfsAOK0bOHy3UZ5aMNxqAqdT17N0g0M
         6m3bFMkVXVkqRar7YWbXjxV06SKcfhCPxgJvOj/aL4P0GUKbB/KpyqlGR9tF2/Dy5SYJ
         HTsw==
X-Gm-Message-State: AOJu0YwaRMqJ1OUomuFQ0pgqdXdaZN1NSjz6jF5CfLgqh5gzMuhd2FgQ
	u1cNLlVGgV2MR/4S4TBtNiMzqHAMZABm0qEYx8J0bWYmHacAQqhoesoWfQPc5wCJV6nNo3LE/bc
	9IBXZKex0h4jVNFlnFPB1ahi47L6ly/VTm9wJiFCfkkaSN9tK9LuXy9irA2EeyrgUYB+9y4FWKI
	DdZSUDpDigQyjRKYZX7aOoBeh+hNZAxHvd7D3h5aZq5sDAWUFmjKCwKm6aaGA26Y9Q+IyTot18i
	FzsCCWxopewx3l8
X-Gm-Gg: ASbGncuOpAJsFgowDwkFrKQfehgve2sw1zmefzxiGfVJqO12cRSqFaFfhLgUkqZlfWr
	sIMIDWVnBgdi7hUfeGqtDwVXj/e8oHIQzJz255RKKSWUvJ7zhhwR9ErLlOheVwD9YF0wG/Q70zU
	xiDJzniFp0aUDVxLiSA7mZxqWC70w+cAOUptBYir0USpW+P1tc+7PGthwErMyp6aiTynjCNBfox
	XLgyWVOP4CBDyc+M9DrHzG6tD6/F7H+gYphDjPxRFcJdx4saS5OlV0sWx0KN7SByJ1UiDdTnVhf
	F3OQH5W1pdkRf7x1JJ55qguSbZUNfypLepUwpPIp4vj5fpgOU+ePXtQOu81A/lvQ7eY9lDbCNwr
	UzrWztlNeqA8xSJulECdOPjOqzRxOsws70X/2wRzvQCwqGj0pm/pN59eSl5oQ3OBUlD/X+1Mjzt
	RuYPDn8HzQGWyKAJoZCizQeiCTnkJKEWnAB7X+YvtOzA==
X-Google-Smtp-Source: AGHT+IFJxwzxpdmQojuFVfWlTgzZdww3wcpqVjHlxf9LWTeIh/Aw1Fq3PxAme22bCjXmOAN5MWNSoRCXjDy2
X-Received: by 2002:a05:6a21:a90c:b0:34e:409e:eea3 with SMTP id adf61e73a8af0-34e40ae3addmr796565637.30.1762212862121;
        Mon, 03 Nov 2025 15:34:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ba1efc57828sm29277a12.8.2025.11.03.15.34.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:34:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340be2e9c4bso2226818a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762212859; x=1762817659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+P0KIIygy/NSL1zmH+oUDan0k+tOj8G3m0CQiMdVHAU=;
        b=IfFmt32l2CDY7s4uBvE91sEArkjV5etRDgddRaUlYQC60E8ukHmfZ5rkW/GtY+WsHA
         2ajFkBuMQkQyXxSSkzpqR3t4FvT7EgHqwRVspjHeCm4Ua8/BvDb7IyVOaGpsGz+RtvQX
         VkPGt61uQ6BkV/9M+EMTeMuxuZIbpZBkDvKvQ=
X-Received: by 2002:a17:90b:584b:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-340b152f234mr15279101a91.11.1762212859288;
        Mon, 03 Nov 2025 15:34:19 -0800 (PST)
X-Received: by 2002:a17:90b:584b:b0:340:b152:efe7 with SMTP id 98e67ed59e1d1-340b152f234mr15279070a91.11.1762212858917;
        Mon, 03 Nov 2025 15:34:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c69fd56sm2257488a91.14.2025.11.03.15.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:34:18 -0800 (PST)
Message-ID: <ad5d4ba5-bd30-429d-9c5c-86b3d6abe232@broadcom.com>
Date: Mon, 3 Nov 2025 15:34:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Allow disabling pause frames on panic
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Antoine Tenart <atenart@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Yajun Deng <yajun.deng@linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
 <20251103152257.2f858240@kernel.org>
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
In-Reply-To: <20251103152257.2f858240@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/3/25 15:22, Jakub Kicinski wrote:
> On Mon,  3 Nov 2025 11:46:29 -0800 Florian Fainelli wrote:
>> This patch set allows disabling pause frame generation upon encountering
>> a kernel panic. This has proven to be helpful in lab environments where
>> devices are still being worked on, will panic for various reasons, and
>> will occasionally take down the entire Ethernet switch they are attached
>> to.
> 
> Could you explain in more detail? What does it mean that a pause frame
> takes down an Ethernet switch?

One of our devices crashed and kept on sending pause frames to its link 
partner which is an Ethernet router. Rather than continue to forward 
traffic between other LAN ports and Wi-Fi, that router just stopped 
doing that and the other devices were frozen. I don't have the exact 
model yet because this was on a different site/team but I will try to 
get that. This should obviously be treated as a router bug and its 
firmware should be updated, if there is an update available.

I have seen it happen a bunch of times at home as well with an unmanaged 
5-port TP-Link switch and a crashed laptop.
-- 
Florian

