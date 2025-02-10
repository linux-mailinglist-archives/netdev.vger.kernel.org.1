Return-Path: <netdev+bounces-164823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B813CA2F531
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DAC1672BC
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE295255E33;
	Mon, 10 Feb 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HWm/Gck5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F82500B4
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208356; cv=none; b=UXrnEJcDAWmY236ez8efsclHS8T13vcZ55ydjmMgVkyjZrIARxPtIiH0IsMikBIOu+w19KQmXZh3n5IYgAzcwAkgGW5EPoc7G25ysIC3dAuKGSdp4oE+l4FZpuE1RybN9VqUjYjaVf+UAkIRLO4lll9MiOYNkWT9aOYZxQTBHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208356; c=relaxed/simple;
	bh=aN2EmS2Wv8dmB2jBkzZWYudZLHQwtAZEJXyPO7h3nWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iw1WGM+jTjRL2PPVHRPPOk0iTAZuOwfXYDJbZLmlXBpcm41Kh8kxpwMxHmjcNjITFr3vzGc9nuGR9yhOAjekip58Y3IgnquMk6prpBZkJHx+iSXD/Ta5ncAOvpg77SHyQrvJYMHywF10gj9VgZh2OmJhuQOQQ6OpFsitDhd1Pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HWm/Gck5; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2b863fdc25aso579725fac.2
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739208352; x=1739813152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gp8qkq7qBewVEkouEYW8313k1UZv/AD2lu2jM5fMUlA=;
        b=HWm/Gck5Xc53xEqZSDEUazR9VeaAsMeLX7xBS+TdzQDUTlvZ5kkamkGiiDipvfwYeC
         BFvbGCw6TByJKPkdZsV8fNjETfZcdlSytY8jiX4CPk5oQo3zIntFtjnyeVy+nz2K2nhq
         XtNXHutnYtCpLXA13a5DiNCemdD5BFAM4gX/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208352; x=1739813152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp8qkq7qBewVEkouEYW8313k1UZv/AD2lu2jM5fMUlA=;
        b=U9BFn/m16SHQo+/ajuUojMg5UFzHj2L2q+R5+KnmaPyBb9VDcR93tX1lDUtVsTyHxE
         Y2yPSz97BugGgqqCT7x5uXIU3K3SwnZVrMzkI+qr0uXZr08T01qrZrCz0/vP/vlzA/lH
         cjaCDSsPhHgBPv92A3TSDnUxAjgz+OpeO8KPuhMis+pref/8wBbbTK3gEXYI/CLptw86
         U8WSzqgr4IMB6JQGVdLK8FnQC053/KohyBHHyb05c2fhh5RZSOGcQrUCBP9LTntaCqIP
         SBih8vdKB7H/txWFDz35U1eTv8+SbsichCj25t24cdpiSVotsAfGJqJ/EBL71rO8UsKd
         +/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXjQvEcZoqeRA34knp87FiObXTJoizE1MDtrGb/FMX/Faejydq5ncCW7pnLczFcXs1j7BuKtVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoD72FEAmmA7+QdiH4RHi84gfbQF6hY9zQVaoSUh1Rlr+if9h
	hThMlO0lM4/lhY5XnANqwVrNK9PdNoB9whSEspAoH0hw95pygX9SKC6dUcWg/w==
X-Gm-Gg: ASbGncv1e+gUQMOWxQtNPLOoKJshX++aICRg9l1wpWqdiM9zoAWaUpST0MadAcmePDz
	xaDwtazUAbWxz7Xsh5nWggOhllvMuH4eWaTQGCKJy5d7Nitbm0S8X4X/nAdtrZ0/G8ymB0WG7IX
	ijroPOtg1aLoqyUIuWRz3f+lMgENRottBu4Wb8qYzmph4katgylUSTpWioT4+rOxyn7stSOUwKf
	C84VuRhpmjoYVjo8lkGOYPCWKntcf4V5q+W/diUpK6TNAEx74scUmTbUqyXJ5teFz1c6kjfJkQR
	IW+GoWSVvftWbZRP5ztJzP6JVu5ou/LEM6ZzrCKOXQkAJoqonT5XAvQ=
