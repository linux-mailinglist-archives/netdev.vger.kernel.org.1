Return-Path: <netdev+bounces-208780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96957B0D1B8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCAF7AF599
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B870628D8F5;
	Tue, 22 Jul 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yCLhT4SP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F046BF;
	Tue, 22 Jul 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164795; cv=none; b=Mu0GbJ+i7oKwlJRsyjBn2UEKyMiSc5Hf9ecVQ6zQPMbMPMZmVip+8a1ytP9ib4Eb0TEnhyPyOqox9KlxEb0P00z89LeWAgraE9fOYv7nDVWfWrpbWlsheN1HyMzdI6lKy0H056cgKu1+NW/HkqTnfMuRejs4UQxsl11CujxXE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164795; c=relaxed/simple;
	bh=pKASJsnRlQHlT0s8OZjmjuOTAThIXbH+iclDQTvSs74=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ9Ryi0PA7yByqvQCYSHrJu+QkRW8MZanB8fYHwk7gsCA8m1Oat7W2Z+0z8T51QFuwEU0pLCsSnwQaUhGgQDIKdtWjr+H2jnefS+RroLOClSmT8bNZLZQUil+dIMhCnMp23b14d6vrbWFRIBXN7fCnWvKXvmfyQbMgMEj6UXFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yCLhT4SP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753164793; x=1784700793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pKASJsnRlQHlT0s8OZjmjuOTAThIXbH+iclDQTvSs74=;
  b=yCLhT4SPzm3mME37eekTKONPQVqyfXHQyU8s/olT8K8Jqbcsln6AkhCI
   sNYmpmWTGgdNBNedLgEABc0lLxdF31FLECO9gXv2rVF1JIgAgfTDBbYaN
   MpiDiJp+qER1VRXwW4z+11hZcWVtpc0PMmHleWwo0H5YZ+8sB5YUOdOSb
   KLVcnf2sqVmYL3LUu5WyFLTD/kGkiGhBRPeLHkYQrIwX6PEOQjRynMoGs
   WT79xWb5fiF0V+KOgtoVuec0cm1Z5UcMveVdwyBJ9NTj8psU6Y0jq+5FI
   KsVxj6gLv0zJM9c+sj3ZYr4CBmULadEh6FNH0vOm8n++hbI5Uuj0CSCsM
   A==;
X-CSE-ConnectionGUID: dZXh1W5OQuqgFbGgCs4DCg==
X-CSE-MsgGUID: 4l3NpAzISVCH/xkMP0ecYQ==
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43736235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 23:13:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 21 Jul 2025 23:12:44 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 21 Jul 2025 23:12:44 -0700
Date: Tue, 22 Jul 2025 08:09:54 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<o.rempel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <20250722060954.ecaxrk7vq5ibuy55@DEN-DL-M31836.microchip.com>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
 <4dd62a56-517a-4011-8a13-95f6c9ad2198@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <4dd62a56-517a-4011-8a13-95f6c9ad2198@lunn.ch>

The 07/21/2025 16:22, Andrew Lunn wrote:

Hi Andrew,

> 
> > +static struct lan8842_hw_stat lan8842_hw_stats[] = {
> > +     { "phy_rx_correct_count", 2, 3, {88, 61, 60}},
> > +     { "phy_rx_crc_count", 2, 2, {63, 62}},
> > +     { "phy_tx_correct_count", 2, 3, {89, 85, 84}},
> > +     { "phy_tx_crc_count", 2, 2, {87, 86}},
> > +};
> 
> Hi Horatiu
> 
> Please could you look at using ethtool_phy_stats via the
> .get_phy_stats() phy driver op.

Yes, definetly I will update this in the next version.

> 
> > +static int lan8842_config_init(struct phy_device *phydev)
> > +{
> > +     int val;
> > +     int ret;
> > +
> > +     /* Reset the PHY */
> > +     val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);
> > +     if (val < 0)
> > +             return val;
> > +     val |= LAN8814_QSGMII_SOFT_RESET_BIT;
> > +     lanphy_write_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET, val);
> 
> It looks like there are sufficient pairs of
> lanphy_read_page_reg()/lanphy_write_page_reg() you would be justified
> adding a lanphy_modify_page_reg().

I agree, I can do that.

> 
> > +}, {
> > +     .phy_id         = PHY_ID_LAN8842,
> > +     .phy_id_mask    = MICREL_PHY_ID_MASK,
> 
> I think you could use PHY_ID_MATCH_MODEL() here.  It would make it
> different to every other PHY, but maybe you could start with some
> cleanup patches, adding the _modify_ call etc?

Yes, I will use PHY_ID_MATCH_MODEL().
I was thinking to start with 2 cleanup patches, one to use
PHY_ID_MATCH_MODEL in the driver and one to introduce
lanphy_modify_page_reg and put it to use.
Do you have other suggestions?

> 
>         Andrew

-- 
/Horatiu

