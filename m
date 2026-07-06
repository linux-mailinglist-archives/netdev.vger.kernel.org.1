Return-Path: <netdev+bounces-305221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BVt4JYkSTGrjfwEAu9opvQ
	(envelope-from <netdev+bounces-305221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:39:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AFD7157F8
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:39:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eJGIyTzP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305221-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305221-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E51B93080BDA
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975583E3C5F;
	Mon,  6 Jul 2026 20:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877783E2AB9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 20:30:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369806; cv=none; b=Six/X1toYFbBdSsg5arwDVhZnWDxqh/8ITH9n7eH7KXFKPcL6Ptmulc0vXWdz0s/eh45UYF3rRZ5P+B4NIhr3FkbC+A+lud2QEmN7LrgCDD3Qb6ew04h5qlGYIfI9IgrWU5pmK2gbU/VGGap/y0Ts/PKKpjQ78kT4+yhzSUP9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369806; c=relaxed/simple;
	bh=cuuGRQ9ikVr5K2JDWNiMw8FokA6lvFe5ZtfeL7kRoKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC3kmrT/hg8g3tpAFdosWaeVAgvMYOsIFFbp1LtPBG47BwvooR7bWi6qKdN5amnauWkJJ6ZLZY1IIV/RNhZXwinfJ6waWwmq26IXcFnnP+41a20RnjNzdE5uYanQkkJnnGGK16gV9nYbUoMramUXAax4gbQ3UV0NX+ZlXetL8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJGIyTzP; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b7612475so32295575e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783369802; x=1783974602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6q/pZi6Akagjc5HROiArP01SOpU9gOVMCKwxAzqUAfM=;
        b=eJGIyTzP+kAhRwtL2dHxTzMmBiNXlTHECGSUZmGjTm280+XxFxOA9JykXQ4o8xQs1L
         TEGrgs5HBCCdEv1yRBF0RarZH8fsYGCtuozKKNDRRkvpkBsssbChORPHOpDnDFBr3wit
         PMTKLTDkJwV8gFPjN7rBTiqCHHJuR7wWPi65tkD5VkussP6NjBGpuzOUhn6ws9XgCOP1
         ceCT/WT0yRZAQxxuP1hdSTgriFQWfqqd8ISR5AAmw6tv6pVFIGzE0LjafrRdgM/2vSVo
         5PL5rRW0pZHLT1A1iARx19k5IAjfuKWGczByQPYGT6QBTIvvPSYFY96Oenm1e3owWLX5
         HAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783369802; x=1783974602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q/pZi6Akagjc5HROiArP01SOpU9gOVMCKwxAzqUAfM=;
        b=QZThkrY2CRWlq1mh2CclClcbx60UHTru2MSxZzUb5+XQKyesIpO5jrf3+Cfz9zfCs3
         GhE9plvRkHkfu6/OU7O8YCjY6Y1IaWY6dLBpACYmF075NCkYVs/fOH9EfZ5tbzHgrND8
         fzewQ9HNnmVweoBaqr5Q+j4lLmN4g0+NaxQ4BDik49n6/M21NNtQdUY3AV5WwV2+bqSh
         x5iWAA+iwp0WbfOatUBr0/DBpoxJt7LF30Z0SgEKg/JpmaOpseGj0iDt8Sjy7Vp2sYZk
         ypkPGjGq2BmdYrkZs4G7gVTHafsUwGfvLPk3tBa2gjKLWhoBEAuRv9SUL3UtspOhyMlw
         9dAA==
X-Forwarded-Encrypted: i=1; AHgh+RobiWCMOKsWz33Af6Xk2F3Pm2hrpZloVYGsjiXGtRMsF41hKriG+Cr5H5nObfhhCtXB+3rqum4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXcKdXOImNBR0lmd14pqPAP3zvVljR5fURx3D0Zobh2QkVII5S
	PRMZWbfTLSsQOzfQ06zgUocC257oW4gDNd8fH3Ukp0B3rw2Fth40XEYA
X-Gm-Gg: AfdE7cn4rmlWl9ui813FQiu/z9CQzWi3Fc4taX/jR4cjXOx0XFFb+BKNJNHABdg20m5
	G2MuAlmxw2lafltDgpaOdAR5nBqtWQ0zEAgNDv2XIsWDrBY3tVfT5GR5vJO7g8uoHeSeCBxLSNl
	gdtRgLnEOMEqlTcAtojUUiEL12Qv1boEKeB9eGVS1nyvME29wKoN5992BPRBNlSE5XPi1FQFxWh
	VAUeZL81I2wzj6Lc3E0RS1/bJgNxVtcWCXMqD6KUuaVNDlDW3d8qo8tC0gJHiMfnSZj8T7aLg28
	2eWX5YL3/mqVyV0pHYOwQHrgAdWnU4dWdRbLKl7sngEfU3Owqs4z21D7xgIyEnqy6OaM90kiDKM
	35ty3vNX9tga4rrWKAFSbK1pKzUg9dHj3fnQy6E4Xim7A32cZHZivj78IX3h3ccCUpVniBjTnGP
	xbVhHV4xWiN3Bw5beqgoi8KF3vAN11RMZunyy1H158O/t1OkRvU3uy4dSdNoJovM5uB4NYS4fX0
	FlkC5Jog43YBCQ=
X-Received: by 2002:a7b:c5cb:0:b0:493:c535:3934 with SMTP id 5b1f17b1804b1-493df09c294mr16563235e9.36.1783369801698;
        Mon, 06 Jul 2026 13:30:01 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f13c:d501:a53d:1108:c6d3:af16? ([2001:9e8:f13c:d501:a53d:1108:c6d3:af16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm27931062f8f.5.2026.07.06.13.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 13:30:01 -0700 (PDT)
Message-ID: <c19e563a-8931-4f31-b05a-ff8def4a5161@gmail.com>
Date: Mon, 6 Jul 2026 22:30:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Golle <daniel@makrotopia.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-2-jelonek.jonas@gmail.com>
 <20260706-player-handwash-0a3fe95cf5ec@spud>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260706-player-handwash-0a3fe95cf5ec@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-305221-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zyxel.com:url,linksys.com:url,svanheule.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1AFD7157F8

Hi Conor,

On 06.07.26 19:35, Conor Dooley wrote:
> On Mon, Jul 06, 2026 at 11:24:21AM +0000, Jonas Jelonek wrote:
>> [...]
>> +
>> +description: |
>> +  Microcontroller (MCU) that fronts the PSE hardware on switches using
>> +  Realtek (RTL8238B, RTL8239, RTL8239C) or Broadcom (BCM59111, BCM59121)
>> +  PSE chips. The MCU exposes a small message-based protocol over either
>> +  I2C/SMBus or UART; the actual PSE silicon is not accessed directly. The
>> +  Realtek and Broadcom variants share this device tree contract but use
>> +  different protocol opcodes, selected by the compatible.
>> +
>> +  The compatible identifies the PSE-MCU protocol dialect, not a specific
>> +  part. The device here is the MCU: it presents a stable message protocol
>> +  documented by Realtek, with the PSE silicon behind it - Broadcom on
>> +  older boards, Realtek on newer - detected at runtime and not described
>> +  here. The MCU's own silicon is general-purpose and varies across
>> +  boards, so the 'realtek' vendor prefix names the protocol front-end
>> +  (following the google,cros-ec pattern); the '-rtk'/'-brcm' suffix
>> +  selects the Realtek or Broadcom dialect.
>> +
>> +  A single compatible per dialect covers both the I2C/SMBus and UART
>> +  attachments: the wire protocol is identical across them and the
>> +  transport is already expressed by the node's parent bus, so it is not
>> +  encoded in the compatible. Transport-specific properties differ
>> +  accordingly - the I2C attachment carries 'reg' (and, for Realtek,
>> +  'realtek,i2c-protocol'), while the UART attachment carries the serial
>> +  peripheral properties such as 'current-speed'.
> I'm not really convinced by the arguments here.
>
> If the switch vendors are running different software on their MCUs to
> the point that they behave differently, then yes it makes sense to have
> different compatibles.
>
> The first thing I don't understand is why realtek is considered the
> main vendor here? Is it their MCU that broadcom are re-using with some
> protocol tweaks?

The protocol and firmware on the MCU, most likely the whole "solution",
is from Realtek. The setup is always the same on most Realtek-based
switches (saying most because a few counterexamples use completely
different setups, not even Broadcom or Realtek PSE silicon). The host
interface is always the same (except for I2C vs. SMBus vs. UART, which
is likely just a config in the MCU firmware). Therefore "realtek," is the
right prefix for all of these.

Broadcom is not really involved here except for their PSE silicon being
used. Maybe Realtek modeled their MCU host protocol after the one that
Broadcom PSE silicon uses as host interface, but this is rather guessing.

Maybe a historical view might help. Older RTL83xx-based switches with
PoE shipped with this setup using Broadcom PSE silicon. From what I know,
at this point Realtek didn't design their own PSE silicon. They used the
Broadcom silicon, put a MCU as a manager in front of it with their firmware
and a host protocol based on what Broadcom PSE itself uses. At some
point Realtek started to design their own PSE silicon which then was
used in newer switches instead of Broadcom PSE.

> If it is, then having the vendor as a suffix like wheel reinvention to
> me, and if the MCU and/or protocol aren't something that broadcom
> borrowed from realtek then having a realtek vendor prefix is strange
> altogether. The mention of old boards being broadcom while the protocol
> is documented by realtek is confusing me.
>
> Either way, encoding the vendor without using the vendor prefix seems
> very odd me to.

I'm open for suggestions here. This has been the hardest issue in this
whole series, to be honest. It basically boils down to differentiating
these two protocol generations. I cannot say why Realtek did that on
the transition to their own PSE silicon but vendors doing weird stuff
shouldn't be surprising and this is the reality now.

Is something like "-gen1" and "-gen2" better, with a clear description
somewhere in the bindings how that maps to actual device setups
(gen1 = older/MCU fronts Broadcom PSE, gen2 = newer/MCU fronts
Realtek PSE)? This would drop Broadcom and the confusion around it
here. I admit, using a vendor suffix isn't great and still attributes
Broadcom too much in this context here.

> Secondly, the compatibles you do provide seem too generic. Is it really
> possible for a given board to use smbus AND i2c, or do specific boards
> only ever use i2c OR smbus (or uart for that matter).
> I find it more believable that a board would support i2c and uart than
> supporting both i2c and smbus fwiw.

Only one at a time is used, but not combined in any way. All switches
I've seen so far always have a single management MCU for PoE, not
multiple. Thus, only a single variant is used. Which variant is used
likely depends on the board vendor which then tells Realtek "I want your
PoE solution, I can attach it via (I2C/SMBus/UART)". At least for UART vs.
I2C/SMBus there are sometimes valid reasons to use UART over the other.

There is only a single switch (from Linksys) where the MCU expects raw
I2C messages. SMBus transaction fail actually. But I don't see the reason
why Linksys did it that way. The reason can't be that the MCU is attached
on a bit-banged I2C because another switch uses SMBus transaction on
a bit-banged I2C.

> Can you provide a link to the actual devices somewhere? It is
> completely non-obvious to me what the binding actually represents.

I hope I get your request correctly. Find some links to devices and/or
to my commits wiring that up in actual DTS (WIP, hashes may change).

Zyxel XMG1915-10EP (UART with Realtek PSE silicon):
https://svanheule.net/switches/xmg1915-10ep
https://github.com/jonasjelonek/openwrt/commit/d173e64730a511e04b68271289be23ae4e98a02f

Zyxel XS1930-12HP (SMBus with Realtek PSE silicon):
https://www.zyxel.com/de/de/products/switch/10-12-port-10g-multi-gigabit-lite-l3-smart-managed-switch-xs1930-series
https://github.com/jonasjelonek/openwrt/commit/74339c9a002032fc204b6b1fe07af259d8f51787

Zyxel GS1900-10HPv1 (UART with Broadcom PSE silicon):
https://svanheule.net/switches/gs1900-10hp

Linksys LGS328MPC (I2C raw, not SMBus, with Realtek PSE silicon):
https://support.linksys.com/kb/article/5133-en/

(mostly Zyxel devices but that's just the main devices I work with)

> Cheers,
> Conor.
>
>
>> [...]
>>

Best regards,
Jonas

