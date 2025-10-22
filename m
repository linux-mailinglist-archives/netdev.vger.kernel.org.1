Return-Path: <netdev+bounces-231843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD3BFDDCA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F22E8358DAA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C2128725B;
	Wed, 22 Oct 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ca6FhRXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3258F34A3BC
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157891; cv=none; b=mPrSLxFDV0l2pyAHAM2w7xD4i7hQZlhw/77rVQHOcyX3XLPW6tJo9DXHTDq4aiujTaUsQzSUioFHgGWO70tnZVJOCHphHEPBFU1EhyY6/gozojPEOBoIX0o4HTE3dD7f5ZGVWk7g8g5p1KArlT//agYq4SslT1pGMCqoBKieEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157891; c=relaxed/simple;
	bh=JV0mQ1Xwedn+vBOXvjzKdjKxyDTofVcjrfvkRIq7k0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYsKBdazV3zqBuYkRnvbeJsuhdkoO6FkdJ8WnoLQbRzL6zJlvouw1wpyxTIMGy0P9FaZdMxDOFdV3IPP3ih9upujxgnExY/oP7ljpfAubJQpCnG83/3elOfYkOUJex+uamk9663cxIvI6lGfeBJHlWJdofZuXv79ts5ZHn1K0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ca6FhRXn; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-93bccd4901aso596141039f.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157889; x=1761762689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI+rhvxEBxqKNkYgkKodZ5I5aGcum/RfIbS5GB+RU9o=;
        b=JmHn2MTEV/UBbZIaqDl9crSWC7aMiMYnJ5S4sikIVbyfh9rpHuiZDYd7QlKgJkX+Od
         oDjfgewejTWFCuhPRG7L5bCmDdytc41DJ8sa28JAh5pxS4t3yE42Qb35Xk1JcaorL3wG
         mMzPF+AeqNe7yaeY9/OqVjcGGlTlTEmizwo6wpv4aX9TxeQ7OPt79OgnUMLjrBXECIvT
         JuYARr2G71eO0r/+9U8yGCs6D1M1jVcBD3Mk/r89QHmhN6sdCbhx9RArT1O6Xuu0tSPH
         rcr5T4KObUUq/WA3Zvbq+HpTkJUtSenYi7goiETOAZC6hU5U5NIyDV/TKfdD/OTApfHp
         unNw==
X-Forwarded-Encrypted: i=1; AJvYcCWNjHclfXN+WkkNDdHxwHHUgK7t3uVPVqkcSCe3yJCGMjgHlki8yv/6ArLwXwqPt7QA8XAe8X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgIqnek0N8zMugAoRw0uxsa1CoqPpoH/VT3Ym8xkwcf81TUrh7
	VX2H1oJn4E3zDnFBvv+eW0RDAslKJhDIhUc3qIOVm6ojOFeCfbx8P/Ehr9vU4RyUrQaOwjLadK5
	bncOdabHXBXnxp5+lnODbRW0kcxJIaeOB0CQj0rtSEmiHnI02cJCgEfEvjy0zIqYuAzX0C/Pq0J
	KX+xBmx1S7Hc9D3Cjvy+KMwJhi9P4ny83z1Cms4rRbYgNTGKDfF4kDdcP/4BgC+Eyy+7cyZSrcT
	ZHKQuyoIAFHNCsN
X-Gm-Gg: ASbGncuBMSVHaQy80Kv2mYduThjee1OV0jexsxKpqTC43LN00XghPzZBvTcu8eD2xuv
	bnZgDHT5nSpvlRAH6dYd253Uo9mdcIcBYsPivw2sLuTV6jK2TQ7sg6iCMyXpTII/Bv2H5hQN0Xk
	kke+v5WFEABrJZQk9xpMyid2+hSPgnVfMxSckanvfQJnM+OqsrN9Pv85am2nfsfK1wxUwlRlJ/G
	H1xBeaTFssKetFNibkdT7IVto73i+7mILUylYHC67ENRiOF+1tA4l2v+YMFr/d0G/djRdCIrJy0
	g+nv5coo6BrOnPux0m4CPTGw14NdHjqmaZ3d7zdW6QIozqEc34uM3744Jo0vouSA2W9sj+2u6qv
	ywu7V0mB4BO/237qL39zT4v5Zy/R7sPBgjqd1rNkuCRkv4TmhWYfxD14ku9vStkSVp9tu5tPRMQ
	8Z9lMno+/Ssxs39a+jejLSKCekIoBYZSiawhMLdag=
