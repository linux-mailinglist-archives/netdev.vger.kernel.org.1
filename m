Return-Path: <netdev+bounces-242054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1F7C8BECA
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 21:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C4F3A74FE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66A33FE03;
	Wed, 26 Nov 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao41VIod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB22D2390
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764190583; cv=none; b=MRV9JfXa8P5+SkMZonmP/pM7aya2ZLT3KlJMEcygiu3wKLRdvT42EsvWiZSTmnO6mF1IGSLgAnaR3qO7fENVLXGB1VuqZN68Bx8lzFF1DRbm6pe3b0emB1CPimkpAGhGAjhBT1/aBCn4yiWMYdWKSyA2ytuKWL7ealNM8pzWE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764190583; c=relaxed/simple;
	bh=Dt350O4s7/IUq+j9naCofzl4cWJ8WislzSXHIBeUF9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ9fZArw2yve9/TdXXnXy42Dt8maeb4qRizHwbhue8j1hVmHq79oOslJOnPMphWD4+G0Y+Zj+1UMaCaPkI0mnaOnIQ+XNUvPqy+LvBLqVhvOtMa6iTd9AUR2P/J2/e3O3pFwAfsUSgfwuGq3hI7T/al8Cg4rnwtIRpMlKMVvH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ao41VIod; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b32a5494dso141326f8f.2
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764190579; x=1764795379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt350O4s7/IUq+j9naCofzl4cWJ8WislzSXHIBeUF9w=;
        b=ao41VIodm6FTNBwsolI2pjkHM5dolV5rBr19ho/wEOfbWyXWxa99W5ZM05PXpUO+zr
         XeiuL5MPx9U8qwMiY7weF7Jd1TTqlDATdRVLVgY9gor64gBndr5/3wi5DprLjhxaYr29
         Rmw+PemP6IFnkF0JGn704Bjy0QDEHIW6cOEx5DhUvShdLlmNteGO8mgh/p8dvo+jVAir
         nXIXj24QPFsIgQViK7rykkHlNlGo0uOaW4RM+TG2R9NHPkH+Q8dPUaKGHLDOO5v5bFlQ
         3lqyVDA9d3SDwjjkXkVKNRy6Eq6FAsRg03xG3fK+bIJzH5RDjR0K7GwL5FP3SF2GqP0n
         Nrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764190579; x=1764795379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dt350O4s7/IUq+j9naCofzl4cWJ8WislzSXHIBeUF9w=;
        b=CdhSCw+gsZJPFTfSdi3WSAvRsbGNtLDkNSIsvev9u9dXPNmRWPeobOAdqNoR/1EDwb
         tg3+dEe5zIU820F5RxDXLgcOWDrcG25YJJgGdeECjQZGFCt6Y3ElF8pOdIcka1M5yDqj
         t/peJ6bbYpUmIXjFAJbfu6Nh1K3FQ7YtqneGS5ZRUBbub5peq/FijWA3SNLSS62J1eLm
         e1EgxwbSSaIhQDiqR3Dww0rsc481x1z+xwkTXvgWPWmrblm4myCPdcW1/2AgKFwWJ+8G
         GvPLAz2byt60RitL8h7dKL8ZHVunnXiUBBhqGtxf25kiXvWTpOinWlAsaYEDR9nDm/yO
         7RhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjAuBaqMpMzS796X1wQsTSFPdgNBbTRoIAG7KElE5rTlzomSkUGnTMe/fVs6Ncm6iY0r8AQXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnd4VPFA0GIcUd387PjjZT2WKWEV4xGVQ3j1Ws2ihDNzFFIWP7
	ViY9AumcgexcIYW+Oz/HQ40MsyrPNn2z+Ejli0GfwFvma01rx6p2szuHj+wX3I9lD17LH8m2jAF
	5OgbDLnEAofTqxIy20xoayq0Jzd+fkus=
