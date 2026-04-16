Return-Path: <netdev+bounces-279024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEH+KrTN4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:53:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33F40DAF2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBEB33029C3B
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F545396D22;
	Thu, 16 Apr 2026 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaJR9Uqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B337DE92
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340398; cv=none; b=kkIDJ3BmE3vUK0HQlzbTRYqrQo8HOkycmEDLuzWalC6NPcoiduJQD8veed286XPbfs6BO3ZA6qL9lVaHH97xsG3vG3MUYG3ZDkvwCRRelEA/OAbulLpOod4zLYzy8NOjgJMxOtQmJvwKempBJ6tQR0Xz6hlsmruqk/n6B6O0GKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340398; c=relaxed/simple;
	bh=2yKBl/HRG0k4/O9AvxFux/USNSiycjdUrFR1lWQN3aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ni8Ig/QeNEh7tZ/+9QXwygKtHbqH07K9mjwRMPB7a65ogzL1rENwwt0rdmom0XyZImDqkB9vnhrUR0hy8xuxQba7F9iYNWy8nXN4skfQ7frU5Xq2ngMLQAzF6y41QK//BjeepvuK2q+3QVFe/uoopxeYzPjCEh8LfSN7WgWwHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaJR9Uqw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488971db0fdso79197725e9.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340395; x=1776945195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8L8vlI55xATq/1fRRIVGzZKbIML/TD9GIsR25DWYmg=;
        b=RaJR9UqwGgoMLCdUikUiDJyQnYQ/0k+E0FagaxNBHgMu2xzCoINnJ0higqoTOZHpJ0
         2+SNP45/y10wytVRlSiFUmsXhuHtJ3qEcD6AnMt6WDOD3Ztza0EM7vYtVODIsZTrgXVU
         ZwFuMJrcYz+1fc4fZawlOB+9bn776oAahpMZaGRTDj4T2VoUV9AMdtUG9+SV1AJa64J6
         EfY9lrmoaQLoMAaRh0Yjfy4pudUDy/oGZBL2yLxKp+pBE5dW+0D3nTl04CnNmvi/LjF+
         s8vzfT4sAZc+Po7U9uOP21vDnKsZBfJMy15z0fIg6nZlBM1k4fyN5Ja+mpsk7UVGVD0O
         erfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340395; x=1776945195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8L8vlI55xATq/1fRRIVGzZKbIML/TD9GIsR25DWYmg=;
        b=P4KEf+OuaD86L47XjjXhE/uFhKnl1WBcIhjqYgwBE6WNui2IQYK0VSfUbbo5zNLE31
         6HniEaZ2WhJR0RTGGc1ksthZu0+9YwktWBfB6IdNDLx8AFbm7qWOSs3AaU+wAeRLBga2
         VFDdJPBx7p+QoFeMur32DHXA+B1sPAkq+AW9ScsZ5n2HuC/skAnt80f+DQ5au9Tqokwr
         36kzxuQ9GscuPJwXzvOCXc+IEcj+D0d50vph72qa/2wKl1aZxJiaap7zGLgyoXE8DhxU
         HqeCKR4UeZXXuHYRr4EadprvDxTB6X74YRgmZHRXOsKXzJ5pl7w8EHsd1XZcy1fubOBL
         LN7w==
X-Forwarded-Encrypted: i=1; AFNElJ8exbb5i9+HQMbBa3wwiduSR0bOP3nc0t64YsJe9pj1fpVnPTvYcGk4CU9KEMkn0NUYNqp148o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGrvUm88/69cJ7tKKYVZaxtfHKf5yr2oDNHMzbB9NUmZoCpAC
	0o/bs0zQpYvhAx2X9ObmYxLUzJTiKpCoJKUKbfxedL1fnM49ftwEzjak
X-Gm-Gg: AeBDiet40o2mh1LTijVwWRAb9JGqnghua8oDA7RsbAMDB7cEf1cXPvzSTV8Cq+xyhhb
	bwyki0c6wziMLzPnQbSW5RyHo6qoKXmG2qCnqhtmF5gV4NivoEgQ2K5O2G8JWbHX5vNFedlaK1u
	yAI18nFEUwvV7BefZM9bE0vEcYUL6HJwoOdduar2bQeZKf89VPt8zjunlFyYXt1FnUXEUzPn/nl
	EKG+h+7YUZ/lkzariQiZgPkgRrdXUAXz2nRG5zMYSbm1apukLr+cVVFA0b1mjQ+cT3iQDpo1FrX
	Wf1MejdTyfPRtO/vOvTFDBHpD1K5rSuS7qsUu4xWfWnAhBDnDGkkIJud71DBi/JlAAlilsu+pO5
	mfTx5h95Fi1TAG709BgxTyfD5z6h4IitNIqchC6ZQ0Ufa/l/uKiyEDY2KfF7V6FipqVvYz9OW6W
	vJbuwaqXlu2AwwX89TKObXQGlLkHK0xGhnDleo978UiB7oAis8ON1Rp6eA0/v6ypYV0uUTrgvFz
	oMQ4C5FkA==
