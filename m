Return-Path: <netdev+bounces-101536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF0F8FF4A4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694ECB244A9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA819A287;
	Thu,  6 Jun 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="P3p84HvM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C781993B6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698498; cv=none; b=Rts9GPhD7PbxbGEMmKNHeXTm/fIpZ6bIue7BKsUCAcZxGS2H6niiDlPp6UctJlfsEByFW4yTqO4YZx10OHAH7mEZMKdv6QJlJaC0L7UmOnXkmk29Wg9X9MPjxko+aKSlRmWPERffMaZvYWLjSuTX4aAqxsPQ+g3Ppu75EMjEITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698498; c=relaxed/simple;
	bh=UVM6VFOZv7lPN78CMq1Zq+5I3YSli6AaF8emodeIRO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5VsBeFgGimT4lHo36FSX4/AZ4vuZiqWRe0V5j8yX5oDOjJ+ncth6QGwaltithjXyxZeNm7JZK8ysjFDkRHvfcT5MKuDttRvBWGjLS+3R9jFlC9DyTnoUA+P1WMuxDayjtOT3c0BGNBQcBsRYpqy4p0XWtkWDIiZ8yo9SQAsilY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=P3p84HvM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o7ND3h/LzeZsuGG055zHA6rQdJQsfVYiMKbUIbgJOHQ=; b=P3p84HvMHHAiyWhxzNW6UZjUes
	usHF09k+UADRTiXitAuHI5wU3MG8LIMutirk4oaxzqv3xlKliGZMzblmJrN0hDleeKyIs4tXT+eWm
	BAXO7E0ow8CTGjVGEuKqHfxWDVCJcsowABAd1NJZqBbTG9BtoAi9FwzvNDNfGsZ0XpdMg9IHVwkzA
	nfTyJdMTiYkqWzyd0y3bUiXSGl5y+aBTmUXr2GGLQc9pqNJaGN2isoxd5mR3k7Sgxb7ACLTi4suVX
	9yMGRPU+Ddj12nd8cm2Muv0sTm29kyLlWqjQM4iYMlVHAguqvGD609CuI2lkBV87PkIEZm0N+NJE8
	3WJSfb4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43750)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sFHq6-0006gr-1j;
	Thu, 06 Jun 2024 19:27:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sFHq4-0003Pa-Em; Thu, 06 Jun 2024 19:27:52 +0100
Date: Thu, 6 Jun 2024 19:27:52 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org, guyinggang@loongson.cn,
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 00/15] stmmac: Add Loongson platform support
Message-ID: <ZmH/qN6lKGA/tGTW@shell.armlinux.org.uk>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 29, 2024 at 06:17:22PM +0800, Yanteng Si wrote:
>  3. Our priv->dma_cap.pcs is false, so let's use PHY_INTERFACE_MODE_NA;

Useful to note.

>  4. Our GMAC does not support Delay, so let's use PHY_INTERFACE_MODE_RGMII_ID,
>     the current dts is wrong, a fix patch will be sent to the LoongArch list
>     later.

RGMII requires a delay somewhere in the system, and there are three
options: at the MAC, in the board traces, or at the PHY. The
PHY_INTERFACE_MODE_RGMII* passed to the PHY determines what delays the
PHY uses, and thus what the GMAC uses has no bearing on this - if the
board traces are adding the required delay, then
PHY_INTERFACE_MODE_RGMII is sufficient.

If the board traces do not add the required delay, and the GMAC doesn't
add a delay, then it is necessary to add the delay at the PHY, so
using PHY_INTERFACE_MODE_RGMII_ID is appropriate.

It's all detailed in Documentation/networking/phy.rst

What isn't documented there (and arguably should be) is if the MAC
adjusts its delays according to the PHY interface mode, then the MAC
should pass PHY_INTERFACE_MODE_RGMII to the PHY _irrespective_ of
which _ID/_TXID/ _RXID has been selected by firmware (since we don't
want the PHY to be adding its own delays if they've already been taken
care of by the MAC.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

