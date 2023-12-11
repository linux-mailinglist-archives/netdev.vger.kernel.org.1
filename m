Return-Path: <netdev+bounces-56019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B680D4DE
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540E61C208D4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9664F203;
	Mon, 11 Dec 2023 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhS3mulj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3F98
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:01:05 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so556483466b.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317664; x=1702922464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oih71XhHF6ujiKAxYDkqouB2sQ0yEjdxmK5GTiHqg/Q=;
        b=JhS3muljE3oDbyCaJa4kQtNo3A44wSSSpKCV651mcW8XYpv6OXNXlmdOUsKE4XsbPC
         GzFuTIiG2t+xDLrYDDjO2ie1+cWT6k+/GRpKr2fzgsg2fQu5W/sZQYzD8tGS2MgyObx+
         sdiJC6FQavyzKze/vf7ItU5zr5zNlCxPrJeUw71kn5yuHrU+b3pkm3AtrvXI1NJXmqVP
         dAPhjmrCadd4NTuX3hpaDq6lLeCAyHQHNZw/fRQNC2QOYZ8DOcFBBWhqAVkfY8lMM/Kq
         d/BoFZx6od84TdiuGLPrmteDp9w0erF6DsILk5naCTYF8ZGizAB1TWA0Pv0L0L+ljdtP
         9irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317664; x=1702922464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oih71XhHF6ujiKAxYDkqouB2sQ0yEjdxmK5GTiHqg/Q=;
        b=wmF346vOusNKuHp4QnJw751X97skm0mYH8zXy9nCBF0DeKBQWviezVUIDIX+98+MSD
         ydaSPxiW4be0P4/mBXG96N6z1v6Z0hiQfbApoPMNW3yFUtjPVGgmQ4Vjz5V6uWIfZvQd
         b4+VuU8x+IQpzlfyWQLgv/wF5JLsa/ghraIWmvW3SFivEm2SZ074D0GUle6o5Ks8Az9V
         PCtJv5xhO+5H1oHFiNotGpSPzraUdAxKK9LysGWlbT7uX1EgPJR4XTTbwcx4FVzJNqO9
         8610OROpO1oFDuZ9tFp7fycHRErEIhV2bdQW8N2FNiAMcLkQqdKLV8dsQ8e0QtzWG7xL
         ElWg==
X-Gm-Message-State: AOJu0Yw1OxKiGhxtVQzP6mUgWtjmVsgzgqSyTZPFgpB4FJkK2orGruK/
	rAF+kyZuMznOJmJ9WqCGOYg=
X-Google-Smtp-Source: AGHT+IEjenm2FSJUCshi8UVywu59w4WeYbceM0rXqOTq+75UVjNBni6xBwdPR8RjHf85AyjQkd/gFg==
X-Received: by 2002:a17:906:7310:b0:a18:ab2f:467f with SMTP id di16-20020a170906731000b00a18ab2f467fmr2870742ejc.37.1702317664104;
        Mon, 11 Dec 2023 10:01:04 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id ub27-20020a170907c81b00b00a1df4387f16sm5211675ejc.95.2023.12.11.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:01:03 -0800 (PST)
Date: Mon, 11 Dec 2023 20:01:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [net-next 2/2] net: dsa: realtek: load switch variants on demand
Message-ID: <20231211180101.twpcepmdivsi7ymn@skbuf>
References: <95381a84-0fd0-4f57-88e4-1ed31d282eee@kernel.org>
 <7afdc7d6-1382-48c0-844b-790dcb49fdc2@kernel.org>
 <CAJq09z5uVjjE1k2ugVGctsUvn5yLwLQAM6u750Z4Sz7cyW5rVQ@mail.gmail.com>
 <vcq6qsx64ulmhflxm4vji2zelr2xj5l7o35anpq3csxasbiffe@xlugnyxbpyyg>
 <CAJq09z4ZdB9L7ksuN0b+N-LCv+zOvM+5Q9iWXccGN3w54EN1_Q@mail.gmail.com>
 <20231207171941.dhgch5fs6mmke7v7@skbuf>
 <CAJq09z7j_gNbUcYDWXjzUNAXat-+EyryFJFEqpVG-jPcY4ZmmQ@mail.gmail.com>
 <20231207223143.doivjphfgs4sfvx6@skbuf>
 <CAJq09z70hfygcB5LL3Rp9GQ0180mTJauH6qVeAPqm1zO4HiAAQ@mail.gmail.com>
 <CAJq09z70hfygcB5LL3Rp9GQ0180mTJauH6qVeAPqm1zO4HiAAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJq09z70hfygcB5LL3Rp9GQ0180mTJauH6qVeAPqm1zO4HiAAQ@mail.gmail.com>
 <CAJq09z70hfygcB5LL3Rp9GQ0180mTJauH6qVeAPqm1zO4HiAAQ@mail.gmail.com>

