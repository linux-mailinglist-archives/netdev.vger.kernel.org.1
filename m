Return-Path: <netdev+bounces-68514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E173847108
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA97B2938B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0102545C06;
	Fri,  2 Feb 2024 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WgtHVplz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C145BF6
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880137; cv=none; b=nB2OGUgLk0JxoXTIo7Slgj+GrjiTzegik8Wu3uyXiuOX8YX6e80TnPZiow8H4buwDWgZR4s8fOeYL9XfVvip27kTFDTN3TEOisTMt9B+TxGrjeT4fxExOYLg6yCpKKnPeo8Km60fjCrSkeXH61MkKT63oLAuBOJ5HItmY739c90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880137; c=relaxed/simple;
	bh=AkfVREWqtiMQ0P7yIO4atobgHukchUjjKceysBhEJVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCLbe/U3y8UW2q81FCsr522r3XTfVhOAoueCC4HJ9/+ImgKYEM+hpHRAij2eEOaPCPpJ2aV+9IMEQuHnSAJESZ7tBJ+lBgIKU00Q4FvM7g94oJjcZkgp4qMZp9q6WZW7F2OwI0rBkKZaHyhksbY/MmI2Y+QXJnOrUaZ3SPPMSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WgtHVplz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zCy5TRRChiARS/YN+mikGNWPL6NJ970/jZDxj25xTy4=; b=WgtHVplz7iZ83QxUazbfsMgAB8
	Sm6k2dnouYrUYlhyQUW9NJQkyZUbc8TqiuGE5Jt4JipX5+c4AF0OG8uywsFXkUGDJ6nAxB8L4mjhP
	BuqWeP9PAlpGEbjXokCWy7vZgBYm6RGr4b2nQ+Bg9hqMrxfvnfY/X22fRvvMmjuw/qO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtUY-006mjc-EH; Fri, 02 Feb 2024 14:22:02 +0100
Date: Fri, 2 Feb 2024 14:22:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, g@lunn.ch
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 3/6] net: fec: remove eee_enabled/eee_active in
 fec_enet_get_eee()
Message-ID: <011cb523-0561-436a-9f64-4479648b4770@lunn.ch>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvm-002Pe0-TV@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVpvm-002Pe0-TV@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 09:33:54AM +0000, Russell King (Oracle) wrote:
> fec_enet_get_eee() sets edata->eee_active and edata->eee_enabled from
> its own copy, and then calls phy_ethtool_get_eee() which in turn will
> call genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Therefore, setting these members in fec_enet_get_eee() is redundant.
> Remove this, and remove the setting of fep->eee.eee_active member which
> becomes a write-only variable.

I _think_ p->eee_enabled becomes write only as well?

	Andrew

