Return-Path: <netdev+bounces-225179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3CB8FBD3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E84518A024A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC99281530;
	Mon, 22 Sep 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jvcglCLl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAC27E048
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532972; cv=none; b=J28T6SdWCaEuKQj3Z8vp/rnwWzJls5JjT/xxbl6E9BQe3uzX52O4WiH+hmoLY6Xnw/Aoc6MyWPfREipibnrs9a147oyJbDhGEepYRgkvhVoq31ruHZeKsKH6lW7XcnqcB5sF7v7esKdgLIl1B4fiwuZ9M/dScOX8fpfKRO4FWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532972; c=relaxed/simple;
	bh=Cv+QcaRW1M/ScUfhQ3CopbH4/KPQKbZQwkLqjBhU4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE43wO/rqUL7q5NrCZIxS+JFL12hJ16qElFamHOIeRgDUUK2h+PFpOT5cZNkVYk8QuaiAwonmLerLh+Wd0EGmpr21fjz1E4Mlo4Sc6PHc4cT7SySBgAT5jM1qjjlvVRJnjcJqcnwNvZNAduEAH1XSYRTVb3MUpG5HDe3KgL0pm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jvcglCLl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5HMGUHuaoBUo3WMM8ho2knTNC4kjGpWNx/sxNL55sLs=; b=jvcglCLljHCF6fshn4vDk3z+e+
	USrjKZZeTxguDOMLMXYYGztmjJHvd0pqzkwll25odClz2Lxra9XihBrBPHCeQqqZFImY7V4K9ZGZa
	JiWyIfURPoPGMvKUyHEy+RVFZCtZaLaAXSwZeqGpPKZ2YTWBZK1DXAr6GVxUVTDxHqB1yFqrMcdEd
	oaANdeIgF8QIjek2hr7ongxfDx7x+JxDiTI6Mmsqi1QrUCOS/FUc/k5Ko82y8lLW4qAF3APF91Ybc
	ODNH3V6u9ijMXJ0To8FIz6uvo2SmaJWtEG1Upnrk7XMioKkDSuwipX8u4lyej0ET0oDjtWhf9AvOn
	zxiPQ5/A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v0ckq-000000004RG-3TXj;
	Mon, 22 Sep 2025 10:22:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v0ckp-000000004zo-2GMD;
	Mon, 22 Sep 2025 10:22:39 +0100
Date: Mon, 22 Sep 2025 10:22:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Zoo Moo <zoomoo100@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: Marvell 375 and Marvel 88E1514 Phy network problem: mvpp2 or DTS
 related?
Message-ID: <aNEVX9ew-5kPB22u@shell.armlinux.org.uk>
References: <wL97kjSJHOArswIoM2huzx9vV9M9uh0SoCZtDVYo-HJFeCwZXraoJ4kc0l1hkxt1XLsejTsRCRCkTqASpo98zAUyfmYoCfzGD3vkaThigVA=@proton.me>
 <aM_L1Hbind29q_Z_@shell.armlinux.org.uk>
 <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mgCCIJjGoUsB3nhQPO_r2E4X7JvDb5_40Aq9GVv5OoH6OXxsKCuO3lnlVSHj-zH00KV5AY66F4VE6bed9R5yu8SM_jNeBpdGDYAkBNq7hXA=@proton.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 22, 2025 at 08:58:49AM +0000, Zoo Moo wrote:
> Sent with Proton Mail secure email.
> 
> On Sunday, 21 September 2025 at 19:56, Russell King (Oracle) <linux@armlinux.org.uk> wrote:
> 
> > On Sun, Sep 21, 2025 at 09:05:18AM +0000, Zoo Moo wrote:
> > 
> 
> > > Hi,
> > > 
> 
> > > Bodhi from Doozan (https://forum.doozan.com) has been helping me try to get Debian to work on a Synology DS215j NAS. The DS215j is based on a Marvell Armada 375 (88F6720) and uses a Marvel 88E1514 PHY.
> > 
> 
> > 
> 
> > Probably wrong RGMII phy-mode. I see you're using rgmii-id. Maybe that
> > isn't correct. Just a guess based on the problems that RGMII normally
> > causes.
> 
> Hi Russell,
> 
> Thanks, we did try different drivers (gmii, sgmii), but they didn't help, details in this message https://forum.doozan.com/read.php?2,138851,139291#msg-139291.

What I was meaning was not to try stuff like "SGMII", but try the _other_
three flavours of RGMII. In other words:

	rgmii
	rgmii-txid
	rgmii-rxid

If u-boot works, and it's using RGMII, then it's definitely one of the
four flavours of RGMII interface.

No need to post the failures of the testing to the forums - just say
here whether any of those result in packet flow or not. Nothing else
should change - the only difference between these modes are the timings
of the RGMII interface, and having the wrong mode is the most common
reason for RGMII not working.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

