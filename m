Return-Path: <netdev+bounces-130077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3D988113
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE111C23F76
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1018A921;
	Fri, 27 Sep 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="D+HSuacO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264E018A6D0
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428033; cv=none; b=D3Pt25UQJ3Tff69nH6E058l9L5sTW/x5rpYOROGIxgmGm8Iy8LT++6cQZ51jZrBIMHG8TkKGckkdNQu3lKcFGaKmhHJQ8qSpX5z5rmmw58KswoHER8Lk2qVszg2eXnRmrEczoYWFiif2Aw8mompMhmk2EriRzlGsMEbashi8MZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428033; c=relaxed/simple;
	bh=p/tL/mEtgxya4nQTMT45w11AbEgp01edlss3aQNmTWA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDsdpPe5GJqoVD5vAJhgtma80RSotxksv/H1E7ENda8J+D0qfhwRdDOqyDTIRbC3Whz2AlkLw6PT2VHiw21HRFSi3UkIK4R0RmdEAncwT+bPN+5I7dmQe+isfaTaoHDjHy4lxyhdCDLfZQ8gqTwT2tAnVyNAxax1aT0ek3LBgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=D+HSuacO; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02F963FFF4
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 09:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727428013;
	bh=TdWwWyYx3NSL/g/B28NaT9+skLBhcn0OqBIgUz2KJ8c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=D+HSuacOpUViEhGFqOTUZ5T5K2mBJPogFbSk6Bs3kpfOR8R2XmhQIv6TD1z3R5uzC
	 h86fM1A86+bEn4doc5+jkjYAZCt/tNf6A+Df13Qxq4Mx8Id7lO9a9N8Idrr8udgRrD
	 40auLPER3CBA1Nd3wKvRFO2FTkZZGxKyJs3tGoMR0A5wcKyjkmUEmGEKeLQ1n01kqS
	 iCXCvxiX85O95ZmXvwC4zTo9Qv5lHZQCVccjyMvMOn7xyzd4sMybegZtbWxi1bTpDB
	 5Fl2VksZiYD3d09Dv9dCbD/MRUJJpIfPLu7m6gtqUOKokSzW6TUVzuCQ1KIrWHVkvF
	 CpUJLJaFOqyBw==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2870e3bce36so1033884fac.3
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 02:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727427998; x=1728032798;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdWwWyYx3NSL/g/B28NaT9+skLBhcn0OqBIgUz2KJ8c=;
        b=AuYfKa2BxoPK9KUpiVCNYIxTYP01xiOyTF0gjXBwY/OAanrYSN0WAbNH499Fr8Ksl2
         x+eEuG8Y/0WxFd1jn5dplFMkk3dW0b+EyUCF3R2QU4MGHnUVROuI1MgYeN5qrfaU/lXh
         0Zg/YxDng3uUZfNffeUA+7319g5bRPNmcfvXS1DlmRw+vuFQg3mf7EoQ+Hypf1Iy662z
         LP1QxD7XSgCfuF6a5mGO6O9GSBHaAJCg4b10/Pcc8jaIOUaEvddjrbqwoFJ3M+LADJ8s
         P+rdLsvsVUN1SGd7kjjNZ+Id8YUyHeiE47cNv1Rqa8CdhSvjSvbPZK7iHTdvM/WAEJNH
         Pvyg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2RaA6Pc5fnlvuENi6UYO5w0RzVbIZhsD3mY4Xhns2S9+SRMEHRjqbzNdiR0sx27IXjwrftU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CpQGNR8ahOCaj7cJX0isvroPpcgDoTYypuXYdO3m7n7pDL2K
	xJlS5LA4B4vSqxAqTZ07YixXo11Ks0FCUHEjVDNiflfnibKZ3ktXICKBUCwRAcXRUpsgno8yMid
	UHgZ2nZawyLw/+ZJSJC7MsK7R3PvsBNrAppgGx31NGcDFWmigSLOhLM4eb6gBRIV/PkS5GU2iHT
	GXV4NFP0I8rHSxBsB7KBetYpt512mQxsH5/ipyVbVlM0fs
X-Received: by 2002:a05:6871:1c7:b0:277:fd73:8f82 with SMTP id 586e51a60fabf-28710c28d08mr1801225fac.45.1727427998417;
        Fri, 27 Sep 2024 02:06:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv+HoVG+UamQzP9HYGm4dvtX0uDQArn9ex/l2o6/iZbKaH7H7PMWWqDndToxE25AX6dEyIqQ8K4thbHVn/x+E=
X-Received: by 2002:a05:6871:1c7:b0:277:fd73:8f82 with SMTP id
 586e51a60fabf-28710c28d08mr1801204fac.45.1727427998028; Fri, 27 Sep 2024
 02:06:38 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Sep 2024 02:06:37 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZvYJfrPx75FA1IFC@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com> <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1> <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch> <ZvYJfrPx75FA1IFC@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 27 Sep 2024 02:06:37 -0700
Message-ID: <CAJM55Z8DeGJs=ASgdErEVWagy_f8JMWVe_TEWJWAcrUbzoDjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
To: Drew Fustini <dfustini@tenstorrent.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> On Thu, Sep 26, 2024 at 09:30:32PM +0200, Andrew Lunn wrote:
> > On Thu, Sep 26, 2024 at 12:13:06PM -0700, Drew Fustini wrote:
> > > On Thu, Sep 26, 2024 at 08:39:29PM +0200, Andrew Lunn wrote:
> > > > > +&mdio0 {
> > > > > +	phy0: ethernet-phy@1 {
> > > > > +		reg = <1>;
> > > > > +	};
> > > > > +
> > > > > +	phy1: ethernet-phy@2 {
> > > > > +		reg = <2>;
> > > > > +	};
> > > > > +};
> > > >
> > > > Two PHYs on one bus...
> > >
> > > Thanks for pointing this out. I will move phy1 to mdio1.
> >
> > ???
> >
> > Are you saying the two PHYs are not on the same bus?
>
> Sorry, this is my first time working on an Ethernet driver and I
> misunderstood.
>
> Sipeed only shares the schematic of the baseboard for the LPi4a [1].
> There are pages for GMAC Ethernet0 and GMAC Ethernet1. Each shows 4 MDIO
> differential pairs going into a SG4301G transformer.
>
> I believe that RTL8211F-CG phy chips are on the LM4A SoM board which
> contains the TH1520 SoC. Unfortunately, Sipeed does not provide a
> schematic of the SoM so its hard for me to inspect how the phy chips are
> wired up.
>
> Vendor kernel [2] that Sipeed uses has:
>
> 	mdio0 {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		compatible = "snps,dwmac-mdio";
>
> 		phy_88E1111_0: ethernet-phy@0 {
> 			reg = <0x1>;
> 		};
>
> 		phy_88E1111_1: ethernet-phy@1 {
> 			reg = <0x2>;
> 		};
> 	};
>
> so I think that does mean they are on the same MDIO bus.

It depends how you look at it. The SoC has two MACs and they can both
control their own MDIO bus. However MDIO of both MACs are pinmux'ed to
the same pins on the SoC. So the solution above just mux the pins to
GMAC0 and let that control both PHYs. Alternatively I guess one could
let each GMAC control their own phy on their own MDIO bus and then
switch pinmux settings everytime you need to need to talk to one or
the other.

/Emil

