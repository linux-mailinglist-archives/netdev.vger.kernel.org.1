Return-Path: <netdev+bounces-210893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E37FB1553B
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 00:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5759F4E219A
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 22:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFF12820DB;
	Tue, 29 Jul 2025 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ak65rxZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36B275AE4
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753827784; cv=none; b=pYzE+TJD7lfjqzmcA7vqeDk+VDeCrQc9CDHaOJVL6zpG6Bu82OCyj4w09rnC6oS63k30R3naqgLh8ls3aWm2nIn6eviqL8sBDqNh5ZwPvdBfdIivi40R/n2quICTke4HO3xNeg1uS9ErFQl4g//7YmWEtS6ZVPqrSSbOrbNs9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753827784; c=relaxed/simple;
	bh=4GdSigWwwldL0RA27kr53J6NXPAwPI5dHAa5/mhdiiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXM/ICZBy8F6ZT7u2VrGyKiYtlq2D58Q3q+e2BaW22ryFNHoqGf4rgMpihDkVTCK8NMT+9zHwnIlEmLLni9NiWWuJsit2FIaYvEOKjE7B5QlbUMIWzppasxLuYdrtSMwPdaHjjClEKlcouJ6f/I90/mXfiNIykyXvAw/iCw8caw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ak65rxZ1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7074bad03ceso22345326d6.0
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753827781; x=1754432581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+LE/N4dZraGWQ3jyiAjJdQylOUBI0lucdkrBEItExm0=;
        b=Ak65rxZ18Q2+Rco20xgkNdYHD89Bc8vwu9d91z4mxyo5iEs7s6kEecLtbh3TUgdytQ
         EqnRW82TGtgSNDN492Sn9glRrXE6gkzq7U2VC388MGLhY74ladY4/xcC/Q5NZjgAkNb2
         Xbb6CevsFfa0ssns15kR6tokMzFysZvjG9wrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753827781; x=1754432581;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LE/N4dZraGWQ3jyiAjJdQylOUBI0lucdkrBEItExm0=;
        b=LNle9wChY6VNeZdwmZ++Oo3AucG48ndTw2OCVpsMVUAdumKwsGRz6gr92UOJRVADHq
         lBKMs33dnBj3SwnoTdQA1Z+SCHboVS9VyY+WWXuxK33TyiiCoi9gIaw/yqAvDFkdi8tB
         xsz4OIVI4X91HGwereRHXQ8oHIRTO5uhIgBEcx3mLChvRg8IiV/gTWGfH2acrR9nGmFt
         uHPlaIeodp28wjksRe3E3hNWW9QLusLnevKVpI816UXrhK/L6/x+OfXkRX/GWiL3joV6
         0Evo1D+hqHlm/LL2V82+WdCLLywUfJP6BmQ8/OFMA8PZ7HPiqc/T4j+GVlMa0ErgTGx6
         BiRg==
X-Gm-Message-State: AOJu0Yw35Ii2LRhNfA43HsBd8q16/f3ViaYlWk70eW5sIRpz0FSHyPuj
	IZXYlhQYLtR7vC1QFg4MgSOACAZ7PNQWUqzdtrI1bPSN7To619wBJK+AFtLNhqZ3eg==
X-Gm-Gg: ASbGncuT6UBJn2d8Wc6Pa102agyvNr8OOaIrKLGERJqzOXEtspbBjA+vbMjQJ/Y7tdA
	RntMlp1ylzWFnAwvQFheYmXBtg86hfO8X40AT/TDn3yNXuCs2zxJN1ZMFr6JHMpRgNlKrRvByXW
	emEc8G4+2r40BG2oGfiZfcresKNDtYJgdo6JT8LXWSR7iwRG2t3V5aUdXYnbi2JD4qhsOWs7yom
	5Gq6wxI3xlfXod8mOBRk6jNs5f2kqH2NsLVcGl58FQUYVAcmbG/JqEpU1XD3Gb8vVkJW4Ru4fSp
	2NFeVvXJfmS7Vz6izwEKl4px1qXFidVWRPuHS/L+kk+7s6CvBkTdad3VIYae236qV0YrbByxhE+
	S3kabZZXU1FmealSF4av33R9FEwrb5u9PO5VX5LFuUBnIL+F6dyBybkMBWsvOgQ==
X-Google-Smtp-Source: AGHT+IHAjKz6peco8RflxNDLQgMoSAlltIZ8BdUBJwYDjKEQKjRs3sP5vNW8dYdyT4heNCxJmiO1Rw==
X-Received: by 2002:a05:6214:ccd:b0:6ff:7678:bd0e with SMTP id 6a1803df08f44-70766d508c3mr14274536d6.8.1753827781429;
        Tue, 29 Jul 2025 15:23:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70752597db1sm23424126d6.26.2025.07.29.15.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 15:23:00 -0700 (PDT)
Message-ID: <9c10c78b-3818-4b97-8d10-bc038ec97947@broadcom.com>
Date: Tue, 29 Jul 2025 15:22:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
To: Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20250729213148.3403882-1-florian.fainelli@broadcom.com>
 <11482de4-2a37-48b5-a98e-ba8a51a355cd@lunn.ch>
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
In-Reply-To: <11482de4-2a37-48b5-a98e-ba8a51a355cd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 15:20, Andrew Lunn wrote:
> On Tue, Jul 29, 2025 at 02:31:48PM -0700, Florian Fainelli wrote:
>> In case the rate for the parent clock is zero,
> 
> Is there a legitimate reason the parent clock would be zero?

Yes there is, the parent clock might be a gated clock that aggregates 
multiple sub-clocks and therefore has multiple "parents" technically. 
Because it has multiple parents, we can't really return a particular 
rate (clock provider is SCMI/firmware).

> 
> I can understand an optional clock being missing, but it seems odd
> that a clock is available, but it is ticking at 0Hz?
> 
> Maybe for this case, a warning should be issued to indicate something
> odd is going on?
> 
> 	Andrew
> 

-- 
Florian


