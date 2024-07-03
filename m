Return-Path: <netdev+bounces-109027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04F69268DB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB09B1C22038
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9A1822E0;
	Wed,  3 Jul 2024 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FKG/whSO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFD41A81
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033811; cv=none; b=T8w7vqOFN242ZpmYLwpW5H0So211ihPAarUcrAtVNoeL+9YUc9NvyU6a054YFIDrONuNwXS4k2xrmDxE4bzlTIynlbyvyEmyV2m5F4VlZGYU1FH2BDKbkhIIhyVLyhKqct2BbRO0a1OZVyZormQQSZM2Td0AfLPQFmIo+cO9lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033811; c=relaxed/simple;
	bh=3Jtth2Z5iq6FFWQ1ERqR7jOh95JUVLVdwQrrMDib2+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXOr5Mr327HQOZjkhtQkU/ZqdIHCfhpu2et1nZHyBStFfztbiMbxXj6Pd10YsOgps1TXcwWdkCmS2yC6jMbJ7Cj5CAD9ibU4ecFBBsMu85Lb1qardVMZllk1X0IJ2utAY1bLij4IZgNoRVaVePx5o1oN44As31SGi2679zDDtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FKG/whSO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=scCnbiYENQc9N93uIbyPuit3RJTpk8ZUKMyyqdGf5ms=; b=FKG/whSOTl+O+T/mrp03Nh+AS7
	tC89xCvA2YvQs1+tpI+ylUgIkoE5fQCsgclf8VR25hPaNYCBzWzRjtP6xCx0dxztYYXIBkagp18KG
	8/2jBRhUAz4l98IS9ObtAJIzAJwAXCEWGQr0XN4LpBpFeL7+gBaKkiXJYIzS1ZD2z0Lc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sP5MX-001lGB-AS; Wed, 03 Jul 2024 21:09:53 +0200
Date: Wed, 3 Jul 2024 21:09:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <eb4bed28-c04e-4098-b947-e9fc626ba478@lunn.ch>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
 <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
 <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>
 <hdqpsuq7n4aalav7jtzttfksw5ct36alowsc65e72armjt2h67@shph7z32rbc6>
 <ZoWex6T0QbRBmDFE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWex6T0QbRBmDFE@shell.armlinux.org.uk>

> Rather than erroring out, I think it may be better to just adopt
> the Marvell solution to this problem to give consistent behaviour
> across all PHYs.

Yes, expand phy_config_aneg() to look for this condition and enable
autoneg. But should we disable it when the condition is reverted? The
user swaps to 100Mbps forced?

What about other speeds? Is this limited to 1G? Since we have devices
without auto-neg for 2500BaseX i assume it is not an issue there.

	Andrew

