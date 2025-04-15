Return-Path: <netdev+bounces-182805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67517A89F18
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC92218923E5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D41C297A40;
	Tue, 15 Apr 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SyhUf/n/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548D2957C7;
	Tue, 15 Apr 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722752; cv=none; b=YpK3u1OUXm2XGrCjajPPpW2pvVYFwbgiOuTqonUtYdYwAVZB9SyWoj/snaoEr2Oiuh59FNg+dp9IwG7qtiWZRSAX+dTT4N2yrt6KUHs3OXA1d4hVZm6S1zcdvirVsFTv+I6gwleZ6Wt7R53Ka1Vob76lk4KsdHzIzMqCCYviK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722752; c=relaxed/simple;
	bh=BeHlrz5CIQlk/1kDDh2XFjvzQ+Ov07K+rokHvYu2Nj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlPRqLKcMRdQJSzv7K+ZOsZXq4m1jCL2XvVGd06vAC6tJJqqem3SaipeALns9EBPeXCZrK8I0dPxRDgxj2P0vFXb0JaQJb48QdYZVp3YJeHP8l89NtW3p7kUG7pnwKgkQqdVaPsvmLHvWNl++udiVOFvdGJJ1r/7/BIa/SDpYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SyhUf/n/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S+9AKP7zQ1+iMRVWZx18hsEz57eDtfhGlOAA50AWGAU=; b=SyhUf/n/OF9SyPoLA1ckdHwam6
	5WaQP2y7KmbnQjEBT4QA5bWMeKLM0hBfi+nzMnWSov05efBfqdCcy/VRO6BApbaoyKMQMrYHrMukf
	u2rgHQFqsw7Z4wPUihGUMayHx1i3aLoJpiB/JQqoLl+5qtmG8EmXQOUJ4v2Gs1SJgLaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4g5B-009RlD-7A; Tue, 15 Apr 2025 15:12:09 +0200
Date: Tue, 15 Apr 2025 15:12:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 4/4] checkpatch: check for comment explaining
 rgmii(|-rxid|-txid) PHY modes
Message-ID: <a0904f35-8f26-4278-9090-9bbeef905ef7@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <16a08c72ec6cf68bbe55b82d6fb2f12879941f16.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <20250415131548.0ae3b66f@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415131548.0ae3b66f@fedora.home>

> My Perl-fu isn't good enough for me to review this properly... I think
> though that Andrew mentioned something along the lines of 'Comment
> should include PCB somewhere', but I don't know if this is easily
> doable with checkpatch though.

Maybe make it into a patchset, and change a few DTS files to match the
condition. e.g.

arm/boot/dts/nxp/ls/ls1021a-tsn.dts:/* RGMII delays added via PCB traces */
arm/boot/dts/nxp/ls/ls1021a-tsn.dts-&enet2 {
arm/boot/dts/nxp/ls/ls1021a-tsn.dts-    phy-mode = "rgmii";
arm/boot/dts/nxp/ls/ls1021a-tsn.dts-    status = "okay";

This example is not great, but...
arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi-                         phy-mode = "rgmii";
arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi:                         /* 2ns RX delay is implemented on PCB */
arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi-                         tx-internal-delay-ps = <2000>;
arm64/boot/dts/freescale/imx8mp-skov-reva.dtsi-                         rx-internal-delay-ps = <0>;

There is one more i know of somewhere which i cannot find at the
moment which uses rgmii-rxid or rgmii-txid, an has a comment about
delay.

	Andrew

