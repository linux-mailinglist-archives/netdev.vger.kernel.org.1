Return-Path: <netdev+bounces-234579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA1C239E7
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 08:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B031A22F4E
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A283203A7;
	Fri, 31 Oct 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HrnEVODp"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29422D7D2E;
	Fri, 31 Oct 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897337; cv=none; b=IxLRIyUinKPEkfvNYr86Z5Siirw7YEmIyQHWtvURqB+V+Z3K7j4NN0xgESy/Z5WKN6xxmUJzKgwdEFMm1bjhBNp4NFFZzUBLPr/a+LAn5jkpLbJf7F28AAycOkuaOAJl4agLzRsI1PZoznPtuT8csBVNL3cuikJI+VmjjYZcdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897337; c=relaxed/simple;
	bh=tRaPSB02NSM670yRYpWQLUz0VyeuspHIKjpXseASx7A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I42Txv8533jAozLwsB8spgVFYL1POVJL8/aMlYMKUUtRFMk8pMSQ0LB0Y2caxbCZ+GBxuPkdmfng1HA2chV0bjM1gk2QHgzCK8OJiibkmN1JziNcDrtYVqs6cm/mMzgfJFQt1kaKTQVi6z3OgV+xCW9JBYg5Vzax1b5E/t2/QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HrnEVODp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761897336; x=1793433336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tRaPSB02NSM670yRYpWQLUz0VyeuspHIKjpXseASx7A=;
  b=HrnEVODpiGyj3qUEfP3RDLX9FWHGhK9FTo1RcGBJKS4JSvI9CbtEbt0F
   i/0wqJ1+A4NvxqVocvvuw0j327vWHLssjgtsJDLkBeW1SnHwGgNfjIZqk
   XHPFiXl8IYklyJxCy294DNiDVJAtQjjY1KYjTx96pqS797UvzNCcsbAqN
   zstwl2Q8vCQSbF9Syghcijrl1JuZ2sI/G9zx76uyVibQiQdIUFeniJAnI
   L6lza3H4dSzarQINkaL/7nf7esfWOAk5oMxTUgIDVDP5hF+2KYtENLJzT
   7i3RAeWFsySsrl3+APT9q6GJhXjD8T9T1PJ4SIKGxXt/2vBe9Pt49PC0t
   Q==;
X-CSE-ConnectionGUID: 14ruu4AOSFGGHKcwuzeuHA==
X-CSE-MsgGUID: WagJdeaGSMOTetzvcxJHhg==
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="48511970"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:55:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 31 Oct 2025 00:55:29 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 31 Oct 2025 00:55:29 -0700
Date: Fri, 31 Oct 2025 08:54:11 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3 1/2] net: phy: micrel: lan8842 errata
Message-ID: <20251031075411.kcxdfonu42wj5rjh@DEN-DL-M31836.microchip.com>
References: <20251030074941.611454-1-horatiu.vultur@microchip.com>
 <20251030074941.611454-2-horatiu.vultur@microchip.com>
 <aQM-9u6MQKN_t9fE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aQM-9u6MQKN_t9fE@shell.armlinux.org.uk>

The 10/30/2025 10:33, Russell King (Oracle) wrote:

Hi Russell,

> 
> On Thu, Oct 30, 2025 at 08:49:40AM +0100, Horatiu Vultur wrote:
> > +static int lan8842_erratas(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     /* Magjack center tapped ports */
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_3_ANEG_MDI,
> > +                                 LAN8814_POWER_MGMT_VAL1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX,
> > +                                 LAN8814_POWER_MGMT_VAL1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_5_10BT_MDI,
> > +                                 LAN8814_POWER_MGMT_VAL1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_6_10BT_MDIX,
> > +                                 LAN8814_POWER_MGMT_VAL1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN,
> > +                                 LAN8814_POWER_MGMT_VAL2);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_8_100BT_MDI,
> > +                                 LAN8814_POWER_MGMT_VAL3);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX,
> > +                                 LAN8814_POWER_MGMT_VAL3);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX,
> > +                                 LAN8814_POWER_MGMT_VAL4);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_11_100BT_MDIX,
> > +                                 LAN8814_POWER_MGMT_VAL5);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX,
> > +                                 LAN8814_POWER_MGMT_VAL5);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                 LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX,
> > +                                 LAN8814_POWER_MGMT_VAL4);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
> > +                                  LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
> > +                                  LAN8814_POWER_MGMT_VAL4);
> 
> This is a lot of repetition.
> 
> Is it worth storing the errata register information in a struct, and
> then using a loop to write these registers. Something like:
> 
> struct lanphy_reg_data {
>         int page;
>         u16 addr;
>         u16 val;
> ;
> 
> static const struct lanphy_reg_data short_centre_tap_errata[] = {
>         ...
> };
> 
> static int lanphy_write_reg_data(struct phy_device *phydev,
>                                  const struct lanphy_reg_data *data,
>                                  size_t num)
> {
>         int ret = 0;
> 
>         while (num--) {
>                 ret = lanphy_write_page_reg(phydev, data->page, data->addr,
>                                             data->val);
>                 if (ret)
>                         break;
>         }
> 
>         return 0;
> }
> 
> static int lan8842_erratas(struct phy_device *phydev)
> {
>         int ret;
> 
>         ret = lanphy_write_reg_data(phydev, short_centre_tap_errata,
>                                     ARRAY_SIZE(short_centre_tap_errata));
>         if (ret)
>                 return ret;
> 
>         return lanphy_write_reg_data(phydev, blah_errata,
>                                      ARRAY_SIZE(blah_errata));
> }
> 
> ?

That is a really good suggestion. I will do that in the next version.

> 
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
/Horatiu

