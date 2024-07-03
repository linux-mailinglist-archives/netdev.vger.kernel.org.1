Return-Path: <netdev+bounces-109038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742AB926993
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376302848EE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121B17DA20;
	Wed,  3 Jul 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaQELECc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE644964E;
	Wed,  3 Jul 2024 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038686; cv=none; b=u1UADqc2ZdNwFiwGAAOLGypPul9r5l6Kq7peDmsoemTKnZrFOzoj/m1oJYf6vD3/5oPnm43l1HWlnu4RPmr70wPghdTznHbiwuVRDReZkl08gYzi4lZxIwZ9RtjfMjcJzMwG2Au6Mgy/i3WEZZsu093FkK3tTkc6vQrGdyqi4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038686; c=relaxed/simple;
	bh=28CwKUBpxn29hreka2jtVxsXjE9DWJUpeBMm2mXFMKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxMehRX6BpJgLVFtTxVdUWa0PibeCWsEbzuhuXm3K2SzRF6cg7qK6ynYHnLlvFirSm4iTIGbrdwbXqsjXHVByF1vgk8N8OUVrqW+sTz3jhGlkrkKReIDvb8xzN8ujmdLBLcrmFsUXufOVHYwZwBV0bR5CDp7VpAjajSSrbNV8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaQELECc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso56989731fa.3;
        Wed, 03 Jul 2024 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720038683; x=1720643483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxQPKIQ3HTrHnNwff3QYIMoIek786yjRZFVT1LlX/d8=;
        b=MaQELECcLuYYVx1UGpfAkc+CKhlnd5tL1AglJStZMt4q+ADz05JgyTFyVDwJgjbkJo
         NdNNpEw8i56rTqYBP1qU6QsbMEUPwZrj9ifh6t95Btzs06Gx60EP2bxz15K+UMYGOKCp
         PyM/5NpgZhCJZ0NP8BXobiTXjisJ6HKysD03mdYbGkwH8fIw2xX7BHFgBzjYJX5TfCCJ
         QATi7pko7yWAtocsCi2oCKXk90THGoQDpAAVwl7cBA4HpKD79oP7RAT3AQgnGcXyXyET
         tv/GdJaEtd3Z6YxeDhl0pTmqcBGfc5IR3/dOXRx+fxaqH6i/ftu83TmyuLl5o7lgi06N
         OtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720038683; x=1720643483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxQPKIQ3HTrHnNwff3QYIMoIek786yjRZFVT1LlX/d8=;
        b=O23I+/dtbRmEVbpzNnsqWIKN9mIBXxyTGwQ0wPshy/s+seo5UW1mfIRCeVRQxnRiNC
         vMziWChmJwV67A+/M9kZJ+WqjWqfdjaegFh5oqhvT6AARKgA/FOwnLU8bKALsmbcvt6F
         xN5EykndcIvti/UR9Wd83diuadj3YGWAugavNTlEzjB1y/eKmDV513CZgdILXsLrfPR/
         /kKZdeXAjry8+dZDjiVtyjWyDtOEYsYGYNKUBHAZdBTTOJuZkOoF7vM5XVuyHHA5Cslg
         k3cDq6IFn+XjQX7VfDu+xQGRCo8Q3I62diR/Hv8SasGbYtZCQXeAT+oU3F9AOgCWP3Ev
         NhhA==
X-Forwarded-Encrypted: i=1; AJvYcCX6IZn/ZgWSKsTzNh5EMCZvJZLcnfg4w6TP0vXvo905JPmNnhGMp29fhoWLUr7sRlXHeYnUWz0M3dS7qNauvVzIsOZ6vVWy7JtvTrOWW5o79WiK6xd/EIMQLQflWyFFH+jFhFxE
X-Gm-Message-State: AOJu0YzUD5hVt/064lwUg1rBu85DkQ0OZkJ9tD/ROFSXasOh2ZVHptCp
	Ea/R1yTdBpnc4jNi9e0d6Pc09Ay8IyWCNL8oWYsR7HJGrQtqsMTbsLqpp87NkuQaf1K16aGLP2P
	4av6J5vUfkFlR9HJ0LNtmenihHKdXUmKk
X-Google-Smtp-Source: AGHT+IFoeK/j/BiQlJ84Hk5d+C/64MO9ULJ/NDXv9h23TkeLVAeFB9gn8BRnxA72N8BTWVLsxHFnRxw/4FSKuI6Qdkg=
X-Received: by 2002:a2e:a78a:0:b0:2ee:5ed4:792f with SMTP id
 38308e7fff4ca-2ee5ed47fcbmr98080471fa.2.1720038682299; Wed, 03 Jul 2024
 13:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5ffa9a-62cc-4a79-9368-989f5684c29c@alliedtelesis.co.nz>
 <CACRpkdbF-OsV_jUp42yttvdjckqY0MsLg4kGxTr3JDnjGzLRsA@mail.gmail.com>
 <CAJq09z6dN0TkxxjmXT6yui8ydRUPTLcpFHyeExq_41RmSDdaHg@mail.gmail.com> <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
