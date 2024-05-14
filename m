Return-Path: <netdev+bounces-96359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D58C5698
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA4A1F2259F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E2143724;
	Tue, 14 May 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kqcd9f34"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63714199C;
	Tue, 14 May 2024 13:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692156; cv=none; b=Ue4g6StQo7qdXmJa/IqKpSxMucMPKlGoJDJkl5ddCz7z16AOk6Ak6bomFl8nsWLBJBJWfrP0QLRauMo1ws3YW9z86XmfVPbI0cMFHpRx37h3//r8G/8X1bQrcPS13miM9e3PJPgP2tDSHq+AdPbuOkq1Q3DZQ8klH1390HGpD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692156; c=relaxed/simple;
	bh=IMciIs02jZfJJNuVLxbbibqMHxlWWQB7g6LZ+KmsTbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9thy9pKO7LwhwP+ueUkkmSDBYyJaEmJ1dd/OCeO/EImCPINfaGr53+L7NvIShSNe8VV0O5SLXwVgi3tkblMxinb3k0IyHqgaKn0/3tiqVzYg8oE992aq4iUEygTnByZvtI7UGctH0t4hVSR8lFIU5awl2fXWVwxOoCPgzgU1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kqcd9f34; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qawFOO1lYL5ztdc7toCwvMFh7tarh+OmXydhWJWRKUk=; b=kqcd9f34BPPW8ZPHox5dB35Jxj
	G7xketqHAI0NXcl1aFE7G8SHbe6nkEIfQl3+TxFxHYrnNh0Wa2G97z8ivFKE0mZXhy/1CY/CFUsTA
	TGnPNmGV7x0ahYOhg4IVkwVJ5P2rZTpw1UZ98YK/UK9VJ5YSP28UJxSjMtESSgk3Vxz4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s6rtr-00FOB2-Va; Tue, 14 May 2024 15:08:59 +0200
Date: Tue, 14 May 2024 15:08:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	MD Danish Anwar <danishanwar@ti.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
Message-ID: <16f79b3f-0b33-4196-858a-b1469ed1200b@lunn.ch>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de>
 <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de>

> +/* FX_CTRL bits */
> +#define DP83869_CTRL0_SPEED_SEL_MSB		BIT(6)
> +#define DP83869_CTRL0_DUPLEX_MODE		BIT(8)
> +#define DP83869_CTRL0_RESTART_AN		BIT(9)
> +#define DP83869_CTRL0_ISOLATE			BIT(10)
> +#define DP83869_CTRL0_PWRDN			BIT(11)
> +#define DP83869_CTRL0_ANEG_EN			BIT(12)
> +#define DP83869_CTRL0_SPEED_SEL_LSB		BIT(13)
> +#define DP83869_CTRL0_LOOPBACK			BIT(14)

This looks like a standard BMCR. Please just use defines from mii.h,
since they are well known.

> +/* FX_STS bits */
> +#define DP83869_STTS_LINK_STATUS		BIT(2)
> +#define DP83869_STTS_ANEG_COMPLETE		BIT(5)

And these are standard BMCR bits.

> +
> +/* FX_ANADV bits */
> +#define DP83869_BP_FULL_DUPLEX			BIT(5)
> +#define DP83869_BP_HALF_DUPLEX			BIT(6)
> +#define DP83869_BP_PAUSE			BIT(7)
> +#define DP83869_BP_ASYMMETRIC_PAUSE		BIT(8)

ADVERTISE_1000XPSE_ASYN, ADVERTISE_1000XPAUSE, ...

Please go through all these defines and see what match to existing
ones.

	Andrew

