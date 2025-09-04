Return-Path: <netdev+bounces-220081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AE8B44617
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFBC7B01C3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE31248F59;
	Thu,  4 Sep 2025 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hd8J0dEh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA922F16E
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012655; cv=none; b=u/Bq4BBKTIWmJ9JIoBuB4AK/f59k51l7tZKltxjrBV0PMD1eaIZoVQZt1H6H3r71tgpmq6SzdPW7NNfLNJDYsKrk565HL2KkrhCbMSlUItxJqhkESjhsrCU91RGZRTK0+lRDbxmG+QRsqpAxRE+nERzP0xJJLyEX4h+8197p3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012655; c=relaxed/simple;
	bh=g/vnWWAH+N2G0YtyNq37jRNdolT6eQY2+AhsGrGAnOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUxNktjnlVGUgWIuq0XRUTuUmN9dWDBGNSeM3OldRAGiTOq/qjFv6XQPmm0qMx6TQaBOTrFKVtUiUGWzohWgUjdwlHJdLnwuAjLhCC87/YM/RkRWkALqGVjelHNjQ+x5gxads14Cq2x2MqNm3qdx6MBiOJ731BrdGNCEuLk9zBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hd8J0dEh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9k49AGNLb5MxxmRILhhE+l4vy15lzrYQ/X4lAvJu9Kk=; b=hd8J0dEhz6uhVAC+yPUwr6ZBwV
	j4EJ0jriaNrRBEiNQTgB8ldmUVR5raWKhpKevLUZyLc3rQIkdyJPTxaa7PSn9mKk9RRVE0BDa6Zal
	iyFOES/tRgof6nruQ04rgxWLJ3R6VGPnxugD1/MmLTAKTPiQgX19EaYBeAsqJuxfmtP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuFFc-007G9R-Fw; Thu, 04 Sep 2025 21:04:04 +0200
Date: Thu, 4 Sep 2025 21:04:04 +0200
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
Subject: Re: [PATCH net-next v2 08/11] net: stmmac: mdio: move initialisation
 of priv->clk_csr to stmmac_mdio
Message-ID: <78e6c3c7-4a93-4310-998c-b4ea4daf15f9@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8oR-00000001vpB-3fbY@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8oR-00000001vpB-3fbY@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:35PM +0100, Russell King (Oracle) wrote:
> The only user of priv->clk_csr is the MDIO code, so move its
> initialisation to stmmac_mdio.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