In-Reply-To: <b15b15ce-ae24-4e04-83ab-87017226f558@alliedtelesis.co.nz>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 3 Jul 2024 17:31:10 -0300
Message-ID: <CAJq09z5EWps3j1jZPj2J+j=hmzmpvF8QdUJpKADz6nQ_jJEjGw@mail.gmail.com>
Subject: Re: net: dsa: Realtek switch drivers
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Linus Walleij <linus.walleij@linaro.org>, "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"olteanv@gmail.com" <olteanv@gmail.com>, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	"ericwouds@gmail.com" <ericwouds@gmail.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"justinstitt@google.com" <justinstitt@google.com>, 
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, netdev <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"sander@svanheule.net" <sander@svanheule.net>
Content-Type: text/plain; charset="UTF-8"

Em seg., 1 de jul. de 2024, 23:09, Chris Packham
<chris.packham@alliedtelesis.co.nz> escreveu:
>
>
> On 15/06/24 09:36, Luiz Angelo Daros de Luca wrote:
> > Hello Chris and Linus,
> >
> >>> I'm starting to look at some L2/L3 switches with Realtek silicon. I see
> >>> in the upstream kernel there are dsa drivers for a couple of simple L2
> >>> switches. While openwrt has support for a lot of the more advanced
> >>> silicon. I'm just wondering if there is a particular reason no-one has
> >>> attempted to upstream support for these switches?
> >> It began with the RTL8366RB ("RTL8366 revision B") which I think is
> >> equivalent to RTL8366S as well, but have not been able to test.
> >>
> >> Then Luiz and Alvin jumped in and fixed up the RTL8365MB family.
> >>
> >> So the support is pretty much what is stated in the DT bindings
> >> in Documentation/devicetree/bindings/net/dsa/realtek.yaml:
> >>
> >> properties:
> >>    compatible:
> >>      enum:
> >>        - realtek,rtl8365mb
> >>        - realtek,rtl8366rb
> >>      description: |
> >>        realtek,rtl8365mb:
> >>          Use with models RTL8363NB, RTL8363NB-VB, RTL8363SC, RTL8363SC-VB,
> >>          RTL8364NB, RTL8364NB-VB, RTL8365MB, RTL8366SC, RTL8367RB-VB, RTL8367S,
> >>          RTL8367SB, RTL8370MB, RTL8310SR
> >>        realtek,rtl8366rb:
> >>          Use with models RTL8366RB, RTL8366S
> >>
> >> It may look like just RTL8365 and RTL8366 on the surface but the sub-version
> >> is detected at runtime.
> >>
> >>> If I were to start
> >>> grabbing drivers from openwrt and trying to get them landed would that
> >>> be a problem?
> >> I think the base is there, when I started with RTL8366RB it was pretty
> >> uphill but the kernel DSA experts (Vladimir & Andrew especially) are super
> >> helpful so eventually we have arrived at something that works reasonably.
> >>
> >> The RTL8356MB-family driver is more advanced and has a lot more features,
> >> notably it supports all known RTL8367 variants.
> > I played with RTL8367R. It mostly works with rtl8365mb driver but I
> > wasn't able to enable the CPU tagging. Although
> >
> >> The upstream OpenWrt in target/linux/generic/files/drivers/net/phy
> >> has the following drivers for the old switchdev:
> >> -rw-r--r--. 1 linus linus 25382 Jun  7 21:44 rtl8306.c
> >> -rw-r--r--. 1 linus linus 40268 Jun  7 21:44 rtl8366rb.c
> >> -rw-r--r--. 1 linus linus 33681 Jun  7 21:44 rtl8366s.c
> >> -rw-r--r--. 1 linus linus 36324 Jun  7 21:44 rtl8366_smi.c
> >> -rw-r--r--. 1 linus linus  4838 Jun  7 21:44 rtl8366_smi.h
> >> -rw-r--r--. 1 linus linus 58021 Jun 12 18:50 rtl8367b.c
> >> -rw-r--r--. 1 linus linus 59612 Jun 12 18:50 rtl8367.c
> >>
> >> As far as I can tell we cover all but RTL8306 with the current in-tree
> >> drivers, the only reason these are still in OpenWrt would be that some
> >> boards are not migrated to DSA.
> > These drivers you listed are mostly found in old or low spec devices.
> > There is little incentive to invest too much time to migrate them. For
> > rtl8365mb, it still lacks support for vlan and forwarding offload. So,
> > the swconfig driver still makes sense.
> > There is also a performance problem with checksum offloading. These
> > switches are used with non-realtek SoC, which might lead to:
> >
> > "Checksum offload should work with category 1 and 2 taggers when the
> > DSA conduit driver declares NETIF_F_HW_CSUM in vlan_features and looks
> > at csum_start and csum_offset. For those cases, DSA will shift the
> > checksum start and offset by the tag size. If the DSA conduit driver
> > still uses the legacy NETIF_F_IP_CSUM or NETIF_F_IPV6_CSUM in
> > vlan_features, the offload might only work if the offload hardware
> > already expects that specific tag (perhaps due to matching vendors).
> > DSA user ports inherit those flags from the conduit, and it is up to
> > the driver to correctly fall back to software checksum when the IP
> > header is not where the hardware expects. If that check is
> > ineffective, the packets might go to the network without a proper
> > checksum (the checksum field will have the pseudo IP header sum). For
> > category 3, when the offload hardware does not already expect the
> > switch tag in use, the checksum must be calculated before any tag is
> > inserted (i.e. inside the tagger). Otherwise, the DSA conduit would
> > include the tail tag in the (software or hardware) checksum
> > calculation. Then, when the tag gets stripped by the switch during
> > transmission, it will leave an incorrect IP checksum in place."
> > See: https://docs.kernel.org/networking/dsa/dsa.html
> >
> >> But maybe I missed something?
> > I guess Chris is talking about the realtek target that uses Realtek
> > SoC (target/linux/realtek/files-5.15/). That is a completely different
> > beast. Although it might share some (or a lot) logic with current
> > upstream drivers, it is way more complex. It might require a
> > multi-function device driver. Anyway, the current realtek SoC/target
> > drivers need some love, like using regmap, implement functions using
> > an abstraction layer (and not if model a inside the code), get rid of
> > all magic numbers and replace them with meaningful macros, create a
> > proper tagger (and not translate a generic one just before forwarding
> > it). In OpenWrt, a code that gets things done might be acceptable but
> > the upstream kernel requires something more maintainable. So, if you
> > want to upstream those drivers, you can start by improving them in the
> > openwrt.
>
> So now got access to the Realtek docs and I've been pouring over them
> and the openwrt code (I'm avoiding looking at the Realtek SDK for now,
> just to make sure I don't submit something I don't have the rights to).
>
> If someone were to look at the block diagram in the brief datasheet
> they'd probably come away with the impression that it very much fits the
> DSA model. There's a SoC portion with the CPU, peripherals and a "NIC".
> That NIC is connected to the CPU MAC in the switch block. All seems like
> a pretty standard DSA type design and that's what the openwrt code
> implements a ethernet/rtl838x_eth.c driver for the Ethernet NIC and a
> dsa/rtl83xx driver for the DSA switch.
>
> But when you start digging into the detail you find that the registers
> for the NIC are scattered through the address space for the switch. Same
> for the MDIO related registers. There is a more detailed block diagram
> in the CPU and Peripherals datasheet that shows the NIC and switch as
> part of the same IP block. The openwrt implementation does things that I
> think would be frowned upon upstream like calling from the Ethernet
> driver into the switch driver to access registers.

