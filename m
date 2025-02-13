Return-Path: <netdev+bounces-165898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63BCA33ACF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472A73AAB24
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36620D503;
	Thu, 13 Feb 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FHKPeciZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A820C490;
	Thu, 13 Feb 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437867; cv=none; b=CsIvDdIN4mUAaVQQNc74/IdycF9+eK4nTKJlOAqYQ/z8+cTE6O8w3IQlnPiKEFNIlmtnLbwKEcD2/Uwn9YewluYWMEV8dysDnGCRD4Xa2tNPA2jLkxwQPa3L8KRrGwK4w+annoMKRsmX9GZrj41ZVJbD4sgfClOILPOgfhOAmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437867; c=relaxed/simple;
	bh=UBgSTAr18iVKE29oD70Y3P8gPekBiga3WnTrcv0GM6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTDY506EWV639W7s37FhVygBQbIYasV+pWDXiJYl5bQQkMs0RCwt+L8Fzdh/KosogDLXFpFLYrRIyuGoNHDx1KPK1yPW48LmDgLV3xTpbTjfG9F2P5nYGCIiJ0Z6umKgmeSWjFKpJJxWqvPks66aGRH+YVYb/+ZNlilmjEAJyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FHKPeciZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KV5C98I/LRqywPZKUBEyHWkSBV5mfoVaexgU2HkSRYY=; b=FHKPeciZuEcM5wkuV85GDTvkeB
	de68VNbqN90ENT8s2DIP+ji5goQOWCDVknZRxBG15appf1F0LAR/UzARWezSkdzyEOLAN9GWjAX9a
	AozPbDPm4XZ2UnoEG/uEIiwQVt4+wHYevtV9wAU9hEnhGYXKKEI9lUvXfWzyYFb0SYNQ9OWFwmyAv
	HJVJty0Ea/yyFw7+VvapEmG0Y1ML5mSHNPlB0e85RGmhC8U0V24500NtlGzE1+4neViZVoSHhwd8D
	If330fBza54lqvfUfxO/rAwGfipdI0WFzBjZOtzOQxMem9mQVt6OxuVPeiIB4O64hBtH3wba4w0LA
	Z7mckHBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiVFF-0000VT-0J;
	Thu, 13 Feb 2025 09:10:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiVFB-00021H-16;
	Thu, 13 Feb 2025 09:10:49 +0000
Date: Thu, 13 Feb 2025 09:10:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Qingfang Deng <dqfext@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2] net: ethernet: mediatek: add EEE support
Message-ID: <Z623GQHI_FHyDyjE@shell.armlinux.org.uk>
References: <20250210125246.1950142-1-dqfext@gmail.com>
 <a42ec2d4-2e4f-4d1d-b204-b637c1106690@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a42ec2d4-2e4f-4d1d-b204-b637c1106690@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 10:04:50AM +0100, Paolo Abeni wrote:
> On 2/10/25 1:52 PM, Qingfang Deng wrote:
> > Add EEE support to MediaTek SoC Ethernet. The register fields are
> > similar to the ones in MT7531, except that the LPI threshold is in
> > milliseconds.
> > 
> > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> 
> @Felix, @Sean, @Lorenzo: could you please have a look?

That would be a waste of time, because it's implementing the "old way"
including using phy_init_eee() which Andrew wants to get rid of. It
should be using phylink's EEE management.

The patches for the mt753x driver converting that over have now been
apparently merged last night according to patchwork into net-next, but
something's gone wrong because there's no updates to the git trees
on korg,

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

