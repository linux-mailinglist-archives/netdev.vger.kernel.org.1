Return-Path: <netdev+bounces-238897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A694C60BE4
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D640A3B8585
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D422F772;
	Sat, 15 Nov 2025 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BDzXoDgB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470841946DF
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244085; cv=none; b=kTuOH85iuHsgs8OKc2x/ZlEzM58bCQUhv0Ip+/VDZTed1EufbOp/ospfj2JAQnlrlTV7NfMSs/Q4aqK26HXXKKWtFjngpVXJwXoCNfl+zidymSzjt79XwKa6jnsYaTwvM78YgOq+p0wKsZ31/Qz5h8sAjMfmUMbLLkjvYtuiM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244085; c=relaxed/simple;
	bh=L0QzxXXScFFksUmDT5PS01GwuhCqzKfxGDYffb7MB+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA0tadD+kkgcw3Aso6cTo3n5zXsVOptZJaLOlmwxtZ8VyzuiTLqd8+2ti1x0kBbywk7XnEzR+oSM7SOxSlyEMzUHiMyTxmOeqP68vFi3rKaxvoUj4g9fj2diH7azKl/L6TaEH8VcKrzN7D/UZz2hBwyhmkBgYYDqfC15TZmAOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BDzXoDgB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ywZ71KVSLDF6WWkYHUF7pGyKsWbTYCHAFW3+6QMRS80=; b=BDzXoDgBMlEt1OiD8c9SoZ5gmb
	kHD8BTKYir4hCBLMAaKZOIZXiWAe17hh3iAKxrzVHAqhc+wEQZ5HeJo28CcbgwxNFmWcUDllLV8CY
	rjuDGOZBiVP1cUejYScc9H5O1TJ8eE5EbqivBYbbkLwipfNydR1zKCCmfaIlia0BG0WLx0pVPSU6k
	Qoz81v2R8qbRvHiGLonxVhA4d68S+6JW8HKT6/+JaHwg7yN6cZBDaNhb9L09pbEG2/UelulFTJzFm
	4Na/PaVvnIIQeBpWQ7X4YTwSDCd0CW5XBRpyFDOeCAgy0P5Jpxl9oHLznl57UyC2Z6xdd/G2efpA/
	2XGxm98A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45496)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vKOKf-000000000My-0KcV;
	Sat, 15 Nov 2025 22:01:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vKOKd-0000000078y-2iig;
	Sat, 15 Nov 2025 22:01:19 +0000
Date: Sat, 15 Nov 2025 22:01:19 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Fabio Estevam <festevam@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, edumazet <edumazet@google.com>,
	netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
Message-ID: <aRj4L-BKoFeaJpWH@shell.armlinux.org.uk>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
 <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
 <CAOMZO5CbNEspuYTUVfMysNkzzMXgTZaRxCTKSXfT0=WmoK=i5Q@mail.gmail.com>
 <7082e2d0-a5a9-4b00-950f-dc513975af1c@gmail.com>
 <CAOMZO5CLvDMgxi+VUVgiTy=TsK75QMYrTYZDEOzY4Y7eN=CRMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CLvDMgxi+VUVgiTy=TsK75QMYrTYZDEOzY4Y7eN=CRMw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 15, 2025 at 06:54:08PM -0300, Fabio Estevam wrote:
> On Sat, Nov 15, 2025 at 6:26 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
> > smsc_phy_reset() does two things:
> > 1. set PHY to "all capable" mode if in power-down
> > 2. genphy_soft_reset()
> >
> > Again, as the genphy driver works fine for you, both parts should be optional.
> > Check with part is causing the packet loss.
> 
> It is the genphy_soft_reset() that causes the packet loss.
> 
> If I comment it out like this, there is no packet loss:
> 
> --- a/drivers/net/phy/smsc.c
> +++ b/drivers/net/phy/smsc.c
> @@ -149,8 +149,7 @@ static int smsc_phy_reset(struct phy_device *phydev)
>                 phy_write(phydev, MII_LAN83C185_SPECIAL_MODES, rc);
>         }
> 
> -       /* reset the phy */
> -       return genphy_soft_reset(phydev);
> +       return 0
>  }
> 

This is no proof. The two are not independent. See 3.7.2 of the LAN8720
datasheet. A change to the MODE[2:0] field requires a soft reset to
take effect.

Avoiding the soft reset just means effectively you've disabled the
effect of the write to MII_LAN83C185_SPECIAL_MODES. I don't see
anywhere else that the driver would set the RESET bit in BMCR, so
this write will never take effect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

