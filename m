Return-Path: <netdev+bounces-173536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BFA59532
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3348C188DF31
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A765226D1B;
	Mon, 10 Mar 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sINWN16n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4062235963;
	Mon, 10 Mar 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611238; cv=none; b=NXLF2lhXeVeQJ51ZBK3SWBgcJD92wv8LNgVpFrb2/R51TOE8A9ELdvTei6K5XvgjOVzGR39nKEeur99bWCpixPYSxsa7sFUeElgSiN6LMTv+K6WNmFXnMbkOYlLCjoNVOTJ3beglQ2HqM3fEEG9KEbYe1Ndfkw3SAtueEJdwe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611238; c=relaxed/simple;
	bh=J1e0tuX0R2dKRPJ+pB6GcyRcQHThRSNrXsdiWBni5Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH2Wq7U+9BZZv3yuYfls/YVTQy1eQzCnXyF+Id01Joa7okfdjtdEJZBiYlbf0DBVgyrFMrM0jinILsvbmZ/+8Ol+9wYLFBT0j2r2FMc9gQwLZ08xXLRY6LPW4qYUoVTKW7rDfrwdh+aQvsUNYzaC9SyuVbP+2UicNKBWui+3jAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sINWN16n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7079CC4CEE5;
	Mon, 10 Mar 2025 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741611237;
	bh=J1e0tuX0R2dKRPJ+pB6GcyRcQHThRSNrXsdiWBni5Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sINWN16ngmfU2lykcPSvEltv8suz+4O4FzbpqqAf8sN1TkxAateKk8xaWROXzZlg/
	 4lKExBHdAJhTMm/zIyb7EjXGys2rB3rHGsL9TxpkaSK9WzmatdOIuYHViAbazwRVRx
	 IS2iaG3Ocpg2eRRLOJdc+t5PDggdRzoe+fOKYDFI2WjPO1G3fEl3/mZAQZe+Pdnhsd
	 yzfgHJadIf7kxez3j5tOJkx/cPK3eQ2lcqMaIl4R2CIPdG5y32mnhK+XpT5rLaF+BC
	 KkJV7Vt9a4FqNJME2iX0fxvjPhZFHGtPSgfKx91tzXj0w69Q4R8z7/Dw3TJXqDx9JE
	 68olY1HAX1M+g==
Date: Mon, 10 Mar 2025 07:53:55 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jakub Kicinski <kuba@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Jose Abreu <joabreu@synopsys.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-riscv@lists.infradead.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Conor Dooley <conor@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] dt-bindings: deprecate
 "snps,en-tx-lpi-clockgating" property
Message-ID: <174161123533.3885448.13844393493565707617.robh@kernel.org>
References: <Z82tWYZulV12Pjir@shell.armlinux.org.uk>
 <E1trIAQ-005nto-3w@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1trIAQ-005nto-3w@rmk-PC.armlinux.org.uk>


On Sun, 09 Mar 2025 15:02:14 +0000, Russell King (Oracle) wrote:
> Whether the MII transmit clock can be stopped is primarily a property
> of the PHY (there is a capability bit that should be checked first.)
> Whether the MAC is capable of stopping the transmit clock is a separate
> issue, but this is already handled by the core DesignWare MAC code.
> 
> Therefore, snps,en-tx-lpi-clockgating is technically incorrect, so this
> commit deprecates the property in the binding.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


