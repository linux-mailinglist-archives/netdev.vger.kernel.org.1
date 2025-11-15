Return-Path: <netdev+bounces-238856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB30C60433
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 12:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18DE4E2683
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7404429A9CD;
	Sat, 15 Nov 2025 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Sf7odPhe"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4E935CBB7;
	Sat, 15 Nov 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207217; cv=none; b=R93wh8zIgF+YaLzx4YCOTimlf9aYS8vnV1QlOt2QgRZxIvzUKuEvS2HRbwmTQaJPyDn1lx+ZScmdHVYCpLmGpG4rPEPfXN+v4PuQh95g7rv0/FO3jDAWJo6+PZq2hk2iFXLR8FCsG0YwpkgqeybSWPyFNwJKET3qasLfx/uo8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207217; c=relaxed/simple;
	bh=ifBTFXbo+mdIwhRyM4hFGuC/7YhMyELVxSTyy1UrOxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppk51hSAhjYfqkJYX2spxwNoJAjIneabfbG4RUh80BZeYUvsQ8L6POs4BuZ4sOoeqRp4NPHKWtIcqumWA/eWVO9xRMp02qNDHxAtwWxUUz/YIUKRWkSo0ovdLU5jpyYYMFswKjHQSxbnClJ5HoTLLZDGB1L+NMU/DZRuBCaaPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Sf7odPhe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E2F2525F18;
	Sat, 15 Nov 2025 12:46:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnpjLnXyXJYg; Sat, 15 Nov 2025 12:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763207210; bh=ifBTFXbo+mdIwhRyM4hFGuC/7YhMyELVxSTyy1UrOxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sf7odPheAjPyTd/T0HsALQvzOEm1fjJwtNHY2Ruu3r6cUFUKKmT/Sa8e16vMH9SHS
	 HREo4z1h/x5u1l0N8Z5uYVay6SS0Ie4agMEzRnrWRrPG/mYWOi8TuCEvc58TFAkMxj
	 cCz/OSummn7u7h4acDnw1ild2pyvZtD4nl72xd2HKmD+JmoaAGjAlKVSoe7uCXUgoD
	 /GaX1mIK7kax37IYB8vjba2jLn/FHwtpXv5qM/UCghj6OXEDD4QG+qqTBEgmyUgpsx
	 CjTCpYYRxKqhpx0AobM/KZcFztUh3//FlKCyFCxaUdWNBYe79gnzyn8T9P8RpKySwY
	 wavvX5bckfMiA==
Date: Sat, 15 Nov 2025 11:46:36 +0000
From: Yao Zi <ziyao@disroot.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Runhua He <hua@aosc.io>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH net-next v2 2/3] net: stmmac: Add glue driver for
 Motorcomm YT6801 ethernet controller
Message-ID: <aRhoHJioqvfT2tEv@pie>
References: <20251111105252.53487-1-ziyao@disroot.org>
 <20251111105252.53487-3-ziyao@disroot.org>
 <aRMs-B2KndX-JNks@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRMs-B2KndX-JNks@shell.armlinux.org.uk>

On Tue, Nov 11, 2025 at 12:32:56PM +0000, Russell King (Oracle) wrote:
> On Tue, Nov 11, 2025 at 10:52:51AM +0000, Yao Zi wrote:
> > +	plat->bus_id		= pci_dev_id(pdev);
> > +	plat->phy_addr		= -1;
> > +	plat->phy_interface	= PHY_INTERFACE_MODE_GMII;
> > +	plat->clk_csr		= STMMAC_CSR_20_35M;
> 
> Could you include a comment indicating what the stmmac clock rate
> actually is (the rate which is used to derive this divider) ? As
> this is PCI, I'm guessing it's 33MHz, which fits with your divider
> value.

The divider is taken from vendor driver, and the clock path isn't
mentioned in the datasheet, either. I don't think it's 33MHz since it's
a PCIe chip, and there's no 33MHz clock supplied by PCIe.

The datasheet[1] (Chinese website, requires login) mentions that the
controller requires a 25MHz external clock input/oscillator to function,

> 25MHz Crystal Input pin.
>
> If use external oscillator or clock from another device.
>   1. When connect an external 25MHz oscillator or clock from another
>   device to XTAL_O pin, XTAL_I must be shorted to GND.
>   2. When connect an external 25MHz oscillator or clock from another
>   device to XTAL_I pin, keep the XTAL_O floating.

25MHz fits in STMMAC_CSR_20_35M, too, so it's more likely the clock
source.

I don't think this guess could be confirmed without vendor's help,
should the information be included as comment?

Best regards,
Yao Zi

[1]: https://www.motor-comm.com/download?kw=&category=606&wd=1&tp=1

> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

