Return-Path: <netdev+bounces-221801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C1EB51E5F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092A53BA3C0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB028C006;
	Wed, 10 Sep 2025 16:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D9289E13
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523334; cv=none; b=en5LrGpcmnPv0xEVgCKPdabDZ1BaPODd2jwH7+4fVzwf3GXUnHZ4DDxJpwHNyV7Z4ulIyJtBAtI2+28LeOKUMQBKWRvPHMfXCH8rkqSh7KuAJ2IKDfmDikUdYp2Vzp//JhUtst4U6OGjJuzcv//U10ILr2vnOdBRG+rc4sylxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523334; c=relaxed/simple;
	bh=+MiE311kfFW//2eHcz0hVWh71Y6hSvVa+hpJe44h5QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDIyKJKHIQKd9WgOBJsLPH5fbeeRW+Sj6e954zus0fNdOelktroySM3MBbJob24OCnuaVseopPG8sNsfdxvAkhuU8I7hmtH5l7OcBXr67d/Qy4XIYnSsDpvLDEtoBdv94fdPJaSMezeyn0tN9COLI6bGujw8Rgu87IxWDqR2c2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwO6K-00081C-BQ; Wed, 10 Sep 2025 18:55:20 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwO6J-000ceW-0G;
	Wed, 10 Sep 2025 18:55:19 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwO6I-00GJtR-2w;
	Wed, 10 Sep 2025 18:55:18 +0200
Date: Wed, 10 Sep 2025 18:55:18 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Jonas Rebmann <jre@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250910165518.bzpz5to5dtwe2z6x@pengutronix.de>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
 <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
 <20250910144328.do6t5ilfeclm2xa4@skbuf>
 <693c3d1e-a65b-47ea-9b21-ce1d4a772066@sirena.org.uk>
 <20250910153454.ibh6w7ntxraqvftb@skbuf>
 <20250910155359.tqole7726sapvgzr@pengutronix.de>
 <20250910164231.cnrexx4ds3cdg6lu@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910164231.cnrexx4ds3cdg6lu@skbuf>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 25-09-10, Vladimir Oltean wrote:
> On Wed, Sep 10, 2025 at 05:53:59PM +0200, Marco Felsch wrote:
> > IMHO silently removing the support will break designs for sure and
> > should never be done. As said, imagine that the firmware will handle the
> > supplies and the driver only needs to release the reset. If you silently
> > remove the support, the device will be kept in reset-state. In field
> > firmware updates are seldom, so you break your device by updating to a
> > new kernel.
> > 
> > One could argue that the driver supported it but there was no dt-binding
> > yet, so it was a hidden/unstable feature but I don't know the policy.
> 
> Ok, I didn't think about, or meet, the case where Linux is required by
> previous boot stages to deassert the reset. It is the first time you are
> explicitly saying this, though.
> 
> So we can keep and document the 'reset-gpios' support, but we need to
> explicitly point out that if present, it does not supplant the need to
> ensure the proper POR sequence as per AH1704.

We could do that but I think that no one should assume that the driver
ensures this due to the missing power-supply and clock support. But this
goes to the DT maintainers. IMHO we shouldn't mention any document
within the binding, maybe within the commit message, since those
documents may get removed.

Regards,
  Marco

