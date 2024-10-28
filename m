Return-Path: <netdev+bounces-139555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815CD9B3042
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04F91C21876
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7072D1D9586;
	Mon, 28 Oct 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CY+JEtDP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A31D9320;
	Mon, 28 Oct 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118537; cv=none; b=kW/fhgEPn5a01ARMCNMs4+mhRJnj22BDI2Zd1A2GBIZlyPx+zKWWWNN2/gRQtT1rMj3hA0wlbSqHOGhjELbY2WdWMk+3mtATmPOExOaYsQzuxfOFz3QEAcXn7Wp0UZ5bAa/4T4D6VVZPMWoZEh+t6LhpkF5PNMsvGRfZGntSnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118537; c=relaxed/simple;
	bh=wt73btPmeDGo2H2UrDyLd61eZc1kRtDNzSOLxXMmrYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsfu61tqm09VDFe4sVzybcbsZmP/R/O8gsLTK2EMh+9u40oX4Z6LiY9O2zxCS3QR1mHN+D49coo42/+pqQ6D2VrCC7RoIphImYaH6lNOK8b5gfOZkEFoOO3yGeJqrdJdUz9IJk0zYg/cfQihsPj/P2AI0CX/U3+BJ8J5Gbnf6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CY+JEtDP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dUdrVGx+Nn/r2w710Uhyv3zhFpLcxZLGQqQHzcftc10=; b=CY+JEtDP6/n6Bgu5W0n8hNIPDr
	yK1oqEf5NyFJBLMlSXT6Yc9dNAV0rqWsE9hE2eFKuFSFye4Y1GgRJT4LlEKbfMjtsIw4zwQIgMf06
	qEUzDoHbo76B97PLu9PBp9YB296dZqVpkHbWSVotMal/Y0vl+iALa0TMMVHfXgrQgpWM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5OrT-00BRYK-Pb; Mon, 28 Oct 2024 13:28:43 +0100
Date: Mon, 28 Oct 2024 13:28:43 +0100
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: Add glue layer for T-HEAD
 TH1520 SoC
Message-ID: <81cafa27-1c66-4f4f-97b4-0ec16d32a19f@lunn.ch>
References: <20241025-th1520-gmac-v5-0-38d0a48406ff@tenstorrent.com>
 <20241025-th1520-gmac-v5-2-38d0a48406ff@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-th1520-gmac-v5-2-38d0a48406ff@tenstorrent.com>

On Fri, Oct 25, 2024 at 10:39:09AM -0700, Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add dwmac glue driver to support the DesignWare-based GMAC controllers
> on the T-HEAD TH1520 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> [esmil: rename plat->interface -> plat->mac_interface,
>         use devm_stmmac_probe_config_dt()]
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe(),
>        convert register access from regmap to regular mmio]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

