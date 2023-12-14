Return-Path: <netdev+bounces-57579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91794813751
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7BA1F210E1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3D463DE2;
	Thu, 14 Dec 2023 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="frk4Dncz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F29114;
	Thu, 14 Dec 2023 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ugFB1vBKVW+nDdvfwJiPPX7fgDivYw5u4az0IoQczq4=; b=frk4DnczFWbtesoE20GmeIo/VL
	Y9yr1aTI8RXlJaHXybkDTnXnD2SnpKUumSNlR6HzaHyNbHuzuKnC0YVIsn8TEPor2nc0L9JBinvEf
	Z7GtRcTCc5fJCDrPlkiCMJ+bSYqfmlwKRG3L7iO8iGbJFZ0cQ9Fj9oKP2wOapkruhq2W/5pP34jeM
	QREsOn+5C8366EnOkmKBzp53gdHTqXC2I3v7hpnx6OVZXPkLOV+7cDhaVTt1bvxmRHZ8/guR2TLJv
	s44yCr8m8AWNtAm0WdsqTR+ZmKif+EdAsxwfPtytVEhLDzkjbA69lsGcBuWHP7SF/KYH5dz4qwsHa
	pqw3eQKg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50230)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rDpAk-0001jY-0t;
	Thu, 14 Dec 2023 17:06:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rDpAl-0002i0-Nq; Thu, 14 Dec 2023 17:06:55 +0000
Date: Thu, 14 Dec 2023 17:06:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v7 4/4] net: phy: add support for PHY package
 MMD read/write
Message-ID: <ZXs2L0zfMaXTf+Ls@shell.armlinux.org.uk>
References: <20231214121026.4340-1-ansuelsmth@gmail.com>
 <20231214121026.4340-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214121026.4340-5-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 14, 2023 at 01:10:26PM +0100, Christian Marangi wrote:
> Some PHY in PHY package may require to read/write MMD regs to correctly
> configure the PHY package.
> 
> Add support for these additional required function in both lock and no
> lock variant.
> 
> It's assumed that the entire PHY package is either C22 or C45. We use
> C22 or C45 way of writing/reading to mmd regs based on the passed phydev
> whether it's C22 or C45.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v7:
> - Change addr to u8
> Changes v6:
> - Fix copy paste error for kdoc
> Changes v5:
> - Improve function description
> Changes v4:
> - Drop function comments in header file
> Changes v3:
> - Move in phy-core.c from phy.h
> - Base c45 from phydev
> Changes v2:
> - Rework to use newly introduced helper
> - Add common check for regnum and devad
> 
>  drivers/net/phy/phy-core.c | 144 +++++++++++++++++++++++++++++++++++++
>  include/linux/phy.h        |  16 +++++
>  2 files changed, 160 insertions(+)
> 
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index b729ac8b2640..7af935c6abe5 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -650,6 +650,150 @@ int phy_write_mmd(struct phy_device *phydev, int devad, u32 regnum, u16 val)
>  }
>  EXPORT_SYMBOL(phy_write_mmd);
>  
> +/**
> + * __phy_package_read_mmd - read MMD reg relative to PHY package base addr
> + * @phydev: The phy_device struct
> + * @addr_offset: The offset to be added to PHY package base_addr
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + *
> + * Convenience helper for reading a register of an MMD on a given PHY
> + * using the PHY package base address. The base address is added to
> + * the addr_offset value.
> + *
> + * Same calling rules as for __phy_read();
> + *
> + * NOTE: It's assumed that the entire PHY package is either C22 or C45.
> + */
> +int __phy_package_read_mmd(struct phy_device *phydev,
> +			   unsigned int addr_offset, int devad,
> +			   u32 regnum)
> +{
> +	struct phy_package_shared *shared = phydev->shared;
> +	u8 addr = shared->base_addr + addr_offset;
> +
> +	if (addr >= PHY_MAX_ADDR)
> +		return -EIO;

The helper I mentioned in the previous patch (whether or not we do the
rest of the range checks) would probably be a good idea to get away from
the repetitive nature of this logic. This patch adds four more!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

