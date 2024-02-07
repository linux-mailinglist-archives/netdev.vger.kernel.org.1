Return-Path: <netdev+bounces-69961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D47F84D233
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DC1C224ED
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BE85641;
	Wed,  7 Feb 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UePaxCxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5C7F7FC;
	Wed,  7 Feb 2024 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333787; cv=none; b=LuYN82KHgABR0nYD+1nu+MVmMSiIa+OasWiDCAReDq4fIlS1ARJe+huOohkOQwzfgmqn9uGmkAVSfqUkeDkH3wnkywP3JKAVxUigeIVJEpXAAlGL/0MoMkYtUaiJLgA9r/58yRyHBed5RQfAcZPLRO4DX5oeWOeY/7NdTDi7MsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333787; c=relaxed/simple;
	bh=46cdCkZUfEb61wP23W0zdofoxTmaW/ZSbVVjq/XPmp8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u2lXh/2kN67moXV/vuPRdeYNb+tzJs9CsuZR7n8JlE1gS48AMuY8Fww75ekfeHieC05cTHSwAGXZJF7mpYdDHQnVtKwDW45uYoW82nJMXWhiacAczLm/ZIDc+ulGMdvvlXDAgrCyztDYV9vAo9pmC1f4KcxORLrOrBNZTmzIuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UePaxCxa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5600c43caddso1053817a12.2;
        Wed, 07 Feb 2024 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707333784; x=1707938584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPLawAZmVpSkl4t0aQX4pq2PhjmmXTupRhpu+j87PvE=;
        b=UePaxCxaYc2blLgOHPJfws35S+LiqkEtiZVvcEAYz/DxtIZPuQOybyrcHusdBMfIOQ
         Nx/JS05v5n3Bfyh3NDLU2IkvSgN8FKLGmTyAgfTaDciqH778iv9fJ8WddDJYNurJpa25
         VC7JgDLLFPSdwfjiTDpJwT9sSPgvgZvA3zoVXS2TfwleoEHHRirWBYSwHY6VDrCWLdlm
         klOxEhHFM7t1bl+edJni8O8WrqTCBAf63EFQE3agoUgxDrkaXcKvK/fm8N/ibGFXAlvl
         CENkh/q9W8EO5OSJoYHcQe0CatfRGEcN72JrJjc9mYdu6LgnBy78o4K7vB4Hh0DIiRid
         uRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707333784; x=1707938584;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPLawAZmVpSkl4t0aQX4pq2PhjmmXTupRhpu+j87PvE=;
        b=U6uc+6XkuVlU8dxwJsavf4dFBAiBlwgSg3DL09T0IQR5GmV+KJcJ9XbzornDNrEJfD
         /beyl5BAYqKUvIh1iJ5coOQSSetzQKl5YfvP44Yqcm9wMVUM25O/77vj3vXHxcfb8qal
         o6AzwGE4seGmFqd4+HBSxT6VuhCbWKjYLnHFXPR8YajUgK+wUMxP0Rkva1RyzjCOuX5/
         nFgYsO8N6pj0DSPtW0Jt+0uQF3D5J7d5LfyN+npxx0PnAV9jpFHGnR/F79S8RHxg+FOT
         5TMCql1Q+GBoHgZzXViQE/u+obQme/BAJZzgZgtEDwmYLeGQIQk3rnGyjqdhTdsYuaqz
         z4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW24CiUK2K/6uusEiOIgqfb8AzYgS7tUw8/SOzUM9ZbFAEToYYBGIeFyTvl3pifY+IqsgIF0a0QsOHU58aAC7UQ7MKRcRgFI8k97cCSAKDR160ba9DSzMM18xW55InBHDLP3Q==
X-Gm-Message-State: AOJu0YzdCIXcZAtQ5Kh09yN83Y1KF7UaqJ6Tjzckx5R+PLZcPaCno4sp
	vHwfwX1RXPW4Zaewt/Tjm+lk3+X8Af/YlmGpRKvPvxZ4Llki6G2r
