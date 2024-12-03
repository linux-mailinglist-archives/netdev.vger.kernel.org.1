Return-Path: <netdev+bounces-148430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028DB9E184A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2FC160609
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5F1DF997;
	Tue,  3 Dec 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMn/4squ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C51DF26C;
	Tue,  3 Dec 2024 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219530; cv=none; b=QTthd48UNDzzVujD7t/lpqh7EDXVo6afTRu6v6jK23ryWnEtA1hDwL0aByzgV3ipr6wF+NqP+ckaERPSwJgKsgjdvmf5bEPEEzuvPp6lsmlY1d1l4k2sYvo1BudH61TuK8yJ/QYzuuJbhFJR5DiKAXCi/jtcNIAI1WfjmGKBSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219530; c=relaxed/simple;
	bh=dI9v6KrHaH0nV+8GuIjF+ylyqgFhGTVmTsx4O1eEUSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqgDUJ1f6nVHO6mk1QnD2uxHy0xtkQt9dkCLIBLxZtPdIsSaFuLdn86KU9zEpfjK7GV9gS1D8CjDKsLOEgcTBVKi781Zi9+eM+x51/DvTrzyk67JdF8/ryWDN47dVCdopLyS3PalUWxVKmUSnICtvcJUOxrdtokuvoTTp3ARSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMn/4squ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0c098c870so6069358a12.1;
        Tue, 03 Dec 2024 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733219527; x=1733824327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c1fDr9AeQFAk/Z1ZfzWbmvkQ+r0XutA/mW8M8TQNyjE=;
        b=hMn/4squBQi1dHfRBEg77PheaF/C1sU603MABmASl2wKZTC3JVWvhdHs2dV7xmHToU
         AEEel+JGf4dn2gbdn+NUcW4qeME4EtFgKEfsrmIxkK0iBgfiWWa0eSkR9JCr5Q2n3uzl
         zGIpEjfYstAsjdwjWgQ86lKvYriBQ+RAz0rKMdJH2ZSHhbcEocdv61HOhLfFZmhDeTsG
         uZic1oHZpQC+GylMr876Nq5xnCe5xsyugB7jVYopdaAWKBuoxb/PseoV59JL/hJ08oDq
         4cG7PTFza/dAGPivPMkONSNWaajv2pSiVlcnbkCB/Imve1VjtLhI508OFX8s26q0o/KX
         aahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219527; x=1733824327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1fDr9AeQFAk/Z1ZfzWbmvkQ+r0XutA/mW8M8TQNyjE=;
        b=kYuhFg9r+3Iu7mMvD1Yb/JOL2ZgfZJ1tNhUB91p5FGRh0jXOJU/JyZitL0jjv4FSPc
         NjxGIp7cyuigiexwE3+YjY15uYTXUryNPvHBoiaUeLH6rQ7E/4xzt8J/svT59+xkM2Tk
         +/VBon3ca6aM+9C+cM6H0qPjDQh0PFNId8KNYHl1aQF22F3RhmGeUt/bmu+FdCK5kMo5
         A+DzW1apS2LCYrPwNbZ4YP+CwRGL3I4yoXGHf4jmrkR3EjdXu20vXPry5NkLcuY+R3pQ
         rW4w2A7QHxcBrLIGuNLrIccmgk7DSjU35HRYIuSRuFjmC2chbtznGdXPStGpTAme5qkv
         F/MA==
X-Forwarded-Encrypted: i=1; AJvYcCWL4ExC+0NWcTPIBEggKkfkn9klh43zxnCLct05nDwuFCaoquFJJdqPEgGKmRX5pllSLSCLc+nv@vger.kernel.org, AJvYcCXyNeFHNO1moi5ljfo+H10vgBX0XvXSklT/aViRtiX9TQ2UDprOBo26pDb6IvU2jurFj0sdVy8rYFDQ5bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruaSE7oj6VGifTRSk9lP9oANjkYteQ9Nwnbpm5ZDdnFiZu0aV
	P/YIO91LIiO+SD1Mw9tM32kbbbHHP4ipo8zss3RxTfrqRbxYmyo1k1pBhw==
X-Gm-Gg: ASbGncupRzCS3e1R9PsybzCW8sxDhQUozxU7tRWxx36153GnxGu33xVv0rt9l5zpEEp
	jsDB1CcMxHVLidWPaN4Z9wDEA0ZadO/GAfKko2dFY/dRRbO7XDav0wMAAwqRDRcsG6beAcTGlz6
	oCC98AQ6FqPH7H7kn/oLPx4nnYo/sDLiWXw05cj66cewpbHgA79FpmbzLqN5GSoCi7kgI4A2MQX
	JBFbmBl/tvCBOZy36ntcaaOsRZgR7U7qwVv5fDvuO6fCgsKzs9Zu2T+kBqsyGhvlVAxyGXgOlJ+
	jcdwvzzKxHTm904l1O1GsuNZ4aQH5pQKdkIeTNjK8diT4KhsBbXoP37kg5tquEim5gyRE9Ec5JD
	y4M1G/uESR0mMHS3+GCNpHvzIIUX6QtSbKybAcRR3BA==
