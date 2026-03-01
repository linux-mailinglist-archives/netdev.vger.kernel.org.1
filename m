Return-Path: <netdev+bounces-262424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S1D3Izh0pGlShgUAu9opvQ
	(envelope-from <netdev+bounces-262424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:15:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D148A1D0CDA
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3E20300D17B
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2CA5733E;
	Sun,  1 Mar 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYPJ7BmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942DA59
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772385332; cv=none; b=IONpjR9upTxVuYxANngbBCyFowr0Y0ASEMm+WevDgfBmQ10sK19sENC/Cdx2oJmHqbwoB6TLDJw7NvU4ki5UwIInIfqbCXZDrhAGyN/cWrK3xLzbDKu2sQBjC+REZe8c6TqkTSoN9te67soInCtNbBg0WHxjJK5FIqgCOzlvKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772385332; c=relaxed/simple;
	bh=9rcxTIeddUw8jP3mdz14whvVh9NjguhNoNqVN7qLEgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EksacnMRNABYLyZlaLS1EF+VFjWPhR2LTwRPueMRBbMnCAp4E1y6p9NQNYeKkdvjN7pkZt0DcOvUQDkGomIlnF9avzvQsTFjIGAIAZSQPOgZ4lCJiCbk/KxAOoYXztVbHeg3ExIY68dhIz5DIzcDWrOszPOCx0hORrkH8dKh/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYPJ7BmB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-436e8758b91so2344256f8f.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 09:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772385330; x=1772990130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jw39l5pBGt4URbUpW6AosV1of/iQq1CoJCwSZP9GMAY=;
        b=GYPJ7BmBnLp/chU3tcnlKW+OdO81Mu0D+6Saw9N9Fjz8mimVqraii0Qh67selIwNZw
         6oAMj0JRfAI77ysOyHYKK7HIj+iNBCxQ6N/3DMZaAWmvN3fuauXyBVMbABNuAL7EjrwL
         CV+0Sg1Y2RgdZ2V+1ZQZlJXPTt4RXpwqwyB17d1QN/0vjYmlgF3x6OUL/Yy5QCcICVYd
         PkmOzipTZBJn0cIHTtOIXYv8G/j8OAQjaZAxTNDgQAcwv26m+94TUlNcMGH/6xELTg9g
         yIYUv4bWqVKzDtU+1qNfnQeKdNBoAH+/2ZpioevKIu5SiV6GeTF3PKlCM5U7fd/8GeyS
         H03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772385330; x=1772990130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jw39l5pBGt4URbUpW6AosV1of/iQq1CoJCwSZP9GMAY=;
        b=gvNtrvonksn5Zc4w3RLPCPxH8S4zHVOqIaiNgNXHLVo3nckiuMlwGrMq9kZYeYTFih
         S0lFTrdAk8RZBWgN0c0hZSyssLiiHpGBtoRQoC+HO4/FHzrtSXkJFGkrh3qVDx+UOdNZ
         2/mHPv7gd9a87/LmCi+KrAfYojx+z/e93f8htJG3J4l4loW3ExOGARMPDoLWS2yHQz66
         Uxqgfejqt+gvFrXpDAaMgJlZj9dU6KzMsgILZz7m4vgZASijWK1lsC4hDBWJaqkDdch7
         Eh7xOAKcraGnJ6qFe4rwk/UgAjfsSgjoHugdO7rLlh2oEJ+G6vzyg//UEsrnG5jpCrGM
         s7/A==
X-Forwarded-Encrypted: i=1; AJvYcCVsZjX5fIV+LFV763o82fETozz79ckF6K8amV0zg3DPI0HbxNldgHRNj0tB5jx5ALBsKFJd2dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOR/1JZqXz09wLDozENSNdUz+LFTFGLeZukw0ERW4rncKjaPK
	3+MGFzz1cmQFVVl43vhueUtGH9Bvx/wT2OQTte5GzKLvBc6V93pNq+xj
X-Gm-Gg: ATEYQzwHhKv4egkccYzEL3YF6owrftQIoyrdFfbinl4+U2ZcZ/NMs7/PJrJSI+EpsAy
	YMruM3ZJi9i0KOeWFxT+oP9kdRmY5sY//4GWgWynpZrbfc8OeVjdB2F6eaEPB3NqviNpRY3vU5N
	CJvx/oLPUkyiGK9mlPoB+Av2wrd2KY6PIhs0ennrqgeTktv3a4NL7Lrp2hoqCChso0sA6U3fFpc
	Uyr2IrnPQR/V4cPJkWQav8orVuYjmVtBsDcYaIYj9CGT3tKEvIW2m6CrS4bJ+xPdLWkO/smgltG
	exl3w+N3YpsUT0yo2XU5PCM12JLHTP1+f6tddDcX49XdYYz9vYfFAOqP15lvYKcmJDyZI7i8VkI
	2Jh+TGMi6puVj49wyv6oa30d9DbfGvvtgkmYQjJ4rpT4HH7+UTXHatjJSvRBVffQUwvJFGNaFmk
	4NC+y79Fr4tTgZX4lJ7PzJfZuYh1dOa31Emhoy0XnGkt89yjmNz62wycj6t9LY3AdM+Z8GGxNhA
	GEC
X-Received: by 2002:a05:6000:2301:b0:439:938a:3de1 with SMTP id ffacd0b85a97d-4399ddf1edcmr15797993f8f.16.1772385329622;
        Sun, 01 Mar 2026 09:15:29 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b8807a4esm11833f8f.4.2026.03.01.09.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 09:15:29 -0800 (PST)
Message-ID: <f7e0a64e-7f5e-4e13-ba62-2e1d0e8e39bd@gmail.com>
Date: Sun, 1 Mar 2026 18:15:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] net: phy: Disable MDIO broadcast address
 on YT8821
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Frank <Frank.Sae@motor-comm.com>,
 Sai Krishna <saikrishnag@marvell.com>, Daniel Golle <daniel@makrotopia.org>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
 <d0b2a87a-e981-4245-803d-d57c401b6156@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <d0b2a87a-e981-4245-803d-d57c401b6156@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D148A1D0CDA
