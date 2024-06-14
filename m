Return-Path: <netdev+bounces-103732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF689093B0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3EB21F222AC
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF1C15B562;
	Fri, 14 Jun 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/GZJE4+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4914882D;
	Fri, 14 Jun 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718401006; cv=none; b=dFeqK0Jt3+OtmbD9CYJvHf5XJzqMXEEv2s1XC72OOmZuCcD3PcZlRl8G8bzkJDhidUkH0D+hTXr+4CQ5B3rXv1EaZM1+kbh0/p+oTOvDa110U7b5ZjlGl/9iAzKAbmFEo+m4rTGOdtix8wsDfmQpZe10zPoicE8orns+O9NE7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718401006; c=relaxed/simple;
	bh=q0g6ibi75ZEzD6ggra8+zOk+wRYXZj61KZeiY/yG4P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzngoKG4RAUzgcwQFoj9hsqvS10DNRtSywQp7fSRCdgpkHV6Gx8HlhATaMEbkKNVDqqJGohjBRxojjY2jV/cLW12Xf4lOqoUC8beNhgeFV5DAGoCQUd0dAMaemg8aJ/B0hL2RPn8c8WWDzMh6F1L70QqbAodiYGjamk4Zob4hGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/GZJE4+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso3912823e87.1;
        Fri, 14 Jun 2024 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718401003; x=1719005803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bPuWx3FNS7o7yVF4Y5MNousWkGaU6pMFEqKrEXP5xc4=;
        b=f/GZJE4+Rz36qz/SFySMk59b3bqp6qSY85IJc9EYXwOUJGhbz3fiY98sT9WXyjpH2m
         vCWQyEHBJ21FWkrnSxjRAORcodPJft9pT7r4onrfxx6+49fLliKz4YE7xmRmi+QllsFt
         MZm5ymCe5E7651KMU0RXM3ZB5UE7ipGNdIE3dGqfO7IMWb1Y/27NaClin74bIwc7Xy1Z
         sDjYUpd30mR9Hqx+ZW9erQweXCDQLL37edRiq1hR+JtRSIOpF5hO0QTTU6ROSfspwhdJ
         eRWuvHiAZY+ywOkeZUyInnAotYCZ3E3dKEelGcHkmx6Qo1e95Yn4QDJ/E83BOpUSlJzo
         eBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718401003; x=1719005803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPuWx3FNS7o7yVF4Y5MNousWkGaU6pMFEqKrEXP5xc4=;
        b=ipneLUmRhQQjxmd5c9VBiShB+udDco56hQAgwFA54bSTYTzKuVouV5zkV+0uZygpcR
         AjT68VxwN3fdqayDpQ1pCHbFzec05xU9ja6GWAPMlI4X3vktA0s7UVQX8eDVRRJ26dSG
         8Jun4WCJ3z5PyeS35w7J76H5F/MrfzyT7hY/3N2EPM4LjIWFVGCpXfwjq0Njlt2T3eqI
         xvxHuGsyGqPrDMi9e4tgfCDyrrNghpT7ReK10qwZK/Fa5KIAbgonm4gwV+oBKB+Pm1HX
         wEk8fD36/I8ZIQxajiVXtvyS56PsOrulx3dUdh1XUV3MkQdDsFtIfRzOA2VAp/KLh2cL
         5VTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJiksZyzaIQURlsWCQS/QGw5Ae1mSPuBtE6ZRhFDxiQ6wj8nTEZgnwE7p7DobMxjS7nRVluhuYzpf2hgDIVo3oKGK/xKYBAqPeqTCXwULr+Y1naiLMEGWxY5/6kg0jD+8pdadx
X-Gm-Message-State: AOJu0YytuvuK4Jf0QbXxwoaZ7U/oWUJaSzEEgaEk21sgYw20LjvKpnkj
	i9kWahcIIBC431gNF1ldfdEhBoUNYwKjnOW+YWKvTgKf9+zI4AwFfWZyKKI62F/FlhMqC9AmYWC
	yLcDEzQT6jwP2OqrZOTWQ7exl6Go=
X-Google-Smtp-Source: AGHT+IEmoSgtLwTY+KHsVc6GIwPMGR12YEcFNBBLmXtGr5ut1UXzXRAgLLv9mlDWzXaAwyJs4Pi7+h87CcyKoFuT5U0=
X-Received: by 2002:a19:f014:0:b0:52c:8440:1d7b with SMTP id
 2adb3069b0e04-52ca6e6e549mr2491614e87.36.1718401002763; Fri, 14 Jun 2024
 14:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz> <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
In-Reply-To: <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 14 Jun 2024 18:36:31 -0300
Message-ID: <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com>
Subject: Re: net: dsa: Realtek switch drivers
To: Linus Walleij <linus.walleij@linaro.org>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	"ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"justinstitt@google.com" <justinstitt@google.com>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Chris and Linus,

