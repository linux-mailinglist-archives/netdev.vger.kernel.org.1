Return-Path: <netdev+bounces-177773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8189A71B23
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BEB7A3A62
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85891F4160;
	Wed, 26 Mar 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X4QZMjiO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200521F192E
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743004360; cv=none; b=Qh3u1ssYY9BVsGzqJfZC5+FXJ2d8mBF9lll8eMN9MRuA+0lcGDGdoXYiqL0hLMO4LHtVq2YqBNlaDDuM8Yayog2qF07ujkuscwe5JnC50NtMArcX9TiYZVjdm3jOCOLManvFLzp2OHuMdTrpavv1O4Uv4pAjwfzPePlqPi8DIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743004360; c=relaxed/simple;
	bh=DpXIFSPHgxrC2L3bWup5TL2HI13UFYbTXWR+IdCZMGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQhaO3Vl6RLrtfaGvqmrv5vaYIaq8sNeqF9s8IQbll5KbZtkLeSrZBwbjj5QZZotZrST3D5f790qUiC5mV0AMZklvZoAkRKB1XobzvN+W8cgAOQr6gON54joOCZeJCJBIPnNErl7KfdpMGOqSdA5yNkW0u6taP++vnS3LjxJQyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X4QZMjiO; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3f6eaa017d0so5069199b6e.0
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743004358; x=1743609158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=udItE5Q4k1y1BqI3Fo6NEtGka3OiY9ULfIZMY+8LN3k=;
        b=X4QZMjiOygg09QkdYEG9mzcsade4o5jZfvtV4gfqIVhnIP22EiwpUQu1UjDb/z1mxc
         aLuQ3mQBDFWU9oabic0E1Dg/ApG9LvtPn9V+aAKSM47yqcr1bsMR4w5msUp5UMgwi64C
         J2Ye/EFYn9n9fWGrtHtBxJ/tTZ/Jvi/JfZrCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743004358; x=1743609158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udItE5Q4k1y1BqI3Fo6NEtGka3OiY9ULfIZMY+8LN3k=;
        b=D2d0OR+T4JuEKWelU/CTDoZP2mkd08Y05/aZJmtMIdN4U6betHa/H/9EMXR5bl+wfZ
         VXPwfwNcP6/q9VHk88OkWMvJklCUIXW89N8K3uQhVbCQWXiLVKX3szddBFMCBYWhLn9v
         rKrEdhejma5JCtNnoHnFziakYZeIgwa4XoIcwafAUVUTOKScFM0U6ACKEOxWJDLEC5yu
         7g9aHF8pldpJ8vAz/AVouJekl7OJZ301AoRGFqBLj8lEn4/v/7nSbmhtavdAbCXfXYzy
         72lrWlnsNLpg5HDJoGn5p9V9H7nGSm7t/dwLjea+P1njiyEDCfihjXjmqreJondcpkTT
         VgZA==
X-Gm-Message-State: AOJu0YzCRAwkk6kxIHCry2Wl0LegXl4SGEbhCZPgFh8R5GAPsla5alft
	q3Zw1N93jGgi7JscNoB549bqCph8pj0SCVjWcZASOj5GC7QywFYgB77pRP2Nk4+KezZ/58vQ4JH
	e4w==
X-Gm-Gg: ASbGncthf0E5d+8WI2XIU95V15PryeyG03ml/s/MQ1HQnEiCmft/hWwxMNRrXVnhyPJ
	KOvJyZMRjKXQzsW4Y73GE3zqDVkJIPqTMK9FxizpoHSM29U5JexRT5f2FPNYimvKoRgaEBk/fNC
	p4qEYEqYHPZSrFxy/qRc+gr3tx/+JqDwA74qZA0+jzsNkcJCrcN4MHvQXcnYPzEm2nKVw+Wv7Fn
	tFt6Wol+RvUH9eX5KxTrJlGqddspRTt7hw/oKuveTr6IInLiYmFsJZVqjl/9dOiSUEb5iks6N59
	kcQ1RUJRAsmpq4J9ynf+XwelWFULgflpFMQ7jryAy4sTD/VibGoIRWZFmhFEosTsAbqzdhRp21J
	JF4oU23Xx
X-Google-Smtp-Source: AGHT+IFztQJJB2FbWxTixC/VzEaxyykXn6Yty2pQKlozj02r/Do2ZskiPh4HM8CyCoQC3rA7GhTSHA==
X-Received: by 2002:a05:6808:3995:b0:3f6:aad5:eaba with SMTP id 5614622812f47-3fefa4e5d85mr27739b6e.7.1743004358031;
        Wed, 26 Mar 2025 08:52:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf79219csm2444046b6e.34.2025.03.26.08.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 08:52:36 -0700 (PDT)
Message-ID: <e367382f-2934-44f2-aba0-a8297d417548@broadcom.com>
Date: Wed, 26 Mar 2025 08:52:35 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,net] net: phy: broadcom: Correct BCM5221 PHY model detection
 failure
To: Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com, andrew@lunn.ch,
 hkallweit1@gmail.com, kuba@kernel.org, linux@armlinux.org.uk,
 edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, giulio.benetti+tekvox@benettiengineering.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20250325091029.3511303-1-JJLIU0@nuvoton.com>
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
In-Reply-To: <20250325091029.3511303-1-JJLIU0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/25 02:10, Jim Liu wrote:
> Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.
> 
> Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v3:
>     modify BRCM_PHY_MODEL define

Humm, I am not super confident in modifying BRCM_PHY_MODEL() since that 
impacts the entire driver, how about just using Russell's suggestion:

if (phydev->drv->phy_id == PHY_ID_BCM5221)

all over the place? That also paves the way for getting rid of 
BRCM_PHY_MODEL() once this patch is in net-next.

Thanks!
-- 
Florian

