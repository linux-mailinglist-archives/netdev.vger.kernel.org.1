Return-Path: <netdev+bounces-156988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EEBA0897F
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6B2168BAA
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCF2066E5;
	Fri, 10 Jan 2025 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH4xv65I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B0133987
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496303; cv=none; b=XyMRQ6kHl9zVT0/YRYCH67ncIbFkN9NT/D3ur449OQgXpg+EMVpv71OLM12/lpPiEEOO/r1m8Luuxq0bwC1fHKwLfvk6g+TSEajGRSTmb1VGYDvwB4Jx71/JQXpR70AKtNWEks0YtMy5ZxKCFZxePOgaa/DrdO7Trqj6zsOWLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496303; c=relaxed/simple;
	bh=HHE5VPD/nIq3qUsGJ+suHBl5EQQ6xFSGwApL621v3Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cm9TtfvqPrJ65HvTKNsMWU0yo4ZDGHjekYKpH1VRynmonAGUu3gzVGjHA7mDGcCXeBs86QnqyHCxYqYQUL/4qnbODClV3vYVZHRNlDdCwAvBi8JizzUK7nDJ5TyAgbR39LhdamiCZISY1L1ubt3pk/0KKYUYpHbi+XqcQRyfeEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH4xv65I; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so2798277a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 00:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736496300; x=1737101100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w33jw1q4Iy6fLg7J+U6vKqGOAfKskZPYBAN9gxyTK/M=;
        b=WH4xv65IZBWE5dHZPXS8KUEzzGNkKUv/fm+az9I5Zlr9OpJ4mw1R40HGirV/lS5ymG
         d8enDRRoL4Tzx7h9X8dZYKyg01R7TXPog0QkuTTr6hnN6Dh0HVvx0b/YWRK+bRPhM1wl
         WG7bzSyXS14gf2SCoH6mTEWVECCpZaJUp8e0xuaS12F7Y91f0b7xetWLwarFdYfBubac
         TXiQXLulVZuKx+tfpajHwC6YYtZoTscTuLSznSo8q8ywjdbslFi8Umg06HqH71GWKKEl
         X7e2SEW5JaH8PYHC05iDqtuZPppxRR9BRGnJ3ubgpFD3bsBzwcYv9OvtEl5sd5ytoub+
         F2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736496300; x=1737101100;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w33jw1q4Iy6fLg7J+U6vKqGOAfKskZPYBAN9gxyTK/M=;
        b=S3Fiq3NY3STS6lNjZRbcO/h55iwriZYXj6z/87g3bvJM1d5/mdXmFfmS+lw8LzTkGy
         StWhIwEeYazcANVMNk/s0DgsSNSAK9qCyOE4TOxy/7XskKQyw167281fRXHpz3YRCvcu
         ykJQOJ8RlnUi5EJ7UbXsHe1L7hKwS2o2PJYuWCDxNWhcY6pwX0eVqyKcf/g2OlyZXUUs
         y6syDVxm7VS+gsl9bDrMAL8xHBDagjRrad/GGoER70K1iOFlTvLhtfFuI0mYnbL61EdV
         iy49BsAWor/n6Cwpno0wb+tpfaW2u7tTRRygX9UGoAvow/fbZMxihOOSjfmZKx6K4DCh
         JVuA==
X-Forwarded-Encrypted: i=1; AJvYcCWJfJ99VIWPQo3tmlfesbecjFV7RzWNn2Sh/IbO3oGK61SyAbdWYgLMwMd9bgs/PUr20/d5Sxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRoxsDjTup5qQ66gg1TgI/jgTj1tD+TfInPQvXw5qJ58vBAbn
	BBHv90ah6kF1/IH8IOOp8fXcCmohkOXJOI0yKPvDetFt8qX/1k79
X-Gm-Gg: ASbGnctQdVa8/U0pQguUv7dKpI0BBorIsN1is0Qykf6ZJPtW2FSSL3XQQIfJDkKazTr
	iCc2Um/o7pDFJbi1Sgh9/uVMJWwX7kGkWCKLhqexuOw4B4DKhslC1+W6SO6u3a1nV7z2JByKFxQ
	KqPXmSlD0KZPcXQwx9utZPwA8jHMhCY9vHoP2Aw22f+dPgaUK2ok1xwBcfblwB1cL6UTUNzylWN
	pDWEMA28csda8gMQs/szZ02w9P6b59dbZoofxPcXnUJ9GpMvj2ME/bLtG5RJJ2JvCYCbKZsWgjZ
	g8TAwtaVwutp6K+BxhL2o+uOU7SKebHC6XU7+OMLUzY8hVXJkZrEfV/dJG0s3rFdkoedjZwn7yW
	HsHaeijX2n31aDO3pcUR/YcF1yPV0LE0=
X-Google-Smtp-Source: AGHT+IGbgCuh3qC7xY8GvEiBWaGdc/P4HDKXuM2eWs1hM1/IBlvby9L+VE2CIAbznQNTJB1KVadNgQ==
X-Received: by 2002:a05:6402:51cf:b0:5d1:22c2:6c56 with SMTP id 4fb4d7f45d1cf-5d972e1be28mr9171656a12.17.1736496299668;
        Fri, 10 Jan 2025 00:04:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c523sm1409367a12.8.2025.01.10.00.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 00:04:58 -0800 (PST)
Message-ID: <a54b564b-4f88-4783-9e8a-72289ce11c04@gmail.com>
Date: Fri, 10 Jan 2025 09:04:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: phylink: provide fixed state for
 1000base-X and 2500base-X
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Couzens <lynxis@fe80.eu>, Alexander Duyck <alexanderduyck@fb.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ar__n__ __NAL <arinc.unal@arinc9.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Daniel Golle <daniel@makrotopia.org>,
 Daniel Machon <daniel.machon@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, DENG Qingfang <dqfext@gmail.com>,
 Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
 Jose Abreu <Jose.Abreu@synopsys.com>, kernel-team@meta.com,
 Lars Povlsen <lars.povlsen@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Paolo Abeni
 <pabeni@redhat.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Wang <sean.wang@mediatek.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
 <E1tVuG1-000BXo-S7@rmk-PC.armlinux.org.uk>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <E1tVuG1-000BXo-S7@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/9/25 4:15 PM, Russell King (Oracle) wrote:
> When decoding clause 22 state, if in-band is disabled and using either
> 1000base-X or 2500base-X, rather than reporting link-down, we know the
> speed, and we only support full duplex. Pause modes taken from XPCS.
> 
> This fixes a problem reported by Eric Woudstra.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c

After changing 'if (pcs->neg_mode)' to 'if (pcs && pcs->neg_mode)' in
patch 1/5, I have tested this patch-set and I get link up.

Tested-by: Eric Woudstra <ericwouds@gmail.com>


