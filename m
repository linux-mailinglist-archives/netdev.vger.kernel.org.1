Return-Path: <netdev+bounces-106432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97991651A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4902811B0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1D14901A;
	Tue, 25 Jun 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZEEnlRxX"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B34A147C91
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310751; cv=none; b=Bvq97Y79KvpHbB9WSH2waajWINAddpQznL4Fy5r5czSDe32L2vcdNNSu9IneJobhiTxikGNsxoZGh4BItUKi8GY+oa7RbFTL4f/FojWW6sF05TE9gPQCwQHZ1Fc0+Td66Zh5TA7E6Uq5b7Y1Ol4ddYbh948B8aLOEKTjm4BZ6to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310751; c=relaxed/simple;
	bh=lvbzCgywKfGRD0Gvou9fB1+z1Y6oaBNyl00KAfQAtnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQdbkBLo8oa28YNZJGXHmeaUl5AJdi6WehucXfsKIe5Em45XZhOEtP/OKgosUoOuhhrHlZjkofdNYUc9c6U9MCVgTZaOTRZOfIEHmK2+SUtFCdP8sbBmKtAUFsjMuNyC+YysM+HrzR1r5ajS5GmEHxCxhceFY8+XWvVKxE62bCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZEEnlRxX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lkJcYvAVm8LlTM92R7i1SdcjRsL/2F96VQdpcXdghNo=; b=ZEEnlRxXt98hodjiqJnn49rHPy
	6UagbUzklqm3smbXvuLdTfHfVlRKXktdZPh2GI+sDoB8YS/+KWiw1wnVrC8TyAwJqbA9bkAzzrVOx
	CLGkUDvTCNq4x7r3lQmjJNTVSt/hZgQiZKB1pJhaoKxshEO1MMUW2+VNP/o7enr8xkoR1iX0DIS+r
	cDB4v+CMptLWKnbGJx0CwSur2riMCtVDoREGD1fcflekvmEBQgncrZ0MpIHrqkwyAmYXDaBPnIERd
	zRQv3Kzc7OZqnQyedClRQ9pwXqlO3dJGACF1r3O0FhY3YW66p4kIQiKshiBVL9AL4taxbTqJGL2dF
	lBjdLI2Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39496)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sM3GH-0000Jl-0N;
	Tue, 25 Jun 2024 11:18:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sM3GI-0003hy-Bo; Tue, 25 Jun 2024 11:18:54 +0100
Date: Tue, 25 Jun 2024 11:18:54 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v12 7/7] net: tn40xx: add phylink support
Message-ID: <ZnqZjpeQCTEOJRfq@shell.armlinux.org.uk>
References: <20240623235507.108147-1-fujita.tomonori@gmail.com>
 <20240623235507.108147-8-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623235507.108147-8-fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 24, 2024 at 08:55:07AM +0900, FUJITA Tomonori wrote:
> This patch adds supports for multiple PHY hardware with phylink. The
> adapters with TN40xx chips use multiple PHY hardware; AMCC QT2025, TI
> TLK10232, Aqrate AQR105, and Marvell 88X3120, 88X3310, and MV88E2010.
> 
> For now, the PCI ID table of this driver enables adapters using only
> QT2025 PHY. I've tested this driver and the QT2025 PHY driver (SFP+
> 10G SR) with Edimax EN-9320 10G adapter.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

