Return-Path: <netdev+bounces-111352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244DA930AA7
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9071C20AC5
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206EB13A411;
	Sun, 14 Jul 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tVVEbyH/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974326AD3;
	Sun, 14 Jul 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720972841; cv=none; b=cmLkzUPDOxf8Evm4TfstZYmEomtqZIoW2iXUYDgmLVh81RTEfyM8yd2at1EgtTU3jNVOTRfj8FBA+5t5xe5YTv2+mOb2PtExzVYJAITDphXdI9lUjX0XNspeTyIzo8sUNucCi16C6odzwttf7s2qB60WjfaGf6KFhS5fBreSafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720972841; c=relaxed/simple;
	bh=bpAz/A1/JrajaqHfyp+/k6Pv/IZ9oTrY0fdnbnz1BkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvGDVQzjLwLZNi7OReNzQXa32uQEWuYRcikjIggIkilxvC0D2nDx2sT5ztL09k1lBHC82CMw7OVTGF1g6FLM3YMeSSthstjznwADg2HEzfx2EJ8iNaAze/PgvyTZvtBlC82C/xd2+1z6v1eCjzUk/slDfey7XWog4uf1ZYBwf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tVVEbyH/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gcag5dhogKZC9gz32/PhUCgzc0qisX31yFm2IoNiCR4=; b=tVVEbyH/ZF78tYD5buaLytDHq7
	aDXKypXG/uP8agsihtqRcSsxAlBE+IX5vdMGcMs2VqmPhGi5KYoMupCpgGTtYYRr0pikXWeUOrg1k
	bd46o1b45Al6L1QVJ7CpZJjuLsd8+OpP4yFpCnjn+bz7qQBJIhqjAyn6I/qA92moIilc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sT1eB-002Vkg-Lq; Sun, 14 Jul 2024 18:00:23 +0200
Date: Sun, 14 Jul 2024 18:00:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Drew Fustini <drew@pdp7.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC net-next 4/4] riscv: dts: thead: Add TH1520 ethernet
 nodes
Message-ID: <57f778e0-e29e-4257-a06f-a15c96da49ec@lunn.ch>
References: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
 <20240713-thead-dwmac-v1-4-81f04480cd31@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713-thead-dwmac-v1-4-81f04480cd31@tenstorrent.com>

> +&mdio0 {
> +	phy0: ethernet-phy@1 {
> +		reg = <1>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
> +		reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;

Are delays needed after the reset? Does the reset need to be applied for
a minimum time.

	Andrew

