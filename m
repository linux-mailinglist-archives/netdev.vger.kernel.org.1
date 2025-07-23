Return-Path: <netdev+bounces-209465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B52B0FA0C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5359A16EAA1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191D225779;
	Wed, 23 Jul 2025 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S4Vc/LMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD251EF38E
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294415; cv=none; b=gNARn662wjBXj5SSA3X6mHxtgG1ycy5Ui8Ddv1uQMYzRihLvQNvKzxzO8UzenrrSM5bJatK4LQKcZyjv4Ro2cHt90f7YEnyUdZq7pwjP7UQWt2a/TaiV5+5qAybNfDvcK44xH7nbYE1QDCzmOiUw4qpRzhX/mlfrXFiBr+BsMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294415; c=relaxed/simple;
	bh=YdmNl10OUtC/re+EOWea/4ZaPSgqrvrQjhgHJMPnSwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldiIB+bOWwB3BwdHcuoqhXm8iukUktclzfEWt8SPftXom2vDeFx5qNb8wMMNMluh9rU0ukC/nHN9vdno6Zj4xujmLhR/Cma60Umejt6Ug7fY3uQf1kDQABwfaLkdOVf0jQYdSCFq1JurEUpsGAf8CBidAx2oDN3doiR8K7y79dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S4Vc/LMG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab5953f5dcso2370341cf.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753294413; x=1753899213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jRAUCvyU8pYPmWFn/9AeIOCYqe0g5gOFDinoFnUur9s=;
        b=S4Vc/LMG/UbBn60mEcc1YZSRMdyjRXQypAkgQ3YSzPs63VIra9Gcnq6OfxsZ+1cWqV
         gCpK+eHD9pkmbnPxGjwNxGIJ3elpcEmmcMHcG/meqR1vnm5q3IqNdSYlEJQdh/avC84d
         R1kPIVV80w4A11HylQUFi2nnvOfhBYgZdUwp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294413; x=1753899213;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRAUCvyU8pYPmWFn/9AeIOCYqe0g5gOFDinoFnUur9s=;
        b=hD54Ga38yboKsxlx0LCfHzZoUAXPNvNtZwQDXHsAw+INq5DTIDSfx8gtQbEqGSc7in
         /jGeCurAiTTXP8s4xzpVJyTKqiii8kbOTZ7Lg+wElKlcGDChaod+4KvjcewhoM5IYXW5
         bTwRdXQEBAz4+QGKYMPw4QsMWfU9JQMNWiKwlz25SQRiJPpo8EuIdo4oS4P0d4tsPHbr
         fB00Bb7Q2QBxzhUW84Vubij8L4cFTOJOTKkX4vk3+c0ikVz20HPg1ZKDLseTWTNA0+fs
         VnmrxpUSufqwykYZ2Zo0VWGIuz02CEuwSLOrANymsBIS8b3cKOlhb1YlggsyJl2B5+t+
         8rcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw8IfpZIlqQaLrffZz09sYuBTCbdusTe6qXWA36WpvKIGv5scZJKTLSUhLyayi8ZVJCDEpFsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTkeh7qbHMydzLu9bCxgwseTif+oiNFndXle+FSohqBXtM6oZ
	AFkwmYFcToXzLwpVNEs6BUtbSpZ8c/RgOpncskpDrEDjj8ZVHTpCbEoYkM+gpjPMAQ==
X-Gm-Gg: ASbGnctmTHfYsQuwPh39WPy5nNW0EntS4PgXf2UBUoFcsp6yEeONuaJg/xI/M2waXPI
	JqBXgjTGcRbEFpeFfz85USDILoAVaT9eSjZExkSCOGS6eQ1GeX1p9hpOyBo74Zv/0zRjqe1jTMa
	q3tXNB1ize6DQibO44mSd/CTBd+87mQvsMTCzsY9yYZyXfdvXNk1cIiieZLA79Mbkp76d/H+Uuk
	GuwDdF8zqkJ3ixJ77H2zTwg6GxhKgU7X8hXR7+WcuF8upXPdW9MRlL8UI4VDhje4HqpK/lZMGTC
	9Yr2zVPjX/gCPU6nF/cRcboMxZK7pZgGXmnY42NeNCblnjizHc+tQTMnbCZRx1wcZDd7EpiCcP5
	WVvuXyxbJSVKlnJHiIzABU+BstQ4NLA05tjvkxATYq4hT85hgZothA5IyL9NvRg==