X-Google-Smtp-Source: AGHT+IHWiUmUykCGTk7iPKGcK4ZASar6+MZpVfbfNwPNMqHcf/PFjCu08mjK8u5+SpKITS4yuvQcsA==
X-Received: by 2002:a05:6870:6110:b0:278:1f2:a23f with SMTP id 586e51a60fabf-2b83ec5f203mr8337621fac.13.1739208352229;
        Mon, 10 Feb 2025 09:25:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b89b6dee3asm617338fac.47.2025.02.10.09.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 09:25:51 -0800 (PST)
Message-ID: <580cf379-40fa-416d-9823-d8b1fc8c96dd@broadcom.com>
Date: Mon, 10 Feb 2025 09:25:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: dsa: b53: Enable internal GPHY on BCM63268
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
 <1317d50b-8302-4936-b56c-7a9f5b3970b9@broadcom.com>
 <9bd9c1e4-2401-46bd-937f-996e97d750c5@lunn.ch>
 <a804e0a4-2275-41c3-be3b-7dd79c2418cd@gmail.com>
 <318e8b95-4ef8-43ca-a19d-129372a9dc48@gmail.com>
 <aa8fefa0-c5ba-4bb0-9e45-6b0ac4cfbacc@lunn.ch>
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
In-Reply-To: <aa8fefa0-c5ba-4bb0-9e45-6b0ac4cfbacc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/9/25 15:30, Andrew Lunn wrote:
> On Fri, Feb 07, 2025 at 08:44:31AM -0800, Florian Fainelli wrote:
>> On 2/6/25 17:41, Kyle Hendry wrote:
>>>
>>> On 2025-02-06 12:17, Andrew Lunn wrote:
>>>> On Thu, Feb 06, 2025 at 10:15:50AM -0800, Florian Fainelli wrote:
>>>>> Hi Kyle,
>>>>>
>>>>> On 2/5/25 20:30, Kyle Hendry wrote:
>>>>>> Some BCM63268 bootloaders do not enable the internal PHYs by default.
>>>>>> This patch series adds functionality for the switch driver to
>>>>>> configure the gigabit ethernet PHY.
>>>>>>
>>>>>> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
>>>>> So the register address you are manipulating logically belongs
>>>>> in the GPIO
>>>>> block (GPIO_GPHY_CTRL) which has become quite a bit of a sundry here. I
>>>>> don't have a strong objection about the approach picked up here
>>>>> but we will
>>>>> need a Device Tree binding update describing the second (and optional)
>>>>> register range.
>>>> Despite this being internal, is this actually a GPIO? Should it be
>>>> modelled as a GPIO line connected to a reset input on the PHY? It
>>>> would then nicely fit in the existing phylib handling of a PHY with a
>>>> GPIO reset line?
>>>>
>>>>      Andrew
>>> The main reason I took this approach is because a SF2 register has
>>> similar bits and I wanted to be consistent with that driver. If it
>>> makes more sense to treat these bits as GPIOs/clocks/resets then it
>>> would make the implementation simpler.
>>
>> I don't think there is a need to go that far, and I don't think any of those
>> abstractions work really well in the sense that they are neither clocks, nor
>> resets, nor GPIOs, they are just enable bits for the power gating logic of
>> the PHY, power domains would be the closest to what this is, but this is a
>> very heavy handed approach with little benefit IMHO.
> 
> O.K. The naming is not particularly helpful. It is in the GPIO block,
> and named GPIO_GPHY_CTRL so it kind of sounds like a GPIO. If the
> existing GPIO driver could expose it as a GPIO it would of been a lot
> simpler.

You are no stranger to what HW designers like to do: use whatever 
existing hardware block already exists to add random enable and status 
bits to control whatever they fancy that was not exposed before. This 
happens whenever SW/FW people don't push back and ask for proper 
compartmentalization and abstractions to be used. Sometimes layout and 
schedule also play a role, but more often than not, it's "just software" 
so you can update to to account for the fact that bit is there, and not 
here, right?

This one is exactly what happened: there was spare room in the decoding 
address space of the register block, so it was natural from there to add 
a 32-bit word that would hold the enable bits for the internal Gigabit 
PHY... Those bits are not GPIOs, they are just simple enable/control 
bits feeding an internal signal.

> 
> If the SF2 has similar bits, could the SF2 code be shared?

The SF2 single GPHY control register is different and more standardized 
in many ways, so I don't see much value in sharing that code. The 
SWITCH_REG register block in that case does follow a consistent layout 
across different product lines.
-- 
Florian