X-Google-Smtp-Source: AGHT+IE6TAJIcDK541gPd6MtddPZPWrFvF2wMqpK9XL9q+/zJdZJYMuLV8KP4nAKolOWsZ2+6n7SMA==
X-Received: by 2002:aa7:c317:0:b0:560:c8cb:c2c8 with SMTP id l23-20020aa7c317000000b00560c8cbc2c8mr2469327edq.11.1707333784149;
        Wed, 07 Feb 2024 11:23:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuAkCPXmFoLUssf9rSApGtG4jI/41Vj3mG1COcq4oIj8rPv06LXT5DaIpdnVKErdTG1h+pBIBAEuP1Fa1aPGSLkBV6ZoScAvnDPgdXvCsDIgGh/ZQ9ESVrML3Bm59d7Gnv9PnyZPdi9TkuVzXONea1TPqOG9euhvh0ekw7J9FaKW0ISwxCwJsXr8EnabDvPCqbhKU20yeHe+cBA5NhSKimoI3SDy/4Ig7WkNistpPmrGQI8LD+bRrtZnVJ/ByDidqrqPmYuKQV7vowf/7rCjTORG4DMBzkAMBKwDOjC2aQb3Wtl1Y/gOamUclgwHSW72quMlRLV9Rleb0owlKiuTbRoRMnCXLWPalk3OQi1TGfGfWpZZDNREkA7VKlyHGA5zMtWyf/s4oikEYwAv8ldmbZQsPGaElsGlfS0NVJkVTom7LTBUSRe760OSubvvcUICFGZEsWpYsFinbN3tz9dv6W3gJQ8GizTAouu90yM3odYp5xfIf3+e9bZfzvdMXyenC/k0jDyLGk/lybYlAlsfgCGubSKKXa10YYd/I5D8bJMff0Ve63Ce8IfwpwaOhIHg==
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0056023efc5besm14829edq.53.2024.02.07.11.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 11:23:02 -0800 (PST)
Message-ID: <f3f811f8-07cd-416c-ad30-b6db42a78b03@gmail.com>
Date: Wed, 7 Feb 2024 20:23:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-3-ericwouds@gmail.com>
 <ZcLGkmavpBAN02xq@shell.armlinux.org.uk>
 <32897bd5-4b53-4280-a5c0-5765cfe5b7d6@gmail.com>
In-Reply-To: <32897bd5-4b53-4280-a5c0-5765cfe5b7d6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Russell,

>> Searching the driver for "air_buckpbus_reg_read", there are four
>> instances where you read-modify-write, and only one instance which is
>> just a read.
>>
>> I wonder whether it would make more sense to structure the accessors as
>>
>> 	__air_buckpbus_set_address(phydev, addr)
>> 	__air_buckpbus_read(phydev, *data)
>> 	__air_buckpbus_write(phydev, data)
>>
>> which would make implementing reg_read, reg_write and reg_modify()
>> easier, and the addition of reg_modify() means that (a) there are less
>> bus cycles (through having to set the address twice) and (b) ensures
>> that the read-modify-write can be done atomically on the bus. This
>> assumes that reading data doesn't auto-increment the address (which
>> you would need to check.)
> 
> I will see if I can change the code to:
> 
>         __air_buckpbus_set_address(phydev, addr)
>         __air_buckpbus_read(phydev, *data)
>         __air_buckpbus_write(phydev, data)
>         air_buckpbus_reg_read()
>         air_buckpbus_reg_write()
>         air_buckpbus_reg_modify()
> 
> While not changing (except if (saved_page >= 0)):
> 
>         __air_write_buf()
>         air_write_buf()
> 

I just remember, the address register for write, is a different
register from the address register for read. So we always have
to write to address registers twice.

I can still implement an atomic air_buckpbus_reg_modify() though.

Best regards,

Eric Woudstra

