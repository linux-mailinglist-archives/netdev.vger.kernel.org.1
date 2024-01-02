Return-Path: <netdev+bounces-60847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38B821ABB
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B8A283066
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B330DDC7;
	Tue,  2 Jan 2024 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rCqMkH39"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5ABDDC1
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wtaItKkAV4exyxbo9SwTenLlJvcvmQ32PQXv47kXwBA=; b=rCqMkH39r36M7Wv2jVt0MbKqqt
	tekxrJxJSxt3ii/ASmcWWzqFaGm08ZmKsUCfoHaq3qTfOeTn1o+6MpCH+60Ix4PRSb8s+gXKz7vEl
	syuU1mAMMFK7bDYeLtUzs3JLQ2TyodK6RqyKjSUEqHiqejwE15rn2wwU8TgGFKlsmHOz8zaeVBroV
	W5dVw0yjFm5EM3KPD85F6iIG8I8VfktnfU/taNyCv9Tc6TMeeGfNuJC2+8RAvVnNkwTQqzgvsy5JL
	/TUraZxbdRe4s7/zh9cWjWVorSpyFXht1RFxj5yG6cQObBxNURkGOmftRZK2RxAgmC5Rnu2Z4LXwp
	qAPL7cYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43306)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rKckb-0006SA-2u;
	Tue, 02 Jan 2024 11:16:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rKcke-0005EQ-HI; Tue, 02 Jan 2024 11:16:04 +0000
Date: Tue, 2 Jan 2024 11:16:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Willy Liu <willy.liu@realtek.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
	=?iso-8859-1?Q?Maximili=E1n?= Maliar <maximilian.maliar@nic.cz>
Subject: Re: [PATCH net-next 03/15] net: phy: realtek: rework MMD register
 access methods
Message-ID: <ZZPwdEgwCVaHdyZB@shell.armlinux.org.uk>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-4-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220155518.15692-4-kabel@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 20, 2023 at 04:55:06PM +0100, Marek Behún wrote:
> The .read_mmd() and .write_mmd() methods for rtlgen and rtl822x
> currently allow access to only 6 MMD registers, via a vendor specific
> mechanism (a paged read / write).
> 
> The PHY specification explains that MMD registers for MMDs 1 to 30 can
> be accessed via the clause 22 indirect mechanism through registers 13
> and 14, but this is not possible for MMD 31.
> 
> A Realtek contact explained that MMD 31 registers can be accessed by
> setting clause 22 page register (register 31):
>   page = mmd_reg >> 4
>   reg = 0x10 | ((mmd_reg & 0xf) >> 1)
> 
> This mechanism is currently used in the driver. For example the
> .read_mmd() method accesses the PCS.EEE_ABLE register by setting page
> to 0xa5c and accessing register 0x12. By the formulas above, this
> corresponds to MMD register 31.a5c4. The Realtek contact confirmed that
> the PCS.EEE_ABLE register (3.0014) is also available via MMD alias
> 31.a5c4, and this is also true for the other registers:
> 
>   register name   address   page.reg  alias
>   PCS.EEE_ABLE    3.0x0014  0xa5c.12  31.0xa5c4
>   PCS.EEE_ABLE2   3.0x0015  0xa6e.16  31.0xa6ec
>   AN.EEE_ADV      7.0x003c  0xa5d.10  31.0xa5d0
>   AN.EEE_LPABLE   7.0x003d  0xa5d.11  31.0xa5d2
>   AN.EEE_ADV2     7.0x003e  0xa6d.12  31.0xa6d4
>   AN.EEE_LPABLE2  7.0x003f  0xa6d.10  31.0xa6d0
> 
> Since the registers are also available at the true MMD addresses where
> they can be accessed via the indirect mechanism (via registers 13 and
> 14) we can rework the code to be more generic and allow access to all
> MMD registers.
> 
> Rework the .read_mmd() and .write_mmd() methods for rtlgen and rtl822x
> PHYs:
> - use direct clause 45 access if the MDIO bus supports it
> - use the indirect access via clause 22 registers 13 and 14 for MMDs
>   1 to 30
> - use the vendor specific method to access MMD 31 registers
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

