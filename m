Return-Path: <netdev+bounces-228896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 697E7BD5A9C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B1F18953DB
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C482D193B;
	Mon, 13 Oct 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XWwNwslb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4B2D2397
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379219; cv=none; b=Jt/mUivBbGnkeyGzeUC392tNnLOR4IYWjT0XCx4qgjZnHHWbhpnUx6+u9cUQaVOR/VjbkOP28ixF0GX1wHwdmjy4pN6LDpYx/j225OqtTZ/nB7Z0a+RTvmMHkGyyAmpXxTcTVlgHVOQ+rtHREhuqMKCN4nplYeIMYBycAdhFP74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379219; c=relaxed/simple;
	bh=5+xDnb2xb53HUrmtr4FSq+vsKUioXbGIG9Lyf50qLks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLi+0Z5jeXcMAG1l5mGHRih2iYESDf2J2TSREClCo5yMOe5eIidCHltcg/mAtZuINzPwYpt6EhweV8AIIY+LmMXjjcl81LQuMtKqp6H7cE3ErNIiFgUa7pT9rFCKB6KTmHtF1sIqE78q02S8ciCoI+WgA2g/m0hXdhr53cEy7Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XWwNwslb; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-781014f4e12so43534437b3.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379216; x=1760984016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnWgWJ64u/8WCAJXjGDR4Iw3Y3OHER/u6FLE1jKF00M=;
        b=lC7e+kDv4V+sM+XG9WvyshK7vuImfSgLcHbWkwlxS3AjRNvAnI+6cEXIMoTPuFHyet
         rRoIScGJ1kwjxcmXRWXNhDLy2OiZcbQBCVtM0GkU51srMy+Cc/U/9ZcxApUW4hkhUk5M
         JcUin2mKUpgAmBfSLhX4IRCLEgqq3VPV6ishMNlx4xr6nhHJCqppoKTy8P5mhr+rrUBi
         qPKrOVXj85PB/e9UlRNZClz2ZTwM4MZ2xFNwXS4kEUjTMdhVmgdE/VPAF106HBboc5oa
         RSOFQtz8qH0N4VQgDQs+trYMs/3EG/SxWeQ58vLmfIo0j23cQxpYtnfMAOk4l1mTZ0L8
         xl1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXt+HDJXMTC6cnjz1DjLCH8l7s5/ThwmX57pL54hgxniWiEc8Ef/6FfOB8fgtcGQs8dZag/1go=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6UsP5VZwH+u7oZID1wzSyuCO+tpPjOGPKVhaYB4civK/TosK4
	PrZnYlcAQpynnsdFWF0X3QhNm54A9LrvkZr01asLwiZfjYnDPfNT7FKtF4VGkKyurW3a2UukPda
	3+iEkAplz2dJ7RiqwlteRAcFA8+jpIpX/ZZDNR7FYDTcTPZwDu23sA8pksJyiMw49AktFhcnZpd
	DwDoluU/AotN1U+LLSRaUEXsKMe9uLh+CAny2bz8rAEDLuOXfWdasz4+hEb/9stDZSL4/smMpli
	y4mQwS6d+akMDp1
X-Gm-Gg: ASbGncuwPX0S2l6Q/FIWOa0ZRCkvBssCZIaZz0/AUokp/VJAzVnl4dA0+6Tc88O0gtq
	6LPhtwcHp60zMZkCbYvUQQ3K66kabjZ0TLka95Bmve+L3A38R0lbUXM1R6ZTv9T62tWlZf8+j+d
	Qidd5l0fP85kxgK3nkW5vC53251h/280p1ilnnChlXDYKLfqCm/CFYuKKpUI0estXomh9i7U6FY
	gAWVMRvGUDh9njvgfVLgOtz/KnywrueCgb5hgB6IN9ivZL95tdIYvWblVsrVAAyQMSapoFvyYt2
	jiQXWoMXYACQPUBwvBKydE1CvzInbC3W0TzURgGRcVKFffIF2a6kiVw5urNcP8tpoafp8/Ry3SF
	u6DgGduVNIAG4nmCKSwpg92oJbiWEUTuiJcji7181MncbJ4+fQkfyds4+y6uN8WUYu2cG3c6nar
	dd/KR7r+k=
X-Google-Smtp-Source: AGHT+IFcfBLEDadvb0YqFPS2qUAixNlHHfyKQZvZ9qELBQOUtIwSZWBqejudifZapXkAKgEPuS6ppzRbHphK
X-Received: by 2002:a05:690c:6ac4:b0:746:9add:a496 with SMTP id 00721157ae682-780e177efbamr220760367b3.38.1760379216400;
        Mon, 13 Oct 2025 11:13:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7810706a9a7sm6376127b3.34.2025.10.13.11.13.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:13:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8741223accfso298073886d6.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760379216; x=1760984016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vnWgWJ64u/8WCAJXjGDR4Iw3Y3OHER/u6FLE1jKF00M=;
        b=XWwNwslbNXadUvQ3w5ywKLUtt4scXmUKDsaDs1sB7zBGGngvEE437rSaK3/5gIoWGj
         4MvWMWhC9XrXn4Ovk7EzpxdWJ8Z3brvouvrg/ZCdmEZupHpUigvYuAibam6I6fSlWPYN
         6NqpmuQzv8oYHNe2I6LcZJ1ehu0kD7KCA6WTw=
X-Forwarded-Encrypted: i=1; AJvYcCUGuY00wQEj+n4hrwjciuvX/Ht/X5sbn2evejVy40jNnddIQpaXOu8ivYtBSiHlv+KZBf5aoGc=@vger.kernel.org
X-Received: by 2002:a05:622a:590b:b0:4df:bba:5acc with SMTP id d75a77b69052e-4e6ead7788emr317622071cf.79.1760379215771;
        Mon, 13 Oct 2025 11:13:35 -0700 (PDT)
X-Received: by 2002:a05:622a:590b:b0:4df:bba:5acc with SMTP id d75a77b69052e-4e6ead7788emr317621631cf.79.1760379215334;
        Mon, 13 Oct 2025 11:13:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706d670e7sm78544281cf.23.2025.10.13.11.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:13:34 -0700 (PDT)
Message-ID: <1859972b-baca-48c0-a62f-f2b1eaafd89f@broadcom.com>
Date: Mon, 13 Oct 2025 11:13:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] MAINTAINERS: add myself as maintainer for b53
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20251013180347.133246-1-jonas.gorski@gmail.com>
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
In-Reply-To: <20251013180347.133246-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/13/25 11:03, Jonas Gorski wrote:
> I wrote the original OpenWrt driver that Florian used as the base for
> the dsa driver, I might as well take responsibility for it.
> 
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks a lot!
-- 
Florian


