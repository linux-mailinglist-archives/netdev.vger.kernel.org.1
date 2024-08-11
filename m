Return-Path: <netdev+bounces-117492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1294E1E3
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339DE2815A5
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0745614B09F;
	Sun, 11 Aug 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x3ebpXPL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7113634C;
	Sun, 11 Aug 2024 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723390545; cv=none; b=LlI1GW54whFkyDjJsYpuiR/nLO07Uu58AzTJDw4Ga9mi8TD9CBd2sPAlAXAhojy14vDtxRfhfrMg2PzagOQEhcH1ZwOmf7TZfxB8tbOAGVEJr0HTYWxUxzH/scTdXHzfUMEGZMbYIG7XR2TJGzIkn/tl2txsl151Rk6KMHrB03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723390545; c=relaxed/simple;
	bh=qm6Y2wyAQoSeicTEMlMTqk4ky1oNRaACjaPH3282UNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0dVbh9w4SLBHandY8Ir2WwXcMUmEvcqQjqvuqTv2WQz9zIkPocEQOhLx2KJl22eGPlkv2wBooLkgS8tMcBTPOIT3QbkP5A/vAY7cdyXlqPHs4paSBd48ExFlRQfpbyaQFkQMmrT3Fwg3q+yrHh9mc3kfjYS9citk6k9PRlNxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3ebpXPL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bs6XpnLlW7Gjksj2L+h+eEvprEyms6epqWL+BfH10hU=; b=x3ebpXPLPTwZ3DilDZEiLL7kmt
	zLJcD+9u2KqIZMt+QaC7y5lENhgF+VH50kFiOqJTaC2dCi3uBPeKnf3agS5Q3OpSFbagqGoiVMVXz
	RNH2XcLwqkNMzgpS4lCZuhtZ/4oMVSHh+bkddXwKAzoevoBMmreXC+Dv4UU+zuP2VKNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAbM-004VNt-PH; Sun, 11 Aug 2024 17:35:24 +0200
Date: Sun, 11 Aug 2024 17:35:24 +0200
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
Subject: Re: [PATCH net-next v5 01/14] Documentation: networking: add OPEN
 Alliance 10BASE-T1x MAC-PHY serial interface
Message-ID: <76b99d25-2d58-4c30-90af-cd57ad377dff@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-2-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-2-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:38:53AM +0530, Parthiban Veerasooran wrote:
> The IEEE 802.3cg project defines two 10 Mbit/s PHYs operating over a
> single pair of conductors. The 10BASE-T1L (Clause 146) is a long reach
> PHY supporting full duplex point-to-point operation over 1 km of single
> balanced pair of conductors. The 10BASE-T1S (Clause 147) is a short reach
> PHY supporting full / half duplex point-to-point operation over 15 m of
> single balanced pair of conductors, or half duplex multidrop bus
> operation over 25 m of single balanced pair of conductors.
> 
> Furthermore, the IEEE 802.3cg project defines the new Physical Layer
> Collision Avoidance (PLCA) Reconciliation Sublayer (Clause 148) meant to
> provide improved determinism to the CSMA/CD media access method. PLCA
> works in conjunction with the 10BASE-T1S PHY operating in multidrop mode.
> 
> The aforementioned PHYs are intended to cover the low-speed / low-cost
> applications in industrial and automotive environment. The large number
> of pins (16) required by the MII interface, which is specified by the
> IEEE 802.3 in Clause 22, is one of the major cost factors that need to be
> addressed to fulfil this objective.
> 
> The MAC-PHY solution integrates an IEEE Clause 4 MAC and a 10BASE-T1x PHY
> exposing a low pin count Serial Peripheral Interface (SPI) to the host
> microcontroller. This also enables the addition of Ethernet functionality
> to existing low-end microcontrollers which do not integrate a MAC
> controller.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

