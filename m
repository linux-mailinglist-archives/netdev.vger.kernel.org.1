Return-Path: <netdev+bounces-178789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C4A78E3D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3976216369C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD0023A9A7;
	Wed,  2 Apr 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bLpZ6hHr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA49239565;
	Wed,  2 Apr 2025 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596591; cv=none; b=cLZ7Y2IKOOmUFkTrk+FCVvoBmLtUf0di1nFVAdkNmP7D9EKRs//gwEOTrTTQW1SU9S6vu0soAhXuUOFrdz2AlTEarCDTC6ITTpon1rW7jz0WaGgrjzKP67U0yUwKZBPIN7u23+O/9uU1yibJE9iIKk3TtmWGNsklPR5MaHMcpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596591; c=relaxed/simple;
	bh=hyIORvcjc8cnOrwXJJLDQlnMlsVxwobtC9HnweVC5sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GceIoZVk0dKlpUxyFCzOEvLm1NEZDNqvNUchYzp72gb3Cm8Y2SM1thDy8WKvyfn1SRjduOkHgWCHX1/rd2t3plo0I0g9w6cSWHoCLG2IXIjO+Mtf8oSR2IPldCtCfRXz9WGntWz9RstxXm/5BlNfVuW3wECswPzTZ90R/fIMVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bLpZ6hHr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=m5oPUg4ARF8TnNRDBE3jh/Qug56RDVjQifVvp49cFpw=; b=bLpZ6hHr1wVANQ2fF9WBWqeuN5
	HVjQWpQ1OlZggMUP4tufjE3uKqSb0br7f/rT6FWm8LhBf6MhyCRlxMQs6R1eqCC9lnu1A6+Eobou1
	m1u67bO/yEmqZ75JIdUdL/wSSunPuHVf26lfRw+VeWvfOXSXW13frBpp8eGw8qPszd/w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tzx7O-007mpD-0W; Wed, 02 Apr 2025 14:22:54 +0200
Date: Wed, 2 Apr 2025 14:22:53 +0200
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
Subject: Re: [PATCH v3 2/4] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2
 switch description
Message-ID: <82fde123-4783-4d4c-a061-e07731ae7bfd@lunn.ch>
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-3-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331103116.2223899-3-lukma@denx.de>

On Mon, Mar 31, 2025 at 12:31:14PM +0200, Lukasz Majewski wrote:
> The current range of 'reg' property is too small to allow full control
> of the L2 switch on imx287.
> 
> As this IP block also uses ENET-MAC blocks for its operation, the address
> range for it must be included as well.
> 
> Moreover, some SoC common properties (like compatible, clocks, interrupts
> numbers) have been moved to this node.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Assuming it passed the DT checking:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