X-Google-Smtp-Source: AGHT+IHI+gQ8uFSwAdYz5loJxHC+ZoBVvr9MUhShNHs8ZOKvIuZYj/nRgrM0wr9M+fzOpaa7dOjJX77WUwA7
X-Received: by 2002:a05:6e02:160e:b0:42f:8d40:6c4b with SMTP id e9e14a558f8ab-430c5246f89mr339983695ab.11.1761157889154;
        Wed, 22 Oct 2025 11:31:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5a8a9629c88sm1565102173.18.2025.10.22.11.31.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:31:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290bcced220so63566345ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761157888; x=1761762688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xI+rhvxEBxqKNkYgkKodZ5I5aGcum/RfIbS5GB+RU9o=;
        b=Ca6FhRXn65Adp0hUasd/fvZsrYLw9JlYmY2qafTfLOBwhkDDyR+aqD1TTLgZaJujoY
         07hsYEA9ichef9p2tq2dCZsEV70z2RVGmmyW8o19SGxr7XNiYJ/yT317O9txwvOhTCR7
         jH4TWd4/cCW0rgvuXblGxDsiC5ngT3jtttIvU=
X-Forwarded-Encrypted: i=1; AJvYcCUG3qmsN80Dij7H6XKWJx3hp2QIruZ+opx6qrdUfnVNiEGt35C2yTZldHZYrzbagysjW+FsbbY=@vger.kernel.org
X-Received: by 2002:a17:902:dac6:b0:25c:ae94:f49e with SMTP id d9443c01a7336-290ca30e40cmr257832565ad.37.1761157887755;
        Wed, 22 Oct 2025 11:31:27 -0700 (PDT)
X-Received: by 2002:a17:902:dac6:b0:25c:ae94:f49e with SMTP id d9443c01a7336-290ca30e40cmr257832015ad.37.1761157887301;
        Wed, 22 Oct 2025 11:31:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebccf3sm145602945ad.1.2025.10.22.11.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:31:25 -0700 (PDT)
Message-ID: <a6882bfa-866e-4079-b38a-ca2ed30609b9@broadcom.com>
Date: Wed, 22 Oct 2025 11:31:24 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: phy: add phy_may_wakeup()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
 <ad16837d-6a30-4b3d-ab9a-99e31523867f@bootlin.com>
 <aPkgeuOAX98aT-T7@shell.armlinux.org.uk>
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
In-Reply-To: <aPkgeuOAX98aT-T7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/22/25 11:20, Russell King (Oracle) wrote:
> On Wed, Oct 22, 2025 at 03:43:20PM +0200, Maxime Chevallier wrote:
>> Hi Russell,
>>
>> That's not exactly what's happening, this suggest this is merely a
>> wrapper around device_may_wakeup().
>>
>> I don't think it's worth blocking the series though, but if you need to
>> respin maybe this could be reworded.
>>
>> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> I've updated the description as I think patch 4 needs a repost:
> 
> +/**
> + * phy_may_wakeup() - indicate whether PHY has wakeup enabled
> + * @phydev: The phy_device struct
> + *
> + * Returns: true/false depending on the PHY driver's device_set_wakeup_enabled()
> + * setting if using the driver model, otherwise the legacy determination.
> + */
> +bool phy_may_wakeup(struct phy_device *phydev);
> +
> 
> Do you want me to still add your r-b?

Yes, I saw that comment, should have mentioned this applied to your 
revision. Thanks!
-- 
Florian


