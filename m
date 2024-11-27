Return-Path: <netdev+bounces-147658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 982D29DAF36
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174F8B21452
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FC145B38;
	Wed, 27 Nov 2024 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQmOJI9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2E189905
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745728; cv=none; b=LvgqN1XI2R6vvwpEAIOfzjMECjs5r1SXDgZGWYobwZTXRFIQBiu9rdcdCZ6dLu0N03sIv3CYj8WLLuU7WbMqQlQtsLUzbR3xIO+04cc1sJwXIyik3S8H2M378POpL1tArV6tNMPzW5VtOSvlmSB24+538tnnUg5+nbXUXXR/3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745728; c=relaxed/simple;
	bh=1psCjEcN46PG+yIsoZCkNJWfR0iny7oQ4vqx7lMS3jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEae/1a9fOnRyu3t29zyQ4kvo3FjkUB872EPrsLXq8KJ+iYKPF9fq0zr+bFSJQSgTKOXo2qEFDTqM680Nu+/eg7l5YpD+qxK/8e9Oz58GMrEHeoEfvkn3HLz64EXmJ2+ZJEFnqIGjTY1G9IPLuz5iyW8yCaPgwnHq3KYqthTlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQmOJI9X; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso19190366b.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732745725; x=1733350525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C4hMroRe5vC2NxlBWRRYYxsYO1szD/OqQeolaWtKQGk=;
        b=SQmOJI9Xk74CpE88gSwQk4lMZ/2T66dSFNYFZvjUDbrXzOtv8ggCAPYV4zZN7V8KCB
         4S+sdMQTzdSuaYN8o+6bYx8SNxEEoCQ2IAUxpBaECjaHE1LUMxSEMpfuYfru2Dg2Al7E
         SQD/4RiakM5lvFXQTGL7+JxkJLSSZ+1OAY+RtTZVTIMXwL+5CrwyEyG7TlsS08LtJOc6
         q7xVxWnqjI3CRKsoHj59E3OwLTids7Gi8645ap9w4y7y5WkbHBXK+WwlQmpVAITUtxw+
         GKacpsefucC/1KBT3JDgYf3zhV3tzE6DMFRGmQ1fyzBIMWlAiWHqkblfkKsq9j6HUSfT
         vnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745725; x=1733350525;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4hMroRe5vC2NxlBWRRYYxsYO1szD/OqQeolaWtKQGk=;
        b=uN5qDyPnor7WVaoM7zA6aBUsn40TLqOjeS9b0xfoxOMHuqnEEmGS4OImLMcfYS3jUK
         3GOow7UWNImcwAgHmcI+1XdX/u7FNGNJOq6azpM/Sfkpq2GITlL9yMI8QY3DtWunbBpY
         pPXU9ZEV314ZrjjS3r+nlvgClZjBePROFduw+CNDijiw4vYRZ5gqbZ+bS6IZsqomrjaW
         LXctdwBnrYstz7O+kXSkc1LbITDGdMyelMhe//5Hs7wEfDDz3DHIOUb5B3cBWKR0p4Mx
         ksLIf7hwXRSnT9zw3ey0J9UkBJTE5fZijLeLlXY974Bap1BQnmmf6x49J1j1xUrKgPN+
         9S9g==
X-Forwarded-Encrypted: i=1; AJvYcCXydhx7NZM2hPwxWUJk55z5vkWBbirwTVV/t4rjozT8f5CxA485QN5m/J/1JNehB4TGuDdugMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRz/UnL5Prmn1WaTiJXLQVuZhhZKQbZTRHbOUIJrvJbIlVnGA
	mg1sE6n1r8bNsYgqgyvsH3G1WQa6C2VuK0NlvXO2w9OIY9G93Sww
