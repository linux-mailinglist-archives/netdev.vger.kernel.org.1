Return-Path: <netdev+bounces-209106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5DB0E4FC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D107A580BD2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D95A95C;
	Tue, 22 Jul 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y3+wdM9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887526CE22
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216236; cv=none; b=NwEwzczGgRIwjUA6OurQoh4CCLOIRsWuo2LnC8xmy0uoILp4AWlJM3gA2jaRVlzzIZt01q3146DIczC7FDdwAim421TFrNjbjnK1SHIh+Hs7g+OQwW7RUVKYYMawfVCIHbutDLSlzTcGcJbjNffstYHopd5HUsAKPwbaiiEipNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216236; c=relaxed/simple;
	bh=R5HLhd2oskVtl+m81E6fHir5Zlg6HalSgn95K9eftKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6bntOf3LUVEOd8PdXzoX8kHPIaFdTgMSVj7mS1k9fXyYkXW0S68U3I2jlgK+fIH0SIU5sOQmKv9zMv87yBM+6KPE0onmy5Ca/iruNo8Q9ct4DLkGJNssNVsJ/MNYvCPByHqA1czYMsNP2noOxCOWaaEu5AAdZ459W73qpSD9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y3+wdM9w; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e62a1cbf83so19514285a.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753216234; x=1753821034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C0eOoWAY9496jUiB2vuHF5pd/0r+QZAaNXRvWpSvqhA=;
        b=Y3+wdM9wnS4pGZt5r3vBch5xZxn+dPwLKuG+z//Bfg+ItGr+U+PKd2cBdM0OEY2KQU
         5ZhZ90AAhegbKQj6KTUr12l5hRbjXfsV6D+2qmdXpU9FGvZNI2VbMiA8a9ylPYiuIOdw
         XNaYDKsPcE9JBz8ltALLsBZKZtewglimZgGCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216234; x=1753821034;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0eOoWAY9496jUiB2vuHF5pd/0r+QZAaNXRvWpSvqhA=;
        b=Wl73PpiyCgt+a2yhDMu3/mdY3GC+yr7/F9H3OD30tl5A90tn5MgAV0exxU9nmhUTh+
         L4qTlE9AHrcpzo0z4aJ+/ynqiof2zq5jFgcm+2YQmcHDQfM2EG0to+FVgCIUiONxqlNM
         1XkEREAb7sZP97GqLr86I4uCA4BObJ7pUBEx+NDxrwk/rvhOUg9cQFvDXgbSVUz2+Ws9
         vWBSwjqf6940oOPO+vPPcK2arS541h5M3cKP4J89JSSptHf0bY9ZTMNLqi17Z+e2g35O
         uWndKgsjb5ZPAlO9iEF5mQiwUS9pNx6P24s3wLel2u9eIJkD21ej03bG+xu63ISjyjtE
         QA+g==
X-Forwarded-Encrypted: i=1; AJvYcCWO+BqdiaF83lUstF85K9tvIWmIKeZtDzWoT1ACMgxHB2cV9vkoAX+zHOLTNFqkKHAGjaj6Cjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7yxUaBZqTFGU2BSqXz9EzjT5yG5gEIeF7pSAxsK2K5EQSob7S
	nIgNvCuvX7jcoVfFuURpj1pQR9a/GJ1V1nNnmbfa+Gc1POmU2ap1bVA/rowuCpRjpA==
X-Gm-Gg: ASbGncsBnDQBPpwdKR6wZlPT4hh7q9/0iXk2Qlfwy4qlsCt83VuTo77mUmZ6g0qJhai
	nEUZ8uy7Kz7t7pLIPT87VOd0FFc8UaXOYrYzcUCrRc0MimJP2MEquLzJGVRa1Tk4xBlO4gsjFmN
	eHTZHPZFfMtfqcw5o2Pod4RT6SadyArmJxdujx45AlHvVYNQl1Yq7iXorvYZhY9FhzbjL97UVtn
	fskeGcswDfqbKjiMu0OVeaWUcoa2iDnbobh6YZ3hhaVidW0z56K3CEQ/l6VSowsk4BLMluSP5kH
	iqMwoM9+TzdmniIhsKz4lztP5gdh5hpNYqdlZw/lewsIX2EEZITmgRF2J/oTvOj311a7EEpnJrk
	yv0hkN7z/b5HlZ+jpHHCwyJOTLNN/TOFE7iLSF7gPcXbE0maBLOTcY/inS9OTiA==
X-Google-Smtp-Source: AGHT+IHPgae5UqXTaq+pQoIZUFXjLrf7YpxbYbZHd50ldnbPVOcMotdpI94wHHx7zju3ly64oocICQ==
X-Received: by 2002:a05:620a:1094:b0:7e2:1117:55c4 with SMTP id af79cd13be357-7e62a17ce5cmr70674685a.37.1753216233639;
        Tue, 22 Jul 2025 13:30:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c737b5sm585921885a.87.2025.07.22.13.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 13:30:32 -0700 (PDT)