X-Gm-Gg: ASbGncsOr19qcaY+JQPCT7ITm+HyYPOeT03CJ8DB9jr4+8LePgir9n/YPFh3ueNHYrb
	HP58bOpYStGHNHCjIWWvhaXTzKkaz4BO9yQagJY7Zo2J/OPOnuNL7tKgAzEEmpfGZfSLl6CyFR/
	dgyv/hyRKpnEN1Ud8Eiu8unhkHNzymyxr93/ES0Q+E6FgdYPXX1xG5EaGrltyd02Ia2FtQH2UmW
	wIz198neZVA7wW9F4/OArTb6yVFhxhSl5fm0YhaImdvLaJTHvCAwCG/Ch+F95WSu21oFctM0ISQ
	4To5wtp4
X-Google-Smtp-Source: AGHT+IG0RXp7g3rwG1N9bVOtQ9ozNjjP0xKrNIIS8B+mwcvqHsgckTZtjgViUtn3Goop7bdPAsM6eed81Zilw5ZfTQI=
X-Received: by 2002:a05:6000:2f81:b0:429:bc68:6c95 with SMTP id
 ffacd0b85a97d-42cc1d520camr24897838f8f.47.1764190579376; Wed, 26 Nov 2025
 12:56:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251112201937.1336854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <de098757-2088-4b34-8a9a-407f9487991c@lunn.ch> <CA+V-a8vgJcJ+EsxSwQzQbprjqhxy-QS84=wE6co+D50wOOOweA@mail.gmail.com>
 <0d13ed33-cb0b-4cb0-8af3-b54c2ad7537b@lunn.ch>
In-Reply-To: <0d13ed33-cb0b-4cb0-8af3-b54c2ad7537b@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Nov 2025 20:55:53 +0000
X-Gm-Features: AWmQ_bnVIRWusTHYXQG_pEIVx7CON6jGq6AQSdf9oiT5MLxC0fJE8jZLc8Q18PI
Message-ID: <CA+V-a8vx5KTUD_j7+1TC9r5JrGo2fJ0D7XXJCc-oHidtbUN=ZA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pcs: renesas,rzn1-miic:
 Add renesas,miic-phylink-active-low property
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Nov 13, 2025 at 9:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Each of these IPs has its own link status pin as an input to the SoC:
>
> > The above architecture is for the RZ/N1 SoC. For RZ/T2H SoC we dont
> > have a SERCOS Controller. So in the case of RZ/T2H EVK the
> > SWITCH_MII_LINK status pin is connected to the LED1 of VSC8541 PHY.
> >
> > The PHYLNK register [0] (section 10.2.5 page 763) allows control of
> > the active level of the link.
> > 0: High active (Default)
> > 1: Active Low
> >
> > For example the SWITCH requires link-up to be reported to the switch
> > via the SWITCH_MII_LINK input pin.
>
> Why does the switch require this? The switch also needs to know the
> duplex, speed etc. Link on its own is of not enough. So when phylink
> mac_link_up is called, you tell it the speed, duplex and also that the
> link is up. When the link goes down, mac_link_down callback will be
> called and you tell it the link is down.
>
Sorry for the delayed response. I was awaiting more info from the HW
team on this. Below is the info I got from the HW info.

EtherPHY link-up and link-down status is required as a hardware IP
feature, regardless of whether GMAC or ETHSW is used.
In the case of GMAC, the software retrieves this information from
EtherPHY via MDC/MDIO and then configures GMAC accordingly. In
contrast, ETHSW provides dedicated pins for this purpose.
For ETHSW, this information is also necessary for communication
between two external nodes (e.g., Node A to Node B) that does not
involve the host CPU, as the switching occurs entirely within ETHSW.
This is particularly important for DLR (Device Level Ring: a
redundancy protocol used in EtherNet/IP). DLR relies on detecting
link-down events caused by cable issues as quickly as possible to
enable fast switchover to a redundant path. Handling such path
switching in software introduces performance impacts, which is why
ETHSW includes dedicated pins.
As for Active Level configuration, it is designed to provide
flexibility to accommodate the specifications of external EtherPHY
devices.

Please share your thoughts.

Cheers,
Prabhakar

