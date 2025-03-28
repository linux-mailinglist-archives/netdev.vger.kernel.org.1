Return-Path: <netdev+bounces-178154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ECAA75056
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 19:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DB37A5B86
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14A1E0B67;
	Fri, 28 Mar 2025 18:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OzPQhm5A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AEE1E04BB;
	Fri, 28 Mar 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186260; cv=none; b=RUGJyrmYfDxWk4tUn/+U3Dk7Tj/onMd28QrClRyAhGxMpw6PRdbIKT+BSUe78IQxf2RO8ybtOFTN7KIzrg0UX3KwHEadpFVGPTE9mu8cj84IhNVUwSFWB1ryJF1fkHSyz9ZFBq/MdHszwAs29dodEflVRvEeOMPRszAPyp8pp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186260; c=relaxed/simple;
	bh=zf1FJXJGVnr82CxLBuFy0AMCVZ7CInDt03AqYDok4es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnR2rp8xNhG7B37DJoKlEK//NrP4HgwuqA+FTpfBK7Z2Ol6z6FQDzMmoDrhfinGatYNvznLucFA65s6iO4rQUA/DYKWz5fXpmdvCjPJT+okLVMbw5XVO1muQOczqi2gTezrmWdJLy4EY5qQ4UASTLdSyPJC+scPGHdmNedRlvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OzPQhm5A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RNrC5rlHKCOH5xusMQXkhUiFivWWVVsm7aCuKKAQMf0=; b=OzPQhm5AKHHFbL1GlosMauqtz2
	3z0uXkAILxQYLzqyEiqX8zwyAUS/V5b5rE/mcuMowZWgSZv0na/yOy9FR8PwDajs+MZGBqxJcPN9V
	xvNWYI1Ph7Kwx22NJPwyt2kryIe10BJuo3gc+NFeT/sDA0Ip2LDMsVKwSAQfg72D+8EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tyEN0-007Ntl-B8; Fri, 28 Mar 2025 19:23:54 +0100
Date: Fri, 28 Mar 2025 19:23:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <45c6cb9d-b329-4b4c-a480-08110a546fb6@lunn.ch>
References: <20250328133544.4149716-1-lukma@denx.de>
 <20250328133544.4149716-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328133544.4149716-2-lukma@denx.de>

> +                ethphy0: ethernet-phy@0 {
> +                        reg = <0>;
> +                        smsc,disable-energy-detect;
> +                        /* Both PHYs (i.e. 0,1) have the same, single GPIO, */
> +                        /* line to handle both, their interrupts (AND'ed) */
> +                        interrupt-parent = <&gpio4>;
> +                        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;

Shared interrupts cannot be edge. They are level, so that either can
hold the interrupt active until it is cleared.

Also, PHY interrupts in general are level, because there are multiple
interrupt sources within the PHY, and you need to clear them all
before the interrupt is released.

	Andrew

