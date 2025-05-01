Return-Path: <netdev+bounces-187238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B2AA5E28
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 14:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3374A40B7
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9621D54E2;
	Thu,  1 May 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HuA41PXy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8C1EFFA3
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746101756; cv=none; b=KRyl5sz8jF71yCzQjP/xYkTIhbGbJR3Il+Yb7iM2pNTiuTc+ENHbF3qS2nQgg4OnWZ4VAB2YS18R1kGfCjbWJ0PYYPTdcFgjGvdYP6Eg6XKT/e9+h1D0n1Uf+9+ApP6osStffL4j79KYRSROyVf1RQWpJUppil/QXSSF62NqE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746101756; c=relaxed/simple;
	bh=zv5H39P7IqJWewqiZRBvHg3aLUNJRaKdn5EU8v48GmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axN7MzyJgDYIiPxPHSO9ZGqQD/Lom+Wsk+rWHY3SQvrq4Jxu7Ag/xuNhw0QIZIJ3wiUPyGULEI/D7NTaqP6sRWs+pXs2VBD36JeINnZsbu1Iibp9aI6R/xJeowmm2Jgh5Rohx0JWxEMigvZxVgZbInmxf5+vHRvrJCq3bHNyxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HuA41PXy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iKwKmN5MgpqdaSIT1WtFxvF62foTxJhiMC9BORmGGn4=; b=HuA41PXy9c1qxc6ciZpwfdnFsI
	ejhzB97ntiFaqJD+vKoDqfw3SJwo9Ui1MH0yqx+XtjXI8b8/8hJ47Rlqj7fRlfSwJQeYyv5oTncs7
	kdy0E+uJmtkWrgQKJOFlOhH5gGVwxLxnXLzPhVUi+lwnXJ5poyYdad3B+W9VUK8sumHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uASpM-00BJJv-Qp; Thu, 01 May 2025 14:15:44 +0200
Date: Thu, 1 May 2025 14:15:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: intel: convert
 speed_mode_2500() to get_interfaces()
Message-ID: <561331ed-b231-4a3a-bc97-7ab11a6759eb@lunn.ch>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
 <E1uASLx-0021Qs-Uz@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uASLx-0021Qs-Uz@rmk-PC.armlinux.org.uk>

On Thu, May 01, 2025 at 12:45:21PM +0100, Russell King (Oracle) wrote:
> TGL platforms support either SGMII or 2500BASE-X, which is determined
> by reading a SERDES register.
> 
> Thus, plat->phy_interface (and phylink's supported_interfaces) depend
> on this. Use the new .get_interfaces() method to set both
> plat->phy_interface and the supported_interfaces bitmap.
> 
> This removes the only user of the .speed_mode_2500() method.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

