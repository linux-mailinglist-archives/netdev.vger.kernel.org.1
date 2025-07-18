Return-Path: <netdev+bounces-208097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ACCB09CEF
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B590C3AF7EB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CA8284B25;
	Fri, 18 Jul 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osvnfDZC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDB28467D;
	Fri, 18 Jul 2025 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824778; cv=none; b=fCnvG8FTpDFaMb+fevxyVm2uR240DqQCA38oQQHoN9mbtINWjn+pC3Zx7hxYrGEwoc1y6roAYRlWd6ptrsT3HWimJTvNEB0Q0JhWJzdyF9Qwm4+dtbs1iKUJFWLTjb59gC2p0TVsTiN+e16Xzbwoase0YBuMZQE58RFeKCHb8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824778; c=relaxed/simple;
	bh=CDo//Phzqd180yGIi7Ea3zBEBQwktw0nlYYNLkKsXys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJYIJAUXfCVephp8AHlLY3OaNsNn8jt8NdJmOBZ7psIAsBl3LRtKPpoePM8scuRhjomBRrFTMNjQ9jFOqyMSrCNadFO7fPWD4iE+9C4U9VaZy4UnZk7U1Khh2R79SzL9a82YWJraHrsb639//qNPRLFj0pyGN2Az7VFS01vWw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osvnfDZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADEAC4CEED;
	Fri, 18 Jul 2025 07:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752824776;
	bh=CDo//Phzqd180yGIi7Ea3zBEBQwktw0nlYYNLkKsXys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osvnfDZCD/Dgxdv0y4cLhIgU4MBSie8xMZOvIOvfrTTueGd8Y87+MTdhXCf17JiEb
	 wH4u/D0BiLXSJFsnM5Wxe8iEZ30Tmf1RHnS8xNbI8sfcQy3mH/MqV9iBAeKQRxvAaM
	 dcoTHCWjeHPWg7WX8dzKhO2f+MPZXacw9fNUmapt9aH3Th/SnelyMhxLGiNlGi69gZ
	 AP7lD3/wGawsJ6YKgjqoVFS8s+0yrcRs911ZjdEXkGPBDZkVQ4hxGlZk6NuSHIQolV
	 9MibFTlCcxAMx2p3NChmGRQC9pzHu5GmNbdV/Fe2BaYZwXZaBwbQt8twteEjDt19JJ
	 zXhWSITk+1HIg==
Date: Fri, 18 Jul 2025 09:46:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	Frank Li <frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer
 property
Message-ID: <20250718-enchanted-cornflower-llama-f7baea@kuoka>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717-masterful-uppish-impala-b1d256@kuoka>
 <PAXPR04MB85109FE64C4FCAD6D46895428851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <af75073c-4ce8-44c1-9e48-b22902373e81@kernel.org>
 <PAXPR04MB8510426F58E3065B22943D8C8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510426F58E3065B22943D8C8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Thu, Jul 17, 2025 at 10:26:28AM +0000, Wei Fang wrote:
> > > timestamper:	provides control node reference and
> > > 			the port channel within the IP core
> > >
> > > The "timestamper" property lives in a phy node and links a time
> > > stamping channel from the controller device to that phy's MII bus.
> > >
> > > But for NETC, we only need the node parameter, and this property is
> > > added to the MAC node.
> > 
> > I think we do not understand each other. I ask if this is the
> > timestamper and you explain about arguments of the phandle. The
> > arguments are not relevant.
> > 
> > What is this purpose/role/function of the timer device?
> 
> The timer device provides PHC with nanosecond resolution, so the
> ptp_netc driver provides interfaces to adjust the PHC, and this PHC
> is used by the ENETC device, so that the ENECT can capture the
> timestamp of the packets.
> 
> > 
> > What is the purpose of this new property in the binding here?
> > 
> 
> This property is to allow the ENETC to find the timer device that is
> physically bound to it. so that ENETC can perform PTP synchronization
> with other network devices.


Looks exactly how existing timestamper property is described.

If this is not timestamper then probably someone with better domain
knowledge should explain it clearly, so I will understand why it is not
timestamper and what is the timestamper property. Then you should think
if you need new generic binding for it, IOW, whether this is typical
problem you solve here or not, and add such binding if needed.

Maybe there is another property describing a time provider in the
kernel or dtschema. Please look for it. This all looks like you are
implementing typical use case in non-typical, but vendor-like, way.

Best regards,
Krzysztof