> > I'm starting to look at some L2/L3 switches with Realtek silicon. I see
> > in the upstream kernel there are dsa drivers for a couple of simple L2
> > switches. While openwrt has support for a lot of the more advanced
> > silicon. I'm just wondering if there is a particular reason no-one has
> > attempted to upstream support for these switches?
>
> It began with the RTL8366RB ("RTL8366 revision B") which I think is
> equivalent to RTL8366S as well, but have not been able to test.
>
> Then Luiz and Alvin jumped in and fixed up the RTL8365MB family.
>
> So the support is pretty much what is stated in the DT bindings
> in Documentation/devicetree/bindings/net/dsa/realtek.yaml:
>
> properties:
>   compatible:
>     enum:
>       - realtek,rtl8365mb
>       - realtek,rtl8366rb
>     description: |
>       realtek,rtl8365mb:
>         Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
>         RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL8367S,
>         RTL8367SB, RTL8370MB, RTL8310SR
>       realtek,rtl8366rb:
>         Use with models RTL8366RB, RTL8366S
>
> It may look like just RTL8365 and RTL8366 on the surface but the sub-version
> is detected at runtime.
>
> > If I were to start
> > grabbing drivers from openwrt and trying to get them landed would that
> > be a problem?
>
> I think the base is there, when I started with RTL8366RB it was pretty
> uphill but the kernel DSA experts (Vladimir & Andrew especially) are super
> helpful so eventually we have arrived at something that works reasonably.
>
> The RTL8356MB-family driver is more advanced and has a lot more features,
> notably it supports all known RTL8367 variants.

I played with RTL8367R. It mostly works with rtl8365mb driver but I
wasn't able to enable the CPU tagging. Although

> The upstream OpenWrt in target/linux/generic/files/drivers/net/phy
> has the following drivers for the old switchdev:
> -rw-r--r--. 1 linus linus 25382 Jun  7 21:44 rtl8306.c
> -rw-r--r--. 1 linus linus 40268 Jun  7 21:44 rtl8366rb.c
> -rw-r--r--. 1 linus linus 33681 Jun  7 21:44 rtl8366s.c
> -rw-r--r--. 1 linus linus 36324 Jun  7 21:44 rtl8366_smi.c
> -rw-r--r--. 1 linus linus  4838 Jun  7 21:44 rtl8366_smi.h
> -rw-r--r--. 1 linus linus 58021 Jun 12 18:50 rtl8367b.c
> -rw-r--r--. 1 linus linus 59612 Jun 12 18:50 rtl8367.c
>
> As far as I can tell we cover all but RTL8306 with the current in-tree
> drivers, the only reason these are still in OpenWrt would be that some
> boards are not migrated to DSA.

These drivers you listed are mostly found in old or low spec devices.
There is little incentive to invest too much time to migrate them. For
rtl8365mb, it still lacks support for vlan and forwarding offload. So,
the swconfig driver still makes sense.
There is also a performance problem with checksum offloading. These
switches are used with non-realtek SoC, which might lead to:

"Checksum offload should work with category 1 and 2 taggers when the
DSA conduit driver declares NETIF_F_HW_CSUM in vlan_features and looks
at csum_start and csum_offset. For those cases, DSA will shift the
checksum start and offset by the tag size. If the DSA conduit driver
still uses the legacy NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM in
vlan_features, the offload might only work if the offload hardware
already expects that specific tag (perhaps due to matching vendors).
DSA user ports inherit those flags from the conduit, and it is up to
the driver to correctly fall back to software checksum when the IP
header is not where the hardware expects. If that check is
ineffective, the packets might go to the network without a proper
checksum (the checksum field will have the pseudo IP header sum). For
category 3, when the offload hardware does not already expect the
switch tag in use, the checksum must be calculated before any tag is
inserted (i.e. inside the tagger). Otherwise, the DSA conduit would
include the tail tag in the (software or hardware) checksum
calculation. Then, when the tag gets stripped by the switch during
transmission, it will leave an incorrect IP checksum in place."
See: https://docs.kernel.org/networking/dsa/dsa.html

> But maybe I missed something?

I guess Chris is talking about the realtek target that uses Realtek
SoC (target/linux/realtek/files-5.15/). That is a completely different
beast. Although it might share some (or a lot) logic with current
upstream drivers, it is way more complex. It might require a
multi-function device driver. Anyway, the current realtek SoC/target
drivers need some love, like using regmap, implement functions using
an abstraction layer (and not if model a inside the code), get rid of
all magic numbers and replace them with meaningful macros, create a
proper tagger (and not translate a generic one just before forwarding
it). In OpenWrt, a code that gets things done might be acceptable but
the upstream kernel requires something more maintainable. So, if you
want to upstream those drivers, you can start by improving them in the
openwrt.

> Yours,
> Linus Walleij


Regards,

Luiz

