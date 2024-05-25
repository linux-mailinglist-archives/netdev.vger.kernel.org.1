Return-Path: <netdev+bounces-98063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4767B8CEF60
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6AFB2100C
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F55914C;
	Sat, 25 May 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cRxskZAt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F31DA5F;
	Sat, 25 May 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648442; cv=none; b=lquj4C+9al7Y1Dlbgxp4cATmW+VUBeszHMuPUz0iAhUDQhsfkBbX+nmqFnOUo59ieofRuulEUfkpXuuaiJHh5E0Tzl2tft1SnnCf8p4khv0G/gEGN7WsB/WeNl8AIK+/QU6YYn2L6K+KGEsVRQdN6gk/F5jMvcy8OOo1rS3aXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648442; c=relaxed/simple;
	bh=6SNUBZnUp2ArjVrrFS12NGWBhTJdFWYGEK88cZiZ2qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pu7HI1RR2V8+XLzJLzmQn3tewg3v3euriub9oCkgNFn2MGuPX3OPjAHOukqDTypGznmNGJASSHZs0hWZQAA8qnuAWCXKL185JtoG8z1dQBkqwO7uEUOZubpnnxtFk3trHMiMVTlsGWo/CId3Iniwdkli4+0pVC64av2bfvVDeyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cRxskZAt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S39VWHs+4+yu6rI13z80G8Whc59XWseFYI8qC5dVnV8=; b=cRxskZAt0VbPLbJn8T2zCktqb6
	2Fkbg2gxwpuW6v35cOL5uyINjv0HqJW6qc2oC+zCSNKPs+ShNuCLp6HUpit4RD47E92hxoU/HjvYE
	jwqk6rc6Uul7JFWGUTKpaYWcnZLfpbtQ9T77aD69teCDcW+cCKAWuMZqvBi+aFcYmuBw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAsfh-00G095-Qn; Sat, 25 May 2024 16:46:57 +0200
Date: Sat, 25 May 2024 16:46:57 +0200
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
Message-ID: <056f54b1-45d4-4ef8-872e-6321e3d98e7d@lunn.ch>
References: <2d9f523b-99b7-485d-a20a-80d071226ac9@microchip.com>
 <6ba7e1c8-5f89-4a0e-931f-3c117ccc7558@lunn.ch>
 <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786209192CB9B8A6EF5261F9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB6786209192CB9B8A6EF5261F9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>

On Fri, May 24, 2024 at 10:08:54PM +0000, Piergiorgio Beruto wrote:
> > Having a GPIO driver within the MAC driver is O.K. For hardware diagnostics you should be using devlink, which many MAC drivers have. So i don't see a need for the PHY driver to access MMS 12.

> But the MAC driver might need to access MMS-es for vendor specific
> stuff. In our case, there is a model specific register we need to
> access during probe.

Which is fine, and currently supported. Look at the Microchip driver,
it access some registers at startup. The framwork just provides the
core of moving packets around, and MDIO access. The rest is up to MAC
driver.

> Fair enough, let's keep it for "hacks" then. Still, I think there
> are features that -initially- are kind of vendor specific, but in
> the long run they turn into standards or de-facto standards.

> I assume we want to help this happening (step-wise), don't we?

Maybe, but maybe not. We have been developing MAC drivers for over 25
years. There are a number of mechanisms for exporting things to user
space. We have to see if your features fit one of them.

> For example, one big feature I think at some point we should
> understand how to deal with, is topology discovery for multi-drop.
> Maybe you've heard about it already, but in short it is a feature
> that allows one PHY to measure the distance (or rather, the
> propagation delay) to another node on the same multi-drop segment.

> Knowing the cable Tpd (~5ns/m), this allows you to get also the physical distance.

We already have something very similar to this. Cable testing results
which make use of Time Domain Reflectromitery. I would look at
re-using the API as much as possible.

> In my view, we should probably create some PHY extensions in the
> kernel to activate the physical layer part, leaving the "protocol"
> to the userland.  May I ask your opinion?

Please look at how cable testing works.

       Andrew

