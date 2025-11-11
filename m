Return-Path: <netdev+bounces-237467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAAEC4C231
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 08:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9AF3A2621
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483832ABC7;
	Tue, 11 Nov 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Plmz3C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100B31BC80
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846747; cv=none; b=Ufafajfnclms22MnwX2/eYx1HQiq3LwGlZkhTcuV+Ywh8dSgvNnMFOeSqznCf865qbrEtSBd8Q4TwqzFq7m1f8SG9kYg5fia1mRnrt2DUPGusQVQo7RrFCChX6ItUJx3tSCcmzU18R0oMgSERm/4f3Inj5bjbGF5Nni7rEYcAEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846747; c=relaxed/simple;
	bh=tM3F9cGJvdW5nIJTysLeL3dkGfKIFKgPh9hPxrWdLQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9pW3a0VdtAvlxxjv13yMEcHp0oNoufB+TnFjG652h52WnsbZjM8VhZfx3ifqqvX4261SYFV5Vqmf2pI5b4mdoto4nsXrlEgJBK8wzzJeSjGfsRgjGpqAdJ+umwRKM/z0Ig1T9MzhIonmJ2J2+yuyt3cYriITxRqBlClkaBhJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Plmz3C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso25054315e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762846744; x=1763451544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9LS9PnsbQWQTn+P8yBni8Hp8BsL8yGAxygjsAyFI3Q=;
        b=a7Plmz3CfesGadBa0CYEUSb/s7m5STAUXOT+uW+/MFRhNfW/vT2iKXPaV8MVb6S+io
         8b9swzdly7vTDvRiRluprA1eM9WwwqIGWRtN9H+bLf131Lv1Brka7wcqTTxvUAuZH40H
         rFoKdzga4aVlu/wNC6BCjp11RMhnc3IGmLWttpVa95vc/qSUfZf5oa4NnCgiqfiOqd9O
         fGUDw8ZKFFRRuHK8Ua3D4wnFkz23/frxyiirJH289Qe6iF21CCO2/KEi8rhIiSvKpD9C
         jXMYYA/D8JsWB5GvUO1ccCshQUysJ9pVZVLkHaJEZrzHQTQ+jpuBSQx3FYqFFxg1Zj+b
         /nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846744; x=1763451544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9LS9PnsbQWQTn+P8yBni8Hp8BsL8yGAxygjsAyFI3Q=;
        b=e6WI0D9Uo4j3srvixrGl2MIGjpb8TASMvzVlWD2WZhZKFHHiA8N+tOVPslTmu3T/OR
         foVkPUrS2mgbWEEwrf3GF7nZnnmxPI71NEj6S6H6ATdIrZb5xBUz22e02QPbEZvSo8mN
         XNhMJ6drDKfZfOFWwpqoU2fnDTFeg/96EUujQjpad3ZYtLUjHt07uTIpeNNAxcyWeSzF
         lua4IT+8BCAg9OVNHR+lvPCwX+t8NfJl/au2EJnQP3kPrfT+xLgOGWOfSnM9UmCVPJm4
         8o/SnHxcFGxgvOjfkARWiozkI2E/j0QvSzTUtI06bqrVTgs3EEnXWeA9+KSrnTooJ87p
         BC7g==
X-Forwarded-Encrypted: i=1; AJvYcCV2vAXwMQSu5QyEa3HneyK7f6QIa2I2BMeoUN2sdjrlKtkSgc7dL8yEmTpqy1GiROuLDnInNTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKxlt0qeg8GwkcuevFEeQLH2lBloHb6HaCc6yMwT134yAIQAJ
	qSBlydyT0lNXbWVENz8FeZ0kV9UAUYwGaSDYYnfYkUz5a3Z0529ZHkg1/1PrJQ==
