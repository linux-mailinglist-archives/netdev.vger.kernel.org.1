Return-Path: <netdev+bounces-248733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDBBD0DD0F
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 21:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E2FA300D830
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01A2BEC44;
	Sat, 10 Jan 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZVzjVdh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1A2BD013
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075390; cv=none; b=n8vZ0CI7B0orEqvdBQ5Q4s4ROzjZDvdJH0S/ehlxLMrqGbcuEOzCoW5l68ld7Fd1jvXD0DSpth2pdbDJovZR7HeJM+4xgFJcbSb5mqqcT654sx/LebLocSDfhNRdu7GV0q2lQnqof9/sGwgV8w0ro/qA7B0SAeTMDgjo+d0uA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075390; c=relaxed/simple;
	bh=gDvoStGmR6Mxu0N4MwngHG+m5Afx5YPGrm2BcOXxceU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tz3wGkb4QE5vj+/ZaqirHxU9hqxEZghdNmssfPd7RZ60XsTqfdn1lw4q2dMlmSAm1wcyBiIZ/+U3RpOBb5yZtaM++PI5B99ijmokIGq/DpSJJi2H2YXSjKt2L53LPtX0EIdhyKhLR1ycodvM90W6LWB8H8q0eU5S/Ts5LaEGTb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZVzjVdh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327555464cso3057755f8f.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768075387; x=1768680187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG7apv+dfK8MxDS/54Rr1PtzgLDp7m9K5AqVwdqWKy8=;
        b=iZVzjVdhMvwStgSJe4Fej1nKjxYCUsjEYYJ+gpu4lzNMHG+pIffG0yQ3iFvUzO7lrd
         RofJww9PKpBU5gsD3zAgrTU18Veg4TqUD4Q9O2UEbCbhn5dPGrMi38nTcGeeJjJhKz3E
         zJtGjC2tXPaXUwmf8KCj7qe3lQ9PbSEMJ0xN3RZpxIbiySJP8fJsp6loNdVEDWZnmrpk
         aMFXc3m4NJh8L6SyYtsO3nwWjT/p2x8NDV9y7scVp2d51Jx2zwqlJF7kOLPFZXHW5hx+
         xAwwIiDKLUMhY/U/O8IARCZvU32uWUPbUpGiJKUfQLkhniIkjRi72nxp4VNdLbDQoNYo
         9tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768075387; x=1768680187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG7apv+dfK8MxDS/54Rr1PtzgLDp7m9K5AqVwdqWKy8=;
        b=jNp0/+unShzNsW/OtCZreo0+orPJQiKmvZ8GDS8tIT0UCGLzOVMga3y4mn/X7zV5he
         AmnyR1bcKEUrK8aXjPuIIilNEMTF+Uz3sLJtlsE5lXYH+aksHjiqoZ574LdNoeRwKLrn
         jtVrbk2ik4RFPHTy6J3gg2fLGBfIDC34hbqv4rG6A4qLigAK244sMeDf9r7WOrCgynWz
         Gw3yfMChU1rYwMxwPVCM0PFfaMMm3TeuiF/xWt3p9R81YyRM9KVQKm4diQsvKcMJ4jER
         iWoNQLVkHX66BPAI7Jq/UOzhA6XJj4rW7RsvpqCty4FGN6EE2sZnYXeVqAgvixwP7DwT
         7V3g==
X-Forwarded-Encrypted: i=1; AJvYcCUDnU+YCR7UKLyGyBLSneB8nq3gNP2PM3KN4blAbE5kUqJfGGTS+L080BLrvjE5bScJ49TnJTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76AlztbtBrHMqx08CB49KooZ/NzDWYlBvXTsEKursYXhlP7KZ
	SoVPa+k7VOZkTghlSso6PNELnE4jG3jn2jkiNU8qUiSNfc4YBrAOwK3Y
X-Gm-Gg: AY/fxX6Wi78ch6HyWK/PtSy4EEw5FGHYKYx41pn94Xpffy0UEuEfquUtcyFHcJBtutK
	2qJaM3SkIbYV9HJ3FRPMYTDri7kRyv7gCpYrKoz8WT5WClp0r/mMHpp804cIxe5OSnGAjzp0cEm
	LxETKcbRaqo/Hhqov1gCL1mPiMZNn1KwUjIRbkM1HqelA2GjX5dSCtE2F9C7rIY90OIS/4NUsiI
	KqTZ1IDUZa46P3zMycg77iI4OO6EGAHMMp02Y1Uxgty6DfOAGGlVnf7EXmHVfVo3Uq5fSnlOf+y
	PUpAooHcPgJlcdtsBY2scOj45toVxNBIHht0+3hvdgjNHBccwtZUyzPEIaGhVumfrzLnHpqO2yR
	gRfR4W8aLfIbigYoZJmGr6BeJvTwbgJqwoFt9ZZg8wHut2jvJhCjO/gtvd8tweCoNz7pu8jK1W6
	4eIQKjhN0Kifp4cRPP06aX9QJ6mqOj70tKpPKQLcCJ30fYyuLbmhSnUMXHw7rXuxJdZKjDU8gWF
	51duFzeCXk0mYti7X+SUCyPMq4YrFV4d6BnbIG1R1Hcd4nXolZ3fA==
X-Google-Smtp-Source: AGHT+IGWdTT/A3E74t+ZIdvIlOc37dKAfxnL46933pTgSQmbAqwq1bFb067NIfUd5HJxcFsmWmM/sQ==
X-Received: by 2002:a05:6000:4287:b0:432:5c34:fb22 with SMTP id ffacd0b85a97d-432c377c54dmr16662575f8f.22.1768075387333;
        Sat, 10 Jan 2026 12:03:07 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm29480523f8f.32.2026.01.10.12.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 12:03:06 -0800 (PST)
Message-ID: <6df422fa-5d65-435f-896b-6495c63eaacf@gmail.com>
Date: Sat, 10 Jan 2026 21:03:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] r8169: add support for RTL8127ATF (10G
 Fiber SFP)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Klein <michael@fossekall.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c2ad7819-85f5-4df8-8ecf-571dbee8931b@gmail.com>
 <20260110104859.1264adf3@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260110104859.1264adf3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/2026 7:48 PM, Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 16:12:30 +0100 Heiner Kallweit wrote:
>> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
>> DAC). The list of supported modes was provided by Realtek. According to the
>> r8127 vendor driver also 1G modules are supported, but this needs some more
>> complexity in the driver, and only 10G mode has been tested so far.
>> Therefore mainline support will be limited to 10G for now.
>> The SFP port signals are hidden in the chip IP and driven by firmware.
>> Therefore mainline SFP support can't be used here.
>> The PHY driver is used by the RTL8127ATF support in r8169.
>> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
>> PHY ID.
> 
> Hi Heiner!
> 
> This series silently conflicts with Daniel's changes. I wasn't clear
> whether the conclusion here:
> https://lore.kernel.org/all/1261b3d5-3e09-4dd6-8645-fd546cbdce62@gmail.com/
> is that we shouldn't remove the define or Daniel's changes are good 
> to go in.. Could y'all spell out for me what you expect?

I'm fine with replacing RTL_VND2_PHYSR with RTL_PHYSR, as proposed by Daniel.
However, as this isn't a fully trivial change, I'd like to avoid this change
in my series, and leave it to Daniel's series. Means he would have to add
the conversion of the call I just add.
Which series to apply first depends on whether Daniel has to send a new version,
or whether it's fine as-is. There was a number of comments, therefore I'm not
100% sure.