X-Rspamd-Action: no action

On 3/1/26 17:06, Andrew Lunn wrote:
> On Sun, Mar 01, 2026 at 12:22:36AM +0100, Jakub Vaněk wrote:
>> Hello,
>>
>> this series is a rewrite of patch [1], which attempted to make the
>> Motorcomm YT8821 PHY operate reliably in the Cudy M3000 WiFi router.
>>
>> Background
>> ==========
>>
>> The issue on the Cudy M3000 is an MDIO address collision at address 0:
>>
>>  * The MediaTek MT7981B internal Gigabit PHY appears to be hardwired
>>    to respond only at MDIO address 0.
>>
>>  * The Motorcomm YT8821 external PHY responds, by default, at address 0
>>    in addition to address 1 selected by its strapping pins.
>>
>> At a minimum, this means that MDIO transactions intended for the
>> MT7981B PHY are also interpreted by the YT8821, which causes the
>> YT8821 to not work reliably.
>>
>> The YT8821 is not unique in this regard. At least two other vendors
>> ship PHYs with similar behavior:
>>
>>  * Realtek RTL8221B-VB-CG
>>  * Micrel KSZ8081
>>
>> It appears to me that multiple vendors may have interpreted IEEE 802.3
>> Clause 22.2.4.5.5 to mean that MDIO address 0 is a reserved broadcast
>> address ("A PHY [...] shall always respond to transactions addressed
>> to PHY Address zero"). However, the omitted part of that sentence
>> limits the scope, and it does not apply to many PHY types.
> 
> I stopped being lazy and looked at 802.3:
> 
>   22.2.4.5.5 PHYAD (PHY Address)
> 
>   The PHY Address is five bits, allowing 32 unique PHY addresses. The
>   first PHY address bit transmitted and received is the MSB of the
>   address. A PHY that is connected to the station management entity
>   via the mechanical interface defined in 22.6 shall always respond to
>   transactions addressed to PHY Address zero <00000>. A station
>   management entity that is attached to multiple PHYs has to have
>   prior knowledge of the appropriate PHY Address for each PHY.
> 
> And
> 
>   22.6 Mechanical characteristics
> 
>   When the MII is used to interconnect two printed circuit assemblies
>   via a short length of cable, the cable shall be connected to the
>   circuit assembly that implements the Reconciliation sublayer by
>   means of the mechanical interface defined in this clause.
> 
>   22.6.1 Definition of mechanical interface
> 
>   A 40-pole connector having the mechanical mateability dimensions as
>   specified in IEC 61076-3-101:1997 shall be used for the MII
>   connector. The circuit assembly that contains the MAC sublayer and
>   Reconciliation sublayer shall have a female connector with screw
>   locks, and the mating cable shall have a male connector with jack
>   screws.
> 
> Does your board have this 40-pole connector and screw locks?
> 

No, it doesn't :D

> I don't think i have seen one of these in the last 30 years. I do
> remember during my University times some Sun Microsystems, maybe a
> Sun-2, with a fat maybe 2 meter cable running into the false floor to
> a transceiver box onto the one Ethernet cable which snaked around the
> Computing Department.
> 
> So this should not apply to any board from this century which is
> conforming to the 802.3 standard.
> 

I agree with that, this is what I was originally trying to say by
the omitted part limiting the scope, I just got the wording of the
last part of that sentence wrong.

The reason I think that some vendors must have misinterpreted the
specification is that they have claims in their datasheets like
(Micrel KSZ8081RNA datasheet [1]):

| PHY address 0h is defined as the broadcast PHY address according
| to the IEEE 802.3 Specification, and can be used to read/write to
| a single PHY device, or write to multiple PHY devices simultaneously

and so I don't necessarily think they intentionally wanted to
violate the spec (nor I think you implied that, though).

[1]: https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8081RNA-RND-10BASE-T-100-BASE-TX-PHY-with-RMII-Support-DS00002199F.pdf

> So i would say the board you are trying to support is broken twice.
> 
> 1) It is using part of 802.3 which does not apply.
> 
> 2) It has two PHYs which using the same address.
> 
> I can understand a PHY might support this, optionally, with a
> pull-up/down strapping, saying "Break the standard, also respond to
> address 0". But this clearly should be an opt in, and an extra
> component is required.
> 

This appears to be the case for some PHYs. I found that e.g. Micrel
KSZ8081MNX is documented to have a dedicated B-CAST_OFF pin that
does something like that. But e.g. Micrel KSZ8081RNA is shipped in
a smaller package that lacks that pin and its default is to use
address 0 as a broadcast address.

> I'm still not convinced Linux should be handling either of these
> conditions. And even if it did, it should not be in the core, but
> hidden away in a driver.
> 

ACK. Unfortunately I don't think it is feasible to move this into
the driver because of the probing order issues.

>        Andrew

Jakub