X-Google-Smtp-Source: AGHT+IFEF43RiqqzhjaLFGYq5MEC9HWC1y8/iwg5IEvEfmbn8mT4shMSnIGatZImTK+5KIX285TGZw==
X-Received: by 2002:a05:622a:59cf:b0:4ab:66d1:dcdd with SMTP id d75a77b69052e-4ae6df6ebecmr72328811cf.39.1753294412889;
        Wed, 23 Jul 2025 11:13:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abbf5575bbsm62437351cf.24.2025.07.23.11.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 11:13:32 -0700 (PDT)
Message-ID: <69711c9c-b85b-4cd4-a5fe-2719b8e30438@broadcom.com>
Date: Wed, 23 Jul 2025 11:13:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: Andrew Lunn <andrew@lunn.ch>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman <horms@kernel.org>,
 Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <ae31d10f-45cf-47c8-a717-bb27ba9b7fbe@lunn.ch>
 <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>
 <9f00a6cf-c441-4b4c-84ca-5c41e6f0a9d9@lunn.ch>
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
In-Reply-To: <9f00a6cf-c441-4b4c-84ca-5c41e6f0a9d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 07:23, Andrew Lunn wrote:
>> We can't retrofit such detection into PHY drivers - if we do so, we'll
>> break WoL on lots of boards (we'd need to e.g. describe PMEB in DT for
>> RTL8211F PHYs. While we can add it, if a newer kernel that expects
>> PMEB to be described to allow WoL is run with an older DT, then that
>> will be a regression.) Thus, I don't see how we could retrofit PHY
>> WoL support detection to MAC drivers.
> 
> WoL is a mess. I wounder on how many boards it actually works
> correctly? How often is it tested?
 > > I actually think this is similar to pause and EEE. Those were also a
> mess, and mostly wrongly implemented. The solution to that was to take
> as much as possible out of the driver and put it into the core,
> phylink.
> 
> We probably want a similar solution. The MAC driver indicates its WoL
> capabilities to phylink. The PHY driver indicates its capabilities to
> phylink. phylink implements all the business logic, and just tells the
> PHY what it should enable, and stay awake. phylink tells the MAC what
> is should enable, and that it should stay awake.

We would need both a phylib and a phylink set of helpers because not all 
of the drivers need to be converted to phylink.

> 
> Is this going to happen? Given Russell limited availability, i guess
> not. It needs somebody else to step up and take this on. Are we going
> to break working systems? Probably. But given how broken this is
> overall, how much should we actually care? We can just fix up systems
> as they are reported broken.

Please just refrain from making such statements, it really just does not 
help, and if you have no direct hands on experience with Wake-on-LAN, it 
becomes purely gratuitous. I agree that there is a lack of adequate 
consistency and guidelines for developers to implement Wake-on-LAN 
properly, but I don't agree with the message and the way it is 
delivered. It's just completely antagonistic to people like me and my 
colleagues who have spent a great deal of time implementing Wake-on-LAN 
for actively used systems, and I am talking hundred of millions of STBs 
deployed each of them doing hundreds of system suspend/resume involving 
Wake-on-LAN per day.

> 
> I also think WoL, pause and EEE is a space we should have more tests
> for. To fully test WoL and pause you need a link partner, but i
> suspect you can do some basic API tests without one. WoL you
> definitely need a link partner. So this makes testing a bit more
> difficult. But that should not stop the community from writing such
> tests and making them available for developers to use.

The tests are in premise very simple, but you need a link partner and 
you need to be ideally on the same physical network and you need to have 
a system that supports system wide wake-up, or if nothing else s2idle. 
Then you need a secondary wake-up source like a RTC or GPIO in order to 
ensure that there is an upper bound on when you timeout for not 
receiving a proper wake-on-LAN trigger.

It's not clear to me what needs to be contributed to the community, but 
essentially the pseudo code is something like:

- wait for DUT to boot
for each support Wake-on-LAN mode:
	- configure wake-on-LAN on DUT
	- snapshot /sys/*/wakeup_count for the MAC/PHY device
	- enter standby with e.g.: rtcwake -s <TIMEOUT> -m mem
	- send Wake-on-LAN trigger from external device
	- ensure DUT woke-up before <TIMEOUT> and check that /sys/*wakeup_count 
is +1 compared to the previous snapshot
-- 
Florian

