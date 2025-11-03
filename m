Return-Path: <netdev+bounces-235261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679EC2E594
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 00:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C37E1880644
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 23:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5529B8E6;
	Mon,  3 Nov 2025 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VNu3ql3y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E2E4A23
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210830; cv=none; b=TsB1IQqVkBbjDVwATh6g3HO2HPtE8u9AQRbVmhtKDnOZoWr0dgBg3rz0K8gWqL+pJRyZhn+ezuGgGo/HNMMTZglVRcG9G696bXUgnhuLqFg2iSmdKOUu8PDQGj77NfgrIrBXVEHUIV/VldkRjdXh5g12bbNgXG7gENZJHFp7DyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210830; c=relaxed/simple;
	bh=/lW1HzddLQUZKeF4KgnyJzqj0WHWuf2zCzjsyTOf8II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feP8PBTwtaHFjkE9E+Gx0Ev8Ic/mvqnJRgUY8y9TrCnf0In6cP4wiYnF0VYv8ZpjkHQJcHcJuKm/Ro66B/dvqZt6PEGXNvxohoA9egUkjVxAl2ijMI8m0aV33NP/Qsg/xgkDOwFS47foeNJj9EPGYz0EE1D6qclKBP3Upu51aSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VNu3ql3y; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-330b4739538so4857208a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762210829; x=1762815629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0id5Lo+9IJ6LPYuXiU1WqYasBQQKw7fISIlar/OOWY=;
        b=Qx4uC9J+8RKrJd6M4QsE18NY7yYuf1toMkTJoypMhdDUlHMslU/4XtUzwc8KxRmJFI
         Da+9bi7Kdb2P64/rzjwMcF1AQb/WP0oJ9YmSVHIS2b7Ul9YkFNLRID6LpamLF9Xbi5cv
         foAaDdbUUsfjrquL6IeiPTgwQ0OPwDTYbr1W69GMBt2m4I41ivLxwaNWtMsU4PQsbavT
         t7eTxL2zF459ZTg0C6DokFjvrdEPWF3dS2+G2ZQzbU5d90/OiVpGQVcbxmlQTdmeurza
         3XuDgwlqmz6YYCfIJjVFhreTSaRD9tEIMIzmKquaosogqRUTzG/bJk6166TywKh+jZvr
         Ay3A==
X-Gm-Message-State: AOJu0YzIYYCZwkfWZmOMjZCYjqQwCe6sCTuoVSHvCzBkKEP8idb4omsi
	L+DqrhHZKQg1bpZdPoaM8TnuuCLLyXYCX6Lc8i3vvcNy0yx+s+L8MJvm2/m5oxYYbGzQl6UFFc4
	PVtOb6zWtS+3WpxeoYABbUrCmLk2PkXP3/0prPtvzmPvqSsOQ8F85KpsipIH2w56DVJc0AqxKV/
	N1Ua/XHYGQJcB3UapQ0ZCRUkVdDq9aZ8dVliHBvsgerLb9yCG63uN3sHP3eZY2tvnMq/nqX8tDX
	7UMJnqjqBx7sXdG
X-Gm-Gg: ASbGncu9Y5nTUVm+juypQOaW0wRRq1dYaUi9k6pbvD0h/beD6WtZrORqUkiIPVZdO02
	/b5rGh6OQUnt82nkWyKzyePsV8dGqwxh2mE8qWC0I3exT/cYWQwu84Pc2tPcbg22KqfoPbTG0sI
	VdBpeD3WT9Zozbet52VdKKyevdQ++CWt7hr/ccs+1mspus7J6lMJ9ok48l/qrkQ+ZfluWZfW03+
	YmWknDJX/jAgidRWGRZnZmK0imgRGwwlsGV6TosliOITF5ncT+jwhXJbOneSD6hz5qm5OBL56S/
	6VF8GzZ3KGuHCHGazZvbJ3G9elqbwGYvPMSiWVrwczaiOeF6iij1Sa2AtKwdzoWwepveEkeFj1o
	bgwrz29QTnSI81wGkUokSgKz86WnqMixnjXbItTYoJOUXZcv6pIDldhq42TzUP6gcR/8a6/M81J
	Wl+vTJKTIDXLVf6q/F8wuCZu3ELgPwUdOFzo2W
