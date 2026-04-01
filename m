Return-Path: <netdev+bounces-274082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DjyLXoWzWmMZwYAu9opvQ
	(envelope-from <netdev+bounces-274082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E45A37AD88
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 14:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6125323D637
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E33DCDAF;
	Wed,  1 Apr 2026 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qNEW2nQK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F563A16B0
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045982; cv=none; b=euLwbU8udp7kqFplPzg430MtsL7XGy0gpcsWbtHheM/G0liZKA21YgeIiLIvYEmKTlButArfXHmWc2qzpKWR4U0o/Hto4xt2LvacjRXQU54DfjZK7U77Y7lqpjiqx+2Qz0bPqINCuchdT6Imku6ebXLnXOfXDHU6rN3lB2ienME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045982; c=relaxed/simple;
	bh=UomKkk4BjFfyv7HUqrBcjYNYioPovtxbqhl/XaetAgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx6tWivn4QMk3zAHD7ifALu6feKdcEOJ4UbvpAfqOKCwDJYoF0q4VQWIryZIj/NDLYQGPccbCCAdg+0Pg+W0chmICd2nBuewkf6z157gutDG+akLXdTJCdcZTI20tsPq2xkobC2jpimnG2eJPIaByVApF0CGJvp3bSF40KY5mJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qNEW2nQK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pcxQWoLJn9G0dptO93Z+OY78wD/jANP0+W3nIgxkSVw=; b=qNEW2nQKRTDZc2S5ljnvrwFD2S
	ynwfBvwdcAUg9wB9O2BQNo3gsYQBmZWC8+uiTL/bKTKBxga2nWKqXPIxb022Mtqb1OBj0ktBqfItp
	9zPLZJy1ZZlSRAZ2HEbzBs6x5maVTqWMfCM3b+e0uhiaUzx8BfBnLQxfqUtlE2lYy8eY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7uXf-00ELhN-8m; Wed, 01 Apr 2026 14:19:27 +0200
Date: Wed, 1 Apr 2026 14:19:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 00/14] net: stmmac: TSO fixes/cleanups
Message-ID: <420f910f-523d-4a74-a255-2fe48909283a@lunn.ch>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274082-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E45A37AD88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I'm moving the setup of the GSO features, cleaning those up, and
> adding a warning if platform glue requests this to be enabled but the
> hardware has no support. Hopefully this will never trigger if everyone
> got the STMMAC_FLAG_TSO_EN flag correct.

Is this:

  snps,tso:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      Enables the TSO feature otherwise it will be managed by MAC HW capability
      register.

I would not be too surprised if there is cargo cult copy/paste going
on and some do get it wrong.

arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi:			snps,tso;
arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi:			snps,tso;
arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi:			snps,tso;
arch/arm64/boot/dts/toshiba/tmpv7708.dtsi:			snps,tso;
arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi:		snps,tso;
arch/arm64/boot/dts/rockchip/rk3588-base.dtsi:		snps,tso;
arch/arm64/boot/dts/rockchip/rk3576.dtsi:			snps,tso;
arch/arm64/boot/dts/rockchip/rk3576.dtsi:			snps,tso;
arch/arm64/boot/dts/rockchip/rk3568.dtsi:		snps,tso;
arch/arm64/boot/dts/rockchip/rk3528.dtsi:			snps,tso;
arch/arm64/boot/dts/rockchip/rk3528.dtsi:			snps,tso;
arch/arm64/boot/dts/rockchip/rk356x-base.dtsi:		snps,tso;
arch/arm64/boot/dts/qcom/qcs404.dtsi:			snps,tso;
arch/arm64/boot/dts/qcom/lemans.dtsi:			snps,tso;
arch/arm64/boot/dts/qcom/lemans.dtsi:			snps,tso;
arch/arm64/boot/dts/qcom/sm8150.dtsi:			snps,tso;
arch/arm64/boot/dts/qcom/sc8280xp.dtsi:			snps,tso;
arch/arm64/boot/dts/qcom/sc8280xp.dtsi:			snps,tso;
arch/arm64/boot/dts/qcom/monaco.dtsi:			snps,tso;
arch/arm64/boot/dts/st/stm32mp253.dtsi:		snps,tso;
arch/arm64/boot/dts/st/stm32mp233.dtsi:		snps,tso;
arch/arm64/boot/dts/st/stm32mp231.dtsi:				snps,tso;
arch/arm64/boot/dts/st/stm32mp251.dtsi:				snps,tso;
arch/riscv/boot/dts/sophgo/sg2042.dtsi:			snps,tso;
arch/riscv/boot/dts/sophgo/sg2044.dtsi:			snps,tso;
arch/riscv/boot/dts/starfive/jh7110.dtsi:			snps,tso;
arch/riscv/boot/dts/starfive/jh7110.dtsi:			snps,tso;
arch/arm/boot/dts/axis/artpec6.dtsi:			snps,tso;
arch/arm/boot/dts/rockchip/rv1126.dtsi:		snps,tso;
arch/arm/boot/dts/st/stm32mp131.dtsi:				snps,tso;
arch/arm/boot/dts/st/stm32mp133.dtsi:		snps,tso;
arch/arm/boot/dts/st/stm32mp151.dtsi:				snps,tso;

   Andrew

