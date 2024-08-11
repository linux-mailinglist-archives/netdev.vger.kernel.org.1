Return-Path: <netdev+bounces-117495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A694E1F8
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4A6B20E47
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6165914B94F;
	Sun, 11 Aug 2024 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="spzugtmD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82D87F6;
	Sun, 11 Aug 2024 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391270; cv=none; b=UzvjQf8CdvIY2yvamzkxEjkr3J3nEhGK4zR06doqi5/H4CONgU3IkuBfzwUODMEAtUoxxMwd7M48nBDsFAFpf8kvYtojRo6hbS/JPTKiqhmbjkNiLDZgL+NNBhKvuQ8fMJmk4bpPPTcGEL6cfP/DdQ8/g63YZnmBANzvQ95vNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391270; c=relaxed/simple;
	bh=E/SDr4frrJwX24vSZjNxmKMh1Cii2TDKWhbKHvms68s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEuxK00q0aIdauMoRukLJ1nD6NvuZpPIc+k7hS3bX7D7KxbH/z+NeEaJmOFqJ7rcz020zbaLuW4cJ4Ig0IpsabahEXhXeBTOahq+FATEc3JLGKOrxuY7fXngc1ZrDa8+WG/jjVqNviqZQQWhHew+mXP9yPoAAofqd3WGgEGWGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=spzugtmD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TKfoon2hS2GwR6hVHGmvsM1mZM+oTJZ7o3SmTQ+ohQQ=; b=spzugtmD1PU2CFBl2fe7gN+sR5
	GdQREf/4arMeSCdXtF1nwHd3fq0qgqj5cZ98hEgIp1yIHpAhk7EohGCmEyjk4mtVBPk0aeo3iEXS5
	bW5wVBdJS1gjSkC3DGUdqO3Ym6oE9wyziTh/q8MlNrKAZQqsr6+srjexNYlYXe6zIzp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAnB-004VSC-IS; Sun, 11 Aug 2024 17:47:37 +0200
Date: Sun, 11 Aug 2024 17:47:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, masahiroy@kernel.org,
	alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 06/14] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <c1d3e601-80e3-4dd5-9eac-a8305af5b3b3@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-7-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-7-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:38:58AM +0530, Parthiban Veerasooran wrote:
> Internal PHY is initialized as per the PHY register capability supported
> by the MAC-PHY. Direct PHY Register Access Capability indicates if PHY
> registers are directly accessible within the SPI register memory space.
> Indirect PHY Register Access Capability indicates if PHY registers are
> indirectly accessible through the MDIO/MDC registers MDIOACCn defined in
> OPEN Alliance specification. Currently the direct register access is only
> supported.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

