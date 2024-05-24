Return-Path: <netdev+bounces-98045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB08CEBF4
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 23:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B671C20F0A
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 21:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0257C083;
	Fri, 24 May 2024 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fe29KHR2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0E50263;
	Fri, 24 May 2024 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587700; cv=none; b=bnkh4hd7vO6OBFpUJO6Uvg8NKKFoy1asxawnaAO2DrlweXMNkELwzOWgMtWZdWChCCcsXBcDt53u6D8PFmmqiXbtoZj+aTM1v3QpY9v2C/gER8eqszSV/do89J/FbdIytgSLjOj02p2dKoImMFcVRLWUbKtZe2VgyMVemzVenKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587700; c=relaxed/simple;
	bh=uBiB2OxIx+QLLDkp21EN3GZ/wnImGVQhH+E8hIwA0Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3vgXzkgGQfnfPIBaZf9BdRId90MJj4s6lncbIVawmsWaH385g7O01Y23r5SkOcFkKRvw2EgGoigWomazY0cV7gWTXErB0pBtI7AnJaYW3Pt15Mmf9Dol3241oqITGXuZs7w+xjw8PhY3eSIf6NXcUU4vrgnEXrEGJHbZTgTfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fe29KHR2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VdMjgCwAEWh/I3uCmfOdWHsSn/IkPKaLvDRwty7frmQ=; b=Fe29KHR2AGqq+pANkZ4ABkXHPg
	vOVNjsmL92X6gbMm8PiuwC1ibX8LedLrH1wO+waAmbMghdMoi2JammC62Aue9lfFMaco5AiRFRKDZ
	onujCaw8kRqnmUxay7NoFnWFu+0wf13IqL6dIX7gED3u+znXoXZeZOxw3KjcU4sjfJPw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAcs8-00FypH-S3; Fri, 24 May 2024 23:54:44 +0200
Date: Fri, 24 May 2024 23:54:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Piergiorgio Beruto <Pier.Beruto@onsemi.com>
Cc: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>,
	"Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
	"ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
	"Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"Thorsten.Kummermehr@microchip.com" <Thorsten.Kummermehr@microchip.com>,
	"Nicolas.Ferre@microchip.com" <Nicolas.Ferre@microchip.com>,
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
References: <5f73edc0-1a25-4d03-be21-5b1aa9e933b2@lunn.ch>
 <32160a96-c031-4e5a-bf32-fd5d4dee727e@lunn.ch>
 <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>

> In reality, it is not the PHY having register in MMS12, and not even
> the MAC. These are really "chip-specific" registers, unrelated to
> networking (e.g., GPIOs, HW diagnostics, etc.).

Having a GPIO driver within the MAC driver is O.K. For hardware
diagnostics you should be using devlink, which many MAC drivers
have. So i don't see a need for the PHY driver to access MMS 12.

Anyway, we can do a real review when you post your code.

> Although, I think it is a good idea anyway to allow the MACPHY
> drivers to hook into / extend the MDIO access functions.  If
> anything, because of the hacks you mentioned. But also to allow
> vendor-specific extensions.

But we don't want vendor specific extensions. OS 101, the OS is there
to make all hardware look the same. And in general, it is not often
that vendors actually come up with anything unique. And if they do,
and it is useful, other vendors will copy it. So rather than doing
vendor specific extensions, you should be thinking about how to export
it in a way which is common across multiple vendors.

   Andrew

