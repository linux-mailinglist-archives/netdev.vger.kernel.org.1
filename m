Return-Path: <netdev+bounces-172984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D25CA56B6A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369787A74AF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785AC21D002;
	Fri,  7 Mar 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x9Anm586"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D821C16D;
	Fri,  7 Mar 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360161; cv=none; b=qj6/uiWKQe63voJO+FBlAYOH2tzeUl0ifSkr7tMr0fe+JEuG12TehS6SBqqx8T7hua90tlFCHGFF332psUOfZxIKRFVZeYuSCgAMH3XOERy7ZYoEmV62hNnwtmrm3Dygo4aE7zu3dWmsig1Y8F/RzgYHTRqqusoH83KTgct3Yqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360161; c=relaxed/simple;
	bh=D5g1w6+XmDdrXp1CAbqG6r64cw/Yvvz3AhuaCQog/vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfogsHq9NQYhlk4fXpiJRWWDcT6HCvnjo5hpzHrQIRof4hfRpDlSmdmGNijtZdAR5I0nj1Og4z1egeimhTW0gZbqvp79sBtUCN80mbozn26DGEwiwaRjx6iWsCtMKpu0SUD7egzISmILdZQprdVGoeo8aFFjjp47OklUEbL9WMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x9Anm586; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=se78CTgWSMz3fwwLUHiO5oHWeH+WmhQaI4Bm8mflklg=; b=x9Anm586sYnv+cpZc9KXc48alS
	wvsfTYgeanUiP4jsGZqdyqbURpfrkFuA+oIVM3tAqrpgP/ei3SdmEjrVugVb1T4eNFuTg7gtmDO2c
	T7a4F/KTMociRYbUrWS1heoWUbcadNzERNMbOmQuq2vZKK7+3D428CHMxRBQP+2DdkVgkcLyfl4nn
	bDxMLyNlWEnP/MaPIVd8zOV8bn265VkptQ3RoAnqdCZi4l2574oRqixKb8ZQTg0H5Nd3evL2gVNUv
	PLY4iDtOB0drDRnq7p6bwDfViFApqU5L0t2R0L4fMDZJmgngG7RVHJEtQYWhWZfQTg0Pp/KV1eGrQ
	WKe7OdsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45108)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqZJn-0007Zx-1M;
	Fri, 07 Mar 2025 15:08:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqZJj-0007uQ-0o;
	Fri, 07 Mar 2025 15:08:51 +0000
Date: Fri, 7 Mar 2025 15:08:51 +0000
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
Subject: Re: [PATCH net-next v7 2/4] net: stmmac: platform: Group GMAC4
 compatible check
Message-ID: <Z8sMAyH0qsMyXmjX@shell.armlinux.org.uk>
References: <20250307011623.440792-1-inochiama@gmail.com>
 <20250307011623.440792-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307011623.440792-3-inochiama@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 07, 2025 at 09:16:15AM +0800, Inochi Amaoto wrote:
> Use of_device_compatible_match to group existing compatible
> check of GMAC4 device.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

