Return-Path: <netdev+bounces-130041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E2987C6A
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68102284A18
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 01:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC604D8DA;
	Fri, 27 Sep 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Zo8T/hYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179928467
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400324; cv=none; b=ZnbAfxPLLOrO2YYFU31jKlOLiqjKPCwNAlH5ey9jVDjc6KNUi1EtHg6Y1wKiqytq4OnBzhVptxY2kdbeRY0nU1XQ75gPTJj4YovdL8+kQwSH+B4+BeWcw5tsBhR3JD3iA3lL4taExp1wRyWAq5esyl+CH9pL5MNCx4Lgm8ISqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400324; c=relaxed/simple;
	bh=oQ+4b7BRgXRVADP2MBjlvEd8Yh3A6ngbN9lYzOPKaSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPO9IE2dh+b+G6aIclreSKZbkLQe6tgc7oM/LBcH78r6DaeSAl4HqBCAyzdi4p/JEdswSOpM5W90ft57IFhgNY0i6lu1Vzxi2fuALJYanNM77hLPtTXwGG9qBx/D4Jl3urwERHzuj8OwpY9eVtK5ZEZq5pIHmTFLtPHMNhdOTnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Zo8T/hYS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-207397d1000so20625665ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1727400321; x=1728005121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCmcLe0SmYgeEcqqhkJU0Qezbgs/J4u3/7L98eJgBA8=;
        b=Zo8T/hYSCiQUH5F6C5bCQ/mQjEXKks9fYL/F1KPWAM8iE5ZBGHDMvIuuSFWnmJd/pe
         Du4+scH5OH2qbPQO8RZAy1dXsVpLWuonfZXJtUw4B4JgTvuNabPL/EsLHdyQTEIDYDC5
         zMUIeN6ygnM5Frlpnq2lP28P9Po9/hINfftBfdQGwweAuqsomPLDRweG4J4t2HviFdnp
         FRQOFvwA+/my+qetT6u6ivVR4OGCLFeZgYfasW2wY6LUDM4hszqJ4D4BuKk3wiR08Ryz
         QonmyMwUM8HYSJX1SqlM/NuuwWtQSlNrn1/dScbbEbejyIe47abx1yLslPBCldRxLV7l
         iHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727400321; x=1728005121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCmcLe0SmYgeEcqqhkJU0Qezbgs/J4u3/7L98eJgBA8=;
        b=bt1SbDF8eQd+U1noao+rvO/TRL80+CUORIPzp7Z1W2/2i23NWHNk74j9dhZDsqbUuH
         N4t5WkswQWTUNuxN2mULtcEV78q15VCRMrSrVfGMlria7IAXhGg5X9IDPpC6aZO+EQHM
         qDryKm9RnFla9+dVVaFKiHms3WElz29C0KVtlEgc0lbsdKhE22gpOsUqTx9hohgRFCre
         SXYELcgUsjP+7vewlsGnLEpHgyxDb7/2jRdhce2NXD1kf+N3VDAEdmw+A/QQUp5Cai9p
         k3wXKLVjJ94PfHaAOyEZ+mwuh9Gmffq1X+xReGCknhhqmyOqGjtwwSCGjLCbyWNxRxgM
         FXJA==
X-Forwarded-Encrypted: i=1; AJvYcCVv+xv7caHnP8t8ng7kOn6JujuwaUVPk7k/ZJe52t8UmNZxGNn1xVMWwnYdeqd+4wurt6zBf5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqAnyjsT2VwXq0ppL93P8/0xBDvj6ufTffWHPpZSrOI7pI+pBD
	6AbB1OvDjNYnpowU6Ae41DqJDH8LbhOEDbxtpe+6pZID7CiULbxgFFxGM6V056s=
X-Google-Smtp-Source: AGHT+IFNIOZRxH8HvJGMbMu1i8sPGpIXAzt+jVyHPQIeV5WglmLr8F5WYqM/TslsbY+ZUY/LOi5w8A==
X-Received: by 2002:a17:903:2a84:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-20b19cadb22mr63571405ad.22.1727400321286;
        Thu, 26 Sep 2024 18:25:21 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357e8sm4132645ad.187.2024.09.26.18.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 18:25:20 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:25:18 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/3] riscv: dts: thead: Add TH1520 ethernet nodes
Message-ID: <ZvYJfrPx75FA1IFC@x1>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1>
 <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch>

On Thu, Sep 26, 2024 at 09:30:32PM +0200, Andrew Lunn wrote:
> On Thu, Sep 26, 2024 at 12:13:06PM -0700, Drew Fustini wrote:
> > On Thu, Sep 26, 2024 at 08:39:29PM +0200, Andrew Lunn wrote:
> > > > +&mdio0 {
> > > > +	phy0: ethernet-phy@1 {
> > > > +		reg = <1>;
> > > > +	};
> > > > +
> > > > +	phy1: ethernet-phy@2 {
> > > > +		reg = <2>;
> > > > +	};
> > > > +};
> > > 
> > > Two PHYs on one bus...
> > 
> > Thanks for pointing this out. I will move phy1 to mdio1.
> 
> ???
> 
> Are you saying the two PHYs are not on the same bus?

