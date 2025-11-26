Return-Path: <netdev+bounces-241911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C088C8A3B9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24FA3B037E
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467D0301707;
	Wed, 26 Nov 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="J2sQjWS7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71812F8BCA;
	Wed, 26 Nov 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764166201; cv=none; b=CkLVZlneqlPtfcCzpyy3mJCHkb1HEA6TxiZcX4UGs4T0tY/5Zo+QWhPyJV+Y16/RZkbGPdn6st75Epe+ICv+yVl0IZ7U26BGgSFxNLg4k6NsSavwWByceP8uFkbZOTUI3fup5vWQZZ8rPMxae2UbqynLbPgFtwhnCb3DEmEY0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764166201; c=relaxed/simple;
	bh=x/aFPfYZvT+SQsFV48zwTXQjKZ+smV8lSACzRMSzxMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZCS1Z+HBrh0cpqkKNQme4ZxpIYJjpIl6dIrvYGWNlQYWhlPE7cDJ1piI5KRqJ4URnDpUykRhO6lUOoO5PwuelAtGQEy5ioRRixLpukU3ULgIPP70w0UMH9xf+S3K7Kfnuu3lQP0xYI/UKT7RMK7ohjaK3CS+v4AGtAUV76zgZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J2sQjWS7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mfg0ApTsZBuNNepuSTDvrLS0QmLBqFFmwPo/8UlDzWM=; b=J2sQjWS7Hax5P1/pbf0MUa1otj
	b85hRFkepQK9OqNVx44xklhecjLP6XGrWx+eDJMoooUVohkSGS4BcWt2VeJvn4PFBgIHGgo2uPLTR
	UODbmiGYHKLOU5oPH4FShi5BIr4kNDj0/HR+qoa+Cxa/toX/kXBhKpCdOh1jj99YemOQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOGDH-00F9qu-Hi; Wed, 26 Nov 2025 15:09:43 +0100
Date: Wed, 26 Nov 2025 15:09:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Marek =?utf-8?B?QmVo4oia4oirbg==?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <1b815a90-f50e-4bf5-8e43-2f4ac11f96bc@lunn.ch>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
 <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
 <20251125214450.qeljlyt3d27zclfr@skbuf>
 <b4597333-e485-426d-975e-3082895e09f6@lunn.ch>
 <20251126072638.wqwbhhab3afxvm7x@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126072638.wqwbhhab3afxvm7x@skbuf>

> All I'm trying to say is that we're missing an OF node to describe
> mv88e6xxx PCS electrical properties, because otherwise, it collides with
> case (1). My note regarding "phys" was just a guess that the "phy-handle"
> may have been mistaken for the port's SerDes PHY. Although there is a
> chance Holger knew what he was doing. In any case, I think we need to
> sort this one way or another, leaving the phy-handle logic a discouraged
> fallback path.
> 
> That being said, I'm not exactly an expert in determining _how_ we could
> best retrofit SerDes/PCS OF nodes on top of the mv88e6xxx bindings.
> It depends on how many SerDes ports there are in these switches
> architecturally, and what is their register access method, so it would
> need to be handled on a case-by-case basis rather than one-size-fits-all.
> PCS node in port node could be a starting point, I guess, but I don't
> know if it would work.

I would more likely have a PCS container node and then list each PCS
within it, using reg as the MDIO bus address. The 6352 has one PCS,
but depending on configuration port 5 or port 6 can make use of it. (I
might have the numbers wrong, but the principle is correct). Some of
the other switches have more PCSs but with a fixed mapping to
ports. And the 6390X has 2x 10G PCS. But you can take this 10G PCS and
split it into 2x 5G. And you can take those 5G PCS and split it into
two to give a PCS which can do 1/2.5G.

Given this flexibility, putting the PCS in the port would probably be
a bad idea.

	Andrew

