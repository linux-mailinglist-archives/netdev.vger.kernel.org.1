Return-Path: <netdev+bounces-99600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36668D56F7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949501F2413B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB223CB;
	Fri, 31 May 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yBW02iha"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342054C84;
	Fri, 31 May 2024 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115611; cv=none; b=MXFZgSVszkQHl65Fj8i2xb9PshQI01riA27vpWlEqBy2EHkT89rfukR9DQqt+ijjq8UJYMJaznSPnu2KyL9ivRKyivlkDEYHGX21INJthTuwj1WzUwD2kuIxGAXZygknX7qblIlXBmNn5+HlQpUZAb7gGSJ7ONs1llhTk7jczdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115611; c=relaxed/simple;
	bh=gYWdRGn3AeOpnLIlUK3mnGSwl4mb6ATRHGgkB7ftO0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTquyJv1matC8d/lTViaZmHWEu2gcs4xpW7A+nKmH1Pb3G5DmadwU0zMxVMxVf7szivkqiynCxiqmF1FkBqonevHpEUMVV0ior0XU2AOISSSkoPiEon9n7O+pvHYyJtuNXF2jraz7Nkj/CUbAR4iMLWKftoJc2fcQFpFMXFODGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yBW02iha; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PB5NFoVidfRs5Bpnv20WWZ31imy2ZshY8HvuANuXbWk=; b=yBW02ihahmE4c+JC15qTAO1cYi
	KC8N3DykGGU4IREbJ+gEnIm6hvU0/WoI3dB91Hxr1gYtlt+hkZOIk1ZxPpuokVm2WzIZWxT+kJMMb
	2Cm6GMgEIlpt6sYxdEKtzx9nkVvIuWjTFmdqDC/qaVmH265D1SiKppgRkhi0LTPDW9pc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sCqCm-00GQ9n-Be; Fri, 31 May 2024 02:33:12 +0200
Date: Fri, 31 May 2024 02:33:12 +0200
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
	"benjamin.bigler@bernformulastudent.ch" <benjamin.bigler@bernformulastudent.ch>,
	Viliam Vozar <Viliam.Vozar@onsemi.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <1ec62bbd-dff7-4132-8d32-e186797db806@lunn.ch>
References: <8b9f8c10-e6bf-47df-ad83-eaf2590d8625@microchip.com>
 <44cd0dc2-4b37-4e2f-be47-85f4c0e9f69c@lunn.ch>
 <b941aefd-dbc5-48ea-b9f4-30611354384d@microchip.com>
 <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <70cf84d1-99ad-4c30-9811-f796f21e6391@lunn.ch>
 <BY5PR02MB678680FB7F10F1E6B9A859379DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB678680FB7F10F1E6B9A859379DF32@BY5PR02MB6786.namprd02.prod.outlook.com>

> On that we agree. Maybe I was just misunderstanding the earlier
> conversation where I thought you would not allow specific drivers to
> access MMS other than 0,1,4 and the ones that map to MMDs.

I would be disappointed to see a driver access registers which is not
in its address space. The LED driver can be in the MAC driver, or the
PHY driver, depending on where its registers are. The PTP driver can
be in the MAC driver, or the PHY driver, depending on where its
registers are. Hopefully you don't have anything which is split over
both addresses spaces.

     Andrew


