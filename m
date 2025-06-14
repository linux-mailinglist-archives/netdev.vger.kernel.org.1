Return-Path: <netdev+bounces-197841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E14ADA03C
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B09E7A9B9A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA98201004;
	Sat, 14 Jun 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="edHA5A93"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A41D52B;
	Sat, 14 Jun 2025 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749939680; cv=none; b=DTx2Lkw6IbRs8nw04ztiNDVA5GxtZDbtrdJvsH3kVq0Bf4S4GzdTSBWUP9qq8HEVJXGK52/t981uO4MoGrbzN3H82EsPRw61U7907Vas5mV2voHm0o8IKS6PtVgWK91cSbz9zP18GUiB+KzKrSOIwdLoThXua5h5phXHMBjrQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749939680; c=relaxed/simple;
	bh=e4rM8ONvXsdvNI96RL29hs6nfK29YRVo0puDYuAxa6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpkEXSsGvXl+j0MHOj5f7dlWXLqpVCjVgxpzBaCTsk9YtvgbhAcksrLeK8P0A+uDwIuOvVMSu9Xu6U95RfB4hTI8zEuHNDwstvA3/c1JpYuk2RLCwGWYJkO1fb8swj2aIoJ9hIm1WTpQPEDRy62meFUiqCaW9xS0rgAeU+v263k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=edHA5A93; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vjbY7obwbAAFrPPEOEXlpDoKiqUTIDuOT/hoHoOFZao=; b=edHA5A93apXIr1C1lNSV6aVS2m
	pvs5DrAB4pFFXpeeeMvlNz24T/Z9YhKflRPw0a2UbXGpbrVYM4t16Peofu6UzR3PKFFY8Q3fDy9Sa
	JyejDutSXy7rqs9F8RshTJiWrBONMBxEPK5BrhEjZpytPx8cOoCIbU3ZyznKefF+w4+E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uQZEq-00FsZu-IO; Sun, 15 Jun 2025 00:20:36 +0200
Date: Sun, 15 Jun 2025 00:20:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet
 support for cv18xx
Message-ID: <05194937-8db3-4d90-9d03-9836c734fce1@lunn.ch>
References: <20250611080709.1182183-1-inochiama@gmail.com>
 <7a4ceb2e0b75848c9400dc5a56007e6c46306cdc.camel@gmail.com>
 <e84c95fa52ead5d6099950400aac9fd38ee1574e.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84c95fa52ead5d6099950400aac9fd38ee1574e.camel@gmail.com>

> Also ethtool seems to be incompatible with mdio muxes :(

Please could you expand on that, because i don't know of a problem
with mdio muxes and ethtool.

	Andrew