X-Gm-Gg: ASbGncteYAblfaJVdt0TEd4wq7QsZNBsoFEUE/YzrcGmlTEP7fmuMDVG4ulcQKBywqo
	MEqq6/H7AQTfAFFXZWdKQilxkn7aphQ6scEtvdyDYZxNOaYv1EYg/uS6jwl3OuMluRUgXWteSnJ
	dg3YoWCRBdjCoa5wQTbRwFKbwFQzObaz8AbwvmuBRjQ+bz9wdY7xD7+vgS5hwNiwZhn6th8Kdwq
	sFFhTHZOWFu8ZNDP4/FNiCcxir7Zf3gq7xCQPsmmCB2Qvkam62SAZH+tYVGg/hTQjc6nvcgWL/A
	d+TD3+4BK0S+zyDO3ZK4KMG5HRUaxjZqFxw0Qsa5BOkgHccqBRwL7tR7MJl7RWHA99GDEp2VbNQ
	YcLwsWqhjVV//Pm7STjYo+DaG3527itNCtwMuiKBKWWCwSpvF++XOysnkD8pgrqmzpiT7z0XKLW
	kByoJZ8hjc4nBFRBXHb/xoS4isICT4q/ZgadruR6jvEXu2fAUBTMIY9utZe/vMLVJNtTHhIWczB
	+TeqAAAfxTfW54I/c0wSzKk2M4SbjyxVUZ1ekMweaet+yPziNA=
X-Google-Smtp-Source: AGHT+IGA7FU0hR99I1kxouzSHA9VAXgEef79YRul0ndnbm62p7xJKk7eAlqm8YcjAOQAyk27plyoig==
X-Received: by 2002:a05:600c:6c90:b0:477:3f35:66d5 with SMTP id 5b1f17b1804b1-47773271a8fmr49313575e9.26.1762846744143;
        Mon, 10 Nov 2025 23:39:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f30:600:852d:ff0a:9262:188f? (p200300ea8f300600852dff0a9262188f.dip0.t-ipconnect.de. [2003:ea:8f30:600:852d:ff0a:9262:188f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47781d8a742sm11042355e9.16.2025.11.10.23.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 23:39:03 -0800 (PST)
Message-ID: <64163498-cc64-4013-a3cf-ae8736ae1519@gmail.com>
Date: Tue, 11 Nov 2025 08:39:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: fixed_phy: use genphy_read_abilities
 to simplify the code
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ed9eb89b-8205-4ca3-9182-d7e091972846@gmail.com>
 <aRJfrUQ0hSKETbxp@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aRJfrUQ0hSKETbxp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2025 10:57 PM, Russell King (Oracle) wrote:
> On Mon, Nov 10, 2025 at 10:11:24PM +0100, Heiner Kallweit wrote:
>> Populating phy->supported can be achieved easier by using
>> genphy_read_abilities().
> 
> Are you sure about that?
> 
>> -	switch (status->speed) {
>> -	case SPEED_1000:
>> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
>> -				 phy->supported);
>> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
>> -				 phy->supported);
>> -		fallthrough;
>> -	case SPEED_100:
>> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
>> -				 phy->supported);
>> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>> -				 phy->supported);
>> -		fallthrough;
>> -	case SPEED_10:
>> -	default:
>> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
>> -				 phy->supported);
>> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
>> -				 phy->supported);
> 
> This code sets both HD and FD for each speed, and if at 1G it sets
> 100M and 10M as well, if at 100M, it sets 10M as well.
> 
> However, swphy emulation (including what was reported through BMSR
> and ESTAT) has only ever indicated one speed and duplex supported
> via the normal ability bits in these registers. So, "simplifying"
> the code introduces user visible changes. This needs to be mentioned
> in the commit message.
> 
> The next questions are:
> 1. does this difference matter?
> 2. is it a bug fix?
> 3. is swphy wrong?
> 

Once the fixed PHY is attached to the netdev (and bound to the
genphy driver), genphy_read_abilities() will be called anyway.
With the change we have a consistent state before and after
attaching. The link partner advertisement is always determined
by swphy, therefore the additional modes in the old code
should have no effect.

In general I wonder whether setting supported and advertised
modes is still needed here. It was once needed when DSA used to
call genphy_read_status() during port setup. But since the
switch to phylink this isn't the case any longer.

Setting the supported modes was added with 34b31da486a5
("phy: fixed_phy: Set supported speed in phydev").
adjust_link is only set when attaching the PHY, so I'm not
sure the use case exists (any longer?).

So it may be an alternative to remove setting
supported/advertised modes here.


