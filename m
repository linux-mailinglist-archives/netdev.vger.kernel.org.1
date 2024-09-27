Return-Path: <netdev+bounces-130102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC4988381
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19571B21095
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9318A6D2;
	Fri, 27 Sep 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kUz/gtJV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF99143C4C;
	Fri, 27 Sep 2024 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438011; cv=none; b=M9TqPHN6xFeDK8iC6g8gEIacMhXrxpJHWzkHX+/mhLX6p0jsDR3GsqaBjmvQxJSplYkuOPPwoOjZIjI1LhkYdGt5On3hNn3Qdk/ik04o+gpXn19N137hfFDd2ZB1HY6ilnXSwgIlBimDLANt+t92RUujEQcDxThAGC8F/vejBTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438011; c=relaxed/simple;
	bh=WRWW+E1krYmBDrhvwZpLFBTBzNUCdxnEkJ6PMdwjdhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgZMN8HluBBeIeQMhNx16a/n+RTtGVt0DhAmfVYythxYWixN3B+Y4+Sxf1k0Bwplih5vK5r+BQLHZEYvDByy1krPnMAwVIBjytzy41+axBP5Dy+UXQ40CH+56gtgTrXDU1PFexQebBRo5N+IhQO4G+JWyTxpSa856f0sHd5ZP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kUz/gtJV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LgsT4SJMaVNaLNol8+Oz0Hs0nQdKgvAFUDMvdqVb/p4=; b=kUz/gtJV5Vb3boPbS5Hd8g4qUb
	nTO809F1WCk2dNhTjwdVN/6Av34/Kh2NVM0U2HL7fV1lBS5V/PVX0UN7VxCc/TnFbjkE/ZYlXWFfc
	9cYEeD9OQdiZGwLk0B8Lo+JBnVv1X3lYEgqQvMbZFOyVOYgN12/T31JYxHbIr0rcFWM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1su9X3-008SNh-CZ; Fri, 27 Sep 2024 13:53:09 +0200
Date: Fri, 27 Sep 2024 13:53:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Drew Fustini <dfustini@tenstorrent.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Message-ID: <5eead228-7e46-4905-8faa-6a5bc1da70c4@lunn.ch>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1>
 <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch>
 <ZvYJfrPx75FA1IFC@x1>
 <CAJM55Z8DeGJs=ASgdErEVWagy_f8JMWVe_TEWJWAcrUbzoDjOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z8DeGJs=ASgdErEVWagy_f8JMWVe_TEWJWAcrUbzoDjOQ@mail.gmail.com>

> > Vendor kernel [2] that Sipeed uses has:
> >
> > 	mdio0 {
> > 		#address-cells = <1>;
> > 		#size-cells = <0>;
> > 		compatible = "snps,dwmac-mdio";
> >
> > 		phy_88E1111_0: ethernet-phy@0 {
> > 			reg = <0x1>;
> > 		};
> >
> > 		phy_88E1111_1: ethernet-phy@1 {
> > 			reg = <0x2>;
> > 		};
> > 	};
> >
> > so I think that does mean they are on the same MDIO bus.
> 
> It depends how you look at it. The SoC has two MACs and they can both
> control their own MDIO bus. However MDIO of both MACs are pinmux'ed to
> the same pins on the SoC.

Ah. That is unusual. 

> So the solution above just mux the pins to GMAC0 and let that
> control both PHYs.

That makes sense. Using both MDIO bus controllers and playing with the
pinmux on each transaction would be a lot more complex.

	Andrew