X-Google-Smtp-Source: AGHT+IEr++7a+APbwIiB7scQfNXfHel8bpH2WPwPlJSsFF0m6s4X6aueYeyw+1Beia+cATW1NebeQQ==
X-Received: by 2002:a05:6402:1d55:b0:5d0:7a0b:b45f with SMTP id 4fb4d7f45d1cf-5d09510ed31mr23852700a12.10.1733219526945;
        Tue, 03 Dec 2024 01:52:06 -0800 (PST)
Received: from ?IPV6:2a02:3100:9d09:7500:4dd6:631f:ae43:dbe4? (dynamic-2a02-3100-9d09-7500-4dd6-631f-ae43-dbe4.310.pool.telefonica.de. [2a02:3100:9d09:7500:4dd6:631f:ae43:dbe4])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d097db0bbesm5855213a12.29.2024.12.03.01.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:52:05 -0800 (PST)
Message-ID: <af9e7960-ae36-43f9-bf54-0b6b5588b340@gmail.com>
Date: Tue, 3 Dec 2024 10:52:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: disable broadcast address
 feature of rtl8211f
To: Zhiyuan Wan <kmlinuxm@gmail.com>
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy.liu@realtek.com,
 Yuki Lee <febrieac@outlook.com>, andrew@lunn.ch
References: <7a322deb-e20e-4b32-9fef-d4a48bf0c128@gmail.com>
 <20241203071853.2067014-1-kmlinuxm@gmail.com>
 <d2490036-418e-4ed9-99f6-2c4134fece7b@gmail.com>
 <e707044d-a1d3-40c4-aeef-fad68c6a1785@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e707044d-a1d3-40c4-aeef-fad68c6a1785@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.12.2024 09:35, Zhiyuan Wan wrote:
> On 2024/12/3 15:38, Heiner Kallweit wrote:
>>
>> Take care to remove the Rb tag if you make changes to the patch.
>>
> Roger that.
>>
>> This still uses the _changed version even if not needed.
>>
> I'm not sure is it okay to directly write PHYCR1 register, because not
> only it controls ALDPS and broadcast PHY address, but also controls
> MDI mode/Jabber detection.
> 

This was not my point. Just use phy_modify_paged().

> I'm afraid that maybe it causes problem if I don't use RMW to clear
> the PHYAD_EN bit. Because the following code in `rtl8211f_config_init`
> also utilizes `phy_modify_paged_changed` to change ALDPS setting
> without touching anything else.
> 
> But if you insist, I can modify code to this if you like:
> 
> 
> 	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
> 	if (ret < 0)
> 		return ret;
> 
> 	dev_dbg(dev, "disabling MDIO address 0 for this phy");
> 	priv->phycr1 = ret & (u16)~RTL8211F_PHYAD0_EN;
> 	ret = phy_write_paged(phydev, 0xa43, RTL8211F_PHYCR1,
> 			      priv->phycr1);
> 	if (ret < 0) {
> 		return dev_err_probe(dev, ret,
> 			             "disabling MDIO address 0 failed\n");
> 	}
> 	/* Don't allow using broadcast address as PHY address */
> 	if (phydev->mdio.addr == 0)
> 		return -ENODEV;
> 
>  	priv->phycr1 &= (RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF);
> ...
> 
> 
> 
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "disabling MDIO address 0 failed: %pe\n",
>>> +			ERR_PTR(ret));
>>
>> You may want to use dev_err_probe() here. And is it by intent that
>> the error is ignored and you go on?
>>
> 
> I'm sorry that I made a mistake.
> 
>>
>> And one more formal issue:
>> You annotated the patch as 1/2, but submit it as single patch.
>>
> I have another patch to enable support optical/copper combo support
> of RTL8211FS PHY in this mail thread, but since Andrew said that patch
> (migrated from Rockchip SDK) is low quality and I'm too busy with my
> job, don't have much time to read and improve it, so I decided to
> suspend that patch's submission and I'll resume to submit that patch
> when I'm free. Could you please give me some advice or recommends on it?
> 

The patch here seems to be independent and should be properly submitted
as single patch. Regarding the other patch I have nothing to add to what
Andrew stated already.

> Sincerely,
> 
> Zhiyuan Wan


