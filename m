Return-Path: <netdev+bounces-108383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19B923A55
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDF328455E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35FC15530C;
	Tue,  2 Jul 2024 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pRaqfWxz"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605B15217F;
	Tue,  2 Jul 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913283; cv=none; b=NdktH12oid1DwIFuG5l/RjSUiqDqq74ZR+JBwQg0OLiAFbpxwbcoAeojU52rCFT+F1WfUnE1SM0LDwdU3QXOSDGX7blLR2Enp90st4qTtrfHPNiEM8Qp0N/waOltX4QSqbqwl8gRSq/RaKgElnnYZQrBTMxUgXFa+wVJGwvZphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913283; c=relaxed/simple;
	bh=R3ngL8Fv4zUiKpxmIUnkSD2duuv6wqVU5YmU8bbdbN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdBJcBkCQuPr+G9+kbn9rm8FUaQIYbJugr6WXIgPbl7JBSChfkQSxU6FTc81I/+b9nYqLT6YQlDxh69EMfpoI+42VAZ7a63lzEDyJfFT9suw80DpTrweR1xgoEnOu7xTEyBjU5jan2SlWoGhwe4g+djVjETCU10OKRts1qoJ5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pRaqfWxz; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9727A1BF212;
	Tue,  2 Jul 2024 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719913279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/8hFWK9UcvLwmvxQx5S9JAO7f5G9Pn+Hmqfq5j09fY=;
	b=pRaqfWxz7ShvEpbGMyehKBsFqI6DV37eHtko40iUK13IxdeiNqS5pAfFbaKS5gV2zkhTKL
	mY4gP1UmRATDhw4pCrojqv2yBq2pPi5yams5dgbm6Lc9Juj4a0ow/UDWgEajkBi2ZUU/0u
	5mPY4VLbPgX5fW60tnOE9hSUIT9ijeHSr0CMW/AqnZ7S0OKa/LuCrqiVZPFYYk4HmYP2sJ
	KaHMLWUUeod3kHa+04gIsg8t4B7bWLJQEKW3l8lTZUAjDY+0dcxKgRnI5QTd0nl5yxbznG
	ZJjAqs208unbRu0I3tYI5CnEId14CFuMevH9UVqlv+WQ6Pj8zIKRJq24JJ2kyQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation in
 RGMII/1000Base-X mode
Date: Tue, 02 Jul 2024 11:42:04 +0200
Message-ID: <2614671.Lt9SDvczpP@fw-rgant>
In-Reply-To: <ZoPHQms2bDo5zWZm@shell.armlinux.org.uk>
References:
 <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <3818335.kQq0lBPeGt@fw-rgant> <ZoPHQms2bDo5zWZm@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

Hello Russell,

On mardi 2 juillet 2024 11:24:18 UTC+2 Russell King (Oracle) wrote:
> On Tue, Jul 02, 2024 at 10:44:12AM +0200, Romain Gantois wrote:
> > To be clear, "fiber mode" in the DP83869 linguo also includes
> > 1000Base-X which can be used with a direct-attach copper cable. From
> > what I've seen, autonegotiation is not supported in this configuration.
> 
> Why? Direct-attached cables are 1000base-CX, which is defined by 802.3.
> It uses the 1000base-X PCS which is shared with 1000base-SX, 1000base-LX
> etc. If one looks at 37.1.3, Relationship to architectural layering,
> or 36.1.5, Inter-sublayer interfaces, one can see in that diagram that
> the PCS *including* auto-negotiation is included for SX, LX *and* CX.
> 
> Moreover, 39.3 states that TP1 and TP4 will be commin in many
> implementations of LX, SX and CX.
> 
> Moreover, 39.1, 1000base-CX introduction, states that it incorporates
> clause 36 and clause 38. Clause 36.2.2 states that the 1000base-X PCS
> incorporates clause 37 auto-negotiation.
> 
> So, I think AN is supposed to be supported on CX in the same way that
> it's supported for SX and LX.

This seems to be a limitation of this particular PHY. From the DP83869
datasheet:

"7.4.2.1 1000BASE-X
The DP83869HM supports the 1000Base-X Fiber Ethernet protocol as
defined in IEEE 802.3 standard. In 1000M Fiber mode, the PHY will use
two differential channels for communication. In fiber mode, the speed is not
decided through auto-negotiation. Both sides of the link must be
configured to the same operating speed. The PHY can be configured to
operate in 1000BASE-X through the register settings (Section 7.4.8) or
strap settings (Section 7.5.1.2)."

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




