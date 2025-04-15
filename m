Return-Path: <netdev+bounces-182894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABBA8A491
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1446A3B6D32
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF92980AE;
	Tue, 15 Apr 2025 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6Fg9lZLD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB4297A40
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736004; cv=none; b=DuV4d7i7jZq6jfs6fMkgGsGV95daiwtipEGstckCDvs425106u+PcY+uSzdZa4P19NuLCjxEVHD5SRua6iXjInXVr2MC/ebvJv6RoOLeC4DvquvM7X19n7g6Tnp5q0Z6mZwBEuKqdONxxfzuhV3HkChLDGEi9AHMa+/iG+CNcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736004; c=relaxed/simple;
	bh=H0l8Wtqgb4i97S+RWZ/ta3rJzU0kuZFJUkKMydBGEb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h55+ZMJa7Mjf4td3nRFLzskTnjgxL58/YsrWqzH70dq5+unAG81zATiZ8AW77z3K3C4jo+ms1Us3LfUZkytSJx5PeLcgJQ+ji5fHqFKtiaEC2RxiKsb2QyJ9lCe3WgWDW1ZjiA/FSQ0x76Ai17QVhUmYbXJql6dlbxqz8fNIYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6Fg9lZLD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wp/I9Y/Mgjx6GvKWv7wtlhx9b7XZAr2v2596rXTJtC8=; b=6Fg9lZLDnv5vxdgBEO67ohr/1b
	8mXoiPEDLysESWIrWvdbZb+91akD6+vu950P7lSikqfrTnvCNuWQHtAQUV147k5ZDUO5y8zFOPrst
	z+UGK5KWMfeiUsjIMJTO3/cq9uJ5lIhxnJNfIkLyFYGLtP7sFQzRWHHGGBwPcPQ5HCp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4jX9-009UUr-Bt; Tue, 15 Apr 2025 18:53:15 +0200
Date: Tue, 15 Apr 2025 18:53:15 +0200
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
Subject: Re: [PATCH net-next 3/3] net: stmmac: sti: convert to
 stmmac_pltfr_pm_ops
Message-ID: <015dfded-fd5c-4596-b89d-3522e38d707e@lunn.ch>
References: <Z_6Mfx_SrionoU-e@shell.armlinux.org.uk>
 <E1u4jMo-000rCS-6f@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4jMo-000rCS-6f@rmk-PC.armlinux.org.uk>

On Tue, Apr 15, 2025 at 05:42:34PM +0100, Russell King (Oracle) wrote:
> As we now have the plat_dat->init()/plat_dat->exit() populated which
> have the required functionality on suspend/resume, we can now use
> stmmac_pltfr_pm_ops which has methods that call these two functions.
> Switch over to use this.
> 
> Doing so also fills in the runtime PM ops and _noirq variants as well.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

