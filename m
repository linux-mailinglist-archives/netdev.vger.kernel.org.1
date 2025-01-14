Return-Path: <netdev+bounces-158217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D2DA11194
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E7147A07D4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D220ADCE;
	Tue, 14 Jan 2025 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cnAB9ald"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9320897A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884676; cv=none; b=aqUy4dqlCKiaDgodj21Ee4NJvnTyHKV6KPGC2I0zNsvyBl8cybv0Sz8dCnSPKu3Vq3KQVkwdtDUjggYm9zACMaNoFLT+pmEE7e48/xWrG+1qLUoBLer3MGxiGnbgeliPg/fKu8/9/AdcGb4cdCnJLmtrmsTtD4Vaqjs6sfx/1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884676; c=relaxed/simple;
	bh=v8L92saIT/VdOldwiqFcSr0I0aSU3mSj8DlkKFbeQWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmxzeOgdbjtJvbnmnQ//48RE4QkKkNNqHVSG5+L2XEixwJ2IDFX47dfOQ/iq1LGR+c/4MSe8UGS3bNgCybHwrdlo0ABIukqcdUGxFmY/cDBnir5pcUClUCieDKkIsC5N2OvAUx+sW7IZ0iNrVAoMZz80P9Bll7xevQ6FFAafJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cnAB9ald; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso7822235a91.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 11:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736884674; x=1737489474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUw/ZeDkPopKgnFRpTi4hpRB3jFPlL1S2JcO4o2h5z0=;
        b=cnAB9aldU6Ob6BXt2PLQXb8uwUUQ8Y4EO1DeFxFa6U3ILsQBFo+jufjLWIYqzZnRDO
         igEQJK9IKM6FcooH63Ky/KIdLMW+HOlo4dAn/3+y0ZptPnTNzgocIuwLw1TP7oHenWky
         HW4ZSnGNmwYwBq975Hurc3qQ04+lBBEEZWxcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884674; x=1737489474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUw/ZeDkPopKgnFRpTi4hpRB3jFPlL1S2JcO4o2h5z0=;
        b=HbQ69/D+B1ykmPrA1QcCq59sJ2YmvaWNxSPUmUuHGC6YVl25JU7VXygTQ9FmpKj/6b
         YFGdzS1iy6Qeh8CEcpcOTgm8mGvRLXk22/bQyzHdsHn71+zR27onjKuvAnsqS/mKAblT
         2CWmi64HpYVdJQUjvtShbbmjp5+eQupBiCwU/2MvsoEXKaCY7lx6DmObz83GEP0KqAOV
         oCTR38nQBrCDn8FyxWPgspADaoo9p3ZwZ+IqBvVyIH54hd6/4qWvgkng7kxYKmGX32sw
         RRb5WAd5FRm0ayEtU+AhQfpmqnh+CtKx/zM1het2a3oiBBMtVONgKgF5CaEhRR4FBQLc
         Cqaw==
X-Forwarded-Encrypted: i=1; AJvYcCUi1UuD0jJFZva+mhcym+tagCcMn6nrGkA13oSbq/1Zwg3rauwdKdzcPncePfDpOjjBGEiB/8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xoz8O7wmeRrrDb6tsspEPDlnD2NBVDxG/Mnu2cCaGA1gYssV
	8qoBU/g+IrdSI+sQMXKWkVNIGFxd5zNgFL52PbUn+90L0zpVGmRK8cip4mG2Hw==
X-Gm-Gg: ASbGncvi652NGHuPOPYM/nt3Jv2GNCoPsVDydM+mlg0aX9VYgeq/i3aubN57xSDzxP/
	oKtxqgrs72UYNHB+f9htoy/RSkzGAFBPT58EdkODbA4oGnL/MJXCBkq/DBZPjv08Ve99/mZMEna
	pb1YssYMWluPaWNsMX0Tdc1lLKThhnH6YEvzt7GcZw2GuZ65y98iD4rYBYGGbL5uF33VYjyjGPs
	lKaKdBR0N7DVt2y+xlXb2tfpXs6qzM0+7JFW0vtKAlMFrUTqc3QDGvDfWCwTZ+KkJjdmhGhEiSp
	DIk3ypazl/s7Mo9pLIHl
X-Google-Smtp-Source: AGHT+IFMGMiR0LT7rxwIrB6l8pLqQknnW2H0ZV+DadTzbT7b+lHBRV1FrSKUmCDwIvcJyhm4SGGgsQ==
X-Received: by 2002:a17:90b:4c4f:b0:2ee:ee77:227c with SMTP id 98e67ed59e1d1-2f548f102d1mr35753971a91.3.1736884674279;
        Tue, 14 Jan 2025 11:57:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5594697d1sm9855771a91.42.2025.01.14.11.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 11:57:52 -0800 (PST)
Message-ID: <22825393-f6a6-4ca4-8dab-c9491f1078ad@broadcom.com>
Date: Tue, 14 Jan 2025 11:57:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: bcm: asp2: remove tx_lpi_enabled
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 bcm-kernel-feedback-list@broadcom.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
References: <Z4aV3RmSZJ1WS3oR@shell.armlinux.org.uk>
 <E1tXk7w-000r4r-Pq@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tXk7w-000r4r-Pq@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 08:50, Russell King (Oracle) wrote:
> Phylib maintains a copy of tx_lpi_enabled, which will be used to
> populate the member when phy_ethtool_get_eee(). Therefore, writing to
> this member before phy_ethtool_get_eee() will have no effect. Remove
> it. Also remove setting our copy of info->eee.tx_lpi_enabled which
> becomes write-only.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

