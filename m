Return-Path: <netdev+bounces-43771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2987D4B6F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FA21C20B3C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0773F21351;
	Tue, 24 Oct 2023 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QWj0mk9S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A314017;
	Tue, 24 Oct 2023 09:02:56 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F6CAC;
	Tue, 24 Oct 2023 02:02:54 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6811360014;
	Tue, 24 Oct 2023 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698138173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moXvoXVL8BeanjUNuJ9YxDMbdmP0XoJ1UTP44gG4/CA=;
	b=QWj0mk9S2F0YTHYn+XipNAFVia5mjtFwMXs6WlSlTZQRuWmnD7IMIKCVumCfRzOcbLKFP8
	Ev+dwdtdCU5Vou1ysduGfB8wsDve7DAAPUVNM0T4ISKZ0zFWkW0vtD+ggctbRd3e0MBlDV
	Ifyq3r6355gUsmwddN0WQmXghNVOgTWOkxO1MNc70F5cMkQzX8aO6bIpO3bP9R/PgtRDWX
	em6Q72W8DqhJGTzKiVG+rL2htx6/a93cOfNOscntGTQi3Ux0xN1v4xrGQcaBULHbwKg0ie
	N68o2iFkPIcNaZfVQPVlDwT6NcR4XeTsS3VueGSW9WprdiXJSQfoAh1rCEcJOw==
Date: Tue, 24 Oct 2023 11:03:05 +0200 (CEST)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
cc: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net, 
    Rob Herring <robh+dt@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
    Vladimir Oltean <vladimir.oltean@nxp.com>, 
    Luka Perkov <luka.perkov@sartura.hr>, 
    Robert Marko <robert.marko@sartura.hr>, Andy Gross <agross@kernel.org>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@somainline.org>, 
    Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/5] net: ipqess: add a PSGMII calibration
 procedure to the IPQESS driver
In-Reply-To: <df71bbe5-fec0-45cc-adb4-acfbcc356ba3@lunn.ch>
Message-ID: <9d447cb5-c8f9-06d2-0909-2870d57f0f7a@bootlin.com>
References: <20231023155013.512999-1-romain.gantois@bootlin.com> <20231023155013.512999-5-romain.gantois@bootlin.com> <df71bbe5-fec0-45cc-adb4-acfbcc356ba3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Andrew,

On Mon, 23 Oct 2023, Andrew Lunn wrote:

> On Mon, Oct 23, 2023 at 05:50:11PM +0200, Romain Gantois wrote:
> > The IPQ4019 Ethernet Switch Subsystem uses a PSGMII link to communicate
> > with a QCA8075 5-port PHY. This 1G link requires calibration before it can
> > be used reliably.
> > 
> > This commit introduces a calibration procedure followed by thourough
> > testing of the link between each switch port and its corresponding PHY
> > port.
> 
> Could you explain the architecture in a bit more detail.
> 
> When i see MAC code messing with a PHY, i normally say move it into
> the PHY driver. But its not clear to me if you are talking about the
> real PHYs here, or this is the switch end of the link, and it has some
> sort of a PHY to talk to the quint PHY?

Yes, I'll add more detailed comments to the code in the v2. The calibration 
procedure itself targets the PSGMII device, which is internal to the SoC and can 
be logically accessed as a PHY device on the MDIO bus. This component is a 
little opaque and has some nonstandard MII register definitions.

The "testing" phase that follows the calibration accesses both the internal 
QCA8K switch ports and the external QCA8075 PHY. For example, it puts both the 
switch ports and the PHY ports in loopback before starting packet generation on 
the external PHYs. This is done to verify that the PSGMII link works correctly 
after being calibrated.

So this code interacts with both internal ESS devices and external PHYs, but 
mostly the former, which is why I kept everything in the MAC/switch driver.

Thanks,

Romain

