Return-Path: <netdev+bounces-184842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ACCA976E2
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 22:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9195A0508
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC6C29C33B;
	Tue, 22 Apr 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="h2QGGRsn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CF29AAE1;
	Tue, 22 Apr 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353267; cv=none; b=LbqmeDgOdeDtFTOihxEYWUBajuUPaE1gQWyfHpP1yW77RoRC7H9cSDovIHf5AwUZ1vRZBdPG6B8W9RrT8YVl/ZQJVaxw4h9n2uHZ/oxKU2mXtpwwGykvvEExEWI2N0iSPEEBlEnF6nsfurhbwaQ3n3y4vxNlX30OVL7d8+GpNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353267; c=relaxed/simple;
	bh=CS7AKF/9vLtf/TyeLql6jdatBRJcEof29RHJq/23Jog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J02mU8NjMrOfFzOxbn+TVQpjPEfRF6McfVYI0kGXq0Lb0Fa+NoawFD+9XKnDA9RLL0eNrnyFL1xkQzshKoSrTMSKSz6e35lN5AJXcdO9loKV4IorSwUGmvSdl4Kl2UiV9FLEaFTGEm5qNlBCrPVYJa4q+rxxVrUIKoyf8mRdVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=h2QGGRsn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T+6cHpd/27XGOPMFydca7fk610QISCEGPK2+n0P8YDM=; b=h2QGGRsnQ9gaBZ+OcdcyJxrwEJ
	H0uZvJY1p2AAy1KxNcFffKkp1A8h0pF3M1z+0DMaNZOl5coJD7+Fn3Mneg+CI0DnPM/FKyHs+ItfZ
	yYSqLtx7A6rjZ0xcZXjdQQ4Q2wmKGplUvjavR7/9zmtlVrzmfNF8PuyuJOIOtmGeoegOYFr7APmDr
	/Q2JaE4tcSvHcTWESIfpFIEmcSqzO9Z6U3j9aV52cz/DdzbYrbzcAQtHAAWNMpYs5Pm7E43v3U3Ga
	49jcfd9X9E1r1X7ChmTHicF7OEPY3RyKodXf5+rO+5SoBG7jeCuWG0t417BCtY+EgNJq1uLchbNoJ
	19XS1GbQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7K6w-0004yU-11;
	Tue, 22 Apr 2025 21:20:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7K6s-0007mx-3B;
	Tue, 22 Apr 2025 21:20:51 +0100
Date: Tue, 22 Apr 2025 21:20:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, rafal@milecki.pl, hkallweit1@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next 3/5] net: bcmasp: Remove support for asp-v2.0
Message-ID: <aAf6IgSCOlWuJn_2@shell.armlinux.org.uk>
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
 <20250416224815.2863862-4-justin.chen@broadcom.com>
 <20250422183235.GN2843373@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422183235.GN2843373@horms.kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 07:32:35PM +0100, Simon Horman wrote:
> On Wed, Apr 16, 2025 at 03:48:13PM -0700, Justin Chen wrote:
> > The SoC that supported asp-v2.0 never saw the light of day. asp-v2.0 has
> > quirks that makes the logic overly complicated. For example, asp-v2.0 is
> > the only revision that has a different wake up IRQ hook up. Remove asp-v2.0
> > support to make supporting future HW revisions cleaner.
> > 
> > Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> > ---
> >  drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 98 ++-----------------
> >  drivers/net/ethernet/broadcom/asp2/bcmasp.h   | 45 ++-------
> >  .../ethernet/broadcom/asp2/bcmasp_ethtool.c   | 21 +---
> >  .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  2 +-
> >  .../ethernet/broadcom/asp2/bcmasp_intf_defs.h |  3 +-
> >  5 files changed, 23 insertions(+), 146 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> 
> ...
> 
> >  static const struct bcmasp_plat_data v21_plat_data = {
> > -	.init_wol = bcmasp_init_wol_shared,
> > -	.enable_wol = bcmasp_enable_wol_shared,
> > -	.destroy_wol = bcmasp_wol_irq_destroy_shared,
> >  	.core_clock_select = bcmasp_core_clock_select_one,
> > -	.hw_info = &v21_hw_info,
> > +	.eee_fixup = NULL;
> 
> 	.eee_fixup = NULL,

Even better... omit it entirely.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

