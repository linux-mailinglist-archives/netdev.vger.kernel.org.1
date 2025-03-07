Return-Path: <netdev+bounces-172985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE38A56B6E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931C87AA2AC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E721D3F0;
	Fri,  7 Mar 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FufODiUI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC321D3ED;
	Fri,  7 Mar 2025 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360175; cv=none; b=QZ71zG4VvUjZgkwyzySwibunhVncWbDzEw45hhdGPB7qXXrqyHR2EjLq9uMaG62ROQnSa0Y3xnILInqf+J7Fd1D3id6j8+u4T3uPNHIgY9CQl0raiL3GoJNlvUFId+ntnxAShGhNGQwp4xrm97/v9lPA/EmQo92ZjVy0IARLa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360175; c=relaxed/simple;
	bh=DQvwBE3K7wzKqqbtyQLjgZyIxBKJQenqbjwYxhmSLxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn/unUfX96p2esOojdFIQhisuERoz1HxG9ybWhQ5JerOcP27NXLKI6GdxylPGFnob4PS6rqH1mX6mJ83y0o3JF+pODcBZmkJ6gc79HsalaqR4G5oL4FoMnP5lc99hN8aA1srLzmQEmQF4QFuNyRQKyW87OjYs9cHymaRMN95f/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FufODiUI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yn7ux/Q934nEj2IODedpVWaIfwaseRhFKbJdfXrSFaU=; b=FufODiUIOanVNCqafgKRVNBKkG
	8AFE2vweHwr4mNEfbiMvMMdN7jF/kImN8ZlqRrTUbRisHgc5htYoyOY1/xRchDl02gbJ8+RwdETlV
	yf5NIag9+CvqVY2Wwx3oybGq9F139EJMS+IkYezmQi9eJKY4DySpoGEYcy2GofTvkUzJ5VunETMsS
	JIZ1vMf83Mr0dsC/5pWj4VSOvQstBc1YVUnTfr2EevR9EUUmV+VwAAE+irAyyL+d1isTulIRJt/tY
	i77W0yrs4wEz5G1p3zcY1TnyC3eBfcQilAmmiP1EoZzQALEMGukyy1C65IizFle84dHfS6xV5EQIa
	5Onhu+hQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqZK7-0007aN-1l;
	Fri, 07 Mar 2025 15:09:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqZK2-0007ua-2m;
	Fri, 07 Mar 2025 15:09:10 +0000
Date: Fri, 7 Mar 2025 15:09:10 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v7 3/4] net: stmmac: platform: Add
 snps,dwmac-5.30a IP compatible string
Message-ID: <Z8sMFh7yAUTZ9GRN@shell.armlinux.org.uk>
References: <20250307011623.440792-1-inochiama@gmail.com>
 <20250307011623.440792-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307011623.440792-4-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 07, 2025 at 09:16:16AM +0800, Inochi Amaoto wrote:
> Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
> to define some platform data in the glue layer.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

