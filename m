Return-Path: <netdev+bounces-101187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0188FDACB
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF1E287776
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C94167DA2;
	Wed,  5 Jun 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NAPHVF8w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35097167268;
	Wed,  5 Jun 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631010; cv=none; b=e4oH+JbOBEO1k1Jb46W4ikDYLxmk0EG3eB41/S54A+JAU5es7GkgKkENwhbi0rBepoRmYNnmv4Jz++VpGY3zhC4w9FNefndVAgKjAhST1gUtH0xTe1BVplXd0GGvhwfHyI2dhT/wOYQ3gJ1iAthOr/tMMzBH/jXspfJZmnaJ4Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631010; c=relaxed/simple;
	bh=iK3LAb+wliolnG3rKsU2JLIVpkEh3hwHDV0sMObCrZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQgxASMRsFWd6zsvYw8DXgpHhhGyH//lkGt7vgnVEq5aoqvOlSHXbN2pDxnvGo/LVOsVweRFmgkydi/4pDu+mfKKzwH8t2os0g5HDpw+gu8jhCQ2JElph/oLn14HmPiQr1pSGHMbLutwroPWzmkUJYhM+fwgqpaksxgeQyWVUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NAPHVF8w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u2cpct7+XFJzG7wX3keUvQVf0CUO4FB1mefATz3+4Jw=; b=NAPHVF8wRn7aVlrTHb60+BQh3v
	qp7CjSe3+zo1HV6qf8fWIjxPzGBsRU8KJzte+rHlB4+9yLfPT+Yj72wJXTItgfwJqHb9qUI8wkA6P
	K6WQpQwKHLlOJjJcCVvkVPJqmh6pdoSwhOrFvoOM4rY9nOlRlhR/i1yyEkx27PxdM+go=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF0HX-00GxVp-0T; Thu, 06 Jun 2024 01:43:03 +0200
Date: Thu, 6 Jun 2024 01:43:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: "Parthiban.Veerasooran@microchip.com" <Parthiban.Veerasooran@microchip.com>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
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
Message-ID: <732ce616-9ddc-4564-ab1f-ac7bbc591292@lunn.ch>
References: <BYAPR02MB5958A4D667D13071E023B18F83F52@BYAPR02MB5958.namprd02.prod.outlook.com>
 <6e4c8336-2783-45dd-b907-6b31cf0dae6c@lunn.ch>
 <BY5PR02MB6786619C0A0FCB2BEDC2F90D9DF52@BY5PR02MB6786.namprd02.prod.outlook.com>
 <0581b64a-dd7a-43d7-83f7-657ae93cefe5@lunn.ch>
 <BY5PR02MB6786FC4808B2947CA03977429DF32@BY5PR02MB6786.namprd02.prod.outlook.com>
 <39a62649-813a-426c-a2a6-4991e66de36e@microchip.com>
 <585d7709-bcee-4a0e-9879-612bf798ed45@lunn.ch>
 <BY5PR02MB6786649AEE8D66E4472BB9679DFC2@BY5PR02MB6786.namprd02.prod.outlook.com>
 <cbe5043b-5bb5-4b9f-ac09-5c767ceced36@microchip.com>
 <BYAPR02MB5958BD922DAE2D31F18241B283F92@BYAPR02MB5958.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB5958BD922DAE2D31F18241B283F92@BYAPR02MB5958.namprd02.prod.outlook.com>


On Wed, Jun 05, 2024 at 09:40:12PM +0000, Selvamani Rajagopal wrote:
> Parthiban/Andrew,
> 
> Couple of requests / suggestions after completing the integration of our drivers to the current framework.

Please configure your email client to wrap lines at about 78
characters.


> 
> 1) Can we move memory map selector definitions (OA_TC6_PHY_C45_PCS_MMS2 and other 4 definitions) to the header file
>      include/linux/oa_tc6.h?
>      Also, if possible, could we add the MMS0, MMS1?. Our driver is using them. Of course, we could add it when we submit our driver.

Interesting. So you have vendor registers outside of MMS 10-15?

Or do you need to access standard registers? I would prefer to see
your use cases before deciding this. If you want to access standard
registers, you are probably doing stuff other vendors also want to do,
so we should add a helper in the framework.

2) If it not too late to ask, Is it possible to move interrupt
> handler to vendor's code?

I would say no, not at the moment.

What we can do in the future is allow a driver to register a function
to handle the vendor interrupts, leaving the framework to handle the
standard interrupts, and chain into the specific driver vendor
interrupt handler when a vendor interrupt it indicated.

> This way, it will provide vendors' code an ability to deal with some
> of the interrupts. For example, our code deals with PHYINT bit.

Please explain what you are doing here? What are you doing which the
framework does not cover.

	Andrew

