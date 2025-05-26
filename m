Return-Path: <netdev+bounces-193500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE1BAC4412
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 21:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043E03A6AB3
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDB20E70E;
	Mon, 26 May 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dZEGbMI2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026472607;
	Mon, 26 May 2025 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288202; cv=none; b=PHjpGFTWHDbRNX0wZaUCTWkXS1+AsWDyL369Yk7gMygwv+sUq9wYxDhhhfrzxeN1ZIMEcK4a9j6vixqTdiFsbgmohq2+p/8tPlE9GteYsPffJVmx11lQoqIM0WUAR/HwmT86neAqoUO/t5mWT1XIuHXWdj15Rz1Qt6RQG5sfOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288202; c=relaxed/simple;
	bh=tUMYkhsjR+DV6weZBNIQDSbSGynVgSFULoxvGLVkw6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7PuFBvMSWKTBnGd5irzDpY+80NTPXgHSx8wCDLH4bFVQWVecIJv1Zgh6dwUou18p6RzZVTlyaBhEZOp7mt6AHDCeai+hYXSa9QCpQIW1CgZudMu1F4MTNijWTDDhg3t7UEF7EIcEroCTXeMgJrg+ZcYrsUNsHApR7WIukJGVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dZEGbMI2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4k9z3rNoaxvsZh30uSr90husp7CDgyQMsf5rUgjtaNU=; b=dZEGbMI244Z6VqhpAY3fWaIfh5
	kV3jP75Ntv0uqIiDd10Gxfi5sxVDrEkSmsnMHGlo1knf8cIcEw2D74nfUmCPiE4OWoF+FzutuQow6
	nQAxASczMZgn86iFIrH3w7Cpo0V3y85B4n1r+hg+EnFvebt0EPu2Qgs739YdtlFM9KdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJdcY-00E1Qy-2i; Mon, 26 May 2025 21:36:26 +0200
Date: Mon, 26 May 2025 21:36:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
Message-ID: <959e576e-bf36-4d01-9ffb-023931b61574@lunn.ch>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526182939.2593553-3-james.hilliard1@gmail.com>

> +        phy-mode = "rgmii";

Does the PCB have extra long clock lines?

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

	Andrew

