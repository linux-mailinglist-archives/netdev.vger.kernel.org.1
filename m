Return-Path: <netdev+bounces-207787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C40B0890E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2465D1881F36
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9CE272E7A;
	Thu, 17 Jul 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjXc1KzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F52C18A;
	Thu, 17 Jul 2025 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743568; cv=none; b=Ofq2pZ2cDDjD8wecKbpmXMQVtqRYdu8mU/heBxBAx/Nq6sms8BILz/jRmVOF7xTau8PGBhAxt6Z2KrzVB0aHI0v/F0OqvF9Mk5uGZWaaYsUAiztRjSUH1bV/cS3Eo0q+UmKj2AxKAFBZSdqqhiq85Vp2GZXxJ8lmNyZdiX96ohI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743568; c=relaxed/simple;
	bh=FfwpwvFvStXJyzoqvzeHLBsOgdYmdv3YtoCDXdc0Ltk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4eb72xs9X3OOHk3KYRjBJ/bWOBhWscXeHcXNb7/2lxknhwURF25th++5pqbkdq86sJ8l2UloM29ltImKVwogX+lEoVKMJMAbVUNiUNwFnZGA5O6icwVd6ZDAutgNJa8NK4MPn34oHeigTl2cnkmaqfSBie/9vv0hPtmBmzvn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjXc1KzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A0BC4CEE3;
	Thu, 17 Jul 2025 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752743568;
	bh=FfwpwvFvStXJyzoqvzeHLBsOgdYmdv3YtoCDXdc0Ltk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjXc1KzSobL8KtiQgBk1n9ZYmUhFqG3aHt3Bd3wAmLGgjGl1wCOWG3LeIAdwiN7lF
	 wRBb3ihKXuBpcRxylaVohY1jPgYQG0kxx0Wf9W9OLnlsnLBcFtdTD/dwZI13X/0mAJ
	 OUTvZagO24sLI6dbEPRkN0SQrJEawITbP4GKeHp+e+67sivX6er5X7FYbzURtkA7GG
	 B5hyNU1japqRDiQOCBMWSV6DmcauoIRnDg1z9T9O/0vYyrgLFXS79HZ/ZkKo2UH2Ba
	 mN5q4aZPFWTjQjFi7LPkscVVsx7eINZi+jMpQ7CIUZF599uv6F56pSFrWgkNyQBfYg
	 TK0hYH7Ytdnrg==
Date: Thu, 17 Jul 2025 11:12:45 +0200
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
Message-ID: <20250717-masterful-uppish-impala-b1d256@kuoka>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-3-wei.fang@nxp.com>
 <20250717-sceptical-quoll-of-protection-9c2104@kuoka>
 <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510EB38C3DCF5713C6AC5C48851A@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Thu, Jul 17, 2025 at 08:32:38AM +0000, Wei Fang wrote:
> > On Wed, Jul 16, 2025 at 03:30:59PM +0800, Wei Fang wrote:
> > > NETC is a multi-function PCIe Root Complex Integrated Endpoint (RCiEP)
> > > that contains multiple PCIe functions, such as ENETC and Timer. Timer
> > > provides PTP time synchronization functionality and ENETC provides the
> > > NIC functionality.
> > >
> > > For some platforms, such as i.MX95, it has only one timer instance, so
> > > the binding relationship between Timer and ENETC is fixed. But for some
> > > platforms, such as i.MX943, it has 3 Timer instances, by setting the
> > > EaTBCR registers of the IERB module, we can specify any Timer instance
> > > to be bound to the ENETC instance.
> > >
> > > Therefore, add "nxp,netc-timer" property to bind ENETC instance to a
> > > specified Timer instance so that ENETC can support PTP synchronization
> > > through Timer.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > >
> > > ---
> > > v2 changes:
> > > new patch
> > > ---
> > >  .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > index ca70f0050171..ae05f2982653 100644
> > > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > @@ -44,6 +44,13 @@ properties:
> > >      unevaluatedProperties: false
> > >      description: Optional child node for ENETC instance, otherwise use
> > NETC EMDIO.
> > >
> > > +  nxp,netc-timer:
> > 
> > Heh, you got comments to use existing properties for PTP devices and
> > consumers. I also said to you to use cell arguments how existing
> > bindings use it.
> > 
> > You did not respond that you are not going to use existing properties.
> > 
> > So why existing timestamper is not correct? Is this not a timestamper?
> > If it is, why do we need to repeat the same discussion...
> > 
> 
> I do not think it is timestamper. Each ENETC has the ability to record the
> sending/receiving timestamp of the packets on the Tx/Rx BD, but the
> timestamp comes from the Timer. For platforms have multiple Timer

Isn't this exactly what timestamper is supposed to do?

Best regards,
Krzysztof


