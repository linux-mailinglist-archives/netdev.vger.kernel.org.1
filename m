Return-Path: <netdev+bounces-127699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937529761D2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06CC2B21520
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5A18BC22;
	Thu, 12 Sep 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ul9Ctz7n"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557018BBBC;
	Thu, 12 Sep 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123834; cv=none; b=oC7YWs9dGqsGgWGW0/svOgyr60IFcmkcj1ETk9KcCuqnQaree91vQMahGGgyNZFBWLHV3oJ50eTxgPoXkM/uHg63xfgAWnr0otzTcfSqbTfZQpHjKrpm/nhsEFZTrJ8nMf0c/GrKM7E//W1D3fpRrWnb2MsfVgtK60Zo6Ugjk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123834; c=relaxed/simple;
	bh=EBxemKti4xJ8vmNgq76QSfaB4SSu/PnBKc2/y5ixnTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgLIDNl/etEvpZCRnsErn03eRuu5fBFwYqlp3xnQC4VSu4VQoa/v/U+mS/ovsOVAHbZEloDgcf6k2p5QlxVGBRRXqIsDDbq7HpJu1wO/CBgfAQW55C2+WWAId3hprYfW9h7VgPRDF7EQofIIBbA2IIj4pserwiu2iHqEh7BVP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ul9Ctz7n; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726123832; x=1757659832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EBxemKti4xJ8vmNgq76QSfaB4SSu/PnBKc2/y5ixnTo=;
  b=ul9Ctz7nBBySkVrOs6xlVe+/PYam0VWInPJ2iAi0/0oUACof54s5Wgv0
   LTQEHXh7id5cHpMGK/RXy8Mh0jUfWFe8nlfq976nVzIi45US7Pc/o7zKw
   ivPFCgroyKhpE8Vo9C/sXvSe+RnMZq62Wx5DWENSHfg0mX/p/V0JAPhI9
   /yUE8iVp+vJbMr9qNYuFOTmavucjWeVwyynqnDD+sV9tt/9tKgDsl/glw
   6a8HhtQVkdz5Xsa+1Y2+Nmkqf8VH7Y6d84rQCjs6VMHYjs0HQ3LCSRur+
   +fiGK3uGlaymlDkdKRY8aZyVKnDKZedkjYsAWqnKwH5SZLxVlYAMN7rrh
   g==;
X-CSE-ConnectionGUID: wr6MJFrmSWapl9D4DJKCyw==
X-CSE-MsgGUID: 4dzz1YawRqybKms59QTE+w==
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="31685584"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 23:50:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 23:50:00 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 11 Sep 2024 23:50:00 -0700
Date: Thu, 12 Sep 2024 12:16:10 +0530
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<rdunlap@infradead.org>, <andrew@lunn.ch>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <ZuKOMjMWUf5d9mL8@HYD-DK-UNGSW21.microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <20240911192425.428db5ac@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240911192425.428db5ac@fedora.home>

Hi Maxime,

Thank you for review the patches.

The 09/11/2024 19:24, Maxime Chevallier wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Hello Raju,
> 
> On Wed, 11 Sep 2024 21:40:53 +0530
> Raju Lakkaraju <Raju.Lakkaraju@microchip.com> wrote:
> 
> [...]
> 
> > @@ -3820,9 +3869,28 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
> >       ret = mdiobus_register(adapter->mdiobus);
> >       if (ret < 0)
> >               goto return_error;
> > +
> > +     if (adapter->is_sfp_support_en) {
> > +             if (!adapter->phy_interface)
> > +                     lan743x_phy_interface_select(adapter);
> > +
> > +             xpcs = xpcs_create_mdiodev(adapter->mdiobus, 0,
> > +                                        adapter->phy_interface);
> > +             if (IS_ERR(xpcs)) {
> > +                     netdev_err(adapter->netdev, "failed to create xpcs\n");
> > +                     ret = PTR_ERR(xpcs);
> > +                     goto err_destroy_xpcs;
> > +             }
> > +             adapter->xpcs = xpcs;
> > +     }
> > +
> >       return 0;
> >
> > +err_destroy_xpcs:
> > +     xpcs_destroy(xpcs);
> 
> It looks like here, you're destroying the xpcs only when the xpcs
> couln't be created in the first place, so no need to destroy it :)

Ok. I will remove

But i was little bit confusion here.

In xpcs_create_mdiodev( ) function, inside the mdio_device_create( ) function 
allocate memory for mdio_device

Then, in xpcs_create( ) function to create data by calling xpcs_create_data( )
function, create dw_xpcs memory.

It's reason, for safe side, I updte xpcs destroy

> 
> Best regards,
> 
> Maxime

-- 
Thanks,                                                                         
Raju

