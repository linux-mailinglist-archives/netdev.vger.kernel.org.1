Return-Path: <netdev+bounces-211062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 832DAB1666F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3F57A8590
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C22DFA21;
	Wed, 30 Jul 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f1Ka3DmR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A42BCFB
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753900867; cv=none; b=a3qXpsRRFHYdY2NWae04A8nvXaVDVR3EUXQM0MN2BMs3Xh3bjBDa7hrZnyjvv2nQHdf0OVdDiC2qQqD6FXPRPQNnaXXTj2/H66A1cP5CJQXA1DSla+e2SnA9JWJHoJVrKQOBEh7QwzRt5OOdz+7/PJGAKTXgY4ISUZq2KgGBy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753900867; c=relaxed/simple;
	bh=IDZVHAUnqA+hvKUpyxjPG3LKpwEKeCQmIrk5w6Arm98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t70VWeiaqmmWND0sAX0tFJ6rjjBOifzBQ0HQgZexMcuoCUQUi5yQah5ISDFvYYw4yUVjhC9eOw13u+3Et2zv9ohq838Tr8ibbdl0Pyqc2UFkraA2Gi9uF9H2d41Tp0z29Y7lqjnLOE7kGtiwi3OgFvhHCbJes5Zy4XC/3RLDMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f1Ka3DmR; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e34399cdb2so19917085a.3
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753900865; x=1754505665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j1hxL5Vx5A9KnVBhUwPUidWdTjrb+vaRaMmz7WAa6Bw=;
        b=f1Ka3DmRtNb9zOcgqCErfq2cFg6rv04vxsJ8Fto67HG5w42RCxHdou6XGpUQsz/JSI
         ULvAZMa2kLEAQIrkkTFDFshYuIrqpw7asyAZnK49Ebdo/IjpWiPz5e+BMyy3CV8wKkVn
         SqqmuJccRnGS5hzxP5fqB1jZEbMCSgv611o3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753900865; x=1754505665;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1hxL5Vx5A9KnVBhUwPUidWdTjrb+vaRaMmz7WAa6Bw=;
        b=o3EvCcN8eludR8k82XqHEJmdSOupUfqFaa/l132hU8iMC090e1iJO6pwcxzP1msLyv
         ZNaNKp0N6+X4A1aUluE3cHVXGd85muldBYTlXCGwoQXUVli051LeUGsv5CdJUb1E7IQl
         ASlciMt2QH81RxujyEnaCuqYXbTYKhXxi18qJm5yuwNQ+tyAO1RTu8CVUfCERoEm5eIz
         vK6JxWD2IICLWJpxb7J4zIqBlKC8o14etYZRbiC+BnyvOCJpjnQ5rDHwsJrjMR2K/04K
         vRRfeMJmWbwMkwV0hpnIGceOIJTaL6uaCUl3Z3x3PPhFXsxVG4GQBJeDTJuyTUur4GhH
         hn0w==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9JTFaswTsl1hmJh9WU6CdqQW0XVH4TZCFPVqy3IP6J/XxmwupbHrNvV12rlm2JN+CFA2NdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55UkS82ez5U0MQQ/0aqbNg43Mt3E00zZwAiG5emZww+B3WGrX
	Uw+8dv5DKMk8tXSMzqVRJJWemsjXoUwGze8bJm6X8Tz9JRKCwMIDjbkfCneC+e59lg==
X-Gm-Gg: ASbGncvmqYu5kn3YnOsgoJY1zl4AdRMChZxuIXBwyCTOxdVlznf60lS1cKM3/ES8Tik
	SoNQe21GiSrJ5lBUGkTbS/q4uPKW7c67iUw9LoLMh2HwJR0qC+xn3GXBj0x3jTkUjq0XPE1wsd8
	GbeQHzwx1QG65UuP6nrksTN73rlO1+N4DCBUb/hLpnMy0C279uT5zAYssvcdfH5Gp58pLKill+U
	hdO1bvpXhWCzbmm9wHWyuIxkCiwyOWq5SkggOi1aIF4QmHu0DMO/Im8ll9B2LeTYhG3EkNuUxzD
	4V1YAjjSqeJ4PnXNkgz+uZlM0S4hedglh/fsTQM9r0uxxFIPh56MTXt/56Ddr2L8eu3vzfvoYHs
	QnbJERule+SuteN/7C4ZdMxS/oiSo4JxtebHZZ1pMHkmzhI9Ju0aHfutHUWmpcQ==
X-Google-Smtp-Source: AGHT+IG3MV2lDcwBFqjZSW+SRBYzdliL7B6DW5UaA3OyG1yEKduZx+x6LLWdvH0Y3ExSLnQyDkGKCg==
X-Received: by 2002:a05:620a:17a6:b0:7e3:4413:e492 with SMTP id af79cd13be357-7e66f3f8bacmr526967585a.62.1753900865037;
        Wed, 30 Jul 2025 11:41:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a2199sm609191085a.31.2025.07.30.11.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:41:03 -0700 (PDT)
Message-ID: <ec68a220-53c9-459f-9bb7-7d48da1a3e77@broadcom.com>
Date: Wed, 30 Jul 2025 11:41:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: b53: mmap: Implement bcm63268 gphy
 power control
To: Kyle Hendry <kylehendrydev@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: noltari@gmail.com, jonas.gorski@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730020338.15569-1-kylehendrydev@gmail.com>
 <20250730020338.15569-3-kylehendrydev@gmail.com>
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
In-Reply-To: <20250730020338.15569-3-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 19:03, Kyle Hendry wrote:
> Add check for gphy in enable/disable phy calls and set power bits
> in gphy control register.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

