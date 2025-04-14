Return-Path: <netdev+bounces-182390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DDFA889D9
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4E91898AAD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89519E806;
	Mon, 14 Apr 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uiQtc286"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491F19CC0A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651822; cv=none; b=n8332o4c/TfU4vQFAZUhcwzuG0PhL5FlLyAp4iuSchP5oXiWdjD4OJWSqIaiRjTgJVBK9P0iVw7nkkiseQp8/wlIUC0NkXvzyU1a1wtF/7li2gl55FXJHZmX8c1Q4Oj6NLLzPFUvKpqul1huRJasPkBo2LDMgk8Eiw5CQXbJZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651822; c=relaxed/simple;
	bh=CkCUah9vGUhgVPN/4lnrfDpXCLChP6GAWZa7t1EKBig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO5H0D7zppf0NSDLPtkqhcNHhv+evPYff0Hg9e1PZRQUuf7NGZcD/1epaVySX7qWBqi59avhxshpVJrngAY6Pgc7r8AE1jpNcOBc+iIgM/aTuQVUsWSahyT23bInu813jYoJ64g+L10lO+ULW8c+YY1HGlB+LVWctSOPW4IOKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uiQtc286; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p2zIMHrDMq/1rVu7mSYz5FdoQpd9TCLFKHxSveT/LnM=; b=uiQtc286DG+TEz1K2TajQcfXO3
	aQ0Y9O0hmoN5pCPsCMlbmDgwvhULDn5VvCjNv1LLl1N/SIYOowrisvGqF03MaajJguqGvyX9mrfMl
	GOolssWUjGb+kAbkALZ2H5E00Z30Hu9ZfS0Y7kzSADc+y/wW9dmsnwzOabuIRQv0L1p8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4NdM-009Eyo-Ic; Mon, 14 Apr 2025 19:30:12 +0200
Date: Mon, 14 Apr 2025 19:30:12 +0200
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
Subject: Re: [PATCH net-next 1/2] net: stmmac: ingenic: convert to
 stmmac_pltfr_pm_ops
Message-ID: <df7dfb2e-ac3b-4d27-b7a1-2a36e2ee4567@lunn.ch>
References: <Z_0u9pA0Ziop-BuU@shell.armlinux.org.uk>
 <E1u4M5N-000YGD-5i@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u4M5N-000YGD-5i@rmk-PC.armlinux.org.uk>

On Mon, Apr 14, 2025 at 04:51:01PM +0100, Russell King (Oracle) wrote:
> Convert the Ingenic glue driver to use the generic stmmac platform
> power management operations.
> 
> In order to do this, we need to make ingenic_mac_init() arguments
> compatible with plat_dat->init() by adding a plat_dat member to struct
> ingenic_mac. This allows the custom suspend/resume operations to be
> removed, and the PM ops pointer replaced with stmmac_pltfr_pm_ops.
> 
> This will adds runtime PM and noirq suspend/resume ops to this driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