Wouldn't that be a case for Multi-Function Device driver? From docs,
"A typical MFD can be:
- A mixed signal ASIC on an external bus, sometimes a PMIC (Power
Management Integrated Circuit) that is manufactured in a lower
technology node (rough silicon) that handles analog drivers for things
like audio amplifiers, LED drivers, level shifters, PHY (physical
interfaces to things like USB or ethernet), regulators etc.
- A range of memory registers containing "miscellaneous system
registers" also known as a system controller "syscon" or any other
memory range containing a mix of unrelated hardware devices."

Vladimir Oltean was the first to suggest to me the use of MFD for DSA
switches as they commonly need two drivers: DSA and the user mii bus
driver. The Realtek SoC just seems to make it more needed as we have
other functions registers scattered.
https://lore.kernel.org/netdev/20231211143513.n6ms3dlp6rrcqya6@skbuf/

The OpenWrt driver does work and I think it can be incrementally
improved up to upstream status. It is a bit messy but you could start
untangling it there, trying to decouple (the non-existing) tagger,
ethernet, phy and DSA drivers (and whatever else shares the same
register space). The upstream realtek drivers use a common
code+subdrivers model while the Realtek SoC DSA driver in OpenWrt uses
a single driver with lots of ifs inside each function. I don't know if
they can be merged into a single driver tree, sharing as much as
possible, or Realtek SoC will require a completely duplicated tree.

> This leads me to conclude that what Realtek call the "NIC" is actually
> just the DMA interface for packets sent from or trapped to the CPU.
> Rather than trying to make this fit the DSA model I should be looking at
> using switchdev directly (I can still probably leverage a lot of code
> from the openwrt drivers because the switch tables are the same either way).
>
> What would I be loosing if I don't use the DSA infrastructure? I got
> kind of hung up at the point where it really wanted a CPU port and I
> just couldn't provide a nice discrete NIC.

---
     Luiz Angelo Daros de Luca
            luizluca@gmail.com