Message-ID: <0a665be1-6300-4d37-884f-b2e22448c463@broadcom.com>
Date: Tue, 22 Jul 2025 13:30:22 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
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
References: <20250721-wol-smsc-phy-v1-0-89d262812dba@foss.st.com>
 <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
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
In-Reply-To: <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 13:20, Russell King (Oracle) wrote:
> On Tue, Jul 22, 2025 at 03:40:16PM +0200, Andrew Lunn wrote:
>> I know Russell has also replied about issues with stmmac. Please
>> consider that when reading what i say... It might be not applicable.
>>
>>> Seems like a fair and logical approach. It seems reasonable that the
>>> MAC driver relies on the get_wol() API to know what's supported.
>>>
>>> The tricky thing for the PHY used in this patchset is to get this
>>> information:
>>>
>>> Extract from the documentation of the LAN8742A PHY:
>>> "The WoL detection can be configured to assert the nINT interrupt pin
>>> or nPME pin"
>>
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
>>
>> It is a bit messy, but in the device tree, you could have:
>>
>>      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>
>>                   <&pmic 42 IRQ_TYPE_LEVEL_LOW>;
>>      interrupt-names = "nINT", "wake";
>>      wakeup-source
>>
>> You could also have:
>>
>>      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>;
>>      interrupt-names = "wake";
>>      wakeup-source
>>
>> In the first example, since there are two interrupts listed, it must
>> be using the nPME. For the second, since there is only one, it must be
>> using nINT.
>>
>> Where this does not work so well is when you have a board which does
>> not have nINT wired, but does have nPME. The phylib core will see
>> there is an interrupt and request it, and disable polling. And then
>> nothing will work. We might be able to delay solving that until such a
>> board actually exists?
> 
> (Officially, I'm still on vacation...)
> 
> At this point, I'd like to kick off a discussion about PHY-based
> wakeup that is relevant to this thread.
> 
> The kernel has device-based wakeup support. We have:
> 
> - device_set_wakeup_capable(dev, flag) - indicates that the is
>    capable of waking the system depending on the flag.
> 
> - device_set_wakeup_enable(dev, flag) - indicates whether "dev"
>    has had wake-up enabled or disabled depending on the flag.
> 
> - dev*_pm_set_wake_irq(dev, irq) - indicates to the wake core that
>    the indicated IRQ is capable of waking the system, and the core
>    will handle enabling/disabling irq wake capabilities on the IRQ
>    as appropriate (dependent on device_set_wakeup_enable()). Other
>    functions are available for wakeup IRQs that are dedicated to
>    only waking up the system (e.g. the WOL_INT pin on AR8031).
> 
> Issue 1. In stmmac_init_phy(), we have this code:
> 
>          if (!priv->plat->pmt) {
>                  struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> 
>                  phylink_ethtool_get_wol(priv->phylink, &wol);
>                  device_set_wakeup_capable(priv->device, !!wol.supported);
>                  device_set_wakeup_enable(priv->device, !!wol.wolopts);
>          }
> 
> This reads the WoL state from the PHY (a different struct device)
> and sets the wakeup capability and enable state for the _stmmac_
> device accordingly, but in the case of PHY based WoL, it's the PHY
> doing the wakeup, not the MAC. So this seems wrong on the face of
> it.

Yes, this looks like the wrong driver to be doing the 
device_set_{wakeup,capable}, those calls should be in the PHY driver 
where the knowledge of whether WoL is possible should reside.

> 
> Issue 2. no driver in phylib, nor the core, ever uses any of the
> device_set_wakeup_*() functions. As PHYs on their own are capable
> of WoL, isn't this an oversight? Shouldn't phylib be supporting
> this rather than leaving it to MAC drivers to figure something out?

The Broadcom PHY driver calls device_init_wakeup() when we have 
determined that the GPIO used for wake-up is available as an interrupt 
resource.

> 
> Issue 3. should pins like WOL_INT or nPME be represented as an
> interrupt, and dev_pm_set_dedicated_wake_irq() used to manage that
> interrupt signal if listed as an IRQ in the PHY's DT description?

Yes they should be IMHO.

> 
> (Side note: I have tried WoL on the Jetson Xavier NX board I have
> which uses stmmac-based WoL, but it seems non-functional. I've
> dropped a private email to Jon and Thierry to see whether this is
> expected or something that needs fixing. I'm intending to convert
> stmmac to use core wakeirq support, rather than managing
> the enable_irq_wake()/disable_irq_wake() by itself.)
> 


-- 
Florian

