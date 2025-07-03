Return-Path: <netdev+bounces-203876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55AFAF7D34
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C715816DC
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C63D2EF9CD;
	Thu,  3 Jul 2025 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ei9Kh3pV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037F2EF9CB;
	Thu,  3 Jul 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558581; cv=none; b=PzyIViJIP98QNUeJYz7Xlxb7KBOw4rL2acQjZxtE6OvwMVAg4keVxQ/jXEfQo7XHzRthYi3Gab6yYlisxzoNP5HlNxjN4QuoiypC96+Ls6dYl8zMlrLsPATQ6ZLFe4aFpAR55A4//dLa9325x5Hu4LFUUhxxyXMBgKnyGfvgxew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558581; c=relaxed/simple;
	bh=can3F0NiK+RM/o/h/N4y84gESEsFFjLqz7fOQSUjTuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3ZAF/9IHIZgUzO9NEcJ9YlKjmZdgFCDNM9NwChGnxZBgsb5w2sPv6m0PBIMQaTe+Ad/aHM7jvav+20MeSg04Rb8ymgviUDzuhA3qu2reoXJR7CZBA1xRlztGEmFmcR9Q64DUWAdAM+4XEh9Vx/+Ugm2LMis40PrsgT5egTR92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ei9Kh3pV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wtjRuAyC7vMRMx/UJSaY6ovJK30TPRL48z6eA243l8I=; b=Ei9Kh3pVvB6iyQDYBACPJ3WWRB
	UA5sMKAdqAeWJyAzn7SUrmaE3ldJGc4cKGtebzXPpzC4fjdvwMYXw2r2JUheQZRFSonaYPrMsc1C3
	HCwKhbK8CGTH0i0eDzvU0g6Ajqhcu9b8WC+Z3GZkHBqUrndxlszGtilS9tvgQ+roZO8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXMOe-0007HZ-Dn; Thu, 03 Jul 2025 18:02:48 +0200
Date: Thu, 3 Jul 2025 18:02:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
	vladimir.oltean@nxp.com, jszhang@kernel.org,
	jan.petrous@oss.nxp.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	inochiama@gmail.com, boon.khai.ng@altera.com,
	dfustini@tenstorrent.com, 0x1207@gmail.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v3 1/2] dt-bindings: ethernet: eswin: Document for
 EIC7700 SoC
Message-ID: <3efddad3-87f7-4f4b-a406-a0c866ef5fd4@lunn.ch>
References: <20250703091808.1092-1-weishangjuan@eswincomputing.com>
 <20250703091947.1148-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703091947.1148-1-weishangjuan@eswincomputing.com>

> +    ethernet@50400000 {
> +        compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
> +        reg = <0x50400000 0x10000>;
> +        interrupt-parent = <&plic>;
> +        interrupt-names = "macirq";
> +        interrupts = <61>;
> +        phy-mode = "rgmii";

Please don't user 'rgmii' in examples. It is normally wrong, and we
don't want DT developers copying it into real DT binding, just for me
to tell them it is wrong.

	Andrew

