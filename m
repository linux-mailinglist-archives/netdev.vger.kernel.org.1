Return-Path: <netdev+bounces-70986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50F85179C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB3F1C2180F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A513C48D;
	Mon, 12 Feb 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lkif+SG5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BC3C06A;
	Mon, 12 Feb 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750432; cv=none; b=u/LOBevsmRRvAwbsTOnefqBx5ecjY9/A47XWN/yY/NwQulVsPnasFWx5drXuAJmrG2KEa6IprCIDcnOUSWJDgCWaZJlO7gkUDlU8in7diHsWZEJvIcCNISrtObuJic6zOLwO11aoLk9ZHqgHXSlQrX1jL77DeTs+WvKE8w/dqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750432; c=relaxed/simple;
	bh=wQOq4bOK/MtslhyaEgSZoHnk92FEKvYn7lNpICXclX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teSwNA1nzlijXRNjNVp3ij9MacyVsdIM+YjGTafvE26GKr0SRgoXhkaszPnBMguB50OCo5L7/RNUuyfTjwmjCxMiZer/vZirj18BXGtVjd3S8VSMjre5olrChiRbjY4I6e7Sg7xx2T/qQGby3Ofm8FvruYQH5rWDM6wzXlOcBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lkif+SG5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wnB39ES76DNPpISASYCOBAKMF2MUBv8m38PEbyYRN+0=; b=lkif+SG5mbcCnNZEqgRMOrKSxA
	220hgrFv/zNRNFObsNsagKTn6t8p3HCdkdXxJsCEcXQx/MM+mgTUddfTaYp+JHWThBAAbF9Bqi1S0
	HLdJMD2lBbHX6JCuuzEAlj/AIs11BZ/k/FCJPoETDGG5yGvMwCT1KWaUJ1W3BjPJKIFo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZXtm-007aK5-DX; Mon, 12 Feb 2024 16:07:10 +0100
Date: Mon, 12 Feb 2024 16:07:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v4 2/2] net: phy: dp83826: support TX data voltage tuning
Message-ID: <1412f8bc-6555-4e80-8e44-dda2292ac458@lunn.ch>
References: <20240212074649.806812-1-catalin.popescu@leica-geosystems.com>
 <20240212074649.806812-2-catalin.popescu@leica-geosystems.com>
 <186cf83c-b7a7-4d28-a8b1-85dde032287b@leica-geosystems.com>
 <10ed19e3-01a9-4fcb-819f-686c6d0bf772@lunn.ch>
 <ff630ce9-0da8-4ad7-ab30-11f337dfa1ff@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff630ce9-0da8-4ad7-ab30-11f337dfa1ff@leica-geosystems.com>

> I see. Then, I should not disable WOL in config_init, since this 
> callback is also called on the resume path : 
> mdio_bus_phy_resume->phy_init_hw->config_init.
> However, this contrasts with the rest of the driver and my patch is not 
> anymore about just adding support for tuning of TX voltage levels ...

So wait until your patch is merged and then follow up with another
patch disabling WoL. Patches get merged pretty quickly, so there is
plenty of time before the next merge window.

      Andrew

