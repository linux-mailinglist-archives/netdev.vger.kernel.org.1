Return-Path: <netdev+bounces-244652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25919CBC142
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 23:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E09E530088A5
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C533161BD;
	Sun, 14 Dec 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lFE+vr2N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0602DE70D;
	Sun, 14 Dec 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751624; cv=none; b=I/+xgXJL32jJh+nep7/LeJtB4BmdubWpwWOx0j6kXChXjqj72SnCGXsgE6uZK/KHBX2wwbVO/42NGugFHNf6LiwB3u77OVq90nIFuFM6vh9x9sLYrG0/0pLp6BKuA/Tjwunq+4XMe+tldNe6tbddlmAMEAD1ZUh/3csgFRdcy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751624; c=relaxed/simple;
	bh=CZ/i5p6/q5bcXCMjyB3Ux4OUMu+SfAfCpZ/POSne6a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg6e7jl2CFYfN4wGsS+E5K89DuMZtnfOcrt1VCmAQkOE4HrSjHfEg0zFG12fvqEwFnUd4GBwEeqlh5ewrSLXmhsV5otAeheyvyyeacj5pFWOxEpFlURKgy4fHjKyk7p6xXIdgK1BzD+vAMDVCdkX/tkLPxnRXyu6BVTfi3v0HQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lFE+vr2N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/xB0oJAXp3qEO4ENcSX3Z1/nEQf1M14DCflSGjej4+8=; b=lF
	E+vr2NgmGXKsHZWD2ULhRLIMai7tY+0nGBkao0Z9cHgY5nS8J3NI2buROpSRKb+3xT02Fpv/wcPR/
	0+0SD1OVNmyD9rdt7OUGL5xOyVrp2XfdvTeb249r/jXD6++7KS4A34cB19BWvkHX0B3CX9hxvEIcq
	GPS97jZR+UJsMp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUuef-00GwbG-M1; Sun, 14 Dec 2025 23:33:29 +0100
Date: Sun, 14 Dec 2025 23:33:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Support multi-channel IRQs in stmmac platform
 drivers
Message-ID: <39430c2b-9430-46c3-8087-5381782a5b01@lunn.ch>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>

On Sun, Dec 14, 2025 at 11:15:36PM +0100, Jan Petrous via B4 Relay wrote:
> The stmmac core supports two interrupt modes, controlled by the
> flag STMMAC_FLAG_MULTI_MSI_EN.
> - When the flag is set, the driver uses multi-channel IRQ mode (multi-IRQ).
> - Otherwise, a single IRQ line is requested:
> 
> static int stmmac_request_irq(struct net_device *dev)
> {
>         /* Request the IRQ lines */
>         if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
>                 ret = stmmac_request_irq_multi_msi(dev);
>         else
>                 ret = stmmac_request_irq_single(dev);
> }
> 
> At present, only PCI drivers (Intel and Loongson) make use of the multi-IRQ
> mode. This concept can be extended to DT-based embedded glue drivers
> (dwmac-xxx.c).
> 
> This series adds support for reading per-channel IRQs from the DT node and
> reuses the existing STMMAC_FLAG_MULTI_MSI_EN flag to enable multi-IRQ
> operation in platform drivers.
> 
> NXP S32G2/S32G3/S32R SoCs integrate the DWMAC IP with multi-channel
> interrupt support. The dwmac-s32.c driver change is provided as an example of
> enabling multi-IRQ mode for non-PCI drivers.
> 
> An open question remains: should platform drivers support both single-IRQ
> and multi-IRQ modes, or should multi-IRQ be required with the DT node
> specifying all channel interrupts? The current RFC implementation follows
> the latter approach — dwmac-s32 requires IRQs to be defined for all
> channels.

You need to consider backwards compatibility. Will an old DT blob
continue to work after this change?

	Andrew