X-Gm-Gg: ASbGncsLA4QYvjLjn6zguKrWc++u0On+ccqM0SJD7HZKble+Mv8q9ZD3+D0VwqRDClR
	6loQ8kuuwSUNopoLJBYLWBoK1cflqpfDQSiXFlgDFyukHgcYZd9Tr/LUjbDgrPkCk3Q+UEJ6C+Y
	wf6CGH5tO6e6+4yIpsTreKnpks4mSZvIu7bZyFTEzu8zgQU2JN334R5i6f65apYXDZk4EuNe9nk
	pjnOU6ZKxxpUJiEFyqdxgIQk+svRhSwEhGBKJnsuu1mbAVGxoYbGS0AjNAbM28YkIF8a+B8TFWw
	m0+HYVCEbFb667vdAseadM7qEnxpqYkpPkuGeSMixrc49qWS32DqCxdtoOE6lI4mD9rMJjqi5+I
	o9qI4n1fFiDylDDFiqP55nn6GQY4VzMqcmjb1WY4+Og==
X-Google-Smtp-Source: AGHT+IHYgWvU50Owdns9gA4SJOoFe3enu43XPSQT/+67ke9HUNtG8d/ql9AEHSChYJ3EEYt+kRuvzg==
X-Received: by 2002:a17:907:254e:b0:a99:529d:81ae with SMTP id a640c23a62f3a-aa581062752mr318792466b.55.1732745724778;
        Wed, 27 Nov 2024 14:15:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:b12f:4200:648f:850f:5e23:bc2f? (dynamic-2a02-3100-b12f-4200-648f-850f-5e23-bc2f.310.pool.telefonica.de. [2a02:3100:b12f:4200:648f:850f:5e23:bc2f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa55567771esm386400266b.79.2024.11.27.14.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 14:15:24 -0800 (PST)
Message-ID: <6d4bf2cb-b5be-4b35-bc05-c6cac08a7028@gmail.com>
Date: Wed, 27 Nov 2024 23:15:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: rtl8169: EEE seems to be ok
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <Z0b5NepJdXiEQ1IC@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z0b5NepJdXiEQ1IC@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.11.2024 11:49, Russell King (Oracle) wrote:
> On Tue, Nov 26, 2024 at 12:51:36PM +0000, Russell King (Oracle) wrote:
>> In doing this, I came across the fact that the addition of phylib
>> managed EEE support has actually broken a huge number of drivers -
>> phylib will now overwrite all members of struct ethtool_keee whether
>> the netdev driver wants it or not. This leads to weird scenarios where
>> doing a get_eee() op followed by a set_eee() op results in e.g.
>> tx_lpi_timer being zeroed, because the MAC driver doesn't know it needs
>> to initialise phylib's phydev->eee_cfg.tx_lpi_timer member. This mess
>> really needs urgently addressing, and I believe it came about because
>> Andrew's patches were only partly merged via another party - I guess
>> highlighting the inherent danger of "thou shalt limit your patch series
>> to no more than 15 patches" when one has a subsystem who's in-kernel
>> API is changing.
> 
> Looking at the rtl8169 driver, it looks pretty similar to the Marvell
> situation. The value stored in tp->tx_lpi_timer is apparently,
> according to r8169_get_tx_lpi_timer_us(), a value in bytes, not in a
> unit of time. So it's dependent on the negotiated speed, and thus we
> can't read it to set the initial phydev->eee_cfg.tx_lpi_timer state,
> because in the _probe() function, the PHY may not have negotiated a
> speed.
> 
Right, hw stores the tx_lpi_timer in bytes. Driver's default value is
one frame plus a few bytes. It doesn't use phydev->eee_cfg.tx_lpi_timer.
set_eee() op isn't implemented for tx_lpi_timer, because no one ever
asked for it and I'm not aware of any good use case.

> However, this driver writes keee->tx_lpi_timer after
> phy_ethtool_get_eee() which means that it overrides phylib, so hasn't
> been broken.
> 
> Therefore, I think rtl8169 is fine.
> 


