Return-Path: <netdev+bounces-104784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 941D890E585
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E102B20DBD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8679B84;
	Wed, 19 Jun 2024 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l8+eKRfN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDC56448;
	Wed, 19 Jun 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785935; cv=none; b=nj7MESDHs4+D2y45cpg0J1vyvH8mLi7TqxCdLHoBDHhLoDVqlQ/ukNhUqEIYrxg1DsXrYFUZXJYuXPlXegzwQBb0xACmaJggx2S86TXZRD2835k4MBmAJdTz2luf+CbQ7bbymHGvGRYQT8UdpTq4RTu+oSH3DM2QNxm4aYn9Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785935; c=relaxed/simple;
	bh=6L3CLgqlPBPjLasxNnLwmXiP78gx+9LhlT39CmIA30k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mztcUrmSFqPIAigNgonl7lhq8W9uxd375/y9gZTW1s8VPj+EHBsVhLFNjyoA6fi7WJGQeSTPkr1LFDCRn6blhjmGYXuoMiHEaC6lAiVIe1VLe92vOw8BgHga1kWBCvu/77I51ep+vgsurDugDrpOeB7vYBPxO1l2JH97i/zo1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l8+eKRfN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R2yscDCF3+dfP4Cs8Q0wqLUEmaZApVG8aLFF5tCrBu0=; b=l8+eKRfNIsFXfp/wyZ3/k43Fll
	UNDwT6Xcx37V3IP7XEq0A2mnLZLe7Ki00Ay8C0YLUVFt4SjyYlb1gtwH2DDZ6ZlF8NSsaelTpalOe
	d0JmJZys/ARESp+k7XtoeVaNxRISbwI1gf9tOg75zt+8QmPXW5auJfxbGIy7q3T+7WUhzhENUC0mZ
	4qNom5NPKYWHSHEiz0G3y7V3KCF5wpFI6t7JvI5SrGhsRZ3to0SbBhU1M7To9be38P54WonUN9YCE
	s2jtXSIB/2t9mrAsjf936r3j8NGS200YJR40vm3VOTZicERw+4glf6dCDzVHUQkwq5oiIcS4kMohm
	WnLhmwrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48842)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sJqjM-0007zd-1N;
	Wed, 19 Jun 2024 09:31:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sJqjL-0006bp-Ee; Wed, 19 Jun 2024 09:31:47 +0100
Date: Wed, 19 Jun 2024 09:31:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v7 1/5] net: phy: mediatek: Re-organize MediaTek
 ethernet phy drivers
Message-ID: <ZnKXc/UglBxayJtv@shell.armlinux.org.uk>
References: <20240613104023.13044-1-SkyLake.Huang@mediatek.com>
 <20240613104023.13044-2-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613104023.13044-2-SkyLake.Huang@mediatek.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 06:40:19PM +0800, Sky Huang wrote:
> diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
> similarity index 99%
> rename from drivers/net/phy/mediatek-ge-soc.c
> rename to drivers/net/phy/mediatek/mtk-ge-soc.c
> index f4f9412..47af872 100644
> --- a/drivers/net/phy/mediatek-ge-soc.c
> +++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
> @@ -1415,7 +1415,7 @@ static int mt7988_phy_probe_shared(struct phy_device *phydev)
>  	 * LED_C and LED_D respectively. At the same time those pins are used to
>  	 * bootstrap configuration of the reference clock source (LED_A),
>  	 * DRAM DDRx16b x2/x1 (LED_B) and boot device (LED_C, LED_D).
> -	 * In practise this is done using a LED and a resistor pulling the pin
> +	 * In practice this is done using a LED and a resistor pulling the pin

If you are moving files around, there should be no extraneous changes
in the commit that is doing the move. This is a spelling fix, and that
should be a separate patch (and probably should be done as the first
patch.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

