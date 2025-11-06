Return-Path: <netdev+bounces-236253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB382C3A40E
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 11:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BA31A45FE9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD628726E;
	Thu,  6 Nov 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0iLpV6p5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974C26B08F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424597; cv=none; b=TrNN19h2jyH0RTSTzdABzy7ccpODpZiIB99xFKH81Uo+qBp1RQMO0zip0auFuXhmaATxqIJhvNlPIVLyxWmdvHFUW+CMsmfa7DGfmYWNyVuNNgUCu4S0NQGXNBfqgB7F1XvNFtwbJ8HMPtKSKvWER6hOUXsd6s2kzyUf7eWZdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424597; c=relaxed/simple;
	bh=YCPg4RQWIrFb8aEDc9A3mzb5NF2Jxzc84gKviRkTpr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co/O8sShSwSjSYj8FyW/dsevgT/QekuzvL5unLM1OfU7YcgqTMq0TKvpN/o+kcJzuftDudYgxcBwiv+RsXsZCv+N64XbNAZynPywQ6q5cAY6Na70YUF7/fNbVH1nfLUzQDP3zOo2vbLSm62kbhM4nq4x2IIYrPEL3SNJzcLrtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0iLpV6p5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OMLwGIoNYOp5BTjdjZEw24Nsm4q49zJb/gk4akyApJw=; b=0iLpV6p5k1d8XZXOo/2wtp0gck
	ILbjL960etTl/6BeAYcs/QMyVWExZWDAeMF+oAHtNoYiCOzpV5QEOK4xqvkNFufxXQLqyzGbQBefM
	RMMUgqcuHBZILrfmsDw4z2NejnvVU8Hm2SpjN5ogRVj7gLLFUL2K2PAffbccV3OjkNb2m18CB79uP
	FvsNUheSqT9dqIqb9Fh7EFTQB6NFTndHHzvyonYwYhVF9TCkkiuD+LsYjMhlZRojbmghmFQcT0Ovd
	ddYUd8ebcYjWLWluaPZO6Z3gdr6TwOZwoNfT6l56QjcsOeGh0yBA8Zxiph5QFPw4PZGaHrUspZwtC
	/wDPW3Dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60346)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vGx8z-000000004nS-3qZ9;
	Thu, 06 Nov 2025 10:23:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vGx8w-000000006ZU-32os;
	Thu, 06 Nov 2025 10:23:02 +0000
Date: Thu, 6 Nov 2025 10:23:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: ingenic: convert to
 set_phy_intf_sel()
Message-ID: <aQx3Brj6t48O6wPg@shell.armlinux.org.uk>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
 <6ad7667a-f2be-4674-99a2-2895a82b762a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad7667a-f2be-4674-99a2-2895a82b762a@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 06, 2025 at 10:57:55AM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On 06/11/2025 09:55, Russell King (Oracle) wrote:
> > On Wed, Nov 05, 2025 at 01:25:54PM +0000, Russell King (Oracle) wrote:
> > Convert ingenic to use the new ->set_phy_intf_sel() method that was
> > recently introduced in net-next.
> > 
> > This is the largest of the conversions, as there is scope for cleanups
> > along with the conversion.
> > 
> > v2: fix build warnings in patch 9 by rearranging the code
> > 
> >  .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    | 165 ++++++---------------
> >  1 file changed, 45 insertions(+), 120 deletions(-)
> > 
> 
> Damned, missed that V2 and started reviewing V1... I'll resend the tags
> for V2.

Yes, Jakub reported build warnings on patch 9 last night, followed by
the kernel build bot reporting the same thing. The dangers of not
building with W=1, but then W=1 is noisy which makes spotting new
warnings difficult.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