X-Google-Smtp-Source: AGHT+IGTH6I+Lv2d6cSu1su5tNxaQpxOoTPuEoBd6qWLk7sZoJVCmBMBzrJ3QzfBXa3ywgQsTKCBBvsgWbAx
X-Received: by 2002:a17:90a:ec84:b0:329:d8d2:3602 with SMTP id 98e67ed59e1d1-340830745a8mr20134640a91.17.1762210828665;
        Mon, 03 Nov 2025 15:00:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-ba1ee06cb24sm22968a12.3.2025.11.03.15.00.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:00:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3409a1854cdso8774083a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 15:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762210826; x=1762815626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K0id5Lo+9IJ6LPYuXiU1WqYasBQQKw7fISIlar/OOWY=;
        b=VNu3ql3yF8SSISfjeMpLYfivd5rcw9bI9vtjhG77AtnS/+0wl+5A0Bynp4+5SmDdH5
         O/OD17FHe6LbNe9VjDnPl/3HC4cceSz5DeuplLSpAG5bgQ7Yo5SgNM4pb9AgLjZE8f08
         mccfalVNK3wrKHPsQZxrBaqLj4RlKydsfIh/w=
X-Received: by 2002:a17:90b:50c3:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-3408309e698mr16646436a91.33.1762210825689;
        Mon, 03 Nov 2025 15:00:25 -0800 (PST)
X-Received: by 2002:a17:90b:50c3:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-3408309e698mr16646400a91.33.1762210825276;
        Mon, 03 Nov 2025 15:00:25 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bcb9faasm155726a91.1.2025.11.03.15.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:00:24 -0800 (PST)
Message-ID: <1ce81ce5-1c09-4663-915b-16ee58e19035@broadcom.com>
Date: Mon, 3 Nov 2025 15:00:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: bcmgenet: Support calling
 set_pauseparam from panic context
To: Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Antoine Tenart <atenart@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Yajun Deng <yajun.deng@linux.dev>, open list <linux-kernel@vger.kernel.org>
References: <20251103194631.3393020-1-florian.fainelli@broadcom.com>
 <20251103194631.3393020-3-florian.fainelli@broadcom.com>
 <f9a32e33-9481-4fb7-8834-b36d88147dc2@lunn.ch>
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
In-Reply-To: <f9a32e33-9481-4fb7-8834-b36d88147dc2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/3/25 14:19, Andrew Lunn wrote:
>> @@ -139,7 +141,8 @@ void bcmgenet_phy_pause_set(struct net_device *dev, bool rx, bool tx)
>>   	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->advertising, rx);
>>   	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->advertising,
>>   			 rx | tx);
>> -	phy_start_aneg(phydev);
>> +	if (!panic_in_progress())
>> +		phy_start_aneg(phydev);
> 
> 
> That does not look correct. If pause autoneg is off, there is no need
> to trigger an autoneg.
> 
> This all looks pretty messy.

That is pre-existing code, so it would be a separate path in order to 
fix, though point taken.

> 
> Maybe rather than overload set_pauseparams, maybe add a new ethtool
> call to force pause off?

Yes, I like that idea, that way it is clear which drivers support 
disabling pause from a panic context.

> 
> It looks like it would be something like:
> 
> struct bcmgenet_priv *priv = netdev_priv(dev);
> u32 reg;
> 
> reg = bcmgenet_umac_readl(priv, UMAC_CMD);
> reg &= ~(CMD_RX_PAUSE_IGNORE| CMD_TX_PAUSE_IGNORE);
> bcmgenet_umac_writel(priv, reg, UMAC_CMD);

Yes, that is essentially what needs to be done.

Thanks!
-- 
Florian


