Return-Path: <netdev+bounces-130108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D97798839F
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CADE1C2283D
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A983418A93F;
	Fri, 27 Sep 2024 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LuYkyrSc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD0143C4C;
	Fri, 27 Sep 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438352; cv=none; b=Xd0Xox36iM3uXln823USgMxRKHsP2dJ/goJfhpr/HypS7HkvrTl37WL1sFW55bBd3aR0+1u8PMMnL/wG7iYIjH/YlVQpcgvcQal9KJOxOtAR1abgkDI7h07xxSIsSjbNNs2HyNiB+KOnfuTf8lLHopAXRjuM3OCvTRor+hVgJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438352; c=relaxed/simple;
	bh=OHgltXjCCbzVialuRwKHad3k4S6bdpxLuP2Vdgj2Jiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCef0CDulARBc+wA9OCv+RmSYUwBT6t1KnKSLb2yYXx8E7lbkfIiLanfJY0Ut60zK6/LbivUdE6JuXhNBiV0rfEwGqizZeaX5hPc1ybLJrKqE+MfWPOv4tuUQEaw3Iu8WtJil9f5cPFP47tPq7zwuK+3XWMDpylkxZx5gY8LniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LuYkyrSc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9SUDZW4Es71/qXQBSzrGEM3NsuyUoGW8P/PUFbYZIA4=; b=LuYkyrScUAmp094kXm5CrB4SqI
	bD0g3c/LHBoFXF9vxq0zltKH8MYcEb5MIUKZy4cz3s+GrBCPY4AX7IDpWjrN+FiSBoqEMJf0A6ech
	u+VgkaueeK7a6s98+SNVXzfeOgl4jem99PE7O3VCni51eghIxcykdlATXLosRG9w+JNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1su9cO-008SQd-4u; Fri, 27 Sep 2024 13:58:40 +0200
Date: Fri, 27 Sep 2024 13:58:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <dfustini@tenstorrent.com>
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
Message-ID: <5076789c-3a35-4349-9733-f5d47528c184@lunn.ch>
References: <20240926-th1520-dwmac-v2-0-f34f28ad1dc9@tenstorrent.com>
 <20240926-th1520-dwmac-v2-3-f34f28ad1dc9@tenstorrent.com>
 <3e26f580-bc5d-448e-b5bd-9b607c33702b@lunn.ch>
 <ZvWyQo+2mwsC1HS6@x1>
 <0b49b681-2289-412a-8969-d134ffcfb7fc@lunn.ch>
 <ZvYJfrPx75FA1IFC@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvYJfrPx75FA1IFC@x1>

> I tried to setup an nfs server with a rootfs on my local network. I can
> mount it okay from my laptop so I think it is working okay. However, it
> does not seem to work on the lpi4a [3]. It appears the rgmii-id
> validation fails and the dwmac driver can not open the phy:
> 
>  thead-dwmac ffe7060000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
>  thead-dwmac ffe7060000.ethernet eth0: validation of rgmii-id with support \
>              00,00000000,00000000,00006280 and advertisementa \
> 	     00,00000000,00000000,00006280 failed: -EINVAL
>  thead-dwmac ffe7060000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -22)

Given what Emil said, i would suggest flipping the MDIO busses
around. Put the PHYs on gmac1's MDIO bus, and set the pinmux so that
its MDIO bus controller is connected to the outside world. Then, when
gmac1 probes first, its MDIO bus will be probed at the same time, and
its PHY found.

	Andrew

