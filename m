Return-Path: <netdev+bounces-65216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA050839AD9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF91B29C64
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9077E2C1B7;
	Tue, 23 Jan 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="J45UVL1o"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF64E1BC
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043969; cv=none; b=mWFMmNW1FktGZFXfU00QkpTnMgVHzdBn4M3Gngs9dIjZREaHXgE/6VTq87HUSckYs7RixF5KBh4xeIUQ3luBmAswB+YpOGmX+09yYJHbOrEvTVTcrjzqp9eRRp6uO8E7jKant2n6Z68A4amMT+5nt5t7+PTPZ5V3RykJIZa5B2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043969; c=relaxed/simple;
	bh=wvda1L3RR/smUjSRPDsfcLiEuhGrOrqrle7idqMf9t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1Js5je9/iBQhrDxdW8VufXCkJqDqjlh3gAkZeMqHiHCXof/s2HsPjWuWriBgu7cit0ktng5P+kmUmVn2xXZ1OS3Byn5xZWyn1M9UEjG8SA81Sn8NWtIYo31uTwKYPgzUpp4mEgG3SJp44imvjECQiBToZugVgQYW0ZlzIDnNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=J45UVL1o; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oC+Xzu8aSBBLxTeOfbPxmslOua7SUo4gfiXATYXwkfg=; b=J45UVL1of3oS15/wI5Kdmn28wP
	7NPwZmDwM3ad0TQT+R6Kl9P6QMirgtMipu5fPDa6WhT2/UwIxx1ne/KkfmlSKDirr4Hd8WuTmok/y
	FMw4Q3uBOcg8QIoVKE8OzqN9r2whlaugsZJme1hEZSobD0kFllk/tmRuVVCUd3QyKoZhjx7d9rxyt
	Z5ShI6oUM7qT5YIGi8U1JcpH8BQ7eJBr6osb3Hzb1YneVqu746PUAsQ9kay+HAcICWTBM9GhJ5Gn0
	4x30bjcoNaX8RJ2CIwr/zI1Rt52PufU+PMTRmN1jdYXkmWxwe4NlGq0QTWfnHnBftRxNSIhd16w8y
	7KsPIptw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43142)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSNxu-00035u-1i;
	Tue, 23 Jan 2024 21:05:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSNxr-0002Fu-Qa; Tue, 23 Jan 2024 21:05:47 +0000
Date: Tue, 23 Jan 2024 21:05:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Landen.Chao@mediatek.com, UNGLinuxDriver@microchip.com,
	alexandre.belloni@bootlin.com, andrew@lunn.ch,
	angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
	claudiu.manoil@nxp.com, daniel@makrotopia.org, davem@davemloft.net,
	dqfext@gmail.com, edumazet@google.com, f.fainelli@gmail.com,
	hkallweit1@gmail.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
	sean.wang@mediatek.com
Subject: Re: [PATCH RFC net-next 03/14] net: phylink: add support for PCS
 link change notifications
Message-ID: <ZbAqK+RbuJZ6d4tK@shell.armlinux.org.uk>
References: <E1qChay-00Fmrf-9Y@rmk-PC.armlinux.org.uk>
 <75773076-39a2-49dd-9eb2-15a10955a60d@seco.com>
 <ZbAch9ZlbDrZqzpw@shell.armlinux.org.uk>
 <e3647618-b896-47a2-b9b9-c75b56813293@seco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3647618-b896-47a2-b9b9-c75b56813293@seco.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 03:33:57PM -0500, Sean Anderson wrote:
> On 1/23/24 15:07, Russell King (Oracle) wrote:
> > On Tue, Jan 23, 2024 at 02:46:15PM -0500, Sean Anderson wrote:
> >> Hi Russell,
> >> 
> >> Does there need to be any locking when calling phylink_pcs_change? I
> >> noticed that you call it from threaded IRQ context in [1]. Can that race
> >> with phylink_major_config?
> > 
> > What kind of scenario are you thinking may require locking?
> 
> Can't we at least get a spurious bounce? E.g.
> 
> pcs_major_config()
>   pcs_disable(old_pcs) /* masks IRQ */
>   old_pcs->phylink = NULL;
>   new_pcs->phylink = pl;
>   ...
>   pcs_enable(new_pcs) /* unmasks IRQ */
>   ...
> 
> pcs_handle_irq(new_pcs) /* Link up IRQ */
>   phylink_pcs_change(new_pcs, true)
>     phylink_run_resolve(pl)
> 
> phylink_resolve(pl)
>   /* Link up */

By this time, old_pcs->phylink has been set to NULL as you mentioned
above.

> pcs_handle_irq(old_pcs) /* Link down IRQ (pending from before pcs_disable) */
>   phylink_pcs_change(old_pcs, false)
>     phylink_run_resolve(pl) /* Doesn't see the NULL */

So here, phylink_pcs_change(old_pcs, ...) will read old_pcs->phylink and
find that it's NULL, and do nothing.

> > I guess the possibility would be if pcs->phylink changes and the
> > compiler reads it multiple times - READ_ONCE() should solve that.
> > 
> > However, in terms of the mechanics, there's no race.
> > 
> > During the initial bringup, the resolve worker isn't started until
> > after phylink_major_config() has completed (it's started at
> > phylink_enable_and_run_resolve().) So, if phylink_pcs_change()
> > gets called while in phylink_major_config() there, it'll see
> > that pl->phylink_disable_state is non-zero, and won't queue the
> > work.
> > 
> > The next one is within the worker itself - and there can only
> > be one instance of the worker running in totality. So, if
> > phylink_pcs_change() gets called while phylink_major_config() is
> > running from this path, the only thing it'll do is re-schedule
> > the resolve worker to run another iteration which is harmless
> > (whether or not the PCS is still current.)
> > 
> > The last case is phylink_ethtool_ksettings_set(). This runs under
> > the state_mutex, which locks out the resolve worker (since it also
> > takes that mutex).
> > 
> > So calling phylink_pcs_change() should be pretty harmless _unless_
> > the compiler re-reads pcs->phylink multiple times inside
> > phylink_pcs_change(), which I suppose with modern compilers is
> > possible. Hence my suggestion above about READ_ONCE() for that.
> > 
> > Have you encountered an OOPS because pcs->phylink has become NULL?
> > Or have you spotted another issue?
> 
> I was looking at extending this code, and I was wondering if I needed
> to e.g. take RTNL first. Thanks for the quick response.

Note that phylink_mac_change() gets called in irq context, so this
stuff can't take any mutexes or the rtnl. It is also intended that
phylink_pcs_change() is similarly callable in irq context.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