On Thu, Dec 07, 2023 at 11:46:46PM -0300, Luiz Angelo Daros de Luca wrote:
> The device-tree bindings should delineate the hardware characteristics
> rather than specifying the implementation details of a particular
> driver. The requirement of an "mdio" node with a compatible string
> such as "realtek,smi-mdio" may be misleading, implying a potential
> correlation between the host-switch interface (SMI, SPI, or MDIO) and
> a specific user MDIO it describes. It's important to note that how we
> describe the user mdio could vary for other future switch families,
> but not with a distinct management interface.

Agree, "realtek,smi-mdio" is not a great compatible string. But it is an
established compatible string.

> I am currently conducting tests using the same user MDIO driver for
> both realtek-smi and realtek-mdio. However, it's noteworthy that
> unlike realtek-smi, the current user MDIO for realtek-mdio does not
> require a compatible string; only a node named "mdio". Realtek-mdio is
> presently utilizing the generic DSA user MDIO, but you mentioned it's
> not considered a "core functionality." I assume this implies I
> shouldn't depend on it. That's the reason for my switch to the
> existing user MDIO driver from realtek-smi.
> 
> Regarding the absence of a compatible string for realtek-mdio, we have
> a few options: introducing a new compatible string exclusively for
> realtek-mdio, such as "realtek,mdio-mdio"; creating a new generic one
> for both interfaces like "realtek,user-mdio" or "rtl836x-user-mdio";

The naming choice really looks like the secondary problem here.
But what about "realtek,rtl8365mb-mdio" and "realtek,rtl8366rb-mdio" as
a secondary compatible string for SMI, and primary compatible string for
MDIO-connected switches?

> or simply ignore the compatible string, as you suggested. However, if
> I opt to ignore it, I presume I should retrieve that node solely based
> on the node name. That's what I'm after. Is my understanding correct?

You could do that. There's a very high chance that the node was named
"mdio". The schema says it should be called "mdio", _and_ be compatible
with realtek,smi-mdio. If anyone comes and complains (very unlikely),
just say "hey, even Documentation/devicetree/bindings/net/dsa/realtek-smi.txt
said you should name the node 'mdio'"!

> I'll post a new series that is still compatible both with old HW
> descriptions and the device-tree bindings. In that way, I'll not touch
> the docs.

> However, given that the compatible string is unnecessary to describe
> the hardware, and after we modify the code to disregard it, it is
> awkward for the binding documentation to request a compatible string
> that serves no purpose. Shouldn't we consider updating this
> requirement at some point?
> 
> Regards,
> 
> Luiz

Not everything that is in the device tree has to be used. It is a
description of the hardware, not a rigid set of instructions for what
the OS has to do. The OS still does whatever it wants based on that info.

You can ask anyone about this. See Thomas Petazzoni's slides as just one
example.
https://elinux.org/images/f/f9/Petazzoni-device-tree-dummies_0.pdf

| The Device Tree is really a hardware description language.
| It should describe the hardware layout, and how it works.
| But it should not describe which particular hardware configuration you’re interested in.
| As an example:
| You may describe in the DT whether a particular piece of hardware supports DMA or not.
| But you may not describe in the DT if you want to use DMA or not.

It's a really weak argument for recommending users to remove the compatible
string, thereby deliberately breaking ABI compatibility in one direction,
to literally _no_ benefit.

Compatible strings for MDIO controllers are, in essence, not strange.
They are independent devices which could reasonably be bound to their
own drivers. I don't see what's awkward about this.

