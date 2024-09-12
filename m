Return-Path: <netdev+bounces-127938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E298A977164
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D39D1F24F6C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F21C6885;
	Thu, 12 Sep 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HWDc5OSk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0A1C172E
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168551; cv=none; b=Ag84KA+G/l2yU56RdIlAwqkuFs3r4F9xHh812FxfhD+yYLNJFDVKWGsn6sLISWxx60c96oiw67P53VaXNMiQXhBWF2Szyp/WHLXlr8CioOboxUHlp2ApHPXo2utHZxEePcDfcflw4tdIWxnH4emOzlyvJx75KJk8rqEoFbWX2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168551; c=relaxed/simple;
	bh=c4P6Zht+tk/DDCDZ39O83sTDtwxcfWCo3dafG9zyFM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXVaOlNhhjTLLJb0RliwUVo3aJy/Oyu9P268pPcQc7A2Z5kOsiR/1ZwJXNBTLGDYkhR1Q/rt6ju+t5/rqAeshvaM5PFwiZMO9TDqa56xSGuc2nRhspcc/h5CdiDZWOrqo2kRjMq08jbg+L7edw4DhSuxPBCvOTcUuhEbq9wfZXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HWDc5OSk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vr+ogoHeav16ENlWR4Ydb811vRMHUoqPLeOIpZlekXQ=; b=HWDc5OSkZF49ixYreNr8eefV7p
	Boa+9QyEK14Y3+ZEutOefW3dTkc8PW0fmBQCq4S2Y0SsR591mGec6p3Ygoe2kFepOReDSyN8Fxtbp
	tWKuT54GV0bbe+7KXD4rm52s807ebqw5XegTO9FGGDGU32fp0QQhCRzaaTXXaeqKQ9C4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sopIB-007Ku7-Aw; Thu, 12 Sep 2024 21:15:47 +0200
Date: Thu, 12 Sep 2024 21:15:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/5] net: phy: aquantia: search for
 firmware-name in fwnode
Message-ID: <0d5a5cbb-c13f-4354-a48a-d20cb5a2def3@lunn.ch>
References: <trinity-da86cb70-f227-403a-be94-6e6a3fd0a0ca-1726082854312@3c-app-gmx-bs04>
 <0f811481-0976-4aec-a000-417d8b0a2a98@lunn.ch>
 <1ebc6d0d-6eca-4c99-be1a-3fbfa524ac71@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ebc6d0d-6eca-4c99-be1a-3fbfa524ac71@gmx.net>

> device_property_read_string() would would be very elegant, but it only
> looks for properties in the swnode of this device.
> However, I did not find a way to add a swnode directly to the phy, but
> only to the mdiobus.

Think about the DT representation, taken from marvell,aquantia.yaml.

    mdio {
        #address-cells = <1>;
        #size-cells = <0>;

        ethernet-phy@0 {
            compatible = "ethernet-phy-id31c3.1c12",
                         "ethernet-phy-ieee802.3-c45";

            reg = <0>;
            firmware-name = "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776_VER1630.cld";
        };

        ethernet-phy@1 {
            compatible = "ethernet-phy-id31c3.1c12",
                         "ethernet-phy-ieee802.3-c45";

            reg = <1>;
            nvmem-cells = <&aqr_fw>;
            nvmem-cell-names = "firmware";
        };
    };

You want to construct the same. Do you know the address on the bus the
PHY uses? Can you create a ethernet-phy@X node? And then put the
property there?

Then there is the question of if the current code associates the
swnode to the PHY device. I've no idea if it does! If not, it might
mean we need to add a device_set_node(&mdiodev->dev, fwnode) somewhere
in the core code.

       Andrew

