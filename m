Return-Path: <netdev+bounces-180768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F84A82663
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36FB900027
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659025C6E7;
	Wed,  9 Apr 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KlrW0cDW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB0228CA5
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744205924; cv=none; b=dHe75Jp7q5znbIYZJVuhDQr3D35RnJA830Ib+6t5Rb/T6OoOJd9szNuTRDwMVCkxs09TXGrlidwlyVk6OEsGof2bdBx1Y3kYp46CsiMX9TeDliZH/d1tkM7MaJmZZPR03IKrL9sEe1iEfmXcpBMUJizWLs8kJxiydHXdsy/cc8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744205924; c=relaxed/simple;
	bh=cdayuC9LTaTNWWxNwBdE0CoNRhGMz3d2q8zGPI6Ew3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cApG2DTW0TiIgwqTiiLJcCHL66uWAQwOgnOjreCjO7C+650ww5gNYJTGtYGq28JWLgvm2xYLZO98izCF4ElqGe0L98/urBmrGZgwkzW8FVISysW1AQYBg/AZ/yZhgc22pSY0W+gEP0rYHiNcCNT/lyjpM28uD/tClq0WZ60+Cag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KlrW0cDW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tEi1ASfzu6RMVqoZyyuUKKGsqDK54V17Mow+ONkR8V8=; b=KlrW0cDWk63FXPUqN1Inh1XUtn
	724Jd+qQU3BWA5uHSs5mtbekTRQ/IcoxBXDrlBszeQEbTYBX4ZAZIaHRuY3j387gBGX1goZ9KdcwK
	k8B0fLiI3XsToIWx4lhrXzzKvml9QXUVaqE6vrSVU854jQcLWOtbjCfIBWJeoRtKdAUs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2VdM-008Xw3-O7; Wed, 09 Apr 2025 15:38:28 +0200
Date: Wed, 9 Apr 2025 15:38:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: dwc-qos: use
 stmmac_pltfr_find_clk()
Message-ID: <0d11c42d-43f1-4141-9ed3-9232f301a436@lunn.ch>
References: <Z_Yn3dJjzcOi32uU@shell.armlinux.org.uk>
 <E1u2QO9-001Rp8-Ii@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u2QO9-001Rp8-Ii@rmk-PC.armlinux.org.uk>

On Wed, Apr 09, 2025 at 09:02:25AM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