X-Received: by 2002:a05:600c:64c9:b0:488:c40b:c8b9 with SMTP id 5b1f17b1804b1-488d67b8d4emr376689565e9.3.1776340394867;
        Thu, 16 Apr 2026 04:53:14 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm77739125e9.5.2026.04.16.04.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 04:53:14 -0700 (PDT)
Message-ID: <84e24758-2f59-44ca-a9b8-a46094578f83@gmail.com>
Date: Thu, 16 Apr 2026 13:53:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Marek Vasut <marex@nabladev.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
 <d9b161dd-f698-4d7e-8ccb-9ec12411bf87@lunn.ch>
 <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <712cc46a-5ceb-4f0f-88bb-fa0a47002258@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,vger.kernel.org,exotec.com];
	TAGGED_FROM(0.00)[bounces-279024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F33F40DAF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 17:49, Marek Vasut wrote:
> On 4/14/26 2:40 PM, Andrew Lunn wrote:
>> On Tue, Apr 14, 2026 at 01:05:49PM +0200, Marek Vasut wrote:
>>> On 4/14/26 11:12 AM, Fidelio Lawson wrote:
>>>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>>>> Microchip document DS80000687C for KSZ87xx switches.
>>>>
>>>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>>>> where the PHY receiver equalizer may amplify high-amplitude signals
>>>> excessively, resulting in internal distortion and link establishment
>>>> failures.
>>>>
>>>> KSZ87xx devices require a workaround for the Module 3 low-loss cable
>>>> condition, controlled through the switch TABLE_LINK_MD_V indirect
>>>> registers.
>>>>
>>>> The affected registers are part of the switch address space and are not
>>>> directly accessible from the PHY driver. To keep the PHY-facing API
>>>> clean and avoid leaking switch-specific details, model this errata
>>>> control as vendor-specific Clause 22 PHY registers.
>>>>
>>>> A vendor-specific Clause 22 PHY register is introduced as a mode
>>>> selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
>>>> translate accesses to these bits into the appropriate indirect
>>>> TABLE_LINK_MD_V accesses.
>>>>
>>>> The control register defines the following modes:
>>>> 0: disabled (default behavior)
>>>> 1: EQ training workaround
>>>> 2: LPF 90 MHz
>>>> 3: LPF 62 MHz
>>>> 4: LPF 55 MHz
>>>> 5: LPF 44 MHz
>>> I may not fully understand this, but aren't the EQ and LPF settings
>>> orthogonal ?
>>
>> What is the real life experience using this feature? Is it needed for
>> 1cm cables, but most > 1m cables are O.K with the defaults? Do we need
>> all these configuration options? How is a user supposed to discover
>> the different options? Can we simplify it down to a Boolean?
> 
> The report I got was, that if the device is cooled down AND the user 
> used special short low-loss CAT6 cable, then there was packet loss until 
> the communication completely broke down.
> 
> With the LPF set to 62 MHz and DSP EQ initial value set to 0, that 
> situation improved and there was still up to 0.14% packet less, but it 
> is better than total breakdown of communication. We couldn't get the 
> packet loss down to 0% no matter which tuning we applied.
> 
>> Ethernet is just supposed to work with any valid length of cable,
>> KISS. So maybe we should try to keep this feature KISS. Just tell the
>> driver it is a short cable, pick different defaults which should work
>> with any short cable?
> 
> I think the user should be able to configure the LPF bandwidth and DSP 
> EQ initial value as needed. While the short cable improvement settings 
> are "LPF set to 62 MHz bandwidth and DSP EQ initial value to 0", there 
> might be future configurations which require different settings.
> 
> I think the ideal setup would be if those two settings were configurable 
> separately, with a bit of documentation explaining the two currently 
> known good settings:
> - Default (LPF 90 MHz BW, DSP EQ initial value as needed)
> - Short cable (LPF 62 MHz BW, DSP EQ initial value 0)
> But if the user needs to reduce the BW further e.g. to improve noise 
> resistance further, they shouldn't be prevented from doing so.
> 
>> A boolean should also help with making this tunable reusable with
>> other devices. It is unlikely any other devices have these same
>> configuration options, unless it is from the same vendor.
> Could the LPF PHY tunable simply take integer as a parameter ? Then it 
> would be portable across other PHYs I think ?
> 
> The DSP EQ initial value can also be an integer tunable.

Yes, I think a reasonable compromise could be to expose three tunables:

- a boolean "short-cable" tunable, which applies the known good settings
   (LPF 62 MHz BW, DSP EQ initial value 0).

- an integer LPF bandwidth tunable, for advanced use cases where further
   tuning is needed;

- an integer DSP EQ initial value tunable, for the same advanced cases.

The boolean tunable would follow the KISS principle and cover the common
scenario, while the more granular controls would remain optional.

What do you think?



