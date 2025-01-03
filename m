Return-Path: <netdev+bounces-154977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D7A00893
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3964F1884D39
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955321D61AC;
	Fri,  3 Jan 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk4Bm0kj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DB1527AC
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903557; cv=none; b=WsXXfkUEKS2Nfns/K9NfT6N93oymDIuqbuqM0sahslRTJZaE2cUuxIyAe+DJbP+HLJAi6eIlcOV+nCf19EwAj6d7VoB3W04QBku1VDgS4nTrK5UPrISqXEad1l5Gq6SWxiRK3kWGxlV1+dizLrWS320/7o2fLvq6KWkr02rIZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903557; c=relaxed/simple;
	bh=oU55qpf78huvCWNcQujIMaSnAxG6ieIaWjy9FTupk2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWc9Zv1VE/UnFSOUx/s9Zg54IT8TKTFmc9GAHWpemw6AmL0xgHQxreFWb3lbR5JfPoKesWEpxk6UaSKs2/lmlwVI6yHthPIwk6Ln1nRRo9JcPaamp0wJURF4HLB85pJ7hFND/tOq/MVvereeg7+JKPaUwmPahUaH/Xycn3wlQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk4Bm0kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F30C4CECE;
	Fri,  3 Jan 2025 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735903556;
	bh=oU55qpf78huvCWNcQujIMaSnAxG6ieIaWjy9FTupk2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rk4Bm0kjtCoWjzfk0N1vMzUwPwcvx72I1v6m2vSjRtf0ugGfvifSyIRtWsDijT4vj
	 ZLoZ259tCxbCyN0BEFoJdqA9X2zKH/iyaI7PQ4TQ4/BvoWsN0kp7C8vPD2wzMNecUW
	 h/4QtCEpy+h0JM7Uu/fLgrnpN6TuBTdeCQPQT0ZyjJ6ssk8+fqGiemLbzuGqrJERQ/
	 o4ZJ0gcvs3Q/pli5Jdf1ACNa2VuTqBHOYzPsZ4/bmjN2960vuu8S4CkCY15KFCRbnW
	 Ur/7aB73gGMKLGZoVdsqfRzMpUF7cNrxojAwIIfmZJUzve1aj1FN7oURNQ+t1Uhhcd
	 xjiucI4PQ+tkA==
Date: Fri, 3 Jan 2025 12:25:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Francesco Valla <francesco@valla.it>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <Z3fJQEVV4ACpvP3L@ryzen>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>

On Thu, Jan 02, 2025 at 02:52:18PM +0100, Andrew Lunn wrote:
> On Thu, Jan 02, 2025 at 02:26:58PM +0100, Francesco Valla wrote:
> > On Thursday, 2 January 2025 at 12:06:15 Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> > > On Thu, Jan 02, 2025 at 12:51:22AM +0100, Francesco Valla wrote:
> > > > Whenever a new PHY device is created, request_module() is called
> > > > unconditionally, without checking if a driver for the new PHY is already
> > > > available (either built-in or from a previous probe). This conflicts
> > > > with async probing of the underlying MDIO bus and always throws a
> > > > warning (because if a driver is loaded it _might_ cause a deadlock, if
> > > > in turn it calls async_synchronize_full()).
> > > 
> > > Why aren't any of the phylib maintainers seeing this warning? Where does
> > > the warning come from?
> > > 
> > 
> > I'm not sure. For me, it was pretty easy to trigger.
> 
> Please include the information how you triggered it into the commit
> message.
> 
> > This is expected, as request_module() is not meant to be called from an async
> > context:
> > 
> > https://lore.kernel.org/lkml/20130118221227.GG24579@htj.dyndns.org/
> > 
> > It should be noted that:
> >  - the davincio_mdio device is a child of the am65-cpsw-nuss device
> >  - the am65-cpsw-nuss driver is NOT marked with neither PROBE_PREFER_ASYNCHRONOUS
> >    nor PROBE_FORCE_SYNCHRONOUS and the behavior is being triggered specifying
> >    driver_async_probe=am65-cpsw-nuss on the command line.
> 
> So the phylib core is currently async probe incompatible. The whole
> module loading story is a bit shaky in phylib, so we need to be very
> careful with any changes, or you are going to break stuff, in
> interesting ways, with it first appearing to work, because the
> fallback genphy is used rather than the specific PHY driver, but then
> breaking when genphy is not sufficient.
> 
> Please think about this as a generic problem with async probe. Is this
> really specific to phylib? Should some or all of the solution to the
> problem be moved into the driver core? Could we maybe first try an
> async probe using the existing drivers, and then fall back to a sync
> probe which can load additional drivers?
> 
> One other question, how much speadup do you get with async probe of
> PHYs? Is it really worth the effort?
> 

I'm trying to enable async probe for my PCIe controller (pcie-dw-rockchip),
which on the radxa rock5b has a RTL8125 NIC connected to it.

By enabling async probe for the PCIe driver I get the same splat as Francesco.

Looking at the prints, it is trying to load a module for PHY ID: 0x1cc840
This PHY ID is defined in: drivers/net/phy/realtek.c.

Looking at my .config I have:
CONFIG_REALTEK_PHY=y

So this is not built as a module, so I am a bit surprised to see this
splat (since the driver is built as built-in).


I think it would be nice if the phylib core could be fixed so that
it does not try to load modules for drivers which are built as built-in.


Also see this old thread that tries to enable async probe by default on
DT systems:
https://lore.kernel.org/linux-kernel//d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com/T/#u

AFAICT, it seems that the phylib core is one of the biggest blockers from
being able to enable async probe by default on DT systems.


Kind regards,
Niklas

