Return-Path: <netdev+bounces-241654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BFCC8734A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACE404E2A64
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D642FB978;
	Tue, 25 Nov 2025 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q/mIFDJA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3822FB093;
	Tue, 25 Nov 2025 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105561; cv=none; b=IsllopxILaQubTo+7QnYcbYkaxig+fJfgoB2UQPiFxfUX49aUKRJxhs5aVLnB6nK8xSv5M8anl1Me7OX0n/BqMvnRKliiGFn8WYCCoWSE87Nu0tULyaOtu3xr0MIB92hKpLC03H8V1qVJrdqtrR308ItiXpKvyDbMSBYbH0kDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105561; c=relaxed/simple;
	bh=yKeUegFI0QE/9BsO7g5nTK0hXwYhBIFU9sEfp8HoFXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcPgPre1x0xAnfgKjRpcA796ucaRalxcgvNtyp4t9i96Xgc963VdaOFPo44V7h0OibrnmLa8DZcReR8cYgzgiXQjw1i5KBkXK/REAuvWoChMv9e+xBNQEloEoLdnVjouX9edcITjyyjhymi56EMNIwgHn4vDML0U/mKF6EtUlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q/mIFDJA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L+cBTRRQGE2v1BWrrSCYxS5xPces5KE3phitGCPEZc4=; b=Q/mIFDJAMg6Y7+Z5dFQdj64tcG
	ltB53b2q6U6LjaY/7cpwYah+1fOAlZ4o9o14KIlE8S00xYsIrfX3ZwiS2auSkYR+wlVc1UGyiJDTf
	UfaR9FTk/tzT12sqd7srC1aHe9B8pekZnE4oakLmwY3pNRKws7GOyWrqevIDLVwJj/7E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vO0RL-00F3Ks-GA; Tue, 25 Nov 2025 22:19:11 +0100
Date: Tue, 25 Nov 2025 22:19:11 +0100
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
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH net-next 1/9] dt-bindings: phy: rename
 transmit-amplitude.yaml to phy-common-props.yaml
Message-ID: <0faccdb7-0934-4543-9b7f-a655a632fa86@lunn.ch>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
 <20251122193341.332324-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122193341.332324-2-vladimir.oltean@nxp.com>

On Sat, Nov 22, 2025 at 09:33:33PM +0200, Vladimir Oltean wrote:
> I would like to add more properties similar to tx-p2p-microvolt, and I
> don't think it makes sense to create one schema for each such property
> (transmit-amplitude.yaml, lane-polarity.yaml, transmit-equalization.yaml
> etc).
> 
> Instead, let's rename to phy-common-props.yaml, which makes it a more
> adequate host schema for all the above properties.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../{transmit-amplitude.yaml => phy-common-props.yaml}    | 8 ++++----

So there is nothing currently referencing this file?

	Andrew

