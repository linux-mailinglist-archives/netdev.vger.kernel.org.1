Return-Path: <netdev+bounces-183910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C59FA92C93
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22B319E7C0E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2C81FC7CA;
	Thu, 17 Apr 2025 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJ6ZoG4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130A18D63E;
	Thu, 17 Apr 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924681; cv=none; b=MLE0rSXPH1+nESuprMbqfTxczSkc9oNDg3ZOthqdm+1vcji9ExKviaTcGYEwVEX7LRQ6ogTaA1V+s9gub3r9hcWMgi6EQhf0Vy3cak78YrDBtmZzPtQGtNcxpC/5vdBgKsHUbpKJDyyHRkjSJrfvwVP7+RTwMttXf2rOzsNxyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924681; c=relaxed/simple;
	bh=rnUjLUoMsMQKKXl7g3E5gGV/X0nGNMJBwz+vGOkcSxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxWyVXhbxM9TL95GOdL85v+fceKdil9sRhSsp7l5FJOmeH41bLOOfiMlng2FV8trdUeXO5WrNz5HZLlKCboQD/i/Q9fn6jNjq/nxPqdqC5Wu9BEQkW4mCIwf7hOvPiAdB4vZFk6IfbtRvcjs0XxRv4arC1jhrIJdIH4kiUpZK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJ6ZoG4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acae7e7587dso190439766b.2;
        Thu, 17 Apr 2025 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744924678; x=1745529478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LleGygEKZOTFCjpqAtwuAogaCni3sDmlu3noPvzdSHY=;
        b=XbJ6ZoG4WXzIRfoGdQdihwaUpfmsyJNU6T1j6wAnOzgK4IgstH9VW3IqXW40nxcC6r
         zbnfyDsSQXRSe/+BrJmUsXCdmJNstGAv4Q6Fg4WcSJlxHespFg9+JTAPnBenmHrEarmc
         ZiLE1I1a2JGCZtosBARuu3hXVwjFVdPuUPF5FUtNF1RRkM5O3hSvOrqbmER96GUZoNN3
         +s6qyHeCQ1SX/h3fcPKInctswnpxDR578b6Eq+hgb2asuA41/x7i3tnvAK7xebTs4qrP
         JWLq9Vcj+KrdpseZALFmws5l2dKJ27Uw085OEUXywxDQ6CstlXRIvywwlPIkiL/XFBcL
         4uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924678; x=1745529478;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LleGygEKZOTFCjpqAtwuAogaCni3sDmlu3noPvzdSHY=;
        b=IpujQWJdO18QsSFZJSSKZhjrfUxdtB3/6Z4krRjginqYblgFnK9ahsPhltlFFYc9NH
         CkoQhXLFE0D6kaBHjyRisvRYJ/F9Acd1umq1Bgwb2NUZ3H7GQ82NWWXrGzAl+M6ksekr
         azuvN6hdE8nD8NCsdqrHXgbHeYps0o4dOrpO3n4RgiwYJbvcFgDqdYWdHEoE+1HyGJwY
         J9q/PvAtVKeZXVRGYmU2rhR8MoHVDFksskRjzZdD7Val7BLKGjcxG7JLsbh+jDOhzCVC
         Wmqj2WUFQHuyuNJo2Wmm7NuctgLgADaeumiKUZA6KL9B/HGbz0TCbRq52R73jDdWvmmk
         BzEg==
X-Forwarded-Encrypted: i=1; AJvYcCUYVv22G4jbbwe0eyduhbVh91oCEK6OeytktpSlVHjYqlriFtfM6x8ebJy+SklmvsCxb8JPEXCzVZ4c@vger.kernel.org, AJvYcCXGj1or8NyD2KkH7MoOJTq0Ba46HFZ0J+DzkRY3gIMa4PgYdAl7V/TejAey4dZuHaWn5E/0D3w1@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtNZ+zrAq8s2UKq5Ch3/0XKp8iPLBcT3MQswIr/6WcQyS1zXx
	lICzJDCFu+k0U9EyCGCENvtfXc7IuMZDY3CsoSEdPi1FsAzXfztk
X-Gm-Gg: ASbGncsBOKXUHVZNAUbTonme3oGINcnv38nX2WUL5Gj27l0Z4SJERJE6vihbsxumiUV
	aXW42QnV0+gtzcCedmlMcz8Q3m/XKTNMSXKDUbybb6Nv6Xf2ugHn5UOnnJfY1zgweSSH6s1lisQ
	+Se3lTGO2hXA+ZX0EZ+Pft6hDSFdGGVJIoUuSYfSkV1Zv6HF3jH0832NKcHFJSDRu+CKLbc6lCG
	xvmrSKBPBiVvRVzVE8eVZjpUP02kQT4lAU+oIR6mzASCeXyAFqzMtm/pPVdlRaiQk1oDzoZPVjR
	uz1LZEoKejfgHJj+IqEVVEPN8MxmoRe7u+LNPqFy1EEjDM5QzvMFIqcUiZQlEcHp4+F4E7l+WwI
	1kyjHUYM8+76ulV58+0op+iRKIx/5AEsoewpZ5Bz4RUR4Qyz75hplwxMS4q/TNQ1W4gRtDC7Wyn
	XBj/HxlMC86uxY2WO9dlUpztzaN+Jzye+n
X-Google-Smtp-Source: AGHT+IHgWZ6zBLXrzwVJT8HLzsaSLllReadQ9HZiOOwVSc5KIna4e2Bs50+CTJgH0VeGtb6hCxvp+A==
X-Received: by 2002:a17:907:1b2a:b0:aca:cb18:9ad0 with SMTP id a640c23a62f3a-acb74d83229mr31132066b.45.1744924677896;
        Thu, 17 Apr 2025 14:17:57 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af86:ee00:2c13:51b7:e758:1b52? (dynamic-2a02-3100-af86-ee00-2c13-51b7-e758-1b52.310.pool.telefonica.de. [2a02:3100:af86:ee00:2c13:51b7:e758:1b52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acb6ec13a5bsm39985566b.27.2025.04.17.14.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 14:17:57 -0700 (PDT)
Message-ID: <b5bb5e17-66cc-42e5-a000-b33dfe04b5b3@gmail.com>
Date: Thu, 17 Apr 2025 23:18:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-phy: remove
 eee-broken flags which have never had a user
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
 <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>
 <6a3d0502-01dd-4ffa-aab3-3bf97a4bc2f0@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6a3d0502-01dd-4ffa-aab3-3bf97a4bc2f0@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.04.2025 21:20, Andrew Lunn wrote:
> On Tue, Apr 15, 2025 at 09:55:55PM +0200, Heiner Kallweit wrote:
>> These flags have never had a user, so remove support for them.
> 
> They have never been used, but they are a logical description of the
> bits in the EEE registers. Do we think vendors have gotten better with
> EEE and are less likely to get it wrong at these higher speeds? Are we
> deleting them to just bring them back later? I don't know.
> 
These modes are not new, and I would expect that if there would be PHY
EEE issues, we should know meanwhile.

Even for 100BaseT/1000BaseT most eee-broken DT flags exist as a workaround
because the MAC doesn't support EEE. It's not that EEE in the respective
PHY's would be broken.

> I don't think there is any maintenance burden from them, so i would
> just leave them?
> 
I don't have a strong opinion here. If consensus is that we better leave
this code in, then fine with me.

> 	Andrew

Heiner

