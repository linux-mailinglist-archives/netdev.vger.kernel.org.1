Return-Path: <netdev+bounces-108358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6AA9237E2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61BAB24007
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF8214E2F1;
	Tue,  2 Jul 2024 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JAYilRh1"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5C14E2E8;
	Tue,  2 Jul 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909811; cv=none; b=cksStywxcCmz3wtL+K7biHPzcJEYNzm8pRoIWt0wC5gDmPu3Rj/4rCtfzJ3+czGY5DxKU6N+92TqBDeMDsrO9sVGTF52mhk7y9XBR04of5wCQAFf9FvheY+9WNQnODE4jxKZho0G/MbfaYdk2U27get6qBgPfMlN8eD/tHfklNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909811; c=relaxed/simple;
	bh=HXFeBtQ2nJcSAHi9tFupC1wLuKQP+oXjQcCxaB0UapQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpDIJUW+1j+WYmv0cuSvnuPeBoobGRirGUgohZIKyKYX1VU9IVtd7NWdDyv9GzJ+AgUBhLfkk31+DiqeUufKLuFPWPDhIBykEuhtdpY0tdDZnFoitVumLc1vIuF7RdcDmox9TQcQkOai7RXLYWhl23BoEMdNihBDhd4e7vH8CRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JAYilRh1; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA00B240003;
	Tue,  2 Jul 2024 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719909807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESiFCwdIijiYKdTgoUxnWvhTex6WtiiBxTyR4etpb9Q=;
	b=JAYilRh1vX1i2kUkXnuWb3U40CeaCGpuwSK4xKmSiLuF2R7Zk1QhoGWQ/KJbsVBumSIMKH
	FcutiaGlCysRV3/zD8UB6iPNnRHBaXoToEj2FvVNraRojwyMGPbC1BD09mqr4OOhQF6AXf
	lSj5KEcNA1PxZNVK7d+fQ5XiXP0hTBjb0tnE06NyQfFkkYAADrR1AXiuy1pD6Oh3aWDcXp
	aUwj3DSK8sG+9P/WZlP/dncXOqimhqd+KJT/SCzLL8w1OistzhHjAmVgt2hwawpgtsz674
	fXQfJJ2LFhRTH7huSB+36Co3ebvF2oGIwnowBIQzjX7ma+5sTdfULKhSBPo+HA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation in
 RGMII/1000Base-X mode
Date: Tue, 02 Jul 2024 10:44:12 +0200
Message-ID: <3818335.kQq0lBPeGt@fw-rgant>
In-Reply-To: <a244ce05-28a1-47b7-9093-12899f2c447f@lunn.ch>
References:
 <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <20240701-b4-dp83869-sfp-v1-1-a71d6d0ad5f8@bootlin.com>
 <a244ce05-28a1-47b7-9093-12899f2c447f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On lundi 1 juillet 2024 18:40:24 UTC+2 Andrew Lunn wrote:
> On Mon, Jul 01, 2024 at 10:51:03AM +0200, Romain Gantois wrote:
> > Currently, the DP83869 driver only disables autonegotiation in fiber
> > configurations for 100Base-FX mode. However, the DP83869 PHY does not
> > support autonegotiation in any of its fiber modes.
> > 
> > Disable autonegotiation for all fiber modes.
> 
> I'm assuming to does work in copper mode?

I'm unable to test any of the copper modes for the DP83869HM but
according to the datasheet, autonegotiation should work in those.

To be clear, "fiber mode" in the DP83869 linguo also includes
1000Base-X which can be used with a direct-attach copper cable. From
what I've seen, autonegotiation is not supported in this configuration.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




