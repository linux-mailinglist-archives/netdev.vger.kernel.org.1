Return-Path: <netdev+bounces-193968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AEAC6AAD
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7483A6958
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00280288519;
	Wed, 28 May 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ArBPduF6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A86C28850F;
	Wed, 28 May 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748439265; cv=none; b=rrCUVtSS2bivdiO3uXeRffBUQKwaowF9RozteH7SS5UYl18qJg1LQxzIWU6CYIDtgm8wKDQC8ojrgIgvTXahpJNe04lm2tf1o2IXNwJ8KCeP5BE+tzFrZWU+TFiMn77Cly1a2la6N49jN5jZTKA0m3rifavmTqaapQ303LcV+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748439265; c=relaxed/simple;
	bh=lSlTzvqYvzVkhoHlYSWjOtonFkIYqKQkc5ttEOkBwr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USlUidsu06evRSHr+w2NZJppE+9FKpDj3K41H9OdPc+BO9IWq+5ynGlNhTto/EKMMHgW4UfpwHRzp20Zqr2I6eyDO4Wy9IBAgKP+yCfoM+AjehPA8q/zN6VJZ8EPj+EFbxbunaiYuWcUl1/FSCC/zdVuUKnVS5LYmfOdB0OhUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ArBPduF6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DKPJPtI3URqKQogiR3sy89lcY7NU2XOj83Ly1vrJsws=; b=ArBPduF6FEK+oQkYDHWrDH38DX
	zMVKHZWk7bT/9yjo6req6iBhzjD83I2xsJv7gUe2f96C6hKZkNPmcY46+zIA4xHEL9pFI/i0Oe3X3
	YHgMPthcDlqbpDAr4q+L6DgsEG+md87R40Q0PBYpGW8ZehzzI/DAAbAb9ie7/FME+CBE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uKGvA-00EBBB-18; Wed, 28 May 2025 15:34:16 +0200
Date: Wed, 28 May 2025 15:34:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: weishangjuan@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com,
	jan.petrous@oss.nxp.com, jszhang@kernel.org, p.zabel@pengutronix.de,
	0x1207@gmail.com, boon.khai.ng@altera.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, lizhi2@eswincomputing.com
Subject: Re: [PATCH v2 1/2] dt-bindings: ethernet: eswin: Document for
 EIC7700 SoC
Message-ID: <ea59176e-e415-4b39-81af-ad0e2130b826@lunn.ch>
References: <20250528041455.878-1-weishangjuan@eswincomputing.com>
 <20250528041558.895-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528041558.895-1-weishangjuan@eswincomputing.com>

> +examples:
> +  - |
> +    gmac0: ethernet@50400000 {
> +        compatible = "eswin,eic7700-qos-eth", "snps,dwmac";
> +        reg = <0x0 0x50400000 0x0 0x10000>;
> +        interrupt-parent = <&plic>;
> +        interrupt-names = "macirq";
> +        interrupts = <61>;
> +        phy-mode = "rgmii-txid";

Does the PCB has extra long clock lines in one direction? That is very
odd.

https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366db828d845bade3a1

	Andrew