Sorry, this is my first time working on an Ethernet driver and I
misunderstood.

Sipeed only shares the schematic of the baseboard for the LPi4a [1].
There are pages for GMAC Ethernet0 and GMAC Ethernet1. Each shows 4 MDIO
differential pairs going into a SG4301G transformer.

I believe that RTL8211F-CG phy chips are on the LM4A SoM board which
contains the TH1520 SoC. Unfortunately, Sipeed does not provide a
schematic of the SoM so its hard for me to inspect how the phy chips are
wired up.

Vendor kernel [2] that Sipeed uses has:

	mdio0 {
		#address-cells = <1>;
		#size-cells = <0>;
		compatible = "snps,dwmac-mdio";

		phy_88E1111_0: ethernet-phy@0 {
			reg = <0x1>;
		};

		phy_88E1111_1: ethernet-phy@1 {
			reg = <0x2>;
		};
	};

so I think that does mean they are on the same MDIO bus.

> 
> > > > +		gmac1: ethernet@ffe7060000 {
> > > > +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> > > > +			reg = <0xff 0xe7060000 0x0 0x2000>, <0xff 0xec004000 0x0 0x1000>;
> > > > +			reg-names = "dwmac", "apb";
> > > > +			interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			interrupt-names = "macirq";
> > > > +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC_AXI>;
> > > > +			clock-names = "stmmaceth", "pclk";
> > > > +			snps,pbl = <32>;
> > > > +			snps,fixed-burst;
> > > > +			snps,multicast-filter-bins = <64>;
> > > > +			snps,perfect-filter-entries = <32>;
> > > > +			snps,axi-config = <&stmmac_axi_config>;
> > > > +			status = "disabled";
> > > > +
> > > > +			mdio1: mdio {
> > > > +				compatible = "snps,dwmac-mdio";
> > > > +				#address-cells = <1>;
> > > > +				#size-cells = <0>;
> > > > +			};
> > > > +		};
> > > > +
> > > > +		gmac0: ethernet@ffe7070000 {
> > > > +			compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
> > > > +			reg = <0xff 0xe7070000 0x0 0x2000>, <0xff 0xec003000 0x0 0x1000>;
> > > > +			reg-names = "dwmac", "apb";
> > > > +			interrupts = <66 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			interrupt-names = "macirq";
> > > > +			clocks = <&clk CLK_GMAC_AXI>, <&clk CLK_GMAC_AXI>;
> > > 
> > > And the MACs are listed in opposite order. Does gmac1 probe first,
> > > find the PHY does not exist, and return -EPROBE_DEFER. Then gmac0
> > > probes successfully, and then sometime later gmac1 then reprobes?
> > > 
> > > I know it is normal to list nodes in address order, but you might be
> > > able to avoid the EPROBE_DEFER if you reverse the order.
> > 
> > The probe order seems to always be the ethernet@ffe7060000 (gmac1) first
> > and then ethernet@ffe7070000 (gmac0). I do not see any probe deferral
> > in the boot log [1].
> 
> > [1] https://gist.github.com/pdp7/02a44b024bdb6be5fe61ac21303ab29a
> 
> So two PHYs are found, so they must be on the same bus.
> 
> It could well be that this MAC driver does not connect to the PHY
> until the interface is opened. That is a good 30 seconds after the
> driver probes in this log message. So there has been plenty of time
> for the PHYs to be found.
> 
> What would be interesting is if you used NFS root. Then the interface
> would be opened much faster, and you might see an EPROBE_DEFER. But
> i'm just speculating. If it works for you, there is no need to do
> more.
> 
>       Andrew

I tried to setup an nfs server with a rootfs on my local network. I can
mount it okay from my laptop so I think it is working okay. However, it
does not seem to work on the lpi4a [3]. It appears the rgmii-id
validation fails and the dwmac driver can not open the phy:

 thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
 thead-dwmac ffe7060000.ethernet eth0: validation of rgmii-id with support \
             00,00000000,00000000,00006280 and advertisementa \
	     00,00000000,00000000,00006280 failed: -EINVAL
 thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -22)

I suppose that this is what you were talking about that NFS will cause
the interface to be opened much faster.

Thanks,
Drew

[1] https://dl.sipeed.com/shareURL/LICHEE/licheepi4a/02_Schematic
[2] https://github.com/revyos/thead-kernel/blob/lpi4a/arch/riscv/boot/dts/thead/th1520-b-product.dts#L758
[3] https://gist.github.com/pdp7/458eb93509548383beabeb21c8ffc43a

