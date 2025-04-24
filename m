Return-Path: <netdev+bounces-185730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D9CA9B8FE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B247B9A7020
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB6215F46;
	Thu, 24 Apr 2025 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e/nikoQV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F3201100
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525972; cv=none; b=Daf2AkpTzxRNNmxFyYME8LW1mvACrwdzqKmPnGW8JLs3nnnzb5v4XJI7kvj5Nzsg/HY1iQ5mhN4mLCjyrKh5JxRqEbAyTQXOIscrol19vrC8emBKkwV2bWzDfBYP1XtQ1I+ZMUX949VIUpskV1y3CjLvXrzoUFCCJfzROw76D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525972; c=relaxed/simple;
	bh=Xa5RS0tO91ddq9XqdvI1hv1yHxUBdX/At5x07JUhWKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Quy/+x+fREkCauqFf4Pl5gVjgJZiy78ypNKv+jNX5JCERs+bMTyksuAvNQN+aZXmyFZ6hHIsOvADpz9Z5PfiMJPB1c3mCThr/hRxtpZoyhijIeYSCNAbx9fF9nqy0Ie1PoUrd1N/IJulN0FcyCaQs1rjwx0cVsrmKa3O6DrGygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e/nikoQV; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c14138668so477739a34.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745525969; x=1746130769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oqeEv4v3bOApbNzYbp7XrvULOWufFR1pDZijiIygErA=;
        b=e/nikoQVL23PqT5gAurv4zj5/Bkxuhmp3PJ/7boyIuTJRvO9LnggbvnxZBOMZKOLMF
         F2c1Zpj/kORl70xunoNhEk03Qtd81/kTuRaJxvFoq2nw4DKZcZCJQ1rfjRwDgtW93HYG
         //uhkhU7N7OZ9p4fT1WtxtL/Emm/KPMKbMuYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525969; x=1746130769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqeEv4v3bOApbNzYbp7XrvULOWufFR1pDZijiIygErA=;
        b=RrQ/hFs9wFbBwTt0BzTaNj8oWeaKksO7Lpr5DS7omfq0A8jeblKbyelyP/02OvxIaQ
         IMcKYKukNa0qZbcyIABZFn99JXlaExF0H24Pmd9RCMwspSoI1FPbnpUfdvVxMUtvD2cq
         UT0hP+shci2wcI9EaXqdm43y+BrcOE2poSbLp1k0cqK71AG3QGNJDOGVORKDssh/3rWO
         z9t+eP54H85bARIZ50J3uhelxwULwyr6AMOJSgESmOxYjFwbkulfn7yfIifTIcWJniv0
         +4semQtHGOo06FwnzfrZ5eOOm+wks3BSGMf4pOx0mmwPBWkhul25IRhiqh+L2yyUGMdr
         yRYg==
X-Forwarded-Encrypted: i=1; AJvYcCWN3rkfTMJW5YUFMkK81Mt/F89heP10/a8rHM0AxYnhzFOiCeBtudk7t+uB+HgLj32nN1nJC2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrjKMR4xHJBM5MMCPqlMxRoNpJJaH6yxGtRStG6yG3Mn3k0E1t
	SATZlp8eS/KAB7V8/hXkSymmlg/QySYaAuVhqklXtJwOaJy0ciOLnXyTXzHUpQ==
X-Gm-Gg: ASbGncs+oLb6IB+WtCGN7v32iW3u4s4nhfB6g5Iq+f0Di8zbqKYOkdnsg2tvA26qPTy
	bQ+UPpG4kPK8AHprcBJVO7AGku8RPj/9qdzOlutFdi+z4gr28ZUC5OsUHYKq+jzo22P8I7igyKW
	FE5g0Gp8QjnP/QmKnNyT5UMrLEYvHjNROIccOafAokoUboBMMC4FpMcH8ege1oGgmKfO8Nw1NW5
	2D0ndVINf5axgFz5JMrfUviC0OKuE8+pq15+7tidqjpQu4u8ILrU3D/5HgYCqKln5xxGwP9Gnlr
	FTTtHOI9coT6dsF/h3vhynMmU1gxH+n7CrL4LXYQxb7j6oO79KVreKbdbpPRwQNT2zKOJvsTDt0
	WQtZ6AqnO2WiPX4Y2JnT/bKQ=
X-Google-Smtp-Source: AGHT+IGsXz56lKf4pUSfPxhe42rAmvFdU1I04LJ1E8ANRdMilQHTZi7Iaf+y4D28BUDDt4Cusrd9xA==
X-Received: by 2002:a05:6830:3883:b0:72b:9d8d:5889 with SMTP id 46e09a7af769-73059dc0180mr943568a34.20.1745525969298;
        Thu, 24 Apr 2025 13:19:29 -0700 (PDT)
Received: from [192.168.1.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f37b158sm364084a34.49.2025.04.24.13.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:19:28 -0700 (PDT)
Message-ID: <acb0ea07-a2b0-4a3b-9631-253cd7a378f8@broadcom.com>
Date: Thu, 24 Apr 2025 22:19:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/8] dt-bindings: net: brcm,unimac-mdio: Add
 asp-v3.0
To: Justin Chen <justin.chen@broadcom.com>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20250422233645.1931036-1-justin.chen@broadcom.com>
 <20250422233645.1931036-7-justin.chen@broadcom.com>
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
In-Reply-To: <20250422233645.1931036-7-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 1:36 AM, Justin Chen wrote:
> The asp-v3.0 Ethernet controller uses a brcm unimac like its
> predecessor.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


