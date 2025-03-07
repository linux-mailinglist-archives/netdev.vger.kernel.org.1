Return-Path: <netdev+bounces-172982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43EA56B36
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389973AAA37
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF621C185;
	Fri,  7 Mar 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yW0AcufO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF96218AB4;
	Fri,  7 Mar 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360038; cv=none; b=asBDkyZ1EkcMzwOK4AEjP/yxqQP8KjKvWO42lQn7zr7waLo9tpGQkWS9yURCH103d+q/3bSbljA6dUzlODDUzC7L2ZEVCoWYUb97YNJ5uu/+ItiC1mMq9UU3ki6zDl8F9k7plJtoM/ZuF5sQETDeSFclGopreX9XLEAs467dzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360038; c=relaxed/simple;
	bh=k2RsuBJenczQo70HERB+LmBalKEDkzEizBCy+Q/+BJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHe2CYccpEukiQXKzZxlZurEGVC8s1C8QkC7cUSI/BNoDBEKuHEqNKvK4C2LD+6iVsNVavj6M3q7E4wfshADAls166t73JmQrASrUG0QiEfaqLQamTTQhjIIzL02EncKWnHD9af5uHanGfZ/ToqFlPOaN9LIEv/tMFUjWnD3m/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yW0AcufO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+YoQ2bMScfM3XAjlW+ut1pe8WVSp2EYOFx87rsgzN5k=; b=yW0AcufOGRYzmpgjGUgGNmg/0F
	56qmo0oQ6Pdz6e0J5QHj/u774MNjQpmgTkNm+4Z8BViLIV96x9aPBHpaG529Rn9Y9cYfKboGR2qfX
	1wNc3hnNoSARSM4ggrltwjCJJfa61gsC3vk5Nb2/f7d1VqjEMsOr2WEEa6T4QXBsqulZlf/fIfABR
	r390rRxnArS/qTzhbLk5afn2oiPQRawCCjC9QIBgjvYNE/j/QUzUzUnx86lj365Vo0vpxJzlanMxA
	w+GBPP64swpFjcRItYcpFUsgWldeODSnI6aEXLNBJuhpPKTMAb47O43gsDJkOTqmGIGNlD2AP20O3
	mMjClxuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqZHh-0007ZK-2W;
	Fri, 07 Mar 2025 15:06:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqZHX-0007uI-2E;
	Fri, 07 Mar 2025 15:06:35 +0000
Date: Fri, 7 Mar 2025 15:06:35 +0000
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
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v7 4/4] net: stmmac: Add glue layer for Sophgo
 SG2044 SoC
Message-ID: <Z8sLeyixPzH60mJ_@shell.armlinux.org.uk>
References: <20250307011623.440792-1-inochiama@gmail.com>
 <20250307011623.440792-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307011623.440792-5-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 07, 2025 at 09:16:17AM +0800, Inochi Amaoto wrote:
> Adds Sophgo dwmac driver support on the Sophgo SG2044 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

